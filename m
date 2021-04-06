Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DDB355B39
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbhDFSWf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbhDFSWd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 14:22:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5659EC061756
        for <bpf@vger.kernel.org>; Tue,  6 Apr 2021 11:22:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l1so7963253plg.12
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0RQ/HPJcBHKXW84UVqze3pyJyNv+txPaAWDVCQCoUQ=;
        b=LBbkasxXqQ/IqtFb12mMZe/4HfwrWM5ba61wDtVNHGT9ChcWXoj9GAcI1uMeQaPLXt
         WP6AqdqLnUiyPpHJ4EbQMnXWXa1pFjcQrLK14FV9rBOTAITujyeIajIvZY/LUbtixGNt
         ekmeLDzRXJPxuQLy+fxIb8RiIvo/5YReLoRlFwRzNA7qan6TQ2uw8p77Io3+1DoFym64
         x/EVn1IkQo+OLR2eBm4mt8hBX0HU8IRN4i5XLJgTxEfFgpp+jaN2pGBWPWLsKmXNnSDJ
         idme/zvwO6G8GIZABpg/jPgWfPm6Tp+Ms5OXETBqPoed6wCai/Qsy+feIShlhr5S3jg9
         QyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0RQ/HPJcBHKXW84UVqze3pyJyNv+txPaAWDVCQCoUQ=;
        b=FfuPEcvZC+WuUKg9Mj70ULjf0xVzD7g0LNbsKbhaaxSI4zNuZSv6EilUaB07rSmlCi
         n/tu+9vt3kCUvDAX85K+aU9/w8jBT3BeoRpxgP7Lupoy+DU0UeBIvlDTRi84i/6Bzkko
         nP1ZSlQTg9uo4EnBaZk2SUYHRxfmG3Q3YjI3sFA68M78Qmc25Yj/hHaTVsI+4pBf6HK4
         4lu+mD8Zvdw/R9mFGsmCvGOdvSIm1iOZipEzRJTqy3TPh1EWoPv5lOG7Ltdip6q6FFlI
         heUR73oJM+3J71zkETLAtpHa1A4YVm8BlqiGOXat9vwnBxx/e4fXH9doedXFzAOCsDDu
         xqrA==
X-Gm-Message-State: AOAM530Xs87Bcej+R+lY0waPBQ151FgaAeIUEYl72UloT0+6DNrxLX8v
        +UfyYekHpHJhoUxElDcQ/2BI9Cf3XrRUsHu40l0Qzg==
X-Google-Smtp-Source: ABdhPJxsZo1TkJNobBdpsBU4FMHfaHL5sG1OxZFg6v51vjPZR7gTLxw1Ep9EKowyT+MOQk8MxkWCBnBoVz0oEW0Ee2U=
X-Received: by 2002:a17:90a:1049:: with SMTP id y9mr5457835pjd.173.1617733344337;
 Tue, 06 Apr 2021 11:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com> <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org> <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org> <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org> <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
 <4eda63d8-f9df-71ab-d625-dcc4df429a89@fb.com> <YGyicDTUkPNhab4K@kernel.org> <CAENS6EvW8+oAa_DfN3LZsHmVkwA2WTb-TrcSf1FLEroyrnQXzQ@mail.gmail.com>
