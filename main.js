const _0x464a76 = _0x2001;
(function(_0x9bcdeb, _0x53b012) {
    const _0x514ed6 = _0x2001,
        _0x2e1734 = _0x9bcdeb();
    while (!![]) {
        try {
            const _0x1c2ea0 = -parseInt(_0x514ed6(0x16d)) / 0x1 * (-parseInt(_0x514ed6(0x13d)) / 0x2) + parseInt(_0x514ed6(0x123)) / 0x3 * (-parseInt(_0x514ed6(0x120)) / 0x4) + parseInt(_0x514ed6(0x12b)) / 0x5 + parseInt(_0x514ed6(0x144)) / 0x6 * (-parseInt(_0x514ed6(0x175)) / 0x7) + parseInt(_0x514ed6(0x139)) / 0x8 * (-parseInt(_0x514ed6(0x16b)) / 0x9) + parseInt(_0x514ed6(0x17c)) / 0xa + parseInt(_0x514ed6(0x167)) / 0xb;
            if (_0x1c2ea0 === _0x53b012)
                break;
            else
                _0x2e1734['push'](_0x2e1734['shift']());
        } catch (_0x334a77) {
            _0x2e1734['push'](_0x2e1734['shift']());
        }
    }
}(_0x3655, 0x69786));
const configuration = {
    'SiteName': _0x464a76(0x143),
    'Use2DTextOver3D': ![],
    'SiteNameSize': 0.7,
    'NumberOfVerticalLines': 0x19,
    'NumberOfDots': 0x1388,
    'colors': {
        'CanvasBackgroundColor': '#141414',
        'LettersColor': '#FF0000',
        'LinesColors': [_0x464a76(0x142), _0x464a76(0x13b), _0x464a76(0x130)],
        'LowerLinesColors': ['#3d3d3d'],
        'DotsColor': _0x464a76(0x130)
    }
};
import * as _0x255c8b from './ext/three.module.min.js';
import _0xbc2b79 from './ext/tween.js';
import _0xb5dabc from './ui.js';
const ui = new _0xb5dabc(uiCallback),
    windowHeightInRadians = 0x19;
let camera, scene, renderer, sceneMovedAmmount = 0x0,
    timeoutActive = ![];
const mainGeomertries = [];
let mainLettersMesh, touchStartPosition;
window[_0x464a76(0x136)]('load', () => {
    const _0x5a94e3 = _0x464a76,
        _0x5487fd = document[_0x5a94e3(0x129)](_0x5a94e3(0x180));
    _0x5487fd[_0x5a94e3(0x121)][_0x5a94e3(0x164)](_0x5a94e3(0x12d)),
        setTimeout(() => {
            init(),
                animate();
        }, 0xbb8);
});

function _0x2001(_0x4a9a2e, _0x3db759) {
    const _0x365530 = _0x3655();
    return _0x2001 = function(_0x20017f, _0x3302b3) {
            _0x20017f = _0x20017f - 0x11e;
            let _0x4af489 = _0x365530[_0x20017f];
            return _0x4af489;
        },
        _0x2001(_0x4a9a2e, _0x3db759);
}

