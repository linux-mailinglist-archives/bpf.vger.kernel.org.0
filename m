Return-Path: <bpf+bounces-62306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A358AF7D8C
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAAA1C86DFD
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A02F199C;
	Thu,  3 Jul 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="pukhBq/r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1AA2F198A
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558681; cv=none; b=sC3C1KALsCPrO+sCMyUVBoipTvR49Fe+wiDnKU40eQ+Z17kuOV0sT130B2LF7gOJppJIfW/RnlcA2jUnWjC90hvWa0tSA04ZCyr+AK4I/+CM9Wj87ecMYehVqKMwnlqZVKqLxRUE9NDLzqqaJgfrcdMNI+Nu4qvc4kk/L3FH2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558681; c=relaxed/simple;
	bh=w8ouu/T7wQTVDwrWc5iBTatWT0bz2dvI79plv7yF9VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gnuv1OkmLvl7cXfJOhcFxrUHbf0mrpk6+b9jri3iPotj53oeZEIJobMcFSjg/RWENy9Ow2qxrNBfJcZJeWKPqYvFz/FqOOTWlmwy6RT4Lhf6X4Vq8vVGuZ1Hv88Fqun3uN8zpn/J7ktoyU1GsMSy+oCIk0K/xKpXilHtHaOGUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=pukhBq/r; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e81826d5b72so6804275276.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751558676; x=1752163476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPWAKnXKrQ9v5zWCAveL5FeKmZp+rhBnWBfvO6oCoPg=;
        b=pukhBq/rL9qHtL39QtSUvynbPzp0eVk7rRFJEB34MvZYj/FMALNukWJ92OGojS4y+I
         EJKRhKLG4Qq9duemEjy/+Ux3C6t19twW1YZ5BpM/O8qXUy031Ibgtu/l3nnkfBe5mpE+
         lH01ddl7ifTWZw6iRlW2HaJSo9j6bUOVwT2CEuVNCEfTQMOX8REBLT3V4n42x0jcLvHq
         r4Zq7HkUTNsNSJyQNh7IM/U6iE8zAkZPGHlTQZ7UunfpAX2LahLJFbzsrQ6jRyb7voGk
         f6WhYPG0Sm8hqPVFdacEfd9f8ZM7vwE3harADpCnWD6i2I1L/U1PMUHY1rIRTGfekbF3
         +yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558676; x=1752163476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPWAKnXKrQ9v5zWCAveL5FeKmZp+rhBnWBfvO6oCoPg=;
        b=Fcwm6YR7JIWa+jwUwiCb+FOt5NpGlYT0m7in9JWf7DIa/V3i11pBBE9y7UEecfNV7W
         gfeRG2JmzOclWmL+PowMhH0B7megEyFiQtAZXOr0Ku1sUe1ZxNCOzGStd3AUjZ4oDZ9J
         2arYnIUwGMujgtgMHpCt4bZUePjortzJ8hu/Z9QP9xIdkNAWIM3wPlVpwfEwUWTeeAjC
         0bjH+8zUW2103GYTff8WbNuiRRnbxyQzT/I6kSyQsZ88QfToJQCZXa7KaKxrvZJtCzBf
         oDw+5HHU/uWJlW7fiEm4k3ale0Av8AqMCIAd3XbkNYfQg0MzwnkxOFS1kqV5LGfX4DML
         Jq4g==
X-Gm-Message-State: AOJu0Yzh6h5RxCjlMUqx8XvJg29Lnw9QoB1BMo6fpF8pfFcxS/AXTQWl
	TyYBJWowBFwe3pDAo7N0oC6KrkeGJPgZHswQLWu7aAg/lIVq4HXyhVPkMW2FOiWaFe/x+NMdJIo
	DrMRHtrWxYDj/kR/iobM390C2K528mDMfDEA92UFTDA==
