Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91917109324
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2019 18:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfKYRyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Nov 2019 12:54:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36827 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYRyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 12:54:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id y10so18163876qto.3
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2019 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zRrHaamSr+2Yy26kS9NjszBhSrczbY37SDoXVfFslKQ=;
        b=HuhVLRrG7Yr8kbRW9LdJ4017ZwhK/aXpilYttr+rqY+M9/p3kJsm7ioA1KsesjlkxL
         7rP+lbN45TP4kvZNc1X3xdGiXs8I7VuvGHZWDqgczgiCkEXziXfC/4Q5I4qwNuUKTVHK
         5a1Ex3zvsokRRmtzvfwZMiLtG5CvXhDxMa/RJbYG7udVvU7fPQciyoZoRZmtASSints/
         vd6Qj+9TRlL0mRj17ecpbrGZ0Uu2qzAmEe0GQCEfNBaLpWQBnt0UwqICxdQy/HvjXwRh
         OSW/7umI/M0umAUDMGu/fvPm9dMxxRub3qjuLKUTrCpVFLMSyIudvM6eJZUI+XkyrxIj
         gIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zRrHaamSr+2Yy26kS9NjszBhSrczbY37SDoXVfFslKQ=;
        b=tJe2MsdVxBhpFuUXTX9ybbK5nKzrmNQrcMc2pyvgq5WYFGrFKVYy8GXsGQpuUr/1iY
         4BHeu53wh9LHURsAo8daTiG+0XG0vx8Mk4ni9rMstmFdGZgaJYNzxuUzq2EOITt/mRiX
         TKmUkhm6R/yto82kRhnqT+fG1Ai5xVr+o/Hi9/z4Sfaoa4uK6RE4p0p2kfmYKTK4p468
         714PzAMvi6xO7FkvHxbwcjHeUOkwzk6nH12Tn9Z+csta287eBWUX7VCHCj6G97yGCv1k
         Kb6EZtp8JCBVJjDqZZPH2lTK2EfqyQ8LhCw/Xe3xtPXghFctsoBVge91OqP0/kRqWKK9
         iaWg==
X-Gm-Message-State: APjAAAXRhAoENShICNAYvk+afra+W28FYu8CFpqRWuB628WZvDU/mTCF
        lzWBPeLFXHm9BzpMZhoESkk8+3rWNpmbXlrsI6M=
X-Google-Smtp-Source: APXvYqySK22Ym1LnUq/zfAhlAQX0AdJrLJ9OTv45rCVb4SbpnqLZfs/9KEqqnknTRuqk6JzABOGUFuIEWEzsG869+es=
X-Received: by 2002:ac8:1387:: with SMTP id h7mr13385472qtj.59.1574704439273;
 Mon, 25 Nov 2019 09:53:59 -0800 (PST)
MIME-Version: 1.0
References: <201911231924.k1adA4Qy%lkp@intel.com> <baf09eb1-946b-fe04-6302-006654d594e0@fb.com>
 <1a9bdba3-ccbf-95d0-6033-467fa0f7eddd@intel.com>
