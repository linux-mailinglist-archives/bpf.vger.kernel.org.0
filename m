Return-Path: <bpf+bounces-67395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3BBB43389
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4CA5E3554
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC129A312;
	Thu,  4 Sep 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7EiTYVG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9A2868A6
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970253; cv=none; b=OLnQzJ8EEWZw2bdsZ5ESWpv4mCp6AETdrHFIi3BYHNSueCU3Me9biBSR28V20i7U7wbgIH+lTXqoOV9Uu84REvojz0+Ho9rvJ0PxZVwJpchsBoa/hri/vkv4PKBgjGxajCd7U0rPj3Vmqj0T6y1KnOrFcfzcJHoMWwzDM0+AgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970253; c=relaxed/simple;
	bh=oIckBVKRKgmc03f98rn0emLj9a37R8lZrEevCLloEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq2JPE80cLF0IN/Sgk7XUSVxY9M3aafn/NOBQHHoLFQHZphkdNA/XKfcTo43LVzWXsZEVz68qNFXyi0DWciuXE40DegyQyUnWByMy4y+3Y7Q3UbBwO+PgvJ4kBTSglzbX8gQm5PlUuBZyaiK8HL0PC6taMtroN+IwDfU9Hb3cDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7EiTYVG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756970251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8hHca6nrr4DSD1i4RnW4HNPHcBb/x8yT/5uh6e1tr0=;
	b=A7EiTYVG3vpi6Xi06OaZQnIqbAy5rV1zZn/8dG7/rXp2CUm9Ts7OXN3WSe0PX73iS65QsP
	wrJzZZUMEqnUfB/ugJmki5fL8TgRDK2enjmrJjXq85nyIIEblgf7ohZV/KOQXNm3USPHGt
	efYJc/llD3lwBnaJj2sY4/Ka/OJaJp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-kToSeuC7M1SKwdfDlqtlzQ-1; Thu, 04 Sep 2025 03:17:29 -0400
X-MC-Unique: kToSeuC7M1SKwdfDlqtlzQ-1
X-Mimecast-MFC-AGG-ID: kToSeuC7M1SKwdfDlqtlzQ_1756970249
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b87609663so3706045e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970248; x=1757575048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8hHca6nrr4DSD1i4RnW4HNPHcBb/x8yT/5uh6e1tr0=;
        b=u+dB4B9d0ZsjhJxg2fOEPz5An52v7DA/BxEkoG/+bmyWZ/PyMTxzdn5GH9LkXf0MTp
         PgbJHEBY77+qKSDf6lUhGogGo8Wc0JABo6uf+H73Eg8PPEvwS1fbEaDh3MekKI6n+4o9
         K57AWPfV8zye83wnJ6Hd9npjNpZLUUSjfHPwhu7Fpjlh1jRCRMCDlfhhF7dDmWMcJxA/
         Z+zVaFVfYMDtwdss+S3tLdWAsxY70ZuWzVASBc+VM9bvIKNH+9TrFO7pfbykzVC8Fahe
         Nwzzi+oI+TNucPcSWDRkw2jaYvp99GF/uQFa/kP8rp5FmRLkYgiRyH6O3LjUMAguawgY
         TBKA==
X-Forwarded-Encrypted: i=1; AJvYcCUIsZ8jUW1RdqKO978aZWNfCdom/fkbVONjD3qGmneRNVgqbfrQpdfviaLR5ma0gJ9O7Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSg4pkP0mIzExAesXwFO44kGx4HqQb5A89abAFBrA4T68I4oM
	m9BWPvkFMQMhsY3yBavFVUnjBoOoBsEzu74IuOkBl3bkoLNvU2SpCpDOLVjBH+FwwejcDUpryUe
	dApEYylBW2rW754feqgyIo1yPrCh6sNb1/o5qOP1N6g9Esh0xnOGWBQ==
X-Gm-Gg: ASbGncsbl3vX3Gm1k/jmAI03SkjZjZRxnXL+lm54m2q0yoBITXcxE8K7q+VXkFTAxBw
	3x0K2JiNrUfEBp3sFzVNkR9ZDjWD+Bc6oQh6hLk+C6BEGQEKMOEntgjDwfhJp4L3lgBt0t1y6qo
	ktIIr79lXgiYJ1A4UPcjloTADWXsnK94xyYSyIDH0PPb7MiTx+nB4u3kZ9wEGyhE75wKgudBZtj
	yCeBw+PrtC6T8K/mIiFcz+cMDxM/FnhcN4jlYxQ4M02o/4MPANKvd/stWS4bSgy21yOtGNvMqY1
	dLYbQ3fFovjFRZCKVzI/27QnVo2ZPqJ27NnAFBcPlPGXOYvk8TMhRAksC1ArjcI5cLuIiMw=
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr141027125e9.25.1756970248436;
        Thu, 04 Sep 2025 00:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlNaYXu+Ti5TyjToAfM/VPhoLNPClSOiPQxxxvQ/mXgMA1LuzTwi9Jqs2HyOXrR/sPrrxEg==
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr141026695e9.25.1756970247956;
        Thu, 04 Sep 2025 00:17:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm7685035e9.7.2025.09.04.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:17:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:17:24 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
 <20250903200520.GN4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903200520.GN4067720@noisy.programming.kicks-ass.net>

On 03/09/25 22:05, Peter Zijlstra wrote:
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
> > 
> > I don't believe Peter already expressed his opinion on what Yuri is
> > proposing, so this might be moot. 
> 
> Urgh, yeah, I don't like that at all. That reasoning makes no sense what
> so ever. That 5% is not lost time, that 5% is being very optimistic and
> 'models' otherwise unaccountable time like IRQ and random overheads.

But, wait. For dealing with IRQs and random overheads we usually say
'inflate your reservations', e.g. add a 3-5% to your runtime so that it
is sound against reality. And that gets included already in the 95%
default max cap and schedulability tests.

I believe what Yuri is saying is that dl-servers are different, because
they are only a safety net and don't provide any guarantees. With RT
throttling we used to run non-RT on the remaining 5% (from 95%) and with
Yuri's change we are going to go back at doing the same, but with
dl-server(s). If we don't do that we are somewhat going to pay overheads
twice, first we must inflate real reservations or your tasks gets
prematurely throttled, second we remove 5% of overall bandwidth if
dl-servers are accounted for with the rest of real reservation.

What do you think? :)


