Return-Path: <bpf+bounces-18898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C1582357D
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E92286874
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E71B1CAA8;
	Wed,  3 Jan 2024 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO+dA/IJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B401CA8B
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5563944b3dfso3252945a12.3
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704309622; x=1704914422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHCoLStVeRds3aPh1Ij3S0hpX8p07DFvNbhzzoE3PMs=;
        b=BO+dA/IJUi6Qq21zlqLLjY5hueO/QwVPPFcitZwggLg7+Gp0pUESOe0XHDB03rOM2v
         sWBA5kIezMKF7rrOQw+YdoievQD81s78bzBM/utvzQsEebX96G6L9sBARfvz4TCp/JZU
         Zi9C0MkmsWkpVq3sZDJPfRmjNVDc63zUyJxleFJIlUmq1DWmE3rOhgU6XwzK5BQ1bmx6
         PHK8hnF/nHkbs8XrpFejSw77BPji49XjqkxVLcmtEpxAZ2tiIQWVE6sajjqGW63GZYFp
         42nvPsK8C3pEbhbM0DyekYdFLwKmwmCDqtfEJYenhq98MG1eOi/2R6dwdRLk/pigKiLt
         VW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309622; x=1704914422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHCoLStVeRds3aPh1Ij3S0hpX8p07DFvNbhzzoE3PMs=;
        b=LqgtjFHcb9Z3hktcdN+QEdHzN0N+F4O7vIxC8fWYhMhCU7KmxybU1oPNUcaTn8ihxd
         S9mSydBtjlsdu8GMP+uG4VPNRwG/X37xoPRzgp2FMFRdtEebrbdx1KjRhaDc9A2NVADb
         PIesITpRP7SsJuQ05YeviEBn/1gEsh8lPQ2/9An4jyg30pQe/eNmc14drroDOFvMlRQ9
         6x+DtGjccMJbknBcB0g8VO2Intp4enTxuwnXH+gSEU0KK9k5E+bz0TD1g4Wh93MSlYYa
         X6KkQOps9ZQrVBUP2aIF4+ysu9jnE3qSQD6xnSpsaCtExqjChqhxsB3NElNuV+W1GY8T
         7XYw==
X-Gm-Message-State: AOJu0YyCMsMR5+MH6EOMht6ChCS8iZXmbJSuXxD89DcOGcwXMYmMM0LV
	q9e0bsAU59Tu2ucixxvpBAVvYK6y5kjxPFgnC5U=
X-Google-Smtp-Source: AGHT+IHLQ+JGLpadgC7/jPifPU5id+k7hz1k6iaVCd93VTFdjHIfB91ooFXyOX9k+H3JsAHyFK7Hrj9EZwcCXPMsC8g=
X-Received: by 2002:a50:d65c:0:b0:553:5087:cbf0 with SMTP id
 c28-20020a50d65c000000b005535087cbf0mr10898375edj.83.1704309621520; Wed, 03
 Jan 2024 11:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com> <20231226191148.48536-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20231226191148.48536-3-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 11:20:09 -0800
Message-ID: <CAEf4BzYQxH7k22tY7ZFXLLmFS4xy4wNGAVVF2OJECv=1RajF4Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: Introduce "volatile compare" macros
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, dxu@dxuuu.xyz, memxor@gmail.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 11:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Compilers optimize conditional operators at will, but often bpf programme=
rs
> want to force compilers to keep the same operator in asm as it's written =
in C.
> Introduce bpf_cmp_likely/unlikely(var1, conditional_op, var2) macros that=
 can be used as:
