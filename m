Return-Path: <bpf+bounces-56792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EA1A9DC9D
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236B31BC09B4
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5325DB1D;
	Sat, 26 Apr 2025 17:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C006AD3;
	Sat, 26 Apr 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745689222; cv=none; b=WXMzMjOaEML9KniDI0SYSmCMtiv/CVtZc65doTXeO/0k+JXLmAyz5bA64taudElsbQQQa8N6BQ8O/H3xXHUvLcLsE8uT3o2C+PUf4yQ3JVDWJbw5DWk03QsEwjym4RoeKV1zF6tK4YgmUH06c8/sze+dszaL8RH+X2B3srhFR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745689222; c=relaxed/simple;
	bh=rYYw9404H8xYqDQUBACPZOXHuBU/6uktEy9crEUXQR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/kgt8MhUuSwaXgIsWWjNqL+Bq6c0CUKxkOHVg2VHemRfT5KqbCH7SWPr0ctCEWTAqwkxtJGSnBz5M9h8vmH3LdIE2b7nieFYG2WcAJxNr1fGW3w+hTdQwIXJDt1Z+EXhFgukAw11Ri7mOfyWvv2I+tfy9vXHMm6NZjGvPHOQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aed07.dynamic.kabel-deutschland.de [95.90.237.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7996B61E647A8;
	Sat, 26 Apr 2025 19:39:54 +0200 (CEST)
Message-ID: <d18ee493-bd33-439b-8c58-cb6e552e92a1@molgen.mpg.de>
Date: Sat, 26 Apr 2025 19:39:51 +0200
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
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org
References: <2b3986f2-7152-4c11-957a-b08641dfe132@molgen.mpg.de>
 <03a0ad73-325c-4d6d-ba32-13a4938dc4cf@oracle.com>
 <273137fb-74c3-4c74-b228-099cde3869e7@molgen.mpg.de>
 <112a01c8-4ff6-445e-acc6-5a493a4862b0@oracle.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <112a01c8-4ff6-445e-acc6-5a493a4862b0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alan,


Thank you for your support.

TLDR; Upgrading elfutils/libelf from 0.176 to 0.193 fixed the issue.


Am 25.04.25 um 18:43 schrieb Alan Maguire:
> On 24/04/2025 20:58, Paul Menzel wrote:

>> Am 24.04.25 um 20:07 schrieb Alan Maguire:
>>> On 22/04/2025 14:33, Paul Menzel wrote:
>>
>>>> Trying to build Linux 6.12.23 with BTF and pahole 1.30, I get the build
>>>> failure below:
>>>>
>>>>       $ more .config
>>>>       […]
>>>>       #
>>>>       # Compile-time checks and compiler options
>>>>       #
>>>>       CONFIG_DEBUG_INFO=y
>>>>       CONFIG_AS_HAS_NON_CONST_ULEB128=y
>>>>       # CONFIG_DEBUG_INFO_NONE is not set
>>>>       # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
>>>>       # CONFIG_DEBUG_INFO_DWARF4 is not set
>>>>       CONFIG_DEBUG_INFO_DWARF5=y
>>>>       # CONFIG_DEBUG_INFO_REDUCED is not set
>>>>       CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
>>>>       # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
>>>>       # CONFIG_DEBUG_INFO_SPLIT is not set
>>>>       CONFIG_DEBUG_INFO_BTF=y
>>>>       CONFIG_PAHOLE_HAS_SPLIT_BTF=y
>>>>       CONFIG_DEBUG_INFO_BTF_MODULES=y
>>>>       # CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
>>>>       # CONFIG_GDB_SCRIPTS is not set
>>>>       CONFIG_FRAME_WARN=2048
>>>>       # CONFIG_STRIP_ASM_SYMS is not set
>>>>       # CONFIG_READABLE_ASM is not set
>>>>       # CONFIG_HEADERS_INSTALL is not set
>>>>       # CONFIG_DEBUG_SECTION_MISMATCH is not set
>>>>       CONFIG_SECTION_MISMATCH_WARN_ONLY=y
>>>>       CONFIG_OBJTOOL=y
>>>>       # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>>>>       # end of Compile-time checks and compiler options
>>>>       […]
>>>>       $ make -j100
>>>>       […]
>>>>         LD      .tmp_vmlinux1
>>>>         BTF     .tmp_vmlinux1.btf.o
>>>>       die__process: DW_TAG_compile_unit, DW_TAG_type_unit,
>>>> DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @
>>>> 115a4a9!
>>>>       error decoding cu
>>>>       pahole: .tmp_vmlinux1: Invalid argument
>>>>         NM      .tmp_vmlinux1.syms
>>>>         KSYMS   .tmp_vmlinux1.kallsyms.S
>>>>         AS      .tmp_vmlinux1.kallsyms.o
>>>>         LD      .tmp_vmlinux2
>>>>         NM      .tmp_vmlinux2.syms
>>>>         KSYMS   .tmp_vmlinux2.kallsyms.S
>>>>         AS      .tmp_vmlinux2.kallsyms.o
>>>>         LD      vmlinux
>>>>         BTFIDS  vmlinux
>>>>       libbpf: failed to find '.BTF' ELF section in vmlinux
>>>>       FAILED: load BTF from vmlinux: No data available
>>>>       make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
>>>>       make[2]: *** Deleting file 'vmlinux'
>>>>       make[1]: *** [/dev/shm/linux/Makefile:1179: vmlinux] Error 2
>>>>       make: *** [Makefile:224: __sub-make] Error 2
>>>>
>>>> Help how to get a successful build is much appreciated.
>>>
>>> I haven't been able to reproduce this one yet with your config;
>>> I tried with bpf-next + gcc-14, then switched to linux stable 6.12y +
>>> gcc 12 as that more closely matched your situation; all works fine for
>>> me. I'll try more precisely matching the gcc 12 version; things worked
>>> fine with pahole v.130 + gcc 12.2.1; from your config looks like you
>>> have gcc 12.3.0.
>>
>> I also tried gcc 14.1.0, and now Linux origin/master (e72e9e6933071
>> (Merge tag 'net-6.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/
>> git/netdev/net)) with gcc 12.3.0. We do build GCC ourselves [1]. Maybe
>> there is something missing?
>>
>> I built with `make V=1` now, and here are the commands:
>>
>> ```
>> $ make V=1
>> […]
>> + ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments -z max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn --script=./arch/x86/kernel/vmlinux.lds -o .tmp_vmlinux1 --whole-archive vmlinux.o .vmlinux.export.o init/version-timestamp.o --no-whole-archive --start-group --end-group .tmp_vmlinux0.kallsyms.o
>> + is_enabled CONFIG_DEBUG_INFO_BTF
>> + grep -q '^CONFIG_DEBUG_INFO_BTF=y' include/config/auto.conf
>> + gen_btf .tmp_vmlinux1
>> + local btf_data=.tmp_vmlinux1.btf.o
>> + info BTF .tmp_vmlinux1.btf.o
>> + printf '  %-7s %s\n' BTF .tmp_vmlinux1.btf.o
>>    BTF     .tmp_vmlinux1.btf.o
>> + LLVM_OBJCOPY=objcopy
>> + pahole -J -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --lang_exclude=rust .tmp_vmlinux1
>> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0) @ 1229728!
>> error decoding cu
>> pahole: .tmp_vmlinux1: Invalid argument
>> […]
>> ```
>>
>> I uploaded `.tmp_vmlinux1` (295 MB) [3].
>>
>> Copying this file to a Debian sid/unstable system with *pahole* 1.30-1,
>> and *llvm-19* 1:19.1.7-3, there is no error.
>>
>>      $ ls -l /usr/bin/llvm-objcopy
>>      lrwxrwxrwx 1 root root 31 Nov 11 12:42 /usr/bin/llvm-objcopy -> ../lib/llvm-19/bin/llvm-objcopy
>>      $ llvm-objcopy --version
>>      llvm-objcopy, compatible with GNU objcopy
>>      Debian LLVM version 19.1.7
>>        Optimized build.
>>
>> In the problematic environment, we have LLVM 18.1.8 installed:
>>
>>      $ llvm-objcopy --version
>>      llvm-objcopy, compatible with GNU objcopy
>>      LLVM (http://llvm.org/):
>>        LLVM version 18.1.8
>>        Optimized build.
> 
> Thanks for the additional info! I tried BTF generation with the
> tmp_vmlinux1 you provided, and all worked okay for me. From the above it
> looks like pahole is using objcopy (LLVM_OBJCOPY=objcopy) rather than
> llvm-objcopy to copy the ELF sections around, so are there differences
> in objcopy version between working/failing systems perhaps? Or other
> library differences in the built pahole on working and failing systems
> revealed by "ldd $(which pahole)"? If we can track down any differences
> like that it might give as a clue as to the source of the issue. Thanks!
After copying the libraries from the Debian system and using 
`LD_LIBRARY_PATH`, and also `libedit.so.2` and `libz3.so.4`, it still 
did not work. Going on, the bpftrace tool `opensnoop.bt` showed 
`/lib/libelf.so.1` to be used:

     113293 pahole             -1   2 
/scratch/local2/pahole/build/libelf.so.1
     113293 pahole             -1   2 glibc-hwcaps/x86-64-v3/libelf.so.1
     113293 pahole             -1   2 glibc-hwcaps/x86-64-v2/libelf.so.1
     113293 pahole             -1   2 tls/x86_64/x86_64/libelf.so.1
     113293 pahole             -1   2 tls/x86_64/libelf.so.1
     113293 pahole             -1   2 tls/x86_64/libelf.so.1
     113293 pahole             -1   2 tls/libelf.so.1
     113293 pahole             -1   2 x86_64/x86_64/libelf.so.1
     113293 pahole             -1   2 x86_64/libelf.so.1
     113293 pahole             -1   2 x86_64/libelf.so.1
     113293 pahole             -1   2 libelf.so.1
     113293 pahole              3   0 /lib/libelf.so.1

     $ ldd /usr/bin/pahole
         linux-vdso.so.1 => linux-vdso.so.1 (0x00007ffeb7ded000)
         libdwarves_emit.so.1 => /lib/libdwarves_emit.so.1 
(0x00007f4c20aa7000)
         libdwarves_reorganize.so.1 => /lib/libdwarves_reorganize.so.1 
(0x00007f4c20aa2000)
         libdwarves.so.1 => /lib/libdwarves.so.1 (0x00007f4c20a70000)
         libdw.so.1 => /lib/libdw.so.1 (0x00007f4c209c7000)
         libelf.so.1 => /lib/libelf.so.1 (0x00007f4c209ab000)
         libz.so.1 => /lib/libz.so.1 (0x00007f4c2098d000)
         libbpf.so.1 => /lib/libbpf.so.1 (0x00007f4c20926000)
         libc.so.6 => /lib/libc.so.6 (0x00007f4c20748000)
         libzstd.so.1 => /lib/libzstd.so.1 (0x00007f4c20657000)
         liblzma.so.5 => /lib/liblzma.so.5 (0x00007f4c20627000)
         libbz2.so.1.0 => /lib/libbz2.so.1.0 (0x00007f4c20614000)
         /lib64/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 
(0x00007f4c20ac6000)

     $ ls -lh /lib/libelf.so.1
     lrwxrwxrwx 1 root root 15 Sep 14  2021 /lib/libelf.so.1 -> 
libelf-0.176.so

Copying `/usr/lib/x86_64-linux-gnu/libelf.so.1` from Debian sid/unstable 
did not help. No idea if it’s related to the GLIBC_2.38 incompatibility 
– we still use 2.36, but ldd showed it nevertheless.

     $ LD_LIBRARY_PATH=/scratch/local2 ldd /usr/bin/pahole
     /usr/bin/pahole: /lib/libc.so.6: version `GLIBC_2.38' not found 
(required by /scratch/local2/libelf.so.1)
         linux-vdso.so.1 => linux-vdso.so.1 (0x00007ffd2310d000)
         libdwarves_emit.so.1 => /lib/libdwarves_emit.so.1 
(0x00007fdd3088b000)
         libdwarves_reorganize.so.1 => /lib/libdwarves_reorganize.so.1 
(0x00007fdd30886000)
         libdwarves.so.1 => /lib/libdwarves.so.1 (0x00007fdd30854000)
         libdw.so.1 => /lib/libdw.so.1 (0x00007fdd307ab000)
         libelf.so.1 => /scratch/local2/libelf.so.1 (0x00007fdd3078d000)
         libz.so.1 => /lib/libz.so.1 (0x00007fdd3076f000)
         libbpf.so.1 => /lib/libbpf.so.1 (0x00007fdd30708000)
         libc.so.6 => /lib/libc.so.6 (0x00007fdd3052a000)
         libzstd.so.1 => /lib/libzstd.so.1 (0x00007fdd30439000)
         liblzma.so.5 => /lib/liblzma.so.5 (0x00007fdd30409000)
         libbz2.so.1.0 => /lib/libbz2.so.1.0 (0x00007fdd303f6000)
         /lib64/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 
(0x00007fdd308aa000)

Anyway, `opensnoop.bt` showd still `/lib/libelf.so.1` to be used, and as 
our version 0.176 is from 2021, I built version 0.193, and now it works! 
In hindsight the error kind of pointed to libdw.so.1, but I confused it 
with `libdwarves.so.1`.

No idea, if and how this version dependency could be checked by pahole 
to log a more easily understandable error message.


Kind regards,

Paul


PS: ldd outpt for the copied `llvm-objcopy`:

$ LD_LIBRARY_PATH=/scratch/local2 ldd /scratch/local2/llvm-objcopy
/scratch/local2/llvm-objcopy: /lib/libc.so.6: version `GLIBC_2.38' not 
found (required by /scratch/local2/libLLVM.so.19.1)
/scratch/local2/llvm-objcopy: /lib/libm.so.6: version `GLIBC_2.38' not 
found (required by /scratch/local2/libLLVM.so.19.1)
/scratch/local2/llvm-objcopy: /lib/libtinfo.so.6: no version information 
available (required by /scratch/local2/libedit.so.2)
/scratch/local2/llvm-objcopy: /lib/libc.so.6: version `GLIBC_2.38' not 
found (required by /scratch/local2/libedit.so.2)
/scratch/local2/llvm-objcopy: /lib/libc.so.6: version `GLIBC_2.38' not 
found (required by /scratch/local2/libz3.so.4)
/scratch/local2/llvm-objcopy: /lib/libstdc++.so.6: version 
`GLIBCXX_3.4.31' not found (required by /scratch/local2/libz3.so.4)
/scratch/local2/llvm-objcopy: /lib/libstdc++.so.6: version 
`GLIBCXX_3.4.32' not found (required by /scratch/local2/libz3.so.4)
/scratch/local2/llvm-objcopy: /lib/libstdc++.so.6: version 
`CXXABI_1.3.15' not found (required by /scratch/local2/libz3.so.4)
	linux-vdso.so.1 => linux-vdso.so.1 (0x00007ffecd598000)
	libLLVM.so.19.1 => /scratch/local2/libLLVM.so.19.1 (0x00007f1369276000)
	libstdc++.so.6 => /lib/libstdc++.so.6 (0x00007f136903a000)
	libm.so.6 => /lib/libm.so.6 (0x00007f1368f58000)
	libgcc_s.so.1 => /lib/libgcc_s.so.1 (0x00007f1368f37000)
	libc.so.6 => /lib/libc.so.6 (0x00007f1368d59000)
	libffi.so.8 => /lib/libffi.so.8 (0x00007f1368d47000)
	libedit.so.2 => /scratch/local2/libedit.so.2 (0x00007f1368d0c000)
	libz3.so.4 => /scratch/local2/libz3.so.4 (0x00007f1367293000)
	libz.so.1 => /lib/libz.so.1 (0x00007f1367275000)
	libzstd.so.1 => /lib/libzstd.so.1 (0x00007f1367184000)
	libxml2.so.2 => /lib/libxml2.so.2 (0x00007f136701e000)
	/lib64/ld-linux-x86-64.so.2 => /lib64/ld-linux-x86-64.so.2 
(0x00007f1370ef7000)
	libtinfo.so.6 => /lib/libtinfo.so.6 (0x00007f1366fed000)
	libbsd.so.0 => /lib/libbsd.so.0 (0x00007f1366fd4000)
	libdl.so.2 => /lib/libdl.so.2 (0x00007f1366fcf000)
	liblzma.so.5 => /lib/liblzma.so.5 (0x00007f1366f9f000)
	librt.so.1 => /lib/librt.so.1 (0x00007f1366f9a000)

