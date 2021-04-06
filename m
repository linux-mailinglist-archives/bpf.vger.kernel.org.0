Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA082355A73
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhDFReM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 13:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhDFReL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 13:34:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63F03613C2;
        Tue,  6 Apr 2021 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617730443;
        bh=CV7EnJZ7PQ0prhXM19//Q5xYjxBlYYRfj0Le7rvdhtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ym/6YL0XUWluzuNs5ZhoSQwBWeSrN2xZzOph0luGowqD7rfsRT4GOOqQAkbBFktIx
         8I6Xd84hD9bZyqYbHX+5WHlfGkyXPYTkCOdRCcwtdkXf0KUzD5btjK/JX7sKzssIZb
         VgpsUCN3gzFDqc8Jy/GWewIL5JqOLz36MO7nq3ZXBRrFh8mNd3teEZbaRzry4OzmNd
         MxcAsV0WAczEW8t2iynIF6YbmZK+6H2HVxt3DfiRgw+qvBwJFmkdmsGuLbFkemGT6M
         0/DaNQQ1HSOMxmfDDvsFxF+wh1lswC+AHvbYNNs3+goFOQJMHYgpj/hkG3vXnNH+x/
         CqcKo83V1gAUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0B18840647; Tue,  6 Apr 2021 14:34:01 -0300 (-03)
Date:   Tue, 6 Apr 2021 14:34:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Bill Wendling <morbo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGybiA2uSax5+6np@kernel.org>
References: <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
 <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org>
 <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org>
 <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 10:23:37AM -0700, Yonghong Song escreveu:
> 
> 
> On 4/6/21 10:03 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Apr 06, 2021 at 01:59:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Tue, Apr 06, 2021 at 01:55:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Apr 06, 2021 at 01:40:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Tue, Apr 06, 2021 at 10:22:37AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > I'm seeing these here:
> > > > 
> > > > > > [acme@five bpf]$ rm -f ../build/bpf_clang_thin_lto/*vmlinu*
> > > > > > [acme@five bpf]$ time make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_thin_lto/ vmlinux
> > > > > > make[1]: Entering directory '/home/acme/git/build/bpf_clang_thin_lto'
> > > > > >    GEN     Makefile
> > > > > >    DESCEND  objtool
> > > > > >    DESCEND  bpf/resolve_btfids
> > > > > >    CALL    /home/acme/git/bpf/scripts/atomic/check-atomics.sh
> > > > > >    CALL    /home/acme/git/bpf/scripts/checksyscalls.sh
> > > > > >    CHK     include/generated/compile.h
> > > > > >    GEN     .version
> > > > > >    CHK     include/generated/compile.h
> > > > > >    UPD     include/generated/compile.h
> > > > > >    CC      init/version.o
> > > > > >    AR      init/built-in.a
> > > > > >    GEN     .tmp_initcalls.lds
> > > > > >    LTO     vmlinux.o
> > > > > >    OBJTOOL vmlinux.o
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12: unsupported stack pointer realignment
> > > > > > vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12: unsupported stack pointer realignment
> > > > > >    MODPOST vmlinux.symvers
> > > > > >    MODINFO modules.builtin.modinfo
> > > > > >    GEN     modules.builtin
> > > > > >    LD      .tmp_vmlinux.btf
> > > > > >    BTF     .btf.vmlinux.bin.o
> > > > > >    LD      .tmp_vmlinux.kallsyms1
> > > > > >    KSYMS   .tmp_vmlinux.kallsyms1.S
> > > > > >    AS      .tmp_vmlinux.kallsyms1.S
> > > > > >    LD      .tmp_vmlinux.kallsyms2
> > > > > >    KSYMS   .tmp_vmlinux.kallsyms2.S
> > > > > >    AS      .tmp_vmlinux.kallsyms2.S
> > > > > >    LD      vmlinux
> > > > > >    BTFIDS  vmlinux
> > > > > > WARN: multiple IDs found for 'inode': 232, 28822 - using 232
> > > > > > WARN: multiple IDs found for 'file': 374, 28855 - using 374
> > > > > > WARN: multiple IDs found for 'path': 379, 28856 - using 379
> > > > > > WARN: multiple IDs found for 'vm_area_struct': 177, 28929 - using 177
> > > > > > WARN: multiple IDs found for 'task_struct': 97, 28966 - using 97
> > > > > > WARN: multiple IDs found for 'seq_file': 510, 29059 - using 510
> > > > > > WARN: multiple IDs found for 'inode': 232, 29345 - using 232
> > > > > > WARN: multiple IDs found for 'file': 374, 29429 - using 374
> > > > > > WARN: multiple IDs found for 'path': 379, 29430 - using 379
> > > > > > WARN: multiple IDs found for 'vm_area_struct': 177, 29471 - using 177
> > > > > > WARN: multiple IDs found for 'task_struct': 97, 29481 - using 97
> > > > > > WARN: multiple IDs found for 'seq_file': 510, 29512 - using 510
> > > > > >    SORTTAB vmlinux
> > > > > >    SYSMAP  System.map
> > > > > > make[1]: Leaving directory '/home/acme/git/build/bpf_clang_thin_lto'
> > > > > > 
> > > > > > [acme@five pahole]$ clang -v
> > > > > > clang version 11.0.0 (Fedora 11.0.0-2.fc33)
> 
> This could be due to the compiler. The clang 11 is used here. Sedat is
> using clang 12 and didn't see warnings and I am using clang dev branch
> (clang 13) and didn't see warnings either. clang 11 could generate
> some debuginfo where pahole didn't handle it properly.
> 
> I tried to build locally with clang 11 but it crashed as I enabled
> assert during compiler build. Will try a little bit more.

Right, I'm now at:

$ git clone https://github.com/llvm/llvm-project.git
$ cmake -DLLVM_ENABLE_PROJECTS=clang -G "Unix Makefiles" ../llvm

:-)

- Arnaldo
