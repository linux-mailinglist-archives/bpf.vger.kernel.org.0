Return-Path: <bpf+bounces-19107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240F824D8E
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 04:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32568B24123
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 03:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563B442F;
	Fri,  5 Jan 2024 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhvSe4Nc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F424405
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccec119587so14316561fa.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 19:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704427089; x=1705031889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHeClYEPiyLidSBpXYMZrjixAWXvxmEQ3bcK+Od3YKc=;
        b=RhvSe4NcWoNwMXMz9mWgg9kPUTy15py0lGCgHD5ghh2lLtegHNL9DvKUCtvkvxW3SX
         LQS7MVjm+8xHMIJCB8M6aaI5Z0rK/QFNdQv2Y1ggHbUBxw1sRin4Sf0cS6/LSbFu0fMr
         V/Y84B3Qz+IscyDvu+eSLWxbDVQMbuc5ZQCdOE6W+15tJRbV7OoKMU5xtkHLv69Fwy5k
         GviA8zaIeGnKljBbE2nlsUq34jbXEJm9bhXt4PZyn0b9JzDLrS2PIBIVHeynXYRc0xTw
         Y04SxTEkf81ytfNyF1mox1WboBNraRF6uCoqx34MbeTibBjjwCHikVt+vkkUMdnWs9Lv
         igCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704427089; x=1705031889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHeClYEPiyLidSBpXYMZrjixAWXvxmEQ3bcK+Od3YKc=;
        b=u+yC7Svq/JDFn+x63BslPCi/uJ03YxKKCv1RfS/Q0SWOkGUhn4yUqJzF1f9tun+c+I
         M+oEvmg4SF722ns8r4uklT1LEQ8YA9+8NrgHd25aPdeV82fht3soVEGloossJelK4Tpi
         a2H/UHLtOc7zl4Sodb3ASJVbW3ZL9gxVxlbZF3XUGRKj9BNs+3aJe7WXY3664q4Dm9I2
         ijk4IAPW5XTShZdSJxBfEG2EcLuuUgmjlNpsmJ77EDO09xbfwBwMVsRxluFF7HFgAtvP
         OUSduIYAiLZ03I4LJmOhTWP5vbGfS1tFq10QUwOGX7d4ZGMkr/SwyTWCkf//MItNh0R6
         16fw==
X-Gm-Message-State: AOJu0YxjYFYK9AxoyMnGt1MG4AVxqHRNPT8VxAULE2kC+nZ26WEdKt1d
	CcekB82dO1D9n6SOWuefCAwsB8RVzxPynsb18s+2MU6JMdk=
X-Google-Smtp-Source: AGHT+IGLYg08WDlwtZo6augFaGXh01m9L89rmzYhn1p40jex9a09m3vV88ezIN9jaJBUc2MqpU4SiO8krZcZI0+NG4g=
X-Received: by 2002:a2e:95d0:0:b0:2cc:5c19:d009 with SMTP id
 y16-20020a2e95d0000000b002cc5c19d009mr855728ljh.45.1704427088509; Thu, 04 Jan
 2024 19:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
 <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
 <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com>
 <CAADnVQLOYU67aRyp92S0G8AEVxXRYndb6hWrtHZOH9gr0Q7JEQ@mail.gmail.com>
 <CAEf4BzaSspEa27TtMLRv-V4ipGhVdK9y5Ynu9teYNDp4f0CctA@mail.gmail.com> <CAADnVQKPSXUxT6HLF-hMeVd6zJhNqriFjaqdeNkyj_wRFN8Hdg@mail.gmail.com>
In-Reply-To: <CAADnVQKPSXUxT6HLF-hMeVd6zJhNqriFjaqdeNkyj_wRFN8Hdg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 19:57:56 -0800
Message-ID: <CAEf4BzahccE=CuWk1G05byopvd9b_iwdeF5aeL4TSNR7Cg10ZA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 5:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 12:58=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > My point was that it's hard to accidentally forget to "generalize"
> > type if you were supporting sk_buff, and suddenly started calling it
> > with xdp_md.
> >
> > From my POV, if I'm a user, and I declare an argument as long and
> > annotate it as __arg_ctx, then I know what I'm doing and I'd hate for
> > some smart-ass library to double-guess me dictating what exact
> > incantation I should specify to make it happy.
>
> But that's exactly what's happening!
> The smart-ass libbpf ignores the type in 'struct sk_buff *skb __arg_ctx'
> and replaces it with whatever is appropriate for prog type.

