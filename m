Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0C355B32
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhDFSUc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 14:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237779AbhDFSUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 14:20:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16580613B8;
        Tue,  6 Apr 2021 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617733224;
        bh=HwWDY1UBty/z4wmcoQdcjUnhELugmMFyNKQPmbJ1LLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMhJwqnjKBfocKJuw+LfP0E/0eS8VR7Dv2bOw6G2XNIJddg+LBT6CtUs6D91GrqbR
         brLbJ2O6Qo7EmYy490HgPsXtC9i+dkOHnDhVnGxjJy4LJqSMMESmrYTtlNe1VfE1ZB
         5FUExM2QlE1LWeBeG7KTuMn8AEh1zvleMopUiSa4jVIhv4qImiBfGNQQjQm9gBIdT6
         /7mIO4sSRNNxmQ9RT5oJSTJ9AtCPzXuAYmCvJEO/DSdq3IPW9q2t2eZPbic+7dnFYh
         kYhy9JmstxXuDByWut7yZm57s1KXYZxsrleqPK6BZlvqLC4dOHalrAOlJXQQ0jj53m
         z5DlpXSEXunYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C24940647; Tue,  6 Apr 2021 15:20:21 -0300 (-03)
Date:   Tue, 6 Apr 2021 15:20:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Blaikie <dblaikie@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>, Bill Wendling <morbo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGymZcMytvDpqHaK@kernel.org>
References: <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
 <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org>
 <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org>
 <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
 <4eda63d8-f9df-71ab-d625-dcc4df429a89@fb.com>
 <YGyicDTUkPNhab4K@kernel.org>
 <CAENS6EvW8+oAa_DfN3LZsHmVkwA2WTb-TrcSf1FLEroyrnQXzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAENS6EvW8+oAa_DfN3LZsHmVkwA2WTb-TrcSf1FLEroyrnQXzQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 11:17:56AM -0700, David Blaikie escreveu:
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

Thanks for the pointer!

- Arnaldo
