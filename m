Return-Path: <bpf+bounces-16292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01B7FF875
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D955B2105E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D635810B;
	Thu, 30 Nov 2023 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w/fHai8k"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02207131
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 09:39:15 -0800 (PST)
Message-ID: <840e33ec-ea4c-4b55-bda1-0be8d1e0324f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701365954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfWUC30JUSCmwoYj4vKyiknlvKqWv4pfeoM/YirSLtM=;
	b=w/fHai8kY3V7PTbNp43G1IX2sCvWmX9nqtBOUYRQE1LGUFdwMfUw/nNGuz6u2X9XR/r+ly
	rP9Z+3wGm2rAa0KvDv7vWW/uLkQ63+kT8gzEDx6bsu3Hz9STXZttB5x2MkSXOFCyLT480x
	ICf+N+XchtDNz311TYHyzcBGB6B3uu4=
Date: Thu, 30 Nov 2023 09:39:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF GCC status - Nov 2023
Content-Language: en-GB
To: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
References: <87leahx2xh.fsf@oracle.com>
 <3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev> <87jzq1t4sk.fsf@oracle.com>
 <a1073bd0-9df2-4a9e-900c-7e8ac63ac464@linux.dev> <87h6l3a16n.fsf@gnu.org>
 <b1b003f0-dfa7-434f-a03a-1c9e2a21c3bf@linux.dev> <87v89j8emi.fsf@gnu.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87v89j8emi.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/30/23 10:06 AM, Jose E. Marchesi wrote:
