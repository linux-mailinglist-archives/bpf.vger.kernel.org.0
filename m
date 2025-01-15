Return-Path: <bpf+bounces-48889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE6AA11679
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634EB168FA9
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA235968;
	Wed, 15 Jan 2025 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaaTFx3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BE33DB
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904218; cv=none; b=n0+DAL1FZXF2KTTKiuCkLo4zZufsCpQoJ/SktyIr+Ceio9JGNrr52JxIrI8710jbeG2uj1gBLGFd2zGFoTDRTbU36ab8kYiBrv69hAlLw3nO+VdLzWAsEmRDODhGaHamFFOReBD4/PN+mCvVnL2iiyFw/zpoz3e6z7JsMM4Rnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904218; c=relaxed/simple;
	bh=goFAduwmFiyWr8+CR9Jor6ndozV8zdBYGgWiqzBEtFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqdFo1fmkFOKdImJkkaBX1ml5VeLr55g+Sqtbe+8e7wusDEAMzEK2E7M5De1er+L1PaWUQNVAzYVbfhERNNxJUyJoTgqy3KMgMODkGh5KyuKfeBvYBOKWRQYUDl/8u5IGoXWoyX4E3kTH5kw2zM9iAklZvh5vvB1dCw7R61VeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaaTFx3u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7f19f20so3132999f8f.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 17:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736904215; x=1737509015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok9Gqy2J4Ancn8P8Xi7xjCCSatpnHob/7noj/m8WMWY=;
        b=gaaTFx3u/SdrmLcxh0VOUXcC4WKqnHgJeAWksZWC1BBsmx4p9kg/BBS5vbXWZlaumC
         143OBxqXmMqPQ2fDlW2McP+2Cx9T/2lSYOScQHrCI8n2uJJTCkaXKcj9jvYFU1YATQJZ
         +Q4ImWy3qLDBQCe77+F7/S4x0sffta/nUqHgH8bFy71St6uRRtz9KiDE+S0MiEUkPkkS
         2b8m5St4uUl0/P5HKFZeaF6ASyoeo4bRqn2T6oinCqajhduyMarc2fBHzgUYxLYfJD17
         FCCa+ccwhecFWPJb7CCdw+nJBmLd7JppNjiEDdnwOmu1Rb5vxgTAkbIP7ff4BrYOJQsu
         N0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736904215; x=1737509015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok9Gqy2J4Ancn8P8Xi7xjCCSatpnHob/7noj/m8WMWY=;
        b=ZckzAqg0gmGfR4ZUHny7jZjQxjlfk0PPCyYnRfbPnoyaRZFb1tfvmk9fG/15aPj8+y
         gaV1/Q9A4kocH7bXg/LY/5efeE51RzRTiAwc4eObQPvvqu0V6y7RohKtWec9PjEvS5eY
         6I3vx3QUh3Rml7hQGooguFJR2jePfltzY/fH0pUB1TOblfB1FBlNNhkIWkNIjoXEqSCp
         dZHAk2SLyrw8vEqE5oxhxvCF9EKpPAYHRvUkB+8tJvXb7OVyNrjulADEnV7dWea18EK1
         XjNqe08NBIjQivLFsy1HJxz+sz60eHS3iF0Ai2yk+ICMGOSJj3ngBIJttOr8Z8yIyG2c
         Y8Jw==
X-Gm-Message-State: AOJu0YyWQ5pQR+SXRJSIRuoVcuKqbBveoT6WsND4gUXzO/BLKmjoDYsL
	9pv/DMzARMghJlKI93+Brpj2VZ/CSqSRxEJ0JDDo0NZjPtaqRqq+25HVk9bK7gDpF1MTb8YCZ9p
	BK5GHY4IqpSZO/kGI9I4qFok+ouY=
X-Gm-Gg: ASbGncu4taP4KIT7dhvUlRO2vw9AcqVfYCRQUpO7NdYvN+EXBZ1BHKN8APJUd5glajz
	GSAOgZKEkFx1h6nfzxV4/F20z0qILvrMgfo1fVrT1qHyZgWqwLCu8RA==