The only thing that libbpf does in this case is it honors __arg_ctx
and makes it work *exactly the same* as __arg_ctx natively works on
the newest kernel. Not more, not less. It doesn't change compilation
or verification rules. At all.

Libbpf is not a compiler. And libbpf is not a verifier. It sees
__arg_ctx, it makes sure this argument is communicated to the verifier
as context. That's all. Again, it has no effect on code generation
*or* verification (compared to a newer kernel with native __arg_ctx
support). If a user has a bug, either the compiler or verifier will
complain (or not), depending on how subtle the bug is.

> More below.
>
> >  static __attribute__ ((noinline))
> > -int f0(int var, struct __sk_buff *skb)
> > +int f0(int var, struct sk_buff *skb)
> >  {
> > -       return skb->len;
> > +       return 0;
> >  }
> >
> >  __attribute__ ((noinline))
> > @@ -20,7 +19,7 @@ int f1(struct __sk_buff *skb)
> >
> >         __sink(buf[MAX_STACK - 1]);
> >
> > -       return f0(0, skb) + skb->len;
> > +       return f0(0, (void*)skb) + skb->len;
>
> This is static f0. Not sure what you're trying to say.

Ok, I brainfarted and converted a static function in the test called
test_global_func2 without even checking if it's global or not, as I
didn't expect that there are any static subprogs at all. My bad. But
the point stands, both sk_buff and __sk_buff are recognized as
PTR_TO_CTX for global subprogs, see below. And that's all I'm trying
to say.

> I don't think btf_get_prog_ctx_type() logic applies here.
>