>
> -               if (seen >=3D 1000)
> +               if (bpf_cmp_unlikely(seen, >=3D, 1000))
>
> The macros take advantage of BPF assembly that is C like.
>
> The macros check the sign of variable 'seen' and emits either
> signed or unsigned compare.
>
> For example:
> int a;
> bpf_cmp_unlikely(a, >, 0) will be translated to 'if rX s> 0 goto' in BPF =
assembly.
>
> unsigned int a;
> bpf_cmp_unlikely(a, >, 0) will be translated to 'if rX > 0 goto' in BPF a=
ssembly.
>
> C type conversions coupled with comparison operator are tricky.
>   int i =3D -1;
>   unsigned int j =3D 1;
>   if (i < j) // this is false.
>
>   long i =3D -1;
>   unsigned int j =3D 1;
>   if (i < j) // this is true.
>
> Make sure BPF program is compiled with -Wsign-compare then the macros wil=
l catch
> the mistake.
>
> The macros check LHS (left hand side) only to figure out the sign of comp=
are.
>
> 'if 0 < rX goto' is not allowed in the assembly, so the users
> have to use a variable on LHS anyway.
>
> The patch updates few tests to demonstrate the use of the macros.
>
> The macro allows to use BPF_JSET in C code, since LLVM doesn't generate i=
t at
> present. For example:
>
> if (i & j) compiles into r0 &=3D r1; if r0 =3D=3D 0 goto
>
> while
>
> if (bpf_cmp_unlikely(i, &, j)) compiles into if r0 & r1 goto
>
> Note that the macros has to be careful with RHS assembly predicate.
> Since:
> u64 __rhs =3D 1ull << 42;
> asm goto("if r0 < %[rhs] goto +1" :: [rhs] "ri" (__rhs));
> LLVM will silently truncate 64-bit constant into s32 imm.
>
> Note that [lhs] "r"((short)LHS) the type cast is a workaround for LLVM is=
sue.
> When LHS is exactly 32-bit LLVM emits redundant <<=3D32, >>=3D32 to zero =
upper 32-bits.
> When LHS is 64 or 16 or 8-bit variable there are no shifts.
> When LHS is 32-bit the (u64) cast doesn't help. Hence use (short) cast.
> It does _not_ truncate the variable before it's assigned to a register.
>
> Traditional likely()/unlikely() macros that use __builtin_expect(!!(x), 1=
 or 0)
> have no effect on these macros, hence macros implement the logic manually=
.
> bpf_cmp_unlikely() macro preserves compare operator as-is while
> bpf_cmp_likely() macro flips the compare.
>
> Consider two cases:
> A.
>   for() {
>     if (foo >=3D 10) {
>       bar +=3D foo;
>     }
>     other code;
>   }
>
> B.
>   for() {
>     if (foo >=3D 10)
>        break;
>     other code;
>   }
>
> It's ok to use either bpf_cmp_likely or bpf_cmp_unlikely macros in both c=
ases,
> but consider that 'break' is effectively 'goto out_of_the_loop'.
> Hence it's better to use bpf_cmp_unlikely in the B case.
> While 'bar +=3D foo' is better to keep as 'fallthrough' =3D=3D likely cod=
e path in the A case.
>
> When it's written as:
> A.
>   for() {
>     if (bpf_cmp_likely(foo, >=3D, 10)) {
>       bar +=3D foo;
>     }
>     other code;
>   }
>
> B.
>   for() {
>     if (bpf_cmp_unlikely(foo, >=3D, 10))
>        break;
>     other code;
>   }
>
> The assembly will look like:
> A.
>   for() {
>     if r1 < 10 goto L1;
>       bar +=3D foo;
>   L1:
>     other code;
>   }
>
> B.
>   for() {
>     if r1 >=3D 10 goto L2;
>     other code;
>   }
>   L2:
>
> The bpf_cmp_likely vs bpf_cmp_unlikely changes basic block layout, hence =
it will
> greatly influence the verification process. The number of processed instr=
uctions
> will be different, since the verifier walks the fallthrough first.
>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  | 69 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/exceptions.c  | 20 +++---
>  .../selftests/bpf/progs/iters_task_vma.c      |  3 +-
>  3 files changed, 80 insertions(+), 12 deletions(-)
>

Likely/unlikely distinctions make 100% sense. Last year when I was
looking into improving verifier heuristics I noticed how sensitive and
important it is for verifier to first verify code path that is most
generic. This significantly aids state pruning. So code generation
makes a big difference, and if an "unlikely" short-cut (usually error
handling or early exit) condition is verified first, it will cause
verifier more work. Which totally explains the regressions you were
seeing in the last patch.

Let's hope users will actually make the right likely/unlikely decision
in their code when using bpf_cmp() :)


I left a few more comments below, but they can be a follow up. This
looks great, we should move this to bpf_helpers.h in libbpf after a
bit more testing in real-world production use cases.

