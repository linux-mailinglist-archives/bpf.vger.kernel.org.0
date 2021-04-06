Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1A355A44
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 19:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbhDFRZm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 13:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346916AbhDFRZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 13:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 007A6613BC;
        Tue,  6 Apr 2021 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617729929;
        bh=UtDJrvYQBENXqcY/Yw+5EWY1nNIyY0zPLC9cmmxdHdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGoWiWg7DKULQrfskLP1+8OWlOLfBSFWzi1ihLKXRzTzRtRcWcegRQaVLEo+pCYud
         1rx4Q9VzFSY5cglGbscXHu4UVxa1/hNsRjmXFPzwF8zyOpTgXkg6X2jq1qCibwh37h
         COyce7d6SIcMStvnjbUIXbDpI0ddlx1ieL6k7gozvjHUgpXp695iN4/UdgGNtp2RO6
         e3zzoAgQezZlwaiDRVfpB5SlBLhzkVb082n+h90h0C4ZRTB57gsTt55d5J7BfluvTH
         u2H/pkdC/x/9JV2ugB1W/Nls8khTXFJLMjmF0owGJsc0edpoK0eyPGJACVxYWpFBJB
         zpX+GW/EqZQTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 962E540647; Tue,  6 Apr 2021 14:25:26 -0300 (-03)
Date:   Tue, 6 Apr 2021 14:25:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGyZhjVgiM/mYz4r@kernel.org>
References: <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
 <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org>
 <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org>
 <YGyVTnBCWan8zJ8Q@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyVTnBCWan8zJ8Q@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 02:07:26PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 06, 2021 at 02:03:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Sorry, I forgot to use clang on this no-lto build... doing it now with:
> > 
> > [acme@five bpf]$ grep LTO ../build/bpf_clang_no_lto/.config
> > CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> > CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> > CONFIG_HAS_LTO_CLANG=y
> > CONFIG_LTO_NONE=y
> > # CONFIG_LTO_CLANG_FULL is not set
> > # CONFIG_LTO_CLANG_THIN is not set
> > CONFIG_HID_WALTOP=m
> > [acme@five bpf]$
> > [acme@five bpf]$ make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_no_lto/ vmlinux
> 
> 
> Works:
> 
> [acme@five bpf]$ make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_no_lto/ vmlinux


Now with FULL LTO:

  CC      fs/mbcache.o
  CC      fs/posix_acl.o
  CC      fs/coredump.o
  CC      fs/drop_caches.o
  CC      fs/fhandle.o
  AR      drivers/soundwire/built-in.a
  AR      drivers/hid/built-in.a
  AR      drivers/acpi/built-in.a
  AR      drivers/built-in.a
  AR      fs/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  GEN     .tmp_initcalls.lds
  LTO     vmlinux.o
  OBJTOOL vmlinux.o
vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen2()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen2()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen2()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen2()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_init_avx_gen4()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_enc_update_avx_gen4()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_dec_update_avx_gen4()+0x12: unsupported stack pointer realignment
vmlinux.o: warning: objtool: aesni_gcm_finalize_avx_gen4()+0x12: unsupported stack pointer realignment
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
make[1]: Leaving directory '/home/acme/git/build/bpf_clang_full_lto'

real	8m36.854s
user	50m44.832s
sys	4m0.946s
[acme@five bpf]$

[acme@five bpf]$ cat /etc/fedora-release
Fedora release 33 (Thirty Three)
[acme@five bpf]$ grep LTO ../build/bpf_clang_full_lto/.config
CONFIG_LTO=y
CONFIG_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_HAS_LTO_CLANG=y
# CONFIG_LTO_NONE is not set
CONFIG_LTO_CLANG_FULL=y
# CONFIG_LTO_CLANG_THIN is not set
CONFIG_HID_WALTOP=m
[acme@five bpf]$


Probably this will go away if I update clang/llvm? :)

Will try.

- Arnaldo
