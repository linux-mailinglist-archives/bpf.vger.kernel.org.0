Return-Path: <bpf+bounces-19145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE742825C39
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 22:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9661E284652
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53521A11;
	Fri,  5 Jan 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hed1qo6Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678936093
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e3a67ca9fso266595e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 13:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704491270; x=1705096070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2TwumnDWyEHWwqsTw4aAlQjOE5GhST1uznuHWGlCq74=;
        b=hed1qo6YLOvMgqDPezc6ffYFCFcUnFaoj+qF55VcXjXMb/hbwcLGAFdtfqfOSfMqLg
         lF/2YKEJr3jWO/Kma7PBLPTwjw8i6RdO90RQqh/yd50wY6CuaJ5hzjXcfQmfTz1s6dbE
         LahlvkRHbVBcS0juCM6sdZrDMOjCCvrQq8OoCQhVBgM8azUfSbvKipT2DxFt2/gIT5it
         Uo+8tA6N2qzy+P9bZfZLUteOpkoH7kAb9+4TSld8OVSyI2VDxBbhomya9g7nIg3CC2KO
         Ovtfl+xoDwU9BeB3EVyFbt/gsOVciropg8EEfkhJ/Jk8ZF8aI4KQG5qfFdvGfqZAoPxN
         r0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704491270; x=1705096070;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TwumnDWyEHWwqsTw4aAlQjOE5GhST1uznuHWGlCq74=;
        b=URjqmtN9Hd8zirzyzBgnJrf5TpGShZAUrwEw8FoIejnc0AvWGA8cu5B3S5jzBINT4z
         txyFZusavvnSCl1XONqX7dz2d4Y/fxw7NT6quBjk5RuFBwlPRh3sL2KV0mYCVhY7D9ah
         rOd9zpbm8Flt04sco9okcsPWZzoU9G7qTgUQT2ISvO8cTQGsBVIzwJA9Tj6vP/m94eC8
         AmKHbOTPP1xa098MM8znwNLTuYuwJ45x997xYsF7cs+qGTSNkufXOQpw6TslW7KCdsCw
         ZPwXn+3fmkMHXqHzjXfSKzOgfXNUudF0oUwxh37yHb4T5Za3SgdvTDG8CCkS0wwQLXQ8
         LzOQ==
X-Gm-Message-State: AOJu0YwL7zXQYeIw8fNYOkXcoOMsrcrgKrBDRS1XAyUYr81p9oWNBgiL
	C66FxxWqzIQkuPKDDtJ3+yk=
X-Google-Smtp-Source: AGHT+IGD9Q/bEgBcp109+48zXxh1/B1TNKLQ97MYHTxbrJH92WJOOJ+i1rnujcVBXoADekOe/tvP0g==
X-Received: by 2002:a1c:7c1a:0:b0:40d:6e05:fcc0 with SMTP id x26-20020a1c7c1a000000b0040d6e05fcc0mr77936wmc.41.1704491269467;
        Fri, 05 Jan 2024 13:47:49 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c1d0800b0040d6e07a147sm2732307wms.23.2024.01.05.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 13:47:48 -0800 (PST)
Message-ID: <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya
	Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, John Fastabend <john.fastabend@gmail.com>, bpf
 <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Date: Fri, 05 Jan 2024 23:47:47 +0200
In-Reply-To: <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
[...]
> It turned out there are indeed a bunch of redundant shifts
> when u32 or s32 is passed into "r" asm constraint.
>=20
> Strangely the shifts are there when compiled with -mcpu=3Dv3 or v4
> and no shifts with -mcpu=3Dv1 and v2.
>=20
> Also weird that u8 and u16 are passed into "r" without redundant shifts.
> Hence I found a "workaround": cast u32 into u16 while passing.
> The truncation of u32 doesn't happen and shifts to zero upper 32-bit
> are gone as well.
>=20
> https://godbolt.org/z/Kqszr6q3v

Regarding unnecessary shifts.
Sorry, a long email about minor feature/defect.

So, currently the following C program
(and it's variations with implicit casts):

    extern unsigned long bar(void);
    void foo(void) {
      asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned)bar()));
    }

