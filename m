Return-Path: <bpf+bounces-73940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE50C3EA6E
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 07:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C8C1887E18
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31024303CBB;
	Fri,  7 Nov 2025 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrU/OI9U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKzkoYgb"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBF303A3D
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498319; cv=none; b=NoWbB2s+Zdu+5xdLfGQ7scjeaewsJV0VyzY56ybYr+gOZ2A6IGhR2Jgd4WuUyR71/TZQ44urdjWxc+/AINDjvIpZNbowAI/+mQCI0h5DPY1S66rD8HfcnsvcVJZeok1EUWpPUGuSBhLV2BmfpMqGvv+AigVltWRob62gJ9U6Rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498319; c=relaxed/simple;
	bh=uPG2qaEExT59WP2ysS8ErG3/JwdyIv1CjufizYF4whg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtUt0TpF2hnx+soJft2DVB4W0rXVQ1Ztu+/e8VLDrP2gOn+2UkNKNvZO6AxtS51/MsvnBkgR4og45SVjWluTN7tvFjPyrxsHZbyUxQPZa3PNLvC+/Vlbq4dFBRmugbVm+/w8BcHISjTQ4q6jIkpS7RGoOzPt70OnIjEfyyBV41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrU/OI9U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKzkoYgb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762498316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYmb/mOjOmAnHynzCc5urdD/k2k7E8plshDwUAI/8Ps=;
	b=JrU/OI9U+FY8Hugbv45BCCzhElGJXfVcePGkvTIjOc7w0XyVRxqPa9m7Gt9/Z8QJG8cyUh
	PH5HSFe8DtP4Ekz50L1PrD0Ee61DFknIHFPsTZ2MllVMzSg30dOXQTINjQxqiRK/qs/ftu
	aCH9y+i1dIeN7vpGkQ57MQ37gLC4ZdA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-yY17kK6vO5GuoBvsJOjplQ-1; Fri, 07 Nov 2025 01:51:54 -0500
X-MC-Unique: yY17kK6vO5GuoBvsJOjplQ-1
X-Mimecast-MFC-AGG-ID: yY17kK6vO5GuoBvsJOjplQ_1762498313
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cceeeb96so196489f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 22:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762498313; x=1763103113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYmb/mOjOmAnHynzCc5urdD/k2k7E8plshDwUAI/8Ps=;
        b=EKzkoYgb4nd7vgjuHN3sK1Zb6TwwTj5huwP5mFyPhZEkqWJmsK1CbKxkuR4OyyqipT
         4dY4SoijWxLLwv6FCnY0gTkdPB3sPFroiu6ObJPSGKR2DZfsnIVUVM/V5HNBZehO/uHC
         yTdPubeWwr4mPa0ALB6VbEv3PnWEL3HyDypmDT+qqQYV8ttzcP04HOQCFWpXFqdEYDVr
         kSXyhbNQY+UCP6TeoGabigtK6GzZoopwzbGQWKj6lzeHjNMGlkQbY5oZ9PjsQkKrGQaY
         ukbowRDKOp+EhyMWCLfxBsxwhPuGkwxsHefK+gQdB9os32BaLKhtt6TLk1lBEt9BVvJK
         oFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762498313; x=1763103113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYmb/mOjOmAnHynzCc5urdD/k2k7E8plshDwUAI/8Ps=;
        b=eNq7poJuPLDA30XK5OqpguU6Pc/VTWEEvTruYL+VF9MD0TQW+Yxo0rFH5QMJh8KHFz
         jwWDYHLe9M47kM2X8XeouOXchsOMSdd11akE67JyCyMu2cA8d+uhg2wPluBg5NnTDY3e
         OVAuf9XXi8Yl89KbiZdVSMePmirP4/u04yUS8dXXHP+rDa1BKKMKLCiguFhABEIbTnh1
         pUFhdlkoQbRVyliFw6VKo13dS0jIm/On2zLUiKdiL97HSuqvtVSLV2fB9wCokKKhoXwx
         7G3hwfe4WNTozWtuHX2LSBRvNP+2wukmc2hAJ+dd258vBYVeBtUkutSDtNiXkndKfEyO
         gNfA==
