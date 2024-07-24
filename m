Return-Path: <bpf+bounces-35580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BED93B96E
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB711C229E0
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1E140397;
	Wed, 24 Jul 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+XAqpai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342854A39;
	Wed, 24 Jul 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721863396; cv=none; b=LT520MghZeP39uDNYHdVZyCBRgoh6x894LrybkCh/mWWzbOw/x1cd/yHA4bnnSmQ0voiis7DLpL+pjbVAy6IA18mFJgoYD9wgGE7qOWH+Ni3p1pHENBQfkxkF8+JuJ0fz7HEc9xghE0TZ1wsDwz9WQEPm8W2n1BdzPK9GwX1PFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721863396; c=relaxed/simple;
	bh=EqtI0KKOgHHFpicPc8PMfZkzc7l/YjmEsmudDUHw6GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jjy4SL5g+O4naCAJiSEaZy1YcEL1aK2AiQ88tWIGzm7Qv0FYQvTZcKlg+x+UXUKvNPO2uqMMYLmHOZ2AVTIEEWitiS2B5wGvyG3XiWcGpJNP/Wp2F50ewYiftufmNYRbE4B/VVIwpbv5YPbVg/0KsPTRj6AqbpwKxZnKOAAq/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+XAqpai; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so2245935e9.3;
        Wed, 24 Jul 2024 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721863393; x=1722468193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zR8iZrfFQm3OVQt080+A5v61apE5wMX8nOfX8DFlXk=;
        b=c+XAqpaipX9fMRFRXdHA/N+q9dXqHrcU2KUcVNeRDkHR3CkLtHxUzeb/0Yz0vp7fVV
         xN6mEkmS7M21eQaUbMSvVS5pYvRx7x3hyg35tv2sEv1LA1EJVmly4VFSE+GsdD36vjyp
         fGAekBZpfXM0Oe1SvmrVOtAJ66SRo45MJpBRFjy9/6RojW1gbJsNBLD7bv9MLfMsR/c2
         NMtZXthDjwSvgmT6mTgo4P3v0IoEtlqfl/7Spnt3CFy4VglPvGK0PukQzcruBwn1E7QX
         N8BgpgOgXjT6AoV/jZ8qHPvaU3+KCV3Xgc7BrPZVKP0DW6paIYp1iokZxcqB6HODg6xl
         nfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721863393; x=1722468193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zR8iZrfFQm3OVQt080+A5v61apE5wMX8nOfX8DFlXk=;
        b=W7UE3Ki2/dL64iaJFrzRJB/LwtpZvaxVSGLQFv+/gxX6B1i7Q2387tCsAys5CupyPt
         clW/dY3beQckEaU+ohvepNUITaW/O7QwRHRFlOhCvItHcuU4Gr4M+8K+wZxJKpPDVZfw
         slOrSwjgz8V5PP9gLG/fq4r4e4XGbYU/x9CscCLj8D0J2YIOyr7Ezmf8VdfjF60lo1xy
         M7tqA+TRBB0BqdP6Dy53CI/8EHQmpbcfLRS+4MkTuwpU867rej1isenxn+rrQn20P3Bf
         ajIdxE24+q6GG2LhKPqXqYRQdg5drbkW+/CZVcG7rvLa7p9yA9V6GUq8jBsvUW5uvhuL
         tFbw==
X-Forwarded-Encrypted: i=1; AJvYcCUEGYwCSSvi6H3KDQuR6r3Mnm0qoEuS6jAfR0BATObQsLFLWr8nytn+l3p03QLOMQDGCTx4s4uKDYSpZa7tY+7NpuR+mf5auBKwjkdBUA1cb3Qt0ntgPIVsWFSR0QVy+fbRba6qxvZRjqzuhJLwTNXozvQ88B/1wJ84LJ/pv3EAOFybiDU6
X-Gm-Message-State: AOJu0YxWbDpsb/YgVtBSROWOBxx/hpwjOE9QrNUpmVz9CockF+kcSXUA
	WG+3hCz4xrzaWUw4uqVqLCy2iGQOjq2wEZsJM2bpaJfA/eAYJWvowVrD8EjSnyn3zCP+ATzBnw7
	U3tGlO91rKWc7W02oU1wqKjxpSCQ=
X-Google-Smtp-Source: AGHT+IFVDnjqgNt5f6Hn+I6swhoyJpilIY2WCelZW1oW4KuQFCwlPNGLjQrZqEfH14F8C/9ope1K1qDdliKBYaGjtYs=
X-Received: by 2002:a05:600c:1c99:b0:426:5440:854a with SMTP id
 5b1f17b1804b1-42805503f76mr3011395e9.1.1721863393226; Wed, 24 Jul 2024
 16:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724113944.75977-1-puranjay@kernel.org>
In-Reply-To: <20240724113944.75977-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jul 2024 16:23:02 -0700
Message-ID: <CAADnVQKXY5E11gpng=0P_YFLJZh+nmiJDLOrtv2hftvxinukFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: implement bpf_send_signal_pid/tgid() helpers
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 4:40=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Implement bpf_send_signal_pid and bpf_send_signal_tgid helpers which are
> similar to bpf_send_signal_thread and bpf_send_signal helpers
> respectively but can be used to send signals to other threads and
> processes.

Thanks for working on this!
But it needs more homework.

>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -6006,6 +6041,8 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(send_signal_pid, 212, ##ctx)         \
> +       FN(send_signal_tgid, 213, ##ctx)                \

We stopped adding helpers long ago.
They need to be kfuncs.

>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cd098846e251..f1e58122600d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -839,21 +839,30 @@ static void do_bpf_send_signal(struct irq_work *ent=
ry)
>         put_task_struct(work->task);
>  }
>
> -static int bpf_send_signal_common(u32 sig, enum pid_type type)
> +static int bpf_send_signal_common(u32 sig, enum pid_type type, u32 pid)
>  {
>         struct send_signal_irq_work *work =3D NULL;
> +       struct task_struct *tsk;
> +
> +       if (pid) {
> +               tsk =3D find_task_by_vpid(pid);

by vpid ?

tracing bpf prog will have "random" current and "random" pidns.

Should it be find_get_task vs find_task too ?

Should kfunc take 'task' parameter instead
received from bpf_task_from_pid() ?

two kfuncs for pid/tgid is overkill. Combine into one?

> +               if (!tsk)
> +                       return -ESRCH;
> +       } else {
> +               tsk =3D current;
> +       }

pw-bot: cr

