Return-Path: <bpf+bounces-76960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ADECCA9BD
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 08:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE59D307A9C4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 07:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA929E0E7;
	Thu, 18 Dec 2025 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLs2Ee5q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kD6QzC6G"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247E2877C3
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042063; cv=none; b=r3T3mkC/uBi57qgGHiHU7pvApxyBEMojK/18e/NVVJrZ6OzwRLaFoq//U0p6/8/sPzcFqmJqJ68mElvPjhG/NACSN3MZatP6uWjq+jtl3iIFvY55zefyogDseHI2UPwpbIslNzeMB1tRs+hbbfWojdzLpNctblFvPtqIZ6Xh1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042063; c=relaxed/simple;
	bh=pdMUtduMXCj5whENGA9N7DnLbY+JEMVMPlaas2KdqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+ZzFmbouVwgu4aWRGaaiTpipSEfnAb4bGbEBbHVEhb2EPShHCgHW1Hmp7h4RfPuZvG6Rh8JdlF/GPT73Ld9U0gEHGmM5lOomoD5xKVjE05n58sAXdr/fcmh8ailxiS1NESHYl2ynDzVivnEMFEOQkj6OmJMaIdjBonce/Kn5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLs2Ee5q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kD6QzC6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766042060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
	b=aLs2Ee5qVfUHNo+cKCdt5ERD7tpHxLjPW35gTUDGsty01cM7qxlNwMtbFWB9kYYHEOWRPR
	34czcntWkXseOisZeisTZRaOFc/bvc4ftrK1G0NtPpLFPnisK3peU4QGL6Mo12xvsuXlDJ
	B/ejXaA+pYFOZsYNgJYu0BoX5xJjVHM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-KLi16BCeOfKHM6Sp6M0ORA-1; Thu, 18 Dec 2025 02:14:18 -0500
X-MC-Unique: KLi16BCeOfKHM6Sp6M0ORA-1
X-Mimecast-MFC-AGG-ID: KLi16BCeOfKHM6Sp6M0ORA_1766042057
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f5dcd4d3so155132f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 23:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766042056; x=1766646856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
        b=kD6QzC6GiQmYrdH4YxH7W2Gj77eHBrbcWvGvJrulBJpYs+ya+7f8fIv2uGgQ/O0B8m
         Fz5DMDxstvMDHrBdM9GMU7QwEwy3bf5WMX+/P6PwdEyqeYwxl/GWkR07iF9RrfU0o7lB
         3MPWhG8+PXQ7wScmUJ4OdtSas1SCuLGgmlcBJmnZnOVGOFO61pjbyxw0EKpdH8OQPT0E
         cR+jwyalByW5W7wGf55tLF07tR3HUrgxRmANRCgN9sr/UxY3IqtHidQgJLpgKs59WYJF
         b7aDvWN3u+6BOPkN/pKUbKUzmhkFmb2XRgZNpQFjxFFt27qUHL2OByawW7JVhtbUUAG+
         l33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042056; x=1766646856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNBsiLM1lI5WSv0gDo/xxnKGXTG+8RkXyoth8Hg52dk=;
        b=kZkHq1HEgvk6vv5PASx/b/cA+MC+dtiu+6hmrsB/DGsLE4jVgH2nHq1cqNtY5M++YX
         qOlunm9pdJbnmv00y5/EuhRTjGNqJYuqUPKXkOnXB0m+sdQKaF4lyBvaDhbuEC/zqRKK
         /Gyj8Vfvk2HG0OQOn/UPuDsygOgHfqIlkLp+5L81Fv1+s87Hm/+J2QiyJTz7diUn1TWe
         suGnRsTWGZ+FVafgte9UxrswhLcWTFR6xCsyOvUQd2q6tisCeEiVpQln47k37534d0i8
         f0dX7YlRJwZfVlBgPnn99uPZ0jEjx3MVCRqL/jrXoecVbJgaj4Jj5z+HgQt+7DCaWZDv
         aByg==