function init() {
    const _0x1e3c5e = _0x464a76;
    camera = new _0x255c8b[(_0x1e3c5e(0x17d))](0x37, window[_0x1e3c5e(0x15b)] / window['innerHeight'], 0x2, 0x4e20),
        camera[_0x1e3c5e(0x174)]['z'] = 0x14,
        scene = new _0x255c8b[(_0x1e3c5e(0x17f))](),
        scene['background'] = new _0x255c8b[(_0x1e3c5e(0x125))](configuration[_0x1e3c5e(0x13e)][_0x1e3c5e(0x154)]);
    const _0x143f07 = 0xa,
        _0x2df21b = 0x96;
    scene['fog'] = new _0x255c8b['Fog'](configuration['colors'][_0x1e3c5e(0x154)], _0x143f07, _0x2df21b);
    !configuration['Use2DTextOver3D'] ? loadMainLetters() : loadMain2DLetters();
    for (let _0x14bf3b = 0x0; _0x14bf3b < configuration[_0x1e3c5e(0x156)]; _0x14bf3b++) {
        generateRandomObject(0x1, [
                [0.2, 0x2, 0x4, 0x5],
                [0.1, 0.2]
            ], configuration[_0x1e3c5e(0x13e)][_0x1e3c5e(0x14b)]),
            generateRandomObject(-windowHeightInRadians * _0x14bf3b / 0x3, [
                [0x2, 0x4],
                [0.05]
            ], configuration[_0x1e3c5e(0x13e)][_0x1e3c5e(0x133)]);
    }
    renderer = new _0x255c8b['WebGLRenderer'](),
        renderer[_0x1e3c5e(0x140)](window[_0x1e3c5e(0x13a)]),
        renderer[_0x1e3c5e(0x12f)](window[_0x1e3c5e(0x15b)], window[_0x1e3c5e(0x13f)]),
        document[_0x1e3c5e(0x172)][_0x1e3c5e(0x157)](renderer[_0x1e3c5e(0x153)]),
        window[_0x1e3c5e(0x136)](_0x1e3c5e(0x16c), windowResize, ![]),
        window[_0x1e3c5e(0x136)](_0x1e3c5e(0x13c), windowWheelOrTouch, ![]),
        window[_0x1e3c5e(0x136)](_0x1e3c5e(0x141), _0x3aef96 => {
            const _0x2ce77c = _0x1e3c5e;
            touchStartPosition = _0x3aef96[_0x2ce77c(0x12e)][0x0][_0x2ce77c(0x177)];
        }, ![]),
        window['addEventListener'](_0x1e3c5e(0x17a), windowWheelOrTouch, ![]);
    if (!isMobile())
        window[_0x1e3c5e(0x136)]('mousemove', mouseMove, ![]);
}

function animate(_0x453e67) {
    const _0x88fa7f = _0x464a76;
    requestAnimationFrame(animate),
        _0xbc2b79[_0x88fa7f(0x17b)](),
        render(_0x453e67);
}

function render(_0x2dcc03) {
    const _0x51d4bb = _0x464a76;
    _0x2dcc03 = _0x2dcc03 / 0x3e8;
    if (mainLettersMesh)
        mainLettersMesh[_0x51d4bb(0x169)][_0x51d4bb(0x124)][_0x51d4bb(0x14d)]['value'] = _0x2dcc03;
    mainGeomertries['forEach']((_0x269d31, _0x96e1f7) => {
            const _0x2afee7 = _0x51d4bb;
            _0x269d31[_0x2afee7(0x16f)]['x'] = Math[_0x2afee7(0x179)](_0x2dcc03 / 0x2 + _0x96e1f7 * 0x3) * 0.5 + 0.5;
        }),
        renderer['render'](scene, camera);
}

