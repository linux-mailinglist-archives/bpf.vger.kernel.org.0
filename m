Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1118651FCE
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLTLh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 06:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTLhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 06:37:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDAB55AC
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 03:37:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so734004pjb.0
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 03:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WTy1R/nngHr8BZjjRfyTTGC+oDxjyezHRnSIyRBWd/g=;
        b=dR3HmFkUn0xKb1Fg1JZUYlppZ395je8l+Xqf4XDsSaQrS8cl90fXNEf5mFEf0uDjw1
         t0H/yRQtEuEHNgc5gl+oUlsamaC45ye4q3VRiDkZeMrk98sLR1DDElRBwIZC+ixLwZbv
         aeIDqJ084IF0GuDQmx7zviK9u09L5hDalHoKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTy1R/nngHr8BZjjRfyTTGC+oDxjyezHRnSIyRBWd/g=;
        b=4WInwkKtpW4YTy7sHDd2ah3QOgvrVYEYiLD/SkPJCfhRrRmyJ5e1mJh2OxxJ5UM5mt
         VuSttaNumsaosUwqgUMvzh7qB0+04JKHo0df5kDrIFudZXlAQ3JdWukWtG5Bqc0c+rlV
         yM+C9GfpPzB/TvxsTXxKQ4dV3/d28vEtK8ie68wByzOZKf2J9IxrArarKsa3HoK3d75u
         vehodd+wuQuMF+pTMFDzt6evexVoddus0IT4ZkQJcevjfvwAAMHID/ubORpmQDMJPP3p
         6KheN4SXxY8Bp1inNbYR4OHGTABMmjWM+smW4suer0BmI+TnBd/mKLc82p69Vv1vtAGC
         NE+Q==
X-Gm-Message-State: ANoB5pn1rQEDObkQufDFX5UThpLaE73w3iH0tV2YyBG8AcxQCZZgOjud
        FW3QOfQUmsGWfJ7x0a3Wma3HqA==
X-Google-Smtp-Source: AA0mqf5WsWKa47EHlANvI2IwrDkeYFSNW9tlLM1IhZ0HtMcpqplyexLGyXjJjjCRWnkr8uhNYpA91A==
X-Received: by 2002:a17:902:bf04:b0:189:c4a9:c5ee with SMTP id bi4-20020a170902bf0400b00189c4a9c5eemr44791904plb.32.1671536243821;
        Tue, 20 Dec 2022 03:37:23 -0800 (PST)
Received: from ubuntu ([121.133.63.188])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001868981a18esm9106624plj.6.2022.12.20.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:37:23 -0800 (PST)
Date:   Tue, 20 Dec 2022 03:37:18 -0800
From:   Hyunwoo Kim <v4bel@theori.io>
To:     sdf@google.com
Cc:     keescook@chromium.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        syzbot+b1e1f7feb407b56d0355@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, v4bel@theori.io
Subject: Re: [report] OOB in bpf_load_prog() flow
Message-ID: <20221220113718.GA1109523@ubuntu>
References: <20221219135939.GA296131@ubuntu>
 <Y6C1SFEj9MOOnAnb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y6C1SFEj9MOOnAnb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 19, 2022 at 11:02:32AM -0800, sdf@google.com wrote:
> On 12/19, Hyunwoo Kim wrote:
> > Dear,
>=20
> > This slab-out-of-bounds occurs in the bpf_prog_load() flow:
> > https://syzkaller.appspot.com/text?tag=3DCrashLog&x=3D172e2510480000
>=20
> > I was able to trigger KASAN using this syz reproduce code:
> > ```
> > #define _GNU_SOURCE
>=20
> > #include <endian.h>
> > #include <stdint.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/syscall.h>
> > #include <sys/types.h>
> > #include <unistd.h>
>=20
> > #ifndef __NR_bpf
> > #define __NR_bpf 321
> > #endif
> > #ifndef __NR_sched_setattr
> > #define __NR_sched_setattr 314
> > #endif
>=20
> > uint64_t r[4] =3D {0xffffffffffffffff, 0xffffffffffffffff,
> > 0xffffffffffffffff, 0xffffffffffffffff};
>=20
> > int main(void)
> > {
> > 	syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> > 	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
> > 	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> > 	intptr_t res =3D 0;
> > 	*(uint32_t*)0x20000080 =3D 0;
> > 	syscall(__NR_sched_setscheduler, 0, 2ul, 0x20000080ul);
> > 	*(uint64_t*)0x200000c0 =3D 5;
> > 	syscall(__NR_sched_setaffinity, 0, 8ul, 0x200000c0ul);
> > 	*(uint32_t*)0x20001700 =3D 4;
> > 	syscall(__NR_sched_setscheduler, 0, 1ul, 0x20001700ul);
> > 	res =3D syscall(__NR_socketpair, 1ul, 0ul, 0, 0x20000200ul);
> > 	if (res !=3D -1) {
> > 		r[0] =3D *(uint32_t*)0x20000200;
> > 		r[1] =3D *(uint32_t*)0x20000204;
> > 	}
> > 	*(uint16_t*)0x2057eff8 =3D 0;
> > 	*(uint8_t*)0x2057effa =3D 0;
> > 	*(uint32_t*)0x2057effc =3D 0;
> > 	syscall(__NR_connect, r[0], 0x2057eff8ul, 0x6eul);
> > 	syscall(__NR_sendmmsg, r[1], 0x200bd000ul, 0x318ul, 0ul);
> > 	*(uint32_t*)0x20000040 =3D 0x38;
> > 	*(uint32_t*)0x20000044 =3D 0;
> > 	*(uint64_t*)0x20000048 =3D 0;
> > 	*(uint32_t*)0x20000050 =3D 0;
> > 	*(uint32_t*)0x20000054 =3D 0;
> > 	*(uint64_t*)0x20000058 =3D 0;
> > 	*(uint64_t*)0x20000060 =3D 0;
> > 	*(uint64_t*)0x20000068 =3D 0;
> > 	*(uint32_t*)0x20000070 =3D 0;
> > 	*(uint32_t*)0x20000074 =3D 0;
> > 	syscall(__NR_sched_setattr, 0, 0x20000040ul, 0ul);
> > 	syscall(__NR_getrlimit, 3ul, 0x200001c0ul);
> > 	*(uint32_t*)0x20000300 =3D 0x11;
> > 	*(uint32_t*)0x20000304 =3D 5;
> > 	*(uint64_t*)0x20000308 =3D 0x200000c0;
> > 	memcpy((void*)0x200000c0, "\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\xff\x00\x00\x00\x85\x00\x00\x00\x0e\x00\x00\x00\x85\x00\x00\x00\x50\x=
00\x00\x00\x95",
> > 33);
> > 	*(uint64_t*)0x20000310 =3D 0x20000100;
> > 	memcpy((void*)0x20000100, "syzkaller\000", 10);
> > 	*(uint32_t*)0x20000318 =3D 0;
> > 	*(uint32_t*)0x2000031c =3D 0;
> > 	*(uint64_t*)0x20000320 =3D 0;
> > 	*(uint32_t*)0x20000328 =3D 0;
> > 	*(uint32_t*)0x2000032c =3D 0;
> > 	memset((void*)0x20000330, 0, 16);
> > 	*(uint32_t*)0x20000340 =3D 0;
> > 	*(uint32_t*)0x20000344 =3D 2;
> > 	*(uint32_t*)0x20000348 =3D -1;
> > 	*(uint32_t*)0x2000034c =3D 8;
> > 	*(uint64_t*)0x20000350 =3D 0;
> > 	*(uint32_t*)0x20000358 =3D 0;
> > 	*(uint32_t*)0x2000035c =3D 0x10;
> > 	*(uint64_t*)0x20000360 =3D 0;
> > 	*(uint32_t*)0x20000368 =3D 0;
> > 	*(uint32_t*)0x2000036c =3D 0;
> > 	*(uint32_t*)0x20000370 =3D 0;
> > 	*(uint32_t*)0x20000374 =3D 0;
> > 	*(uint64_t*)0x20000378 =3D 0;
> > 	res =3D syscall(__NR_bpf, 5ul, 0x20000300ul, 0x80ul);
> > 	if (res !=3D -1)
> > 		r[2] =3D res;
> > 	*(uint64_t*)0x20000200 =3D 0;
> > 	*(uint32_t*)0x20000208 =3D r[2];
> > 	syscall(__NR_bpf, 0x11ul, 0x20000200ul, 0x10ul);
> > 	res =3D syscall(__NR_socket, 0xaul, 0x80003ul, 7);
> > 	if (res !=3D -1)
> > 		r[3] =3D res;
> > 	*(uint16_t*)0x20000040 =3D 0xa;
> > 	*(uint16_t*)0x20000042 =3D htobe16(0);
> > 	*(uint32_t*)0x20000044 =3D htobe32(0);
> > 	*(uint8_t*)0x20000048 =3D -1;
> > 	*(uint8_t*)0x20000049 =3D 1;
> > 	memset((void*)0x2000004a, 0, 13);
> > 	*(uint8_t*)0x20000057 =3D 1;
> > 	*(uint32_t*)0x20000058 =3D 4;
> > 	syscall(__NR_connect, r[3], 0x20000040ul, 0x1cul);
> > 	*(uint32_t*)0x200054c0 =3D 0xa;
> > 	*(uint32_t*)0x200054c4 =3D 0x16;
> > 	*(uint64_t*)0x200054c8 =3D 0x20001340;
> > 	memcpy((void*)0x20001340, "\x61\x15\x50\x00\x00\x00\x00\x00\x61\x13\x5=
0\x00\x00\x00\x00\x00\xbf\xa0\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x08\x=
00\x00\x00\x2d\x03\x01\x00\x00\x00\x00\x00\x95\x00\x00\x00\x00\x00\x00\x00\=
x69\x16\x00\x00\x00\x00\x00\x00\xbf\x67\x00\x00\x00\x00\x00\x00\x35\x03\x07=
\x00\x0f\xff\x07\x20\x67\x06\x00\x00\x02\x00\x00\x00\x16\x03\x00\x00\x0e\xe=
6\x00\x60\xbf\x05\x00\x00\x00\x00\x00\x00\x5f\x65\x00\x00\x00\x00\x00\x00\x=
65\x07\xf9\xff\x01\x00\x00\x00\x07\x07\x00\x00\x4d\xdf\xff\xff\x1e\x75\x00\=
x00\x00\x00\x00\x00\xbf\x54\x00\x00\x00\x00\x00\x00\x07\x04\x00\x00\x04\x00=
\xf9\xff\xad\x43\x01\x00\x00\x00\x00\x00\x95\x00\x00\x00\x00\x00\x00\x00\x1=
5\x00\x00\x00\x00\x00\x00\x00\x95\x00\x00\x00\x00\x00\x00\x00\x32\xed\x3c\x=
12\xdc\x8c\x27\xdf\x8e\xcf\x26\x4e\x0f\x84\xf9\xf1\x7d\x3c\x30\xe3\x2f\x17\=
x54\x55\x8f\x22\x78\xaf\x6d\x71\xd7\x9a\x5e\x12\x81\x4c\xb1\xd8\xa5\xd4\x60=
\x1d\x29\x5c\x45\xa6\xa0\xb9\xbd\xb7\xdd\x39\x97\x03\xca\xc4\xf6\xf3\xbe\x4=
b\x36\x92\x89\xaa\x68\x12\xb8\xe0\x07\xe7\x33\xa9\xa4\xf1\xb0\xaf\x3d\xda\x=
82\xee\x45\xa0\x10\xfb\x94\xfe\x9d\xe5\x7b\x9d\x8a\x81\x42\x61\xbd\xb9\x4a\=
x05\x00\x00\x00\xc6\xc6\x0b\xf7\x0d\x74\x2a\x81\x76\x2b\xab\x83\x95\xfa\x64=
\x81\x0b\x5b\x40\xd8\x93\xea\x8f\xe0\x18\x54\x73\xd5\x1b\x54\x6c\xad\x3f\x1=
d\x5a\xb2\xaf\x27\x54\x6e\x7c\x95\x5c\xce\xfa\x1f\x6a\xb6\x89\xb5\x55\x20\x=
2d\xa2\xe0\xec\x28\x71\xb4\xa7\xe6\x58\x36\x42\x9a\x52\x7d\xc4\x7e\xbe\x84\=
xa4\x23\xb6\xc8\xd3\x45\xdc\x8d\xa3\x08\x5b\x0a\xb7\x1c\xa1\xb9\x01\x62\x7b=
\x56\x2e\xd0\x4a\xe7\x60\x02\xd4\x51\x9a\xf6\x19\xe3\xcc\xa4\xd6\x9e\x0d\xe=
e\x5e\xb1\x06\x77\x4a\x8f\x3e\x69\x16\xdf\xec\x88\x15\x8f\x02\x00\x00\x00\x=
00\xc8\xfb\x73\x0a\x5c\x1b\xf2\xb2\xbb\x71\xa6\x29\x36\x19\x97\xa7\x5f\xd5\=
x52\xbd\xc2\x06\x43\x8b\x8e\xf4\x90\x1f\xd0\x3c\x16\xdf\xda\x44\x22\x1b\x23=
\x5c\x8a\xc8\x6d\x8a\x29\x7d\xff\x04\x45\xa1\x5f\x21\xdc\xe4\x31\xe5\x67\x2=
3\x88\x8f\xb1\x26\xa1\x63\xf1\x6f\x92\x0a\xe2\xfb\x49\x40\x59\xbb\xa8\xe3\x=
b6\x80\x32\x4a\x18\x80\x76\xeb\x68\x5d\x55\xc4\xe9\xb2\xad\x9b\xc1\x17\x2b\=
xa7\xcb\xeb\xe1\x74\xab\xa2\x10\xd7\x39\xa0\x18\xf9\xbb\xec\x63\x22\x2d\x20=
\xce\xca\xc4\xd0\x37\x23\xf1\xc9\x32\xb3\xa6\xaa\x57\xf1\xad\x2e\x99\xe0\xe=
6\x7a\xb9\x37\x16\xd2\x00\x00\x00\x9f\x0f\x53\xac\xbb\x40\xb4\xf8\xe2\x73\x=
82\x70\xb3\x15\x62\xed\x83\x4f\x2a\xf9\x77\x87\xf6\x96\x64\x9a\x46\x2e\x7e\=
xe4\xbc\xf8\xb0\x7a\x10\xd6\x73\x51\x54\xbe\xb4\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x40\x00\xbc\x00\xf6\x74\x62\x97\x09\xe7\xe7\x8f\x4=
d\xdc\xfd\xed\x41\xf6\xe2\x52\x0a\x21\x1b\xc3\xeb\xe6\xbd\x9d\x42\xca\x01\x=
40\xa7\xaf\xaa\xb4\x31\x76\xe6\x5e\xc1\x11\x8d\x50\xd1\xe8\x27\xf3\x47\x2f\=
x44\x45\xd2\x53\x88\x7a\x5a\xd1\x03\x64\x9a\xfa\x17\x69\x08\x84\xf8\x00\x03=
\x1e\x03\xa6\x51\xbb\x96\x58\x9a\x7e\x2e\x50\x9b\xcc\x1d\x16\x13\x47\x62\x3=
c\xb5\xe7\xac\x46\x29\xc8\xab\x04\x87\x1b\xc4\x72\x87\xcd\x31\xcc\x43\xea\x=
0f\xfb\x56\x7b\x40\x40\x7d\x00\x00\x00\x21\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x5f\x37\xd8\x3f\x84\xe9\x8a\x52\x3d\x80\xbd\x97\x0d\x70\x3f\x37\xca\x36=
\x4a\x60\x1a\xe8\x99\xa5\x67\x15\xa0\xa6\x2a\x34\xc6\xc9\x4c\xce\x69\x94\x5=
2\x16\x29\xab\x02\x8a\xcf\xc1\xd9\x26\xa0\xf6\xa5\x48\x0a\x55\xc2\x2f\xe3\x=
a5\xac\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc1\xeb\=
x2d\x91\xfb\x79\xea\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\xe4\x00\x7b\xe5\x11\xfe\x32\xfb\xc9\x0e\x23\x64\xa5\x5=
e\x9b\xb6\x6a\xc6\x44\x23\xd2\xd0\x0f\xea\x25\x94\xe1\x90\xde\xae\x46\xe2\x=
6c\x59\x6f\x84\xeb\xa9\x00\x00\x00\x00\x00\x00\x00\x00\xff\xfb\x00\x00\x00\=
x00\x82\xfb\x0d\x3c\xc3\xaa\x39\xee\x4b\x13\x86\xba\xb5\x61\xcd\xa8\x86\xfa=
\x64\x29\x94\xca\xcd\x47\x3b\x54\x3c\xcb\x5f\x0d\x7b\x63\x92\x4f\x17\xc6\x7=
b\x13\x63\x1d\x22\xa1\x1d\xc3\xc6\x93\x96\x28\x95\x49\x6d\x4f\x6e\x9c\xc5\x=
4d\xb6\xc7\x20\x5a\x6b\x06\x8f\xff\x49\x6d\x2d\xa7\xd6\x32\x7f\x31\xd7\x3f\=
xcc\x5d\x32\x5c\x53\x79\xb0\x36\x3c\xe8\xbd\x1f\x61\xb0\x07\xe1\xff\x5f\x1b=
\xe1\x96\x9a\x1b\xa7\x91\xad\x46\xd8\x00\x00\x00\x00\xc7\xf2\x6a\x03\x37\x3=
0\x2f\x3b\x41\xea\xe5\x98\x09\xfd\x05\xd1\x2f\x61\x06\xf1\x17\xb0\x62\xdf\x=
67\xd3\xa6\x47\x32\x65\xdd\x14\x10\xee\xa6\x82\x08\xa3\xf2\x6b\x29\x89\xb8\=
x32\xd8\xb3\x4a\x34\xa4\xf0\x8b\x34\xb3\x04\x20\x65\xac\xaa\x10\x85\x6e\x85=
\x8d\x27\xad\xee\x7d\xaf\x32\x90\x3d\x3f\xc7\x87\x00\xd4\x29\xa2\xd4\xc8\xb=
6\xd8\x03\xeb\x83\xee\xcf\xe4\xc7\xff\x9e\x6a\xb5\xa5\x2e\x83\xd0\x89\xda\x=
d7\xa8\x71\x0e\x02\x54\xf1\xb1\x1c\xce\xd7\xbc\x3c\x8d\xa0\xc4\x4d\x2e\xbf\=
x9f\x6f\x3f\xf3\xbe\x4d\x14\x58\x07\x7c\x22\x53\xb0\xc7\xc7\xa0\xa9\xfd\xd6=
\x3b\xf9\x10\xdc\x20\xe5\xcb\x2a\x88\xe5\x9f\xeb\xc4\x7f\x12\x12\xa2\x1f\x6=
3\x1d\xba\xa7\x4f\x22\xba\xd0\x50\xe9\x85\x6b\x48\xae\x3a\x03\xa4\x97\xc3\x=
77\x58\x53\x76\x50\xfe\x6d\xb8\x9d\xa3\xc4\x1f\xdc\x3d\x78\xe0\x46\xf6\x16\=
x0e\x17\x41\x29\x9e\x8d\xc2\x99\x06\x87\x0e\x64\x31\xed\x1e\xab\x5d\x06\x7a=
\x18\x3f\x06\x4b\x06\x0a\x8e\xc1\x27\x25\xd4\x2e\x3a\x74\x86\x3d\x66\xbe\xe=
9\x66\xb1\x57\x4f\x8e\x01\xb3\xf3\x4a\x26\x7f\xf0\xaf\xa1\xe1\xc7\x58\xa0\x=
07\x9b\x74\x70\x67\x31\x2e\x98\x15\xa2\x1c\xb3\xf1\xf8\x15\x0d\x99\x9d\x78\=
x85\x4c\xa4\xd3\x11\x6d\xbc\x7e\x2b\xf2\x40\x2a\x75\xfd\x7a\x55\x73\x33\x60=
\x04\x08\x55\xed\x5d\x1c\x0d\x63\x4f\xc5\xfb\x38\xf8\x4d\x9d\x87\xb2\x7f\x8=
a\x5d\x91\x21\x7b\x72\x8f\x13\xe3\xee\x20\xe6\x9e\x0f\xfb\x27\x80\xb1\xa7\x=
af\x13\x7f\xf7\xb4\xff\x13\x96\x04\xfa\xf0\x45\x3b\x65\x58\x6f\x65\xc7\x94\=
x3d\x54\xb5\x2f\x06\xc8\x70\xed\xf0\xc5\xd7\x44\xb5\x27\x2b\x44\xc2\x34\x88=
\xb2\xbd\xbf\xf9\x47\xc4\xdf\xa1\x08\xcb\xb8\x82\x02\xee\xb8\x1f\x42\x8a\x5=
b\x3c\x29\x98\x48\x64\x9e\x1a\x57\xff\x52\xf6\x57\xa6\x74\x63\xd7\xdb\xf8\x=
5a\xe9\x32\x1f\xc2\xcc\x17\xdc\x4a\x29\xb9\xcb\xa8\xde\xd5\xde\x82\x06\xc8\=
x12\x43\x9a\xb1\x29\xae\x81\x88\x37\xee\x15\x62\x07\x89\xc5\x24\xb3\xba\xf4=
\x9a\x0b\xe9\xbb\x7d\x95\x8d\x5e\x87\xc6\xc0\x9b\xf7\x1a\x89\x4b\xad\x62\x9=
3\x47\x82\xcc\x30\x8e\x93\x6d\x76\x37\xe0\x7c\x4a\x2b\x3b\xc8\x7b\x0d\xa2\x=
00\x00\xd9\xef\x41\x8c\xf1\x9e\x7a\x8c\x4c\x32\x8b\xe0\xce\x91\x79\x8a\xdc\=
x2d\xca\x87\xdd\xd9\xd0\x64\xe0\x4b\x6f\x02\x75\x86\x6d\x1a\x1d\x1c\x76\x1e=
\x2c\x29\xff\x66\x30\xb7\xc4\xb3\x17\xbb\xfa\x70\xe4\x68\x29\xdc\xab\x47\x4=
1\x78\xda\x43\xaa\xcd\x93\xbd\xb9\x19\x72\xdb\xa1\x8c\x81\x15\xe6\x15\x29\x=
cd\x7c\x42\x30\x45\x23\xc8\xdb\x52\x1d\x17\x33\x0f\x8a\x14\x49\x0f\x56\x83\=
x91\x52\x44\x19\xcb\x53\x9c\x26\x65\x7c\x38\xbd\xe4\x12\xee\x11\xd5\x2b\xba=
\x48\xcf\x45\x55\x09\xe2\x5b\x0a\x3f\x38\x77\x73\x71\x20\xab\x9c\x1e\xd5\x9=
5\x2c\x82\x45\x96\x01\x0c\xb2\x56\x78\xb7\x9f\x08\x1c\x44\x6b\xb4\x13\x6e\x=
c1\xde\xa6\x6a\x6a\xad\x69\x4f\x77\x02\xc3\x93\xc6\x1e\x38\xf1\x88\xa5\x9e\=
xb8\x08\xf5\x55\xe4",
> > 1628);
> > 	*(uint64_t*)0x200054d0 =3D 0x20000100;
> > 	memcpy((void*)0x20000100, "GPL\000", 4);
> > 	*(uint32_t*)0x200054d8 =3D 0;
> > 	*(uint32_t*)0x200054dc =3D 0;
> > 	*(uint64_t*)0x200054e0 =3D 0;
> > 	*(uint32_t*)0x200054e8 =3D 0;
> > 	*(uint32_t*)0x200054ec =3D 0;
> > 	memset((void*)0x200054f0, 0, 16);
> > 	*(uint32_t*)0x20005500 =3D 0;
> > 	*(uint32_t*)0x20005504 =3D 0;
> > 	*(uint32_t*)0x20005508 =3D -1;
> > 	*(uint32_t*)0x2000550c =3D 8;
> > 	*(uint64_t*)0x20005510 =3D 0x20000000;
> > 	*(uint32_t*)0x20000000 =3D 0;
> > 	*(uint32_t*)0x20000004 =3D 0;
> > 	*(uint32_t*)0x20005518 =3D 0;
> > 	*(uint32_t*)0x2000551c =3D 0x10;
> > 	*(uint64_t*)0x20005520 =3D 0x20000000;
> > 	*(uint32_t*)0x20000000 =3D 0;
> > 	*(uint32_t*)0x20000004 =3D 0;
> > 	*(uint32_t*)0x20000008 =3D 0;
> > 	*(uint32_t*)0x2000000c =3D 0;
> > 	*(uint32_t*)0x20005528 =3D 0;
> > 	*(uint32_t*)0x2000552c =3D 0;
> > 	*(uint32_t*)0x20005530 =3D -1;
> > 	*(uint32_t*)0x20005534 =3D 0;
> > 	*(uint64_t*)0x20005538 =3D 0;
> > 	syscall(__NR_bpf, 5ul, 0x200054c0ul, 0x48ul);
> > 	return 0;
> > }
> > ```
>=20
> > IMHO, the root cause of this seems to be commit
> > ceb35b666d42c2e91b1f94aeca95bb5eb0943268.
>=20
> > Also, a user with permission to load a BPF program can use this OOB to
> > execute the desired code with kernel privileges.
>=20
> Let's CC Kees if you suspect the commit above. Maybe we can run
> with/without it to confirm?

I built and tested each commit of 'kernel/bpf/verifier.c' that caused=20
OOB, but I couldn't find the commit that caused OOB.

So, starting from upstream, I reversed commits one by one and=20
found the commit that triggers KASAN.

As a result of testing, OOB is triggered from commit=20
8fa590bf344816c925810331eea8387627bbeb40.

However, this commit seems to be a kvm related patch,=20
not directly related to the bpf subsystem.

IMHO, the cause of this seems to be one of these:
1. I ran this KASAN test on a nested guest in L2. That is,=20
there is a problem with the kvm patch 8fa590bf34481.

2. Previously, the BPF subsystem had a patch that triggers KASAN,=20
and KASAN is induced when kvm is patched.

3. There was confusion in the .config I tested, so the wrong=20
patch was derived as a test result.

I haven't been able to pinpoint what the root cause is yet.=20
So I didn't add a CC for 8fa590bf34481 commit.


Regards,
Hyunwoo Kim

>=20
> > Regards,
> > Hyunwoo Kim