X-Forwarded-Encrypted: i=1; AJvYcCVIpthDjhL8RuuZoF76p2n//hSn86z6T1Gmy87U7bNWAhzfF7xc+1LsAVum4yivvyzsyZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxjm69TiaIhBVuBLpj1jAmYscxW5jhbB3byK1B0mYTwNsXNAPx
	8tDwzUuZNhpOORCWMOn9NfBFRri99yifvJfdP6ijS38psXGB7LwrYEj6hxyO+phjBPGC2IeDWNB
	AO9/2KrrbPZnL4Mqq3bS/x9sb3Cchp6EyafQaqibsCwuOaOQZH+IJ3obYyV+x8Q==
X-Gm-Gg: AY/fxX44h6qeY/GRL++/kf/XBSbLYVwe96W/Lp2Mqr/an1GMIJghvCvTcUCCTjIi5cD
	qKB6wjBnUwTy7sGGTpie+iQ6XFpeJh/yytv351ftNwbBTxWuRTbAilMe8mAXeQnRr0e9Y3v0Z/2
	Ejw2t5Xfg9PvYM8Z2XfrM7dGsEtJ8lBrvROojm8Pprzf+ngxB1i6GUtkqBgel+rjSqVKHeTykzQ
	g5S3YBXJAPn4V8me9VXb6HZLQKlOFRi0ZhKVNm1RNW1NP8vLRaMn6byxiXBP5CeeiUCoGi7o4Ao
	c4BGztwb/n3OsOyeSiH5rx6j5ZywBr7z+ubeif4oP1CmDZ1IAHgNYT6BpWhQpeKyXg0iWLNHsL/
	CLkHYRnuhg/f2HJZtIgEpmairZwDlQ9Z5xqE5sXLH
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr2026731f8f.18.1766042056140;
        Wed, 17 Dec 2025 23:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmwvfPARt5/oktdF01vTTh+pbj0DvIQNLkJ0QsqlEvJKz7q81ZhZQ2a/z1plKZxslmFO/O2g==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr2026688f8f.18.1766042055684;
        Wed, 17 Dec 2025 23:14:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fe27sm3248198f8f.12.2025.12.17.23.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:14:15 -0800 (PST)
Date: Thu, 18 Dec 2025 08:14:13 +0100
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
Subject: Re: [PATCH v2 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aUOpxVIQieTOMifV@jlelli-thinkpadt14gen4.remote.csb>
References: <20251217093923.1556187-1-arighi@nvidia.com>
 <20251217093923.1556187-5-arighi@nvidia.com>
 <aULQ7kPm-RqHWGDL@jlelli-thinkpadt14gen4.remote.csb>
 <aUMmuRI-ZljfDuh9@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUMmuRI-ZljfDuh9@gpd4>

Hi!

On 17/12/25 22:55, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also included later to confirm that both DL servers are
> functioning correctly:
> 
>  # ./runner -t rt_stall
>  ===== START =====
>  TEST: rt_stall
>  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
>  OUTPUT:
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1511) is 0.250000 seconds
>  # Runtime of RT task (PID 1512) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 1 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1514) is 0.250000 seconds
>  # Runtime of RT task (PID 1515) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 2 PASS: EXT task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of FAIR task (PID 1517) is 0.250000 seconds
>  # Runtime of RT task (PID 1518) is 4.750000 seconds
>  # FAIR task got 5.00% of total runtime
>  ok 3 PASS: FAIR task got more than 4.00% of runtime
>  TAP version 13
>  1..1
>  # Runtime of EXT task (PID 1521) is 0.250000 seconds
>  # Runtime of RT task (PID 1522) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 4 PASS: EXT task got more than 4.00% of runtime
>  ok 1 rt_stall #
>  =====  END  =====
> 
> v5: - do not restart the EXT server on switch_class() (Juri Lelli)
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

This new version looks good to me, thanks!

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


