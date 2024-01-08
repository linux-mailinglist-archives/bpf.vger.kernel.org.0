Return-Path: <bpf+bounces-19223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BE6827A21
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2401C228BB
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7D55E78;
	Mon,  8 Jan 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LopNJXUT"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A255E70
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc6ce5dc-afb9-4b5b-a99a-1577b99f6a96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704748899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmv99/IyXN5S4H0kx5eoL5JBkKG28IKLZbgxxVMU0EQ=;
	b=LopNJXUTkjAcaZuWRapFLq+kRwpr/7lIUOpAMhlt5SC0OGfJ7vHG4YTg8TmN2UmwOdXHcB
	pTplpws3h9+SXrAipv2uo7ZYrXn5ZzUQz4W9TYO399rPBQl/0sxq2enzY5LxfNxGd7fEi9
	dnPtODRsvxD7UFWnV7owf+R0e+OBLlw=
Date: Mon, 8 Jan 2024 13:21:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/5/24 1:47 PM, Eduard Zingerman wrote:
> On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
> [...]
>> It turned out there are indeed a bunch of redundant shifts
>> when u32 or s32 is passed into "r" asm constraint.
>>
>> Strangely the shifts are there when compiled with -mcpu=v3 or v4
>> and no shifts with -mcpu=v1 and v2.
>>
>> Also weird that u8 and u16 are passed into "r" without redundant shifts.
>> Hence I found a "workaround": cast u32 into u16 while passing.
>> The truncation of u32 doesn't happen and shifts to zero upper 32-bit
>> are gone as well.
>>
>> https://godbolt.org/z/Kqszr6q3v
> Regarding unnecessary shifts.
> Sorry, a long email about minor feature/defect.
>
> So, currently the following C program
> (and it's variations with implicit casts):
>
>      extern unsigned long bar(void);
>      void foo(void) {
>        asm volatile ("%[reg] += 1"::[reg]"r"((unsigned)bar()));
>      }
>
> Is translated to the following BPF:
>
>      $ clang -mcpu=v3 -O2 --target=bpf -mcpu=v3 -c -o - t.c | llvm-objdump --no-show-raw-insn -d -
>      
>      <stdin>:	file format elf64-bpf
>      
>      Disassembly of section .text:
>      
>      0000000000000000 <foo>:
>             0:	call -0x1
>             1:	r0 <<= 0x20
>             2:	r0 >>= 0x20
>             3:	r0 += 0x1
>             4:	exit
>             
> Note: no additional shifts are generated when "w" (32-bit register)
>        constraint is used instead of "r".
>
> First, is this right or wrong?
> ------------------------------
>
> C language spec [1] paragraph 6.5.4.6 (Cast operators -> Semantics) says
> the following:
>
>    If the value of the expression is represented with greater range or
>    precision than required by the type named by the cast (6.3.1.8),
>    then the cast specifies a conversion even if the type of the
>    expression is the same as the named type and removes any extra range
>    and precision.                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    ^^^^^^^^^^^^^
>    
> What other LLVM backends do in such situations?
> Consider the following program translated to amd64 [2] and aarch64 [3]:
>
>      void foo(void) {
>        asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned long)  bar())); // 1
>        asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned int)   bar())); // 2
>        asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned short) bar())); // 3
>      }
>
> - for amd64 register of proper size is selected for `reg`;
> - for aarch64 warnings about wrong operand size are emitted at (2) and (3)
>    and 64-bit register is used w/o generating any additional instructions.
>
> (Note, however, that 'arm' silently ignores the issue and uses 32-bit
>   registers for all three points).
>
> So, it looks like that something of this sort should be done:
> - either extra precision should be removed via additional instructions;
> - or 32-bit register should be picked for `reg`;
> - or warning should be emitted as in aarch64 case.
>
> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
> [2] https://godbolt.org/z/9nKxaMc5j
> [3] https://godbolt.org/z/1zxEr5b3f
>
>
> Second, what to do?
> -------------------
>
> I think that the following steps are needed:
> - Investigation described in the next section shows that currently two
>    shifts are generated accidentally w/o real intent to shed precision.
>    I have a patch [6] that removes shifts generation, it should be applied.
> - When 32-bit value is passed to "r" constraint:
>    - for cpu v3/v4 a 32-bit register should be selected;
>    - for cpu v1/v2 a warning should be reported.
>
>
> Third, why two shifts are generated?
> ------------------------------------
>
> (Details here might be interesting to Yonghong, regular reader could
>   skip this section).
>
> The two shifts are result of interaction between two IR constructs
> `trunc` and `asm`. The C program above looks as follows in LLVM IR
> before machine code generation:
>
>      declare dso_local i64 @bar()
>      define dso_local void @foo(i32 %p) {
>      entry:
>        %call = call i64 @bar()
>        %v32 = trunc i64 %call to i32
>        tail call void asm sideeffect "$0 += 1", "r"(i32 %v32)
>        ret void
>      }
>
> Initial selection DAG:
>
>      $ llc -debug-only=isel -march=bpf -mcpu=v3 --filetype=asm -o - t.ll
>      SelectionDAG has 21 nodes:
>        ...
>        t10: i64,ch,glue = CopyFromReg t8, Register:i64 $r0, t8:1
>     !     t11: i32 = truncate t10
>     !    t15: i64 = zero_extend t11
>        t17: ch,glue = CopyToReg t10:1, Register:i64 %1, t15
>          t19: ch,glue = inlineasm t17, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>                           TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t17:1
>        ...
>
> Note values t11 and t15 marked with (!).
>
> Optimized lowered selection DAG for this fragment:
>
>      t10: i64,ch,glue = CopyFromReg t8, Register:i64 $r0, t8:1
>    !   t22: i64 = and t10, Constant:i64<4294967295>
>      t17: ch,glue = CopyToReg t10:1, Register:i64 %1, t22
>        t19: ch,glue = inlineasm t17, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>                         TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t17:1
>
> Note (zext (truncate ...)) converted to (and ... 0xffff_ffff).
>
> DAG after instruction selection:
>
>      t10: i64,ch,glue = CopyFromReg t8:1, Register:i64 $r0, t8:2
>    !     t25: i64 = SLL_ri t10, TargetConstant:i64<32>
>    !   t22: i64 = SRL_ri t25, TargetConstant:i64<32>
>      t17: ch,glue = CopyToReg t10:1, Register:i64 %1, t22
>        t23: ch,glue = inlineasm t17, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>                         TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t17:1
>
> Note (and ... 0xffff_ffff) converted to (SRL_ri (SLL_ri ...)).
> This happens because of the following pattern from BPFInstrInfo.td:
>
>      // 0xffffFFFF doesn't fit into simm32, optimize common case
>      def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
>                (SRL_ri (SLL_ri (i64 GPR:$src), 32), 32)>;
>
> So, the two shift instructions are result of translation of (zext (trunc ...)).
> However, closer examination shows that zext DAG node was generated
> almost by accident. Here is the backtrace for when this node was created:
>
>      Breakpoint 1, llvm::SelectionDAG::getNode (... Opcode=202) ;; 202 is opcode for ZERO_EXTEND
>          at .../SelectionDAG.cpp:5605
>      (gdb) bt
>      #0  llvm::SelectionDAG::getNode (...)
>          at ...SelectionDAG.cpp:5605
>      #1  0x... in getCopyToParts (..., ExtendKind=llvm::ISD::ZERO_EXTEND)
>          at .../SelectionDAGBuilder.cpp:537
>      #2  0x... in llvm::RegsForValue::getCopyToRegs (... PreferredExtendType=llvm::ISD::ANY_EXTEND)
>          at .../SelectionDAGBuilder.cpp:958
>      #3  0x... in llvm::SelectionDAGBuilder::visitInlineAsm(...)
>          at .../SelectionDAGBuilder.cpp:9640
>          ...
>
> The stack frame #2 is interesting, here is the code for it [4]:
>
>      void RegsForValue::getCopyToRegs(SDValue Val, SelectionDAG &DAG,
>                                       const SDLoc &dl, SDValue &Chain, SDValue *Glue,
>                                       const Value *V,
>                                       ISD::NodeType PreferredExtendType) const {
>                                                     ^
>                                                     '-- this is ANY_EXTEND
>        ...
>        for (unsigned Value = 0, Part = 0, e = ValueVTs.size(); Value != e; ++Value) {
>          ...
>                                                     .-- this returns true
>                                                     v
>          if (ExtendKind == ISD::ANY_EXTEND && TLI.isZExtFree(Val, RegisterVT))
>            ExtendKind = ISD::ZERO_EXTEND;
>      
>                                 .-- this is ZERO_EXTEND
>                                 v
>          getCopyToParts(..., ExtendKind);
>          Part += NumParts;
>        }
>        ...
>      }
>
> The getCopyToRegs() function was called with ANY_EXTEND preference,
> but switched to ZERO_EXTEND because TLI.isZExtFree() currently returns
> true for any 32 to 64-bit conversion [5].
> However, in this case this is clearly a mistake, as zero extension of
> (zext i64 (truncate i32 ...)) costs two instructions.
>
> The isZExtFree() behavior could be changed to report false for such
> situations, as in my patch [6]. This in turn removes zext =>
> removes two shifts from final asm.
> Here is how DAG/asm look after patch [6]:
>
>      Initial selection DAG:
>        ...
>        t10: i64,ch,glue = CopyFromReg t8, Register:i64 $r0, t8:1
>    !   t11: i32 = truncate t10
>        t16: ch,glue = CopyToReg t10:1, Register:i64 %1, t10
>          t18: ch,glue = inlineasm t16, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>                           TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t16:1
>        ...
>      
> Final asm:
>
>      ...
>      # %bb.0:
>      	call bar
>      	#APP
>      	r0 += 1
>      	#NO_APP
>      	exit
>      ...

