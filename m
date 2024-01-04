Return-Path: <bpf+bounces-19066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431768249E4
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F471F23424
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FE528E03;
	Thu,  4 Jan 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJEo0xWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FA2C1B5
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-556ea884968so1113463a12.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704401916; x=1705006716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG1xxcdJwyhqh7oFACCdO8dJ6hXhXM6B32M1bqgt+gw=;
        b=aJEo0xWatYGJ7Ye01orzeTuOr4EVetzoI3ay8RgH5ib+vWevZJdHfcwf7vdT/vkEhh
         j/xvnTZEfVaU9nw+BzAiYK4Db+xIbk4v0qf2+ymf6JO+SM0lBOYSACKWc3v9J4dcJcVL
         duiVT8gPO1BMsM4MPGlEoun7jvvboVCtirpUW9UP5oLW8Hcc2Po60zhPRIfGpCwTopje
         nHQO0n4Gen5+C4A2cuEccmtrg+nclCKs99D6WkuHpxogBhR3cJauyYIamUWJxTwWGWgT
         4uIFWM+Fgo1hkLgRoDSvu21v7dkDrJZ/ee10CqJXpjQnKGiSmd8nNEvrC4UYV9yYgKiv
         FLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704401916; x=1705006716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG1xxcdJwyhqh7oFACCdO8dJ6hXhXM6B32M1bqgt+gw=;
        b=HaXtCQ8R5EGDcI+j4/H3NnUDoh+2pJI/CsdyhHOqibSdlWZ6URrxFoIsxgixDXw1rP
         /z6H1GqtuLf0oGAOKNCVssuj29L68PiPXw9lSMfGEm+TcMTUG7DnAVz4vUsFzSmT2mDn
         Vb+xMD0pSUgpBN+VSBp2dUAUJcr+3T21sqAc5sbl3Tgneri6q8EDR0ZqKwXuFGqcjfen
         ifB2o0klOXqVyDMh6Lm8WkOlnKUGhJeVhVdTTe+iXe5jJ9J11L8T70k8LVBg+qielQ/5
         Ci09Ilu8XBw7FqvR3VZZoakY10sjPEYhfQ1h5Rs3ljHMULV4Anhi+UtUOTYxA4Jf+jQD
         OCSw==
X-Gm-Message-State: AOJu0YwCBEzEsAOgCISMJ/0HjSBGf9zKM6Mo1wy88Hu7XrnOpgYrxHHJ
	XDJkIramdW2E5U+azxVl7Gz7D9TMssx/h5fmFFo=
X-Google-Smtp-Source: AGHT+IGO0UPrXN43HJ0IHFOPn2n/WT/ItMeybW9vQPUrlyOhBLH9nEiiFSAEkl9iH8T0VkRCHYGdu64dey+XmWHivBI=
X-Received: by 2002:a50:8e5c:0:b0:556:c95d:9cfa with SMTP id
 28-20020a508e5c000000b00556c95d9cfamr640296edx.75.1704401915619; Thu, 04 Jan
 2024 12:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
 <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
 <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com> <CAADnVQLOYU67aRyp92S0G8AEVxXRYndb6hWrtHZOH9gr0Q7JEQ@mail.gmail.com>
In-Reply-To: <CAADnVQLOYU67aRyp92S0G8AEVxXRYndb6hWrtHZOH9gr0Q7JEQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 12:58:23 -0800
Message-ID: <CAEf4BzaSspEa27TtMLRv-V4ipGhVdK9y5Ynu9teYNDp4f0CctA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:52=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 10:37=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jan 3, 2024 at 9:39=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jan 3, 2024 at 5:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > > >
> > > > This limitation was the reason to add btf_decl_tag("arg:ctx"), maki=
ng
> > > > the actual argument type not important, so that user can just defin=
e
> > > > "generic" signature:
> > > >
> > > >   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
> > >
> > > I still think that this __arg_ctx only makes sense with 'void *'.
> > > Blind rewrite of ctx is a foot gun.
> > >
> > > I've tried the following:
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_a=
rgs.c
> > > b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> > > index 9a06e5eb1fbe..0e5f5205d4a8 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> > > @@ -106,9 +106,9 @@ int perf_event_ctx(void *ctx)
> > >  /* this global subprog can be now called from many types of entry pr=
ogs, each
> > >   * with different context type
> > >   */
> > > -__weak int subprog_ctx_tag(void *ctx __arg_ctx)
> > > +__weak int subprog_ctx_tag(long ctx __arg_ctx)
> > >  {
> > > -       return bpf_get_stack(ctx, stack, sizeof(stack), 0);
> > > +       return bpf_get_stack((void *)ctx, stack, sizeof(stack), 0);
> > >  }
> > >
> > >  struct my_struct { int x; };
> > > @@ -131,7 +131,7 @@ int arg_tag_ctx_raw_tp(void *ctx)
> > >  {
> > >         struct my_struct x =3D { .x =3D 123 };
> > >
> > > -       return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x,=
 ctx);
