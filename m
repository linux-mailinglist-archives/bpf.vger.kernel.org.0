Return-Path: <bpf+bounces-27854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66D8B2974
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 22:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87B6283155
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53561152E13;
	Thu, 25 Apr 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSYjDI4I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DA21101;
	Thu, 25 Apr 2024 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075787; cv=none; b=bnejczjfLaC/BmXXegNiW2sV+PRlNeexE+uB+cnSDz85I9QpoceWt1FBlJMmQW+A6CC0/K2CgNKFzIq3yzo6FAgM9fuVvKzMDu3zbOXM5Jl/IXg1rmNt69HHzpjnlQCz+dc0y1sCitW1hwKT3A+UH7gS+gmxpGF2so4MvYjXpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075787; c=relaxed/simple;
	bh=xPLDSjTkA2X2khRH8zUFP+319KpCzP+c/rPSDRVa9sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uivo4djb3P7Y6KEFB5zfg0mnXMoFjECSlGO0Xfr7ok+li0VylZT6/xfHr5ejZMyk7mtpB3+ZpdAGPbvR/GzQ5Xg24EqWVkEq1Y4UQv+7c6Y5aCl5Jl9hXcfqy/JooFPF0/1A/WgcTJTIvCE1NdKifIv4N01sEW5lvX/Kx5acb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSYjDI4I; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ac1674d890so1283556a91.3;
        Thu, 25 Apr 2024 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714075786; x=1714680586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrZK6ml6rEEwBTrQjJ1G9DmN6BYGfMleWCxQeuJAdjk=;
        b=ZSYjDI4IE6m5+CtzHV+hOLd440FjS4HhuSAeKrKbJe1isDhuAuT1LAmAYaLeXmHsBr
         Iaj+z+jAXAgMPoy5acg0RxxSEGrvqH25+8YNZoK4Lpo910UkLJ1K8tdRoXxl6SUUkJdV
         8JeewVS4DmK6CtBSsImNQp3+t8nPCFdXEnBd8liv2jfVx9o87/o4RyK7HxubIWJYLOUI
         31ynJ6ui8Br2iPyt0Hg/Mu4XlguXR6H6ZC21uR33cVP1pILvvaGNJa79T6kk+PTgn8Py
         /3b4mms1q+wP9S4FN01UZpyhUibmsWg/QH4gEewMLyaV2FL46AcJAqb3DAHjqkaAromV
         gXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075786; x=1714680586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrZK6ml6rEEwBTrQjJ1G9DmN6BYGfMleWCxQeuJAdjk=;
        b=uTmJYxBZ5q3khiLI4WT2ZSXcQBDKQQ9aHKfQjxOiol3EM7aWtyJ8ne2AZekZ9Ehb7n
         1pM03zPJ78nWSTZ9vwr2GWbtxzWJNOtvkp2mmq1VIuerRm2H+2Fr8LolrqW6NBkvZWag
         SrT0bWYvVtf3sY7seickf0mJxEBgj7pkejvYecRoisGYIi3JBoPpOp3OmKV/HjsbFYt8
         T+qsV4UVE6iS8JD8o8O/Mfn2i5goXm6OZ2YVZ+XWLAUE5/C43l/z/IYPYlbHuyfINf67
         fZWg0kdHMnktdHe3VtBgxcbzPbsf+kIBeyOD+iS9pXWS0tX9vmClnhS5cuaQNBubSn05
         nCvA==
X-Forwarded-Encrypted: i=1; AJvYcCVFrOq6VHneE/8lZhjNd6RwduUtFvaZ0+49PXurGy88Tj4L85LxupysFhdFFMgih793bciPg9n5/o+yCX3jwZiUSLQfgaaTUoCEFTH6JUcWW4aUNGhNFDnLjIV3a6hx6NL+2Dxm5rZj36JtaXkTU/Xqgn6qc4I+7rdiex1GY7XThnu+x2RR
X-Gm-Message-State: AOJu0Yy5UCpqweaLAM4UVHwFPIc0yL9HgEMHkgsYXTtSMRbLuWGfHCV3
	nNQfpRtUeiNlPtLACFOzKH0o+gNBpphQuSw9VXb1AiwlPfeWtjWOzx5z/yWKws4QdusuzCY1BtU
	ANzfRwtWmGekuqINGZStqTOz3lpU=
