Return-Path: <bpf+bounces-16279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73E7FF32F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F5F1C20F6B
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB451C43;
	Thu, 30 Nov 2023 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="I2l65Dyk"
X-Original-To: bpf@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C585137
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 07:07:13 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1r8idD-0007pk-2U; Thu, 30 Nov 2023 10:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=nnUw97kVtuJZVuBxbOc08Bhf73AoP06hn82YtP1Lp8Y=; b=I2l65DykED4ER0VQOVbI
	kXwhG6lzhIu4JFiWURD7W3rIFK12tZe54v+E0IBlagVLIw8tRi7IMJsc4I2Ro/+yLgy55A0H837TQ
	KLz610FNPK5pw8gwbDTshsv5U93nVrCx6V8OpjKm/ViD8/7E+cQur4KGlwq3pnZZJw5yCef+qWb/4
	pDi2Pdc/UbuXm5+BS/umW8V9KUPhu1YMN3Gboeq7KQal7z4z0JI+llSSRiSDb4nz1zYa11ufowhGe
	5aoN2itws3YAB1FGWSiOmCza5lpHSMqeL/w+0EVm08Mt5dGxTCmXvKVK0OT7YJJ3/2JZNR8XbPR2m
	SlQVESKxek1K1A==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,  bpf@vger.kernel.org
Subject: Re: BPF GCC status - Nov 2023
In-Reply-To: <b1b003f0-dfa7-434f-a03a-1c9e2a21c3bf@linux.dev> (Yonghong Song's
	message of "Thu, 30 Nov 2023 06:58:56 -0800")
References: <87leahx2xh.fsf@oracle.com>
	<3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev>
	<87jzq1t4sk.fsf@oracle.com>
	<a1073bd0-9df2-4a9e-900c-7e8ac63ac464@linux.dev>
	<87h6l3a16n.fsf@gnu.org>
	<b1b003f0-dfa7-434f-a03a-1c9e2a21c3bf@linux.dev>