>> On 11/30/23 7:13 AM, Jose E. Marchesi wrote:
>>>> On 11/29/23 2:08 AM, Jose E. Marchesi wrote:
>>>>>> On 11/28/23 11:23 AM, Jose E. Marchesi wrote:
>>>>>>> [During LPC 2023 we talked about improving communication between the GCC
>>>>>>>      BPF toolchain port and the kernel side.  This is the first periodical
>>>>>>>      report that we plan to publish in the GCC wiki and send to interested
>>>>>>>      parties.  Hopefully this will help.]
>>>>>>>
>>>>>>> GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
>>>>>>> IRC channel: #gccbpf at irc.oftc.net.
>>>>>>> Help on using the port: gcc@gcc.gnu.org
>>>>>>> Patches and/or development discussions: gcc-patches@gnu.org
>>>>>> Thanks a lot for detailed report. Really helpful to nail down
>>>>>> issues facing one or both compilers. See comments below for
>>>>>> some mentioned issues.
>>>>>>
>>>>>>> Assembler
>>>>>>> =========
>>>>>> [...]
>>>>>>
>>>>>>> - In the Pseudo-C syntax register names are not preceded by % characters
>>>>>>>       nor any other prefix.  A consequence of that is that in contexts like
>>>>>>>       instruction operands, where both register names and expressions
>>>>>>>       involving symbols are expected, there is no way to disambiguate
>>>>>>>       between them.  GAS was allowing symbols like `w3' or `r5' in syntactic
>>>>>>>       contexts where no registers were expected, such as in:
>>>>>>>
>>>>>>>         r0 = w3 ll  ; GAS interpreted w3 as symbol, clang emits error
>>>>>>>
>>>>>>>       The clang assembler wasn't allowing that.  During LPC we agreed that
>>>>>>>       the simplest approach is to not allow any symbol to have the same name
>>>>>>>       than a register, in any context.  So we changed GAS so it now doesn't
>>>>>>>       allow to use register names as symbols in any expression, such as:
>>>>>>>
>>>>>>>         r0 = w3 + 1 ll  ; This now fails for both GAS and llvm.
>>>>>>>         r0 = 1 + w3 ll  ; NOTE this does not fail with llvm, but it should.
>>>>>> Could you provide a reproducible case above for llvm? llvm does not
>>>>>> support syntax like 'r0 = 1 + w3 ll'. For add, it only supports
>>>>>> 'r1 += r2' or 'r1 += 100' syntax.
>>>>> It is a 128-bit load with an expression.  In compiler explorer, clang:
>>>>>
>>>>>      int
>>>>>      foo ()
>>>>>      {
>>>>>        asm volatile ("r1 = 10 + w3 ll");
>>>>>        return 0;
>>>>>      }
>>>>>
>>>>> I get:
>>>>>
>>>>>      foo:                                    # @foo
>>>>>              r1 = 10+w3 ll
>>>>>              r0 = 0
>>>>>              exit
>>>>>
>>>>> i.e. `10 + w3' is interpreted as an expression with two operands: the
>>>>> literal number 10 and a symbol (not a register) `w3'.
>>>>>
>>>>> If the expression is `w3+10' instead, your parser recognizes the w3 as a
>>>>> register name and errors out, as expected.
>>>>>
>>>>> I suppose llvm allows to hook on the expression parser to handle
>>>>> individual operands.  That's how we handled this in GAS.
>>>> Thanks for the code. I can reproduce the result with compiler explorer.
>>>> The following is the link https://godbolt.org/z/GEGexf1Pj
>>>> where I added -grecord-gcc-switches to dump compilation flags
>>>> into .s file.
>>>>
>>>> The following is the compiler explorer compilation command line:
>>>> /opt/compiler-explorer/clang-trunk-20231129/bin/clang-18 -g -o /app/output.s \
>>>>     -S --target=bpf -fcolor-diagnostics -gen-reproducer=off -O2 \
>>>>     -g -grecord-command-line /app/example.c
>>>>
>>>> I then compile the above C code with
>>>>     clang -g -S --target=bpf -fcolor-diagnostics -gen-reproducer=off -O2 -g -grecord-command-line t.c
>>>> with identical flags.
>>>>
>>>> I tried locally with llvm16/17/18. They all failed compilation since
>>>> 'r1 = 10+w3 ll' cannot be recognized by the llvm.
>>>> We will investigate why llvm18 in compiler explorer compiles
>>>> differently from my local build.
>>> I updated git llvm master today and I managed to reproduce locally with:
>>>
>>> jemarch@termi:~/gnu/src/llvm-project/llvm/build$ clang --version
>>> clang version 18.0.0 (https://github.com/llvm/llvm-project.git 586986a063ee4b9a7490aac102e103bab121c764)
>>> Target: unknown
>>> Thread model: posix
>>> InstalledDir: /usr/local/bin
>>> $ cat foo.c
>>>       int
>>>       foo ()
>>>       {
>>>         asm volatile ("r1 = 10 + w3 ll");
>>>         return 0;
>>>       }
>>> $ clang -target bpf -c foo.c
>>> $ llvm-objdump -dr foo.o
>>>
>>> foo.o:	file format elf64-bpf
>>>
>>> Disassembly of section .text:
>>>
>>> 0000000000000000 <foo>:
>>>          0:	18 01 00 00 0a 00 00 00 00 00 00 00 00 00 00 00	r1 = 0xa ll
>>> 		0000000000000000:  R_BPF_64_64	w3
>>>          2:	b7 00 00 00 00 00 00 00	r0 = 0x0
>>>          3:	95 00 00 00 00 00 00 00	exit
>> Could you share the cmake command line options when you build you clang?
>> My cmake command line looks like
>> cmake .. -DCMAKE_BUILD_TYPE=Release -G Ninja \
>>      -DLLVM_ENABLE_PROJECTS="clang;lld;compiler-rt" \
>>      -DLLVM_TARGETS_TO_BUILD="BPF;X86" \
>>      -DLLVM_ENABLE_ASSERTIONS=ON \
>>      -DLLVM_ENABLE_ZLIB=ON \
>>      -DCMAKE_INSTALL_PREFIX=$PWD/install
>>
>> and cannot reproduce the issue.
> I don't have the original cmake command, I executed it long ago
> (rebuilding clang/llvm in my laptop takes three days or more so I do it
> incrementally.)
>
> I see this in my CMakeCache.txt:
>
>    LLVM_ENABLE_PROJECTS:STRING=clang
>    LLVM_TARGETS_TO_BUILD:STRING=BPF
>    LLVM_ENABLE_ASSERTIONS:BOOL=OFF
>    LLVM_ENABLE_ZLIB:STRING=ON
>    CMAKE_INSTALL_PREFIX:PATH=/usr/local

Thanks for your cmake command line options. Looks like the reason is due to LLVM_ENABLE_ASSERTIONS=OFF while in my case
LLVM_ENABLE_ASSERTIONS=ON.

The related function in llvm is:

static void printExpr(const MCExpr *Expr, raw_ostream &O) {
#ifndef NDEBUG
   const MCSymbolRefExpr *SRE;

   if (const MCBinaryExpr *BE = dyn_cast<MCBinaryExpr>(Expr))
     SRE = dyn_cast<MCSymbolRefExpr>(BE->getLHS());
   else
     SRE = dyn_cast<MCSymbolRefExpr>(Expr);
   assert(SRE && "Unexpected MCExpr type.");

   MCSymbolRefExpr::VariantKind Kind = SRE->getKind();

   assert(Kind == MCSymbolRefExpr::VK_None);
#endif
   O << *Expr;
}

If LLVM_ENABLE_ASSERTIONS=ON, NDEBUG will not be defined
and 'assert' will actually do assertion.
If LLVM_ENABLE_ASSERTIONS=OFF, NDEBUG will be defined
and 'assert' will be a noop.

That is why ASSERTIONS OFF flag is okay while ASSERTIONS ON
will cause the following error:
    $ clang --target=bpf -g -S -O2 t.c
    clang: ../lib/Target/BPF/MCTargetDesc/BPFInstPrinter.cpp:46: void printExpr(const llvm::MCExpr*, llvm::raw_ostream&):
        Assertion `SRE && "Unexpected MCExpr type."' failed.
    .... stack trace etc. ....