function _0x3655() {
    const _0xa8b377 = ['Quartic', 'Easing', '12yEgMPy', 'classList', 'vec3', '721023EIZbBq', 'uniforms', 'Color', 'Points', 'resources/images/icons/pointImg.png', 'applyMatrix4', 'querySelector', 'configuration__letters--hidden', '1045385FsgPMg', '\x0a\x20\x20varying\x20vec2\x20vUv;\x0a\x20\x20uniform\x20float\x20time;\x0a\x20\x20\x0a\x20\x20vec3\x20mod289(vec3\x20x)\x20{\x0a\x20\x20\x20\x20return\x20x\x20-\x20floor(x\x20*\x20(1.0\x20/\x20289.0))\x20*\x20289.0;\x0a\x20\x20}\x0a\x20\x20\x0a\x20\x20vec4\x20mod289(vec4\x20x)\x20{\x0a\x20\x20\x20\x20return\x20x\x20-\x20floor(x\x20*\x20(1.0\x20/\x20289.0))\x20*\x20289.0;\x0a\x20\x20}\x0a\x20\x20\x0a\x20\x20vec4\x20permute(vec4\x20x)\x20{\x0a\x20\x20\x20\x20\x20\x20\x20return\x20mod289(((x*34.0)+1.0)*x);\x0a\x20\x20}\x0a\x20\x20\x0a\x20\x20vec4\x20taylorInvSqrt(vec4\x20r)\x0a\x20\x20{\x0a\x20\x20\x20\x20return\x201.79284291400159\x20-\x200.85373472095314\x20*\x20r;\x0a\x20\x20}\x0a\x20\x20\x0a\x20\x20float\x20snoise(vec3\x20v)\x20{\x0a\x20\x20\x20\x20const\x20vec2\x20\x20C\x20=\x20vec2(1.0/6.0,\x201.0/3.0)\x20;\x0a\x20\x20\x20\x20const\x20vec4\x20\x20D\x20=\x20vec4(0.0,\x200.5,\x201.0,\x202.0);\x0a\x20\x20\x20\x20\x0a\x20\x20\x20\x20//\x20First\x20corner\x0a\x20\x20\x20\x20vec3\x20i\x20\x20=\x20floor(v\x20+\x20dot(v,\x20C.yyy)\x20);\x0a\x20\x20\x20\x20vec3\x20x0\x20=\x20\x20\x20v\x20-\x20i\x20+\x20dot(i,\x20C.xxx)\x20;\x0a\x20\x20\x20\x20\x0a\x20\x20\x20\x20//\x20Other\x20corners\x0a\x20\x20\x20\x20vec3\x20g\x20=\x20step(x0.yzx,\x20x0.xyz);\x0a\x20\x20\x20\x20vec3\x20l\x20=\x201.0\x20-\x20g;\x0a\x20\x20\x20\x20vec3\x20i1\x20=\x20min(\x20g.xyz,\x20l.zxy\x20);\x0a\x20\x20\x20\x20vec3\x20i2\x20=\x20max(\x20g.xyz,\x20l.zxy\x20);\x0a\x20\x20\x0a\x20\x20\x20\x20//\x20\x20\x20x0\x20=\x20x0\x20-\x200.0\x20+\x200.0\x20*\x20C.xxx;\x0a\x20\x20\x20\x20//\x20\x20\x20x1\x20=\x20x0\x20-\x20i1\x20\x20+\x201.0\x20*\x20C.xxx;\x0a\x20\x20\x20\x20//\x20\x20\x20x2\x20=\x20x0\x20-\x20i2\x20\x20+\x202.0\x20*\x20C.xxx;\x0a\x20\x20\x20\x20//\x20\x20\x20x3\x20=\x20x0\x20-\x201.0\x20+\x203.0\x20*\x20C.xxx;\x0a\x20\x20\x20\x20vec3\x20x1\x20=\x20x0\x20-\x20i1\x20+\x20C.xxx;\x0a\x20\x20\x20\x20vec3\x20x2\x20=\x20x0\x20-\x20i2\x20+\x20C.yyy;\x20//\x202.0*C.x\x20=\x201/3\x20=\x20C.y\x0a\x20\x20\x20\x20vec3\x20x3\x20=\x20x0\x20-\x20D.yyy;\x20\x20\x20\x20\x20\x20//\x20-1.0+3.0*C.x\x20=\x20-0.5\x20=\x20-D.y\x0a\x20\x20\x20\x20\x0a\x20\x20\x20\x20//\x20Permutations\x0a\x20\x20\x20\x20i\x20=\x20mod289(i);\x0a\x20\x20\x20\x20vec4\x20p\x20=\x20permute(\x20permute(\x20permute(\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20i.z\x20+\x20vec4(0.0,\x20i1.z,\x20i2.z,\x201.0\x20))\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20+\x20i.y\x20+\x20vec4(0.0,\x20i1.y,\x20i2.y,\x201.0\x20))\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20+\x20i.x\x20+\x20vec4(0.0,\x20i1.x,\x20i2.x,\x201.0\x20));\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x0a\x20\x20\x20\x20//\x20Gradients:\x207x7\x20points\x20over\x20a\x20square,\x20mapped\x20onto\x20an\x20octahedron.\x0a\x20\x20\x20\x20//\x20The\x20ring\x20size\x2017*17\x20=\x20289\x20is\x20close\x20to\x20a\x20multiple\x20of\x2049\x20(49*6\x20=\x20294)\x0a\x20\x20\x20\x20float\x20n_\x20=\x200.142857142857;\x20//\x201.0/7.0\x0a\x20\x20\x20\x20vec3\x20\x20ns\x20=\x20n_\x20*\x20D.wyz\x20-\x20D.xzx;\x0a\x20\x20\x0a\x20\x20\x20\x20vec4\x20j\x20=\x20p\x20-\x2049.0\x20*\x20floor(p\x20*\x20ns.z\x20*\x20ns.z);\x20\x20//\x20\x20mod(p,7*7)\x0a\x20\x20\x0a\x20\x20\x20\x20vec4\x20x_\x20=\x20floor(j\x20*\x20ns.z);\x0a\x20\x20\x20\x20vec4\x20y_\x20=\x20floor(j\x20-\x207.0\x20*\x20x_\x20);\x20\x20\x20\x20//\x20mod(j,N)\x0a\x20\x20\x0a\x20\x20\x20\x20vec4\x20x\x20=\x20x_\x20*ns.x\x20+\x20ns.yyyy;\x0a\x20\x20\x20\x20vec4\x20y\x20=\x20y_\x20*ns.x\x20+\x20ns.yyyy;\x0a\x20\x20\x20\x20vec4\x20h\x20=\x201.0\x20-\x20abs(x)\x20-\x20abs(y);\x0a\x20\x20\x0a\x20\x20\x20\x20vec4\x20b0\x20=\x20vec4(\x20x.xy,\x20y.xy\x20);\x0a\x20\x20\x20\x20vec4\x20b1\x20=\x20vec4(\x20x.zw,\x20y.zw\x20);\x0a\x20\x20\x0a\x20\x20\x20\x20//vec4\x20s0\x20=\x20vec4(lessThan(b0,0.0))*2.0\x20-\x201.0;\x0a\x20\x20\x20\x20//vec4\x20s1\x20=\x20vec4(lessThan(b1,0.0))*2.0\x20-\x201.0;\x0a\x20\x20\x20\x20vec4\x20s0\x20=\x20floor(b0)*2.0\x20+\x201.0;\x0a\x20\x20\x20\x20vec4\x20s1\x20=\x20floor(b1)*2.0\x20+\x201.0;\x0a\x20\x20\x20\x20vec4\x20sh\x20=\x20-step(h,\x20vec4(0.0));\x0a\x20\x20\x0a\x20\x20\x20\x20vec4\x20a0\x20=\x20b0.xzyw\x20+\x20s0.xzyw*sh.xxyy\x20;\x0a\x20\x20\x20\x20vec4\x20a1\x20=\x20b1.xzyw\x20+\x20s1.xzyw*sh.zzww\x20;\x0a\x20\x20\x0a\x20\x20\x20\x20vec3\x20p0\x20=\x20vec3(a0.xy,h.x);\x0a\x20\x20\x20\x20vec3\x20p1\x20=\x20vec3(a0.zw,h.y);\x0a\x20\x20\x20\x20vec3\x20p2\x20=\x20vec3(a1.xy,h.z);\x0a\x20\x20\x20\x20vec3\x20p3\x20=\x20vec3(a1.zw,h.w);\x0a\x20\x20\x20\x20\x0a\x20\x20\x20\x20//\x20Normalise\x20gradients\x0a\x20\x20\x20\x20vec4\x20norm\x20=\x20taylorInvSqrt(vec4(dot(p0,p0),\x20dot(p1,p1),\x20dot(p2,\x20p2),\x20dot(p3,p3)));\x0a\x20\x20\x20\x20p0\x20*=\x20norm.x;\x0a\x20\x20\x20\x20p1\x20*=\x20norm.y;\x0a\x20\x20\x20\x20p2\x20*=\x20norm.z;\x0a\x20\x20\x20\x20p3\x20*=\x20norm.w;\x0a\x20\x20\x20\x20\x0a\x20\x20\x20\x20//\x20Mix\x20final\x20noise\x20value\x0a\x20\x20\x20\x20vec4\x20m\x20=\x20max(0.6\x20-\x20vec4(dot(x0,x0),\x20dot(x1,x1),\x20dot(x2,x2),\x20dot(x3,x3)),\x200.0);\x0a\x20\x20\x20\x20m\x20=\x20m\x20*\x20m;\x0a\x20\x20\x20\x20return\x2042.0\x20*\x20dot(\x20m*m,\x20vec4(\x20dot(p0,x0),\x20dot(p1,x1),\x0a\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20dot(p2,x2),\x20dot(p3,x3)\x20)\x20);\x0a\x20\x20}\x0a\x20\x20\x0a\x20\x20void\x20main()\x20{\x0a\x20\x20\x20\x20vUv\x20=\x20uv;\x0a\x20\x20\x0a\x20\x20\x20\x20vec3\x20pos\x20=\x20position;\x0a\x20\x20\x20\x20float\x20noiseFreq\x20=\x203.5;\x0a\x20\x20\x20\x20float\x20noiseAmp\x20=\x200.15;\x20\x0a\x20\x20\x20\x20vec3\x20noisePos\x20=\x20vec3(pos.x\x20*\x20noiseFreq\x20+\x20time,\x20pos.y,\x20pos.z);\x0a\x20\x20\x20\x20pos.x\x20+=\x20snoise(noisePos)\x20*\x20noiseAmp;\x0a\x20\x20\x0a\x20\x20\x20\x20gl_Position\x20=\x20projectionMatrix\x20*\x20modelViewMatrix\x20*\x20vec4(pos,\x201.);\x0a\x20\x20}\x0a\x20\x20', 'page-not-loaded', 'touches', 'setSize', '#7d7d7d', 'resources/fonts/Roboto-Black-3d.json', 'push', 'LowerLinesColors', '\x0a\x20\x20uniform\x20vec3\x20color;\x0a\x20\x20void\x20main()\x20{\x0a\x20\x20\x20\x20gl_FragColor\x20=\x20vec4(color,\x201.0\x20);\x0a\x20\x20}\x0a\x20\x20', 'down', 'addEventListener', 'DoubleSide', 'ui_moveEvent', '1398856qGSQoz', 'devicePixelRatio', '#FF0000', 'wheel', '236290DvpVpl', 'colors', 'innerHeight', 'setPixelRatio', 'touchstart', '#FFF', 'ABRAN', '138VhMlQf', 'SiteName', 'updateProjectionMatrix', '.configuration__letters', 'InOut', 'aspect', 'FrontSide', 'LinesColors', 'Tween', 'time', 'Matrix4', 'load', 'parameters', 'TextGeometry', 'PointsMaterial', 'domElement', 'CanvasBackgroundColor', 'floor', 'NumberOfVerticalLines', 'appendChild', 'touchEvent', 'PlaneBufferGeometry', 'Mesh', 'innerWidth', 'createEvent', 'random', 'width', 'clientY', 'ShaderMaterial', 'center', 'setAttribute', 'TextureLoader', 'remove', 'DotsColor', 'min', '8048876GrwXiB', 'SiteNameSize', 'material', 'Float32BufferAttribute', '18kjfekZ', 'resize', '7qvkxQq', 'lookAt', 'scale', 'ui_moveScene', 'max', 'body', 'length', 'position', '197834XXNtnd', 'LettersColor', 'pageY', 'add', 'sin', 'touchmove', 'update', '3849610sluXDB', 'PerspectiveCamera', 'FontLoader', 'Scene', '.ui-wrapper'];
    _0x3655 = function() {
        return _0xa8b377;
    };
    return _0x3655();
}

