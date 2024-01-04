Return-Path: <bpf+bounces-19053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8F82486E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03F7287EF9
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114828E24;
	Thu,  4 Jan 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV6Ob/ml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C62C195
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33674f60184so740102f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704394364; x=1704999164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey+cHez0LQ0bZD9nqPbHUnO7DoZFPpik7ioiERFfYiY=;
        b=LV6Ob/mlCDd90wWI5trpQcZ1QzLkkIT2H3waJgl/m19aj2DZFmsxn3/0+3nOhS/Hj3
         pzOFLD5jwDG2dIBRv/+To3JDQDtzaAYEffVkMiLfuQ+USnOd3d+vLIAlKsqBYn04NNPa
         I6FoDy6VxM5w1fYCWAgPiZcO/C39QTgdsvQxZdQGwadNknt269XpPIiB5IEqXNsgob7i
         g0KHm6bQL3ou3g6oRk6bnIGJpni+1EKqvyFRJHQ85vbrWjnfdX5X91yRXLC/pwsP4G9d
         vuzVsLm1j4R9w37WWCtd0h4t/9cS1ts00yarI+LSfM/CzN558YNQTdTQtMGJz4vtw6Fa
         whAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704394364; x=1704999164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey+cHez0LQ0bZD9nqPbHUnO7DoZFPpik7ioiERFfYiY=;
        b=Zjpnf5E/wf05zC6UMIsfE+wZS4mktdqLz28ZOk9dkr30geqUiagEldwMIOoPwriY3F
         a2hsG2qmRvwqfUWQ7cxuq3Yjt5anqBm36XrFUL6Ko1aFvzqWcHQMVDv7rBAPW9+cw9lE
         QFpP1pdAl9MLcr8cwISgSEw83NE4/Jngtdg8W3uK1Hcc4kz81/RywGhq9BAmuExIiFZr
         Pt2mHWW+SgWhPcsWuR74YS+vpKL46m/37BLIkKYqwj4887xU1+934JR0J7Ft/KM5ERPR
         Qs0ejb7X5UV7NNY9StpX2s3Pnwxnze5cK8KZXhRLUcLTr+tvjcORXc9KpyIM6TnzB8Gc
         XDvw==
X-Gm-Message-State: AOJu0YxDBttTuLcu8ECTJcaSCYQV5nzr1ShGc6t7yxUxip279Nm6smD9
	BwwgOuo8mom0JqllJ2HCPeVTVYL3fd4GtWe4SYY=
X-Google-Smtp-Source: AGHT+IH3ZwLCZPIJodnfBsP2B89CEPyUPOGw5RQKuBljjLy2c2PeqrZU2w5W4+2PPeIyYMhQXs+yqWP6t2WsZlH3MhM=
X-Received: by 2002:a05:6000:1212:b0:336:6c01:b8cf with SMTP id
 e18-20020a056000121200b003366c01b8cfmr535641wrx.87.1704394363395; Thu, 04 Jan
 2024 10:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
 <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com> <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 10:52:31 -0800
Message-ID: <CAADnVQLOYU67aRyp92S0G8AEVxXRYndb6hWrtHZOH9gr0Q7JEQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:37=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 3, 2024 at 9:39=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jan 3, 2024 at 5:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> > > the actual argument type not important, so that user can just define
> > > "generic" signature:
> > >
> > >   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
> >
> > I still think that this __arg_ctx only makes sense with 'void *'.
> > Blind rewrite of ctx is a foot gun.
> >
> > I've tried the following:
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_arg=
s.c
> > b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> > index 9a06e5eb1fbe..0e5f5205d4a8 100644
> > --- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> > +++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> > @@ -106,9 +106,9 @@ int perf_event_ctx(void *ctx)
> >  /* this global subprog can be now called from many types of entry prog=
s, each
> >   * with different context type
> >   */
> > -__weak int subprog_ctx_tag(void *ctx __arg_ctx)
> > +__weak int subprog_ctx_tag(long ctx __arg_ctx)
> >  {
> > -       return bpf_get_stack(ctx, stack, sizeof(stack), 0);
> > +       return bpf_get_stack((void *)ctx, stack, sizeof(stack), 0);
> >  }
> >
> >  struct my_struct { int x; };
> > @@ -131,7 +131,7 @@ int arg_tag_ctx_raw_tp(void *ctx)
> >  {
> >         struct my_struct x =3D { .x =3D 123 };
> >
> > -       return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x, c=
tx);
> > +       return subprog_ctx_tag((long)ctx) +
> > subprog_multi_ctx_tags(ctx, &x, ctx);
> >  }
> >
> > and it "works".
>
> Yeah, but you had to actively force casting everywhere *and* you still
> had to consciously add __arg_ctx, right? If a user wants to subvert
> the type system, they will do it. It's C, after all. But if they just
> accidentally use sk_buff ctx and call it from the XDP program with
> xdp_buff/xdp_md, the compiler will call out type mismatch.

I could have used long everywhere and avoided casts.

> >
> > Both kernel and libbpf should really limit it to 'void *'.
> >
> > In the other email I suggested to allow types that match expected
> > based on prog type, but even that is probably a danger zone as well.
> > The correct type would already be detected by the verifier,
> > so extra __arg_ctx is pointless.
> > It makes sense only for such polymorphic functions and those
> > better use 'void *' and don't dereference it.
> >
> > I think this can be a follow up.
>
> Not really just polymorphic functions. Think about subprog
> specifically for the fentry program, as one example. You *need*
> __arg_ctx just to make context passing work, but you also want
> non-`void *` type to access arguments.
>
> int subprog(u64 *args __arg_ctx) { ... }
>
> SEC("fentry")
> int BPF_PROG(main_prog, ...)
> {
>     return subprog(ctx);
> }
>
> Similarly, tracepoint programs, you'd have:
>
> int subprog(struct syscall_trace_enter* ctx __arg_ctx) { ... }
>
> SEC("tracepoint/syscalls/sys_enter_kill")
> int main_prog(struct syscall_trace_enter* ctx)
> {
>     return subprog(ctx);
> }
>
> So that's one group of cases.

But the above two are not supported by libbpf
since it doesn't handle "tracing" and "tracepoint" prog types
in global_ctx_map.
I suspect the kernel sort-of supports above, but in a dangerous
and broken way.

My point is that users must not use __arg_ctx in these two cases.
fentry (tracing prog type) wants 'void *' in the kernel to
match to ctx.
So the existing mechanism (prior to arg_ctx in the kernel)
should already work.

> Another special case are networking programs, where both "__sk_buff"
> and "sk_buff" are allowed, same for "xdp_buff" and "xdp_md".

what do you mean both?
networking bpf prog must only use __sk_buff and that is one and
only supported ctx.
Using 'struct sk_buff *ctx __arg_ctx' will be a bad bug.
Since offsets will be all wrong while ctx rewrite will apply garbage
and will likely fail.

> Also, kprobes are special, both "struct bpf_user_pt_regs_t" and
> *typedef* "bpf_user_pt_regs_t" are supported. But in practice users
> will often just use `struct pt_regs *ctx`, actually.

Same thing. The global bpf prog has to use bpf_user_pt_regs_t
to be properly recognized as ctx arg type.
Nothing special. Using 'struct pt_regs * ctx __arg_ctx' and blind
rewrite will cause similar hard to debug bugs when
bpf_user_pt_regs_t doesn't match pt_regs that bpf prog sees
at compile time.