I also tried with my local redhat built clang15 and it didn't produce error either.
   $ /bin/clang --target=bpf -g -S -O2 t.c
   $ rpm -qf /bin/clang
   clang-16.0.6-1.el9.x86_64
Looks like their cmake options does not have LLVM_ENABLE_ASSERTIONS at all
which I assume is OFF. See
   https://gitlab.com/redhat/centos-stream/rpms/clang/-/blob/4fcf8241b99430ba239c5461b962fea1f3107a22/clang.spec

clang really does not support this syntax:
    r1 = 10 + w3 ll

The following clang patch will emit error regardless of LLVM_ENABLE_ASSERTIONS value.

======

diff --git a/llvm/lib/Target/BPF/MCTargetDesc/BPFInstPrinter.cpp b/llvm/lib/Target/BPF/MCTargetDesc/BPFInstPrinter.cpp
index 15ab55f95e69..c266538bec73 100644
--- a/llvm/lib/Target/BPF/MCTargetDesc/BPFInstPrinter.cpp
+++ b/llvm/lib/Target/BPF/MCTargetDesc/BPFInstPrinter.cpp
@@ -36,15 +36,16 @@ void BPFInstPrinter::printInst(const MCInst *MI, uint64_t Address,
  }
  
  static void printExpr(const MCExpr *Expr, raw_ostream &O) {
-#ifndef NDEBUG
    const MCSymbolRefExpr *SRE;
  
    if (const MCBinaryExpr *BE = dyn_cast<MCBinaryExpr>(Expr))
      SRE = dyn_cast<MCSymbolRefExpr>(BE->getLHS());
    else
      SRE = dyn_cast<MCSymbolRefExpr>(Expr);
-  assert(SRE && "Unexpected MCExpr type.");
+  if (!SRE)
+    report_fatal_error("Unexpected MCExpr type.");
  
+#ifndef NDEBUG
    MCSymbolRefExpr::VariantKind Kind = SRE->getKind();
  
    assert(Kind == MCSymbolRefExpr::VK_None);

=======