Thanks for the detailed analysis! Previously we intend to do the following:

- When 32-bit value is passed to "r" constraint:
   - for cpu v3/v4 a 32-bit register should be selected;
   - for cpu v1/v2 a warning should be reported.

So in the above, the desired asm code should be

     ...
     # %bb.0:
     	call bar
     	#APP
     	w0 += 1
     	#NO_APP
     	exit
     ...

for cpuv3/cpuv4. I guess some more work in llvm is needed
to achieve that.

On the other hand, for cpuv3/v4, for regular C code,
I think the compiler might be already omitting the conversion and use w
register already. So I am not sure whether the patch [6]
is needed or not. Could you double check?

>      
> Note that [6] is a very minor change, it does not affect code
> generation for selftests at all and I was unable to conjure examples
> where it has effect aside from inline asm parameters.
>
> [4] https://github.com/llvm/llvm-project/blob/365fbbfbcfefb8766f7716109b9c3767b58e6058/llvm/lib/CodeGen/SelectionDAG/SelectionDAGBuilder.cpp#L937C10-L937C10
> [5] https://github.com/llvm/llvm-project/blob/6f4cc1310b12bc59210e4596a895db4cb9ad6075/llvm/lib/Target/BPF/BPFISelLowering.cpp#L213C21-L213C21
> [6] https://github.com/llvm/llvm-project/commit/cf8e142e5eac089cc786c671a40fef022d08b0ef
>