Did you check the patch I referenced? I'm saying that `struct sk_buff
*ctx` is recognized as a context type by kernel *for global subprog*.
Here we go again, this time on f1(), which is not static:

diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c
b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 2beab9c3b68a..4a54350f0aa0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
-#include <stddef.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"

@@ -14,13 +13,13 @@ int f0(int var, struct __sk_buff *skb)
 }

 __attribute__ ((noinline))
-int f1(struct __sk_buff *skb)
+int f1(struct sk_buff *skb)
 {
        volatile char buf[MAX_STACK] =3D {};

        __sink(buf[MAX_STACK - 1]);

-       return f0(0, skb) + skb->len;
+       return f0(0, (void *)skb);
 }

 int f3(int, struct __sk_buff *skb, int);
@@ -28,7 +27,7 @@ int f3(int, struct __sk_buff *skb, int);
 __attribute__ ((noinline))
 int f2(int val, struct __sk_buff *skb)
 {
-       return f1(skb) + f3(val, skb, 1);
+       return f1((void *)skb) + f3(val, skb, 1);
 }

 __attribute__ ((noinline))
@@ -45,5 +44,5 @@ SEC("tc")
 __success
 int global_func2(struct __sk_buff *skb)
 {
-       return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
+       return f0(1, skb) + f1((void *)skb) + f2(2, skb) + f3(3, skb, 4);
 }


And here's portion of veristat log output to be 100% sure this time:

Validating f1() func#2...
20: R1=3Dctx() R10=3Dfp0
; int f1(struct sk_buff *skb)

It's a context.

> > I'll say even more, with libbpf's PT_REGS_xxx() macros you don't even
> > need to know about pt_regs vs user_pt_regs difference, as macros
> > properly force-cast arguments, depending on architecture. So in your
> > BPF code you can just pass `struct pt_regs *` around just fine across
> > multiple architectures as long as you only use PT_REGS_xxx() macros
> > and then pass that context to helpers (to get stack trace,
> > bpf_perf_event_output, etc).
>
> Pretty much. For some time the kernel recognized bpf_user_pt_regs_t
> as PTR_TO_CTX for kprobe.
> And the users who needed global prog verification with ctx
> already used that feature.

Not really, see below. For a long time *we thought* that kernel
recognizes bpf_user_pt_regs_t, but in reality it wanted `struct
bpf_user_pt_regs_t` which doesn't even exist in kernel and has nothing
common with either `struct pt_regs` or `struct user_pt_regs`. I fixed
that and now the kernel recognizes *both* typedef and struct
bpf_user_pt_regs_t. And there is no point in using typedef, because
`struct bpf_user_pt_regs_t` is backwards compatible and that's what
users actually use in practice.

> We even have helper macros to typeof to correct btf type.
>
> From selftests:
>
> _weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
> {
>         return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
> }
>
> SEC("?kprobe")
> __success
> int kprobe_typedef_ctx(void *ctx)
> {
>         return kprobe_typedef_ctx_subprog(ctx);
> }
>
> #define pt_regs_struct_t typeof(*(__PT_REGS_CAST((struct pt_regs *)NULL))=
)
>
> __weak int kprobe_struct_ctx_subprog(pt_regs_struct_t *ctx)
> {
>         return bpf_get_stack((void *)ctx, &stack, sizeof(stack), 0);
> }
>
> SEC("?kprobe")
> __success
> int kprobe_resolved_ctx(void *ctx)
> {
>         return kprobe_struct_ctx_subprog(ctx);
> }
>
> __PT_REGS_CAST is arch dependent and typeof makes it seen with
> correct btf_id and the kernel knows it's PTR_TO_CTX.

TBH, I don't know what btf_id has to do with this, it looks either as
a distraction or subtle point you are making that I'm missing.
__PT_REGS_CAST() just does C language cast, there is no BTF or BTF ID
involved here, so what am I missing?

> All that works. No need for __arg_ctx.
> I'm sure you know this.
> I'm only explaining for everybody else to follow.
>

Ok, though I'm not sure we are actually agreeing that with libbpf's
PT_REGS_xxx() macros it's kind of expected that users will be using
`struct pt_regs *` everywhere (and not user_pt_regs).

And so actual real world code is actually written with explicit
`struct pt_regs *` being passed around. In all static subprogs as
well. And only global subprogs currently force the use of the fake
`struct bpf_user_pt_regs_t` (not typedef, it's so confusing, but I
have to emphasize the big difference, sorry!).

So what I'm saying (and I'm repeating that below) is that it would be
nice to make global subprogs use the same types as static subprogs,
which is just plain `struct pt_regs *ctx __arg_ctx`.

> > No one even knows about bpf_user_pt_regs_t, I had to dig it up from
> > kernel source code and let users know what exact type name to use for
> > global subprog.
>
> Few people know that global subprogs are verified differently than static=
.
> That's true, but I bet people that knew also used the right type for ctx.
> If you're saying that __arg_ctx is making it easier for users
> to use global subprogs I certainly agree, but it's not
> something that was mandatory for uniform global progs.

What is "uniform global progs"? If you mean those polymorphic global
subprogs, then keep in mind that only one level of global subprogs are
possible without this __arg_ctx approach. It's a big limitation right
now, actually.

> __arg_ctx main value is for polymorphic subprogs.

If you mean this libbpf's type rewriting logic for __arg_ctx, yes, I
agree. If you mean in general, then no, it's not just for polymorphic
subprogs. It's also to allow passing context in program types that
don't support passing context to global subprog (fentry, tracepoint,
etc). But libbpf cannot do anything about the latter case, if kernel
doesn't support __arg_ctx natively.

> An add-on value is ease-of-use for existing non polymorphic subrpogs.
>
> I'm saying that in the above example working code:
>
> __weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
>
> should _not_ be allowed to be replaced with:
>
> __weak int kprobe_typedef_ctx_subprog(struct pt_regs *ctx __arg_ctx)

Why not? This is what I don't get. Here's a real piece of code to
demonstrate what users do in practice:

struct bpf_user_pt_regs_t {}

__hidden int handle_event_user_pt_regs(struct bpf_user_pt_regs_t* ctx) {
  if (pyperf_prog_cfg.sample_interval > 0) {
    if (__sync_fetch_and_add(&total_events_count, 1) %
        pyperf_prog_cfg.sample_interval) {
      return 0;
    }
  }

  return handle_event_helper((struct pt_regs*)ctx, NULL);
}

See that cast to `struct pt_regs *`? It's because all non-global code
is working with struct pt_regs already, and it's fine.

Keep in mind, they can't use bpf_user_pt_regs_t typedef and avoid the
cast, because older kernels didn't recognize typedef, so they use
empty `struct bpf_user_pt_regs_t`, which has to be casted.

I don't want to get into a debate about whether they should convert
all `struct pt_regs *` to `bpf_user_pt_regs_t *`, that's not the
point. Maybe they could, but their code already is written like that
and works. Using struct pt_regs is not broken for them, both on x86-64
and arm64.

I'm saying that I explicitly do want to be able to declare (in general):

int handle_event_user(struct pt_regs *ctx __arg_ctx) { ...}

And this would work both on old and new kernels, with and without
native __arg_ctx support. And it will be very close to static subprogs
in the existing code base.

Why do you want to disallow this artificially?

>
> Unfortunately in the newest kernel/libbpf patches allowed it and
> this way both kernel and libbpf are silently breaking C type
> matching rules and general expectations of C language.

C types are still checked and enforced by the compiler. And only the
compiler. Verifier doesn't use BTF for verification of PTR_TO_CTX
beyond getting type name for global subprog argument. How is libbpf
breaking anything here?

>
> Consider these variants:
>
> 1.
> __weak int kprobe_typedef_ctx_subprog(struct pt_regs *ctx __arg_ctx)
> { PT_REGS_PARM1(ctx); }
>
> 2.
> __weak int kprobe_typedef_ctx_subprog(void *ctx __arg_ctx)
> { struct pt_regs *regs =3D ctx; PT_REGS_PARM1(regs); }
>
> 3.
> __weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
> { PT_REGS_PARM1(ctx); }
>
> In 1 and 3 the caller has to type cast to correct type.
> In 2 the caller can pass anything without type cast.
>
> In C when the user writes: void foo(int *p)
> it knows that it can access it as pointer to int in the callee
> and it's caller's job to pass correct pointer into it.
> When caller type casts something else to 'int *' it's caller's fault
> if things don't work.
> Now when user writes:
> void foo(void *p) { int *i =3D p;
>
> the caller can pass anything into foo() and callee's fault
> to assume that 'void *' is 'int *'.
> These are the C rules that we're breaking with __arg_ctx.
>
> In 2 it's clear to callee that any ctx argument could have been passed
> and type cast to 'struct pt_regs *' it's callee's responsibility.
>
> In 3 the users know that only bpf_user_pt_regs_t will be passed in.
>
> But 1 (the current kernel and libbpf) breaks these C rules.
> The C language tells prog writer to expect that only 'struct pt_regs *'
> will be passed, but the kernel/libbpf allows any ctx to be passed in.
>
> Hence 1 should be disallowed.

All the above is already checked and enforced by the compiler. Libbpf
doesn't subvert it in any way. All that libbpf is doing is saying "ah,
user, you want this argument to be treated as PTR_TO_CTX, right? Too
bad host kernel is a bit too old to understand __arg_ctx natively, but
worry you not, I'll just quickly fix up BTF information that *only
kernel* uses *only to check type name* (nothing else!), and it will
look like kernel actually understood __arg_ctx, that's all, happy
BPF'ing!". If a user is misusing types in his code, that will be
caught by the compiler. If user's code is doing something that the BPF
verifier detects as illegal, regardless of types and whatnot, the
verifier will complain.

I don't want libbpf to perform functions of both compiler and verifier
in these narrow and unnecessary cases. Especially that there are
specific situations where the user's code is correct and legal, and
yet libbpf will be complaining because... reasons.

>
> The 'void *' case 2 we extend in the future to truly support polymorphism=
:
>
> __weak int subprog(void *ctx __arg_ctx)
> {
>   __u32 ctx_btf_id =3D bpf_core_typeof(*ctx);
>
>   if (ctx_btf_id =3D=3D bpf_core_type_id_kernel(struct sk_buff)) {
>       struct sk_buff *skb =3D ctx;
>       ..
>   } else if (ctx_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_buff)) =
{
>       struct xdp_buff *xdp =3D ctx;
>
> and it will conform to C rules. It's on callee side to do the right
> thing with 'void *'.

