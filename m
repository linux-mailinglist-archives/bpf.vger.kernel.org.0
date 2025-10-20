Return-Path: <bpf+bounces-71391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082DBF14D7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECC174F53C7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0D2FB987;
	Mon, 20 Oct 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htf+Jfua"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF32354AF2
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964360; cv=none; b=NTyw7LGSGT6b1X+pY+kLBoBP6atFc+kn7EBYXtr5ao6OkBdTwlwq+hrpKp+L8t88waYE6ix3WT9SqUs15U1oJe1ifekU1ieM4vXlvAy70dKEFyW7WJc7Bx5HdMOEJ9pRWAEtP0c5XHvcHJLju3ikIILOOeUH4YSKgrJPeqBd+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964360; c=relaxed/simple;
	bh=pP3A5lVFp+TWJlDAr+FZUeR4ot4uHjyyYG0uyvoNEmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go8Scb1ROE8VtNTyYgUhD02pqlFsDy3XxGLOBsCVavm9L/iiAzcWXIU7cBUFkRzhnhm4wbAO42VMINiFxQDYrf/LXIdmqkWc20/vNHJ0+IDTo2776pDBgWcEeq+kwrwCYBjGLIm3W6lfmehhpeUAgJlN62Q5klcGq2hqIZkiLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htf+Jfua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760964357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8arYXBG+DW3SodLFxrTiKZROIPvWVTu4xbqeXb0NwI=;
	b=htf+JfuaQCtihPWdLM2F62dIw9LRfDkSkDL/HHwQ/llqmbhuG2h4OcKT0/tLKRoZCqKKii
	WxKjKCB8mA83PGfLyqmvnGqKqQPirPCY8Q8UY2bjL0KYygV+q5JpSkI8A8QtMKNVYWVSYd
	wha21teRc2k+6++zV66ixsIMoEjSGbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-ZaQEtGNYMECjHw7FCgkNsA-1; Mon, 20 Oct 2025 08:45:55 -0400
X-MC-Unique: ZaQEtGNYMECjHw7FCgkNsA-1
X-Mimecast-MFC-AGG-ID: ZaQEtGNYMECjHw7FCgkNsA_1760964355
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-427091d7f2fso961828f8f.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964354; x=1761569154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8arYXBG+DW3SodLFxrTiKZROIPvWVTu4xbqeXb0NwI=;
        b=smX5S1fr1iYA5QHpGkIm0M5PrROtizlqPQwBg8tP/dHRjfkG3reD00sQPWLfQxpICp
         wLaKoquYqMVQ9Bvea8YkSf4fKzaU2BxTpGx8qEy2mFTTd0+qP4cUTJVShQM8FLfJWmEy
         ZniCcKMwQa5nFi6s04a5pEWIdRRfWqpIgmXT3ZXwxYu1LfLBi4Mzad7aRrQ0ylDqon7D
         99oj4uu5VdxADS8ya71jcWReJhsDaz1s6c5LYObYfitePR+6OMvkoGnVJltPdvx7uYO3
         pAqtGsiboaSnsSWgNpHUvWjjTxKQmrUH2RnWPfmNgox8WujoWTMBnGs3qwrDGXW8GyWQ
         5C6A==
X-Forwarded-Encrypted: i=1; AJvYcCXXSGODA5xvoyliGlrXcohnJYEgybCZCWp3YAdjohlV7g6+9wZ1NnWFlM1QCtRex8hEqNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TXZa3XLmchMMiEu+YFcgHaCq720+7C0kgfk3yvgneMQPiLlo
	B+rBpx12OWtkesuTlnZYa9q8k/bIUXwT+3PF4ST+HX5Voj2lUCamfCBTotEE7/ZWz/vJTEOHpZg
	WjII12DRqZBiIzixS+W33o5ol+0ZeBQUIOZ0Y5DxG91O2cwh/AxkERA==
X-Gm-Gg: ASbGnctX1ANAYOGsiI0h0mYtMFfHObhn5uXM2V2mRodD7WhCtijh0GHuFOeecGKm44i
	VGTR7lVBy8xePiM69+jOz7gLoI7bmXw8a4qO1XvhNGwNm8YGdgLHFkneZHiythCcXzZzGZqlJWZ
	QRnM2OmHkm/hIK+2BF8X/ZL9hUrsc/Brr+knwuFtuAsPvHne6eEOeFhuiU2NMKpdbtPltenULmV
	qrkaL8jXF6T5zywhmFIFnvTMlgoOk9fz7kdBAlqM8jkgT5MMLNTw1pBP+DWfO0/MCW/T55SgJKX
	gR+fTmKvdW31Xqsi2U9nl+2GnGl2UYJndNGHRYq/Ja3XyIs7shGrF2a5hL8YnazgrqWAIGxB0QE
	ao/MHgWMqhf01AWTrqract/WdYegqvA==
X-Received: by 2002:a05:6000:2c08:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4281dcb253emr5610037f8f.47.1760964354440;
        Mon, 20 Oct 2025 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9O5gCxZwTvWdqs5vD1NFCOQQ5mTNsM7VkdHL37Gjdb+1cITrv3BccUNrbtLnGONIEq4LZcA==
X-Received: by 2002:a05:6000:2c08:b0:428:1dca:ffdc with SMTP id ffacd0b85a97d-4281dcb253emr5610016f8f.47.1760964353963;
        Mon, 20 Oct 2025 05:45:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a96asm15201768f8f.31.2025.10.20.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:45:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:45:50 +0200
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
Subject: Re: [PATCH 07/14] sched/debug: Add support to change sched_ext
 server params
Message-ID: <aPYu_obVO4QjbqUL@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-8-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> When a sched_ext server is loaded, tasks in CFS are converted to run in
> sched_ext class. Add support to modify the ext server parameters similar
> to how the fair server parameters are modified.
> 
> Re-use common code between ext and fair servers as needed.
> 
> [ arighi: Use dl_se->dl_server to determine if dl_se is a DL server, as
>           suggested by PeterZ. ]
> 
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---

...

> @@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		}
>  
>  		if (runtime > period ||
> -		    period > fair_server_period_max ||
> -		    period < fair_server_period_min) {
> +		    period > dl_server_period_max ||
> +		    period < dl_server_period_min) {
>  			return  -EINVAL;
>  		}
>  
> -		is_active = dl_server_active(&rq->fair_server);
> +		is_active = dl_server_active(dl_se);
>  		if (is_active) {
>  			update_rq_clock(rq);
> -			dl_server_stop(&rq->fair_server);
> +			dl_server_stop(dl_se);
>  		}
>  
> -		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> +		retval = dl_server_apply_params(dl_se, runtime, period, 0);
>  
>  		if (!runtime)
> -			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> -					cpu_of(rq));
> +			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
> +					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));

Guess this might get convoluted if are ever going to add an additional
dl-server, but I fail to see that happening atm (to service what?).

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


