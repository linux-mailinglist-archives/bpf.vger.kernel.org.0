Return-Path: <bpf+bounces-40504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B878989654
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38A528415F
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9A17CA04;
	Sun, 29 Sep 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbbDBAkm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068579FD;
	Sun, 29 Sep 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727628977; cv=none; b=RGxqoebaY7YrqkYgWvW5u1O7x6auuS4YZCHvzRgfF+uvXiFqe64vX2KCRGBd5TgEDi5Jo2IXwGr04uBlu5eK+KVqhfz1Ipn3mn4aFnU7fjL/dlykBJmF1jL453WuU4yCFGwtiyyOfQTzBLet1f2Hif+VgZQuj3gpb3RUGh6Kj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727628977; c=relaxed/simple;
	bh=/A095cZBgYnes/ihK3oSWpqt3MXM87K4hk2AGl6FhgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjbemLoa5Jiv74Z/3jf6o8OLnfFTzhyPWphF4Cue8vjlyiDdv/sEqMkUSX7xdAFn+Kk85/xTCWXwHzKW0RvOOkErqmizo2N856E4XAa2JBrzv7QksL3A+3kfg0uecRbyz7/KyU8FTQ5rrh1Yd08EZwF5nsqlXnYEhyWB1bvt0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbbDBAkm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb2191107so29273085e9.1;
        Sun, 29 Sep 2024 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727628974; x=1728233774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAQoNOgNJ0vEkqaqFbvaXRQniI018F1SMrrbs5au4pY=;
        b=SbbDBAkmCPXWbqWe6bDx4+xdzuHmNBznpbf3p6YtdN+wk9s/+Dy+Yms7yIjpunl8B0
         DyP14EqF38ES2TC3ofJCYrq2nhGSGe5w0typzJ3Wg2LzqCnCyYsVwNV2nQe1EegA8yQW
         E7Yvco/ucwSdedO26QEEWdKcj7jYMbw4p2ZEq4ADRA2oh4RndjN1SmBJwoxhpPWWRyI9
         2Vmnkp0CSJzXv41Z+KOo7BcCI2/mLt5S96KFxRzH3m6SX2xG2yQE/grmpsugtlt2qT21
         GziHRifcMtyBHPwCOat8eGMiSCoOSm81Txy4K8tKOivEIxP3fuWc5N1os6Sdz4jsONuZ
         QLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727628974; x=1728233774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAQoNOgNJ0vEkqaqFbvaXRQniI018F1SMrrbs5au4pY=;
        b=BNVvZPsn3OB73U7sPYFPoFvYiZNLRiRMFTwUCq/svFXK4T51Z1swV/ECi3RH/NSbts
         6R2b2z0uuCFFcX4NoSCIYkHIvnUPGN6xtfq5HDEPf1S2J6mQaq439LkVV0sS7kiHNLCj
         b/gtpBjMPR7LcOUqJFdfLYSSX6lQaZz4pCQHyvG0wDe1DZc0nBEKVuUGVxq8gmRyTrVe
         uHg6syhXlizhYR4cJH1YGv6hGgtJwc8CTTTYnQNUttqC4nWB4txirKkl612CcF4cdG3i
         AdYvhPMfeU02HOdXirKO+yPpFRFq4yfFNJ3ARwl10grMgKHjzClDWFJPIv04mHNsr6Sq
         EAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZCiGevoRRK84PUiI2T5QOwSuV1jMTY1+g66VG1ETA1PHQ2T8CgHKKLWjrk8Hw6eacuYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaKSehCHOperqO2Zq0mr9sM2m9Edd++rk+dGAOEAxmcRTLNQE
	cmjGKKwiKba5DSzIFNBOUB8gsYr9LRRosQZ69Rd75gWWyP1lqQ5/odlGm23DBZQ+sR1T8QmM9X7
	K7PxwsIjshkYKZup3WhOPQPWh8Fc=
