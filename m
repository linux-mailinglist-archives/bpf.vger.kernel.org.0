Return-Path: <bpf+bounces-62311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F4AF7DE5
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7445F188290D
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9F24DCEC;
	Thu,  3 Jul 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0kWIyVfY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB723BF83
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560000; cv=none; b=qAK5jArJ1Adv9PBGioLQ/119PFW4rRzPmIarhrRrOaNjAzQtpAA/Qe6rTNuqjUQk8UxDgJ+3J5p/KMX5+0hB8I8p2Z1dw+Tuf2JCrmwu7mPpB1E4HelsR9BAvo+rvHa6VwIcSFnB8hd02fFXQSm3VFZAC+eFtwxtlD4DtuLBmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560000; c=relaxed/simple;
	bh=IOj0FsLZikNMNQLaCUMu93W14tJqlKBAAAP1HBCQ/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONT6HDyfRaC+PwFOTKjSglwiEdugxIkKYxkl3LcVf85uIrLspDggHdHrzBP5IRJ01UhX8vLu/NMpXUDu0TgxFIu6J/6wp4kf3A2es7joybedBefWMjD2EK1rAGQCh3N7VPG74vTyls6kCySj03I9CMWd5dOHusxlZF0AnhEKT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0kWIyVfY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e40e3f316so51798277b3.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751559997; x=1752164797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w0JYSYhFUj0uDiLtml2uNZm9CcWCCOpkN8WVXcPQb4=;
        b=0kWIyVfYLoJ0Rn1P3mBro8CODdu331Je7eAQxu4glPur9NssvL2ytgj7SdziebLERe
         8fmbwfUEJosIeaD+8X3KnqvGWwFXkOClGWDEBAmhFPkqV1nNPUaNdKjVUegzjGGjOB3u
         O5FzKZFU/IZM9/ysncxlNWK72uJHrsqPJPesAAADZOQnntAWjpLie17/4aegKgf6mQCx
         Rh59IjuC+PRnbKij8JviZlxTbHhfmFUEJPW1dUCx8WyjSnWmoFLvwsPOK+g5fntcqMMy
         JkLKupuBxzYk3jmiLUtpgjRXDi5Q7eeeqrvSoHjyBcVRuqAC/BFQUKb/9uW0aR5beuQb
         75Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559997; x=1752164797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w0JYSYhFUj0uDiLtml2uNZm9CcWCCOpkN8WVXcPQb4=;
        b=rVhLd7RzY33CXIbeChC+f/ndVPGQJHdhB/tteBIXuoDtQlZ+BoIAWpwMhGijTNGpNZ
         KJYeZL2KYFvv3ddd+sFEG3YeQGfiK14l6ZgmywAuEd9p5itbCQ5ZWjuKbc9fqYxDvXvq
         KGpREWB+ACMWR4YclHt/dI8r/mRGKdMzBf0jNdiC3sVi/6cC8fYvASE1OsUaodTi73cK
         75pt0T6cgJC+1cHI2x7bu82ckaquQMkJ7jJWAx9gaQVDEx0uweTrPr4V0caAn9ykQXsl
         JDkfpYHyOFKiKC1AIgIxeNNJSoh8y9tdFcdEPSJMDh8WTWTnlHPvBbIQ5At9GDL4Lizl
         3ozg==
X-Gm-Message-State: AOJu0Yyg8/E0yp4ifqOCllSkFNpyPU8P3OQY5Ie55WZM8SUCBW3xgHSp
	oYRHY4VoW++yPhoJOvAMeR+EJ4KGn3WSFuZM89YuzwWIr1J7wSD5rfx5n5Y2Fporn5xXMnSAsH/
	otUr29BPJ1T0/aWI58vEPKMjL5MmGkNeEz69EfPgD4A==
X-Gm-Gg: ASbGncsbFEKeeGEAqRtoTIUxvIugatEnbQnqKnGYwRn1TYDr+ongL13E91ok5m1BQRp
	HCfFcr9r6z6Wv0qr3IejWO0VkMQaXAqtz1hTgExWK5NJiTCYm6a93/6HUb9OrW2tXQvCuO5GYLc
	/EK6fjuG7zzyEJjVBpBHMcQxH6Xb5U7a4K280lfQlhxFmH