> > > +       return subprog_ctx_tag((long)ctx) +
> > > subprog_multi_ctx_tags(ctx, &x, ctx);
> > >  }
> > >
> > > and it "works".
> >
> > Yeah, but you had to actively force casting everywhere *and* you still
> > had to consciously add __arg_ctx, right? If a user wants to subvert
> > the type system, they will do it. It's C, after all. But if they just
> > accidentally use sk_buff ctx and call it from the XDP program with
> > xdp_buff/xdp_md, the compiler will call out type mismatch.
>
> I could have used long everywhere and avoided casts.
>

My point was that it's hard to accidentally forget to "generalize"
type if you were supporting sk_buff, and suddenly started calling it
with xdp_md.

From my POV, if I'm a user, and I declare an argument as long and
annotate it as __arg_ctx, then I know what I'm doing and I'd hate for
some smart-ass library to double-guess me dictating what exact
incantation I should specify to make it happy.

If I'm clueless and just randomly sprinkling __arg_ctx, then I have
bigger problems than type mismatch.

> > >
> > > Both kernel and libbpf should really limit it to 'void *'.
> > >
> > > In the other email I suggested to allow types that match expected
> > > based on prog type, but even that is probably a danger zone as well.
> > > The correct type would already be detected by the verifier,
> > > so extra __arg_ctx is pointless.
> > > It makes sense only for such polymorphic functions and those
> > > better use 'void *' and don't dereference it.
> > >
> > > I think this can be a follow up.
> >
> > Not really just polymorphic functions. Think about subprog
> > specifically for the fentry program, as one example. You *need*
> > __arg_ctx just to make context passing work, but you also want
> > non-`void *` type to access arguments.
> >
> > int subprog(u64 *args __arg_ctx) { ... }
> >
> > SEC("fentry")
> > int BPF_PROG(main_prog, ...)
> > {
> >     return subprog(ctx);
> > }
> >
> > Similarly, tracepoint programs, you'd have:
> >
> > int subprog(struct syscall_trace_enter* ctx __arg_ctx) { ... }
> >
> > SEC("tracepoint/syscalls/sys_enter_kill")
> > int main_prog(struct syscall_trace_enter* ctx)
> > {
> >     return subprog(ctx);
> > }
> >
> > So that's one group of cases.
>
> But the above two are not supported by libbpf
> since it doesn't handle "tracing" and "tracepoint" prog types
> in global_ctx_map.

Ok, so I'm confused now. I thought we were talking about both
kernel-side and libbpf-side extra checks.

Look, I don't want libbpf to be too smart and actually cause
unnecessary problems for users (pt_regs being one such case, see
below), and making users do work arounds just to satisfy libbpf. Like
passing `void * ctx __arg_ctx`, but then casting to `struct pt_regs`,
for example. (see below about pt_regs)

Sure, if someone has no clue what they are doing and specifies a
different type, I think it's acceptable for them to have that bug.
They will debug it, fix it, learn something, and won't do it again.
I'd rather assume users know what they are doing rather than
double-guess what they are doing.

If we are talking about libbpf-only changes just for those types that
libbpf is rewriting, fine (though I'm still not happy about struct
pt_regs case not working), we can add it. If Eduard concurs, I'll add
it, it's not hard. But as I said, I think libbpf would be doing
something that it's not supposed to do here (libbpf is just silently
adding an annotation, effectively, it's not changing how code is
generated or how verifier is interpreting types).

