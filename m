Return-Path: <bpf+bounces-40399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D5988230
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 12:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8CB288FEA
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D01BC086;
	Fri, 27 Sep 2024 10:03:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD016DEB5;
	Fri, 27 Sep 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431422; cv=none; b=Juads6Ia960vZFg7mmLk0aKOe6qPMZ6Une5TzMhBm0H1LIeS2xzO5GYrCGAuEgHw2PB7+jzsdfM/kOAt+1frFhzyVWLvPBHo/VKIVXUFHx1BZpypnEGueYAL5z2AzmIL5oq7fjrutD6LXsdTmh1cyKXgV8WPMPG759NuEFYjgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431422; c=relaxed/simple;
	bh=ICXoLw7JoQ7HO0Ah5/sPn2rFGKa892gRr+ox+6kbXvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6sT8o5jPKzUIS0wWaaPYmLbnwh76mYcABDKkNSPs6DKeD+BehkCusTRn8CtqbDmgTGDjGw8jrrRV5S0Unk9MjY33RR2nxr0GAiQ0mVUbkX4bnsmdVHM06MIc6irlkj8E4Y0b6wNqUvCQBCwjN6N5rxvzxgGiFRIYE3D2EyCO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XFQwH5l8bzWf33;
	Fri, 27 Sep 2024 18:01:19 +0800 (CST)
Received: from kwepemg200002.china.huawei.com (unknown [7.202.181.29])
	by mail.maildlp.com (Postfix) with ESMTPS id DB05F140154;
	Fri, 27 Sep 2024 18:03:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200002.china.huawei.com
 (7.202.181.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Sep
 2024 18:03:37 +0800
From: Yipeng Zou <zouyipeng@huawei.com>
To: <linux-pm@vger.kernel.org>, <bpf@vger.kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
	<song@kernel.org>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>
CC: <zouyipeng@huawei.com>, <liaochang1@huawei.com>
Subject: [RFC PATCH 0/2] cpufreq_ext: Introduce cpufreq ext governor
Date: Fri, 27 Sep 2024 18:13:40 +0800
Message-ID: <20240927101342.3240263-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200002.china.huawei.com (7.202.181.29)

Hi everyone,

I am currently working on a patch for a CPU frequency governor based on
BPF, which can use BPF to customize and implement various frequency
scaling strategies.

If you have any feedback or suggestions, please do let me know.

Motivation
----------

1. Customization

Existing cpufreq governors in the kernel are designed for general
scenarios, which may not always be optimal for specific or specialized
workloads.

The userspace governor allows direct control over cpufreq, but users
often require guidance from the kernel to achieve the desired frequency.

Cpufreq_ext aims to address this by providing a customizable framework that
can be tailored to the unique needs of different systems and applications.

While cpufreq governors can be implemented within a kernel module,
maintaining a ko tailored for specific scenarios can be challenging.
The complexity and overhead associated with kernel modules make it
difficult to quickly adapt and deploy custom frequency scaling strategies.

Cpufreq_ext leverages BPF to offer a more lightweight and flexible approach
to implementing customized strategies, allowing for easier maintenance and
deployment.

2. Integration with sched_ext:

sched_ext is a scheduler class whose behavior can be defined by a set of
BPF programs - the BPF scheduler.

Look for more about sched_ext in [1]:

	[1] https://www.kernel.org/doc/html/next/scheduler/sched-ext.html

The interaction between CPU frequency scaling and task scheduling is
critical for performance.

cpufreq_ext can work with sched_ext to ensure that both scheduling
decisions and frequency adjustments are made in a coordinated manner,
optimizing system responsiveness and power consumption.

Overview
--------

The cpufreq ext is a BPF based cpufreq governor, we can customize
cpufreq governor in BPF program.

CPUFreq ext works as common cpufreq governor with cpufreq policy.

		   --------------------------
		  |        BPF governor      |
		   --------------------------
			       |
			       v
			  BPF Register
			       |
			       v
	    --------------------------------------
	   |             CPUFreq ext              |
	    --------------------------------------
	      ^                ^               ^
	      |                |               |
	   ---------       ---------       ---------
	  | policy0 | ... | policy1 | ... | policyn |
	   ---------       ---------       ---------

We can register serval function hooks to cpufreq ext by BPF Struct OPS.

The first patch define a dbs_governor, and it's works like other
governor.

The second patch gives a sample how to use it, implement one
typical cpufreq governor, switch to max cpufreq when VIP task
is running on target cpu.

Detail
------

The cpufreq ext use bpf_struct_ops to register serval function hooks.

	struct cpufreq_governor_ext_ops {
		...
	}

Cpufreq_governor_ext_ops defines all the functions that BPF programs can
implement customly.

If you need to add a custom function, you only need to define it in this
struct.

At the moment we have defined the basic functions.

1. unsigned long (*get_next_freq)(struct cpufreq_policy *policy)

	Make decision how to adjust cpufreq here.
	The return value represents the CPU frequency that will be
	updated.

2. unsigned int (*get_sampling_rate)(struct cpufreq_policy *policy)

	Make decision how to adjust sampling_rate here.
	The return value represents the governor samplint rate that
	will be updated.

3. unsigned int (*init)(void)

	BPF governor init callback, return 0 means success.

4. void (*exit)(void)

	BPF governor exit callback.

5. char name[CPUFREQ_EXT_NAME_LEN]

	BPF governor name.

The cpufreq_ext also add sysfs interface which refer to governor status.

1. ext/stat attribute:

	Access to current BPF governor status.

	# cat /sys/devices/system/cpu/cpufreq/ext/stat
	Stat: CPUFREQ_EXT_INIT
	BPF governor: performance

There are number of constraints on the cpufreq_ext:

1. Only one ext governor can be registered at a time.

2. By default, it operates as a performance governor when no BPF
   governor is registered.

3. The cpufreq_ext governor must be selected before loading a BPF
   governor; otherwise, the installation of the BPF governor will fail.

TODO
----

The current patch is a starting point, and future work will focus on
expanding its capabilities.

I plan to leverage the BPF ecosystem to introduce innovative features,
such as real-time adjustments and optimizations based on system-wide
observations and analytics.

And I am looking forward to any insights, critiques, or suggestions you
may have.

Yipeng Zou (2):
  cpufreq_ext: Introduce cpufreq ext governor
  cpufreq_ext: Add bpf sample

 drivers/cpufreq/Kconfig        |  23 ++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/cpufreq_ext.c  | 525 +++++++++++++++++++++++++++++++++
 samples/bpf/.gitignore         |   1 +
 samples/bpf/Makefile           |   8 +-
 samples/bpf/cpufreq_ext.bpf.c  | 113 +++++++
 samples/bpf/cpufreq_ext_user.c |  48 +++
 7 files changed, 718 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/cpufreq_ext.c
 create mode 100644 samples/bpf/cpufreq_ext.bpf.c
 create mode 100644 samples/bpf/cpufreq_ext_user.c

-- 
2.34.1


