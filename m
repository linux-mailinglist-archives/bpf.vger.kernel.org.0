Return-Path: <bpf+bounces-40529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A7989866
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45136283002
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630217E472;
	Sun, 29 Sep 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq5qtoMw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32242ABE;
	Sun, 29 Sep 2024 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727652170; cv=none; b=BbLX5Vhd6ME/bQI8Vmjv9EpdjdmjZq+wZ75TUy3vIrDAQqDr9amOVGjomJcAN7LMC7rkCqMcdDG6OTEAcVjULKvT1id/mxBWBPnF+JkK1axU67I1mrVqtQMddenO332addtPM4KluIn7KngMTXbT+vEe7aBacRYDc9HiSmlPGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727652170; c=relaxed/simple;
	bh=KtAK4NDo8xMvG0jrUzeRdw4q2ZXJd2FLkSW2T07lLto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx/UJwePTm89iK+CNggAddr5o1yaS82q6K1//P9yxZSzbjVCKGqzsAppiE4hk3H7AxdKYtxFBSC154SO6aUW9dTrOMn1/nwfwE0W/ZOiPvssoW9GJvK6cjlLF4N/LqWzfeQBGVadX2I39pga5K3BZBclzWIk1Q+XgeGgS6qZ3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq5qtoMw; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9ae8fc076so429115985a.2;
        Sun, 29 Sep 2024 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727652167; x=1728256967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FaArng7VYzWeHBXPveklsuS5pq3RVdw0NUIJv/MENw=;
        b=aq5qtoMwXA+aCT5c7sho6oWwBGLJcBQUQdt98sohLi7qz1SAlNXx/DnswDw5vY3Kfw
         zhaGubbH+PtewgwJyRyvtX3Ii9iH+U70NkR+po5Ucg2/BgQ4Y3Ch1jDcmvbSFV0Qu+iW
         5YHl2DraBRs5r1z9YvJ9kNOkwC8RAjHS3OnOJR2D4BuysFSbb62JW1TUFVyJCUAvwYDl
         1OtNZIMdz1AG4ls6U5+rwq3nq13K/PlbqZIuSxtJV3AuLtDfbuGc3rjPkDhkLoon4Vyd
         KcvoW2CiI3YTAqIJbLVUQa7ZdgXpuWYdktqtScE0myy+NQsjqfZI0OSZ/5JofRon7de4
         wAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727652167; x=1728256967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FaArng7VYzWeHBXPveklsuS5pq3RVdw0NUIJv/MENw=;
        b=eb5ov93H/Z/RmtZYSKkI9zVBtBYpHRKn73rciK/v/DCtSd19p0GpYe80n3qwTMVCnL
         bDWzKr0omu7LmH/jID59lF2ZBHYhSTKgdDg3JUNH9AwvJR5QDdI+M/Bk3UeXw7H5D0XH
         Em0PglDT9hlRlhWwT9TH+wemzZwe3/zdKT7Cc6Qj515Xr63SsdIml3UO1Ua+tjD5eMNm
         yt5/tw6EYie8Mo9HancttcEIcP4t4IqtdRS+PP/Fesg5XO/nEQCoGPjZmXskDZSoO4QD
         ItLkQiP2Im5ZOf1JW7wQuVUgg33XEGYIt2ZUQBHOuCZ7JcsFWXddHoQS809hMO3Qlg72
         ChHg==
X-Forwarded-Encrypted: i=1; AJvYcCXySQ30FjkeGaBqCXXGPRhELH9B5elM8H2gbd8i/eVfOI8F/zKGNPDMQKSpl3v9jPHeIng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9dPLbewfkC5yGe0Es/VJ5vqqZuivoH7tCwjdeKeSnm1kLNI2
	HB40j044CZFT0+ypuHRhKAuFDznsgrCjE+AelbjaZgjIndUD+Aoz
