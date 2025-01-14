Return-Path: <bpf+bounces-48756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CBA10481
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8110F1888821
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2AD22DC27;
	Tue, 14 Jan 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XMb6Gn5T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FE22DC20
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851393; cv=none; b=dxL3hWhzcC9s+6jlWQHOK0xfT6aGvII4Omcx6K+7Jx/aAYKUMIJ7yBpu3aPZhgv7RlEdeWXGzeC/5e+Ibn5JyRRuSBiE88JVCzBoB52QkjBQC48qdbmO0KXMQCpnb2ApynKRpvzZRHI2CNemarm5LNtv9uFRGYRgplycuTcBFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851393; c=relaxed/simple;
	bh=YxN35HOah8bYA7E8Mzbi9RWQefWmQ4WvDzoApAA6j6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW5c+0owBW+lttHt7Uo72uRVtRXAbHdkixAYLBdkbCPGXW3Je9WbtU922w8o6yLnNI8s7ZFjfTKv+AaopZBR9oKPTwQ/ICJCBPqUr/xvJNVZie/DTJ6rUN7u4wL5h1gIJS+f6sUKlbtVmGnS5YY1bEcU6+lI8ZXCm5icXZeevJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XMb6Gn5T; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863494591bso2840946f8f.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736851389; x=1737456189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxSwc8OTPdwnVGbJGX7BK5O8k6nzM8uj8qyfrxVFoMc=;
        b=XMb6Gn5Tr/jIPZu5fnf4ERazNudjzbI82keG+7plYyaPaDyXgTjOTUeNIyQcqq7JSt
         Hy68NumWnz77V4ZaSRM+MJgGVpFmhU0Wx69SzLe69n03zJ5gc0QXkpF5lPaBkDUQV6Xa
         3VAhOvcCSgPJ/NLE5u+/RQdw2/1H1GqhVxC7G7ERPmg/mc0GccEmJULruGbOx7P3g3Jx
         3l7Ws1JunLcckzEi6gOZx0oT3nLcEz9ZaHMScHna78zN2dDxJwsNxV8iz7u3mHMGiQn7
         T6DcRH47ypby7qKTtVVy1nqg4sLdvzRi3Ahk1N7BTj/6DHkoz3ZitvLHmQWz8Wfy1NvO
         0vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736851389; x=1737456189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxSwc8OTPdwnVGbJGX7BK5O8k6nzM8uj8qyfrxVFoMc=;
        b=IzFlV19fzAwojTKJmjUFkv19aaySM9ivM+HvCI2fzFZu+qOlYdT49t/LKKS9lBHEzS
         /wGXTxdMzoUPRAOdc82kjaNGwMgOo0Xzbi2/7CKZrDtMoI1+3VpxVpVYf6w+3xhLU2+2
         OlMamz2a91Vmln5d81rNXri1JMxSx1sXSyD+d4dlpvnO1WFkCFb42Udhw52ikgiWvmr1
         2R93MPn8dciU2/pcA1thBIVfbq+kzD4B2XMsijMW3f5gvgRzkhAUm9R4pF1k6fqvOL6Q
         K1FGMsurrctd+v6kelymN4TKGrc8WQFCIWJF0CeMT0IPJq9b7JJrmVFQf4hIXQ6n9j+0
         W4nA==
X-Forwarded-Encrypted: i=1; AJvYcCXFGQWsuvCMdP6C2ELzRwPNByVmiyrAcDRIpiQl20bkzpETu8jE04PI6iTwrFAHAfWtKSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5GsPHSKGkZLcm2Vi61dOEzjqXbZTFHPvmAUTasZo3yuZeFue
	g+uuHlsWRglZy8TtJkzRZdW8zjMtrIM8+Cu48mL/vjlDl+alpRanxyYeYUYnI+E=
X-Gm-Gg: ASbGncu8NJ1VTz8XKeyHU5CgkyC2mRMlip9ncdljAzdzxNEDZt6J0KGmwK49OEjH5QG
	cwkDp8xEQe/0BBFdlBVZUJBoXRdvo6dnSvHgtL3nIuZTzezN2SNsmnyWSaDlLl+7SKF9w6gpTze
	DJDOcr9Uht1kxMsKZ6saBMAC11mcF2sAR4jj5uEpn7VsU5H5iAzKit1hRlwIvocUKJTiLp8p/yL
	Bi30ZZq2VuDtYj86+Kf28Cg4NrUSAQxPoNiiw6Iqx8JkU3fsBHYD6ew1WeAc6uEB3d9Sg==
X-Google-Smtp-Source: AGHT+IEPeWyBdBywc/gAzMNm0XWpJZ3GnUVgsGz+yMD64YySeq3V9/H4z5M6xyDS35moJoykag2d+g==
X-Received: by 2002:a05:6000:2c5:b0:386:930:fad4 with SMTP id ffacd0b85a97d-38a872dec5fmr17582256f8f.19.1736851389497;
        Tue, 14 Jan 2025 02:43:09 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383f8asm14284638f8f.29.2025.01.14.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:43:09 -0800 (PST)
Date: Tue, 14 Jan 2025 11:43:08 +0100
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
Message-ID: <Z4Y_vPMt2dO0-X-r@tiehlicka>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
 <20250114021922.92609-2-alexei.starovoitov@gmail.com>
 <20250114095355.GM5388@noisy.programming.kicks-ass.net>
 <Z4Y6PS3Nj8EMt9Mx@tiehlicka>
 <20250114103946.GC8362@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114103946.GC8362@noisy.programming.kicks-ass.net>

On Tue 14-01-25 11:39:46, Peter Zijlstra wrote:
> On Tue, Jan 14, 2025 at 11:19:41AM +0100, Michal Hocko wrote:
> > On Tue 14-01-25 10:53:55, Peter Zijlstra wrote:
> > > On Mon, Jan 13, 2025 at 06:19:17PM -0800, Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > 
> > > > Tracing BPF programs execute from tracepoints and kprobes where
> > > > running context is unknown, but they need to request additional
> > > > memory.
> > > 
> > > > The prior workarounds were using pre-allocated memory and
> > > > BPF specific freelists to satisfy such allocation requests.
> > > > Instead, introduce gfpflags_allow_spinning() condition that signals
> > > > to the allocator that running context is unknown.
> > > > Then rely on percpu free list of pages to allocate a page.
> > > > The rmqueue_pcplist() should be able to pop the page from.
> > > > If it fails (due to IRQ re-entrancy or list being empty) then
> > > > try_alloc_pages() attempts to spin_trylock zone->lock
> > > > and refill percpu freelist as normal.
> > > 
> > > > BPF program may execute with IRQs disabled and zone->lock is
> > > > sleeping in RT, so trylock is the only option. 
> > > 
> > > how is spin_trylock() from IRQ context not utterly broken in RT?
> > 
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> > +		return NULL;
> > 
> > Deals with that, right?
> 
> Changelog didn't really mention that, did it? -- it seems to imply quite
> the opposite :/

yes, one has to look into the implementation see all the constrains and
the changelog could/should be improved in that regards.

> But maybe, I suppose any BPF program needs to expect failure due to this
> being trylock. I just worry some programs will malfunction due to never
> succeeding -- and RT getting blamed for this.

This is a good question. The current implementation has fewer constrains
and there are no data points about the success rate with the new
implementation. But to be completely honest I am not really sure how
much BPF is used on PREEMPT_RT systems and with RT workloads so I am not
sure how much of a practical problem that is.

> 
> Maybe I worry too much.

-- 
Michal Hocko
SUSE Labs

