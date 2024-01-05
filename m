Return-Path: <bpf+bounces-19100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A379824C98
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 02:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740E41C22772
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4E1FBF;
	Fri,  5 Jan 2024 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNFcYEf2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB51FA3
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336788cb261so808265f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 17:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704418450; x=1705023250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTU3BEd57q6Iqlyfk1MFWnb+N40Hc9qX00XCpvcwStI=;
        b=mNFcYEf28sDpReyg51l1X6zscMcgC7MQjNfkSHwC/2UgwSKIqx5WVXvEO0BaQo80GA
         INvqi7mjYM88XfOph6t7pQAuTvk6iSSkicFB5xQK+edC2vpwIdOPSoILAa39D+CYSPTw
         TjpnzJpzMv+zJ+mZw4vkD2YN9S7xEjB9G7AS/5Tf4GUyytS2iaDI1oZ5MDUTN1RpJzxn
         ADKkw7kz3Yspax2PtppvJQw8I4QpwHA0KM+kcG/UWxeKQ2spSQk74NACN1+fsBr8lIwt
         rZ2vhNGbH2mh6obyubk9O6EcDQJf7W7pdfjoUycF0PTxqo7FtNy9CsRjY9XgzDDXmkeJ
         UFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704418450; x=1705023250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTU3BEd57q6Iqlyfk1MFWnb+N40Hc9qX00XCpvcwStI=;
        b=coh1vOuxMABj+RwYeFeVqVzAOy4b73ntC4LejaQv57HazpL7PT36aX+/jagqUQc7MD
         +242nAyVUm/TCAMnI8rO1K5geg9qtORUsrSTdBQswmM6fGF8O5P42+cALkFbnR4sOfEx
         JlW2NaZZmttiSa6jGS2mdCJa2WWjLI5rMD/dI3iSgB4NptwGVOM9XDebA0jEma7zXC0X
         JJxyYUAOr7jVoXT+ym7is/TyTiu1oXFjxgYTyPVjKweprIXX+03ognx2InT2M7pvMDpj
         W1i76VBfoCP/FZJk+rKf56p+E27GVRsWHu6TBpJFF3mQmFR9EynTfo2f0pS7eA+PaqiA
         Ebtg==
X-Gm-Message-State: AOJu0YzkauoKdEJQtUQdhLNwUVSCd+YtBKtrAf5gFCBDLyXTMFrIdOCl
	LoJHtb/oT9JELhTe1Skq+2scZ62ki1T+ce/fUxs=
X-Google-Smtp-Source: AGHT+IEsZB4PRLPEY2+sDJOcfglO4hd6hZbDHF4X7/PfNnpU53LF74nHx+icjZpXpxE6MWizEEKVZePlIKC+S3Fpfzo=
X-Received: by 2002:adf:eb89:0:b0:337:2e15:21be with SMTP id
 t9-20020adfeb89000000b003372e1521bemr816363wrn.54.1704418449403; Thu, 04 Jan
 2024 17:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
 <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
 <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com>
 <CAADnVQLOYU67aRyp92S0G8AEVxXRYndb6hWrtHZOH9gr0Q7JEQ@mail.gmail.com> <CAEf4BzaSspEa27TtMLRv-V4ipGhVdK9y5Ynu9teYNDp4f0CctA@mail.gmail.com>
In-Reply-To: <CAEf4BzaSspEa27TtMLRv-V4ipGhVdK9y5Ynu9teYNDp4f0CctA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jan 2024 17:33:57 -0800
Message-ID: <CAADnVQKPSXUxT6HLF-hMeVd6zJhNqriFjaqdeNkyj_wRFN8Hdg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 12:58=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> My point was that it's hard to accidentally forget to "generalize"
> type if you were supporting sk_buff, and suddenly started calling it
> with xdp_md.
>
> From my POV, if I'm a user, and I declare an argument as long and
> annotate it as __arg_ctx, then I know what I'm doing and I'd hate for
> some smart-ass library to double-guess me dictating what exact
> incantation I should specify to make it happy.

But that's exactly what's happening!
The smart-ass libbpf ignores the type in 'struct sk_buff *skb __arg_ctx'
and replaces it with whatever is appropriate for prog type.
More below.

>  static __attribute__ ((noinline))
> -int f0(int var, struct __sk_buff *skb)
> +int f0(int var, struct sk_buff *skb)
>  {
> -       return skb->len;
> +       return 0;
>  }
>
>  __attribute__ ((noinline))
> @@ -20,7 +19,7 @@ int f1(struct __sk_buff *skb)
>
>         __sink(buf[MAX_STACK - 1]);
>
> -       return f0(0, skb) + skb->len;
> +       return f0(0, (void*)skb) + skb->len;

