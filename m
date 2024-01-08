Return-Path: <bpf+bounces-19233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5658827B85
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3041BB2313D
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 23:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0658214;
	Mon,  8 Jan 2024 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whMtJQvz"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A295811C
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7f24431-9103-4f1f-8936-ad731a993e3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704756186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdvANYXLmn7twfMElhrn4m2Tj038cyAbQY2iU5ArmuA=;
	b=whMtJQvzrCecII8Tq+lsO1sUQyhvGys3ZJUkNygz+A32893LJdaiskYSdYLhVth3ISSQax
	gVTU+MAVQ7+XgtamOouWWX4H4RiG/8AjafFUK8FQ4VLDSU1mE/E/lRTWSj9TePkUIFA2y4
	aXvGInqyiDG1C15fq0XBUXAif56sgqY=
Date: Mon, 8 Jan 2024 15:22:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 Kernel Team <kernel-team@fb.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/8/24 1:33 PM, Alexei Starovoitov wrote:
> On Fri, Jan 5, 2024 at 1:47 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
>> [...]
>>> It turned out there are indeed a bunch of redundant shifts
>>> when u32 or s32 is passed into "r" asm constraint.
>>>
>>> Strangely the shifts are there when compiled with -mcpu=v3 or v4
>>> and no shifts with -mcpu=v1 and v2.
>>>
>>> Also weird that u8 and u16 are passed into "r" without redundant shifts.
>>> Hence I found a "workaround": cast u32 into u16 while passing.
>>> The truncation of u32 doesn't happen and shifts to zero upper 32-bit
>>> are gone as well.
>>>
>>> https://godbolt.org/z/Kqszr6q3v
>> Regarding unnecessary shifts.
>> Sorry, a long email about minor feature/defect.
>>
>> So, currently the following C program
>> (and it's variations with implicit casts):
>>
>>      extern unsigned long bar(void);
>>      void foo(void) {
>>        asm volatile ("%[reg] += 1"::[reg]"r"((unsigned)bar()));
>>      }
>>
>> Is translated to the following BPF:
>>
>>      $ clang -mcpu=v3 -O2 --target=bpf -mcpu=v3 -c -o - t.c | llvm-objdump --no-show-raw-insn -d -
>>
>>      <stdin>:    file format elf64-bpf
>>
>>      Disassembly of section .text:
>>
>>      0000000000000000 <foo>:
>>             0:   call -0x1
>>             1:   r0 <<= 0x20
>>             2:   r0 >>= 0x20
>>             3:   r0 += 0x1
>>             4:   exit
>>
>> Note: no additional shifts are generated when "w" (32-bit register)
>>        constraint is used instead of "r".
>>
>> First, is this right or wrong?
>> ------------------------------
>>
>> C language spec [1] paragraph 6.5.4.6 (Cast operators -> Semantics) says
>> the following:
>>
>>    If the value of the expression is represented with greater range or
>>    precision than required by the type named by the cast (6.3.1.8),
>>    then the cast specifies a conversion even if the type of the
>>    expression is the same as the named type and removes any extra range
>>    and precision.                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>    ^^^^^^^^^^^^^
>>
>> What other LLVM backends do in such situations?
>> Consider the following program translated to amd64 [2] and aarch64 [3]:
>>
>>      void foo(void) {
>>        asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned long)  bar())); // 1
>>        asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned int)   bar())); // 2
>>        asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned short) bar())); // 3
>>      }
>>
>> - for amd64 register of proper size is selected for `reg`;
>> - for aarch64 warnings about wrong operand size are emitted at (2) and (3)
>>    and 64-bit register is used w/o generating any additional instructions.
>>
>> (Note, however, that 'arm' silently ignores the issue and uses 32-bit
>>   registers for all three points).
>>
>> So, it looks like that something of this sort should be done:
>> - either extra precision should be removed via additional instructions;
>> - or 32-bit register should be picked for `reg`;
>> - or warning should be emitted as in aarch64 case.
>>
>> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
>> [2] https://godbolt.org/z/9nKxaMc5j
>> [3] https://godbolt.org/z/1zxEr5b3f
>>
>>
>> Second, what to do?
>> -------------------
>>
>> I think that the following steps are needed:
>> - Investigation described in the next section shows that currently two
>>    shifts are generated accidentally w/o real intent to shed precision.
>>    I have a patch [6] that removes shifts generation, it should be applied.
>> - When 32-bit value is passed to "r" constraint:
>>    - for cpu v3/v4 a 32-bit register should be selected;
>>    - for cpu v1/v2 a warning should be reported.
> Thank you for the detailed analysis.
>
> Agree that llvm fix [6] is a necessary step, then

[6] probably not needed for normal C code. Eduard may help
to confirm. But yes it is needed to simplify asm
with 'r' registers.

