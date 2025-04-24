Return-Path: <bpf+bounces-56638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEAA9B8A5
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 22:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7B01BA2C91
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC8296178;
	Thu, 24 Apr 2025 19:59:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF8293B50;
	Thu, 24 Apr 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524739; cv=none; b=CBbjqKSyXyyV7zJ721jQsUlw9B/JSKC8D27TO0xAgVDDil3OVJiYq83X0uoeievvYRLFaInfJRZASTnTWnob5pDeIPVMEIfSGjDR3JcPDPrmrztDqhuCHAL89s2xdkdgUwnw/jkvO2sbflB8quYV0KtU/ZohXi3hMxMEupOTPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524739; c=relaxed/simple;
	bh=U+H2Tq8C2+Oan7R7/hmm45bkPDgTuLfOe0pZH4PjNco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoI4dagluGuJa+BioN9PPC/9L90MGbYnnTLF0ojkC++/hR7cYIRlCkSg/StFKI6jHK+PRkHxZCX6T9TtG2JOebwkAdatA/P5a6n/vjEhoVHtRJC/wDZTxk2njOAwNrphyUomdos8LQuwKjvwOy3WHm4b4QQC+3S/nK28ZSjCq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af76d.dynamic.kabel-deutschland.de [95.90.247.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D47FA6016243D;
	Thu, 24 Apr 2025 21:58:31 +0200 (CEST)
Message-ID: <273137fb-74c3-4c74-b228-099cde3869e7@molgen.mpg.de>
Date: Thu, 24 Apr 2025 21:58:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
 DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
 115a4a9!
To: Alan Maguire <alan.maguire@oracle.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <2b3986f2-7152-4c11-957a-b08641dfe132@molgen.mpg.de>
 <03a0ad73-325c-4d6d-ba32-13a4938dc4cf@oracle.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <03a0ad73-325c-4d6d-ba32-13a4938dc4cf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alan,


Thank you for looking into this.


Am 24.04.25 um 20:07 schrieb Alan Maguire:
> On 22/04/2025 14:33, Paul Menzel wrote:

>> Trying to build Linux 6.12.23 with BTF and pahole 1.30, I get the build
>> failure below:
>>
>>      $ more .config
>>      […]
>>      #
>>      # Compile-time checks and compiler options
>>      #
>>      CONFIG_DEBUG_INFO=y
>>      CONFIG_AS_HAS_NON_CONST_ULEB128=y
>>      # CONFIG_DEBUG_INFO_NONE is not set
>>      # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>>      # CONFIG_DEBUG_INFO_DWARF4 is not set
>>      CONFIG_DEBUG_INFO_DWARF5=y
>>      # CONFIG_DEBUG_INFO_REDUCED is not set
>>      CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>>      # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>>      # CONFIG_DEBUG_INFO_SPLIT is not set
>>      CONFIG_DEBUG_INFO_BTF=y
>>      CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>      CONFIG_DEBUG_INFO_BTF_MODULES=y
>>      # CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
>>      # CONFIG_GDB_SCRIPTS is not set
>>      CONFIG_FRAME_WARN=2048
>>      # CONFIG_STRIP_ASM_SYMS is not set
>>      # CONFIG_READABLE_ASM is not set
>>      # CONFIG_HEADERS_INSTALL is not set
>>      # CONFIG_DEBUG_SECTION_MISMATCH is not set
>>      CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>>      CONFIG_OBJTOOL=y
>>      # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>>      # end of Compile-time checks and compiler options
>>      […]
>>      $ make -j100
>>      […]
>>        LD      .tmp_vmlinux1
>>        BTF     .tmp_vmlinux1.btf.o
>>      die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
>> DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
>> 115a4a9!
>>      error decoding cu
>>      pahole: .tmp_vmlinux1: Invalid argument
>>        NM      .tmp_vmlinux1.syms
>>        KSYMS   .tmp_vmlinux1.kallsyms.S
>>        AS      .tmp_vmlinux1.kallsyms.o
>>        LD      .tmp_vmlinux2
>>        NM      .tmp_vmlinux2.syms
>>        KSYMS   .tmp_vmlinux2.kallsyms.S
>>        AS      .tmp_vmlinux2.kallsyms.o
>>        LD      vmlinux
>>        BTFIDS  vmlinux
>>      libbpf: failed to find '.BTF' ELF section in vmlinux
>>      FAILED: load BTF from vmlinux: No data available
>>      make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
>>      make[2]: *** Deleting file 'vmlinux'
>>      make[1]: *** [/dev/shm/linux/Makefile:1179: vmlinux] Error 2
>>      make: *** [Makefile:224: __sub-make] Error 2
>>
>> Help how to get a successful build is much appreciated.
>>
> 
> I haven't been able to reproduce this one yet with your config;
> I tried with bpf-next + gcc-14, then switched to linux stable 6.12y +
> gcc 12 as that more closely matched your situation; all works fine for
> me. I'll try more precisely matching the gcc 12 version; things worked
> fine with pahole v.130 + gcc 12.2.1; from your config looks like you
> have gcc 12.3.0.

I also tried gcc 14.1.0, and now Linux origin/master (e72e9e6933071 
(Merge tag 'net-6.15-rc4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net)) with gcc 
12.3.0. We do build GCC ourselves [1]. Maybe there is something missing?

I built with `make V=1` now, and here are the commands:

```
$ make V=1
[…]
+ ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments -z 
max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn 
--script=./arch/x86/kernel/vmlinux.lds -o .tmp_vmlinux1 --whole-archive 
vmlinux.o .vmlinux.export.o init/version-timestamp.o --no-whole-archive 
--start-group --end-group .tmp_vmlinux0.kallsyms.o
+ is_enabled CONFIG_DEBUG_INFO_BTF
+ grep -q '^CONFIG_DEBUG_INFO_BTF=y' include/config/auto.conf
+ gen_btf .tmp_vmlinux1
+ local btf_data=.tmp_vmlinux1.btf.o
+ info BTF .tmp_vmlinux1.btf.o
+ printf '  %-7s %s\n' BTF .tmp_vmlinux1.btf.o
   BTF     .tmp_vmlinux1.btf.o
+ LLVM_OBJCOPY=objcopy
+ pahole -J -j 
--btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs 
--lang_exclude=rust .tmp_vmlinux1
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit 
or DW_TAG_skeleton_unit expected got INVALID (0x0) @ 1229728!
error decoding cu
pahole: .tmp_vmlinux1: Invalid argument
[…]
```

I uploaded `.tmp_vmlinux1` (295 MB) [3].

Copying this file to a Debian sid/unstable system with *pahole* 1.30-1, 
and *llvm-19* 1:19.1.7-3, there is no error.

     $ ls -l /usr/bin/llvm-objcopy
     lrwxrwxrwx 1 root root 31 Nov 11 12:42 /usr/bin/llvm-objcopy -> 
../lib/llvm-19/bin/llvm-objcopy
     $ llvm-objcopy --version
     llvm-objcopy, compatible with GNU objcopy
     Debian LLVM version 19.1.7
       Optimized build.

In the problematic environment, we have LLVM 18.1.8 installed:

     $ llvm-objcopy --version
     llvm-objcopy, compatible with GNU objcopy
     LLVM (http://llvm.org/):
       LLVM version 18.1.8
       Optimized build.


Kind regards,

Paul


[1]: 
https://github.molgen.mpg.de/mariux64/bee-files/blob/8cd1999f62d2865372c0240e5a62f7f0099fa615/gcc.be0#L28
[2]: 
https://github.molgen.mpg.de/mariux64/pkg-scripts/blob/2c229b222d0ba0794e24e51223aa4768e30884e2/gcc-14.1.0-0.build.sh#L49
[3]: https://owww.molgen.mpg.de/~pmenzel/.tmp_vmlinux1

>> PS: Using pahole 1.23 I get:
>>
>>      $ make -j100
>>      […]
>>        LD      .tmp_vmlinux1
>>        BTF     .tmp_vmlinux1.btf.o
>>      pahole: Multithreading requires elfutils >= 0.178. Continuing with a single thread...
>>      Unsupported DW_TAG_unspecified_type(0x3b)
>>      Encountered error while encoding BTF.
>>        NM      .tmp_vmlinux1.syms
>>        KSYMS   .tmp_vmlinux1.kallsyms.S
>>        AS      .tmp_vmlinux1.kallsyms.o
>>        LD      .tmp_vmlinux2
>>        NM      .tmp_vmlinux2.syms
>>        KSYMS   .tmp_vmlinux2.kallsyms.S
>>        AS      .tmp_vmlinux2.kallsyms.o
>>        LD      vmlinux
>>        BTFIDS  vmlinux
>>      libbpf: failed to find '.BTF' ELF section in vmlinux
>>      FAILED: load BTF from vmlinux: No data available
>>      make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
>>      make[2]: *** Deleting file 'vmlinux'
>>      make[1]: *** [/dev/shm/linux/Makefile:1179: vmlinux] Error 2
>>      make: *** [Makefile:224: __sub-make] Error 2

