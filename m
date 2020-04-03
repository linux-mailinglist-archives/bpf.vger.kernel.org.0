Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346DD19DA15
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404000AbgDCP2V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Apr 2020 11:28:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56187 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgDCP2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Apr 2020 11:28:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so7547530wmg.5
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2020 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=incline-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=E3R8/wdMI2XU0al/0yoO9m2yujlpwOPmAf4P3KfORek=;
        b=sdGOcc3hVB60updmwFGCYEmW6KYUO1jkCZvJrS//Jpcr7Pqh0lihezNaPqzf1XLzp3
         Id6T5Vg6PT/FfHFl8RcARDvcz8l5oCPpsOqldixKe53mOnzletAbBtexQW7TRgNRnUJ4
         hALHvK/vlC2klY9gEBWFa5kjSsnBPfZoCKP1cNELZ4h4ICypGdHi7x117ZkiXxgTVj0N
         4tmO6CAy9tIUPtv4hzjEsxZwUPgrHTtksQhiBjPbNjjctx/I4GkHjUxPO8Cg0yDbQksS
         +iF3Kuqkq9khSrwbj0aC9+fvR79FZg9bxc8UtWRbJfud2y6MHQ2iedvbmQSAYIcNE4Uq
         gZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E3R8/wdMI2XU0al/0yoO9m2yujlpwOPmAf4P3KfORek=;
        b=ud5wkIedPSx02nY8D321/E+/LXsQRd4wAYvZctoyZNcajEpnBiK7sRupIed0Lsm4hW
         SoyRQ9rSp+YGcAFat/qG0KQXXK5Fm1DK7W//g6i4GJ5Wu1y1EqyyPuiy1JPvvk5L0BkV
         f922KPTSg6/WFw4QG8qZ+BKC8Ack+k2DMd021Q7H5zP/dDV40Vn0K8IyMkeiKVFfuenN
         aW4ktyTmnP79FLY8PrX/I8SxwrkodwP2Ap89xNSNBRLPrPei83scgnAORxZBVqSyqIsN
         4JQ3/eNz6AvX0Ncl6dzQlBGu68n1b8rW1qeMVRMORkfHvhSfRLXBme6x0h/V1b3lJpmB
         Vj4A==
X-Gm-Message-State: AGi0PubKseue6BBQ9/aZX+jU/42FaOF44nq7VShEa+I7FWfrNiorbLzQ
        YwzPwRFWLV5jZrtR/fElsygtxwT+wL/3ig==
X-Google-Smtp-Source: APiQypLLz1lflCmsAbNi9i041x9l+bHhMahvuggTg8Aw1quMKI9Bp4muSEodmst1w+MxKAagcUyR4w==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr9339278wml.104.1585927698280;
        Fri, 03 Apr 2020 08:28:18 -0700 (PDT)
Received: from ?IPv6:2a02:1811:51a:b600:ace:32fb:ad63:b5b? (ptr-7u1g92dm5ip8miek4t7.18120a2.ip6.access.telenet.be. [2a02:1811:51a:b600:ace:32fb:ad63:b5b])
        by smtp.gmail.com with ESMTPSA id l12sm12229717wrt.73.2020.04.03.08.28.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 08:28:17 -0700 (PDT)
Subject: Re: arm6/7: pointers wrongly treated as 64 bits wide?
To:     bpf@vger.kernel.org
References: <CANgQc9iPidNLReQpdjyZy-1Ac-nZ+wKr0E_NZ50UCwRSqe6_VQ@mail.gmail.com>
From:   Timo Beckers <timo@incline.eu>
Message-ID: <2e2c44a2-3c22-3dd4-af9b-f9abf9371a48@incline.eu>
Date:   Fri, 3 Apr 2020 17:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANgQc9iPidNLReQpdjyZy-1Ac-nZ+wKr0E_NZ50UCwRSqe6_VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I ended up solving this.

Found a similar thread: 
http://lists.llvm.org/pipermail/llvm-dev/2017-October/118151.html.
Looks like clang always needs to be called with '--target=bpf'.

I presume generating IR against other architectures only happens to work
when they're 64-bit. llc will happily emit correct bpf when called with 
'-march=bpf'.

There seems to be some misinformation out there around this topic.
The Cilium BPF/XDP Reference Guide has correct examples.

When I initially ran with '--target=bpf', some includes started failing, 
mostly due to
asm definitions or macros. Those need to be gated off, and the ways of 
doing so
will vary greatly depending on which headers are included by your BPF 
program.

Stay safe.

Timo

