Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927C935595E
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhDFQkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 12:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhDFQkb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 12:40:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2177E613D5;
        Tue,  6 Apr 2021 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617727223;
        bh=dZpsTQ/aOgqzZBZHunx+MULLBc12D2QIBCK44v7h6s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDxoRti3lNE01AOFDqGS4hsGWu/uY4xpBl44jY+FaezL1RTI410SVNkIJ4Jz3ouw3
         eXhTJAVeJMCnyIqAS/wlE+mliCrPgy4zWmxiIFSuqoIuIcIuKymxukVzkV4n1qJ6sJ
         bYhIglyXVfUdJoujX9Pp5Rp66kTGo1H7yqZ/XO9cb4uMVjTpgTej0QEkRtMmXCZEch
         bUxK47XOWYIhgiNqbROqF5tDvxedU05C+ai0QFcrGk9zHvDre0TSHUNj6wmV/d8ovo
         kKtsVlQID7YeKYgWRBSojk7EA1IEVyfyvXEh7MYRre4INK/fzOUIbBgSJl1KWlH1QV
         FqyG/nrivgTWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB99440647; Tue,  6 Apr 2021 13:40:20 -0300 (-03)
Date:   Tue, 6 Apr 2021 13:40:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Bill Wendling <morbo@google.com>, Yonghong Song <yhs@fb.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGyO9KzDoxu5zk33@kernel.org>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxgnQyBPf5fxQxM@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 10:22:37AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 02, 2021 at 12:44:50PM -0700, Bill Wendling escreveu:
> > I tried porting the .config we're using to the official branch and
> > couldn't replicate the problem. It's probably something local.
> > 
> > On Thu, Apr 1, 2021 at 3:00 PM Yonghong Song <yhs@fb.com> wrote:
> > > On 4/1/21 1:56 PM, Bill Wendling wrote:
> > > > On Thu, Apr 1, 2021 at 12:35 PM Bill Wendling <morbo@google.com> wrote:
> > > >>
> > > >> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
> > > >>>
> > > >>> Function cus__merging_cu() is introduced in Commit 39227909db3c
> > > >>> ("dwarf_loader: Permit merging all DWARF CU's for clang LTO built
> > > >>> binary") to test whether cross-cu references may happen.
> > > >>> The original implementation anticipates compilation flags
> > > >>> in dwarf, but later some concerns about binary size surfaced
> > > >>> and the decision is to scan .debug_abbrev as a faster way
> > > >>> to check cross-cu references. Also putting a note in vmlinux
> > > >>> to indicate whether lto is enabled for built or not can
> > > >>> provide a much faster way.
> > > >>>
> > > >>> This patch set implemented this two approaches, first
> > > >>> checking the note (in Patch #2), if not found, then
> > > >>> check .debug_abbrev (in Patch #1).
> > > >>>
> > > >>> Yonghong Song (2):
> > > >>>    dwarf_loader: check .debug_abbrev for cross-cu references
> > > >>>    dwarf_loader: check .notes section for lto build info
> > > >>>
> > > >>>   dwarf_loader.c | 76 ++++++++++++++++++++++++++++++++++++--------------
> > > >>>   1 file changed, 55 insertions(+), 21 deletions(-)
> > > >>>
> > > >> With this series of patches, the compilation passes for me with
> > > >> ThinLTO. You may add this if you like:
> > > >>
> > > >> Tested-by: Bill Wendling <morbo@google.com>
> > > >
> > > > I did notice these warnings following the "pahole -J .tmp_vmlinux.btf"
> > > > command. I don't know the severity of them, but it might be good to
> > > > investigate.
> > > >
> > > > $ ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > >    BTFIDS  vmlinux
> > > > WARN: multiple IDs found for 'inode': 355, 8746 - using 355
> > > > WARN: multiple IDs found for 'file': 588, 8779 - using 588
> > > > WARN: multiple IDs found for 'path': 411, 8780 - using 411
> > > > WARN: multiple IDs found for 'seq_file': 1414, 8836 - using 1414
> > > > WARN: multiple IDs found for 'vm_area_struct': 538, 8873 - using 538
> > > > WARN: multiple IDs found for 'task_struct': 28, 8880 - using 28
> > > > WARN: multiple IDs found for 'inode': 355, 9484 - using 355
> > > > WARN: multiple IDs found for 'file': 588, 9517 - using 588
> > > > WARN: multiple IDs found for 'path': 411, 9518 - using 411
> > > > WARN: multiple IDs found for 'seq_file': 1414, 9578 - using 1414
> > > > WARN: multiple IDs found for 'vm_area_struct': 538, 9615 - using 538
> > > > WARN: multiple IDs found for 'task_struct': 28, 9622 - using 28
> > > > WARN: multiple IDs found for 'seq_file': 1414, 12223 - using 1414
> > > > WARN: multiple IDs found for 'file': 588, 12237 - using 588
> > > > WARN: multiple IDs found for 'path': 411, 12238 - using 411
> > > > ...
> > >
> > > I didn't see it with my config. Maybe you can share your config file?
> 
> I'm seeing these here:
> 
> [acme@five bpf]$ rm -f ../build/bpf_clang_thin_lto/*vmlinu*
> [acme@five bpf]$ time make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_thin_lto/ vmlinux
> make[1]: Entering directory '/home/acme/git/build/bpf_clang_thin_lto'
>   GEN     Makefile
>   DESCEND  objtool
>   DESCEND  bpf/resolve_btfids
>   CALL    /home/acme/git/bpf/scripts/atomic/check-atomics.sh
>   CALL    /home/acme/git/bpf/scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   GEN     .tmp_initcalls.lds
>   LTO     vmlinux.o
>   OBJTOOL vmlinux.o
> vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12: unsupported stack pointer realignment
> vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12: unsupported stack pointer realignment
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
> WARN: multiple IDs found for 'inode': 232, 28822 - using 232
> WARN: multiple IDs found for 'file': 374, 28855 - using 374
> WARN: multiple IDs found for 'path': 379, 28856 - using 379
> WARN: multiple IDs found for 'vm_area_struct': 177, 28929 - using 177
> WARN: multiple IDs found for 'task_struct': 97, 28966 - using 97
> WARN: multiple IDs found for 'seq_file': 510, 29059 - using 510
> WARN: multiple IDs found for 'inode': 232, 29345 - using 232
> WARN: multiple IDs found for 'file': 374, 29429 - using 374
> WARN: multiple IDs found for 'path': 379, 29430 - using 379
> WARN: multiple IDs found for 'vm_area_struct': 177, 29471 - using 177
> WARN: multiple IDs found for 'task_struct': 97, 29481 - using 97
> WARN: multiple IDs found for 'seq_file': 510, 29512 - using 510
>   SORTTAB vmlinux
>   SYSMAP  System.map
> make[1]: Leaving directory '/home/acme/git/build/bpf_clang_thin_lto'
> 
> [acme@five pahole]$ clang -v
> clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/10
> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Candidate multilib: .;@m64
> Candidate multilib: 32;@m32
> Selected multilib: .;@m64
> [acme@five pahole]$
> 
> [acme@five bpf]$ git log --oneline -10
> 49b9da70941c3c8a (HEAD -> bpf_perf_enable) kbuild: add an elfnote with type BUILD_COMPILER_LTO_INFO
> 5c4f082a143c786e kbuild: move LINUX_ELFNOTE_BUILD_SALT to elfnote.h
> 42c8b565decb3662 bpf: Introduce helpers to enable/disable perf event fds in a map
> f73ea1eb4cce6637 (bpf-next/master, bpf-next/for-next) bpf: selftests: Specify CONFIG_DYNAMIC_FTRACE in the testing config
> f07669df4c8df0b7 libbpf: Remove redundant semi-colon
> 6ac4c6f887f5a8ef bpf: Remove repeated struct btf_type declaration
> 2daae89666ad2532 bpf, cgroup: Delete repeated struct bpf_prog declaration
> 2ec9898e9c70b93a bpf: Remove unused parameter from ___bpf_prog_run
> 007bdc12d4b46656 bpf, selftests: test_maps generating unrecognized data section
> 82506665179209e4 tcp: reorder tcp_congestion_ops for better cache locality
> [acme@five bpf]$
> 
> I'll try after a 'make mrproper'

Same thing, trying now with gcc.

- Arnaldo
