Return-Path: <bpf+bounces-46500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90D9EB1CF
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40C71889AC3
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317F61A3BC0;
	Tue, 10 Dec 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="fg6uaHki"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A671A0B15
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837133; cv=none; b=Ayvk4luSzuJKgYFXvOaeqHSQx34qqmo5uFrO/vHvjckDeHuXxsvl9jIboSaBZSt14XCIP+0qWxEaKXdZucY2n1K26TqdQJ1ErHr0HdAR2vnjAPNMtg45pGlCt9unmAQ276rmu2MgptC598HEw3BshkkNTpuIj6YlBfldxP5e42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837133; c=relaxed/simple;
	bh=2F+U3KpCyFGgxMTffy5RfIns90C/geYxyDAnYBYncrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN4c+JhaiQVJwDfBBXRawQ1mNhpEDNQLU8rUGfXIFOwCLamEOsPng+EQwTXR7fAUtWuk/uJ7ctLfsIuinApqpMSuA06L5KUFQNYf9gPaRecAZ2dcrLfBBN475A867SdYBKvpEnKVxPU+RGsneP9tUMr02MP7gSxNzMjDLKO64HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=fg6uaHki; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21654fdd5daso18919475ad.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 05:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1733837131; x=1734441931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kove9NVUba4GYCR0rE2iJen7tVwV979R+DkeBgZ2aGM=;
        b=fg6uaHkiu32DqqREv6RAxx6ivRvx3Gcm7o2uqTvZkRBSr4PaaR7b2zEuHX8NlxVxMk
         krmEyylrN3/1biHJ4N9uRxZTWNuBYDycabE4+wUGOH6ZWNwjDeb+ikhadhohlOosbzdi
         PquqNjOWgfckcmP708kwclBSPha0ex2Ktstrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837131; x=1734441931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kove9NVUba4GYCR0rE2iJen7tVwV979R+DkeBgZ2aGM=;
        b=JxE7ypP6eJsAb6uGYBBb71v77u1mpCksZDlY0vtYHsZPMUjTzHpTVK957REtRVnqKN
         060lSG63azgyGmQR26YJYi4OARzzV0LiFWcEYLtiM9Gj4YkxZv5VUYnMwE1ywxV+afbu
         nNXGNjzgFNJMgwVTwfBlM4Ky/Wk3zXfp/I1C0N8iWmJzaWt/1ErAwj5BxvF8Cf2ZJDeH
         gG2b+oXI4dkFGaTI8o69JtRGdzVUN8pydF7//h9gR9zRd2xNcl/SjJVGnRQSZKVuA0R9
         zqhpw5EzqkU55IqgfWPc+PUawCZmV8fUwrm1UdmGLTvA41g2C9LWe2cyVZ6wbZu2aVRt
         ih2g==
X-Gm-Message-State: AOJu0YxboaC24Rxo3781V2QlLOry1b5hBek6HKLNCtzxNtQVzlafPXi6
	fmGFz8JIYykEuyXP0US7N+e647nOpqXU8/1+7dPuTZknt6613/6XYi5LQBOAkq7wrYLA9SeTgPd
	OPgYQiVeoGXj6tkS31eMDA19p7vBvAbOpLzlqfQ==
X-Gm-Gg: ASbGncvIrsiJudsksamNxPKPnEVSNGTC6vmLTr28fFui08X4GJwzYU7IqzlciSDaXOG
	vS3vW02Uy8PrWI6XEZh0Z4mCyNaFMoSSsLgo=
X-Google-Smtp-Source: AGHT+IGpZ8mHzT2GGNEe7mVvvtk6LLpWmQvnbjp5Gjr9QW3DMXVcLQ/aNBYeS3yHYJu1u2zlG7LR2+iV6UQ+8Fo6rQE=
X-Received: by 2002:a17:903:2305:b0:216:3eaf:3781 with SMTP id
 d9443c01a7336-2163eaf3fa4mr143114235ad.43.1733837131224; Tue, 10 Dec 2024
 05:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