X-Google-Smtp-Source: AGHT+IEFHJWQfBOSxdr3HcykiIfd2aQANlt5JrGWA9HyRVEZYynaWlt9Sg3AjbKx7HHe9lErflTE/++r0llYa0Y9RiI=
X-Received: by 2002:a05:600c:3c88:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-42f5849924bmr72828155e9.29.1727628973931; Sun, 29 Sep 2024
 09:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927101342.3240263-1-zouyipeng@huawei.com>
In-Reply-To: <20240927101342.3240263-1-zouyipeng@huawei.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 09:56:02 -0700
Message-ID: <CAADnVQJmVo4BU345irnnLNxQ_sT1cOEx8ky4T2iH_ZKpAyFfww@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] cpufreq_ext: Introduce cpufreq ext governor
To: Yipeng Zou <zouyipeng@huawei.com>, Tejun Heo <tj@kernel.org>
Cc: Linux Power Management <linux-pm@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, liaochang1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:03=E2=80=AFAM Yipeng Zou <zouyipeng@huawei.com> w=
rote:
>
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
> Cpufreq_ext aims to address this by providing a customizable framework th=
at
> can be tailored to the unique needs of different systems and applications=
.
>
> While cpufreq governors can be implemented within a kernel module,
> maintaining a ko tailored for specific scenarios can be challenging.
> The complexity and overhead associated with kernel modules make it
> difficult to quickly adapt and deploy custom frequency scaling strategies=
.
>
> Cpufreq_ext leverages BPF to offer a more lightweight and flexible approa=
ch
> to implementing customized strategies, allowing for easier maintenance an=
d
> deployment.
>
> 2. Integration with sched_ext:
>
> sched_ext is a scheduler class whose behavior can be defined by a set of
> BPF programs - the BPF scheduler.
>
> Look for more about sched_ext in [1]:
>
>         [1] https://www.kernel.org/doc/html/next/scheduler/sched-ext.html
>
> The interaction between CPU frequency scaling and task scheduling is
> critical for performance.
>
> cpufreq_ext can work with sched_ext to ensure that both scheduling
> decisions and frequency adjustments are made in a coordinated manner,
> optimizing system responsiveness and power consumption.

I think sched-ext already has a mechanism to influence cpufreq.
How is this different ?

Pls cc sched-ext folks in the future.

> Overview
> --------
>
> The cpufreq ext is a BPF based cpufreq governor, we can customize
> cpufreq governor in BPF program.
>
> CPUFreq ext works as common cpufreq governor with cpufreq policy.
>
>                    --------------------------
>                   |        BPF governor      |
>                    --------------------------
>                                |
>                                v
>                           BPF Register
>                                |
>                                v
>             --------------------------------------
>            |             CPUFreq ext              |
>             --------------------------------------
>               ^                ^               ^
>               |                |               |
>            ---------       ---------       ---------
>           | policy0 | ... | policy1 | ... | policyn |
>            ---------       ---------       ---------
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
>         struct cpufreq_governor_ext_ops {
>                 ...
>         }
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
>         Make decision how to adjust cpufreq here.
>         The return value represents the CPU frequency that will be
>         updated.
>
> 2. unsigned int (*get_sampling_rate)(struct cpufreq_policy *policy)
>
>         Make decision how to adjust sampling_rate here.
>         The return value represents the governor samplint rate that
>         will be updated.
>
> 3. unsigned int (*init)(void)
>
>         BPF governor init callback, return 0 means success.
>
> 4. void (*exit)(void)
>
>         BPF governor exit callback.
>
> 5. char name[CPUFREQ_EXT_NAME_LEN]
>
>         BPF governor name.
>
> The cpufreq_ext also add sysfs interface which refer to governor status.
>
> 1. ext/stat attribute:
>
>         Access to current BPF governor status.
>
>         # cat /sys/devices/system/cpu/cpufreq/ext/stat
>         Stat: CPUFREQ_EXT_INIT
>         BPF governor: performance
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