I also aligned all those \ terminators in macros, as they are very
distracting when reading the code and I'd want to do that before
moving into bpf_helpers.h anyways :) hope you don't mind (and there
were some inconsistencies with single space and no space before \
anyways; it's hard to keep track of that)


> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 1386baf9ae4a..789abf316ad4 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -254,6 +254,75 @@ extern void bpf_throw(u64 cookie) __ksym;
>                 }                                                        =
               \
>          })
>
> +#define __cmp_cannot_be_signed(x) \
> +       __builtin_strcmp(#x, "=3D=3D") =3D=3D 0 || __builtin_strcmp(#x, "=
!=3D") =3D=3D 0 || \
> +       __builtin_strcmp(#x, "&") =3D=3D 0
> +
> +#define __is_signed_type(type) (((type)(-1)) < (type)1)
> +
> +#define __bpf_cmp(LHS, OP, SIGN, PRED, RHS, DEFAULT) \
> +       ({ \
> +               __label__ l_true; \
> +               bool ret =3D DEFAULT; \
> +               asm volatile goto("if %[lhs] " SIGN #OP " %[rhs] goto %l[=
l_true]" \
> +                                 :: [lhs] "r"((short)LHS), [rhs] PRED (R=
HS) :: l_true); \
> +               ret =3D !DEFAULT; \
> +l_true:\
> +               ret;\
> +       })
> +
> +/* C type conversions coupled with comparison operator are tricky.
> + * Make sure BPF program is compiled with -Wsign-compre then

fixed typo while applying: compare

> + * __lhs OP __rhs below will catch the mistake.
> + * Be aware that we check only __lhs to figure out the sign of compare.
> + */
> +#define _bpf_cmp(LHS, OP, RHS, NOFLIP) \

nit: NOFLIP name is absolutely confusing, tbh, it would be nice to
rename it to something more easily understood (DEFAULT is IMO better)