X-Gm-Gg: ASbGncsZO9UPwWleDutpdbpnp9y0iB3Wd66ZbRGe3B611lY3gM+xEMmOL+6bXuONc2w
	pcfNpiSkkmmrrO+8mZ/Xg8D1Gw00egj8C5IW9r7lgJU01NBfQexkL1nAY9L6qaZdtgq+Vn9VUFq
	WLnEM8BK/HpmutOojx7DQp2x+40EwIR3LkacV7tqDacd15
X-Google-Smtp-Source: AGHT+IFmtVdEMhqVC3ilzJUWHKFnKEZDMxAC01UGVuEneat16sKcvyhWR0ER6EM67y5H1y3hnJlLIuwMFrmG1EZ6cLM=
X-Received: by 2002:a05:690c:4c05:b0:711:6419:5ce1 with SMTP id
 00721157ae682-716590cbfd7mr62307947b3.31.1751558676045; Thu, 03 Jul 2025
 09:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-6-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-6-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 12:04:25 -0400
X-Gm-Features: Ac12FXzHLaT4hFsV7lj9FSqVSk5FWneQaGSCuicjRjd6ZM4dYU42XkAI74-Ld88
Message-ID: <CABFh=a5TgSXV5DXHo7aD_J=k3iqN29KCRU-KBHiG7yhWw-qX0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Add function to find program from
 stack trace
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> In preparation of figuring out the closest program that led to the
> current point in the kernel, implement a function that scans through the
> stack trace and finds out the closest BPF program when walking down the
> stack trace.
>
> Special care needs to be taken to skip over kernel and BPF subprog
> frames. We basically scan until we find a BPF main prog frame. The
> assumption is that if a program calls into us transitively, we'll
> hit it along the way. If not, we end up returning NULL.
>
> Contextually the function will be used in places where we know the
> program may have called into us.
>
> Due to reliance on arch_bpf_stack_walk(), this function only works on
> x86 with CONFIG_UNWINDER_ORC, arm64, and s390. Remove the warning from
> arch_bpf_stack_walk as well since we call it outside bpf_throw()
> context.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c |  1 -
>  include/linux/bpf.h         |  1 +
>  kernel/bpf/core.c           | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 15672cb926fc..40e1b3b9634f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3845,7 +3845,6 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *c=
ookie, u64 ip, u64 sp, u64 bp
>         }
>         return;
>  #endif
> -       WARN(1, "verification of programs using bpf_throw should have fai=
led\n");
>  }
>
>  void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 09f06b1ea62e..4d577352f3e6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3662,5 +3662,6 @@ static inline bool bpf_is_subprog(const struct bpf_=
prog *prog)
>
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep,
>                            const char **linep, int *nump);
> +struct bpf_prog *bpf_prog_find_from_stack(void);
>
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b4203f68cf33..ab8b3446570c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3262,4 +3262,37 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
unsigned long ip, const char *
>         return 0;
>  }
>
> +struct walk_stack_ctx {
> +       struct bpf_prog *prog;
> +};
> +
> +static bool find_from_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> +{
> +       struct walk_stack_ctx *ctxp =3D cookie;
> +       struct bpf_prog *prog;
> +
> +       /*
> +        * The RCU read lock is held to safely traverse the latch tree, b=
ut we
> +        * don't need its protection when accessing the prog, since it ha=
s an
> +        * active stack frame on the current stack trace, and won't disap=
pear.
> +        */
> +       rcu_read_lock();
> +       prog =3D bpf_prog_ksym_find(ip);
> +       rcu_read_unlock();
> +       if (!prog)
> +               return true;
> +       if (bpf_is_subprog(prog))
> +               return true;
> +       ctxp->prog =3D prog;
> +       return false;
> +}
> +
> +struct bpf_prog *bpf_prog_find_from_stack(void)
> +{
> +       struct walk_stack_ctx ctx =3D {};
> +
> +       arch_bpf_stack_walk(find_from_stack_cb, &ctx);
> +       return ctx.prog;
> +}
> +
>  #endif
> --
> 2.47.1
>