In-Reply-To: <1a9bdba3-ccbf-95d0-6033-467fa0f7eddd@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Nov 2019 09:53:48 -0800
Message-ID: <CAEf4BzYRtUSfh4cRdmSmEFPEcp=S=0G6RKiAXFF9iA-1_4aS9g@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [linux-next:master 11808/13503]
 kernel/bpf/syscall.c:154: undefined reference to `vmalloc_user_node_flags'
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        kbuild test robot <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 24, 2019 at 11:43 PM Rong Chen <rong.a.chen@intel.com> wrote:
>
>
>
> On 11/24/19 1:37 AM, Andrii Nakryiko wrote:
>
> On 11/23/19 3:44 AM, kbuild test robot wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master
> head:   b9d3d01405061bb42358fe53f824e894a1922ced
> commit: fc9702273e2edb90400a34b3be76f7b08fa3344b [11808/13503] bpf: Add m=
map() support for BPF_MAP_TYPE_ARRAY
> config: arm-randconfig-a001-20191123 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>          wget https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__raw.=
githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=3DDwIBAg&c=
=3D5VD0RTtNlTh3ycd41b3MUw&r=3Dvxqvl81C2rT6GOGdPyz8iQ&m=3DOyqPkKr2ayhE9rsjQ3=
V9TjPHNWGAzMj67odoKch8_YM&s=3DJuUtGb4L_bH6ANKEMAgVL3zSBnFkOW4jhVP9W3WBHBM&e=
=3D  -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout fc9702273e2edb90400a34b3be76f7b08fa3344b
>          # save the attached .config to linux build tree
>          GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     arm-linux-gnueabi-ld: section .data VMA [0000000000808000,00000000008=
829bf] overlaps section .ARM.unwind_idx VMA [00000000007d7000,000000000080b=
8ef]
>     arm-linux-gnueabi-ld: section .ARM.unwind_tab VMA [000000000080b8f0,0=
00000000080febb] overlaps section .data VMA [0000000000808000,0000000000882=
9bf]
>     kernel/bpf/syscall.o: In function `__bpf_map_area_alloc':
>
> kernel/bpf/syscall.c:154: undefined reference to `vmalloc_user_node_flags=
'
>
> Can't repro this with given config on x86_64. Trying to make make.cross
> work for me still. Any ideas why this is happening?
>
>
> Hi Andrii,
>
> We can reproduce it with make.cross command.

Yeah, I was able to repro (and submitted fix already), once I realized
that out-of-source tree compilation wasn't supported.

>
> xsang@xsang-OptiPlex-9020:~/OLT-10114/linux-next$ GCC_VERSION=3D7.4.0 mak=
e.cross ARCH=3Darm
> make CONFIG_OF_ALL_DTBS=3Dy CONFIG_DTC=3Dy CROSS_COMPILE=3D/home/xsang/0d=
ay/gcc-7.4.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi- --jobs=3D16 AR=
CH=3Darm
> ...
>   CC      include/uapi/linux/netfilter/ipset/ip_set_hash.h.s
>   GEN     .version
>   CHK     include/generated/compile.h
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
>   MODINFO modules.builtin.modinfo
>   LD      .tmp_vmlinux1
> /home/xsang/0day/gcc-7.4.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi=
-ld: section .data VMA [0000000000808000,00000000008829bf] overlaps section=
 .init.text VMA [00000000007f4db0,0000000000814207]
> /home/xsang/0day/gcc-7.4.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi=
-ld: section .exit.text VMA [0000000000814208,0000000000817593] overlaps se=
ction .data VMA [0000000000808000,00000000008829bf]

These two were still happening, but even before my patch, so this must
be some other issue.

> kernel/bpf/syscall.o: In function `__bpf_map_area_alloc':
> /home/xsang/OLT-10114/linux-next/kernel/bpf/syscall.c:154: undefined refe=
rence to `vmalloc_user_node_flags'
> Makefile:1074: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
>
> Best Regards,
> Rong Chen
>
> I see that
> __vmalloc_node_flags_caller that we also use if #ifdef'ed as static
> inline in include/linux/vmalloc.h if no CONFIG_MMU is defined. Are we
> missing some config dependency or should I do the same trick as
> __vmalloc_node_flags_caller does?
>
> Also. Daniel, when I tried to build latest bpf-next with this config, I
> got another compilation error, related to your recent patch, you might
> want to take a look as well:
>
>    CC      kernel/tracepoint.o
>    CC      kernel/elfcore.o
> /data/users/andriin/linux/kernel/bpf/verifier.c: In function
> =E2=80=98fixup_bpf_calls=E2=80=99:
> /data/users/andriin/linux/kernel/bpf/verifier.c:9132:25: error: implicit
> declaration of function =E2=80=98bpf_jit_blinding_enabled=E2=80=99; did y=
ou mean
> =E2=80=98bpf_jit_kallsyms_enabled=E2=80=99? [-Werror=3Dimplicit-function-=
declaration]
>    bool expect_blinding =3D bpf_jit_blinding_enabled(prog);
>                           ^~~~~~~~~~~~~~~~~~~~~~~~
>                           bpf_jit_kallsyms_enabled
>    CC      kernel/irq_work.o
>    CC      kernel/crash_dump.o
>
> vim +154 kernel/bpf/syscall.c
>
>     129
>     130 static void *__bpf_map_area_alloc(size_t size, int numa_node, boo=
l mmapable)
>     131 {
>     132 /* We really just want to fail instead of triggering OOM killer
>     133 * under memory pressure, therefore we set __GFP_NORETRY to kmallo=
c,
>     134 * which is used for lower order allocation requests.
>     135 *
>     136 * It has been observed that higher order allocation requests done=
 by
>     137 * vmalloc with __GFP_NORETRY being set might fail due to not tryi=
ng
>     138 * to reclaim memory from the page cache, thus we set
>     139 * __GFP_RETRY_MAYFAIL to avoid such situations.
>     140 */
>     141
>     142 const gfp_t flags =3D __GFP_NOWARN | __GFP_ZERO;
>     143 void *area;
>     144
>     145 /* kmalloc()'ed memory can't be mmap()'ed */
>     146 if (!mmapable && size <=3D (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)=
) {
>     147 area =3D kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
>     148    numa_node);
>     149 if (area !=3D NULL)
>     150 return area;
>     151 }
>     152 if (mmapable) {
>     153 BUG_ON(!PAGE_ALIGNED(size));
>   > 154 return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
>     155       __GFP_RETRY_MAYFAIL | flags);
>     156 }
>     157 return __vmalloc_node_flags_caller(size, numa_node,
>     158   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>     159   flags, __builtin_return_address(0));
>     160 }
>     161
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.01.org_hyper=
kitty_list_kbuild-2Dall-40lists.01.org&d=3DDwIBAg&c=3D5VD0RTtNlTh3ycd41b3MU=
w&r=3Dvxqvl81C2rT6GOGdPyz8iQ&m=3DOyqPkKr2ayhE9rsjQ3V9TjPHNWGAzMj67odoKch8_Y=
M&s=3DzQax2z98Tn-V1wcH0rtwmJ0iA9DpFhqbVNzexx7wOWw&e=3D  Intel Corporation
>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
>
>