X-Forwarded-Encrypted: i=1; AJvYcCUY3rWaGVLXkZKq8tnF5jdGup6Wzxa5VMTZbXbm18ZOvVDSRMeDZTECCwze/uqIhVxzn6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJET1tunfHVJ6oZBMTCtYDUro4jVqvZRnFJeL02rfk94sCtAJh
	yj3JpZ6EatS4zD0jkF/JDpk60vDoNdI3VyT2o0oP17+WMeyCa0lWzgUoUVbjQleWoohWApP43z5
	PIbg41X8ky1vRumNeaqhkAwd6BQf2La8IuaNj8Dkj9M7SGTDCtowAtw==
X-Gm-Gg: ASbGncuZsKjV8s+j6YL9v5Sow0Y8GRH94EuVnxWFa7VlTx2OAjMxt8Kh60yJ96UzBoa
	XAVdBaT6X2KHEajoUwaUI63TmT60x34uXhJvv062sFVs75HUO4K/vpiCZmZyRS9Fxf0+vuVKFQ6
	OfJCQakTDEAm2SCZnIPq1dOz0cx5+bKdDpJdGaQsDUQlk574HngjK7MytKtydNBU1h4k2B5+zrv
	UH9Da3SS7MzNm4if9hnLUqwdEr2EjdbwQqTg6ccEpXiN3E2CA2UFzex7vsNFs0HxuARiaa5OHJF
	up37HPCJCfop3NBI3L2Rl4fpPveiSS8TlJ3N8dh1BDaIK89tJRGgzELZH68S1YXmjwJS0JoKfRb
	tMFEQ3ot24fniVnOK7q5GH7vVY9Gu8Q==
X-Received: by 2002:a05:6000:18a7:b0:428:4b76:c8cd with SMTP id ffacd0b85a97d-42ae5af3d30mr1473407f8f.62.1762498312796;
        Thu, 06 Nov 2025 22:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkTAZvSZYGErM/J0GLN/rgaF1MnsQc3qO4BrVNXh5vafIXUbVWfdF5xK+Ug878KB2EOdOBvg==
X-Received: by 2002:a05:6000:18a7:b0:428:4b76:c8cd with SMTP id ffacd0b85a97d-42ae5af3d30mr1473371f8f.62.1762498312396;
        Thu, 06 Nov 2025 22:51:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63dfecsm3408533f8f.12.2025.11.06.22.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 22:51:51 -0800 (PST)
Date: Fri, 7 Nov 2025 07:51:49 +0100
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aQ2XBQ4vGGFWaykj@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
 <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
 <aQzPVuI-dHEfee4W@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzPVuI-dHEfee4W@gpd4>

On 06/11/25 17:39, Andrea Righi wrote:
> On Thu, Nov 06, 2025 at 08:13:39AM +0100, Juri Lelli wrote:

...

> > > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			return  -EINVAL;
> > >  		}
> > >  
> > > -		update_rq_clock(rq);
> > > -		dl_server_stop(&rq->fair_server);
> > > +		is_active = dl_server_active(&rq->fair_server);
> > > +		if (is_active) {
> > > +			update_rq_clock(rq);
> > > +			dl_server_stop(&rq->fair_server);
> > > +		}
> > >  
> > >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> > >  
> > > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> > >  					cpu_of(rq));
> > >  
> > > -		if (rq->cfs.h_nr_queued)
> > > +		if (is_active)
> > >  			dl_server_start(&rq->fair_server);
> > 
> > Something that I noticed while reviewing this series is that we still
> > start back a server even if the user put its runtime to zero (disabling
> > it) and I don't think we want to do that. It's not of course related to
> > this change or this series per-se, but something we probably want to fix
> > independently.
> 
> Should we just call dl_server_remove_params() when runtime is zero?

Looking again at it I actually wonder if wouldn't it be better to use
dl_server_apply_params(dl_se, 0, dl_se->dl_period, false) in both cases.
dl_rq_change_utilization() deals with dl_non_contending (inactive_timer
armed) case already (even though sub-optimally, but we can fix/change it
later), so we can probably remove the special handling you do in
dl_server_remove_params(). The WARN_ON_ONCE(on_dl_rq()) could be moved
to dl_server_apply_params() as well.

What do you think?