Date: Thu, 30 Nov 2023 16:06:29 +0100
Message-ID: <87v89j8emi.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> On 11/30/23 7:13 AM, Jose E. Marchesi wrote:
>>> On 11/29/23 2:08 AM, Jose E. Marchesi wrote:
>>>>> On 11/28/23 11:23 AM, Jose E. Marchesi wrote:
>>>>>> [During LPC 2023 we talked about improving communication between the GCC
>>>>>>     BPF toolchain port and the kernel side.  This is the first periodical
>>>>>>     report that we plan to publish in the GCC wiki and send to interested
>>>>>>     parties.  Hopefully this will help.]
>>>>>>
>>>>>> GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
>>>>>> IRC channel: #gccbpf at irc.oftc.net.
>>>>>> Help on using the port: gcc@gcc.gnu.org
>>>>>> Patches and/or development discussions: gcc-patches@gnu.org
>>>>> Thanks a lot for detailed report. Really helpful to nail down
>>>>> issues facing one or both compilers. See comments below for
>>>>> some mentioned issues.
>>>>>
>>>>>> Assembler
>>>>>> =========
>>>>> [...]
>>>>>
>>>>>> - In the Pseudo-C syntax register names are not preceded by % characters
>>>>>>      nor any other prefix.  A consequence of that is that in contexts like
>>>>>>      instruction operands, where both register names and expressions
>>>>>>      involving symbols are expected, there is no way to disambiguate
>>>>>>      between them.  GAS was allowing symbols like `w3' or `r5' in syntactic
>>>>>>      contexts where no registers were expected, such as in:
>>>>>>
>>>>>>        r0 = w3 ll  ; GAS interpreted w3 as symbol, clang emits error
>>>>>>
>>>>>>      The clang assembler wasn't allowing that.  During LPC we agreed that
>>>>>>      the simplest approach is to not allow any symbol to have the same name
>>>>>>      than a register, in any context.  So we changed GAS so it now doesn't
>>>>>>      allow to use register names as symbols in any expression, such as:
>>>>>>
>>>>>>        r0 = w3 + 1 ll  ; This now fails for both GAS and llvm.
>>>>>>        r0 = 1 + w3 ll  ; NOTE this does not fail with llvm, but it should.
>>>>> Could you provide a reproducible case above for llvm? llvm does not
>>>>> support syntax like 'r0 = 1 + w3 ll'. For add, it only supports
>>>>> 'r1 += r2' or 'r1 += 100' syntax.
>>>> It is a 128-bit load with an expression.  In compiler explorer, clang:
>>>>
>>>>     int
>>>>     foo ()
>>>>     {
>>>>       asm volatile ("r1 = 10 + w3 ll");
>>>>       return 0;
>>>>     }
>>>>
>>>> I get:
>>>>
>>>>     foo:                                    # @foo
>>>>             r1 = 10+w3 ll
>>>>             r0 = 0
>>>>             exit
>>>>
>>>> i.e. `10 + w3' is interpreted as an expression with two operands: the
>>>> literal number 10 and a symbol (not a register) `w3'.
>>>>
>>>> If the expression is `w3+10' instead, your parser recognizes the w3 as a
>>>> register name and errors out, as expected.
>>>>
>>>> I suppose llvm allows to hook on the expression parser to handle
>>>> individual operands.  That's how we handled this in GAS.
>>> Thanks for the code. I can reproduce the result with compiler explorer.
>>> The following is the link https://godbolt.org/z/GEGexf1Pj
>>> where I added -grecord-gcc-switches to dump compilation flags
>>> into .s file.
>>>
>>> The following is the compiler explorer compilation command line:
>>> /opt/compiler-explorer/clang-trunk-20231129/bin/clang-18 -g -o /app/output.s \
>>>    -S --target=bpf -fcolor-diagnostics -gen-reproducer=off -O2 \
>>>    -g -grecord-command-line /app/example.c
>>>
>>> I then compile the above C code with
>>>    clang -g -S --target=bpf -fcolor-diagnostics -gen-reproducer=off -O2 -g -grecord-command-line t.c
>>> with identical flags.
>>>
>>> I tried locally with llvm16/17/18. They all failed compilation since
>>> 'r1 = 10+w3 ll' cannot be recognized by the llvm.
>>> We will investigate why llvm18 in compiler explorer compiles
>>> differently from my local build.
>> I updated git llvm master today and I managed to reproduce locally with:
>>
>> jemarch@termi:~/gnu/src/llvm-project/llvm/build$ clang --version
>> clang version 18.0.0 (https://github.com/llvm/llvm-project.git 586986a063ee4b9a7490aac102e103bab121c764)
>> Target: unknown
>> Thread model: posix
>> InstalledDir: /usr/local/bin
>> $ cat foo.c
>>      int
>>      foo ()
>>      {
>>        asm volatile ("r1 = 10 + w3 ll");
>>        return 0;
>>      }
>> $ clang -target bpf -c foo.c
>> $ llvm-objdump -dr foo.o
>>
>> foo.o:	file format elf64-bpf
>>
>> Disassembly of section .text:
>>
>> 0000000000000000 <foo>:
>>         0:	18 01 00 00 0a 00 00 00 00 00 00 00 00 00 00 00	r1 = 0xa ll
>> 		0000000000000000:  R_BPF_64_64	w3
>>         2:	b7 00 00 00 00 00 00 00	r0 = 0x0
>>         3:	95 00 00 00 00 00 00 00	exit
>
> Could you share the cmake command line options when you build you clang?
> My cmake command line looks like
> cmake .. -DCMAKE_BUILD_TYPE=Release -G Ninja \
>     -DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt" \
>     -DLLVM_TARGETS_TO_BUILD="BPF;X86" \
>     -DLLVM_ENABLE_ASSERTIONS=ON \
>     -DLLVM_ENABLE_ZLIB=ON \
>     -DCMAKE_INSTALL_PREFIX=$PWD/install
>
> and cannot reproduce the issue.

I don't have the original cmake command, I executed it long ago
(rebuilding clang/llvm in my laptop takes three days or more so I do it
incrementally.)

I see this in my CMakeCache.txt:

  LLVM_ENABLE_PROJECTS:STRING=clang
  LLVM_TARGETS_TO_BUILD:STRING=BPF
  LLVM_ENABLE_ASSERTIONS:BOOL=OFF
  LLVM_ENABLE_ZLIB:STRING=ON
  CMAKE_INSTALL_PREFIX:PATH=/usr/local

