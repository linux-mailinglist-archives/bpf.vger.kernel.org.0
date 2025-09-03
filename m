Return-Path: <bpf+bounces-67308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D537B424CF
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89D1188F0B4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E632222D1;
	Wed,  3 Sep 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWfrNMst"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44B4207A
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912527; cv=none; b=BIq8UVVyL55BoPPcQFUlzsZ2iXu87xKfP/GFMX/hwommoMgReUR+V5xWGBk+euRlfys5SVYW/z43/IwoYAgjF9I6CvpUKC3SrvZQGHR8cwYhI2jCeAmJDgHfnCJ0Dughxj+0o+xReYrP/kmhIilRy+DW2WFX9eUc6+8OYxmC3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912527; c=relaxed/simple;
	bh=Qs0vM4WnRg1sWrSQDhD/dHdJLErkQzLDPp/S8NA9xJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knUKtgVe8J57zl5AtKuPAGx/pVeI1PWIb8MTj2m2sUkBLiLOLNhfkN1bJ1vHgQBwv7SUwAtLtmjdAM8S7FFCz4ZHruOlRWEVe0LNgJYx6etmwC0KtzcA5ciCBM4Fz0pIHLcd2TCZS2FR+uXkaFL9z7Q+1jWD/UHc/A3OUywlU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWfrNMst; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbSBenbpjTa++jsPneELJOEvjFDl0VlvYT1LTF09Ibk=;
	b=AWfrNMst+9J1x8YX+6eobddg2wBGVCqUTX1KQH1ePZBbsCvC3DikmoYJUWy/OWgl32fcjg
	jslljsESSYDbXFWz5SUNdieXLxrBbOzQIMNRmuqkmmW31k/T7szruard3gh0TFFiWFuTsb
	x4fsplUMp37rwUqUhe+G1qlOyWWJWg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-cPsrnuVyPoiAlhnYjECV2Q-1; Wed, 03 Sep 2025 11:15:22 -0400
X-MC-Unique: cPsrnuVyPoiAlhnYjECV2Q-1
X-Mimecast-MFC-AGG-ID: cPsrnuVyPoiAlhnYjECV2Q_1756912521
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so341875e9.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 08:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912521; x=1757517321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbSBenbpjTa++jsPneELJOEvjFDl0VlvYT1LTF09Ibk=;
        b=DMI60BXvh8fH9jYZt01fLyFOrn7nl3CKeMU83Fn5GK5rOb2zPngeMXMqGHa/tk6vh0
         /3LlZ8laIYRhyzDqeGhLihimNXrK+1I+l7u0X3LgFWOya3nEEQCZjXXoh7JugJEAM4nU
         jIOO2UCxfvT9OZgzImCa14jq+M92/HvDPTN59UK8jPYb5GNF2t3k7DUjKBCNGnWXtNZu
         GQqxartnqhPPDE12KFzr/8UH55Z/vSjSGYzBBpTgT9acppnVXCmH7jHiAcZeetdMrRHI
         JXh/VCrAH0+R5WVdiedIHcgFSWV0YHiprjXc978VT2d7akdf7NRiaQbWOhHhiIAU847J
         6erg==
X-Forwarded-Encrypted: i=1; AJvYcCWLAKoCeU1DWBzDuZ+L+xl5rMdhJT6z2Py08Ztgft0t0y2aPf6MR3IzntlRrbncw6YKkvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieMNnh0nYJ05rMJsG6bmlGfvyIrrAxHYQueky8ps6YvS6YkW+
	XzGx+69lM4HRtq6I9erxI3CecByQg8B/s+UHZqzJC5+LC+E2MQCU7sZmSW6n1iIiHmKn6aGMmqs
	uDfEjL4/uLBndWwb/k5sHzpXpEN66EO7AoAkSiwueMv8Hv5T9tB6J/g==
X-Gm-Gg: ASbGncstBKKuKEBXDVdhrDTd/jUmJXEGsjkvVhvRAEwCZ8ZmrCbA3V//s0WjAD+XsOR
	5s/IRLab2pj/9+AUv2iwwcMwQTeTfFPEUb7fUka/tlC5i2WRwanmSH86JKAJljStIhWlZxNkUyU
	8CadBwZmhtMk/zpYhckZPoxwEz1kA5KAQtbhHRmJ9xVwFMfbj2VZROnLKwcK4fpp3V8k4yn2Qoo
	lJfauhFg1OfKGDiruTCYh/bEEfzZvrcH4i1fuQ0nAdLSAD9xUNVk3+RtHt0vInDLP/ArcTCCjHq
	Gmp6koDSuAkkTLyUDs23lW/5XGXkg+sjgP7Fua+v5n8aim+6HhIAohEbhUgr6ZypW9aCIac=
X-Received: by 2002:a05:600c:1d04:b0:45b:82e8:c94b with SMTP id 5b1f17b1804b1-45c9ba76d74mr32283285e9.18.1756912521366;
        Wed, 03 Sep 2025 08:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhDv2jD1vUWaLSAILrInFOmf3ssm9G/W1i5T3Ku2qX4/HBVn1l3SPVtqllrd7Mm4c5Hxfjow==
X-Received: by 2002:a05:600c:1d04:b0:45b:82e8:c94b with SMTP id 5b1f17b1804b1-45c9ba76d74mr32282875e9.18.1756912520893;
        Wed, 03 Sep 2025 08:15:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm243996435e9.12.2025.09.03.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:20 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:15:18 +0200
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
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLhbhv1oiwxQ2E6b@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
 <aLhafcdtmW6s-ydD@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhafcdtmW6s-ydD@gpd4>

On 03/09/25 17:10, Andrea Righi wrote:
> On Wed, Sep 03, 2025 at 04:53:59PM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 03/09/25 11:33, Andrea Righi wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > with accounting and we can retry later. Without this patch, we see
> > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > 
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > >  kernel/sched/deadline.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 3c478a1b2890d..753e50b1e86fc 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > >  	cpus = dl_bw_cpus(cpu);
> > >  	cap = dl_bw_capacity(cpu);
> > >  
> > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > +	/*
> > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > +	 * with accounting and we can retry later.
> > > +	 */
> > > +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
> > >  		return -EBUSY;
> > >  
> > >  	if (init) {
> > 
> > Yuri is proposing to ignore dl-servers bandwidth contribution from
> > admission control (as they essentially operate on the remaining
> > bandwidth portion not available to RT/DEADLINE tasks):
> > 
> > https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> > 
> > His patch should make this patch not required. Would you be able and
> > willing to test this assumption?
> 
> I'll run some tests with Yuri's patch applied and dropping this one (and we
> may also need to drop "[PATCH 10/16] sched/deadline: Account ext server
> bandwidth").

Please mind that Yuri's change is still under discussion! :))

I just wanted to mention it here as it might change how we account for
dl-servers if we decide to go that way.

Thanks,
Juri