function generateRandomObject(_0x317979, _0x1e6194, _0x58ab91) {
    const _0x580875 = _0x464a76,
        _0x33dae = (_0x72869a, _0x157399) => Math[_0x580875(0x155)](Math['random']() * (_0x157399 - _0x72869a + 0x1) + _0x72869a),
        _0x5ce3f2 = _0x1e6194[0x0][_0x33dae(0x0, _0x1e6194[0x0]['length'] - 0x1)],
        _0x21f84f = _0x1e6194[0x1][_0x33dae(0x0, _0x1e6194[0x1]['length'] - 0x1)],
        _0x4a5ca7 = _0x58ab91[_0x33dae(0x0, _0x58ab91[_0x580875(0x173)] - 0x1)],
        _0x542fd2 = new _0x255c8b[(_0x580875(0x159))](_0x5ce3f2, _0x21f84f, 0x1);
    _0x542fd2[_0x580875(0x128)](new _0x255c8b[(_0x580875(0x14e))]()['makeTranslation'](-_0x542fd2[_0x580875(0x150)][_0x580875(0x15e)] / 0x2, 0x0, 0x0));
    const _0xee695e = new _0x255c8b['MeshBasicMaterial']({
            'color': _0x4a5ca7,
            'side': _0x255c8b[_0x580875(0x14a)]
        }),
        _0x1f472d = new _0x255c8b[(_0x580875(0x15a))](_0x542fd2, _0xee695e);
    _0x1f472d[_0x580875(0x174)]['x'] = _0x33dae(-0xa, 0xa),
        _0x1f472d[_0x580875(0x174)]['y'] = _0x317979 + _0x33dae(-0xa, 0xa),
        _0x1f472d[_0x580875(0x174)]['z'] = _0x33dae(-0xa, 0xa),
        scene[_0x580875(0x178)](_0x1f472d),
        mainGeomertries['push'](_0x1f472d);
}

