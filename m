Return-Path: <bpf+bounces-33108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DE49174D6
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFECB2188B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 23:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9B17F4FA;
	Tue, 25 Jun 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC7Y5bFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3725EE97;
	Tue, 25 Jun 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358865; cv=none; b=GRGPUKVRXI3z+RvgkPK5pDjOK/Uy4+othaUCX0yHOX/3+EUKQCOpfRGFjO2OZr86Hv7YObWW6UH5mHV5x3gra+fvC8+DQHSQUpLFK/5f42qU5A8BF/E9HROGbQ+mixQIIa73pMZVti43tkxToo3/zKLjBKQIEqtWW9a7KOJZY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358865; c=relaxed/simple;
	bh=JK7uCoML8qfi3n0SlXFdbTxMEW+VEneHpvCgjcNXp8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHOnhnO3b/Zvf3mAg7ZNcdH776BWk5aXIFWAEN9+rYTMhJtRax/FLBFmP/JuIAJHJ964cqdyCAUB1TxNh9+kNjyafbmb0lmtwU8SpA7CbxRGJlRoOoWGEitRbePfyqbP+XY5/uhk+agfmDHSpwBbahNxx9rBxMk4XW3Ki5AaTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC7Y5bFo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70656b43fd4so3564718b3a.0;
        Tue, 25 Jun 2024 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719358863; x=1719963663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEAfHM+hCJBAK/Mpnd53lr9Lw8KWedp3wvgKnpigICI=;
        b=nC7Y5bFoDanGGSGpBcK8iIlP7MWI9E/5jAbvr1114PbGvVh4y/c6Ej9mSkA8iTeX31
         Pphnze0R4KqaieggVcpnTFpEThewigyJ3kEgUMFk3T7SGAzK6fDOPB0HqAQEJxKosnML
         H/CeDk90Oesj0EV2ho8l1MMu6kJTcWdWphm6SOqv4pKofowGWscBnZ+D/drklzfojx6y
         pY1rateN8Yz7kfA12rAX/pr7J72rGQ1mveDZlbxCcPY5Om7YT+zNYFzmf/icmh9Q6+TT
         oq1GCU3p4FmOe1seIGfj86FXMxhF+s1+tAjzJsQG7LJsRmwBqC4TsC27XFeQD/sh0oZW
         J8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358863; x=1719963663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEAfHM+hCJBAK/Mpnd53lr9Lw8KWedp3wvgKnpigICI=;
        b=V6M+kIxF3OzUnYuTR1j+JRtNU0WwoEiVF0jYUDe41ozjobtrnGuO55fXmgIdsUGLAE
         nd2RA8ej/AyHRvCudrYmL/c9qH6G1DvxrExJPhepap2WpnBblVDWRFxy8ktu16mGtOut
         j3reflVSLRELwr5/jhjWm4m0q/0ntxyObdqHcyRAuitEcU1piPgrT3acBgYdjD+1RuZg
         RKtfSyVXDcHD7w1aYGGhnnP08tgFL+PDU2PJjTZfxS3FGDReBOJ7LLW0lfKxSJ8w9pOh
         W9fRVwwTXSe1JmalSil/OoN4dy8CZjUDQj+Pa9ZYckcUEUMfZdkFJm6YWtEUxK4xyiAi
         y2iA==
X-Forwarded-Encrypted: i=1; AJvYcCX8vJZneLLvu4YefLkjdcWCATrlro9TT34895zqLPTJS/flMPlGrLRTCW/QL7wv+qTIruEONCR8Ual+kxK7nFrR3hrPO8O9vNvNyOHYp2dEU4FTqckGM/eKzYP5KoiZZa3Z
X-Gm-Message-State: AOJu0YyS4uTZQKMrr+wsWTB+VFUFfCL/5YoeXdvOkvwrDCVUzm7rzQcE
	gQkx42ufKtnCrILBPOYbGYLkj0cNO7IVSFyNpvnO/4XERCBMEvpP
X-Google-Smtp-Source: AGHT+IHzQdbQvS2jrWlYdfxrinNBhOZYRaLeJuhM1U3ppPzIEBnQnmne6NX3+8qWxqVKL22ZgZEYtA==
X-Received: by 2002:a05:6a20:3c87:b0:1bd:27fd:ff4e with SMTP id adf61e73a8af0-1bd27fe0185mr2272364637.55.1719358862832;
        Tue, 25 Jun 2024 16:41:02 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb323636sm86604355ad.102.2024.06.25.16.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 16:41:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 25 Jun 2024 13:41:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 09/39] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <ZntVjZ3a2k5IGbzE@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
 <ZnnijsMAQYgCnrZF@slm.duckdns.org>
 <20240625082926.GT31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625082926.GT31592@noisy.programming.kicks-ass.net>

Hello,

On Tue, Jun 25, 2024 at 10:29:26AM +0200, Peter Zijlstra wrote:
...
> > Taking a step back to the sched domains. They don't translate well to
> > sched_ext schedulers where task to CPU associations are often more dynamic
> > (e.g. multiple CPUs sharing a task queue) and load balancing operations can
> > be implemented pretty differently from CFS. The benefits of exposing sched
> > domains directly to the BPF schedulers is unclear as most of relevant
> > information can be obtained from userspace already.
> 
> Either which way around you want to turn it, you must not violate
> partitions. If a bpf thing isn't capable of handling partitions, you
> must refuse loading it when a partition exists and equally disallow
> creation of partitions when it does load.
> 
> For partitions specifically, you only need the root_domain, not the full
> sched_domain trees.
> 
> I'm aware you have these shared runqueues, but you don't *have* to do
> that. Esp. so if the user explicitly requested partitions.

As a quick work around, I can just disallow / eject the BPF scheduler when
partitioning is configured. However, I think I'm still missing something and
would appreciate if you can fill me in.

Abiding by core scheduling configuration is critical because it has direct
user visible and security implications and this can be tested from userspace
- are two threads which shouldn't be on the same core on the same core or
not? So, the violation condition is pretty clear.

However, I'm not sure how partioning is similar. My understanding is that it
works as a barrier for the load balancer. LB on this side can't look there
and LB on that side can't look here. However, isn't the impact purely
performance / isolation difference? IOW, let's say you laod a BPF scheduler
which consumes the partition information but doesn't do anything differently
based on it. cpumasks are still enforced the same and I can't think of
anything which userspace would be able to test to tell whether partitioning
is working or not.

If the only difference partitions make is on performance. While it would
make sense to communicate partitions to the BPF scheduler, would it make
sense to reject BPF scheduler based on it? ie. Assuming that the feature is
implemented, what would distinguish between one BPF scheduler which handles
partitions specially and the other which doesn't care?

Thanks.

-- 
tejun

