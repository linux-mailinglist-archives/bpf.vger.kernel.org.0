Return-Path: <bpf+bounces-58444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68FABAA8F
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019A41B61216
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7A202C21;
	Sat, 17 May 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nRCQ87GH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6351FECB4
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747490781; cv=none; b=S2UHSmNcxDLeJmgempey0LkdV6X9BcX93MpL0PAUittFGZ7OX+nwQc/y6O3L6L5UGKSPL8YJ+7n194JmrNXVeSF+am4ALG0Bnga6Bk+ocvTdpw+5eQji4WeRXh2gukR67xBZLvBG94u1vVGDk+fjUUAPZ0NaCIl5TLtcoU7r9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747490781; c=relaxed/simple;
	bh=V06g8hrNK3Ss5baC8W9lAcyYGrXvMeywgXb8MDbYNUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojsh2FqMaCxFTmGAkhNdc1rfTktINdxZTrvRdZ/wnoMel7GKJLn0wcCcHP83z8qwIy55U+RGeEBRR/HiOQC4cYkU0HyItkqNlgs8fTn3eZTi9N08OdkWNuLUBaZUKCrwtI0pW+erwa5o/xV8SUXkqw/Gzp0gHs0JE/iYq3+rMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nRCQ87GH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c597760323so336028385a.3
        for <bpf@vger.kernel.org>; Sat, 17 May 2025 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747490778; x=1748095578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhvXy1V/6+eGgB5qAljkspgVToq5uQ0qNnLt1dtTF8E=;
        b=nRCQ87GHOKm//mZw3TDNdzJAdz2DpVO9AGACZqar0x2M9+Fgyhd5G5PF2Kj8c6jlO3
         z5xLWE/9s9fjq7jBbvnnri04A3gz3yjExq+0PW+zrqZtLUR095Ko96yp6PR1itF/kXMe
         ThW2Q1ctu/9YVoq6HP30Qw1L7v5cSEoi/VGS+lv4HQD1gmd0RMRMoWqy6gZ+FpmK9mB9
         5mXmgm3iZsORGkAfHfg0E0pnVUyvwFzbms3y3QqkMpdoxSCddCJT3G3OVtLREDZf+q0U
         J7e42VqnElTiwNKhnNkqBSCIgkuYEYxQqqG2E0i5mKUU4kDTzlreW6CTUFyclbhyAYBP
         pWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747490778; x=1748095578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhvXy1V/6+eGgB5qAljkspgVToq5uQ0qNnLt1dtTF8E=;
        b=tZZZ//Z9eFPQvQd2Qj049bAgygSu4XkLA1/bjPba6/+vebR09YUJ1fpUuVFGNzzw+F
         7xAKANKKWaa/KYtfNt84UdyTGBJpPlwKYHQALXI6BBK2CKv9dFJxr0gpRSle0PadxglC
         3VSdFPhXe9CBEnKJQuUSorgSEh7RSFt9IgR+2rJLTPzYm9seiQYPdfXK7AFjMylr/UZl
         Q234G/begGAwsubGMIZS7tZAF5/NPB7RHphOCKrb41B3An7N52tdOkjDMEcQCQDKMJI3
         +CrRUXhhKb1zM1oFEeFXa/ln6/E5pWQHzIZOferP1N7Q8KprGrJQhN1RTHxTxry8wHJx
         JdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUCAaoWWvV/HQYrB7FpBB5rTnh2JedKlI1siZoKH6/B1xDKIDJ6hY+a5FtWYJPgTt0Kww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAb2VCUt50Q2XNX1vO7UbJi5V004QrqzpMYCUPMyXsTMrmOEcS
	cgyOt0STYDsdR/t1vP2rsx3gAMht3szftNtuz6xj9rdRSLB89v3L+QjtfqFiDQUwma8=
X-Gm-Gg: ASbGncu4yODn1GG/7xZBNm6JYKeb1XbWI4lL5y4INNzm8YqiDrvV9O12xyWNpLEcTPu
	lesTHom3DuTIubPT6QYOWi4bJ2KwaiDUPdCJlUEvvZ91Flh2x+jCxzabb9iTtLuvN3EyuL9T6QJ
	j9lxrWMAyP2WgzAiPi1RIvYExeU0V9dGVf35+HW5r4SwuMwrQsBd/NjWXNHMChbyVV741fe0cRm
	dhW/UpjfWKajDN67khO41XhSMcdVFtrSdPy1nZjcLn9WrEpKOmJlQn8KMg3JpmN2MPO8NtxFY4S
	e4ktBIdbkc4g46J58SS3oA28jmNjV19u0Dnwx1DI+ysgb6STRg==
X-Google-Smtp-Source: AGHT+IGK6eD7aI2Err8GHK9YsHuDYpVSIxGRVIvR72HXl/w/7xQC5Grfki+phpp5KFktfiO8EpqdXQ==
X-Received: by 2002:a05:620a:430d:b0:7c5:5d4b:e62f with SMTP id af79cd13be357-7cd46779caamr1017827985a.43.1747490778049;
        Sat, 17 May 2025 07:06:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468e5a77sm257916385a.116.2025.05.17.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 07:06:17 -0700 (PDT)
Date: Sat, 17 May 2025 10:06:13 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v3 1/5] memcg: disable kmem charging in nmi for
 unsupported arch
Message-ID: <20250517140613.GB104729@cmpxchg.org>
References: <20250516183231.1615590-1-shakeel.butt@linux.dev>
 <20250516183231.1615590-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516183231.1615590-2-shakeel.butt@linux.dev>

On Fri, May 16, 2025 at 11:32:27AM -0700, Shakeel Butt wrote:
> The memcg accounting and stats uses this_cpu* and atomic* ops. There are
> archs which define CONFIG_HAVE_NMI but does not define
> CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, so
> memcg accounting for such archs in nmi context is not possible to
> support. Let's just disable memcg accounting in nmi context for such
> archs.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> Changes since v2:
> - reorder the in_nmi() check as suggested by Vlastimil
> 
>  include/linux/memcontrol.h |  5 +++++
>  mm/memcontrol.c            | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index f7848f73f41c..53920528821f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -62,6 +62,11 @@ struct mem_cgroup_reclaim_cookie {
>  
>  #ifdef CONFIG_MEMCG
>  
> +#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
> +	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)

                                             CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG?

> +#define MEMCG_SUPPORTS_NMI_CHARGING
> +#endif

Since it's derived from config symbols, it's better to make this an
internal symbol as well. Something like:

	config MEMCG_NMI_UNSAFE
		bool
		depends on HAVE_NMI
		depends on !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !ARCH_HAVE_NMI_SAFE_CMPXCHG

>  #define MEM_CGROUP_ID_SHIFT	16
>  
>  struct mem_cgroup_id {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e17b698f6243..0f182e4a9da0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2647,11 +2647,26 @@ static struct obj_cgroup *current_objcg_update(void)
>  	return objcg;
>  }
>  
> +#ifdef MEMCG_SUPPORTS_NMI_CHARGING
> +static inline bool nmi_charging_allowed(void)
> +{
> +	return true;
> +}
> +#else
> +static inline bool nmi_charging_allowed(void)
> +{
> +	return false;
> +}
> +#endif

...drop these...

> +
>  __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  {
>  	struct mem_cgroup *memcg;
>  	struct obj_cgroup *objcg;
>  
> +	if (!nmi_charging_allowed() && in_nmi())
> +		return NULL;

..and finally do

	if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE && in_nmi())
		return NULL;

here.