function loadMainLetters() {
    const _0x5259df = _0x464a76,
        _0x564c45 = new _0x255c8b[(_0x5259df(0x17e))]();
    _0x564c45[_0x5259df(0x14f)](_0x5259df(0x131), _0x2acf77 => {
        const _0x44e7d0 = _0x5259df;
        let _0x3b9d4a = new _0x255c8b[(_0x44e7d0(0x151))](configuration[_0x44e7d0(0x145)], {
            'font': _0x2acf77,
            'size': 0x5,
            'height': 0x3,
            'curveSegments': 0x3
        });
        _0x3b9d4a[_0x44e7d0(0x161)](),
            _0x3b9d4a[_0x44e7d0(0x16f)](configuration['SiteNameSize'], configuration[_0x44e7d0(0x168)], configuration[_0x44e7d0(0x168)]);
        const _0x1df5d6 = new _0x255c8b[(_0x44e7d0(0x160))]({
            'uniforms': {
                'time': {
                    'value': 0x0
                },
                'color': {
                    'type': _0x44e7d0(0x122),
                    'value': new _0x255c8b[(_0x44e7d0(0x125))](configuration[_0x44e7d0(0x13e)][_0x44e7d0(0x176)])
                }
            },
            'vertexShader': vertexShader(),
            'fragmentShader': fragmentShader(),
            'side': _0x255c8b[_0x44e7d0(0x137)],
            'wireframe': !![]
        });
        mainLettersMesh = new _0x255c8b[(_0x44e7d0(0x15a))](_0x3b9d4a, _0x1df5d6),
            scene[_0x44e7d0(0x178)](mainLettersMesh);
        let _0x5e2613 = [];
        for (let _0x229b2e = 0x0; _0x229b2e < configuration['NumberOfDots']; _0x229b2e++) {
            let _0x14e7fd = Math['random']() * 0xc8 - 0x64,
                _0xd9cf8a = Math[_0x44e7d0(0x15d)]() * 0xc8 - 0x64,
                _0x7530dc = Math[_0x44e7d0(0x15d)]() * 0xc8 - 0x64;
            _0x5e2613[_0x44e7d0(0x132)](_0x14e7fd, _0xd9cf8a, _0x7530dc);
        }
        const _0x4b9ae2 = new _0x255c8b['BufferGeometry']();
        _0x4b9ae2[_0x44e7d0(0x162)](_0x44e7d0(0x174), new _0x255c8b[(_0x44e7d0(0x16a))](_0x5e2613, 0x3));
        const _0x17f87b = new _0x255c8b[(_0x44e7d0(0x163))]()[_0x44e7d0(0x14f)](_0x44e7d0(0x127)),
            _0x4b4c43 = new _0x255c8b[(_0x44e7d0(0x152))]({
                'color': configuration[_0x44e7d0(0x13e)][_0x44e7d0(0x165)],
                'size': 0.5,
                'map': _0x17f87b,
                'transparent': !![],
                'alphaTest': 0.5
            }),
            _0xdbd72f = new _0x255c8b[(_0x44e7d0(0x126))](_0x4b9ae2, _0x4b4c43);
        scene[_0x44e7d0(0x178)](_0xdbd72f),
            windowResize();
    });
}