This is static f0. Not sure what you're trying to say.
I don't think btf_get_prog_ctx_type() logic applies here.

> I'll say even more, with libbpf's PT_REGS_xxx() macros you don't even
> need to know about pt_regs vs user_pt_regs difference, as macros
> properly force-cast arguments, depending on architecture. So in your
> BPF code you can just pass `struct pt_regs *` around just fine across
> multiple architectures as long as you only use PT_REGS_xxx() macros
> and then pass that context to helpers (to get stack trace,
> bpf_perf_event_output, etc).

Pretty much. For some time the kernel recognized bpf_user_pt_regs_t
as PTR_TO_CTX for kprobe.
And the users who needed global prog verification with ctx
already used that feature.
We even have helper macros to typeof to correct btf type.

From selftests:

_weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
{
        return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
}

SEC("?kprobe")
__success
int kprobe_typedef_ctx(void *ctx)
{
        return kprobe_typedef_ctx_subprog(ctx);
}

#define pt_regs_struct_t typeof(*(__PT_REGS_CAST((struct pt_regs *)NULL)))

__weak int kprobe_struct_ctx_subprog(pt_regs_struct_t *ctx)
{
        return bpf_get_stack((void *)ctx, &stack, sizeof(stack), 0);
}

SEC("?kprobe")
__success
int kprobe_resolved_ctx(void *ctx)
{
        return kprobe_struct_ctx_subprog(ctx);
}

__PT_REGS_CAST is arch dependent and typeof makes it seen with
correct btf_id and the kernel knows it's PTR_TO_CTX.
All that works. No need for __arg_ctx.
I'm sure you know this.
I'm only explaining for everybody else to follow.

> No one even knows about bpf_user_pt_regs_t, I had to dig it up from
> kernel source code and let users know what exact type name to use for
> global subprog.

Few people know that global subprogs are verified differently than static.
That's true, but I bet people that knew also used the right type for ctx.
If you're saying that __arg_ctx is making it easier for users
to use global subprogs I certainly agree, but it's not
something that was mandatory for uniform global progs.
__arg_ctx main value is for polymorphic subprogs.
An add-on value is ease-of-use for existing non polymorphic subrpogs.

I'm saying that in the above example working code:

__weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)

should _not_ be allowed to be replaced with:

__weak int kprobe_typedef_ctx_subprog(struct pt_regs *ctx __arg_ctx)

Unfortunately in the newest kernel/libbpf patches allowed it and
this way both kernel and libbpf are silently breaking C type
matching rules and general expectations of C language.

Consider these variants:

1.
__weak int kprobe_typedef_ctx_subprog(struct pt_regs *ctx __arg_ctx)
{ PT_REGS_PARM1(ctx); }

2.
__weak int kprobe_typedef_ctx_subprog(void *ctx __arg_ctx)
{ struct pt_regs *regs =3D ctx; PT_REGS_PARM1(regs); }

3.
__weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
{ PT_REGS_PARM1(ctx); }

In 1 and 3 the caller has to type cast to correct type.
In 2 the caller can pass anything without type cast.

In C when the user writes: void foo(int *p)
it knows that it can access it as pointer to int in the callee
and it's caller's job to pass correct pointer into it.
When caller type casts something else to 'int *' it's caller's fault
if things don't work.
Now when user writes:
void foo(void *p) { int *i =3D p;

the caller can pass anything into foo() and callee's fault
to assume that 'void *' is 'int *'.
These are the C rules that we're breaking with __arg_ctx.

In 2 it's clear to callee that any ctx argument could have been passed
and type cast to 'struct pt_regs *' it's callee's responsibility.

In 3 the users know that only bpf_user_pt_regs_t will be passed in.

But 1 (the current kernel and libbpf) breaks these C rules.
The C language tells prog writer to expect that only 'struct pt_regs *'
will be passed, but the kernel/libbpf allows any ctx to be passed in.

Hence 1 should be disallowed.

The 'void *' case 2 we extend in the future to truly support polymorphism:

__weak int subprog(void *ctx __arg_ctx)
{
  __u32 ctx_btf_id =3D bpf_core_typeof(*ctx);

  if (ctx_btf_id =3D=3D bpf_core_type_id_kernel(struct sk_buff)) {
      struct sk_buff *skb =3D ctx;
      ..
  } else if (ctx_btf_id =3D=3D bpf_core_type_id_kernel(struct xdp_buff)) {
      struct xdp_buff *xdp =3D ctx;

and it will conform to C rules. It's on callee side to do the right
thing with 'void *'.

