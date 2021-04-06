Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066E3559D5
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbhDFQ7m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 12:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346701AbhDFQ7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 12:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D2B0613D3;
        Tue,  6 Apr 2021 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617728373;
        bh=OFDxHSzOi29eI4K8f7eu5bOR9ltGa1H+qZ+1Pv4KNEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4cKz0oSFn73WE4LMEK/Tx/sg7fDUXaloE/M21GUSlg3jaNBfm/cH/Xc40yOVpP/d
         vpuwHaIKnY41UbZe0qFiqCa5CuqQlHEFbAbKGE4a02MWaPXtPirw3WLHilAL6Zxl0G
         LJByz/vU/aFZfZMBuLX6FD/G+gZfGhkoNOu0t/Xm0dky7Uln49zqX553QopNPFABC6
         aC+ERpOq7vLgMKRL3U2Wv3hCCqydn0el0qJDd77QxqE0IscnfFWwhF2ei9UWzbZBTB
         zpj3djO/qjDUoBd/GYtqhyRVotezWGp+Dzz9EcXoQfZ3o0ORfvvJsQnvZ4hRg+aPQ3
         f12CdslN0dAVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB50A40647; Tue,  6 Apr 2021 13:59:30 -0300 (-03)
Date:   Tue, 6 Apr 2021 13:59:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGyTco9NvT8Bin8i@kernel.org>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
 <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGySmmmn4J43I0EG@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 01:55:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 06, 2021 at 01:40:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Apr 06, 2021 at 10:22:37AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > I'm seeing these here:
> 
> > > [acme@five bpf]$ rm -f ../build/bpf_clang_thin_lto/*vmlinu*
> > > [acme@five bpf]$ time make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_thin_lto/ vmlinux
> > > make[1]: Entering directory '/home/acme/git/build/bpf_clang_thin_lto'
> > >   GEN     Makefile
> > >   DESCEND  objtool
> > >   DESCEND  bpf/resolve_btfids
> > >   CALL    /home/acme/git/bpf/scripts/atomic/check-atomics.sh
> > >   CALL    /home/acme/git/bpf/scripts/checksyscalls.sh
> > >   CHK     include/generated/compile.h
> > >   GEN     .version
> > >   CHK     include/generated/compile.h
> > >   UPD     include/generated/compile.h
> > >   CC      init/version.o
> > >   AR      init/built-in.a
> > >   GEN     .tmp_initcalls.lds
> > >   LTO     vmlinux.o
> > >   OBJTOOL vmlinux.o
> > > vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12: unsupported stack pointer realignment
> > > vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12: unsupported stack pointer realignment
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
> > >   AS      .tmp_vmlinux.kallsyms2.S
> > >   LD      vmlinux
> > >   BTFIDS  vmlinux
> > > WARN: multiple IDs found for 'inode': 232, 28822 - using 232
> > > WARN: multiple IDs found for 'file': 374, 28855 - using 374
> > > WARN: multiple IDs found for 'path': 379, 28856 - using 379
> > > WARN: multiple IDs found for 'vm_area_struct': 177, 28929 - using 177
> > > WARN: multiple IDs found for 'task_struct': 97, 28966 - using 97
> > > WARN: multiple IDs found for 'seq_file': 510, 29059 - using 510
> > > WARN: multiple IDs found for 'inode': 232, 29345 - using 232
> > > WARN: multiple IDs found for 'file': 374, 29429 - using 374
> > > WARN: multiple IDs found for 'path': 379, 29430 - using 379
> > > WARN: multiple IDs found for 'vm_area_struct': 177, 29471 - using 177
> > > WARN: multiple IDs found for 'task_struct': 97, 29481 - using 97
> > > WARN: multiple IDs found for 'seq_file': 510, 29512 - using 510
> > >   SORTTAB vmlinux
> > >   SYSMAP  System.map
> > > make[1]: Leaving directory '/home/acme/git/build/bpf_clang_thin_lto'
> > > 
> > > [acme@five pahole]$ clang -v
> > > clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> > > Target: x86_64-unknown-linux-gnu
> > > Thread model: posix
> > > InstalledDir: /usr/bin
> > > Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> > > Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> > > Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> > > Candidate multilib: .;@m64
> > > Candidate multilib: 32;@m32
> > > Selected multilib: .;@m64
> > > [acme@five pahole]$
> > > 
> > > [acme@five bpf]$ git log --oneline -10
> > > 49b9da70941c3c8a (HEAD -> bpf_perf_enable) kbuild: add an elfnote with type BUILD_COMPILER_LTO_INFO
> > > 5c4f082a143c786e kbuild: move LINUX_ELFNOTE_BUILD_SALT to elfnote.h
> > > 42c8b565decb3662 bpf: Introduce helpers to enable/disable perf event fds in a map
> > > f73ea1eb4cce6637 (bpf-next/master, bpf-next/for-next) bpf: selftests: Specify CONFIG_DYNAMIC_FTRACE in the testing config
> > > f07669df4c8df0b7 libbpf: Remove redundant semi-colon
> > > 6ac4c6f887f5a8ef bpf: Remove repeated struct btf_type declaration
> > > 2daae89666ad2532 bpf, cgroup: Delete repeated struct bpf_prog declaration
> > > 2ec9898e9c70b93a bpf: Remove unused parameter from ___bpf_prog_run
> > > 007bdc12d4b46656 bpf, selftests: test_maps generating unrecognized data section
> > > 82506665179209e4 tcp: reorder tcp_congestion_ops for better cache locality
> > > [acme@five bpf]$
> > > 
> > > I'll try after a 'make mrproper'
> > 
> > Same thing, trying now with gcc.
> 
> With gcc no such messages:
> 
>   CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
>   CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
>   LD [M]  drivers/gpu/drm/nouveau/nouveau.o
>   AR      drivers/gpu/built-in.a
>   AR      drivers/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
>   LD      .tmp_vmlinux.kallsyms1
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
>   SORTTAB vmlinux
>   SYSMAP  System.map
>   HOSTCC  arch/x86/tools/insn_decoder_test
>   HOSTCC  arch/x86/tools/insn_sanity
>   MODPOST Module.symvers
>   TEST    posttest
>   CC [M]  arch/x86/crypto/aegis128-aesni.mod.o
>   CC [M]  arch/x86/crypto/blake2s-x86_64.mod.o
> 
> Now will try with clang non-LTO.

Works:

  AR      drivers/usb/built-in.a
  AR      lib/built-in.a
  AR      drivers/md/built-in.a
  AR      drivers/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  LD      vmlinux.o
  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  BTFIDS  vmlinux
  SORTTAB vmlinux
  SYSMAP  System.map
make[1]: Leaving directory '/home/acme/git/build/bpf_clang_no_lto'

[acme@five bpf]$ grep LTO ../build/bpf_clang_no_lto/.config
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HID_WALTOP=m
[acme@five bpf]$

This works, gcc as well, but this produces those BTFID warnings:

[acme@five bpf]$ grep LTO ../build/bpf_clang_thin_lto/.config
CONFIG_LTO=y
CONFIG_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_HAS_LTO_CLANG=y
# CONFIG_LTO_NONE is not set
# CONFIG_LTO_CLANG_FULL is not set
CONFIG_LTO_CLANG_THIN=y
CONFIG_HID_WALTOP=m
[acme@five bpf]$

Trying with clang full LTO.

- Arnaldo