function vertexShader() {
    const _0x5ecf93 = _0x464a76;
    return _0x5ecf93(0x12c);
}

function fragmentShader() {
    const _0x5bca71 = _0x464a76;
    return _0x5bca71(0x134);
}

function loadMain2DLetters() {
    const _0x594fc7 = _0x464a76,
        _0x38e5e9 = document[_0x594fc7(0x129)](_0x594fc7(0x147));
    _0x38e5e9[_0x594fc7(0x121)][_0x594fc7(0x164)](_0x594fc7(0x12a));
}

function isMobile() {
    const _0x527a1d = _0x464a76;
    try {
        return document[_0x527a1d(0x15c)](_0x527a1d(0x158)), !![];
    } catch (_0x2351a0) {
        return ![];
    }
}

function uiCallback() {
    return {
        'onPagingClick' (_0x312da7) {
            const _0x59b1cd = _0x2001;
            if (sceneMovedAmmount > sceneMovedAmmount)
                ui[_0x59b1cd(0x170)](_0x59b1cd(0x135));
            else
                ui[_0x59b1cd(0x170)]('up');
            sceneMovedAmmount = _0x312da7,
                moveScene();
        },
        'getCurrentPage' () {
            return sceneMovedAmmount;
        },
        'blockSceneScrolling' (_0x51e0d9) {
            _0x51e0d9 ? timeoutActive = !![] : timeoutActive = ![];
        }
    };
}