> +       ({ \
> +               typeof(LHS) __lhs =3D (LHS); \
> +               typeof(RHS) __rhs =3D (RHS); \
> +               bool ret; \
> +               _Static_assert(sizeof(&(LHS)), "1st argument must be an l=
value expression"); \
> +               (void)(__lhs OP __rhs); \

what is this part for? Is this what "__lhs OP __rhs below will catch
the mistake" in the comment refers to?

BTW, I think we hit this one when invalid OP is specified, before we
get to (void)"bug" (see below). So maybe it would be better to push it
deeper into __bpf_cmp itself?

> +               if (__cmp_cannot_be_signed(OP) || !__is_signed_type(typeo=
f(__lhs))) {\
> +                       if (sizeof(__rhs) =3D=3D 8) \
> +                               ret =3D __bpf_cmp(__lhs, OP, "", "r", __r=
hs, NOFLIP); \
> +                       else \
> +                               ret =3D __bpf_cmp(__lhs, OP, "", "i", __r=
hs, NOFLIP); \

tbh, I'm also not 100% sure why this sizeof() =3D=3D 8 and corresponding r
vs i change? Can you please elaborate (and add a comment in a follow
up, perhaps?)

> +               } else { \
> +                       if (sizeof(__rhs) =3D=3D 8) \
> +                               ret =3D __bpf_cmp(__lhs, OP, "s", "r", __=
rhs, NOFLIP); \
> +                       else \
> +                               ret =3D __bpf_cmp(__lhs, OP, "s", "i", __=
rhs, NOFLIP); \

one simplification that would reduce number of arguments to __bpf_cmp:

in __bpf_cmp (drop # before OP):

asm volatile goto("if %[lhs] " OP " %[rhs] goto %l[l_true]"


And here you just stringify operator, appending "s" if necessary:

ret =3D __bpf_cmp(__lhs, #OP, "i", __rhs, NOFLIP);

or

ret =3D __bpf_cmp(__lhs, "s"#OP, "r", __rhs, NOFLIP);

Consider for a follow up, if you agree it is a simplification.

> +               } \
> +               ret; \
> +       })
> +
> +#ifndef bpf_cmp_unlikely
> +#define bpf_cmp_unlikely(LHS, OP, RHS) _bpf_cmp(LHS, OP, RHS, true)
> +#endif
> +
> +#ifndef bpf_cmp_likely
> +#define bpf_cmp_likely(LHS, OP, RHS) \
> +       ({ \
> +               bool ret; \
> +               if (__builtin_strcmp(#OP, "=3D=3D") =3D=3D 0) \
> +                       ret =3D _bpf_cmp(LHS, !=3D, RHS, false); \
> +               else if (__builtin_strcmp(#OP, "!=3D") =3D=3D 0) \
> +                       ret =3D _bpf_cmp(LHS, =3D=3D, RHS, false); \
> +               else if (__builtin_strcmp(#OP, "<=3D") =3D=3D 0) \
> +                       ret =3D _bpf_cmp(LHS, >, RHS, false); \
> +               else if (__builtin_strcmp(#OP, "<") =3D=3D 0) \
> +                       ret =3D _bpf_cmp(LHS, >=3D, RHS, false); \
> +               else if (__builtin_strcmp(#OP, ">") =3D=3D 0) \
> +                       ret =3D _bpf_cmp(LHS, <=3D, RHS, false); \
> +               else if (__builtin_strcmp(#OP, ">=3D") =3D=3D 0) \
> +                       ret =3D _bpf_cmp(LHS, <, RHS, false); \
> +               else \
> +                       (void) "bug"; \

doesn't seem like this is doing anything, I tried using wrong OP and I'm ge=
tting

progs/iters_task_vma.c:31:32: error: expected expression
   31 |                 if (bpf_cmp_unlikely(seen, >=3D=3D, 1000))
      |                                              ^

regardless of this (void)"bug" business. It doesn't hurt, but also
doesn't seem to be doing anything.


If I uses some text instead of operator, I get different one:

progs/iters_task_vma.c:31:30: error: expected ')'
   31 |                 if (bpf_cmp_unlikely(seen, op, 1000))
      |                                            ^
progs/iters_task_vma.c:31:7: note: to match this '('
   31 |                 if (bpf_cmp_unlikely(seen, op, 1000))
      |                     ^
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:30=
1:40:
note: expanded from macro 'bpf_cmp_unlikely'
  301 | #define bpf_cmp_unlikely(LHS, OP, RHS) _bpf_cmp(LHS, OP, RHS, true)
      |                                        ^
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:28=
5:9:
note: expanded from macro '_bpf_cmp'
  285 |                 (void)(__lhs OP __rhs); \
      |                       ^
1 error generated.


But still, (void)"bug" doesn't change anything (updated realization I
got while finishing this email: see below about difference between
likely/unlikely).


And just to complete exploration, if we use valid C operator that's
not supported in assembly (like <<), we can see different error still:

progs/iters_task_vma.c:31:7: error: invalid operand for instruction
   31 |                 if (bpf_cmp_unlikely(seen, <<, 1000))
      |                     ^
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:30=
1:40:
note: expanded from macro 'bpf_cmp_unlikely'
  301 | #define bpf_cmp_unlikely(LHS, OP, RHS) _bpf_cmp(LHS, OP, RHS, true)
      |                                        ^
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:29=
0:11:
note: expanded from macro '_bpf_cmp'
  290 |                                 ret =3D __bpf_cmp(__lhs, OP, "",
"i", __rhs, NOFLIP); \
      |                                       ^
/data/users/andriin/linux/tools/testing/selftests/bpf/bpf_experimental.h:26=
7:21:
note: expanded from macro '__bpf_cmp'
  267 |                 asm volatile goto("if %[lhs] " SIGN #OP "
%[rhs] goto %l[l_true]" \
      |                                   ^
<inline asm>:1:8: note: instantiated into assembly here
    1 |         if r6 << 1000 goto LBB0_6
      |               ^

This one is kind of surprising, we got to asm even though the operator
was wrong. And it took me a bit to realize a huge asymmetry between
bpf_cmp_likely and bpf_cmp_unlikely. likely variant explicitly lists
supported operators and should bail out early on unrecognized one
((void)"bug") part. But unlikely variant just passes through
everything user provided directly into asm-generating macro.

I actually like a more verbose but also more explicit way of likely
implementation, listing explicitly supported operators.  It will also
be easier for users to check what they are supposed to pass. So that's
another thing to maybe do in the follow up?



> +               ret; \
> +       })
> +#endif
> +
>  /* Description
>   *     Assert that a conditional expression is true.
>   * Returns

[...]

