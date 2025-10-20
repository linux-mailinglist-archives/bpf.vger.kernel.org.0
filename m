Return-Path: <bpf+bounces-71384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 724EFBF04FC
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D918A0366
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9523D290;
	Mon, 20 Oct 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diHCGmFr"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5F239E79
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953800; cv=none; b=bm8XOPQOApiSYuUZynjkkmgft1uUmY8mce00S2xtMDBnRO35ksNUy9SFHpH0ptgpGzUIEnr9qW6N7QGF43rMUw6ikjihP+fLCFtmMi5rX8XV+BIY//0RtMWzCTuYPHZIaVSSeeKH6utWGsSdti7nWLY9WWUosfAcsYM2wdCLPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953800; c=relaxed/simple;
	bh=L88CURN76sT3+kKjYcMn64mems4KIaIBpiqCE7sLYgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkcYNaYuBzycF94ZHERPBIellk3nxPKu2QeWMDwAf94M0FOAckTXfFRqNuQanzUGRrTccfzaHbS+EvcNr9wMktCrMXTFUhZ8aWoWpAWckKQU/DssyiHMTrXjeuxYAQ+drGavq1yn/NeCfBtrOILGtyWo+3M6Z/2lPmApaFucxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diHCGmFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760953797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFTTrhJcTtAwy2zqRcI97c2G9J1jPFu8DQY9tZIK604=;
	b=diHCGmFrFi90oKz2i9vdPD5ZZ6Mf9SPMhiRmgZrOmszySw/IfXmXyJa2lYzJ7UTzpS4sMh
	FXMUtNS43s25qmSLa3jogjnVKPGaF22NBFP9pqGqrnGI1BahD61XCO6dhjdoeJWRPBvqyc
	XEnLAQXK5+0FmdaGhcMFCxr7GUDUodo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-xDyie532NsCRoszCp3wmjw-1; Mon, 20 Oct 2025 05:49:55 -0400
X-MC-Unique: xDyie532NsCRoszCp3wmjw-1
X-Mimecast-MFC-AGG-ID: xDyie532NsCRoszCp3wmjw_1760953794
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4270848ceffso4521063f8f.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953794; x=1761558594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFTTrhJcTtAwy2zqRcI97c2G9J1jPFu8DQY9tZIK604=;
        b=KoWCzF+kticEvteLL2qTuOJbue+GnNM/1Zggqz86K+pzI9hWx52qz0I3/JtTU5S2bW
         a6q8nTZwpFl0LLf1CCZm4lWMWlVX/gTYrlYcKyM7dPgW+Fy/e7OVbUyGD15ImB+9Y78a
         u7jvtOCceTtpyeb+knd1LT46UOEaexorGlZD4IZ7aOHc30VsLBrbsXufgdWuWa2QS6k7
         eoy8oj85Ba+tNI3jwUOLzbDJFtOeUNRCD/B3B6m0KQJ1aQHAgOfh+y1LkeXVcUXO2B+C
         WXJO0xL/nR5epEqbPHupZh/uMg/ZGZpIDk1R+RcGxChvrzy1WnGHk/MkrN129mp+nhmq
         8sdg==
X-Forwarded-Encrypted: i=1; AJvYcCWAD0AP+XBa9tsLUI3w6Xgs8+LPelBEP+wVe90qYI6RgD0nipTsj68QAGKxJ2G5fiDM2m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWAwcCHiVBsKVngraY52Scw9Y8jlGzO6F2/myrcsMdcT1G52x
	FYPjHeWCc8aIlfa9oiU2BrY7D+9VtaXcckcP0ZNlE84C0x7al8D2OVXBeOFVGCrL0FtimmUlaJH
	RshqV1mRgjq/qRcDTiK3me/AkcTp6hmK8W/LPt1K6p8EdZpDh3gtAzQ==
X-Gm-Gg: ASbGncvWNzYNJZM8cL8PSBB2OE/P0/1qdYqCqpPwfrTYmHxMxER4UcCiLG+jL22W8jt
	jue5fwAczBFPPLXfFPlNVU/ZXz/kyVX1hMCElr9q4fOaiFZsQPH4IEk7gr01q7DFUYU6jtHISMQ
	7J7zj896Sgoj4+PuYnRqiWyDLCbqb4Qr2zPY3bIsqgzLetqXiyZ7dOW1P7V+8oJoLq8pw893ldf
	QisGofQY+A+cFx9ChnPxx7XbjpZeTVxw8qv4+Ea8SK7KHY2gcvU6AbqlDC7QksSn+C+zO1diBGA
	0NqNA+jc0FgzzpQJJKCS+E559Zr4uceCw3tTP3eGEbKB+t6NS/ks3vQ7O5Abht1pzN+B/2sDPfZ
	GOG8UTXi1PN80JI0h/axFHaWUQ7pcUfk=
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id ffacd0b85a97d-42704daed04mr9407334f8f.38.1760953794301;
        Mon, 20 Oct 2025 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEircX9r4vwBahUAWz08Ch5Vp4KLieMSMxL6ClC8S+P82LJBqd/Fmi99o4l9qj8yYvXucqwnw==
X-Received: by 2002:a05:6000:240c:b0:426:ee84:25a1 with SMTP id ffacd0b85a97d-42704daed04mr9407306f8f.38.1760953793898;
        Mon, 20 Oct 2025 02:49:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm14899561f8f.29.2025.10.20.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:49:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:49:51 +0200
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
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-5-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Hotplugged CPUs coming online do an enqueue but are not a part of any
> root domain containing cpu_active() CPUs. So in this case, don't mess
> with accounting and we can retry later. Without this patch, we see
> crashes with sched_ext selftest's hotplug test due to divide by zero.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
>  
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	/*
> +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> +	 * with accounting and we can retry later.

Later when? It seems a little vague. :)

Thanks,
Juri


