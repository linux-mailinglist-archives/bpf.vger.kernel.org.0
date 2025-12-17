Return-Path: <bpf+bounces-76871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BACC8A1C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F56431C6EED
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533D35580B;
	Wed, 17 Dec 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbTbsFmP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="spwPvRAV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CB34B43F
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986559; cv=none; b=h+4n2BDwGyEpJt5wtXYphkmm6k54nXqNHvY3b8b91I5ZLIUVUs242VoiD50vNRFfL5xp2x70SmRT9HwnNJjwEQGqlzPLA9Lix9m0oq0HY4hhNaPAKX+O1qAqk32zYHJFuN/FGpSURs/EenX1A/L1fw8TTtIc88JVB2JmZSQXtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986559; c=relaxed/simple;
	bh=ej7TTVTeGnBUqaRwlQnvTPhYft8GTVTgUYErJC5s1Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkRirwjprQe+qqSR5voiQerguLK5tKqvYykO5MioQktwceKQLw2wn3EXBqrfmx56aY+uCtcG1Hn5dR/FqM4vL0fQYqLJotOIGU+hP4fFE/n/vJkxLRD2FJCyVzL4tPv2nyTCAD8FwXwwzflf+cqLQXtyS3GjSfKmoqqcd1ECS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbTbsFmP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=spwPvRAV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765986555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
	b=cbTbsFmPpQF53mHeTRTUYEbdaJqTF/nvW/jUVtxH4Bq8FJsnPP3EVV+Cn3zJIRp70wH4i4
	8rQfCFafZfdQ6xDfYlPBzCldfJ9DtJdl85uWgVfbV2tKliDXgzjBrftxctLw/ss7XXF24A
	c2d7DGcDF83SO5afvqfvWPPZV7tVIIc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Z4Be07SsMQ2XqBp-5a3hcw-1; Wed, 17 Dec 2025 10:49:12 -0500
X-MC-Unique: Z4Be07SsMQ2XqBp-5a3hcw-1
X-Mimecast-MFC-AGG-ID: Z4Be07SsMQ2XqBp-5a3hcw_1765986551
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563a0c75so38132865e9.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765986551; x=1766591351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
        b=spwPvRAVjPd8bAiYboWPfTfdFQRAGJ15XAMwYEoFXDhSZefh54e7XdccsV5Llc7Uwn
         2Cd4aUsk59IcNoYtlvXaU1Mi6aoRLHZ6uAPodYzH5JRhyfmUM8GEM4l0xNB9+tAy0zub
         9SZNiNhKId5RxSxLB6gIRe5xfrR4+KiqLBLzKPse1zd9s95n51KT6b8aIR/UGNVPf9Kn
         qmT2ZrxAaWp6fQhFzYdNQuC8YE+2Tqtl8upLZ+fN/gbKh/DUqQXaAP9Kqtpts0PYOwHq
         uEJvmQTonCLkfKmsTyfZODQI1KNnPHzW0oRFGVH2haIcbyNlOlIV8Fu6orjabELdfyFz
         FX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765986551; x=1766591351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bJTbj2QHR/bxiaOEFbouYE+C6nf3xnn/6jMSMVKkAk=;
        b=npIptjE6SEz0DUnAhfBsR+MYmK0BOLPWo10P+NPybTamfIPePuifGcdaIPfc4jFsrP
         lkHYmc2p4CeGgoVTVsoGvxmDpRYl3tk6QOm1E2Bb033kej2yfgAnSoM1jjAUZQkZzg1+
         dF2VyBSd2MPOciJYwDLHi+MKwB61GkwVX1qgt2ArWbpcYg5zzCO3Zb3a94QKRFy9xUEo
         NmS0pmYqxOzuV7i1qN8uzbe1+I44uV1qEGJxX6/NApfyJSoc2hX/cpGLHCkKS2iiSWc7
         5CbHuJGMNf+1ci/rTMyU9wzgoENBWvmHcSo+vITT+q7tSZ45rBPSTAceCVGyJmHN+3xh
         1Ogw==
X-Forwarded-Encrypted: i=1; AJvYcCV1sznTRUWtm7whisOxIlgJycXkk4DPsUhbVGi87tJw8OskyeIUqDNmaJ35Kc+fhc4nLZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wugEdd0jAf70vHZPgFafHcjBdYFeKCrmZGuh89kFZbm+1l01
	pY8XtFQcu2S5StWcw8U7zBNr7bFZL2zWxCjdmc8jSIrd8vHHnw+gEP7Sc0oe6fXA+rbzfs4BqEt
	pMkHJZHcriTN4k8LX53XTiSQyLxKQFmLVBTJgP8ibWGd19BkS0/f8nA==
X-Gm-Gg: AY/fxX71t1ANEbUHt2Yyz+7apqOBcWsxnbP0n5/cMwLOlSmf1mqk7gkDah0GXk1zz4T
	Ceu7kJkgyk+vVfFnHhCTNe0QvWkepvc/ZHUBnsdpQjZKm3yaDwWaycGEpu5Vb2U0X7SYdyQ7LT2
	prFQKjK5KD9+3f0VQBAh3hx9ulmtlE6Ac7FElAhFVtF6F86fsOO+5ZSg7HQ3ORYTbD5QNO2ci3n
	WlGxJX+G1g6pJ/hCPJ5VaQm9MSjOeh6Xt4CYU8IJDsjIN7WTJ8OhPBZgm1pEaqp/pLkYgn0PB9B
	VmJBBSWptYcj5M+31qO2jOOYLqW01RnApfGyc3z0vcmVDG9Lo0xXyKA638QRYkLEp7FeeOGjwWo
	8ZIK3EVLxRSuAebooi/3ZYsu1aYm8RBkl84urUdXP
X-Received: by 2002:a05:600c:1c88:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47a8f917533mr206284045e9.34.1765986550788;
        Wed, 17 Dec 2025 07:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ+ughGVWwzvXsaWm1dblcs5eRzcKirhAt+kak2tJQKEnBlZisL9+a1O+Ahuhxi1HwalxGKQ==
X-Received: by 2002:a05:600c:1c88:b0:477:8a29:582c with SMTP id 5b1f17b1804b1-47a8f917533mr206283615e9.34.1765986550400;
        Wed, 17 Dec 2025 07:49:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd911a9bcsm32202995e9.6.2025.12.17.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:49:09 -0800 (PST)
Date: Wed, 17 Dec 2025 16:49:02 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217093923.1556187-5-arighi@nvidia.com>

Hi!

On 17/12/25 10:35, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.

...

> v4: - initialize EXT server bandwidth reservation at init time and
>       always keep it active (Andrea Righi)
>     - check for rq->nr_running == 1 to determine when to account idle
>       time (Juri Lelli)
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)
> 
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> @@ -3090,6 +3123,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  {
>  	scx_disable_task(p);
> +
> +	/*
> +	 * After class switch, if the DL server is still active, restart it so
> +	 * that DL timers will be queued, in case SCX switched to higher class.
> +	 */
> +	if (dl_server_active(&rq->ext_server)) {
> +		dl_server_stop(&rq->ext_server);
> +		dl_server_start(&rq->ext_server);
> +	}
>  }

We might have discussed this already, in that case I forgot, sorry. But,
why we do need to start the server again if switched from scx? Couldn't
make sense of the comment that is already present.

Thanks,
Juri