Is translated to the following BPF:

    $ clang -mcpu=3Dv3 -O2 --target=3Dbpf -mcpu=3Dv3 -c -o - t.c | llvm-obj=
dump --no-show-raw-insn -d -
   =20
    <stdin>:	file format elf64-bpf
   =20
    Disassembly of section .text:
   =20
    0000000000000000 <foo>:
           0:	call -0x1
           1:	r0 <<=3D 0x20
           2:	r0 >>=3D 0x20
           3:	r0 +=3D 0x1
           4:	exit
          =20
Note: no additional shifts are generated when "w" (32-bit register)
      constraint is used instead of "r".

First, is this right or wrong?
------------------------------

C language spec [1] paragraph 6.5.4.6 (Cast operators -> Semantics) says
the following:

  If the value of the expression is represented with greater range or
  precision than required by the type named by the cast (6.3.1.8),
  then the cast specifies a conversion even if the type of the
  expression is the same as the named type and removes any extra range
  and precision.                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ^^^^^^^^^^^^^
 =20
What other LLVM backends do in such situations?
Consider the following program translated to amd64 [2] and aarch64 [3]:

    void foo(void) {
      asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned long)  bar())); =
// 1
      asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned int)   bar())); =
// 2
      asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned short) bar())); =
// 3
    }

- for amd64 register of proper size is selected for `reg`;
- for aarch64 warnings about wrong operand size are emitted at (2) and (3)
  and 64-bit register is used w/o generating any additional instructions.

(Note, however, that 'arm' silently ignores the issue and uses 32-bit
 registers for all three points).

So, it looks like that something of this sort should be done:
- either extra precision should be removed via additional instructions;
- or 32-bit register should be picked for `reg`;
- or warning should be emitted as in aarch64 case.

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
[2] https://godbolt.org/z/9nKxaMc5j
[3] https://godbolt.org/z/1zxEr5b3f


Second, what to do?
-------------------

I think that the following steps are needed:
- Investigation described in the next section shows that currently two
  shifts are generated accidentally w/o real intent to shed precision.
  I have a patch [6] that removes shifts generation, it should be applied.
- When 32-bit value is passed to "r" constraint:
  - for cpu v3/v4 a 32-bit register should be selected;
  - for cpu v1/v2 a warning should be reported.


Third, why two shifts are generated?
------------------------------------

(Details here might be interesting to Yonghong, regular reader could
 skip this section).

The two shifts are result of interaction between two IR constructs
`trunc` and `asm`. The C program above looks as follows in LLVM IR
before machine code generation:

    declare dso_local i64 @bar()
    define dso_local void @foo(i32 %p) {
    entry:
      %call =3D call i64 @bar()
      %v32 =3D trunc i64 %call to i32
      tail call void asm sideeffect "$0 +=3D 1", "r"(i32 %v32)
      ret void
    }

Initial selection DAG:

    $ llc -debug-only=3Disel -march=3Dbpf -mcpu=3Dv3 --filetype=3Dasm -o - =
t.ll
    SelectionDAG has 21 nodes:
      ...
      t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
   !     t11: i32 =3D truncate t10
   !    t15: i64 =3D zero_extend t11
      t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t15
        t19: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D 1'=
, MDNode:ch<null>,
                         TargetConstant:i64<1>, TargetConstant:i32<131081>,=
 Register:i64 %1, t17:1
      ...

Note values t11 and t15 marked with (!).

Optimized lowered selection DAG for this fragment:

    t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
  !   t22: i64 =3D and t10, Constant:i64<4294967295>
    t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t22
      t19: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D 1', =
MDNode:ch<null>,
                       TargetConstant:i64<1>, TargetConstant:i32<131081>, R=
egister:i64 %1, t17:1

Note (zext (truncate ...)) converted to (and ... 0xffff_ffff).

DAG after instruction selection:

    t10: i64,ch,glue =3D CopyFromReg t8:1, Register:i64 $r0, t8:2
  !     t25: i64 =3D SLL_ri t10, TargetConstant:i64<32>
  !   t22: i64 =3D SRL_ri t25, TargetConstant:i64<32>
    t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t22
      t23: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D 1', =
MDNode:ch<null>,
                       TargetConstant:i64<1>, TargetConstant:i32<131081>, R=
