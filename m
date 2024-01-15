Return-Path: <bpf+bounces-19547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCD82DDA8
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 17:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3400F1C21E58
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452EE17BB5;
	Mon, 15 Jan 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVM5jGE1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238417C60
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so10523534e87.1
        for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705336408; x=1705941208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JaQr7UQw/J8nDQp8peV0MbvepzpSH0z2IBooNUrSLs=;
        b=aVM5jGE1D6wb4JJTL3m3CjwvBLWtC21mY8AEmVC/HaBZF7GldiMg+LBAhWUINAnFyx
         bMRrnAK5FnnZmUbsdyf1vZEKfAnI8WEHQmNVulDAryz7YoiK3oWeBPoED5YEYNchZmkO
         M9kWLvjqDcvGT6Y+YAR5OIYQ9r6fE+aPFBvcJXGc1kPSSLP7gKeXOJstFiRLS03BqnXA
         YWjjiYhBNJfGmuVo8esSH6kVj58EoGzs/k91l08yL09laGC3OoDnlKtybxUNdxspfvz5
         R6bblczGA+X+qKLgFZ37VYlBHiC249OLdzCY+qEAp9RYnGoemK4Jc1Wzz/pwLX7Uf58Y
         0Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705336408; x=1705941208;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JaQr7UQw/J8nDQp8peV0MbvepzpSH0z2IBooNUrSLs=;
        b=FPFn/GvSrCYSS5dJUOJibjnwkjKYqIMdQCptoo0lom3xd/BiAUUoko72XtytOo3Ajv
         VURGeKihqsmjJYELi11c9GUkELR2f4f9JhC6JaPJiRSQLEYM56DRbPCEKrb6XkKs4TUV
         Y3CPDBsKTf6xrlB/LsePnGLibhk4h8bvKZwaurfbgUR9uSjQcJtIP1yQfodN+kFuDLkP
         uLSUTkS9j4HzBIW+ccE8CNx/j3mZNtc1QDID/a9Gvyfkx2RjsuYEoobuTgaTM1jVE0YI
         +cTjJghbFLoDqsoahXHpENB66gfpXAQKi3CgutUMiFfn3LWJZUtJ1+Mzip9d8+8fkvbj
         axOA==
X-Gm-Message-State: AOJu0YwgDgsXaSnoD0pIRyEx3jNmP/SN5IiaJjnywuj7Ty9zSR+EkT3o
	Nce1KnHO/pPARvsp0CY6f2Y=
X-Google-Smtp-Source: AGHT+IF6UX1xlAM3fG779Zospp79f0HGqBIoh8MaRsfm6VbNyPkPGaBV1mlQwwbaqt0+F8LNacPZUw==
X-Received: by 2002:a05:6512:308c:b0:50e:8d0c:5ef0 with SMTP id z12-20020a056512308c00b0050e8d0c5ef0mr3197098lfd.9.1705336407926;
        Mon, 15 Jan 2024 08:33:27 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907a58700b00a2caa85c0c1sm4547885ejc.30.2024.01.15.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:33:27 -0800 (PST)
Message-ID: <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, John
 Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, Kernel
 Team <kernel-team@fb.com>
Date: Mon, 15 Jan 2024 18:33:25 +0200
In-Reply-To: <878r4vra87.fsf@oracle.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com>
	 <878r4vra87.fsf@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-11 at 19:33 +0100, Jose E. Marchesi wrote:
>=20
> > [I have just added a proposal for an agenda item to this week's BPF
> >  Office Hours so we can discuss about BPF sub-registers and compiler
> >  constraints, to complement this thread.]
>=20
> Notes from the office hours:
>=20
> Availability of 32-bit arithmetic instructions:
>=20
>   (cpu >=3D v3 AND not disabled with -mno-alu32) OR -malu32
>=20
> Compiler constraints:
>=20
>   "r"
>=20
>      64-bit register (rN) or 32-bit sub-register (wN), based on the mode =
of
>      the operand.
>=20
>      If 32-bit arithmetic available
>         char, short -> wN and warning
>         int -> wN
>         long int -> rN
>      Else
>         char, short, int -> rN and warning
>         long int -> rN
>=20
>   "w"
>=20
>      32-bit sub-register (wN) regardless of the mode of the operand.
>=20
>      If 32-bit arithmetic available
>        char, short -> wN and warning
>        int -> wN
>        long int -> wN and warning
>      Else
>        char, short, int, long int -> wN and warning

