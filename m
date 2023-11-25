Return-Path: <bpf+bounces-15850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB87F8E46
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 20:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EB8B21065
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B872FE1F;
	Sat, 25 Nov 2023 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgST56Qj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70370C1;
	Sat, 25 Nov 2023 11:59:46 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2e4107f47so1962924b6e.2;
        Sat, 25 Nov 2023 11:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700942385; x=1701547185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VO2STeGiEdMah3Rs2OqrcrAeByRtw44j2ObgacSxxiE=;
        b=LgST56Qjx/YIMLqSoJqVxm7x1UXV50JBAtyTWhCiz6WJRtG81EJjSIMCCXLcYPvNY1
         dmnNypoWAmRiiW1hde5W9KFzIjPSUZ5Zfonxey8nC9SitwMqvcgFyefuJFnthGLlA6vN
         mnpR/iaEV4BCSViF1SdyTwZQ8+RIAWaPmUiJiM60gBmsk6N3NIeV3ekz1xH1v55DpCxw
         yIHxy7WrWFRmhdC8YEdJuhwlAtc0HQnLEWO6Ahnl0A3sN51JiDrrrSA8qkCsjrjqduI3
         qH/YnyBy8TUrr3azmuuGutQcqjQPeDIac7HSBPQshmngX4RjUcisL9I/4e4QtF1WLTsl
         BGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700942385; x=1701547185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VO2STeGiEdMah3Rs2OqrcrAeByRtw44j2ObgacSxxiE=;
        b=gb8VKhmRT/4EALhWPolmcYd465T7iZ8YwyzqrkG6YAiQRC6Euf78oOb2TJgj+/yjgN
         u65+tnlvSLPaRo2OivXB8C1Mvqh8gSp/9EmYjq+ofvNROlg+zQZ1RPSqyDOKiwQQGXpl
         cwPnau5pWj3ymBzQSvDxONnJafRQMwbk+k3W6NFaPXdxirIIXZpcp/knQ/fm0fTf3rio
         yAPIabBkXILZIbjcDhK4gcGvkiir2NajKDNxJCybGNr0EP0sIWBrm4p7QKmkPdIVBNqR
         f7Hm0bpHnCB5gL/TkJHKpjgJU8eJRH3sVSwgdpOquDW/A1sHvb0asqnaAiaW/p78siJP
         DZvg==
X-Gm-Message-State: AOJu0Yy3haYYMZ2RkEuebDfGj/sRElwvqeTzRoTtme+KtYVnlj6CVxNI
	DOKrzvcTT/rKyPbZLDU7paU=
X-Google-Smtp-Source: AGHT+IF+BxyzFQahU6Dxq/44kcsAgGeS2aylZ4ZZxV46S/9sIA9rChJVPx29c5ohIiymo++7u/6c2Q==
X-Received: by 2002:a05:6808:1a1d:b0:3b5:c587:d9ed with SMTP id bk29-20020a0568081a1d00b003b5c587d9edmr9808829oib.26.1700942385503;
        Sat, 25 Nov 2023 11:59:45 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id fb2-20020a056a002d8200b006c4d371ef7csm4860212pfb.14.2023.11.25.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 11:59:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 25 Nov 2023 09:59:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
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
Message-ID: <ZWJSL15eCe0aXnZe@mtj.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <ZV8IR/w4IaxJ2vPA@gpd>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV8IR/w4IaxJ2vPA@gpd>

Hello,

On Thu, Nov 23, 2023 at 09:07:35AM +0100, Andrea Righi wrote:
> On Fri, Nov 10, 2023 at 04:47:38PM -1000, Tejun Heo wrote:
...
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +	p->scx.dsq		= NULL;
> > +	INIT_LIST_HEAD(&p->scx.dsq_node);
> > +	p->scx.flags		= 0;
> > +	p->scx.weight		= 0;
> > +	p->scx.sticky_cpu	= -1;
> > +	p->scx.holding_cpu	= -1;
> > +	p->scx.kf_mask		= 0;
> > +	atomic64_set(&p->scx.ops_state, 0);
> 
> We probably need atomic_long_set() here or in 32-bit arches (such as
> armhf) we get this:
> 
> kernel/sched/core.c:4564:22: error: passing argument 1 of ‘atomic64_set’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>  4564 |         atomic64_set(&p->scx.ops_state, 0);
>       |                      ^~~~~~~~~~~~~~~~~
>       |                      |
>       |                      atomic_long_t * {aka atomic_t *}
> 
...
> > +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> > +{
> > +	if (p->scx.flags & SCX_TASK_QUEUED) {
> > +		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> 
> Ditto. Even if this line is replaced later by
> "[PATCH 31/36] sched_ext: Implement core-sched support"
> 
> > +		dispatch_dequeue(&rq->scx, p);
> > +	}
> > +
> > +	p->se.exec_start = rq_clock_task(rq);
> > +}

Sorry about that. I updated them and will include the changes in the next
iteration. Will test 32bit build too next time.

Thanks.

-- 
tejun