function moveScene() {
    const _0x2b96d9 = _0x464a76;
    new _0xbc2b79[(_0x2b96d9(0x14c))](scene[_0x2b96d9(0x174)])['to']({
        'x': scene[_0x2b96d9(0x174)]['x'],
        'y': sceneMovedAmmount * windowHeightInRadians,
        'z': scene['position']['z']
    }, 0x3e8)['easing'](_0xbc2b79[_0x2b96d9(0x11f)][_0x2b96d9(0x11e)][_0x2b96d9(0x148)])['start']();
}

function windowResize() {
    const _0x36fc31 = _0x464a76;
    if (mainLettersMesh) {
        const _0x55227c = Math[_0x36fc31(0x166)](window[_0x36fc31(0x15b)] / 0x44c, 0x1);
        mainLettersMesh[_0x36fc31(0x16f)]['x'] = _0x55227c,
            mainLettersMesh[_0x36fc31(0x16f)]['y'] = _0x55227c;
    }
    camera[_0x36fc31(0x149)] = window[_0x36fc31(0x15b)] / window[_0x36fc31(0x13f)],
        camera[_0x36fc31(0x146)](),
        renderer[_0x36fc31(0x12f)](window[_0x36fc31(0x15b)], window[_0x36fc31(0x13f)]);
}

function windowWheelOrTouch(_0x27eb87) {
    const _0x3967a8 = _0x464a76;
    if (timeoutActive)
        return;
    timeoutActive = !![],
        setTimeout(() => {
            timeoutActive = ![];
        }, 0x5dc);
    if (_0x27eb87['deltaY'] > 0x0 || _0x27eb87[_0x3967a8(0x12e)] && _0x27eb87[_0x3967a8(0x12e)][0x0]['pageY'] < touchStartPosition) {
        if (sceneMovedAmmount === 0x5)
            return;
        sceneMovedAmmount++,
        sceneMovedAmmount = Math[_0x3967a8(0x166)](sceneMovedAmmount, 0x5),
            moveScene(),
            ui[_0x3967a8(0x170)]('down');
        return;
    }
    if (sceneMovedAmmount === 0x0)
        return;
    sceneMovedAmmount--,
    sceneMovedAmmount = Math[_0x3967a8(0x171)](sceneMovedAmmount, 0x0),
        moveScene(),
        ui[_0x3967a8(0x170)]('up');
}

function mouseMove(_0x45cbb2) {
    const _0x631436 = _0x464a76;
    ui[_0x631436(0x138)](_0x45cbb2, configuration['Use2DTextOver3D']);
    if (sceneMovedAmmount > 0x0)
        return;
    const _0x46e54b = window['innerWidth'] / 0x2,
        _0x1320ba = window[_0x631436(0x13f)] / 0x2,
        _0x3618a5 = _0x46e54b - _0x45cbb2['clientX'],
        _0x47a475 = _0x1320ba - _0x45cbb2[_0x631436(0x15f)];
    camera['position']['x'] = -_0x3618a5 / 0x64,
        camera[_0x631436(0x174)]['y'] = _0x47a475 / 0x64,
        camera[_0x631436(0x16e)](scene[_0x631436(0x174)]);
}