In-Reply-To: <CAENS6EvW8+oAa_DfN3LZsHmVkwA2WTb-TrcSf1FLEroyrnQXzQ@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Tue, 6 Apr 2021 11:22:12 -0700
Message-ID: <CAFP8O3JzEdRsKXF74yT0A26yCLhRT_s1+CpxRkqSctpEE=+wCg@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     David Blaikie <dblaikie@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>, Bill Wendling <morbo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 6, 2021 at 11:18 AM David Blaikie <dblaikie@gmail.com> wrote:
>
> On Tue, Apr 6, 2021 at 11:03 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Apr 06, 2021 at 10:48:22AM -0700, Yonghong Song escreveu:
> > >
> > >
> > > On 4/6/21 10:23 AM, Yonghong Song wrote:
> > > >
> > > >
> > > > On 4/6/21 10:03 AM, Arnaldo Carvalho de Melo wrote:
> > > > > Em Tue, Apr 06, 2021 at 01:59:30PM -0300, Arnaldo Carvalho de Melo
> > > > > escreveu:
> > > > > > Em Tue, Apr 06, 2021 at 01:55:54PM -0300, Arnaldo Carvalho de
> > > > > > Melo escreveu:
> > > > > > > Em Tue, Apr 06, 2021 at 01:40:20PM -0300, Arnaldo Carvalho
> > > > > > > de Melo escreveu:
> > > > > > > > Em Tue, Apr 06, 2021 at 10:22:37AM -0300, Arnaldo
> > > > > > > > Carvalho de Melo escreveu:
> > > > > > > > > I'm seeing these here:
> > > > > > >
> > > > > > > > > [acme@five bpf]$ rm -f ../build/bpf_clang_thin_lto/*vmlinu*
> > > > > > > > > [acme@five bpf]$ time make -j28 LLVM=1 LLVM_IAS=1
> > > > > > > > > O=../build/bpf_clang_thin_lto/ vmlinux
> > > > > > > > > make[1]: Entering directory '/home/acme/git/build/bpf_clang_thin_lto'
> > > > > > > > >    GEN     Makefile
> > > > > > > > >    DESCEND  objtool
> > > > > > > > >    DESCEND  bpf/resolve_btfids
> > > > > > > > >    CALL    /home/acme/git/bpf/scripts/atomic/check-atomics.sh
> > > > > > > > >    CALL    /home/acme/git/bpf/scripts/checksyscalls.sh
> > > > > > > > >    CHK     include/generated/compile.h
> > > > > > > > >    GEN     .version
> > > > > > > > >    CHK     include/generated/compile.h
> > > > > > > > >    UPD     include/generated/compile.h
> > > > > > > > >    CC      init/version.o
> > > > > > > > >    AR      init/built-in.a
> > > > > > > > >    GEN     .tmp_initcalls.lds
> > > > > > > > >    LTO     vmlinux.o
> > > > > > > > >    OBJTOOL vmlinux.o
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_init_avx_gen2()+0x12: unsupported stack
> > > > > > > > > pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_enc_update_avx_gen2()+0x12: unsupported
> > > > > > > > > stack pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_dec_update_avx_gen2()+0x12: unsupported
> > > > > > > > > stack pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_finalize_avx_gen2()+0x12: unsupported
> > > > > > > > > stack pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_init_avx_gen4()+0x12: unsupported stack
> > > > > > > > > pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_enc_update_avx_gen4()+0x12: unsupported
> > > > > > > > > stack pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_dec_update_avx_gen4()+0x12: unsupported
> > > > > > > > > stack pointer realignment
> > > > > > > > > vmlinux.o: warning: objtool:
> > > > > > > > > aesni_gcm_finalize_avx_gen4()+0x12: unsupported
> > > > > > > > > stack pointer realignment
> > > > > > > > >    MODPOST vmlinux.symvers
> > > > > > > > >    MODINFO modules.builtin.modinfo
> > > > > > > > >    GEN     modules.builtin
> > > > > > > > >    LD      .tmp_vmlinux.btf
> > > > > > > > >    BTF     .btf.vmlinux.bin.o
> > > > > > > > >    LD      .tmp_vmlinux.kallsyms1
> > > > > > > > >    KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > > > > >    AS      .tmp_vmlinux.kallsyms1.S
> > > > > > > > >    LD      .tmp_vmlinux.kallsyms2
> > > > > > > > >    KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > > > > >    AS      .tmp_vmlinux.kallsyms2.S
> > > > > > > > >    LD      vmlinux
> > > > > > > > >    BTFIDS  vmlinux
> > > > > > > > > WARN: multiple IDs found for 'inode': 232, 28822 - using 232
> > > > > > > > > WARN: multiple IDs found for 'file': 374, 28855 - using 374
> > > > > > > > > WARN: multiple IDs found for 'path': 379, 28856 - using 379
> > > > > > > > > WARN: multiple IDs found for 'vm_area_struct': 177, 28929 - using 177
> > > > > > > > > WARN: multiple IDs found for 'task_struct': 97, 28966 - using 97
> > > > > > > > > WARN: multiple IDs found for 'seq_file': 510, 29059 - using 510
> > > > > > > > > WARN: multiple IDs found for 'inode': 232, 29345 - using 232
> > > > > > > > > WARN: multiple IDs found for 'file': 374, 29429 - using 374
> > > > > > > > > WARN: multiple IDs found for 'path': 379, 29430 - using 379
> > > > > > > > > WARN: multiple IDs found for 'vm_area_struct': 177, 29471 - using 177
> > > > > > > > > WARN: multiple IDs found for 'task_struct': 97, 29481 - using 97
> > > > > > > > > WARN: multiple IDs found for 'seq_file': 510, 29512 - using 510
> > > > > > > > >    SORTTAB vmlinux
> > > > > > > > >    SYSMAP  System.map
> > > > > > > > > make[1]: Leaving directory '/home/acme/git/build/bpf_clang_thin_lto'
> > > > > > > > >
> > > > > > > > > [acme@five pahole]$ clang -v
> > > > > > > > > clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> > > >
> > > > This could be due to the compiler. The clang 11 is used here. Sedat is
> > > > using clang 12 and didn't see warnings and I am using clang dev branch
> > > > (clang 13) and didn't see warnings either. clang 11 could generate
> > > > some debuginfo where pahole didn't handle it properly.
> > > >
> > > > I tried to build locally with clang 11 but it crashed as I enabled
> > > > assert during compiler build. Will try a little bit more.
> > >
> > > Yes, I can see it with llvm11:
> > >
> > >   LD      vmlinux
> > >
> > >
> > >   BTFIDS  vmlinux
> > >
> > >
> > > WARN: multiple IDs found for 'inode': 245, 36255 - using 245
> > >
> > >
> > > WARN: multiple IDs found for 'file': 390, 36288 - using 390
> > >
> > >
> > > WARN: multiple IDs found for 'path': 395, 36289 - using 395
> > >
> > >
> > > WARN: multiple IDs found for 'vm_area_struct': 190, 36362 - using 190
> > >
> > >
> > > WARN: multiple IDs found for 'task_struct': 93, 36399 - using 93
> > >
> > >
> > > WARN: multiple IDs found for 'seq_file': 524, 36498 - using 524
> > >
> > >
> > > WARN: multiple IDs found for 'inode': 245, 36784 - using 245
> > >
> > >
> > > WARN: multiple IDs found for 'file': 390, 36868 - using 390
> > >
> > >
> > > WARN: multiple IDs found for 'path': 395, 36869 - using 395
> > >
> > >
> > > WARN: multiple IDs found for 'vm_area_struct': 190, 36910 - using 190
> > >
> > >
> > > WARN: multiple IDs found for 'task_struct': 93, 36920 - using 93
> > >
> > >
> > > WARN: multiple IDs found for 'seq_file': 524, 36951 - using 524
> > >
> > >
> > >   SORTTAB vmlinux
> > >
> > >
> > >   SYSMAP  System.map
> > >
> > >
> > >   LTO [M] crypto/crypto_engine.lto.o
> > >
> > >
> > >   LTO [M] drivers/crypto/virtio/virtio_crypto.lto.o
> > >
> > > $ clang --version
> > > clang version 11.1.0 (https://github.com/llvm/llvm-project.git
> > > 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)
> > > Target: x86_64-unknown-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /home/yhs/work/llvm-project/llvm/build/install/bin
> > >
> > > clang12 is okay:
> > >
> > >   LTO     vmlinux.o
> > >   OBJTOOL vmlinux.o
> > >   MODPOST vmlinux.symvers
> > >   MODINFO modules.builtin.modinfo
> > >   GEN     modules.builtin
> > >   LD      .tmp_vmlinux.btf
> > >   BTF     .btf.vmlinux.bin.o
> > >   LD      .tmp_vmlinux.kallsyms1
> > >   KSYMS   .tmp_vmlinux.kallsyms1.S
> > >   AS      .tmp_vmlinux.kallsyms1.S
> > >   LD      .tmp_vmlinux.kallsyms2
> > >   KSYMS   .tmp_vmlinux.kallsyms2.S
> > >
> > > $ clang --version
> > > clang version 12.0.0 (https://github.com/llvm/llvm-project.git
> > > 31001be371e8f2c74470e727e54503fb2aabec8b)
> > > Target: x86_64-unknown-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /home/yhs/work/llvm-project/llvm/build/install/bin
> > >
> > > I think we do not need to fix pahole for llvm11.
> > > When linus tree 5.12 is out. clang 12 should have been released
> > > or very close, we can just recommend clang 12 and later.
> >
> > Agreed, and it is just for _thin_ LTO, those warnings don't pop up when
> > building for full LTO with clang 11, the one in Fedora 33.
> >
> > And Fedora 34 beta has clang/llvm 12.0, so we're good.
> >
> > /me goes back to building clang/llvm HEAD, reducing the number of linker
> > instances to 1 as I have just 32GB of ram in this Ryzen machine... ;-)
>
> 32GB should be enough for a lot of parallel links - unless you're
> using ld.bfd - highly advised to switch to gold or lld & then you
> shuold be able to do a fair number of parallel links without loads of
> thrashing.
>
>  https://llvm.org/docs/GettingStarted.html#common-problems discusses a
> few things to try
>
>  - Dave

In the Linux kernel land I remember ld.lld can use more memory than GNU ld.
There are some lkp bot reports related to this.
It may be related to GNU ld not mmaping(?) input files. In any case no
deep analysis has been performed tracking down the potential issues.
