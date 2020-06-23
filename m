Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3387E204A0B
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 08:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgFWGkl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 02:40:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:36765 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730540AbgFWGkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 02:40:41 -0400
IronPort-SDR: pUJohO2t3OCHFOEO1HU8xOmFO+iA0eXUub1WkQR9GUCWpIO8qWE/1L9scPv/FYtMr4yzFwk0Am
 lrRmW4SkR3cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="141477742"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="gz'50?scan'50,208,50";a="141477742"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 23:40:09 -0700
IronPort-SDR: rk8lzvdlhS8RMzPR4KxLF07fCFlqd57BkOM69PpwabfPPpkMpsXziOrE+bk9/3t0R4mQlc3B8A
 jiVRednMpHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="gz'50?scan'50,208,50";a="293103300"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2020 23:40:06 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jncbG-0000eN-9Y; Tue, 23 Jun 2020 06:40:06 +0000
Date:   Tue, 23 Jun 2020 14:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: add
 bpf_skc_to_{tcp,tcp_timewait,tcp_request}_sock() helpers
Message-ID: <202006231440.W41IhYdj%lkp@intel.com>
References: <20200623003632.3074077-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200623003632.3074077-1-yhs@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yonghong,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Yonghong-Song/implement-bpf-iterator-for-tcp-and-udp-sockets/20200623-090149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: net/core/filter.o: in function `bpf_skc_to_tcp_timewait_sock':
   filter.c:(.text+0x367c): undefined reference to `tcpv6_prot'