X-Google-Smtp-Source: AGHT+IE3OQFaRFBXI+TTmzwcYdZjuFxXeDuWKrteCad+6nEZ37NhTIA62QLGaQV3Q8yq0/XWoJi4RNSi4LHW6O7YggM=
X-Received: by 2002:a17:90b:1208:b0:2a0:9b18:daf with SMTP id
 gl8-20020a17090b120800b002a09b180dafmr647610pjb.42.1714075784821; Thu, 25 Apr
 2024 13:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2> <171318568081.254850.16193015880509111721.stgit@devnote2>
In-Reply-To: <171318568081.254850.16193015880509111721.stgit@devnote2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 13:09:32 -0700
Message-ID: <CAEf4BzZ2cZ-jJDj3Qdc4T_9FmCK21Ae-mr-d2RJRMtdUK8HOjQ@mail.gmail.com>
Subject: Re: [PATCH v9 29/36] bpf: Enable kprobe_multi feature if
 CONFIG_FPROBE is enabled
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:22=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> may always returns 0. But it should be enough for function entry (access
> arguments) and exit (access return value).
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Florent Revest <revest@chromium.org>
> ---
>  Changes from previous series: NOTHING, Update against the new series.
> ---
>  kernel/trace/bpf_trace.c |   22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e51a6ef87167..57b1174030c9 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2577,7 +2577,7 @@ static int __init bpf_event_init(void)
>  fs_initcall(bpf_event_init);
>  #endif /* CONFIG_MODULES */
>
> -#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> +#ifdef CONFIG_FPROBE
>  struct bpf_kprobe_multi_link {
>         struct bpf_link link;
>         struct fprobe fp;
> @@ -2600,6 +2600,8 @@ struct user_syms {
>         char *buf;
>  };
>
> +static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);

this is a waste if CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=3Dy, right?
Can we guard it?


> +
>  static int copy_user_syms(struct user_syms *us, unsigned long __user *us=
yms, u32 cnt)
>  {
>         unsigned long __user usymbol;
> @@ -2792,13 +2794,14 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_r=
un_ctx *ctx)
>
>  static int
>  kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> -                          unsigned long entry_ip, struct pt_regs *regs)
> +                          unsigned long entry_ip, struct ftrace_regs *fr=
egs)
>  {
>         struct bpf_kprobe_multi_run_ctx run_ctx =3D {
>                 .link =3D link,
>                 .entry_ip =3D entry_ip,
>         };
>         struct bpf_run_ctx *old_run_ctx;
> +       struct pt_regs *regs;
>         int err;
>
>         if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1)) {
> @@ -2809,6 +2812,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_=
link *link,
>
>         migrate_disable();
>         rcu_read_lock();
> +       regs =3D ftrace_partial_regs(fregs, this_cpu_ptr(&bpf_kprobe_mult=
i_pt_regs));

and then pass NULL if defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)?


>         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
>         err =3D bpf_prog_run(link->link.prog, regs);
>         bpf_reset_run_ctx(old_run_ctx);
> @@ -2826,13 +2830,9 @@ kprobe_multi_link_handler(struct fprobe *fp, unsig=
ned long fentry_ip,
>                           void *data)
>  {
>         struct bpf_kprobe_multi_link *link;
> -       struct pt_regs *regs =3D ftrace_get_regs(fregs);
> -
> -       if (!regs)
> -               return 0;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
>         return 0;
>  }
>
> @@ -2842,13 +2842,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, =
unsigned long fentry_ip,
>                                void *data)
>  {
>         struct bpf_kprobe_multi_link *link;
> -       struct pt_regs *regs =3D ftrace_get_regs(fregs);
> -
> -       if (!regs)
> -               return;
>
>         link =3D container_of(fp, struct bpf_kprobe_multi_link, fp);
> -       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs);
> +       kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs);
>  }
>
>  static int symbols_cmp_r(const void *a, const void *b, const void *priv)
> @@ -3107,7 +3103,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_at=
tr *attr, struct bpf_prog *pr
>         kvfree(cookies);
>         return err;
>  }
> -#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +#else /* !CONFIG_FPROBE */
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_=
prog *prog)
>  {
>         return -EOPNOTSUPP;
>
>

