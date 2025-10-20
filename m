Return-Path: <bpf+bounces-71401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB0BF1BFC
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13FF44F44F3
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B093176E7;
	Mon, 20 Oct 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBLRt8L1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798326E6F5
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969378; cv=none; b=iWM75J5Qeu6KhKr3k/Pu0f1z5Kh1S/OyVB/bn9yhbCgRKdlk4M2X2u89uB3VYBqwEWUM+NxElIUSU2SFBkvIdAOlHY5RBkqLRZUaQv8S7LqSH3bJkYj82yioy8qbfmbhGBi/KPEk5YthcWwRBi6EiBQ31LlqSKEGCS8A03Vxnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969378; c=relaxed/simple;
	bh=j/Pp8+a9LWec1g+KxozHCqh0X+tJ57lSb9FaEKyKHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itFg+iF7AVbvs0y6pQ+KcZNtBEGsbpMTC/FuI4JSZMFmKJpciPuVeZcES0dkTVRy6K4571NfLkmvlU66umIn4AfiT8dUqC/9gX86/MvzDXeVvy5WgDwCAK0jdckIM/UtQ+sWw5ukW/d439xeEO9qjATi3cdxrnFziukmjzIiKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBLRt8L1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQFS0nziRWGUnVx3NjlDIpRK/8NuLJrpA5nzcrIPL+Y=;
	b=XBLRt8L10oXcdUWEYbpXf0u04wx0h3ciy4LRzvDEfl3rXyovPe0orTOlOkq6+rFRU4SlXP
	AS42ANm50+3xukApIkO4wXUDw78wVRF1FzYLYSA78cVJKn8EBeLjxm73Npr+dqVtpK3Eat
	wPCimZcVvzp12j9y6P1FdRUEXiAhD3U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-p-sLhDtCMPakZuNHBV_vJg-1; Mon, 20 Oct 2025 10:09:34 -0400
X-MC-Unique: p-sLhDtCMPakZuNHBV_vJg-1
X-Mimecast-MFC-AGG-ID: p-sLhDtCMPakZuNHBV_vJg_1760969373
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4710d174c31so48138465e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 07:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969373; x=1761574173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQFS0nziRWGUnVx3NjlDIpRK/8NuLJrpA5nzcrIPL+Y=;
        b=t4IqU6LgnfWZdr5ecJOdRm6iW6rokAJkhT81lYAIoqG2ModqKqjDP97BTHKuOmtzV7
         QkHHFE/dg2qlcvPvsPcMWYeTQ9saXD1T72DS7WNB7zc89H0or9eISJ/61QkM86Y+EfBH
         72dCbOOGjQuyqb8XD2md2PJ81ZDROQI8EMMJ1Dm24CaBoYxnKdtU1HMJxmbd3zwb2M65
         RksAp+B3v63uJVlVe054EXkOnPjMQyz5UeE0UA6auxJX08wy6YjpaKQt3jB8avR0s7O9
         joYrHmtelLwifque+ifsijI7/RMlH2zqzwEEmYKPOOABLhmEAJ0bGdAtgzxfvaSHg/HB
         uwNw==
X-Forwarded-Encrypted: i=1; AJvYcCW+xeZpOdkbtJVikWjhp+DdFnGkQ/zOZw+sbGVcEILhssr8m2BsR/9gMQmZ8Mz/vD+e4os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCND1yf2m2TB7c19ythXevMsgFdU2Q1eUuVhdUYJY0kn/d+Q9v
	7RUcWqdVs3moLxWaWNckjrlPOXrA6qdOWFkA1t4lRzzSj45qoNKnZRFGSlJWphjZRuXnZCTw715
	rAx1BFyMlNxQUtVlumBN1xd1KN6PUuYQVLoMqYIy5svrTD23eU2v2OA==
X-Gm-Gg: ASbGncsqS1iR39T6cGxkjMUIXTqvHTwdq0y2UINfC/tqyncgyvTewQyETAXf9u/ZSvi
	h3JLjQKmbn3yz0Hknm7TJ3yQDHK5NA8YUQhSnD/rhJUkxpvWDyjqKOw0I1PUOZc7QTFwAW86dwl
	sNrGQXaP5hSzmVPmJlOTREJ6QmgSDNblAhn2r1UEhZMlX1nCgCBc7DSchUsxIFYIFa1Fz3mJadk
	3msYh4wuWOz2Qg2LHOEbIYuru+oDIxT6aVV6VRgCYCVO0H8kV4uc0tBTZkpYet4agxVcp7Yzf39
	480zwMj+Wsg8JtWVe2NuPNvHXRMnnikME47xjoAUk19l3h71lPHcYkZR9jnoWhdInlv5IcNVoEd
	9zDWv91CV7hCRBfD2ecpTK/t4I2THCA==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr86748895e9.16.1760969373333;
        Mon, 20 Oct 2025 07:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0mn7LBjNER9gtoWif8Bgg5J8Y0egN0uHFHsLZtoAR0dq+X1zkA1a8NQOlBpYb8JH2pb5i0w==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr86748665e9.16.1760969372894;
        Mon, 20 Oct 2025 07:09:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm149048465e9.9.2025.10.20.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:09:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:09:29 +0200
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
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPZCmZF_K-vJOYKp@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
 <aPY-QOXV5USEHVIq@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY-QOXV5USEHVIq@gpd4>

On 20/10/25 15:50, Andrea Righi wrote:
> Hi Juri,
> 
> On Mon, Oct 20, 2025 at 01:58:50PM +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 17/10/25 11:25, Andrea Righi wrote:

...

> > > @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
> > >  	sub_nr_running(rq, 1);
> > >  
> > >  	dispatch_dequeue(rq, p);
> > > +
> > > +	/* Stop the server if this was the last task */
> > > +	if (rq->scx.nr_running == 0)
> > > +		dl_server_stop(&rq->ext_server);
> > > +
> > 
> > Do we want to use the delayed stop behavior for scx-server as we have
> > for fair-server? Wonder if it's a matter of removing this explicit stop
> > and wait for a full period to elapse as we do for fair. It should reduce
> > timer reprogramming overhead for scx as well.
> 
> So, IIUC we could just remove this explicit dl_server_stop() and the server
> would naturally stop at the end of its current deadline period, if there
> are still no runnable tasks, right?

Right, that is what I'd expect. But this part tricked me several times
already, so I am not 100% certain (Peter please keep me honest :).

> In that case it's worth a try.