egister:i64 %1, t17:1

Note (and ... 0xffff_ffff) converted to (SRL_ri (SLL_ri ...)).
This happens because of the following pattern from BPFInstrInfo.td:

    // 0xffffFFFF doesn't fit into simm32, optimize common case
    def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
              (SRL_ri (SLL_ri (i64 GPR:$src), 32), 32)>;

So, the two shift instructions are result of translation of (zext (trunc ..=
.)).
However, closer examination shows that zext DAG node was generated
almost by accident. Here is the backtrace for when this node was created:

    Breakpoint 1, llvm::SelectionDAG::getNode (... Opcode=3D202) ;; 202 is =
opcode for ZERO_EXTEND
        at .../SelectionDAG.cpp:5605
    (gdb) bt
    #0  llvm::SelectionDAG::getNode (...)
        at ...SelectionDAG.cpp:5605
    #1  0x... in getCopyToParts (..., ExtendKind=3Dllvm::ISD::ZERO_EXTEND)
        at .../SelectionDAGBuilder.cpp:537
    #2  0x... in llvm::RegsForValue::getCopyToRegs (... PreferredExtendType=
=3Dllvm::ISD::ANY_EXTEND)
        at .../SelectionDAGBuilder.cpp:958
    #3  0x... in llvm::SelectionDAGBuilder::visitInlineAsm(...)
        at .../SelectionDAGBuilder.cpp:9640
        ...

The stack frame #2 is interesting, here is the code for it [4]:

    void RegsForValue::getCopyToRegs(SDValue Val, SelectionDAG &DAG,
                                     const SDLoc &dl, SDValue &Chain, SDVal=
ue *Glue,
                                     const Value *V,
                                     ISD::NodeType PreferredExtendType) con=
st {
                                                   ^
                                                   '-- this is ANY_EXTEND
      ...
      for (unsigned Value =3D 0, Part =3D 0, e =3D ValueVTs.size(); Value !=
=3D e; ++Value) {
        ...
                                                   .-- this returns true
                                                   v
        if (ExtendKind =3D=3D ISD::ANY_EXTEND && TLI.isZExtFree(Val, Regist=
erVT))
          ExtendKind =3D ISD::ZERO_EXTEND;
   =20
                               .-- this is ZERO_EXTEND
                               v
        getCopyToParts(..., ExtendKind);
        Part +=3D NumParts;
      }
      ...
    }

The getCopyToRegs() function was called with ANY_EXTEND preference,
but switched to ZERO_EXTEND because TLI.isZExtFree() currently returns
true for any 32 to 64-bit conversion [5].
However, in this case this is clearly a mistake, as zero extension of=20
(zext i64 (truncate i32 ...)) costs two instructions.

The isZExtFree() behavior could be changed to report false for such
situations, as in my patch [6]. This in turn removes zext =3D>
removes two shifts from final asm.
Here is how DAG/asm look after patch [6]:

    Initial selection DAG:
      ...
      t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
  !   t11: i32 =3D truncate t10
      t16: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t10
        t18: ch,glue =3D inlineasm t16, TargetExternalSymbol:i64'$0 +=3D 1'=
, MDNode:ch<null>,
                         TargetConstant:i64<1>, TargetConstant:i32<131081>,=
 Register:i64 %1, t16:1
      ...
   =20
Final asm:

    ...
    # %bb.0:
    	call bar
    	#APP
    	r0 +=3D 1
    	#NO_APP
    	exit
    ...
   =20
Note that [6] is a very minor change, it does not affect code
generation for selftests at all and I was unable to conjure examples
where it has effect aside from inline asm parameters.

[4] https://github.com/llvm/llvm-project/blob/365fbbfbcfefb8766f7716109b9c3=
767b58e6058/llvm/lib/CodeGen/SelectionDAG/SelectionDAGBuilder.cpp#L937C10-L=
937C10
[5] https://github.com/llvm/llvm-project/blob/6f4cc1310b12bc59210e4596a895d=
b4cb9ad6075/llvm/lib/Target/BPF/BPFISelLowering.cpp#L213C21-L213C21
[6] https://github.com/llvm/llvm-project/commit/cf8e142e5eac089cc786c671a40=
fef022d08b0ef


