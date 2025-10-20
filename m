Return-Path: <bpf+bounces-71374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48903BF01D0
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3823BC07C
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B32ED14C;
	Mon, 20 Oct 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dudGMQ8F"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD929ACC3
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951539; cv=none; b=goDBzEjc8wzZfaMyrHPrePdt7ORV9odwkD+YoH1vhhk0r4/d7gUlYEczenKCyS1uHPkjqle7InQ9512X9DSUDT+0wWjNwoRxVGfh/5t5R443VPvF0N0dC7871GF1vWvncD5aQUTICKUTrH281lrW0zo2xlTZq35LXRESv8XaAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951539; c=relaxed/simple;
	bh=ta6LSkk+9A3FVM3mm3iDzNK4zuCKnQq6jaHDvp/Xdvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNqPY4K6ClCJIY6SIld3YW59tbm0TPPHsJnr4E110htMFZzVUqwYTeJn+162+ynT4N6AT4xyK6aMsr7c9zF33CvsTAlIhQJ623STXvR0dKRJO5HJmwAUpni79BOc/CMhett9FqeAd+qneb5W+IzG4987kK/2k1K0PReLBYvf2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dudGMQ8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ubitj5/uevHZU/7Ly6xrweyvQaOv3M8jgDaIwUyJNQ=;
	b=dudGMQ8FDeCvDo6Vn73Y4xcyXO5FdozszhSIlmSr2UfXJ1C7TobBFoNTWEEOrLIWjkzxnX
	W+7R0evqvRckwLTxfKo8GMXgIwkHf5b5/3BpAA2PF/Z4HrOL/wrtk782e1aoh0DY3dPHdk
	bp7pfeDmIPzt5ETfZOyGKlf6FV2ZYnc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Fn2vuB3IPO2MiY96HCMZGQ-1; Mon, 20 Oct 2025 05:12:14 -0400
X-MC-Unique: Fn2vuB3IPO2MiY96HCMZGQ-1
X-Mimecast-MFC-AGG-ID: Fn2vuB3IPO2MiY96HCMZGQ_1760951533
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4270a273b6eso2077752f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951533; x=1761556333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ubitj5/uevHZU/7Ly6xrweyvQaOv3M8jgDaIwUyJNQ=;
        b=Y+41bKgHu6UMqKJvNWwNhKDMIwqqjD627lzX48mr/OtLScH+HM7mQ89NCKkOqH+Axc
         NjnapMswL6v8YNHQU3nT5ytBhtP9dFpkxizbCkF0kVSlLL39AIKclZfIgLYu9VUYRpB+
         oWXM1udwzJIAcGvAgqkiJK4aAGFfT0l3r/PsdGyqcz3Ztm8hk57dgbMapyXwS+2rqAOu
         bRYc1luwfQI0gXsXA1B+GvfgdTy+BAN6PYYu+9hKfvy5gTYBTzW1c5dhWfXJuMVRFGE/
         98QcoYxM79IMIW1BatPib0AuxpvjLWIAC//PfI6KGqY9YuVQHoa3Q1U/O1G5s05ldfqd
         WMGg==
X-Forwarded-Encrypted: i=1; AJvYcCWeHy4wFEW6A6ljGYU3F9P+rh3fZV2tAB8UuEYDbsOB09IOI454sLAVLFY262t4Z6EKRoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSgCvMDsP4KOji/SWT4kY4VLTkSS0dOChqgpA/B6aR2zepVKj
	eY7/w6KrVVlfsMmMMVu30bw3qrpPTL/LkUIOGzcizz1M8hl2DNyiax0bkIfoQ87tZuUKihh2wRJ
	30iIu8BiyC+darUfnHQIRm2Tbc/YjK7oNMo8IsHl1bov9W2hugHNoVw==
X-Gm-Gg: ASbGncsMD7EHP56Ew59RtRJLIYscbpHBJ3TbghHb1KXJNgqRbaA6+xqmoUo91clfS9t
	mqqNGi2KTlrUQAt0JeYJzFktv/KZgLTJ0jsKP4cnJkzbFeK/PKclPvF81kQ1d6lVwAWwB6Ie0Em
	Z+90aI3Krgq40dnFqy9bym4SPVWu/Za2XopLzAltbadkIMrUoSmQ+OhuiOxy6+imwwaoIvEHRTe
	m/HavYlf+JrHS3x/ypzlsDer01A8re907GQ6Ddu9+JeaJn8MftKhE0RhVtH+7aezP3Hr0Kmnf/c
	LhjmL1Y5+T3i7oEG2gN8qgfH7B3Lx3MJZQ2wnvsf2KfkHFOczl3hVdi4rdiG6hYs0fCmGc8EbQz
	HStnuDMsRD3+mDAiU8Z8JxUV4SCTrijQ=
X-Received: by 2002:a5d:5888:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-42704e0efc6mr8234674f8f.60.1760951533492;
        Mon, 20 Oct 2025 02:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1x7pXYq8e945UALV9q1YHdxFAo/gpZoHmNBgsdqAAWXDZS350AGwm1xrETAUHltalmZTxLw==
X-Received: by 2002:a5d:5888:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-42704e0efc6mr8234649f8f.60.1760951533088;
        Mon, 20 Oct 2025 02:12:13 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm139474055e9.6.2025.10.20.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:12:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:12:10 +0200
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
Message-ID: <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-3-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
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

Won't this reintroduce what bb4700adc3abe ("sched/deadline: Always stop
dl-server before changing parameters") fixed?

Thanks,
Juri


