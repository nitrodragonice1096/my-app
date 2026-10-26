import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/css/home.css',
                'resources/css/FilterBar.css',
                'resources/css/fragrance.css',
                'resources/css/seasons.css',
                'resources/css/fall.css',
                'resources/css/falldetails.css',
                'resources/css/genderfalldesign.css',
                'resources/css/genderspringdesign.css',
                'resources/css/gendersummerdesign.css',
                'resources/css/genderwinterdesign.css',
                'resources/css/spring.css',
                'resources/css/springdetails.css',
                'resources/css/summer.css',
                'resources/css/summerdetails.css',
                'resources/css/winter.css',
                'resources/css/winterdetails.css',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
        tailwindcss(),
    ],
    server: {
        watch: {
            ignored: ['**/storage/framework/views/**'],
        },
    },
});
