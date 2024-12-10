Return-Path: <bpf+bounces-46521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146C29EB3E1
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C97F28448C
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88511ACDE7;
	Tue, 10 Dec 2024 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="H2db/sAI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C51AA786
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842125; cv=none; b=Ljwm+nKEURn5JvIZLHB0M0m/5ApAj9wmaw+fCur1KuiwXbzGdvOyiKCnESTNTwfBNmQwZiyC4+0ILcM0Kb1fkS2uKQ+l4Eiilzk5zAgRp9/E64jBbzZtPB6Tvs0nMdCD2a/2wqS2XpfcyrO3Im6TkuAUziFXp5FvlRDfddvUIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842125; c=relaxed/simple;
	bh=eyagzlzKEMUIVHUT+Qslao0xKnVUeABf/usE1LRuwPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqFOfF9SpCFIl7tBPLIzanG8rhuofqWx+XZLrTzkw5THu3ov7JvTpCgUfV8kmQdnajbd0AxJ7+R1W+7C3qZbEfmpLhFxKN6Q+o7sgwdIK/6IQA7XNpyuaOePrMQPx2v0DFeycqzzR4rlOaMNQQNbIaSSjBtesqDtbfLA282OLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=H2db/sAI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so3447105ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1733842123; x=1734446923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBkCOO0fiYIkMHvPj/3gNOQvzv5Nqvaw29CcZoMM5Kg=;
        b=H2db/sAIHcllcufOeGhhxkUL3d4EIyihbB1iUsvkiDKXkfAt9E9Vljxevk7oO4w3nG
         vrp6xAAAuXy6A2k0ebqifBfFKGByb+2s7UjyrhHg5l8rv10FbZWrTraw8YpaeoASG4YT
         BxKobt/vYEGHYRCv2jmhmJOYjEAbW86G+T3p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842123; x=1734446923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBkCOO0fiYIkMHvPj/3gNOQvzv5Nqvaw29CcZoMM5Kg=;
        b=XGARZrAfChYeLJuJvmgptz+J67I2hYXnFTR56SfTyXXs2FVndIMTWLXSXBe6YhZryy
         zm4QNSNgIUqKxLtKKG+/xtrtGzJyXdm0s5jP/Rvp0fwiwfMcGK8LN1nkYs26tkoDifjI
         U8Xo7RKTVFZlQ5FnuzqYmf79vgcaiOYJDwRwvs1sTzhzFsfYesL3CgGiBwf5uNevNxAM
         eJhzDj/SaU+0LIWarDniGW0PbGTHwKT+dtzNg2LjXB1bsIAu8T+6PvcekYVj6lBm/HQJ
         VSwJQsspcCHGIxG2n55dfYPUvWV2Cd9+fSAF0iEke6y7CcA0ovunnAbChiXIGHre+e1S
         IPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7zgiKadm1LHFOZUv3yT0HT0zh3tWCVqhby93frecA039Blgx5ALmfQCbZPBN4q0vBy8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fPP5HtRIerj1/kuHhy69QqIV6GCQYm8SeuWkUi79cVlysFzu
	FJPlPlPYWIBMmZfCie1dEpfnQ0cs+0qcZxTA8aCL5QIFL4WG7oUb4WKEJBdpU1N9WIf0EuGIGUA
	3TFEJfVjAnJylryX3//Hmu9RLZs/k4q2duMKtvw==
X-Gm-Gg: ASbGncv1HbMY0e4T8ap7xS8gWzHAD+NnqP7YMm7Eq2DkmeTo2ZYHch2GYQa3B0qtiFD
	+kykxzGpdv77ck+KprXCAkrcGCkSExzQ29AU=
X-Google-Smtp-Source: AGHT+IGzn42hpfkfa1+or3/ThJbPXQE9D3kuSAxfNj1vjKXla97qHcJJ3vkBTGM2cb/3ZDMT/PhWuq8S+RJ8i5qroZs=
X-Received: by 2002:a17:902:ccc1:b0:216:4e8d:4803 with SMTP id
 d9443c01a7336-2166a03c862mr64659195ad.42.1733842122998; Tue, 10 Dec 2024
 06:48:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
 <CAOzX8iyS6ODErbnkyZO7RyVfXBCL5CFX5ydoKcvzc9LZf425Vw@mail.gmail.com> <20241210141413.GT35539@noisy.programming.kicks-ass.net>
In-Reply-To: <20241210141413.GT35539@noisy.programming.kicks-ass.net>
From: Usama Saqib <usama.saqib@datadoghq.com>
Date: Tue, 10 Dec 2024 15:48:32 +0100
Message-ID: <CAOzX8iy=hELHmPAeMxQ3on_6dqJmJryGgvAXRxMOijqr+Jj62w@mail.gmail.com>
Subject: Re: BPF and lazy preemption.
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	bigeasy@linutronix.de, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply. It is correct that the problem I shared is
already present under PREEMPT_FULL, and as such there is no new issue
being introduced by PREEMPT_LAZY.

My main concern is that if PREEMPT_LAZY is intended to become the
default mode (please correct me if I am wrong here) before this
problem is addressed in the BPF subsystem, then this would result in a
big regression for us. This is especially true if distros pick up the
changes in the intervening period. I wanted to draw attention to this
issue so this situation does not happen.





On Tue, Dec 10, 2024 at 3:14=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Dec 10, 2024 at 02:25:20PM +0100, Usama Saqib wrote:
> > [ Adding x86 / scheduler folks to Cc given PREEMPT_LAZY as-is would cau=
se
> >   serious regressions for us. ]
> >
> > On 11/18/24 10:14 AM, Usama Saqib wrote:
> > > Hello,
> > >
> > > I hope everyone is doing well. It seems that work has started to
> > > introduce a new preemption model in the linux kernel PREEMPT_LAZY [1]=
.
> > > According to the mailing list, the maintainers intend for this to
> > > replace PREEMPT_NONE and PREEMPT_VOLUTARY as the default preemption
> > > model.
> > >
> > >  From the changeset, it looks like PREEMPT_LAZY allows
> > > irqentry_exit_cond_resched() to get called on IRQ exit. This change,
> > > similar to PREEMPT_FULL, can get two bpf programs attached to a kprob=
e
> > > or tracepoint running in user context, to nest. This currently causes
> > > the nesting program to miss. I have been able to get these misses to
> > > happen on top of this new patch.
> > >
> > > This behavior is currently not possible with the default preemption
> > > model used in most distributions, PREEMPT_VOLUNTARY. For many product=
s
> > > using BPF for tracing/security, this would constitute a regression in
> > > terms of reliability.
> > >
> > > My question is whether there is any ongoing work to fix this behavior
> > > of kprobes and tracepoints, so they do not miss on nesting. I have
> > > previously been told that there is ongoing work related to
> > > bpf-specific spinlocks to resolve this problem [2]. Will that be
> > > available by the time this is merged into the mainline, and the
> > > current defaults deprecated?
>
> I have no idea about the whole BPF thing, but if behaviour is as
> PREEMPT_FULL, then there is nothing to fix from a scheduler PoV.
>
> Note that most distros already build with PREEMPT_DYNAMIC, which allows
> users/admins to dynamically select the preemption model (either at boot
> or at runtime through debugfs).
>
> If certain BPF stuff cannot deal with full preemption, then I would have
> to call it broken.

