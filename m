Return-Path: <bpf+bounces-48750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70BA103E9
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DBD3A751C
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931E22DC4E;
	Tue, 14 Jan 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WZJqxt8Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FF1ADC75
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849991; cv=none; b=nhzn7opKg9zRmmJxvm9GnxJ3FL2VZe7QPdAh0ISfGXE6Kqrnr5c6UEWd1YC3e0oYi1C/x/3HtJ1otOU1JgLFL70hJpnp5i9wTsyDUmazkvYVkWTuCNBTtq1U0Y4D5gtrDlDc9DhC8no2MOKEh+PHO1cYf07OqdySrnt22Vcru0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849991; c=relaxed/simple;
	bh=1uGXmGjr3htYpAnKO5sjfFfDadBREUl9GryHb7y+/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7tiGj0lwyMUUua7FKu12vQf/JWvooleHmHq/BPEC1NEVS2j27fRaWRI8meAxmfoRen4JYqicCL59sx+oKqzm3nkB9Bx0jgTHT5u1suafbOBanIQ6113rbHaBRs38rAQI7B4suigKowCymcOpDeCteXW6BpTxii5zfiEwrL80l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WZJqxt8Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso37622195e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736849988; x=1737454788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tB/usraW3aLzA/dJfBvuFHhYSG+4wtC1f6I53Y/5/OE=;
        b=WZJqxt8Z5jBf/amoblSGLviEF6PG+HH29GR9PAqULz+lri5iyanGBcCAoFgPuHplp/
         O+HMKlxy1+tKxyKoyGeqZcMOD+Pdh/zaHYOn1lmA1p6BvoEw76WDSSoDeP0r8RiMyk5C
         mxN+Emnes4uA23ihht9dNlmrZhhhlXSP8gjsBCgU+pPt3ep45RHnCt0/iJbBV0HTmqmM
         Or+z7x7kKb2qBlRNgwtVl+xjk2tLseZxinI2pPl3/Jeo0gz1x289axvJAGqbMcOZBfWz
         Et0UBs7cfDvFYVsLNAMFVi9PhkkK9ozPEh5wf0HW9EFpv0RLXNd4WTSDkacYFEychRYY
         iAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849988; x=1737454788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tB/usraW3aLzA/dJfBvuFHhYSG+4wtC1f6I53Y/5/OE=;
        b=b0YtJULUSilZu4kHjH/sXvLsxtDpwdQmiuEzEsFne3dGSv3X+I7DSRV3vCl9acIZsi
         jbFiQz5KU+QnCUEk2/+LqWfu2lv4C0yPMdU0QDeCtf5AkkdY+zfR+OQWFXMwXRRQ5oeA
         BGhEhYMh0uvZ7MK7HZr+w7MbY/YFBSGyojtH61SiO7/NvJCjWBHU3IHGkUmHIxeRgYr5
         0senF5NtEg/T+UgZVD7adGTI9s4B7oYOpT6RRn5FAGeOo4j9TOBT3F9eTZ/u/PaD4aKg
         LInfR/aF0VuvBe1MqspmrurH4putdedsMooz0uxj1aFh4ZtMs+2vD+zlWqBA+mEeBgFr
         p0FA==
X-Forwarded-Encrypted: i=1; AJvYcCXz8g6UkIko5gBgUtw7OXb+Ln1Oklw0s7iKN//kU9YSp8cTaTBuc9o2YTgk755aTzqcIh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlnDaU784pDfy9hKHjHTCczg8G2NsRit3QGwanE3a6fhqUBVn
	IQz7s6kpY7Hx6pxbVkonHlIvVb4u2QGoV2JnvydO7KnZZXEp7N0+j+oEtE2ryzM=
X-Gm-Gg: ASbGncvvFJu5WRFJBg9aaoevO7PdiOdVdGnWHgX31m+xUk1fRDwiX7O+/ybTt2qMthA
	X0CtZWKLwySFX0NQCUGrJWSZ/N5vVzJegs/u6PoIYiuinGTWCs/YaRxb6CzX7JmJCHMhAp+wonQ
	nPjwEBZhVTe7UvhkXQpJJzZTg32bvuIi2ZdbmsSlfj3ueTpagXuS4qjNpfoEdBT1Zr28qsFWgNU
	Tl/iYbAkTW9uSEQANI4blIaGeAJSYjvhmccd8TZCUD+co9x9SqhTjqjb1ZWLCjnEEbXgQ==
X-Google-Smtp-Source: AGHT+IGR9UOorxAsKZth07cxIyIlF4h8K72Pj5ZJAF/utsrHeLSxjHnrWRBncq6e5M5FRKkcXXuViA==
X-Received: by 2002:a05:600c:3514:b0:434:a367:2bd9 with SMTP id 5b1f17b1804b1-436e26a607fmr245809195e9.14.1736849987813;
        Tue, 14 Jan 2025 02:19:47 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc5csm171642105e9.2.2025.01.14.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:19:47 -0800 (PST)
Date: Tue, 14 Jan 2025 11:19:41 +0100
From: Michal Hocko <mhocko@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	vbabka@suse.cz, bigeasy@linutronix.de, rostedt@goodmis.org,
	houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
	willy@infradead.org, tglx@linutronix.de, jannh@google.com,
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <Z4Y6PS3Nj8EMt9Mx@tiehlicka>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com>
 <20250114095355.GM5388@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114095355.GM5388@noisy.programming.kicks-ass.net>

On Tue 14-01-25 10:53:55, Peter Zijlstra wrote:
> On Mon, Jan 13, 2025 at 06:19:17PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > Tracing BPF programs execute from tracepoints and kprobes where
> > running context is unknown, but they need to request additional
> > memory.
> 
> > The prior workarounds were using pre-allocated memory and
> > BPF specific freelists to satisfy such allocation requests.
> > Instead, introduce gfpflags_allow_spinning() condition that signals
> > to the allocator that running context is unknown.
> > Then rely on percpu free list of pages to allocate a page.
> > The rmqueue_pcplist() should be able to pop the page from.
> > If it fails (due to IRQ re-entrancy or list being empty) then
> > try_alloc_pages() attempts to spin_trylock zone->lock
> > and refill percpu freelist as normal.
> 
> > BPF program may execute with IRQs disabled and zone->lock is
> > sleeping in RT, so trylock is the only option. 
> 
> how is spin_trylock() from IRQ context not utterly broken in RT?

+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
+		return NULL;

Deals with that, right?

-- 
Michal Hocko
SUSE Labs

