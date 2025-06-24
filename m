Return-Path: <bpf+bounces-61415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A43CAE6DD2
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97BA17D397
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F43231A51;
	Tue, 24 Jun 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqxkrrv+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE54126C05
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787183; cv=none; b=KS7xbIZSYUWWPVW7ZM6m4h51k4Uy/fQrK2DZhnAqWlDYrnt6pNzw6aMJd6DK8MgLM2jSUxR6DdjjMY0vYFn6aLgKWiziAX0mPMmnanJuHP81dYfBtZAnFR5wNdSGTDlju3A2/OwQJsDUPpLkHpjNs+I+s6k4/P/msupIrFc8RQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787183; c=relaxed/simple;
	bh=V0ObSnq57Aq7LhRDsj5zbxo7mMxyULksMGHebcfylY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnLBEHEyh9goGTyu345lOuV/xrk1qS6IAsJ7jC1INkg+oVL1gp72CxRVdQ1wbwjedPpkFmKptqxxqeEuTR2KoLB/PgQy3E7532dtAGm2bVFRP2HPZbdizujirtuxKqQYTtC6hgYKV27j/PBx4E2agq22rJwWvuVDMuRN8eGKp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqxkrrv+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453426170b6so531375e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750787179; x=1751391979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0bpciISCndgA54zjn9bnwP25l4dMBWZsrKIFL4F8Uw=;
        b=Kqxkrrv+k6lvc/XMtPzXNUNLm5uwtSN/0kNDf0JBjlW93+rSn5Jz3EC0sHCqn4xgHJ
         alB+KuwLC95KOlcsL+Si3OSPou60bD+3D55UROrgDHYo+FmF56EkAuk6ZvgkFVyNhTjM
         CcdpZx7OP/09d58dyUM6Jc00WjyLn93R9nepnFxwfMFu2bZ4q0WdM6X5vpYSgpOSfRvJ
         O5uQyD0YBhhLHF1ausLG52H9k2n3z31FbcOSjSqF6Ap4+E1PeHUL3rHiFawOrNfgThCZ
         yEmAmP6njhaGLEVTeJu6nqrlIFcVGe4NG+38MzcRmGPmBmSYUmLcgdWVrp8Y29bT+G8M
         NIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750787179; x=1751391979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0bpciISCndgA54zjn9bnwP25l4dMBWZsrKIFL4F8Uw=;
        b=DI9Gs9q7nd/LDoOtZV6FyKWsK34+ypfWmurep2i2rTwObLOaFM/KkUBCsUmHNzIMjy
         YeL3s+/KOrfGk2Lsgn/0rytWuG21bTlC+oFcYA66MKVAh85mNiz2nCjvxMcGqcmi8L2c
         H65zuh6iWasvFW116iAxs2pTFJRsWuwJV8aPDyl49sBx/37+q1XwQhOyqoITx2e8Cs/7
         DHWsC5yBFAM3Mat9mz/qjaNpJESFrmoDPEQIHWleB3Bmw7/7RrJIjqiFRV5Jd8P3GzP/
         H+TnQ4iCTAHQOL8KaPlpAGRyhozYRD0dL7DZZZBsI4D8/BcdSsMflh8CDZUFvxJ2BQ8f
         cK+w==
X-Gm-Message-State: AOJu0YxiZzOKBJVulvll9QHe3JMDnzoj8AvFPZlgHSTKIkwejaOgqj6a
	aXYp0N35bR16MS+GN3b25LHGqMYkH4fE23cztFp5kPjZ7izcFbp9BB03B8pRPEO/6DlANhSFlWp
	nee9f64Ko2RSgOzM3/WaM/gBgNGdZuq0=
X-Gm-Gg: ASbGncsoZMfgy3q+RbUABMDe4Z7wADOmJcxsd1VMvADWotaApxa0M59wpdOk9CEE+4o
	zwIu9uvcdVwF6hk8bVykYMrRcKwgM7tFSoLbnoNLOeXlXhr2BUbiXC/ObHfivtDjujreUxrFkqr
	CNIBDJ9Q6e39jNgb5ORrvon5hyrhE4MFPWLDITBn6EnIt75DAAIrKwT9wS1pk=
X-Google-Smtp-Source: AGHT+IE/aNW+B/F8X0GgPCxi6zJ55wx1Tm7hR3X0O4/PvoKuxq/YDWVhEINem7BhlfgAhjoTrzK+oa3rzaqT/eH75b0=
X-Received: by 2002:a05:6000:1acc:b0:3a4:e231:8632 with SMTP id
 ffacd0b85a97d-3a6e71cde0dmr3679589f8f.12.1750787179369; Tue, 24 Jun 2025
 10:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-6-memxor@gmail.com>
In-Reply-To: <20250624031252.2966759-6-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 10:46:08 -0700
X-Gm-Features: Ac12FXxe1mtrc2mLaTaGyuRtiR3-STTWqe-GyR0vuITr5Cg22axdV7vM03VItY0
Message-ID: <CAADnVQ+4NpB37Dc5dh1Mj19_=QbjMmNYU2UGqGLa=W8tsWAXmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/12] bpf: Add function to find program from
 stack trace
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:13=E2=80=AFPM Kumar Kartikeya Dwivedi
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
>  kernel/bpf/core.c           | 28 ++++++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
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
> index f30697c72ba9..cc14ff8e0b88 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3669,5 +3669,6 @@ static inline bool bpf_is_subprog(const struct bpf_=
prog *prog)
>
>  int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, cons=
t char **filep,
>                            const char **linep, int *nump);
> +struct bpf_prog *bpf_prog_find_from_stack(void);
>
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b4203f68cf33..3871d817396d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3262,4 +3262,32 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
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
> +       rcu_read_lock();
> +       prog =3D bpf_prog_ksym_find(ip);
> +       rcu_read_unlock();

Same here.
Otherwise it looks like an rcu noob mistake.

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