> using 'w' in v3/v4 and warn on v1/v2 makes sense too,
> but we have this macro:
> #define barrier_var(var) asm volatile("" : "+r"(var))
> that is used in various bpf production programs.
> tetragon is also a heavy user of inline asm.

asm volatile("" : "+r"(var)) is expected to be
used only in compiler and the code will be generated
in final binary. This is true for all the instances
I see. If in unusual cases,
we have code generated like (r1 = r1, w1.= w1),
we can remove that inline asm in bpf backend at
the very late peephole optimization.

>
> Right now a full 64-bit register is allocated,
> so switching to 'w' might cause unexpected behavior
> including rejection by the verifier.
> I think it makes sense to align the bpf backend with arm64 and x86,
> but we need to broadcast this change widely.

Indeed, just with [6] might cause wrong results in certain cases.
Or if [6] landed, some code might need to change from 'r' to 'w'
in their source code.

Agree we should do similar thing to arm64/x86.
For cpuv3/cpuv4 4-byte value, changing from 'r' to 'w'.
For other 4-byte value, or 1/2 byte value, issue warnings.

>
> Also need to align with GCC. (Jose cc-ed)
>
> And, the most importantly, we need a way to go back to old behavior,
> since u32 var; asm("...":: "r"(var)); will now
> allocate "w" register or warn.
>
> What should be the workaround?
>
> I've tried:
> u32 var; asm("...":: "r"((u64)var));
>
> https://godbolt.org/z/n4ejvWj7v
>
> and x86/arm64 generate 32-bit truction.
> Sounds like the bpf backend has to do it as well.
> We should be doing 'wX=wX' in such case (just like x86)
> instead of <<=32 >>=32.

Indeed, this is preferred.

>
> I think this should be done as a separate diff.
> Our current pattern of using shifts is inefficient and guaranteed
> to screw up verifier range analysis while wX=wX is faster
> and more verifier friendly.
> Yes it's still not going to be 1-1 to old (our current) behavior.

With [6] and replacing 'r' to 'w' in inline asm, it will be a
new behavior.

>
> We probably need some macro (like we did for __BPF_CPU_VERSION__)
> to identify such fixed llvm, so existing users with '(short)'
> workaround and other tricks can detect new vs old compiler.

We can add a feature macro like
https://github.com/llvm/llvm-project/blob/main/clang/lib/Basic/Targets/BPF.cpp#L55