Hi All,

I have a preliminary implementation of agreed logic for "r" and "w"
inline asm constraints in LLVM branch [0]:

- Constraint "r":
| Operand type | Has ALU32          | No ALU32           |
|--------------+--------------------+--------------------|
| char         | warning            | warning            |
| short        | warning            | warning            |
| int          | use 32-bit "w" reg | warning            |
| long         | use 64-bit "r" reg | use 64-bit "r" reg |

- Constraint "w":
| Operand type | Has ALU32          | No ALU32 |
|--------------+--------------------+----------|
| char         | warning            | warning  |
| short        | warning            | warning  |
| int          | use 32-bit "w" reg | warning  |
| long         | warning            | warning  |

The following constraints are not implemented for now:
"R", "I", "i", "O.

I also have patches, adapting BPF selftests [1], Cilium [2] and
Tetragon [3] to compile using both current LLVM main and [0].
After porting, selftests [1] are passing, and there is no verification
pass/fail differences when loading [2,3] object files using veristat.

The main take-away from the the porting exercise is that all three
projects still use CPUv2 fully or in parts of the code-base.

The issue with CPUv2 is that 'int' type cannot be passed to input
"r" constraint w/o explicit cast, and cannot be passed to output
constraint at all. Note that by default integer literals in C code
have type 'int', hence passing a constant to "ri" constraint might
require cast as well.

E.g. changes for input constraints, necessary for CPUv2:

-   asm("%0 -=3D %1" : "+r"(off) : "r"(buf->skb->data));
+   asm("%0 -=3D %1" : "+r"(off) : "r"((__u64)buf->skb->data));

E.g. changes for ouput (input/output) constraints, necessary for CPUv2:

-   int am;
+   long am;
    ...
    asm volatile("%[am] &=3D 0xffff;\n" ::[am] "+r"(am)

Also, selftests use constraint named "g" in one place:

  #define __sink(expr) asm volatile("" : "+g"(expr))

This constraint is documented in [4] as follows:

  "g" Any register, memory or immediate integer operand is allowed,
      except for registers that are not general registers.

In [0] I apply to "g" same checks as to "r".
This is not fully correct, as it warns about e.g. operand 10 (but not 10L)
when built with CPUv2. It looks like some internal Clang interfaces
(shared between targets) would need adjustment to allow different
semantic action on value vs. constant passed to "g" constraint.

The only instance when I had to analyze verifier behavior while
porting selftests considers usage of the barrier_var() macro.
Test case verif_scale_pyperf600_bpf_loop contains a code sequence
similar to following:

    #define barrier_var(var) asm volatile("" : "+r"(var))
    ...
    void foo(unsigned int i, unsigned char *ptr) {
      ...
      barrier_var(i);
      if (i >=3D 100)
        return;
      ... ptr[i] ...;
    }

Previously such code was translated as follows:

    w1 =3D w1                ; sign extension for inline asm operand
    if w1 > 0x63 goto ...
    ...
    r2 +=3D r1

But now sign extension is gone.
In the test case the range for 'i' was unknown to verifier prior to
comparison and 32-bit comparison only produces range for lower half of
the register. Thus verifier reported an error:

  math between map_value pointer and register with
  unbounded min value is not allowed

Unfortunately, I'm not aware of a simple way in C to force this
comparison be done in 64-bits w/o changing 'i' to 64-bit type:
InstCombinePass demotes it 32-bit comparison.
Hence, I changed the type of 'i' from __u32 to __u64.

There are 18 selftest object files with slight differences in code
generation when new constraint handling logic of [0] is applied.
I'll report on these differences a bit later.

Please let me know what you think about impact of the compiler changes
on the code base.

Thanks,
Eduard

[0] Updated LLVM
    https://github.com/eddyz87/llvm-project/tree/bpf-inline-asm-polymorphic=
-r
[1] selftests
    https://gist.github.com/eddyz87/276f1ecc51930017dcddbb56e37f57ad
[2] Cilium
    https://gist.github.com/eddyz87/4a485573556012ec730c2de0256a79db
    Note: this is based upon branch 'libbpf-friendliness'
          from https://github.com/anakryiko/cilium
[3] Tetragon
    https://gist.github.com/eddyz87/ca9a4b68007c72469307f2cce3f83bb1
[4] https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#index-g-in-c=
onstraint