On 4/2/20 6:27 PM, Timo Beckers wrote:
> Hi all,
>
> I've been trying to get my BPF program to run on arm6/7 targets
> (an RPi 3 and an ODroid XU4), but I'm having trouble getting it past
> the verifier.
>
> It's been a great learning experience, but after not making any progress for
> a couple of days, I think I'm ready to blame the compiler. :(
>
> Some background info:
> - Builds are run on an x86 machine (5.5.10-arch1-1)
> - Using clang+llc version 9.0.1
> - Target board: RPi 3 (armv6l) 4.19.108-1-ARCH, running alarm
> - Builds run against fresh mainline sources prepared with `ARCH=arm
> CROSS_COMPILE=arm-linux-gnueabi- make defconfig prepare`
> - Link to the full version of the program:
> https://github.com/ti-mo/conntracct/blob/arm-builds/bpf/acct.c
> - The program builds and runs fine on anything x86 (don't have any
> arm64 around to test)
>
> clang itself is run as follows (-W arguments omitted):
>
> clang -D__KERNEL__ -D__BPF_TRACING__ \
>      -fno-stack-protector \
>      -O2 -emit-llvm \
>      -c acct.c \
>      -I%s/include \
>      -I%s/include/uapi \
>      -I%s/arch/arm/include \
>      -I%s/arch/arm/include/uapi \
>      -I%s/arch/arm/include/generated \
>      -I%s/arch/arm/include/generated/uapi \
>      --target=armv7-linux-gnueabihf \
>      -o - | llc -march=bpf -filetype=obj -o acct.o
>
> Inspired by this blog post:
> https://www.collabora.com/news-and-blog/blog/2019/05/06/an-ebpf-overview-part-4-working-with-embedded-systems.
>
> ---
>
> The verifier complains as follows:
>
> program kretprobe____nf_ct_refresh_acct: can't load program:
> permission denied: 0: (bf) r6 = r1
> ...
> 20: (85) call bpf_map_lookup_elem#1
> 21: (15) if r0 == 0x0 goto pc+276
>   R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R6=ctx(id=0,off=0,imm=0)
> R9=inv(id=0) R10=fp0,call_-1 fp-112=0
> 22: (7b) *(u64 *)(r10 -240) = r6
> 23: (7b) *(u64 *)(r10 -248) = r9
> 24: (61) r7 = *(u32 *)(r0 +4)
>   R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R6=ctx(id=0,off=0,imm=0)
> R9=inv(id=0) R10=fp0,call_-1 fp-112=0 fp-240_w=ctx
> invalid access to map value, value_size=4 off=4 size=4
> R0 min value is outside of the array range
>
> The annotated objdump looks like:
>
> ;   ctp = bpf_map_lookup_elem(&currct, &pid);
>        18:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>        20:       85 00 00 00 01 00 00 00 call 1
> ;   if (ctp == 0)
>        21:       15 00 14 01 00 00 00 00 if r0 == 0 goto +276 <LBB1_51>
>        22:       7b 6a 10 ff 00 00 00 00 *(u64 *)(r10 - 240) = r6
>        23:       7b 9a 08 ff 00 00 00 00 *(u64 *)(r10 - 248) = r9
> ;   struct nf_conn *ct = *ctp;
>        24:       61 07 04 00 00 00 00 00 r7 = *(u32 *)(r0 + 4)
>        25:       61 06 00 00 00 00 00 00 r6 = *(u32 *)(r0 + 0)
>        26:       bf a2 00 00 00 00 00 00 r2 = r10
>        27:       07 02 00 00 80 ff ff ff r2 += -128
> ;   bpf_map_delete_elem(&currct, &pid);
>        28:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>        30:       85 00 00 00 03 00 00 00 call 3
>        31:       b7 01 00 00 00 00 00 00 r1 = 0
> ;   struct acct_event_t data = {
>        32:       7b 1a 28 ff 00 00 00 00 *(u64 *)(r10 - 216) = r1
> ...zeroing the struct...
>        44:       7b 9a 20 ff 00 00 00 00 *(u64 *)(r10 - 224) = r9
>        45:       63 6a 28 ff 00 00 00 00 *(u32 *)(r10 - 216) = r6
> ;   struct nf_conn *ct = *ctp;
>        46:       67 07 00 00 20 00 00 00 r7 <<= 32
>        47:       4f 67 00 00 00 00 00 00 r7 |= r6
> ;   bpf_probe_read(&ct_ext, sizeof(ct_ext), &ct->ext);
>        48:       bf 78 00 00 00 00 00 00 r8 = r7
>        49:       07 08 00 00 a0 00 00 00 r8 += 160
>        50:       bf a1 00 00 00 00 00 00 r1 = r10
>        51:       07 01 00 00 90 ff ff ff r1 += -112
>        52:       b7 02 00 00 04 00 00 00 r2 = 4
>        53:       bf 83 00 00 00 00 00 00 r3 = r8
>        54:       85 00 00 00 04 00 00 00 call 4
> ;   if (!ct_ext)
>        55:       79 a3 90 ff 00 00 00 00 r3 = *(u64 *)(r10 - 112)
>        56:       55 03 01 00 00 00 00 00 if r3 != 0 goto +1 <LBB1_6>
>        57:       05 00 f0 00 00 00 00 00 goto +240 <LBB1_51>
>
> ---
>
> A couple of lines down, `struct nf_conn *ct` is passed to a function
> `extract_counters(&data, ct)`. Interestingly, when I remove this statement
> along with the remainder of the function, the erroneous access to r0 + 4 is
> no longer emitted. Only r0 + 0 remains, as it should, and the probe clears
> the verifier and runs as expected.
>
> The compiler is clearly aware it's targeting a 32-bit architecture because
> it treats the return value of bpf_map_lookup_elem() as a u32. However, if the
> result is dereferenced and later passed to a function as a pointer, it's
> incorrectly considered as being 64 bits wide.
>
> I've noticed this problem manifests itself in different ways while trying to
> work around this, always when it comes to working with pointers. This is
> the clearest example I could generate.
>
> Any ideas as to what I'm doing wrong? Could this be a bug in clang/LLVM?
>
> Timo
>