>
> Looks like we opened a can of worms.
> Aligning with x86/arm64 makes sense, but the cost of doing
> the right thing is hard to estimate.
>
>> Third, why two shifts are generated?
>> ------------------------------------
>>
>> (Details here might be interesting to Yonghong, regular reader could
>>   skip this section).
>>
>> The two shifts are result of interaction between two IR constructs
>> `trunc` and `asm`. The C program above looks as follows in LLVM IR
>> before machine code generation:
>>
>>      declare dso_local i64 @bar()
>>      define dso_local void @foo(i32 %p) {
>>      entry:
>>        %call = call i64 @bar()
>>        %v32 = trunc i64 %call to i32
>>        tail call void asm sideeffect "$0 += 1", "r"(i32 %v32)
>>        ret void
>>      }
>>
>> Initial selection DAG:
>>
>>      $ llc -debug-only=isel -march=bpf -mcpu=v3 --filetype=asm -o - t.ll
>>      SelectionDAG has 21 nodes:
>>        ...
>>        t10: i64,ch,glue = CopyFromReg t8, Register:i64 $r0, t8:1
>>     !     t11: i32 = truncate t10
>>     !    t15: i64 = zero_extend t11
>>        t17: ch,glue = CopyToReg t10:1, Register:i64 %1, t15
>>          t19: ch,glue = inlineasm t17, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>>                           TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t17:1
>>        ...
>>
>> Note values t11 and t15 marked with (!).
>>
>> Optimized lowered selection DAG for this fragment:
>>
>>      t10: i64,ch,glue = CopyFromReg t8, Register:i64 $r0, t8:1
>>    !   t22: i64 = and t10, Constant:i64<4294967295>
>>      t17: ch,glue = CopyToReg t10:1, Register:i64 %1, t22
>>        t19: ch,glue = inlineasm t17, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>>                         TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t17:1
>>
>> Note (zext (truncate ...)) converted to (and ... 0xffff_ffff).
>>
>> DAG after instruction selection:
>>
>>      t10: i64,ch,glue = CopyFromReg t8:1, Register:i64 $r0, t8:2
>>    !     t25: i64 = SLL_ri t10, TargetConstant:i64<32>
>>    !   t22: i64 = SRL_ri t25, TargetConstant:i64<32>
>>      t17: ch,glue = CopyToReg t10:1, Register:i64 %1, t22
>>        t23: ch,glue = inlineasm t17, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>>                         TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t17:1
>>
>> Note (and ... 0xffff_ffff) converted to (SRL_ri (SLL_ri ...)).
>> This happens because of the following pattern from BPFInstrInfo.td:
>>
>>      // 0xffffFFFF doesn't fit into simm32, optimize common case
>>      def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
>>                (SRL_ri (SLL_ri (i64 GPR:$src), 32), 32)>;
>>
>> So, the two shift instructions are result of translation of (zext (trunc ...)).
>> However, closer examination shows that zext DAG node was generated
>> almost by accident. Here is the backtrace for when this node was created:
>>
>>      Breakpoint 1, llvm::SelectionDAG::getNode (... Opcode=202) ;; 202 is opcode for ZERO_EXTEND
>>          at .../SelectionDAG.cpp:5605
>>      (gdb) bt
>>      #0  llvm::SelectionDAG::getNode (...)
>>          at ...SelectionDAG.cpp:5605
>>      #1  0x... in getCopyToParts (..., ExtendKind=llvm::ISD::ZERO_EXTEND)
>>          at .../SelectionDAGBuilder.cpp:537
>>      #2  0x... in llvm::RegsForValue::getCopyToRegs (... PreferredExtendType=llvm::ISD::ANY_EXTEND)
>>          at .../SelectionDAGBuilder.cpp:958
>>      #3  0x... in llvm::SelectionDAGBuilder::visitInlineAsm(...)
>>          at .../SelectionDAGBuilder.cpp:9640
>>          ...
>>
>> The stack frame #2 is interesting, here is the code for it [4]:
>>
>>      void RegsForValue::getCopyToRegs(SDValue Val, SelectionDAG &DAG,
>>                                       const SDLoc &dl, SDValue &Chain, SDValue *Glue,
>>                                       const Value *V,
>>                                       ISD::NodeType PreferredExtendType) const {
>>                                                     ^
>>                                                     '-- this is ANY_EXTEND
>>        ...
>>        for (unsigned Value = 0, Part = 0, e = ValueVTs.size(); Value != e; ++Value) {
>>          ...
>>                                                     .-- this returns true
>>                                                     v
>>          if (ExtendKind == ISD::ANY_EXTEND && TLI.isZExtFree(Val, RegisterVT))
>>            ExtendKind = ISD::ZERO_EXTEND;
>>
>>                                 .-- this is ZERO_EXTEND
>>                                 v
>>          getCopyToParts(..., ExtendKind);
>>          Part += NumParts;
>>        }
>>        ...
>>      }
>>
>> The getCopyToRegs() function was called with ANY_EXTEND preference,
>> but switched to ZERO_EXTEND because TLI.isZExtFree() currently returns
>> true for any 32 to 64-bit conversion [5].
>> However, in this case this is clearly a mistake, as zero extension of
>> (zext i64 (truncate i32 ...)) costs two instructions.
>>
>> The isZExtFree() behavior could be changed to report false for such
>> situations, as in my patch [6]. This in turn removes zext =>
>> removes two shifts from final asm.
>> Here is how DAG/asm look after patch [6]:
>>
>>      Initial selection DAG:
>>        ...
>>        t10: i64,ch,glue = CopyFromReg t8, Register:i64 $r0, t8:1
>>    !   t11: i32 = truncate t10
>>        t16: ch,glue = CopyToReg t10:1, Register:i64 %1, t10
>>          t18: ch,glue = inlineasm t16, TargetExternalSymbol:i64'$0 += 1', MDNode:ch<null>,
>>                           TargetConstant:i64<1>, TargetConstant:i32<131081>, Register:i64 %1, t16:1
>>        ...
>>
>> Final asm:
>>
>>      ...
>>      # %bb.0:
>>          call bar
>>          #APP
>>          r0 += 1
>>          #NO_APP
>>          exit
>>      ...
>>
>> Note that [6] is a very minor change, it does not affect code
>> generation for selftests at all and I was unable to conjure examples
>> where it has effect aside from inline asm parameters.
>>
>> [4] https://github.com/llvm/llvm-project/blob/365fbbfbcfefb8766f7716109b9c3767b58e6058/llvm/lib/CodeGen/SelectionDAG/SelectionDAGBuilder.cpp#L937C10-L937C10
>> [5] https://github.com/llvm/llvm-project/blob/6f4cc1310b12bc59210e4596a895db4cb9ad6075/llvm/lib/Target/BPF/BPFISelLowering.cpp#L213C21-L213C21
>> [6] https://github.com/llvm/llvm-project/commit/cf8e142e5eac089cc786c671a40fef022d08b0ef
>>

