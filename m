Return-Path: <bpf+bounces-45028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2B9D0100
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11952283D03
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B0199947;
	Sat, 16 Nov 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5KG11Y2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639615E97
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731792872; cv=none; b=kxFUJRgjRLeYFAEFRSVAaWgjxpYnqUHKtXVpjcpFPtE4I6SyQZB+krX9em6YhNQWSw+jTwhDkY9njX0azFvFwMRsTkmbGG4b8ewJMiRKZ0jmhZCuQJqPpYppJnbChLRh++5YTuFuJplqGkHHOazdDzahXBeKVxVqk7t7hx/TPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731792872; c=relaxed/simple;
	bh=89l7MmRZjky9zXNjO1qbXIvIK+kIfwH6edprS/AfR/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgys/yIcTW+ZvYnwzT3+EB5rrFP4R5wQjbuzNUovHAAhgeybEG0Yfzjs97DNeA0bSp7EjnNVHzZ+lO6VTXBIsUbl9vmUCAPo4qAHYUjRhQxrhS3Ta9gc8/y5uTycIYNwdP0OG2Ia0CZCdD0nIofZ4X/pQQUOmlh8zsqxgyZIFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5KG11Y2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38232c6311fso687221f8f.3
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 13:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731792869; x=1732397669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSikF8kTZVqo0PltnA0NXuXcsMGyeUDdT1Gn0MQ2piI=;
        b=C5KG11Y2gMJdQ4uC3ZYNDnyriZiKqsZ+g2mrVn60w7ug5R2QjNpbAggFAIZmLSNNbe
         r0gTBuA/37gOsMnBbK4YgCtuGvPX5FwD3m0L+fV8KWW9DfJqKW26Ajy8mxCR74XwMQDi
         h1T9q47bpE2Jpx8E//1HmHbe5w1bgH2zLqdErn7kHvG9Ow+w9amdE4/2c/S+NY9OnWse
         Bcb47q+he0T5AniarkfzFKwJHwq7NlA/hff81gHsbYYYKP53Afx5fJgTP4rZSQv631D4
         7mkLuegddaLEkeHcufFwGtOiZ4pOoPp5peAZl1e6yM73TI5pPtG/it/iYGvBvRsM5QOH
         J3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731792869; x=1732397669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSikF8kTZVqo0PltnA0NXuXcsMGyeUDdT1Gn0MQ2piI=;
        b=sXjKH5BJ1K6E1OGFPSOr58bJxe4LUBZT7oo3chAkFqIMINbUS1lglV3aw3ehvtG8vD
         8MDaZdlTPZ14PNToOGbm+YJKJKCiX3zpkKOJe8JxE/1AzYyIX7pWx0Nwv3UKv4zoj4M+
         31yxMhVd/jC/prXPfvkS+Qq2U7OMFTqNyb+mqapabGXCE6U9PtwUXU5SAC32sRtxrVLL
         rihwotK2eSNkFy56N5JctUVHo+RtFbAaE3V0GB/xaTqZlYCIMO/ctM+cgf2z9jtmah5E
         8pJ04mRiVa1nMVz3u1FWaR/Jt/+nuMT8luqljcby4z6D7+52ZFkMLvGrIMtTWH5TQIeD
         1+cQ==
X-Gm-Message-State: AOJu0YyNlELd5biYwo5gUOWNqFT+nLmTOOQ6dYIEA3hTs2pl2jt7H7m7
	4TdnAkn1NcGJJyrZTxrt0WrRvFgCZZUlmHujIJl3rlBrgdFoTSaR0INW/B7JsOnQtRqDjVQ8j7j
	pKucAfsYmgizt+4gZJGoZvEin5TI=
X-Google-Smtp-Source: AGHT+IG+Ts2IjAlnFRPHX8erR0J0YZ7QA9fpp+4BGLy4zsOCrGUeX9sVxLRA+HVK+6DyZDigTZFTkPw50Z9r+OEMBg8=
X-Received: by 2002:a05:6000:1f88:b0:37c:d276:f04 with SMTP id
 ffacd0b85a97d-38225a915fbmr5125413f8f.45.1731792868949; Sat, 16 Nov 2024
 13:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
 <20241116194202.GR22801@noisy.programming.kicks-ass.net> <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>
In-Reply-To: <CAADnVQLOyY=Jvibq-hnv6dpXy+hAJFWojyHh7wuEiMn-itMvaw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 13:34:17 -0800
Message-ID: <CAADnVQLA9CkUtcEyjvrTCPZfMWdDXGRzr1O-GD58XM6xjfLTJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 16, 2024 at 11:42=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> >
> > On Fri, Nov 15, 2024 at 05:48:53PM -0800, Alexei Starovoitov wrote:
> > > +static inline struct page *try_alloc_page_noprof(int nid)
> > > +{
> > > +     /* If spin_locks are not held and interrupts are enabled, use n=
ormal path. */
> > > +     if (preemptible())
> > > +             return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_=
ZERO, 0);
> >
> > This isn't right for PREEMPT_RT, spinlock_t will be preemptible, but yo=
u
> > very much do not want regular allocation calls while inside the
> > allocator itself for example.
>
> I'm aware that spinlocks are preemptible in RT.
> Here is my understanding of why the above is correct...
> - preemptible() means that IRQs are not disabled and preempt_count =3D=3D=
 0.
>
> - All page alloc operations are protected either by
> pcp_spin_trylock() or by spin_lock_irqsave(&zone->lock, flags)
> or both together.
>
> - In non-RT spin_lock_irqsave disables IRQs, so preemptible()
> check guarantees that we're not holding zone->lock.
> The page alloc logic can hold pcp lock when try_alloc_page() is called,
> but it's always using pcp_trylock, so it's still ok to call it
> with GFP_NOWAIT. pcp trylock will fail and zone->lock will proceed
> to acquire zone->lock.
>
> - In RT spin_lock_irqsave doesn't disable IRQs despite its name.
> It calls rt_spin_lock() which calls rcu_read_lock()
> which increments preempt_count.

The maze of ifdef-s beat me :(
It doesn't increment in PREEMPT_RCU.
Need an additional check then. hmm.