In-Reply-To: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
From: Usama Saqib <usama.saqib@datadoghq.com>
Date: Tue, 10 Dec 2024 14:25:20 +0100
Message-ID: <CAOzX8iyS6ODErbnkyZO7RyVfXBCL5CFX5ydoKcvzc9LZf425Vw@mail.gmail.com>
Subject: Re: BPF and lazy preemption.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, bigeasy@linutronix.de, peterz@infradead.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Adding x86 / scheduler folks to Cc given PREEMPT_LAZY as-is would cause
  serious regressions for us. ]

On 11/18/24 10:14 AM, Usama Saqib wrote:
> Hello,
>
> I hope everyone is doing well. It seems that work has started to
> introduce a new preemption model in the linux kernel PREEMPT_LAZY [1].
> According to the mailing list, the maintainers intend for this to
> replace PREEMPT_NONE and PREEMPT_VOLUTARY as the default preemption
> model.
>
>  From the changeset, it looks like PREEMPT_LAZY allows
> irqentry_exit_cond_resched() to get called on IRQ exit. This change,
> similar to PREEMPT_FULL, can get two bpf programs attached to a kprobe
> or tracepoint running in user context, to nest. This currently causes
> the nesting program to miss. I have been able to get these misses to
> happen on top of this new patch.
>
> This behavior is currently not possible with the default preemption
> model used in most distributions, PREEMPT_VOLUNTARY. For many products
> using BPF for tracing/security, this would constitute a regression in
> terms of reliability.
>
> My question is whether there is any ongoing work to fix this behavior
> of kprobes and tracepoints, so they do not miss on nesting. I have
> previously been told that there is ongoing work related to
> bpf-specific spinlocks to resolve this problem [2]. Will that be
> available by the time this is merged into the mainline, and the
> current defaults deprecated?
>
> Thanks,
> Usama Saqib.
>
> 1. https://lwn.net/ml/all/20241007074609.447006177@infradead.org/
> 2. https://lore.kernel.org/bpf/CAOzX8ixsxPbw1ke=3DDsDd_b38k1TE+JRG3LvJfh4=
wD60mhHvAqA@mail.gmail.com/T/#m206e33e5a0a0d9d3d498480a53aa9c87c81d91ff

On Mon, Nov 18, 2024 at 10:14=E2=80=AFAM Usama Saqib <usama.saqib@datadoghq=
.com> wrote:
>
> Hello,
>
> I hope everyone is doing well. It seems that work has started to
> introduce a new preemption model in the linux kernel PREEMPT_LAZY [1].
> According to the mailing list, the maintainers intend for this to
> replace PREEMPT_NONE and PREEMPT_VOLUTARY as the default preemption
> model.
>
> From the changeset, it looks like PREEMPT_LAZY allows
> irqentry_exit_cond_resched() to get called on IRQ exit. This change,
> similar to PREEMPT_FULL, can get two bpf programs attached to a kprobe
> or tracepoint running in user context, to nest. This currently causes
> the nesting program to miss. I have been able to get these misses to
> happen on top of this new patch.
>
> This behavior is currently not possible with the default preemption
> model used in most distributions, PREEMPT_VOLUNTARY. For many products
> using BPF for tracing/security, this would constitute a regression in
> terms of reliability.
>
> My question is whether there is any ongoing work to fix this behavior
> of kprobes and tracepoints, so they do not miss on nesting. I have
> previously been told that there is ongoing work related to
> bpf-specific spinlocks to resolve this problem [2]. Will that be
> available by the time this is merged into the mainline, and the
> current defaults deprecated?
>
> Thanks,
> Usama Saqib.
>
> 1. https://lwn.net/ml/all/20241007074609.447006177@infradead.org/
> 2. https://lore.kernel.org/bpf/CAOzX8ixsxPbw1ke=3DDsDd_b38k1TE+JRG3LvJfh4=
wD60mhHvAqA@mail.gmail.com/T/#m206e33e5a0a0d9d3d498480a53aa9c87c81d91ff

