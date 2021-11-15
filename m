Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5695F4501A5
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKOJvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 04:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhKOJvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 04:51:03 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89433C061746
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 01:48:07 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t19so33710593oij.1
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 01:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2+LfxA4FQQFUdmUvKbbLf6gticj20GUOpMCO+fhLvag=;
        b=kURAD2cd7dQ0vcQ9GXarlyrXguF4TkYcd6EMXBKmC/UTWNE6HVqJeFURcNnYkkQkPQ
         5k5nEWyb8Kocf4mNdqHJqsBbNA9EVizcwmBiKcA1eQmz5rV2AIDUH/EBMLOhpsWResTI
         RLCtvTqmr22rZ8cLHWvJm8J2iUJdlq8ZheF2s0aGdJVDLYVBrmX5n+YmgnkIiurL/g0j
         CrjVKuuWMUnef9w3Rd+a8QA5CsmKEBxUnrUop2E4dfJRgOiCateAvsrTry/M2yiYsdh1
         beG+Sseryastc7S8RrtalD09Rm73eD9Mfcuv89OcfDVfenONzAKg9Izn93Z/WGtqJ8T8
         fg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2+LfxA4FQQFUdmUvKbbLf6gticj20GUOpMCO+fhLvag=;
        b=yYMF/FcfQ7M+XA7+dbA/I2GX8OK02ThwfjM9uhDZcx1ulhGEzglTXUTd9+xa7OEyMp
         WlXxRVHShLg8CSaf0pUemkj1egSUsswJQVaJf2NfhMUPmhWSpiwifgh9cebrZkHUeQf7
         c9JaNfvY5kg2CHHsWb3zkrt5bXcwQezCwm4AhuO7N2SIApX+gVzw1X+GQQ2/JoTfw0Wj
         xGX+GFu0Nzbv/EDbrhxAeKZvJpcoWKIzov2GePjT1GPx5/GT/qaJ5oeDFKZEK/+3TFNl
         rRYqGRQja/KG3xpHEylu/PFEHlKJF/V3LhQ03LW7Ju8jxmzQrmA99GW1+AgePxYIxI2e
         uMFQ==
X-Gm-Message-State: AOAM532hm6y/C9NSmD/o2Yo2dHClgm7/V44idWWT+Xkpu7WdpkTTFzNG
        XeplGhJONBGvvK/nub7Udjr/COeaQtBel9aVSJM=
X-Google-Smtp-Source: ABdhPJzL9zUB63HGi/O6hT8oVCZLaEDTyvsrgJQbkc+Ml3iDsPMC4ftdKSty2+5v2ir9HPaclPpM0VCdP4BEjIYutv0=
X-Received: by 2002:aca:ab87:: with SMTP id u129mr30596785oie.42.1636969686701;
 Mon, 15 Nov 2021 01:48:06 -0800 (PST)
MIME-Version: 1.0
From:   Pony Sew <poony20115@gmail.com>
Date:   Mon, 15 Nov 2021 17:47:55 +0800
Message-ID: <CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com>
Subject: Custom 'hello' BPF CO-RE example failed on Debian 10 again for some reason
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,
This (https://github.com/sartura/ebpf-core-sample) is the code I'm using.
But I add " #define BPF_NO_GLOBAL_DATA 1 " on 'hello.bpf.c' so that
Debian 10 is able to execute it.
Compiled on default Debian11 amd64 environment with clang package
installed from mirror source.
Both 'hello' and 'maps' used to work on Debian10 about a month ago.
But 'hello' now can't. I'd like to improve this result.
-----------------------------------------------------------------------------------------
This is how I compiled them in steps:

# bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
# clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c hello.bpf.c -o
# hello.bpf.o
# bpftool gen skeleton hello.bpf.o > hello.skel.h
# clang -g -O2 -Wall -I . -c hello.c -o hello.o
# git clone https://github.com/libbpf/libbpf
# cd libbpf/src
# make BUILD_STATIC_ONLY=1 OBJDIR=../build/libbpf DESTDIR=../build
INCLUDEDIR= LIBDIR= UAPIDIR= install
# cd ../../
# clang -Wall -O2 -g hello.o libbpf/build/libbpf.a -lelf -lz -o hello

There was only one warning message: "libbpf: elf: skipping
unrecognized data section(4) .rodata.str1.1", which appeared during
the generation of 'hello.skel.h'. There are no other warning and error
messages during this whole 'hello' and 'maps' compilation.
-------------------------------------------------------------------------------------------------------------------
Result of executing 'hello' on default amd64 Debian10 environment:

libbpf: kernel doesn't support global data
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -95
failed to load BPF object -95
-------------------------------------------------------------------------------------------------------------------
From what I can remember, That warning message used to appear even
when I'm executing 'hello' on Debian10. But the BPF program work just
fine then. Maybe there is something else I can do?

Sincerely,
Poony.
