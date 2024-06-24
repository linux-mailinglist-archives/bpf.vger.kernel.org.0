Return-Path: <bpf+bounces-32955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303C9159BC
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954B21C21575
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2944E1A0B03;
	Mon, 24 Jun 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtTh7oOs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3E132127;
	Mon, 24 Jun 2024 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267491; cv=none; b=uB9JiMQQ5CRPTlMZMo7PwlOEZDFaG5j7SaXu+uqp08jJzjDgtvrTufvPpaVRrCg5Vh21Sfr7lVWJNtjgPbEYfZj112oLmkl8WWMPbfcXGXXx5avy7iz5S6QfhdVQMeB70t3IkjvDbijibefejcM6GXTlgU0FDzi+L9sH/xeohA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267491; c=relaxed/simple;
	bh=Z9KNXp4MnhHzN+oZJ/qSZbB9ht1F5adEvzfqrOIsL2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1IM9yb+xfrnEvo5ZB7jZM31rzULsBxgMm0751vvHSeHLUZbzerUVa6DDF6aCXzKJWner1bHnnKLPuz8fZu/YJVA7GGnY1Pv4aBnHO0ItAt1aSbsWbJHOnIqf2tYUw+nDuyXrn3V+7WWzhecFDBuErIth3x3yRMhmO2wzmSPB5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtTh7oOs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f65a3abd01so39386075ad.3;
        Mon, 24 Jun 2024 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719267489; x=1719872289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKJ4cDysqin2746pkd9fKqrhNGcxbOmry95OgZaKf1Q=;
        b=EtTh7oOsNu2O+Hjl31CkR+4e90nOWSW23/hSEk+mPbWDnkUXYzNEnEqLXEWqZHm/BQ
         wGtLoektxGVorjz1cgnupTSNd/DYikPatiyHRnPtn+umu95SYI8IHR0TQHRzNLOgQgoX
         pC+YOLr/o/Qp3NFU/GU5GdE2L8r6fWww2TMpL078CqsyhdIC3mYUAgDJkME1k6Oqys46
         weQM8DgZAD37H/DDQMUAMwbKhzFDAOrkvTcV2bMPhaXKyNEAb0fDiIHYClr3KUJ1+ZaW
         xSmkXMQZW/ILXD9T1GonzfTwVcv3qQWZzpwU4a+x//jBojXp4VCAC5JmSnI1d4u/6PTC
         gCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267489; x=1719872289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKJ4cDysqin2746pkd9fKqrhNGcxbOmry95OgZaKf1Q=;
        b=tlj0GIRljy/o3oB4t6qO9Gx9KWbMvakkJtituZ9hKDBe92sITeZ2l8d70+5xtjht3h
         To6p7q2AsS7wbqCg/szjOk1wxa8fnLfzq0nwyGxwF+U1lz73zfvpW2oiRCImbny7UmOd
         onLmZAv47jNYPcpv8ZbEIP5//NdmPtmGZy43QtWWlyeEClPuJodtpb4swsP/ReuBFF+s
         kpJrv5haut+MYgvAfSI5sDntA+lRKGFjo4P/jNWgW9LAp6a5vov130qQyTDYywQUUBd7
         3wxfch+8XIUshUAWtf41mXRoJEqobskPB3RAq4gx/ufAzF1rJc7CFzsWk4ULBdna3S4g
         52+A==
X-Forwarded-Encrypted: i=1; AJvYcCUP3UmDNUVFUVESFg9zk50KY5/QjUmvc+1T9iYK/tckQqrBVob5V1vKWTZYzMT7PuQx1ujtdzIho25KPgrd2acgXrQWd52f33tyMZdrE3MwKmxPZhC3sxWeXE/Wd4TdDu67
X-Gm-Message-State: AOJu0YzRbtQjCITjiYs1dPKSPX/g8ilMIlVOXBbZwzUijn76VjrEaqKS
	qyuXrKsTrAq1iFYHBZuGIIKQDTO7Y1tm970/Ho0O0E0mkhvtepuD
X-Google-Smtp-Source: AGHT+IG5+QrTstT6rm8aOxCwoqm5V/lV4HyZRSR6IdbWy0edk/gqx6F847MFoeGI+/lYdkO5pUiXfA==
X-Received: by 2002:a17:902:c406:b0:1f6:e11e:640e with SMTP id d9443c01a7336-1fa23add606mr82516985ad.4.1719267489406;
        Mon, 24 Jun 2024 15:18:09 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32170asm67871075ad.86.2024.06.24.15.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 15:18:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 12:18:07 -1000
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
Subject: Re: [PATCH 05/39] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <Znnwn0waZXAcNsjn@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-6-tj@kernel.org>
 <20240624110624.GJ31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624110624.GJ31592@noisy.programming.kicks-ass.net>

Hello, Peter.

On Mon, Jun 24, 2024 at 01:06:24PM +0200, Peter Zijlstra wrote:
...
> > +	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
> >  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
> >  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
> 
> So I *think* that I can handle all the current cases in
> sched_class::{en,de}queue_task() if we add {EN,DE}QUEUE_CLASS flags.
> 
> Would that work for the BPF thing as well?
>
> Something like the very much incomplete below... It would allow removing
> all these switch{ed,ing}_{to,from}() things entirely, instead of
> adding yet more.

Hmm... so, I tried to make it work for SCX but enqueue() and dequeue() are
only called if the task was queued at the time of sched_class change, right?
However, these callbacks expect to be called even when the task is not
currently queued. Maybe I'm misreading code but it looks like that'd break
other classes too. What am I missing?

Thanks.

-- 
tejun