X-Google-Smtp-Source: AGHT+IHOGWz+4Wx6JFbzdVjqfCQuUyRE2k404+ROUhxcgv5f0phuKB15wY+zWwTihrmVX0kcYpSTvQ==
X-Received: by 2002:a05:620a:460e:b0:7a9:af5b:6921 with SMTP id af79cd13be357-7ae378301ecmr1773014685a.21.1727652167375;
        Sun, 29 Sep 2024 16:22:47 -0700 (PDT)
Received: from l1441l (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783f7d8sm362585285a.99.2024.09.29.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 16:22:46 -0700 (PDT)
Date: Sun, 29 Sep 2024 19:23:33 -0400
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: Yipeng Zou <zouyipeng@huawei.com>
Cc: linux-pm@vger.kernel.org, bpf@vger.kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	liaochang1@huawei.com
Subject: Re: [RFC PATCH 0/2] cpufreq_ext: Introduce cpufreq ext governor
Message-ID: <adggcxqwq5iux6vtd2rfdsq3qubwpt5wun2cs3l5a5e5qnjj4b@t5vdte2g4pdk>
References: <20240927101342.3240263-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927101342.3240263-1-zouyipeng@huawei.com>

On Fri, Sep 27, 2024 at 06:13:40PM +0800, Yipeng Zou wrote:
> Hi everyone,
> 
> I am currently working on a patch for a CPU frequency governor based on
> BPF, which can use BPF to customize and implement various frequency
> scaling strategies.
> 
> If you have any feedback or suggestions, please do let me know.
> 
> Motivation
> ----------
> 
> 1. Customization
> 
> Existing cpufreq governors in the kernel are designed for general
> scenarios, which may not always be optimal for specific or specialized
> workloads.
> 
> The userspace governor allows direct control over cpufreq, but users
> often require guidance from the kernel to achieve the desired frequency.
> 
> Cpufreq_ext aims to address this by providing a customizable framework that
> can be tailored to the unique needs of different systems and applications.
> 
> While cpufreq governors can be implemented within a kernel module,
> maintaining a ko tailored for specific scenarios can be challenging.
> The complexity and overhead associated with kernel modules make it
> difficult to quickly adapt and deploy custom frequency scaling strategies.
> 
> Cpufreq_ext leverages BPF to offer a more lightweight and flexible approach
> to implementing customized strategies, allowing for easier maintenance and
> deployment.
> 
> 2. Integration with sched_ext:
> 
> sched_ext is a scheduler class whose behavior can be defined by a set of
> BPF programs - the BPF scheduler.
> 
> Look for more about sched_ext in [1]:
> 
> 	[1] https://www.kernel.org/doc/html/next/scheduler/sched-ext.html
> 
> The interaction between CPU frequency scaling and task scheduling is
> critical for performance.
> 
> cpufreq_ext can work with sched_ext to ensure that both scheduling
> decisions and frequency adjustments are made in a coordinated manner,
> optimizing system responsiveness and power consumption.

Hi Yipeng, I prototyped something really similar earlier this year and
the conclusion I came to was that a governor might not be the right
abstraction for struct_ops. One issue is that depending on the frequency
driver being used it may have it governor implmentation included (ex:
intel_pstate). For sched_ext there is already a kfunc
(scx_bpf_cpuperf_set) which is a calls into cpufreq_update_util and that
has been working well so far.

> Overview
> --------
> 
> The cpufreq ext is a BPF based cpufreq governor, we can customize
> cpufreq governor in BPF program.
> 
> CPUFreq ext works as common cpufreq governor with cpufreq policy.
> 
> 		   --------------------------
> 		  |        BPF governor      |
> 		   --------------------------
> 			       |
> 			       v
> 			  BPF Register
> 			       |
> 			       v
> 	    --------------------------------------
> 	   |             CPUFreq ext              |
> 	    --------------------------------------
> 	      ^                ^               ^
> 	      |                |               |
> 	   ---------       ---------       ---------
> 	  | policy0 | ... | policy1 | ... | policyn |
> 	   ---------       ---------       ---------
> 
> We can register serval function hooks to cpufreq ext by BPF Struct OPS.
> 
> The first patch define a dbs_governor, and it's works like other
> governor.
> 
> The second patch gives a sample how to use it, implement one
> typical cpufreq governor, switch to max cpufreq when VIP task
> is running on target cpu.
> 
> Detail
> ------
> 
> The cpufreq ext use bpf_struct_ops to register serval function hooks.
> 
> 	struct cpufreq_governor_ext_ops {
> 		...
> 	}
> 
> Cpufreq_governor_ext_ops defines all the functions that BPF programs can
> implement customly.
> 
> If you need to add a custom function, you only need to define it in this
> struct.
> 
> At the moment we have defined the basic functions.
> 
> 1. unsigned long (*get_next_freq)(struct cpufreq_policy *policy)
> 
> 	Make decision how to adjust cpufreq here.
> 	The return value represents the CPU frequency that will be
> 	updated.
> 
> 2. unsigned int (*get_sampling_rate)(struct cpufreq_policy *policy)
> 
> 	Make decision how to adjust sampling_rate here.
> 	The return value represents the governor samplint rate that
> 	will be updated.
> 

Why does the governor need a sampling rate? Could this be done with a
bpf timer instead?

> 3. unsigned int (*init)(void)
> 
> 	BPF governor init callback, return 0 means success.
> 
> 4. void (*exit)(void)
> 
> 	BPF governor exit callback.
> 
> 5. char name[CPUFREQ_EXT_NAME_LEN]
> 
> 	BPF governor name.
> 
I'm guessing it would be useful to have the governor dispatch on almost
all the governor methods. IIRC I had something like:

	int	(*start)(struct cpufreq_policy *policy);
	void	(*stop)(struct cpufreq_policy *policy);
	void	(*limits)(struct cpufreq_policy *policy);
	int	(*store_setspeed)(struct cpufreq_policy *policy,
				  unsigned int freq);

> The cpufreq_ext also add sysfs interface which refer to governor status.
> 
> 1. ext/stat attribute:
> 
> 	Access to current BPF governor status.
> 
> 	# cat /sys/devices/system/cpu/cpufreq/ext/stat
> 	Stat: CPUFREQ_EXT_INIT
> 	BPF governor: performance
> 
> There are number of constraints on the cpufreq_ext:
> 
> 1. Only one ext governor can be registered at a time.
> 
> 2. By default, it operates as a performance governor when no BPF
>    governor is registered.
> 
> 3. The cpufreq_ext governor must be selected before loading a BPF
>    governor; otherwise, the installation of the BPF governor will fail.
> 
> TODO
> ----
> 
> The current patch is a starting point, and future work will focus on
> expanding its capabilities.
> 
> I plan to leverage the BPF ecosystem to introduce innovative features,
> such as real-time adjustments and optimizations based on system-wide
> observations and analytics.
> 
> And I am looking forward to any insights, critiques, or suggestions you
> may have.
> 
> Yipeng Zou (2):
>   cpufreq_ext: Introduce cpufreq ext governor
>   cpufreq_ext: Add bpf sample
> 
>  drivers/cpufreq/Kconfig        |  23 ++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/cpufreq_ext.c  | 525 +++++++++++++++++++++++++++++++++
>  samples/bpf/.gitignore         |   1 +
>  samples/bpf/Makefile           |   8 +-
>  samples/bpf/cpufreq_ext.bpf.c  | 113 +++++++
>  samples/bpf/cpufreq_ext_user.c |  48 +++
>  7 files changed, 718 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpufreq/cpufreq_ext.c
>  create mode 100644 samples/bpf/cpufreq_ext.bpf.c
>  create mode 100644 samples/bpf/cpufreq_ext_user.c
> 
> -- 
> 2.34.1
> 

