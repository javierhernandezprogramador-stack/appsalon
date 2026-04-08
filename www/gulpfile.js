import path from 'path'
import fs from 'fs'
import { glob } from 'glob'
import sharp from 'sharp'

import { src, dest, watch, series } from 'gulp'
import * as dartSass from 'sass'
import gulpSass from 'gulp-sass'

import concat from 'gulp-concat'
import terser from 'gulp-terser'
import rename from 'gulp-rename'

const sass = gulpSass(dartSass)

const paths = {
    scss: 'src/scss/**/*.scss',
    js: 'src/js/**/*.js'
}

export function css() {
    return src(paths.scss, { sourcemaps: true })
        .pipe(sass({ outputStyle: 'compressed' }).on('error', sass.logError))
        .pipe(dest('./public/build/css', { sourcemaps: '.' }))
}

export function js() {
    console.log("procesando js");
    return src(paths.js)
        //.pipe(concat('bundle.js'))
        .pipe(terser().on('error', function (err) {
            console.error(err.toString());
            this.emit('end');
        }))
        .pipe(rename({ suffix: '.min' }))
        .pipe(dest('./public/build/js'))
}

export async function imagenes(done) {
    console.log("procesando imagenes");
    const srcDir = path.resolve('src/img')
    const buildDir = path.resolve('./public/build/img')
    const images = await glob('src/img/**/*.{png,jpg,jpeg,svg}')

    if (images.length === 0) {
        console.log("NO se encuentran imagenes");
        done();
        return;
    }

    const tareas = images.map(async (file) => {
        const relativePath = path.relative(srcDir, path.dirname(file))
        const outputSubDir = path.join(buildDir, relativePath)
        return procesarImagenes(file, outputSubDir)
    })

    await Promise.all(tareas)
    done()
}

async function procesarImagenes(file, outputSubDir) {
    if (!fs.existsSync(outputSubDir)) {
        fs.mkdirSync(outputSubDir, { recursive: true })
    }

    const baseName = path.basename(file, path.extname(file))
    const extName = path.extname(file).toLowerCase()

    if (extName === '.svg') {
        const outputFile = path.join(outputSubDir, `${baseName}${extName}`)
        fs.copyFileSync(file, outputFile)
    } else {
        const outputFile = path.join(outputSubDir, `${baseName}${extName}`)
        const outputFileWebp = path.join(outputSubDir, `${baseName}.webp`)
        const outputFileAvif = path.join(outputSubDir, `${baseName}.avif`)
        const options = { quality: 80 }

        await Promise.all([
            sharp(file).toFile(outputFile),
            sharp(file).webp(options).toFile(outputFileWebp),
            sharp(file).avif(options).toFile(outputFileAvif)
        ])
    }
}

export function dev() {
    watch(paths.scss, { usePolling: true }, css)
    watch(paths.js, { usePolling: true }, js)
    watch('src/img/**/*.{png,jpg,jpeg,svg}', { usePolling: true }, imagenes)
}

export default series(js, css, imagenes, dev)