If we are talking about kernel-side extra checks, I propose we do that
on my next patch set adding PTR_TO_BTF_ID, but again, we need to keep
those non-polymorphic valid cases in mind (u64 *ctx for fentry,
tracepoint structs, etc) and not make them unnecessarily painful.

> I suspect the kernel sort-of supports above, but in a dangerous
> and broken way.
>
> My point is that users must not use __arg_ctx in these two cases.
> fentry (tracing prog type) wants 'void *' in the kernel to
> match to ctx.
> So the existing mechanism (prior to arg_ctx in the kernel)
> should already work.

Let's unpack. fentry doesn't "want" `void *`, it just doesn't support
passing context argument to global subprog. So you would have to
specify __arg_ctx, and that will only work on recent enough kernels.

At that point, all of `long ctx __arg_ctx`, `void *ctx __arg_ctx` and
`u64 *ctx __arg_ctx` will work. Yes, `long ctx` out of those 3 are
weird, but verifier will treat it as PTR_TO_CTX regardless of specific
type correctly.

More importantly, I'm saying that both `void *ctx __arg_ctx` and `u64
*ctx __arg_ctx` should work for fentry, don't you agree?

>
> > Another special case are networking programs, where both "__sk_buff"
> > and "sk_buff" are allowed, same for "xdp_buff" and "xdp_md".
>
> what do you mean both?
> networking bpf prog must only use __sk_buff and that is one and
> only supported ctx.
> Using 'struct sk_buff *ctx __arg_ctx' will be a bad bug.
> Since offsets will be all wrong while ctx rewrite will apply garbage
> and will likely fail.

You are right about wrong offsets, but the kernel does allow it. See
[0]. I actually tried, and indeed, it allows sk_buff to denote
"context". Note that I had to comment out skb->len dereference
(otherwise verifier will correctly complain about wrong offset), but
it is recognized as PTR_TO_CTX and I could technically pass it to
another subprog or helpers/kfuncs (and that would work).

  [0] https://lore.kernel.org/all/20230301154953.641654-2-joannelkoong@gmai=
l.com/

diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c
b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 2beab9c3b68a..29d7f3e78f8e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -1,16 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
-#include <stddef.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"

 #define MAX_STACK (512 - 3 * 32)

 static __attribute__ ((noinline))
-int f0(int var, struct __sk_buff *skb)
+int f0(int var, struct sk_buff *skb)
 {
-       return skb->len;
+       return 0;
 }

 __attribute__ ((noinline))
@@ -20,7 +19,7 @@ int f1(struct __sk_buff *skb)

        __sink(buf[MAX_STACK - 1]);

-       return f0(0, skb) + skb->len;
+       return f0(0, (void*)skb) + skb->len;
 }

 int f3(int, struct __sk_buff *skb, int);
@@ -45,5 +44,5 @@ SEC("tc")
 __success
 int global_func2(struct __sk_buff *skb)
 {
-       return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
+       return f0(1, (void *)skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
 }


>
> > Also, kprobes are special, both "struct bpf_user_pt_regs_t" and
> > *typedef* "bpf_user_pt_regs_t" are supported. But in practice users
> > will often just use `struct pt_regs *ctx`, actually.
>
> Same thing. The global bpf prog has to use bpf_user_pt_regs_t
> to be properly recognized as ctx arg type.
> Nothing special. Using 'struct pt_regs * ctx __arg_ctx' and blind
> rewrite will cause similar hard to debug bugs when
> bpf_user_pt_regs_t doesn't match pt_regs that bpf prog sees
> at compile time.

So this is not the same thing as skbuff. If BPF program is meant for a
single architecture, like x86-64, it's completely valid (and that's
what people have been doing with static subprogs for ages now) to just
use `struct pt_regs`. They are the same thing on x86.

I'll say even more, with libbpf's PT_REGS_xxx() macros you don't even
need to know about pt_regs vs user_pt_regs difference, as macros
properly force-cast arguments, depending on architecture. So in your
BPF code you can just pass `struct pt_regs *` around just fine across
multiple architectures as long as you only use PT_REGS_xxx() macros
and then pass that context to helpers (to get stack trace,
bpf_perf_event_output, etc).

No one even knows about bpf_user_pt_regs_t, I had to dig it up from
kernel source code and let users know what exact type name to use for
global subprog.