X-Google-Smtp-Source: AGHT+IFa7t9xJ6I+owubgGo/3seVwOYnViO1leJxDQ8hR1dMVWScI1GeIzHoYQRvQS9E+u+W6UPl3nJPkG2hdJPm7Sg=
X-Received: by 2002:a05:690c:38d:b0:710:e8a8:771d with SMTP id
 00721157ae682-7164d3f1d52mr102010557b3.24.1751559996742; Thu, 03 Jul 2025
 09:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-7-memxor@gmail.com>
In-Reply-To: <20250702031737.407548-7-memxor@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Thu, 3 Jul 2025 12:26:24 -0400
X-Gm-Features: Ac12FXxJtCK-i7uRkwHgKfX03UgSsy_U2q_rbMDRSOpyjq4nr0F_pgFPW4Xt9ks
Message-ID: <CABFh=a6iWx9wjxYARijv=Vd5UeU=Qiy1DKf93Gs+J+izE35dsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: Add dump_stack() analogue to print
 to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Introduce a kernel function which is the analogue of dump_stack()
> printing some useful information and the stack trace. This is not
> exposed to BPF programs yet, but can be made available in the future.
>
> When we have a program counter for a BPF program in the stack trace,
> also additionally output the filename and line number to make the trace
> helpful. The rest of the trace can be passed into ./decode_stacktrace.sh
> to obtain the line numbers for kernel symbols.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h |  2 ++
>  kernel/bpf/stream.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4d577352f3e6..18f8e4066e20 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3615,8 +3615,10 @@ __printf(2, 3)
>  int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt=
, ...);
>  int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog=
 *prog,
>                             enum bpf_stream_id stream_id);
> +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>
>  #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARG=
S__)
> +#define bpf_stream_dump_stack(ss) bpf_stream_stage_dump_stack(&ss)
>
>  #define bpf_stream_stage(ss, prog, stream_id, expr)            \
>         ({                                                     \
> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index c4925f8d275f..370eae669300 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>
>  #include <linux/bpf.h>
> +#include <linux/filter.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/percpu.h>
>  #include <linux/refcount.h>
> @@ -476,3 +477,46 @@ int bpf_stream_stage_commit(struct bpf_stream_stage =
*ss, struct bpf_prog *prog,
>         llist_add_batch(head, tail, &stream->log);
>         return 0;
>  }
> +
> +struct dump_stack_ctx {
> +       struct bpf_stream_stage *ss;
> +       int err;
> +};
> +
> +static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> +{
> +       struct dump_stack_ctx *ctxp =3D cookie;
> +       const char *file =3D "", *line =3D "";
> +       struct bpf_prog *prog;
> +       int num, ret;
> +
> +       rcu_read_lock();
> +       prog =3D bpf_prog_ksym_find(ip);
> +       rcu_read_unlock();
> +       if (prog) {
> +               ret =3D bpf_prog_get_file_line(prog, ip, &file, &line, &n=
um);
> +               if (ret < 0)
> +                       goto end;

I assume that this is by design that if we cannot resolve the IP to a
source line
we just dump the IP and continue the stack walk.

> +               ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n  %=
s @ %s:%d\n",
> +                                                   (void *)ip, line, fil=
e, num);
> +               return !ctxp->err;
> +       }
> +end:
> +       ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)=
ip);
> +       return !ctxp->err;
> +}
> +
> +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
> +{
> +       struct dump_stack_ctx ctx =3D { .ss =3D ss };
> +       int ret;
> +
> +       ret =3D bpf_stream_stage_printk(ss, "CPU: %d UID: %d PID: %d Comm=
: %s\n",
> +                                     raw_smp_processor_id(), __kuid_val(=
current_real_cred()->euid),
> +                                     current->pid, current->comm);
> +       ret =3D ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
> +       if (!ret)

Nit: Can we flip this and just do
    if (ret)
        return ret;
? I get using ?: for brevity but it makes the code less obvious, and
this specific check
isn't even shorter than the more straightforward alternative.

> +               arch_bpf_stack_walk(dump_stack_cb, &ctx);
> +       ret =3D ret ?: ctx.err;
> +       return ret ?: bpf_stream_stage_printk(ss, "\n");
> +}
> --
> 2.47.1
>