X-Google-Smtp-Source: AGHT+IEIDyHLvrsamKlandIWLQYxw5Y7eUDiworWj6iaDrcVK1rtsEXYoTLICDodaE/CCqnQWn3X4dSB28Q44qY0lE4=
X-Received: by 2002:a05:6000:461b:b0:385:f17b:de54 with SMTP id
 ffacd0b85a97d-38a872f9866mr23366450f8f.5.1736904214825; Tue, 14 Jan 2025
 17:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com> <Z4Y9BVygLcRTjhMh@tiehlicka>
In-Reply-To: <Z4Y9BVygLcRTjhMh@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Jan 2025 17:23:20 -0800
X-Gm-Features: AbW1kvYTbRdOozu_LRhOJL0e-n4FXoU9mFOu6DWy4O5wO2B81uhVsJSCtiIQXgc
Message-ID: <CAADnVQKYb+kHwaAzL5c9S8V+Wcnju+ScMbajmMj2wi6E_=Pq-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Michal Hocko <mhocko@suse.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:31=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 13-01-25 18:19:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Tracing BPF programs execute from tracepoints and kprobes where
> > running context is unknown, but they need to request additional
> > memory. The prior workarounds were using pre-allocated memory and
> > BPF specific freelists to satisfy such allocation requests.
> > Instead, introduce gfpflags_allow_spinning() condition that signals
> > to the allocator that running context is unknown.
> > Then rely on percpu free list of pages to allocate a page.
> > The rmqueue_pcplist() should be able to pop the page from.
> > If it fails (due to IRQ re-entrancy or list being empty) then
> > try_alloc_pages() attempts to spin_trylock zone->lock
> > and refill percpu freelist as normal.
> > BPF program may execute with IRQs disabled and zone->lock is
> > sleeping in RT, so trylock is the only option. In theory we can
> > introduce percpu reentrance counter and increment it every time
> > spin_lock_irqsave(&zone->lock, flags) is used, but we cannot rely
> > on it. Even if this cpu is not in page_alloc path the
> > spin_lock_irqsave() is not safe, since BPF prog might be called
> > from tracepoint where preemption is disabled. So trylock only.
> >
> > Note, free_page and memcg are not taught about gfpflags_allow_spinning(=
)
> > condition. The support comes in the next patches.
> >
> > This is a first step towards supporting BPF requirements in SLUB
> > and getting rid of bpf_mem_alloc.
> > That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> LGTM, I am not entirely clear on kmsan_alloc_page part though.

Which part is still confusing?
I hoped the comment below is enough:
   * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
   * is safe in any context. Also zeroing the page is mandatory for
   * BPF use cases.

and once you zoom into:
void kmsan_alloc_page(struct page *page, unsigned int order, gfp_t flags)
{
        bool initialized =3D (flags & __GFP_ZERO) || !kmsan_enabled;
...
        if (initialized) {
                __memset(page_address(shadow), 0, PAGE_SIZE * pages);
                __memset(page_address(origin), 0, PAGE_SIZE * pages);
                return;
        }

So it's safe to call it and it's necessary to call it when KMSAN is on.

This was the easiest code path to analyze from doesnt-take-spinlocks pov.
I feel the comment is enough.

If/when people want to support !__GFP_ZERO case with KMSAN they would
need to make stack_depot_save() behave in
!gfpflags_allow_spinning() condition.

Since __GFP_ZERO is necessary for the BPF use case I left all
the extra work for the future follow ups.

> As long as that part is correct you can add
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Other than that try_alloc_pages_noprof begs some user documentation.
>
> /**
>  * try_alloc_pages_noprof - opportunistic reentrant allocation from any c=
ontext
>  * @nid - node to allocate from
>  * @order - allocation order size
>  *
>  * Allocates pages of a given order from the given node. This is safe to
>  * call from any context (from atomic, NMI but also reentrant
>  * allocator -> tracepoint -> try_alloc_pages_noprof).
>  * Allocation is best effort and to be expected to fail easily so nobody =
should
>  * rely on the succeess. Failures are not reported via warn_alloc().
>  *
>  * Return: allocated page or NULL on failure.
>  */

Nicely worded. Will add.

Thanks for all the reviews. Appreciate it!

