Return-Path: <bpf+bounces-19051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE665824847
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8412F287FB4
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE028E0F;
	Thu,  4 Jan 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKP2w0JP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91328E09
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e67e37661so962284e87.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704393468; x=1704998268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj457E1t/NepR0JOENdx16qd5oEVavBN1vzTezPCuJM=;
        b=bKP2w0JPtdBkc2BOaqfMJutxXRrULgQDag0ts06JK2GMUhu6xUx14wfoS/qVFSE1ch
         x5TtPo9yUfK3KnHy+dK+tzTdPBhFNl/LoKJYtBxHBJwu+B0O3/ayxpmyguwS4+ptXckW
         YkcMSVzIHlHSH9Ak+m884GFzt/qRzw1079kjcu80yzywSzjULvCtPG0x+OCwOc2ctzCD
         6vW0ZrwLFAqeOLNDDQumW4mmBbGsUPqrN8wEql1w5a62O+O4KGmTlj/AP3FxxUq2U2vy
         R99awiXGHgwUNIOq8zW3DhEc01mH4XtUGB0pTXVfSVokhYjU++GhQX7fw09sDWfyfE81
         d3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393468; x=1704998268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uj457E1t/NepR0JOENdx16qd5oEVavBN1vzTezPCuJM=;
        b=GJDfTRpYsa/ib+9GNr09hwOFwm2qnlLYQ9hOk90rXY8Lcj7yoWYFpJKphygL0AV6lE
         sV4xQULa8YIvHtL0wie5XLP8S1VV6vIAdV7cEQ8Ur94qoKeRpyjjKb7cJzmbJSajJghJ
         mkvz7UGav0LQW14fV0fLcFdwoU1ErLW7/BEGopd7TZej+mJrnZbd58k2rhSgTRYZiGAu
         1QrUCnm1Ke+ug/ZpZby1FXFKXzfxju1icKIiq6wXgkrOAvjSTx4l9jDPAoaf2JQXkihU
         HVE8tdi7CCXUlW5oaPLl3qanvVM8qbj8DuINzk9l2STGdhg+7uXSLMkB6C2AT6SXPp4L
         0EqA==
X-Gm-Message-State: AOJu0YzMIv4QzhLLYv81FMAJe/TXWu2nack6YUl1elWpZEFhILCKOcP+
	DGcn780WcN5S5rxE1JlMQIn4a4Ef+EidaBkLYmk=
X-Google-Smtp-Source: AGHT+IH//tm/+uisteE3bSu9TEvkGMUKlttXSdNJ2SsvfrMElIG6sza66/51BfsY0JRj6Xm354DnqbHshkPSzooVoKw=
X-Received: by 2002:ac2:5df3:0:b0:50e:62b1:f68d with SMTP id
 z19-20020ac25df3000000b0050e62b1f68dmr578661lfq.78.1704393468015; Thu, 04 Jan
 2024 10:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104013847.3875810-1-andrii@kernel.org> <20240104013847.3875810-8-andrii@kernel.org>
 <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
In-Reply-To: <CAADnVQJn0+fvvbOVnfPFQm=1j+=oFsjy65T2-QY8Ps0pL4nh_A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 10:37:35 -0800
Message-ID: <CAEf4BzYt9yrGUBpSfAR8=vuh7kONFSsFZAKtbg21r4Hoj92gAQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 7/9] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 3, 2024 at 5:39=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> > the actual argument type not important, so that user can just define
> > "generic" signature:
> >
> >   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
>
> I still think that this __arg_ctx only makes sense with 'void *'.
> Blind rewrite of ctx is a foot gun.
>
> I've tried the following:
>
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.=
c
> b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> index 9a06e5eb1fbe..0e5f5205d4a8 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
> @@ -106,9 +106,9 @@ int perf_event_ctx(void *ctx)
>  /* this global subprog can be now called from many types of entry progs,=
 each
>   * with different context type
>   */
> -__weak int subprog_ctx_tag(void *ctx __arg_ctx)
> +__weak int subprog_ctx_tag(long ctx __arg_ctx)
>  {
> -       return bpf_get_stack(ctx, stack, sizeof(stack), 0);
> +       return bpf_get_stack((void *)ctx, stack, sizeof(stack), 0);
>  }
>
>  struct my_struct { int x; };
> @@ -131,7 +131,7 @@ int arg_tag_ctx_raw_tp(void *ctx)
>  {
>         struct my_struct x =3D { .x =3D 123 };
>
> -       return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x, ctx=
);
> +       return subprog_ctx_tag((long)ctx) +
> subprog_multi_ctx_tags(ctx, &x, ctx);
>  }
>
> and it "works".

Yeah, but you had to actively force casting everywhere *and* you still
had to consciously add __arg_ctx, right? If a user wants to subvert
the type system, they will do it. It's C, after all. But if they just
accidentally use sk_buff ctx and call it from the XDP program with
xdp_buff/xdp_md, the compiler will call out type mismatch.

>
> Both kernel and libbpf should really limit it to 'void *'.
>
> In the other email I suggested to allow types that match expected
> based on prog type, but even that is probably a danger zone as well.
> The correct type would already be detected by the verifier,
> so extra __arg_ctx is pointless.
> It makes sense only for such polymorphic functions and those
> better use 'void *' and don't dereference it.
>
> I think this can be a follow up.

Not really just polymorphic functions. Think about subprog
specifically for the fentry program, as one example. You *need*
__arg_ctx just to make context passing work, but you also want
non-`void *` type to access arguments.

int subprog(u64 *args __arg_ctx) { ... }

SEC("fentry")
int BPF_PROG(main_prog, ...)
{
    return subprog(ctx);
}

Similarly, tracepoint programs, you'd have:

int subprog(struct syscall_trace_enter* ctx __arg_ctx) { ... }

SEC("tracepoint/syscalls/sys_enter_kill")
int main_prog(struct syscall_trace_enter* ctx)
{
    return subprog(ctx);
}

So that's one group of cases.

Another special case are networking programs, where both "__sk_buff"
and "sk_buff" are allowed, same for "xdp_buff" and "xdp_md".

Also, kprobes are special, both "struct bpf_user_pt_regs_t" and
*typedef* "bpf_user_pt_regs_t" are supported. But in practice users
will often just use `struct pt_regs *ctx`, actually.

There might be some other edges I don't yet realize.

In short, I think any sort of enforcement will just cause unnecessary
pain, while seemingly fixing some problem that doesn't seem to be a
problem in practice.

