Return-Path: <bpf+bounces-73790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F4C395DF
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 08:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AE23BC265
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBB72E54A0;
	Thu,  6 Nov 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6yd/VU7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="USLIWSv8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7442DCF47
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413229; cv=none; b=ILtfU7J0YAxgWezHjtImRGkFTuSaP0QeHIxEt5rujsuadwp+frPJm9IEhfEEgChaymnhyc5FxubovvcM9ySq7e7hskvOmBTipHZuvWMKCF9RixYUFFcbOsEUZyqVJD6NxcKo2Ox+n42WprxexLkEHwDWYMccIckaW59JUelOzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413229; c=relaxed/simple;
	bh=O8Kuzgwo8NxVtUGQ/sqROsYTAZBIAHhIOZ8Fv83q4tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC8CWAT9GI+6NW2jnPqzp3K3HiUtsTuHD20lxAs4ycZVdcBF/XCKlFLEdAr/BDlfwKOF92PujPSpCQqqcghMn+h+w8tO7ujLVld4q29CVXoL9vYd2jDC8abYXwamUajjKl7bjHlflHdJIwzee826jpngfi4fTG9gmD+M2lQlJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6yd/VU7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=USLIWSv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762413225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
	b=I6yd/VU7kFDTDecxOHd4RW+YKdBDkW0WlZlmLccTtbk1Dbrj7aOHDMqdogz2Tth3ZVwVhu
	WEY/JE5mv9M1aBGIwWtqAK1ZG1qyb/6WfRCZMe6eHciGBw+s7mJQO46rKb3E33bjExIFV8
	6M3HUu3LxSUCgx1IjrmPL6FiWwuRV3g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ISuGvjptOj2auuDqONUK2w-1; Thu, 06 Nov 2025 02:13:44 -0500
X-MC-Unique: ISuGvjptOj2auuDqONUK2w-1
X-Mimecast-MFC-AGG-ID: ISuGvjptOj2auuDqONUK2w_1762413223
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso4007735e9.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 23:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762413223; x=1763018023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
        b=USLIWSv8jzi0XwvpacddR61/GSGBEEnW5HqdAGi9dOuVt5eZynS6+qOaziAkKnePa9
         WDzk/xevrJWhayw3YcdI52DeJEIyK/22xcwKQJs3uq91aj0whaQmsO2CkZAhe1vgI0Yp
         cfS2ZgeezRcKoLwpUPPZ9K4bKQu4DiKcp228wb0piIcBSUXXCOcb2zSnUWY7WWswF1K0
         NB1fPy2YNDQyfSMUrICVtZMABsGHF7kSA0zt4vJ0Sebet5o7DDBjqtuxhsITuURArDct
         w53a95XJwsFu30b1LXQj04HYoAkKHpHxSU1J2Ntn3P+WQMtSozboh68GD8UkPh2B/8v1
         Df8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413223; x=1763018023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOLQ/S3FFuFAGuSGNX4WWksMd2R4YXO/SrRbOgkSfy8=;
        b=L6dgOD+BB9S18DtZUAx5Wv/8r23iSy4u4mgK+ws3st8K7iW4Sz7TfZw1XdawD6spuH
         lG0bdTPDNXRSmMnJJEG3ucnv6fibLzEV/lTSh9oalkPwx3xpGXWYIbKY22wvmJZTtFQb
         6kPVxgw55dFDIvzvsx2eVaiDgaRRHazkBXdblPNFj7s4UhNC+rcsR1jHkHlz0woAo4B9
         oEmq5d6XilwWLu7F9BLPuG75KMFhF8Sv67Fv/9zgwyIIZw+zxiGUgeyYRY1+dK3F4b19
         tuOCnOODb54R0ddJLW653d9LDM9JDfIO6pi8oyqMMKbKJQXxzsTNlYTjkeSLi7zctEo9
         wyXA==
X-Forwarded-Encrypted: i=1; AJvYcCXMxFGufK4sd/erwe4bmpNxj7IrsJwHUKqf5U5f/ZB3PZMC7ZR8bDz/UfwEabAnM2vkJlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1whibORWoC10PPLxpILBKTqZlBqSiyuEeGiCFz27UZd8I2n4d
	MdLVYmgaAc9+FJwJFqKt2oPt1VSPy6Vdvhy7JvuZFs5R64+UBJtax1ZnSuUfB3Cw4fcTPep2f0y
	dvzyCTJmZCMsFwIZnDGX4fYH10B1hm0VGu24DDMDJLPP1W237tVDS4Q==
X-Gm-Gg: ASbGnctqfCLF4EUV9Eajo3TpPVlyi1f4VVTM3yqx0Scnj/DqUNaGfNlm9UwUpa6+gPH
	QFTbEjN/OFc5ZvoW+9nq4t6/5taqnuKDPozyTM7X34Wmd4oDYrad6RHg504gV4XRKiNSwZZsAD6
	h63Ugphh0o8qeHW9taUgHzmYzVLw0mia3P0l+uKcaZvk2srTWk0vk52+3nl+lF9ur/3lSRlgNME
	4gPWZ5VSCnYAmpCZwCsPYdqZEXRwLVxFLLN3Ep9djiz2UYnQeYJ42b3IKta/wQx3VisATgTY/2v
	gx+ReHiHJLsThUigSvuAEr0OT+vh3SKsUy6GOpu17wuUuKdY2z7C7OJkodL+SiM+4O21aFVk4Rh
	l9mlCQZG2miAgRQxEsCoNK/zl3n0cHA==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr53958425e9.3.1762413223138;
        Wed, 05 Nov 2025 23:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUu7ukY7OdyVbeRYFijYbMWBIebeXNAL9BcWIWvL8Cng+u4L3PwJcTQmxc3W42nkhzCF1KSg==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr53958155e9.3.1762413222738;
        Wed, 05 Nov 2025 23:13:42 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4adde4sm3235490f8f.46.2025.11.05.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 23:13:41 -0800 (PST)
Date: Thu, 6 Nov 2025 08:13:39 +0100
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
Message-ID: <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191111.167537-3-arighi@nvidia.com>

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Currently the DL server interface for applying parameters checks
> CFS-internals to identify if the server is active. This is error-prone
> and makes it difficult when adding new servers in the future.
> 
> Fix it, by using dl_server_active() which is also used by the DL server
> code to determine if the DL server was started.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/debug.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 6cf9be6eea49a..e71f6618c1a6a 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		return err;
>  
>  	scoped_guard (rq_lock_irqsave, rq) {
> +		bool is_active;
> +
>  		runtime  = rq->fair_server.dl_runtime;
>  		period = rq->fair_server.dl_period;
>  
> @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		update_rq_clock(rq);
> -		dl_server_stop(&rq->fair_server);
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
> +			update_rq_clock(rq);
> +			dl_server_stop(&rq->fair_server);
> +		}
>  
>  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
>  
> @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
>  					cpu_of(rq));
>  
> -		if (rq->cfs.h_nr_queued)
> +		if (is_active)
>  			dl_server_start(&rq->fair_server);

Something that I noticed while reviewing this series is that we still
start back a server even if the user put its runtime to zero (disabling
it) and I don't think we want to do that. It's not of course related to
this change or this series per-se, but something we probably want to fix
independently.

Thanks,
Juri


