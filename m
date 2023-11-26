Return-Path: <bpf+bounces-15868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C987F91EB
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 10:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D20B20D65
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957526110;
	Sun, 26 Nov 2023 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JtVbkIvc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D56DB8
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 01:06:01 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 83AB63F886
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1700989557;
	bh=NOf8nwqrRIShmOg3ETfBHRni0LDjvujlBEtnlkJfS4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=JtVbkIvc5Smt37YKIfRSd+qVL4J9x7SrPD+Amp4oO/nHGa/Df+iruhGnVKXYkCQdV
	 ySPR9unYoZ1Sqi/FSGPIR2EN3cuMtAcYNeLt8Ndc8PQOBdbesxiD0NkaKGSehEn6Vh
	 AiBFOQTg9WKWGQ40fp/oV3kO5lxNm8w6E7Lwv6OG60HuUztDRbWm/riJWMl2XoE1dC
	 a6Y9N17r005aQbzabh89GyQ55cMdSqSN6LHyNMcv04DMsjeFchJA7lu0TZ7orCSTTR
	 Y61Xdjhqf8LFyPDDgMWNRxaHGS9n4cWJxxTkARoHtyF7WkpY2gqFwY1YMhS2Puj790
	 Wb4mbu4cKDvMw==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9fd0a58549bso380096866b.0
        for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 01:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700989557; x=1701594357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOf8nwqrRIShmOg3ETfBHRni0LDjvujlBEtnlkJfS4I=;
        b=qQOe67ZO5KRrES1owC/vnAIasfOXKslXbbgAKNo6hRV55TdlIAuAAUjImnPVGMorhj
         fVGXmv7dWpUfMDYT9leIbsOeXBNBG1jUgRQDH+aZzAVDG2VkVEcChjYjtskNdsGZUa75
         QSRoF1q+PlTKv/cayLJS4SNHC5yXlK6qNUD5MjWhHSM+aNAmdanAFc68FrqJ8KpHLpvr
         ZZoKTINfrOcjbDzDbuIeCQYQNB1tSsCPa9+RC31pQblOtARuAydRmb6B2sCxt9fPjaEm
         z6XHpg3z4cOvbYDiWeoetBwz3Go+rYt1897h+8ZDVZN56mpidJPPMr9NE/3kUH+IxqDe
         HUsQ==
X-Gm-Message-State: AOJu0YwwPT7t/PLG6q+fEPJ4AI0/85I7yoeZYOMqH1nSg6RsCP49znfQ
	n5Cnbo+Kwbta9U4EZTcXbVhyfXkWHuAFTBmtTkJ0Zw6uufVfL7IC4JM/Fqd+9AfQAA9dsxUoK3o
	9GcRxspMTSe5LvLMAaZp55yZ+Te7Shg==
X-Received: by 2002:a17:906:7494:b0:a01:d701:2f1d with SMTP id e20-20020a170906749400b00a01d7012f1dmr7321327ejl.14.1700989557223;
        Sun, 26 Nov 2023 01:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN59pkxh3dfTCg77E/TXP5hk7Zi5T6bnJILCygsLlXQXG428gwl2nuC8774LYguLMSolYBfw==
X-Received: by 2002:a17:906:7494:b0:a01:d701:2f1d with SMTP id e20-20020a170906749400b00a01d7012f1dmr7321297ejl.14.1700989556648;
        Sun, 26 Nov 2023 01:05:56 -0800 (PST)
Received: from localhost (fi-19-199-248.service.infuturo.it. [151.19.199.248])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906411800b009a193a5acffsm4359673ejk.121.2023.11.26.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 01:05:56 -0800 (PST)
Date: Sun, 26 Nov 2023 10:05:52 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZWMKcPXIAuJ22Q+i@gpd>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <ZV8IR/w4IaxJ2vPA@gpd>
 <ZWJSL15eCe0aXnZe@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWJSL15eCe0aXnZe@mtj.duckdns.org>

On Sat, Nov 25, 2023 at 09:59:43AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Nov 23, 2023 at 09:07:35AM +0100, Andrea Righi wrote:
> > On Fri, Nov 10, 2023 at 04:47:38PM -1000, Tejun Heo wrote:
> ...
> > > +#ifdef CONFIG_SCHED_CLASS_EXT
> > > +	p->scx.dsq		= NULL;
> > > +	INIT_LIST_HEAD(&p->scx.dsq_node);
> > > +	p->scx.flags		= 0;
> > > +	p->scx.weight		= 0;
> > > +	p->scx.sticky_cpu	= -1;
> > > +	p->scx.holding_cpu	= -1;
> > > +	p->scx.kf_mask		= 0;
> > > +	atomic64_set(&p->scx.ops_state, 0);
> > 
> > We probably need atomic_long_set() here or in 32-bit arches (such as
> > armhf) we get this:
> > 
> > kernel/sched/core.c:4564:22: error: passing argument 1 of ‘atomic64_set’ from incompatible pointer type [-Werror=incompatible-pointer-types]
> >  4564 |         atomic64_set(&p->scx.ops_state, 0);
> >       |                      ^~~~~~~~~~~~~~~~~
> >       |                      |
> >       |                      atomic_long_t * {aka atomic_t *}
> > 
> ...
> > > +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> > > +{
> > > +	if (p->scx.flags & SCX_TASK_QUEUED) {
> > > +		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> > 
> > Ditto. Even if this line is replaced later by
> > "[PATCH 31/36] sched_ext: Implement core-sched support"
> > 
> > > +		dispatch_dequeue(&rq->scx, p);
> > > +	}
> > > +
> > > +	p->se.exec_start = rq_clock_task(rq);
> > > +}
> 
> Sorry about that. I updated them and will include the changes in the next
> iteration. Will test 32bit build too next time.
> 
> Thanks.

No problem, if you don't I'll test it for you. :)

-Andrea