>> nios2-linux-ld: filter.c:(.text+0x3680): undefined reference to `tcpv6_prot'
   nios2-linux-ld: net/core/filter.o: in function `bpf_skc_to_tcp_request_sock':
   filter.c:(.text+0x36c0): undefined reference to `tcpv6_prot'
   nios2-linux-ld: filter.c:(.text+0x36c4): undefined reference to `tcpv6_prot'
   nios2-linux-ld: net/core/filter.o: in function `init_btf_sock_ids':
   filter.c:(.text+0xe65c): undefined reference to `btf_find_by_name_kind'
   filter.c:(.text+0xe65c): relocation truncated to fit: R_NIOS2_CALL26 against `btf_find_by_name_kind'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGSZ8V4AAy5jb25maWcAnFxdc+M2r77vr9BsZ95pL7a1naRN5kwuKIqSWUuiQlL+2BuN
62i7nmbtvLbTdv/9ASnJJiXS6TmdaZsQIAmCIPAApPL9d98H6O20/7o+bTfrl5dvwR/1rj6s
T/Vz8Hn7Uv9PELEgZzIgEZU/AXO63b398/Nuuz9Ogruf7n8afTxsxsGsPuzqlwDvd5+3f7xB
9+1+993332GWxzSpMK7mhAvK8kqSpXz8oLt/fFFDffxjswl+SDD+MXj46ean0QejExUVEB6/
dU3JZaDHh9HNaNQR0ujcPrm5Hel/zuOkKE/O5JEx/BSJComsSphkl0kMAs1TmpMLifKnasH4
DFpgcd8HiVbVS3CsT2+vl+WGnM1IXsFqRVYYvXMqK5LPK8RBYppR+XgzgVG6eVlW0JSAhoQM
tsdgtz+pgc9LZBil3So+fHA1V6g0FxKWFPQiUCoN/ojEqEylFsbRPGVC5igjjx9+2O139Y9n
BsTxtMpZJRbIWJJYiTkt8KBB/R/LFNrPyyuYoMsqeypJSczlnRkWSMIUA3qnHc6EqDKSMb6q
kJQIT83RS0FSGjrHRSVYrknRWwdbGRzffj9+O57qr5etS0hOOMV6pwvOQmPzTZKYsoVtFhHL
EM0NRRSIC6JIppjmGBEJyyQWtsz17jnYf+5J15cAw6bPyJzkUnSWKLdf68PRtSJJ8QxMkYDI
8iIe7OT0kzK5jOWmgNBYwBwsotixCU0vGqXE7KNbnaqf0mRacSJAiAxM1LnUgeTdZAUnJCsk
DJ9b03Xtc5aWuUR85Zy65RrsOy7Kn+X6+GdwgnmDNchwPK1Px2C92ezfdqft7o+e6qBDhTBm
MBfNE+N0iUhZCCZglkCXpoh9WjW/cQopkZgJiaRwL0FQp8b+xRL0UjkuA+EyiHxVAc0UGH6t
yBJ23uV5RMNsdhdd/1Yke6rLuHTW/OBcH51NCYp6dnF2a8p/xXDQaCwfx7cXo6C5nIFTi0mf
56ZZtdh8qZ/fXupD8Llen94O9VE3t4I6qIYHTjgrC/dmKKcIZxq21EnGU4JnBQPhlL1Lxt0+
TgBfpN20nsrNsxKxAO8AFoyRJJGTiZMUuQ0/TGfQea4dPHd3DhmT1XBjLvGPFXBg6SdSxYwr
fwD/y1COrWPYZxPwg8t4ukDQzV3El18ak7v8nkEIouDKuTmRSIjM4KDooVCauicBlbX0y3Dx
FOWNr7JiUOOMjFZtU2bcTMz5SRqDsrhrcSECFx+X1pwlIJzer1VBrQELZq/islSa5CiN3bum
xfbQdDDw0MQUoqY7MlLmWBRlVcktV4eiOYWFtvo1NAcDh4hzqjesbZspllUmzBV3bZV7+85k
rU9l2pLOLWMDq3Ftvxn+uQYwtg467WQhiSISWVEEj0e3g+jQwtiiPnzeH76ud5s6IH/VO3Cu
CPwHVu4VgpXpUP5lj06UedbsVaUDimWGCv8hCeDRMEWRotA6C2npBjkiZaHrYEB/2CWekA7h
2aMBNYZAmVIBfgsOC3MbipiWcQzQtEAwEOwBYE5wcZ64y2IKqDlxhi4bMJ9hBWViMgRaWJTZ
sHW6IIAqpIMdAQLk4DFhqeAcLaxDWcG4rDKNXc2dtmLEBQONRyOHNoEwuRv14NKNzdobxT3M
Iwxz9hCMYwKSLatPAHQYh4D4OB4PDMwIV0ArXtYnZW/B/lVlWkp83Z7VX/eHb2oyBQOOl6Cv
VazOqz5jj6N/xqM2S9L9ovqvLVju6VDXpiaaXpEMAXFXxXQFBziK3Pt+YRWsVCuCIJMOzlcO
eV9AAdbsjqfD26aT3RpDZxqcgMtRmc7YJk4XKkhUoizUhloo1KAvOwYXhu34Ijr3jxMD6nOM
0ePCVOVD4buzdXw5e2wVjtcARBz7hEsADxnYMgCFShCpMKfhI1ott2SIuLCT90aua9FV7tox
TXosdDjE2eIGxtWY3GG/qY/H/SE4fXttYKdxeLqAkBlIMecKPIv+FsIxTfJM+UDJL+cx3IPi
LtbcqSOL9CqUMRmesmlV6esFjrSc+jhd27KWD2SAmK4M1rtrBQL43s3V2wINoYAAqVUcwz6B
Ekej++ZEXRR5RWV60ej5LxUxns8FhEtojuYKcEUaY7FcDE5SVH9ev72cziYUwI4F6268jVmH
6dQarA918Hasn/snbkZ4TlK1eXDuElVIaJ3E/cgupVjsNuvGyQpYwmarO7azkno6sOoq68Pm
y/ZUb5TKPj7Xr9AFQuvQTKZoThq/ASaFyZQxI4bqdlXRiTKkjlRV5tr4ox7LzSSkUm1nZSJS
0EmC5JRwFUYgRCaGKbSVIsjgAPtzJgmGqNjlq90ALCpTyIABoWgkqdCNAT0TiUIIrCmAAgBW
kx4WaERSwM+YFDwTiELimGKqThHYn+m/VG3AxBhD00kwm3/8fQ2GEPzZBJfXw/7z9qXJfS+1
CmBr99ody68N0w/47+xktzgVoxViJobP06BQZArZj3paNdfdNLXhNGXIBQRbnjJXdG/nhuz0
IcDX1trcaWA7DqTH55KcB7F2nJ7cuCUrO4B88upkCo9B1KNCQKy45KkVzVRMcnctc7DHCCB1
FrLUzSI5zTq+mULnrvxHGZuxU5B6CiwoGPlTCVmwTVFJaSis1Mpo9lXvLumsJAmn8nrSqyCU
J+cFjs7369KcG8YotkXoiuTNFJAbVvZ504vWjhq5d1oxNIXkiuSYr7RDHxzKYn04bbW3lhAr
LDwK4koqtTG1UcFl2iJi4sJq5NgxtZov0ak3Y1MWZZcSiRnXn8CVN8WLiKBeRDSIs1VoJ+8d
IYyf3IVOa75LpbzBLgXN9WkEj9YUUm06B1Fa+jWas+8CbIn4OpvEtrfWDvmn3ryd1r+/1Ppu
JNAp38nQU0jzOJPK0RsbkMaqfGAchoZJYE4Lu2zYEOAou4qvapCo1BcKZ/X5BDKTgWy9W/9R
f3UGzhhSbUgKjHoFNEB4iYjOFTKr1l+kEIwKqZWigd2tFa7w2cDOdpuofVBeqJcPdoZDE8jX
er1mInOwdvcTGYgE/XKdiDzejh5+OQMOAmZWEI05q1lmlapSgpqY767dZcjZ/qnopTAXSli6
vcwnHacYdhJV3bxRikIps0GO3KmNcLUEf104KYsqBFcyzRCfOU+Vf+cv2pKdUef16e/94U8I
20P7gF2dEWlvqmqB5Am5drTMqVH8Ur+BmVt7odv6vS9BxxOMljHPdJHHjexBoBlZOeShzTq7
34qmwoiRsNYE7We8zRngD+4aqqiKvLAGg9+raIqHjSo7GLZyxAsr0wSxaUHdVeCGmKgUhWTl
0m1QsB4tr6eOnMPBZDPqKVk3M8wl9VJjVrrnVUQ09dMAgfiJtFDuwrNZ2jRMfwxNEhddsz1S
GRV+U9IcHC3e4VBUULGQnLmhhZodfkyuBd8zDy5DatyGdl6roz9+2Lz9vt18sEfPojsfDIT9
+cWN/Qro6ds4dUUNmAQP/UOPp5iudHYBviYrfP4ImGOaSh9gKq4QwUAj7JETaAJLN41HHkwK
tuOuZEt34TKdeGYIOY0SV0lfp5LaMATqH1Zocg42T1Fe3Y8m4ycnOSIYervlS/HEsyCUuvdu
OblzD4UKN4Iupsw3PSWEKLnvbr0+QMM397KwB7HDZiCNVZ1kVpB8LhZUYrcDmQt1ue0JfSCR
Lrp4z3RWeCKIWksu3FNOhT+uNJJCbuHlSG8AJwk4ApWP64lL/wQ5tq95DRJfVmEpVpW6LzLg
41PaC93BqT6eetm76l/MZEJye+YWIQx69ggmGjAUhTKOIvvW6AKjUO62B7ftoRjWx33nOa5m
2H2kF5ST1JcSL2iG3LGSxzPqScWVqh7cbgIjGrsJpJhWvpw1j92rKgS42dRTnVSRMXbT0oUs
80EZpkPsiKZs7oQsRE4lQNju1HRW0xb7o8P2r+4yqxMQY2TfGV/KcdtN2yNgZ5R4QXVNwWlK
0sIpCZwMmRWxMENj01JlqkhlZBkS5RFKrRpawZvhY8qzBQJIpF82dcuJt4evf6vS5st+/Vwf
TLHiha4E9aNTa+r9judqoC6oqHKClXKdBVc1gIjTuSfotQxkzj3Aq2FQz7zaYSBJymAL3SFP
sSHAcrhj1s+SHDo+34NB8gCzU2wW0cCpKl9i5o6eXW2q8W/H4FmbibXN2ZSqUZzaNLsY54SB
4WLfZWGSC1dZKZN2cU5GWg3DSualhPG6Phx7xqy6If6rLn54ZjErQtK81wYSi8+t1pBgEbr4
PxjWUVjppNJilfBjkO1VqaO5HJaH9e740pTo0/U3u+ACM4XpDPaxJ1ZXcrvYuPR4NR+Beik8
jrzDCRFHbq8mMm8nrUfmeVGjiOfCFGReTRAd7DFH2c+cZT/HL+vjl2DzZfsaPJ89l7mVMe1v
1W8EoJfvuCgGODLnV35WTxhMARjX7YvBpWoRIQI4sqCRnFZje6d61MlV6q1NVfPTsaNt4mjL
JQTEpRxSUBaJ4VFSFPCyyHckgFxKmg7sHrnjsaZ53g3oIxgK8N3Og3Jla5sC1vr1VQGRtlFf
cWmu9Ubdq/UPu0orQRFKtSqZuWJ105UAJj89RXKw3K608o5MzRu0+uXzx81+d1pvd/VzAGO2
rtEwXWtGkV5TbzG9RoV/r5G1w5goEfonK9oe//zIdh+xEt8PCtQgEcPJjVMf7y+15w5ykkOE
95sSZOx9Bi1NWqinB/9p/j8JCoCHX5syl0enTQeXzO8PZY8ESb1X3ukKEE8vJnZxXhqlABab
BwqCS5lT6XnqDVRVh5WcEHOAiiCertykGQt/sxpUfRRQstVm1cHhd6s4Br9nAO2tBhiB8Lny
zSTria8gp+8JInh1z3OI9p7GdQeUl2mqfvH3AizHjKqa2apLwvq68/F+OLS+dGGKz52gtGwR
D/13R1rEd+i+Y4gj8HIqG8PR3D0CpPtaowqyX58iHJ6MfJ6RQLy9vu4PJysFhPaqn4p0aZ7Z
p3G22+PGhfkA/2YrZTpOuUiOUyZKrh6rcI053RjBp5qleiu2rEQUE0/ONC9QTt00POmbWXNL
QwoVkI5DjTSU6uEGL39xqqXXtXlaX/+zPgZUv1j6ql/2Hb9A1vAcnBR+U3zBC/i+4BkUuH1V
P5rvA/8fvZunIS+n+rAO4iJBwecuUXne/71TyUrwVcPI4IdD/d+37QHwJJ3gH7tHYHR3ql+C
DJT2n+BQv+hPeRzKmMOx8YH5a0MY6sRT5g6Spi01EVFVOdrAcJGlsw51Z5wxC6lwRCP1nUf/
qwGjizseOSayzpnbk3ue3CKeEOl7/Qvuc5Bn5S275eFYHvmKq/p0eescSYk8T7jJU4lS+unK
hYgkPlCAsCpY+urNPtJ86aOoxNOTvYaQrZeR2+0mntIsyCc8zgDWBT8J5qmhyNItILRXc70z
+iMiT++5z/fmaea4sAf0dDpsf39TR0P8vT1tvgTIeORioZLWNv9tF6N+o57fSNu85iSPGK9Q
irC6ptbfQZ0rF5BBoUoK4u6SoU/m0wCTBPaUS4rcRI7d7SVn3KqSNy0QKO/vnU9fjc4hZygC
yG6dlFt3ITrEmTIydyFRrCBvzHzvLy8TYhSR3jcMYGrO539mpzk1XyGbJH2vbS0/IYBD6Hnf
3Cc+exh5ngxHvT7DOcknPKVWOappqfJCwGpyBBKoSllfWcOREsaS1G0m0xItCHWS6P3kbrl0
k1Qa6qRkCDBkaieU8yxyfnxgdqOYE6vXTNzf342rzPkRQa8naxXloQrYKSc1R9JPI5KznGVu
teVW/QHMYJmQ/9ue3N88WK/LwY6Y8zO8S5eC5EK923dKpGKE+sTPHPMJGioChu+uAGXvCslh
HQIJ54RcXd1wJ0mgTJS5dYcrlklI+ojX0ZOQJ/eQLEUcsiHu3g+RCWxNB78/jMfLd2ZjWJWj
lm6nK6S2HmtYmYE2/8UyVjkrwFdZteQFrpZp0tuNYd85tdwM/AoUyOt7z+GGHRf0U26/32ha
qsXd2OOEzgw373nwBrubg7doHi2p38RaHkj2ZJ/nDMYoayvYRk1LNXYVbKsNq2eK1Dddw0Nl
iDwIrBu4yspllWUUwNu/YVTvSFS1yYPANPOUAq6NvZrQPLR4uh2NH/wMYLUYfBb1gDnFsiyw
q/5QTFcpDY07gAW0WE+FIbOXnCaJulWYWqbUpISUBqrdX7tCAGz7XS/ELPLTWrzhZ1je3//6
8EvoZYB9/3W5XF6j3/96jd7ij2sD3N2Ob0dXZ7i9vx97GTAFzOFfYgsgvPQIsMc1AaPi/uZ+
MrlKl/h+7BdQj3B7f53+y6/v0B/69JYa0yXRFmA93MFFCmfIN6JGEdVygVZellQohDUejcfY
z7OUHqFaMNIXq2sejxLvoA0guUrWqONfcEj/npzhiZcj128mkV+Sp6vdOVFpwuwKXQd4Px2C
/NVlqkDrJ0oyHi3dmZ9KXiC+UOyffA4ZjxDES2+jSwKua8LVf91FpcLz6XVqv8bTrm66P54+
HrfPdVCKsKspaK66flZ/JWV/0JTuSQV6Xr+e6oOr5LLopdBNuWqn3+8uturpwg/D9xc/Bqc9
cNfB6UvH5fDEC09y3hQphCd86Fd+jgcEl/MootxxivK5BSrh16ro1W7bUtTr28lb96F5UZrP
M9WvKihZQb5pjWNVg/a++2iY1DsZ3xuchqP5qxwz3+VPw5QhCIrLPtP5DvdFfce1VZ/1fl73
aqVtf6Y+mrgqx29sdZ2BzN+jh2XiUffgKsfqOSOrkCFufP3UtVRIzkKrCHempLOZp/Z9ZsnJ
QjK3DZ551NsvVR1zb+KZrc0V3mGSbIEWnhuIC1eZvys5g5121x3OLEv57iih572SYRPXDUKo
PzdyhUV/KeZ5x9cwsBJPBcSo/psvW5Le1wVG7kdvB6XOxgOuD8+6/kx/ZoE6woZRCfXXYqx8
SDWo/3oqMg0dgGmhv/nu9eNo4fbMmtrWt6DnFSagKnR+bRiO3xkDFaGPodQc7oomysjwi+G2
+OdS4qXc7nCTjWP5sj6sNyqcXK5mumgpLQQzdylbvbZ/AHwnV0bCnpIE4ZW3sb1Hm9ydP61I
I7AZ/VdL2u/m2kvuw3b9MnyMofQD4ERfVmL7246WdD+5Gw2MLN/vPmrCsRlXR1lHDG3HKBGX
KZXOPznScNgf3RiN6lGSqiE7JBM0pp5SdseBcb50vV5v6a2J/iaRKt7LgQA9+hVZPJxVuFIf
Jr8rwbXZ9XgAJPQHgpfPeBxMISoj9TcVHsfju4n+bNfPi6+U5lv2Fp4VQve4xgln9Bo5FmmV
Fu8NorloHkOe/h4rVkUfSEmriCaQdaWeF2udFRT9e5nzcwjrUAw65qAj/cLRc6+TV4nwQDV1
Py493z/qz57BenN3AGkn159a9m/8Lt6k/UM47thRQEbR/Dkdt2KmC8cfEOnSRDLvPSCAlpnv
r9Lobzb8zyslhn8L721yuvLdaQ5dqTmnEh3UWAqpv94ZPhttANYEu3ySanZNabIb3Dce0y7c
2YoA3bt13r8DPac3jqeSsvjfyo5kuW0ld5+vUM0pqcrLS2zHz++QA8XF6pibuWjJRaXIsqNK
bLkkeeplvn4ANCl2k0A7c3GiBnphL2gAjWW0/rlb/+DGD8Dlx09XVzqynCShaH0ShTEQHUgM
UWV1d0dWkHAcqOPDe/MtbDgeYzgq9auCNym8zlUm2V3PPvLTkc3CYulNhShrBEVLF54+aDhG
+Ij5szeZJQLfi89AieAVTNEOg4xzoivLMUaqKtW4dy+U3GMV8J0eiz7u+TVqld7Lz+P2/uWJ
Qq+4jNIiFAeSEGgoEE9fsu87YU1iXzAPRZwED5Pw8g7gibq8OPu4zNHegJ3hysdgHMrno+hh
EzdhkseCVRkOoLo8//svEVwmnz7we8cbzz99+DBgi+3ai9IXdgCCKzTEPD//NF9Wpe85Zqm6
TeZXvF2Kc9lM1c11HYuhmYDrlb8jDJS39EPfGfVGYzEY2k1gv3r+vl0fOAoTFMkA34My0+Co
DQhiFGsD//3qcTP69nJ/D7Q7GFooRWN2zthq2rp9tf7xc/vw/Yg2gH4w1E90ekQ/wPixZdm8
R7CzMvb8mxhjUjlQWyP5V3o+2eb3p9KgAsCdD23AJioY6leg0CQI8BOds4BhW4D0XITptWDw
AIiSHFZjR0MihE03/gcn8eB5s0ZWCCswBAZreBdoviANYen5heD4StBccqUhaI1qThE8DuMb
xR9ZBPtAuIW4ohoMHGLqgGf1tSewSQqpIcaxc1SnYyaDF3JIEITD2l1naaEEfQOihEm5jHjH
JgLHoUTxCfy152xtQa/DZKwE7pbgUSE3fQ18t8oEFhURoGdSc8gIC/mzZyCtCDagCJ6qcFZm
krEhDW+h4xWICPjgI/evBE9thH3xxsINidBqptKJoOHV05Ji9BdJAYcosU+cjAwX3Dw1LM2m
vM6DwNm1cp7kxAOZSlaBaZQYjSsc8EUE1FXuowj1xpdboIeVLOKvNsLIMCSjY2/Tq697/6WC
Pz3C4NIMefEKoTlIn0B34ATIC5GHlRcvUpkq5ii7+o4GYuilwE0unzEQAyUvSgSXnnJ9hkt5
S/A8DNHpytGCaLrYQMMYBVpBi0w4dYqvjPJekQQqPOOoPwVmUz6MZeIV1Zds4eyiUo4DA1So
DB3nrZrAYZanoJqgnDr0l7KQUG8zW+YlzzMTOVQqyRwkaa7SRP6Gr2GROWfg6yKAG9xxIEsg
WmRuxktzdI3HfeexVs/CcRcnVavBDJ00oSBUZRNfLWNVVTGGYoI71rCFRDgTDRKLWzMJniEC
hDrOB36RBvgUgG7iB722B3wclpHms2OZTuX5918HzNGgnQU5pirNcupx7odqys6box37m669
4FqQiKtFLtjnYsUCdZQO//4kESQgYEr6LyDtZ4Wz9lmw5cvhl+a2e/YsTelSvisIaVwgv55i
fPbJDPg5jOvHuByFLOuqW/CTy/OzK0cXiPDpytEovRx/+7l9+vHm41tameJ6PGru4ZenO8Bg
tvnoTUch3g6GlcRzyX6J4P0YOqchVfvtw4Olxyf8xjxoOM2t3RBFpZb7a9GaBASvI/Yc1TiU
SQj0dxx6lTiok0T2en9+zse4sZAwttVUij1nYbYRXxiD8e0zBeo6jI56qrtVTjfH+y36ezRx
O0dvcEWOq/3D5jhc4tPMFx4wfQPfSvYjvUTSv1h4uehqY6Fpm4LfaQ6FTf4CsOe3loJKeD4m
UVBjFUvTr+BvqsaST2FR+ZoksNAANVPTvtuStu9PvHEdGSGxOgkcnfEjJUifut4SHfqBHlcq
EkynNBrsZeGG6/VvTEk9D1SZS853tTCTU1W08Qa4iwrBaG0YplZiiLY4kVoNcs6ReIp5ZIaN
Ual2wtD3b/PsOJj8ZLve7w67++No8ut5s/9jOnp42RyOlorm5GvkRu26B85u+DjQrmkFIorA
tV5ncRCpkrPvpWhBfmxEEPTJaR+dEm9qw/68RcRYFrlnPkzqHCxNI6c+EXVSBjyT3FVpbOzE
5ZnMMIYiq9T3Sfle7l72lga4veORrGunVatk6C3fWb2p6vKCV8WxfRlteCoeZ5xhtsowAG/H
l1nhSAg4yldAJel9ohxujtdQDTJCPTE5eXQQgs3j7rh53u/WHEOA4Tsq9BzkX4GYyrrR58fD
A9tenpTt0eNbtGoauxh1g+g4NviAEsb2pqT0LKPsaYQu329HB+Qu7k8hQE7Mpvf4c/cAxeXO
59yYOLCuBw2ia5NQbQjV2tj9bnW33j1K9Vi4NhmY539G+83mAMzsZnS726tbqZHXUPUN/T6Z
Sw0MYAS8fVn9hKGJY2fh5nr5S1tfQJXnGET5n0GbTaXmDX3q1+ze4CqfpKbf2gVdV3mCyuyo
CAXn3zm640ncfCZoUJVAq/LZ8IkA3Y4pusLQdrC47btC4YN/n30x8mlZ7RjDwYiW4rM4vQui
cUAFck3M8M5oiGomWepujSYcj8N6fHmTpR4KTbINNz6wNo5ryyorCondM/GC32ms9GJBQYFY
aDihkvlVctuXUi20BG6fGP6C+OvsNJ97y7OrNMEXa8HN28TCGWGX0Z5sozZqNn0poocQp67w
hnTee7rb77Z3lotDGhSZ4q09WnSDrfNY/6KpFWSXfuqkRe2dNpmhQ/gazX45mychvKG2lu+/
4rRakGGTXU3yK+eajASbglJlvEqwjFUinR4cX+HrEFACJ0NZcHgG2DZjbWJ9AfXWy2/RxKkX
qwBTv0SlK7o3EKyzZT/lXgc7d8AuJFgRKkw+VErwLzJoLoOACRFHOq4c3aUqdlSNzuSamHSM
3b04p5Q4y/MNB8+QrMfsWOhtmQ46s+xFfmqbwySXCLdyTCVoFFVhcsce3BwfHz/dxADpRhIU
A4c0pjRMDjEceY7at3UmxBVAm8moFPeOBosLgjkjBFgTfmXJ8KqUWsZ+IC+Z4Ncta66xNXrw
B4ZjwiAleNCYc6bK7O/Lyw/SqOogGoDafvi2taidlX9GXvVnOMe/cMMJvesY90LfU6grn18H
MK2YJWhpkGtk+v4/bF7udhR9vRtxey2BRNDLFkBFN0JACQL2E+ZRIUUNB5lPwQkZNAd8UBwU
Ieengek7zKiL7Z1jEGD8R54A5vNOJxaNgvGwagd8q9mMMqXIW9sLHLBIhk2cIPIsk4imYzRj
GTSsdSLrmsx2c9uWaCGyy1VyKqesAuM6iuwUCR0cFUJIwAQyoxHLOkmkpKenpuYYOcWB0uYV
waQScow7jfvVciLVZUWTk6bbR4WXCFNY3tZeOZFOreMOxFgKc5EAJo6tkMuw23R+4YReytDC
1WnuyPq5KKciyXTsvWJ4ObQ0q7G/tI9fC6Ra9u/pWe/3ef93c7t3ZBFLL5i+C4x+mfY70Jve
LlIlJTfCMO2dCqdlcMhiWecaNt514Nrv/4RR2O3CQIftIeCUzrid9zotrOTU9Ps01G7zYjBf
YRF8JQGywJNJmMyfCfGp61RBi9ytoLLlTCeRPsWtNZjgxhVj/bLfHn9x2uqbcCGcy9CvkVla
BklYkqRbgbwqGclrXCeQ3amk+Jx4BUidYUD8lZ/liy6JpGWg1keTVLUVyNWIk8CMOWIO66eY
7js9Yy/EZfL536iWxJha736tHlfvMLLW8/bp3WF1v4F2tnfv0MvvASf23bfn+39biSO/r/Z3
myc7aca/jKwr26ftcbv6uf0vxXc1nfBUpTOGDRJbE0injMp84SVpgIzpO0VcOx1If0i9DJPM
F3VeDb39ZRJ+jK03YELj7bf9Cvrc716O26d+PqNB8pP2IlYVhnouSibtOuzO1IedE2EEtyZH
MIMSh6kApYwRlYp7/E/RS3Vu8FZwxy3TOhnzLyZF44ZtX4PAjvmqEqTdwv/Ip3PAetXHD4EU
bRzAqqqXnIsXwM7PemM4BzYhjCMhvGSDECs/HC+umKoawrtENiheMfME0xGNAUspQS/FlkUA
b7oNjAl1JkQHLHz+eV47e7jnCJkefFqM0ffpl1UKh60p7QT5r5jkgaV+Jb4smMqfJhOhGV4G
s2olHoUERuJmdIjF0DLGuIGtOglR/9dBT4YlOjw44GIi7n7kFB7Lz2sGBaH4QmV21gnQAPRQ
1Rf2fI9b+K0htlzHmZW5GH+7JjylqKbDUwt3RKJgy1iEsrhd9nNod1siCky/N9iHOouVcX9g
dmt2LF2E2D75skn/+ofOtkClz3u4Jn6QW8zd4+bwwF3CTdp65JolWoNwtAtm7zK/8f2LMWjX
NIxP2Zz/EjFuaxVWnW8f3PElCpGDFi4MOYjimuuhBGKC+WCRerAkw23AY0jRE3XuQcAKiwKT
Fpocjjilek53j8/AAv1x3D5uRuvvm/WPA6GudfmeWwA9FDjQXNCxMCU+NUHnL38SmgnhIpBr
wuXMK9LPHz+cXdi7KF96JepxE0FcCL2AGvYEl75JiH4xQCHQJ5DdznrYwMFQ+j+QuBN0GzLd
Om0IjRTYgNhyDW7SFlJyy1no3bRp0nhFze/OrvUW2xyNYPPt5eEBeQgj4qmlwkFLYBSI7Hiy
9kBLk1q2mV1vrgOLoOBvnpMel31L6d5rsHOw9lh0/lODIFMpqj5azX3DXJ0aszkdOHHhvELr
bIGP0w0iopw4jprJM4XG6VIcUWomG3+BDeHKOoEp311gYkxrpBQ8703JHDVWmAb6tDjam/Ib
v5lFeiMkTpYjeTq57o0Hq2n4lrSrT8U0kM9GsvTBYgw+cNKLZKwVkIg/ynbPh3ejGGSCl2e9
5ycrnZzbWAkQ05Dt7mc14OD4KlGHnSJIA/EOyOrqs+lLnUWUVbHOYZSVnC5DA5eTOsXQtCU/
8bNb1rfwBKeEIro34dnFNRda3Gwzdlq73toiAxmbipmchq2EwTTZXzucuZsw7Ccq0/IGGph0
B/rNAQQ5cjp9N3p8OW7+2cB/Nsf1+/fv3w6vhS7rsOtoMIY0/Q39aiPFrAyF20IjaHYHjil8
pwOteR4hdqxlZPhm6SEGNlSFMbqH/E67aWZ68K9wRf/HJBtt45UExG1Zp2j0jjkWB47ivc+7
0YRMOKdNtum71XE1Qrq9bpPQ9ydJCV/b0NxX4KWL0tJrkAqF6NREi9NlgGHdgf0paubNyjpu
wif1e/ULmD8Mm2crkbQ1kV/zlxAA8MKP5NVHjFe3CCGh0k6EhrclxxS2NkvW+PpfBlRL8yeF
bJKrMfXTIlyqlEKKv6UozdZwip62u8MZR7N0YgXN+Zp8aL+CKQVUOnMa0UZ/95/NfvWwsfRu
dSqIwO3eQc6XAud+0Vwci6wVOyyOfVHCfYgJ23UkCFPrWdQpUk5aWaQZfavM+CYQzAv0VQGn
BG4owSOYUDD5AhqyyhhifbTUboJXAOVx7L4xprxwwFGIBgEoQ8NIEYvsEeBWXrobazLwivBW
JhWopfnhk3COCcQcM6OlUa3FFEJzNHilL2hECeEGMCrBRoMQaHvz+iWCa0nZCYddKzjZE0Zd
9+1kTOjcKwpBpCQ4PmlHccb7HRNGAft8QmGwHBMu+X0QVAX8O73e6TeOYwBfLyWyIvjUkfhZ
T06JQpek1NZ95K7lieGoTFDEl2zvIwUcOYxTSg5tbSd6ZXaMVpb/m+1ISnjxcUFvySRz7Adg
/30PtqWzE2RzBDLaNiIiAExkZZxEfKAY1/qe/wEZ1CmdK5cAAA==

--mYCpIKhGyMATD0i+--
