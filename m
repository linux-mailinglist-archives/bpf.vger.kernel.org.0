Return-Path: <bpf+bounces-71376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE8BF02B9
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC10400786
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD542F5A01;
	Mon, 20 Oct 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfTQfBqm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99642F5499
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952472; cv=none; b=Sgqf2g53EshGb22Duo+CpzPLAgtslCdeVsCoDKYYRGU0FtBquj9rHqkmizD+zn14vM8SCorZQTvK9plpykIAlf4RaLouChHevHnPex8NFIin9CZNP9oX13T3v1zGZ61adpezAiWe5vq5BYrJ8Pvt/HE/RTlRjESyzUlgeTKctJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952472; c=relaxed/simple;
	bh=dFyf69AmPulWJCNb9/HhNO+93AFGf8+/y+hPagOet7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBv5zXHzEjqB0CVEKEJAju1u5hZ0y+e+4G1HTsKWXOP7uMsdlItgYuD+TQs32lZsRao5/uVWPFfurlF18mLtp3ZXzlFntpXk10yy3BQeNr0S1eCrsQTcqPEhnKW/c8kHwNsDH/ISFCI9RtVYz3qGV061Fu3hB/OFe/WmUP9mCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfTQfBqm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760952469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySlbD9JSQ2a30ZVs+aOpmM6Ago5zTLOLY/6GRotx8qU=;
	b=AfTQfBqmEq5L0A9KjqjVXqSeqrBPIf79F0J/UEl+YVKygvq4EgdRCunko6CF/V/VHPK4Vz
	d+eriPu0L7kxYR1TQ5Z66reXF0eQ6mU5xIxKWXmo55gB2UERMlOxj/cJ+wH3YHevw3auUp
	XLUkgQMM0OtkrU/nhIof+NVX6VezNAQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-_Hd0q6QVPPO27rkYDJ_sFw-1; Mon, 20 Oct 2025 05:27:47 -0400
X-MC-Unique: _Hd0q6QVPPO27rkYDJ_sFw-1
X-Mimecast-MFC-AGG-ID: _Hd0q6QVPPO27rkYDJ_sFw_1760952467
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471193dacffso26535805e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952466; x=1761557266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySlbD9JSQ2a30ZVs+aOpmM6Ago5zTLOLY/6GRotx8qU=;
        b=UEt4cncIjxYwrt5vjarPOfn8ZuJ7yGSMKzjUdFsoBDa8l1IZVyAVCDVF17PsqYS1C/
         E0akRCN0+34ga/WKQac5P9zUKDPsHu4bsW7extuloIYQNDYkBcalrVhETS+JXbFFCADG
         /Gee3YhkeJN66BRo3IEeVlH8QKBJ3j5P2ek0iDnj39UsUeebVCbj7WykoX+rXLwmHLav
         OtYglKSO5JUPwuSlpkYQoSAN8yFwrNTdxBiDcwN70/W9YpCUiZ9nNTWWfrYWp06N1r0S
         e2rG2Zb+lyMDUjEBc45aVhv+/acIiA4djMCbBrKuy9lBwgFCYfOjSk0llDdlIqKUCCV1
         vQGg==
X-Forwarded-Encrypted: i=1; AJvYcCVT/gwlPGhfPzyr4wKceOLZUBLX6nO3MIiQXw4fwsARaPJp8ruT4J9VyXSJSZ4c/ZaiLLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyi1My9d8VDeSzdYkAAgmYEpaSH5wY9SQ/F4mYjUbuCTRLO38W
	7tH3+BinbhoAXuoXtLAJCYRVqlbzEdF4sk8DSY/6aqN1K5hwioIWz686qiWuDU5nY4PebZmG1In
	l2bj4neUbGJZ9tofq54jOXOEBRYEzS/UyexFckSkKu8tqK7G941DfWQ==
X-Gm-Gg: ASbGncvy16X8PlQfzR54Rrl73F20f0kpCX6Hjii6m3XYYJDOLk+yhVw1nD5nhoU9kIF
	HtYwmJm6WL365L6cAcgqvIM5ivW3GyNNriayIUGcl+hKNpruloI7+295F63WCJZWIz7+N6ozWoM
	5lOizbkwxh79mnwPw+clJhCkLEITN4QVkn2QoqWR8MEi/1movo5Q8aIZB2EsmEXHXIDx73OsRB9
	KHWzwAIw8Qz7pf11sb1hSkSbGwLz0LPhrDaduueCz3gdK9YXaFSJG/YF5sQkZoMF3CaZ1aGgZhD
	AZZwZruUzLJW8zB9xHzZY+Smh1/GILZzrv9iaLawRMBPaFV20XdKQvOIxrbrPSXB4R8YA8i8DqA
	Kh+1fqoJwkHiE5UM1p58grHIj2NA4yHc=
X-Received: by 2002:a05:600c:458b:b0:471:1702:f41a with SMTP id 5b1f17b1804b1-47117919f1bmr98968295e9.33.1760952466510;
        Mon, 20 Oct 2025 02:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUyEeSf/+w1j3kQT+cNvPNRS6yAgY56mxs7wWlFlz2eV2bpnVw6cx7RlqWm7oJTUSvZbsr8Q==
X-Received: by 2002:a05:600c:458b:b0:471:1702:f41a with SMTP id 5b1f17b1804b1-47117919f1bmr98968095e9.33.1760952466107;
        Mon, 20 Oct 2025 02:27:46 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d382fesm130481475e9.10.2025.10.20.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:27:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:27:43 +0200
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
Subject: Re: [PATCH 02/14] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aPYAjzEB0n0O0LPY@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-3-arighi@nvidia.com>
 <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>

On 20/10/25 11:12, Juri Lelli wrote:
> Hi!
> 
> On 17/10/25 11:25, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Currently the DL server interface for applying parameters checks
> > CFS-internals to identify if the server is active. This is error-prone
> > and makes it difficult when adding new servers in the future.
> > 
> > Fix it, by using dl_server_active() which is also used by the DL server
> > code to determine if the DL server was started.
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/debug.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 6cf9be6eea49a..e71f6618c1a6a 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		return err;
> >  
> >  	scoped_guard (rq_lock_irqsave, rq) {
> > +		bool is_active;
> > +
> >  		runtime  = rq->fair_server.dl_runtime;
> >  		period = rq->fair_server.dl_period;
> >  
> > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			return  -EINVAL;
> >  		}
> >  
> > -		update_rq_clock(rq);
> > -		dl_server_stop(&rq->fair_server);
> > +		is_active = dl_server_active(&rq->fair_server);
> > +		if (is_active) {
> > +			update_rq_clock(rq);
> > +			dl_server_stop(&rq->fair_server);
> > +		}
> 
> Won't this reintroduce what bb4700adc3abe ("sched/deadline: Always stop
> dl-server before changing parameters") fixed?

Ah, OK. It looks like it doesn't, as dl_server_active() is the correct
thing to use/check. Also in case the server was not active is should be
enqueued in defer mode, so no need to have an updated clock just yet.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


