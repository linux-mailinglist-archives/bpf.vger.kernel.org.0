Return-Path: <bpf+bounces-67300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B4B423EF
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 16:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A430B1BC31BE
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705321E098;
	Wed,  3 Sep 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPBSttut"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1A21885A
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910612; cv=none; b=Y2+0Q7/Y83X78N0zs2ajnooZ8oXUjqg8Jvm4/fY/PgrCUgGUpdcnfpnw/Wl81YQt6MctEWnEManefzrSP/g9SBqYbfdCywf+8ruyTH4sblwLtFJ2U7hAGl4DtuTNg71f/qXmGcDx6Y4mzJvCmviWGgjfxeQhlQ+qNdrp1mdzwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910612; c=relaxed/simple;
	bh=qsg5b1hCS0TH3mz58QfmV5A/hWbcjsLvlIP4yl/lCZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhuFeXsBGqKnZE/OHYQlyybl2+qDZsf0XN5oelgM7WzjDZ4ss7AQds0TcTv7qRYA3NQDq9em4q7A/462QmTHD8778J/Q5VAFjJC5ezyZrZWd3FLjCrfhV6vNdXoRMbH/p7U6jOpBsB/2h42CBC2dAZLxjOejMy5WeVMM+UxhIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPBSttut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCtH6GLs0daKTSTUdfVUnTaEI5cKFQFkvOMaqMYTXws=;
	b=VPBSttutF6+4hwBX1JE9+egC5ImQs2pd4iiJcXMK/SDiBh6Z0RI+3PugjzUste+DsUheNH
	BjwI+uywZAA7sgGs4j9JvKe+tT8uCA19q4B9QS8MufCY2IVhztXW9E7tG1gIe1A+Yi5m94
	d2RTsRiTE0NILTt49RXkUQNuex6nJbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-pY4tVEy-NkKSq8S13NEHMQ-1; Wed, 03 Sep 2025 10:43:24 -0400
X-MC-Unique: pY4tVEy-NkKSq8S13NEHMQ-1
X-Mimecast-MFC-AGG-ID: pY4tVEy-NkKSq8S13NEHMQ_1756910603
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b7d84d8a0so39285e9.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 07:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910603; x=1757515403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCtH6GLs0daKTSTUdfVUnTaEI5cKFQFkvOMaqMYTXws=;
        b=N9AfH3ZPvU1SZlqN0idJq33ofL01CeKO5cu/dHhqpK27WarJGE6cKeg7Spe9iXGgQ6
         BbbCK9GLSxj7vkjDXORsI/8xTOXQquPzsUs1KHNFriQklhhj+8/eJtRhk/pSriOYTFMk
         lSUKsNF7O5lP4uPJ0fzfGulyVeRF7Dtvh/ZrvBPHK/NX8Z7HzhFaqEZA2wrhD5CowgNr
         tbPSZJj5+ZNQ2sIxn2JAAFMyylIjD4ex7KyvI1XnLWZ0m5177cC3GFax0EnTbaNo0nsx
         XfHBV3SjeZbV3BD172sx/YOQlNqaxYRkNvVehSbwok6VHq5jAK/ublM2XW1eTuDK8i2T
         lhXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIvdBoIhdzPPn8UArCAZ/RZ3adPEwU+oH7BfwD5Z9PtlRlxIzIaMKaQ7bh2yS/M0K0F4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+bzw/io/2fwgPtF5MMoGOBPvVrcCtdJSNbWa4UEbacG3ZKs8
	jD+B3SmwSMy+G1BsQPLazyShIsAUoOHxS2Ol9cJYVBH/11ktKRSMi95Qr3Q5yKOpYZolVf37ldi
	S0CTk6Khc4U9fS3Md73/dxyTAK7IJxwtA0/3HHM4YnSEh+PsfLgLWrQ==
X-Gm-Gg: ASbGnctbNNDumJpaYh5jBz9ezJJ3WEbjw84Vds11Ddj5LPS5Zm6J9fabuKRTBs+tpBG
	I+Ec2+FcSCZM6gbOgLw1WkUr0Pu0O3DSvubYOu35lUj1ER9UJD+Qtmn+2ZQPzZI1w5aJ9JRuWmk
	C4tturv+tjpJFJkrgzjs/KIdKvrS040ncq2sQ2T0SwK438WADkDqvzE2T/bIgswYOqifXoYEJ32
	NBxxrv4Vh3BeFI1Q4m1OlOYL6XsVD4LSwF7mqYRizI04TWKu88zKSbJCE6Ri996elaSyFweSsnP
	DNUtPfXZfIHgMIQw4yCvsZVj3AD7JUeICR3e9kZXuHde/H0ebFKk7JvS61TwwlJCD5SmkCA=
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr108070865e9.18.1756910603001;
        Wed, 03 Sep 2025 07:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF69gAChxFwcluBRYHF0+z51FCVtEVCadQL0dqsUkUmSsfKqXS/cjr5c0WBKbduX2OT6RRehw==
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr108070485e9.18.1756910602534;
        Wed, 03 Sep 2025 07:43:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b72c55c1bsm342903985e9.10.2025.09.03.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:43:21 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:43:19 +0200
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
Subject: Re: [PATCH 03/16] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aLhUB86NwnaQ8bMf@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-4-arighi@nvidia.com>

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
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
>  kernel/sched/debug.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index dbe2aee8628ce..e71f6618c1a6a 100644
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
> @@ -376,7 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		if (rq->cfs.h_nr_queued) {
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
>  			update_rq_clock(rq);
>  			dl_server_stop(&rq->fair_server);
>  		}

I believe this chunk will unfortunately conflict with bb4700adc3ab
("sched/deadline: Always stop dl-server before changing parameters"),
but it should be an easy fix. :)

Thanks,
Juri


