Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628A7355A00
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbhDFRHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 13:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhDFRHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 13:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EB6D61074;
        Tue,  6 Apr 2021 17:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617728849;
        bh=OTLi2br6TwGXAvuCmYFHZuPBiT/v7waifZhs4i1hXQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYB/165cJWuvS4X/8MJIdGUSKnb8BKgyozRVPCjbNykk+tuqnD164qBjlbKGmzOXR
         d3EEHvgZcTOX2dG9v33+OZtGoLJgMi53MPt0Dj2v2VOJWUrZzJHq2JCAKx4YLiXB+f
         M1Revyo3T0rdANKP/uq95KIQvJzkb3Da0HFOxBAtTdeYwrFuuzNzSomjPsJMroVHau
         zzMZAxOGYZHbQgBA3ZMajHcdenxxeiwR/oa6Q/EHYXnypl+VKB1/Wb4gU0K6EBmJKL
         qcg+Q4ziHW+GY1MT9DZa+tbQq2mDrpXVy1yZZMcD93WlwcMpsqR6J16kCYDePr7IUv
         oDzXkiaEmfJ0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6CE6840647; Tue,  6 Apr 2021 14:07:26 -0300 (-03)
Date:   Tue, 6 Apr 2021 14:07:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
Message-ID: <YGyVTnBCWan8zJ8Q@kernel.org>
References: <20210401025815.2254256-1-yhs@fb.com>
 <CAGG=3QWpcCG7b70oQsRTATgt10acEFS=-Tg9U=DHZ6xoS3GeMA@mail.gmail.com>
 <CAGG=3QUUYn9K7zVQ1UVZ57_FFeiiOexwq_OgDw9VFPJD3fFbVw@mail.gmail.com>
 <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com>
 <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org>
 <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org>
 <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyUbX/HRBdGjH3i@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 06, 2021 at 02:03:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> Sorry, I forgot to use clang on this no-lto build... doing it now with:
> 
> [acme@five bpf]$ grep LTO ../build/bpf_clang_no_lto/.config
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
> CONFIG_HAS_LTO_CLANG=y
> CONFIG_LTO_NONE=y
> # CONFIG_LTO_CLANG_FULL is not set
> # CONFIG_LTO_CLANG_THIN is not set
> CONFIG_HID_WALTOP=m
> [acme@five bpf]$
> [acme@five bpf]$ make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_no_lto/ vmlinux


Works:

[acme@five bpf]$ make -j28 LLVM=1 LLVM_IAS=1 O=../build/bpf_clang_no_lto/ vmlinux
  CC      drivers/acpi/acpica/utxfmutex.o
  AR      fs/built-in.a
  AR      drivers/acpi/acpica/built-in.a
  AR      drivers/acpi/built-in.a
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
