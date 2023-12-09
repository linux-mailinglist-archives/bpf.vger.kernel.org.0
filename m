Return-Path: <bpf+bounces-17313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CFE80B21A
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 06:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C911F213D5
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB017CA;
	Sat,  9 Dec 2023 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Llcdg0VG"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723EB10E6
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 21:05:05 -0800 (PST)
Message-ID: <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702098303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqPA0UsMu88ho3EdDO911whDmHjUPGJpwhbfnoFdXz0=;
	b=Llcdg0VGS1szLlhNsM0txB/mkQzSK1RinKmeFGhZCqC6EAu7CidIMlUlNjvq0L7P9BJrBs
	D8rsg/+rCVK03N3DchCOYdo7y5ZBnS1KMJqrncDeTTnhnl2VxwZM4pTnvZoMMD4YBY28xy
	ks5v3W553mWUjsRAQ678VUIEsSLPzeo=
Date: Fri, 8 Dec 2023 21:04:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
 <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 8:25 PM, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 8:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 12/8/23 8:05 PM, Alexei Starovoitov wrote:
>>> On Fri, Dec 8, 2023 at 2:04 PM Andrii Nakryiko
>>> <andrii.nakryiko@gmail.com> wrote:
>>>> I feel like embedding some sort of ID inside the instruction is very..
>>>> unusual, shall we say?
>>> yeah. no magic numbers inside insns pls.
>>>
>>> I don't like JA_CFG name, since I read CFG as control flow graph,
>>> while you probably meant CFG as configurable.
>>> How about BPF_JA_OR_NOP ?
>>> Then in combination with BPF_JMP or BPF_JMP32 modifier
>>> the insn->off|imm will be used.
>>> 1st bit in src_reg can indicate the default action: nop or jmp.
>>> In asm it may look like asm("goto_or_nop +5")
>> How does the C source code looks like in order to generate
>> BPF_JA_OR_NOP insn? Any source examples?
> It will be in inline asm only. The address of that insn will
> be taken either via && or via asm (".long %l[label]").
>  From llvm pov both should go through the same relo creation logic. I hope :)

A hack in llvm below with an example, could you check whether the C 
syntax and object dump result
is what you want to see?

diff --git a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp 
b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
index 90697c6645be..38b1cbc31f9a 100644
--- a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
+++ b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
@@ -231,6 +231,7 @@ public:
          .Case("call", true)
          .Case("goto", true)
          .Case("gotol", true)
+        .Case("goto_or_nop", true)
          .Case("*", true)
          .Case("exit", true)
          .Case("lock", true)
@@ -259,6 +260,7 @@ public:
          .Case("bswap64", true)
          .Case("goto", true)
          .Case("gotol", true)
+        .Case("goto_or_nop", true)
          .Case("ll", true)
          .Case("skb", true)
          .Case("s", true)
diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td 
b/llvm/lib/Target/BPF/BPFInstrInfo.td
index 5972c9d49c51..a953d10429bf 100644
--- a/llvm/lib/Target/BPF/BPFInstrInfo.td
+++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
@@ -592,6 +592,19 @@ class BRANCH<BPFJumpOp Opc, string OpcodeStr, 
list<dag> Pattern>
    let BPFClass = BPF_JMP;
  }

+class BRANCH_OR_NOP<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
+    : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
+                   (outs),
+                   (ins brtarget:$BrDst),
+                   !strconcat(OpcodeStr, " $BrDst"),
+                   Pattern> {
+  bits<16> BrDst;
+
+  let Inst{47-32} = BrDst;
+  let Inst{31-0} = 1;
+  let BPFClass = BPF_JMP;
+}
+
  class BRANCH_LONG<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
      : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
                     (outs),
@@ -632,6 +645,7 @@ class CALLX<string OpcodeStr>
  let isBranch = 1, isTerminator = 1, hasDelaySlot=0, isBarrier = 1 in {
    def JMP : BRANCH<BPF_JA, "goto", [(br bb:$BrDst)]>;
    def JMPL : BRANCH_LONG<BPF_JA, "gotol", []>;
+  def JMP_OR_NOP : BRANCH_OR_NOP<BPF_JA, "goto_or_nop", []>;
  }

  // Jump and link


And an example,

[ ~/tmp1/gotol]$ cat t.c
int bar(void);
int foo()
{
         int a, b;

         asm volatile goto ("r0 = 0; \
                             goto_or_nop %l[label]; \
                             r2 = 2; \
                             r3 = 3; \
"::::label);
         a = bar();
label:
         b = 20 * a;
         return b;
}
[ ~/tmp1/gotol]$ clang --target=bpf -O2 -S t.c
[ ~/tmp1/gotol]$ cat t.s
         .text
         .file   "t.c"
         .globl  foo                             # -- Begin function foo
         .p2align        3
         .type   foo,@function
foo:                                    # @foo
# %bb.0:                                # %entry
         r0 = 0
         #APP
         r0 = 0
         goto_or_nop LBB0_2
         r2 = 2
         r3 = 3

         #NO_APP
# %bb.1:                                # %asm.fallthrough
         call bar
         r0 *= 20
LBB0_2:                                 # Block address taken
                                         # %label
                                         # Label of block must be emitted
         exit
.Lfunc_end0:
         .size   foo, .Lfunc_end0-foo
                                         # -- End function
         .addrsig
[ ~/tmp1/gotol]$ clang --target=bpf -O2 -c t.c
[ ~/tmp1/gotol]$ llvm-objdump -dr t.o

t.o:    file format elf64-bpf

Disassembly of section .text:

0000000000000000 <foo>:
        0:       b7 00 00 00 00 00 00 00 r0 = 0x0
        1:       b7 00 00 00 00 00 00 00 r0 = 0x0
        2:       05 00 04 00 01 00 00 00 goto_or_nop +0x4 <LBB0_2>
        3:       b7 02 00 00 02 00 00 00 r2 = 0x2
        4:       b7 03 00 00 03 00 00 00 r3 = 0x3
        5:       85 10 00 00 ff ff ff ff call -0x1
                 0000000000000028:  R_BPF_64_32  bar
        6:       27 00 00 00 14 00 00 00 r0 *= 0x14

0000000000000038 <LBB0_2>:
        7:       95 00 00 00 00 00 00 00 exit
[ ~/tmp1/gotol]$



