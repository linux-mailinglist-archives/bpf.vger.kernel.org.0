Return-Path: <bpf+bounces-71402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B9BBF1C05
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBEC18A6D8C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B932142F;
	Mon, 20 Oct 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMQ7Sj/N"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6A320A0B
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969545; cv=none; b=lWHAtB68JiptFCX///Jel5tzGqCb/xHoawL4aKDaPkSue9Hwd/hbM13Slv0FOtjaCWFQOa/CNbyXE9RkAJ43PZzRmVKJZBUldOEskdWZ5wOZ5jLDwb473V8E4EfWg8rIyJ1z+2kBT/PGjNwXStdc4B9BB0Ze9LVn7ANF4m7aM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969545; c=relaxed/simple;
	bh=XTmyJMnTaGQvMndSexCb1z6HpLrVTTo7/egeZXdgM08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTgPp5eWyF47+TsyFaj/RlZD4Iu1JtEzFFwUKs/miDPJLnH0ZcygBDvxa7R5uf6gAp1GF6ufun3cgCqrfv3Bj99QrRwwP22GS+KlO9lM0BT2XdOXmxTlKSYP87TAxlIGJka1OYApU5Ea92Pk7OfNxTxCd7n8I8GXOgNlCtJRS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMQ7Sj/N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7m1GlhRfmho7liEla+/1yigGXVY8Z7LQaPA9s5+XnW4=;
	b=bMQ7Sj/NW5tUjYz5vnvf6LHsVH7KYObfCxq3ktDRYe8u0dS5UYmWtSCI/gpMNm+DzgYM8T
	fPbQd/1v7+IZiYMc4yJcGkqLnewdcWixXpm/XQez3MpKMAupyOFxO/0IaOUlAGsEIdQ2l2
	q7l2GbZJRSrLsktT8H/mAy7yE+kgWKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-VY7-5pPeNx6dU4yvEWQ2ag-1; Mon, 20 Oct 2025 10:12:19 -0400
X-MC-Unique: VY7-5pPeNx6dU4yvEWQ2ag-1
X-Mimecast-MFC-AGG-ID: VY7-5pPeNx6dU4yvEWQ2ag_1760969539
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46eee58d405so23319485e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 07:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969538; x=1761574338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m1GlhRfmho7liEla+/1yigGXVY8Z7LQaPA9s5+XnW4=;
        b=dxJfYScgZCfWjLrGkGdLNXOODYluaPpvRqs2T8QZMJ3cJI4CgjtJViz3kN0zyRuA7y
         SR8sRnuIYGfbhoANXkOMvRUPsjIDfrDwt7jURouWVPqRvbDF/tJXPauGQGqEadm1TD/a
         Q3y0mWBbwpYMoG/iYx7qSCoOo24WaOpMkz2b/Ij/YD+f40rWUScVR0WNVZtN75nRQ3rR
         ghWuvNfxNBsmVo+JsdoIeUXOm+aSaSWMbsMWfjjSyCqNiJ+pZA1oZZaIDyeytkHY6wGy
         4zmuANGm4S4kvZ3C+WTm4uJtfO0cDMBBouZFiX6lMUg9XBj7tRxjslDPolGNjYhxF5lq
         ZOiA==
X-Forwarded-Encrypted: i=1; AJvYcCWux5pNogIcCEh71wxMr5OLVfbtdpdn9D13HkS/h9c+xTCsRDgFhKJxFLLyS/o17Tf2bKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjyc0mlqkbtEaum2K8grbROM4gXj03WU52ckeJvPhavd8AXV4
	JRHISYQFoSZL4T1HVdGhxxm7Wz8eno/vQH4pn5SJpim/1z4pgWNQeS/dPsD3DLFifEPBxvKHR+X
	VuLkVn+bqYSTWR1FW/MN7Hr3XTWZg9KJJz2eYgDiA/4BjudxSW/rvBg==
X-Gm-Gg: ASbGncvnOfxf68VjGKYwVSzkLC52PCpfP4CbnPGcUrx3OIIXUogYNdQYHRJkPGhugHt
	lvHhOfKgUTnIfEXDfZdnRPJ96ojTvBjKiMeEUy++jyF78HegVnTsfxZL1FEME5lt2J5WavaNqyQ
	w8MdA8xVHdhpOeSfh836mgrY9m1Se0ceM1AVOFbwOCA0aznqxQtBNp4Lnz4ZTEJBBZ/VcZNCJKi
	mz7ORU9dDB91vWWB/amVnRIwannVaHY0RAJ3g/I/SjbgH1sklhSqzBo/0LB5ZLoZCdOiuwtLWY6
	yKfYtsKZ7iSnkH57IAPgI9HTC4IcviCnuOxQPg/4hWyxWt37z21m8rcrAR+Av6TNowrHOvWWbbK
	R90Yl3fgq0m7sxfkb6+mYNUam/SBqqQ==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr120146955e9.32.1760969538599;
        Mon, 20 Oct 2025 07:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUFlFwDhK5O8LnMIOdT/gwVFGKlVMOVfS2OH7HmR0uwDj9gtAHpXIdIfbbitn2vkRwOsYp+A==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr120146715e9.32.1760969538203;
        Mon, 20 Oct 2025 07:12:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm15921167f8f.35.2025.10.20.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:12:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:12:14 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPZDPsJaZ9g4jz0g@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
 <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
 <aPY7O7NNs2KyKpb-@gpd4>
 <aPZBPQpRHm977Fno@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZBPQpRHm977Fno@gpd4>

On 20/10/25 16:03, Andrea Righi wrote:
> On Mon, Oct 20, 2025 at 03:38:12PM +0200, Andrea Righi wrote:
> > On Mon, Oct 20, 2025 at 11:49:51AM +0200, Juri Lelli wrote:
> > > Hi!
> > > 
> > > On 17/10/25 11:25, Andrea Righi wrote:
> > > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > > 
> > > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > with accounting and we can retry later. Without this patch, we see
> > > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > > 
> > > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > ---
> > > >  kernel/sched/deadline.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > > index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > > >  	cpus = dl_bw_cpus(cpu);
> > > >  	cap = dl_bw_capacity(cpu);
> > > >  
> > > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > > +	/*
> > > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > +	 * with accounting and we can retry later.
> > > 
> > > Later when? It seems a little vague. :)
> > 
> > Yeah, this comment is actually incorrect, we're not "retrying later"
> > anymore (we used to do that in a previous version), now the params are
> > applied via:
> > 
> >   ext.c:handle_hotplug() -> dl_server_on() -> dl_server_apply_params()
> > 
> > Or via scx_enable() when an scx scheduler is loaded. So, I'm wondering if
> > this condition is still needed. Will do some tests.
> 
> Looks like I can't reproduce the error with the hotplug kselftest anymore
> (and it was happening pretty quickly).
> 
> Then I guess we can drop this patch or maybe add a WARN_ON_ONCE(!cpus) just
> to safe?

WARN_ON_ONCE() works for me.

Thanks!


