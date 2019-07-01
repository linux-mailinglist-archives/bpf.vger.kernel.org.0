Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8C4517B
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2019 03:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfFNB5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 21:57:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45888 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfFNB47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 21:56:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so371669pfq.12;
        Thu, 13 Jun 2019 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FQMTr1LAMEPatmtX5eL7Kp8n0XMmhfiWQovAznnVe3A=;
        b=liHLQtU1osiCpmY7UQyJtWK7PalvucKMq+GmhMocOKuc3rggWiE5J9vIkxZtjfhGuP
         0QGQYpE6hLeJj42SAjyzMTgVanhmk79eN3na7utHko264hFRMjD1oIV3erxy0I1o0P7E
         MYB86cWN2ri6QI5wQpdmsMg1Mg8VD/ieZoZJdYZzgX4iXMYM81f4eO8UlCtpes/IeuYw
         ifjmivlsJC75nvY5qVjUGTk3WCVF0k081/JiC5oh+GJ9PtgazwBs56jXzT5lXYd0JGA4
         bQyxVyxmhW8Oszv9Ad9eOATkBLMDvurlZNNPXUhVLmn81p39DARinHemTFFSHOqLu2cp
         sY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FQMTr1LAMEPatmtX5eL7Kp8n0XMmhfiWQovAznnVe3A=;
        b=tXNTD5q5i2vcly0tPUCfTCmUduACnToUZeLaSSrLymxhB8MWGHdVsZj5ZVUqcHSMjj
         lsFNUhh/zdklDoomjQMhmUSTh57VBvXq2iN/KjtszxlDyE9xrJPq/Y9pPLvjhPxICeAY
         4wJmuHLQXNLEYvCnRvmYxZEYhYwCeW6unlC4dIQ72d+Il6Vlyvn+w7vEiymDSjso25Mg
         x2dc7ruqx29wgp0iuspxxiPbRpBqBsjI1uFtyLZkdPZdw3m3GAsUW4HhkSIeMfJGr8gk
         QjMHkG/Hel7UdxJ74HhGljAoLVybqa9OaUfc2CimNorhAiJceqvag4JGekrO5W2ZnzyF
         dn+w==
X-Gm-Message-State: APjAAAWOvNFHUgNopzKaegjfdvx8JLWSQ/Mr9YV2d+dAFK+XLJASJ3Zz
        z7IsnofThMuxAA2sTHwUFoI=
X-Google-Smtp-Source: APXvYqx8LitHzaB1gSDgbcXpHSz3LGOD8XV3jD1CIICdeXCeX88I/1xv2LED4mZdxuCFVDxoLe9K0g==
X-Received: by 2002:a62:750c:: with SMTP id q12mr76221852pfc.59.1560477415960;
        Thu, 13 Jun 2019 18:56:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id f14sm949465pfn.53.2019.06.13.18.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:55 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/10] blkcg: implement blk-ioweight
Date:   Thu, 13 Jun 2019 18:56:18 -0700
Message-Id: <20190614015620.1587672-9-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset implements IO cost model based work-conserving
proportional controller.

While io.latency provides the capability to comprehensively prioritize
and protect IOs depending on the cgroups, its protection is binary -
the lowest latency target cgroup which is suffering is protected at
the cost of all others.  In many use cases including stacking multiple
workload containers in a single system, it's necessary to distribute
IO capacity with better granularity.

One challenge of controlling IO resources is the lack of trivially
observable cost metric.  The most common metrics - bandwidth and iops
- can be off by orders of magnitude depending on the device type and
IO pattern.  However, the cost isn't a complete mystery.  Given
several key attributes, we can make fairly reliable predictions on how
expensive a given stream of IOs would be, at least compared to other
IO patterns.

The function which determines the cost of a given IO is the IO cost
model for the device.  This controller distributes IO capacity based
on the costs estimated by such model.  The more accurate the cost
model the better but the controller adapts based on IO completion
latency and as long as the relative costs across differents IO
patterns are consistent and sensible, it'll adapt to the actual
performance of the device.

Currently, the only implemented cost model is a simple linear one with
a few sets of default parameters for different classes of device.
This covers most common devices reasonably well.  All the
infrastructure to tune and add different cost models is already in
place and a later patch will also allow using bpf progs for cost
models.

Please see the top comment in blk-ioweight.c and documentation for
more details.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
---
 Documentation/admin-guide/cgroup-v2.rst |   93 +
 block/Kconfig                           |    9 +
 block/Makefile                          |    1 +
 block/blk-ioweight.c                    | 2356 +++++++++++++++++++++++
 block/blk-rq-qos.h                      |    3 +
 include/linux/blk_types.h               |    3 +
 include/trace/events/ioweight.h         |  174 ++
 7 files changed, 2639 insertions(+)
 create mode 100644 block/blk-ioweight.c
 create mode 100644 include/trace/events/ioweight.h

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a5c845338d6d..e66ee2c20b3b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1425,6 +1425,99 @@ IO Interface Files
 	  8:16 rbytes=1459200 wbytes=314773504 rios=192 wios=353 dbytes=0 dios=0
 	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252 dbytes=50331648 dios=3021
 
+  io.weight.qos
+	A read-write nested-keyed file with exists only on the root
+	cgroup.
+
+	This file configures the Quality of Service of the IO cost
+	model based proportional controller
+	(CONFIG_BLK_CGROUP_IOWEIGHT).  Lines are keyed by $MAJ:$MIN
+	device numbers and not ordered.  The line for a given device
+	is populated on the first write for the device on
+	"io.weight.qos" or "io.weight.cost_model".  The following
+	nested keys are defined.
+
+	  ======	=====================================
+	  enable	Weight-based control enable
+	  ctrl		"auto" or "user"
+	  rpct		Read latency percentile    [0, 100]
+	  rlat		Read latency threshold
+	  wpct		Write latency percentile   [0, 100]
+	  wlat		Write latency threshold
+	  min		Minimum scaling percentage [1, 10000]
+	  max		Maximum scaling percentage [1, 10000]
+	  ======	=====================================
+
+	The controller is disabled by default and can be enabled by
+	setting "enable" to 1.  "rpct" and "wpct" parameters default
+	to zero and the controller uses internal device saturation
+	state to adjust the overall IO rate between "min" and "max".
+
+	When a better control quality is needed, latency QoS
+	parameters can be configured.  For example::
+
+	  8:16 enable=1 ctrl=auto rpct=95.00 rlat=75000 wpct=95.00 wlat=150000 min=50.00 max=150.0
+
+	shows that on sdb, the controller is enabled, will consider
+	the device saturated if the 95th percentile of read completion
+	latencies is above 75ms or write 150ms, and adjust the overall
+	IO issue rate between 50% and 150% accordingly.
+
+	The lower the saturation point, the better the latency QoS at
+	the cost of aggregate bandwidth.  The narrower the allowed
+	adjustment range between "min" and "max", the more conformant
+	to the cost model the IO behavior.  Note that the IO issue
+	base rate may be far off from 100% and setting "min" and "max"
+	blindly can lead to a significant loss of device capacity or
+	control quality.  "min" and "max" are useful for regulating
+	devices which show wide temporary behavior changes - e.g. a
+	ssd which accepts writes at the line speed for a while and
+	then completely stalls for multiple seconds.
+
+	When "ctrl" is "auto", the parameters are controlled by the
+	kernel and may change automatically.  Setting "ctrl" to "user"
+	or setting any of the percentile and latency parameters puts
+	it into "user" mode and disables the automatic changes.  The
+	automatic mode can be restored by setting "ctrl" to "auto".
+
+  io.weight.cost_model
+	A read-write nested-keyed file with exists only on the root
+	cgroup.
+
+	This file configures the cost model of the IO cost model based
+	proportional controller (CONFIG_BLK_CGROUP_IOWEIGHT).  Lines
+	are keyed by $MAJ:$MIN device numbers and not ordered.  The
+	line for a given device is populated on the first write for
+	the device on "io.weight.qos" or "io.weight.cost_model".  The
+	following nested keys are defined.
+
+	  =====		================================
+	  ctrl		"auto" or "user"
+	  model		The cost model in use - "linear"
+	  =====		================================
+
+	When "ctrl" is "auto", the kernel may change all parameters
+	dynamically.  When "ctrl" is set to "user" or any other
+	parameters are written to, "ctrl" become "user" and the
+	automatic changes are disabled.
+
+	When "model" is "linear", the following model parameters are
+	defined.
+
+	  =============	========================================
+	  [r|w]bps	The maximum sequential IO throughput
+	  [r|w]seqiops	The maximum 4k sequential IOs per second
+	  [r|w]randiops	The maximum 4k random IOs per second
+	  =============	========================================
+
+	From the above, the builtin linear model determines the base
+	costs of a sequential and random IO and the cost coefficient
+	for the IO size.  While simple, this model can cover most
+	common device classes acceptably.
+
+	The IO cost model isn't expected to be accurate in absolute
+	sense and is scaled to the device behavior dynamically.
+
   io.weight
 	A read-write flat-keyed file which exists on non-root cgroups.
 	The default is "default 100".
diff --git a/block/Kconfig b/block/Kconfig
index 2466dcc3ef1d..15b3de28a264 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -132,6 +132,15 @@ config BLK_CGROUP_IOLATENCY
 
 	Note, this is an experimental interface and could be changed someday.
 
+config BLK_CGROUP_IOWEIGHT
+	bool "Enable support for weight based cgroup IO protection"
+	depends on BLK_CGROUP=y
+	---help---
+	Enabling this option enables the .weight interface for IO throttling.
+	The IO controller will attempt to maintain a IO distribution between
+	different groups based on their percentage of share of the overall
+	weight distribution.
+
 config BLK_WBT_MQ
 	bool "Multiqueue writeback throttling"
 	default y
diff --git a/block/Makefile b/block/Makefile
index eee1b4ceecf9..e8a8ef16dbff 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
+obj-$(CONFIG_BLK_CGROUP_IOWEIGHT)	+= blk-ioweight.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
diff --git a/block/blk-ioweight.c b/block/blk-ioweight.c
new file mode 100644
index 000000000000..d10249f5774e
--- /dev/null
+++ b/block/blk-ioweight.c
@@ -0,0 +1,2356 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * IO cost model based work-conserving proportional controller.
+ *
+ * Copyright (C) 2019 Tejun Heo <tj@kernel.org>
+ * Copyright (C) 2019 Andy Newell <newella@fb.com>
+ * Copyright (C) 2019 Facebook
+ *
+ * One challenge of controlling IO resources is the lack of trivially
+ * observable cost metric.  This is distinguished from CPU and memory where
+ * wallclock time and the number of bytes can serve as accurate enough
+ * approximations.
+ *
+ * Bandwidth and iops are the most commonly used metrics for IO devices but
+ * depending on the type and specifics of the device, different IO patterns
+ * easily lead to multiple orders of magnitude variations rendering them
+ * useless for the purpose of IO capacity distribution.  While on-device
+ * time, with a lot of clutches, could serve as a useful approximation for
+ * non-queued rotational devices, this is no longer viable with modern
+ * devices, even the rotational ones.
+ *
+ * While there is no cost metric we can trivially observe, it isn't a
+ * complete mystery.  For example, on a rotational device, seek cost
+ * dominates while a contiguous transfer contributes a smaller amount
+ * proportional to the size.  If we can characterize at least the relative
+ * costs of these different types of IOs, it should be possible to
+ * implement a reasonable work-conserving proportional IO resource
+ * distribution.
+ *
+ * 1. IO Cost Model
+ *
+ * IO cost model estimates the cost of an IO given its basic parameters and
+ * history (e.g. the end sector of the last IO).  The cost is measured in
+ * device time.  If a given IO is estimated to cost 10ms, the device should
+ * be able to process ~100 of those IOs in a second.
+ *
+ * Currently, there's only one builtin cost model - linear.  Each IO is
+ * classified as sequential or random and given a base cost accordingly.
+ * On top of that, a size cost proportional to the length of the IO is
+ * added.  While simple, this model captures the operational
+ * characteristics of a wide varienty of devices well enough.  Default
+ * paramters for several different classes of devices are provided and the
+ * parameters can be configured from userspace via
+ * /sys/block/DEV/queue/io_cost_model.
+ *
+ * 2. Control Strategy
+ *
+ * The device virtual time (vtime) is used as the primary control metric.
+ * The control strategy is composed of the following three parts.
+ *
+ * 2-1. Vtime Distribution
+ *
+ * When a cgroup becomes active in terms of IOs, its hierarchical share is
+ * calculated.  Please consider the following hierarchy where the numbers
+ * inside parentheses denote the configured weights.
+ *
+ *           root
+ *         /       \
+ *      A (w:100)  B (w:300)
+ *      /       \
+ *  A0 (w:100)  A1 (w:100)
+ *
+ * If B is idle and only A0 and A1 are actively issuing IOs, as the two are
+ * of equal weight, each gets 50% share.  If then B starts issuing IOs, B
+ * gets 300/(100+300) or 75% share, and A0 and A1 equally splits the rest,
+ * 12.5% each.  The distribution mechanism only cares about these flattened
+ * shares.  They're called hweights (hierarchical weights) and always add
+ * upto 1 (HWEIGHT_WHOLE).
+ *
+ * A given cgroup's vtime runs slower in inverse proportion to its hweight.
+ * For example, with 12.5% weight, A0's time runs 8 times slower (100/12.5)
+ * against the device vtime - an IO which takes 10ms on the underlying
+ * device is considered to take 80ms on A0.
+ *
+ * This constitutes the basis of IO capacity distribution.  Each cgroup's
+ * vtime is running at a rate determined by its hweight.  A cgroup tracks
+ * the vtime consumed by past IOs and can issue a new IO iff doing so
+ * wouldn't outrun the current device vtime.  Otherwise, the IO is
+ * suspended until the vtime has progressed enough to cover it.
+ *
+ * 2-2. Vrate Adjustment
+ *
+ * It's unrealistic to expect the cost model to be perfect.  There are too
+ * many devices and even on the same device the overall performance
+ * fluctuates depending on numerous factors such as IO mixture and device
+ * internal garbage collection.  The controller needs to adapt dynamically.
+ *
+ * This is achieved by adjusting the overall IO rate according to how busy
+ * the device is.  If the device becomes overloaded, we're sending down too
+ * many IOs and should generally slow down.  If there are waiting issuers
+ * but the device isn't saturated, we're issuing too few and should
+ * generally speed up.
+ *
+ * To slow down, we lower the vrate - the rate at which the device vtime
+ * passes compared to the wall clock.  For example, if the vtime is running
+ * at the vrate of 75%, all cgroups added up would only be able to issue
+ * 750ms worth of IOs per second, and vice-versa for speeding up.
+ *
+ * Device business is determined using two criteria - rq wait and
+ * completion latencies.
+ *
+ * When a device gets saturated, the on-device and then the request queues
+ * fill up and a bio which is ready to be issued has to wait for a request
+ * to become available.  When this delay becomes noticeable, it's a clear
+ * indication that the device is saturated and we lower the vrate.  This
+ * saturation signal is fairly conservative as it only triggers when both
+ * hardware and software queues are filled up, and is used as the default
+ * busy signal.
+ *
+ * As devices can have deep queues and be unfair in how the queued commands
+ * are executed, soley depending on rq wait may not result in satisfactory
+ * control quality.  For a better control quality, completion latency QoS
+ * parameters can be configured so that the device is considered saturated
+ * if N'th percentile completion latency rises above the set point.
+ *
+ * The completion latency requirements are a function of both the
+ * underlying device characteristics and the desired IO latency quality of
+ * service.  There is an inherent trade-off - the tighter the latency QoS,
+ * the higher the bandwidth lossage.  Latency QoS is disabled by default
+ * and can be set through /sys/fs/cgroup/io.weight.qos.
+ *
+ * 2-3. Work Conservation
+ *
+ * Imagine two cgroups A and B with equal weights.  A is issuing a small IO
+ * periodically while B is sending out enough parallel IOs to saturate the
+ * device on its own.  Let's say A's usage amounts to 100ms worth of IO
+ * cost per second, i.e., 10% of the device capacity.  The naive
+ * distribution of half and half would lead to 60% utilization of the
+ * device, a significant reduction in the total amount of work done
+ * compared to free-for-all competition.  This is too high a cost to pay
+ * for IO control.
+ *
+ * To conserve the total amount of work done, we keep track of how much
+ * each active cgroup is actually using and yield part of its weight if
+ * there are other cgroups which can make use of it.  In the above case,
+ * A's weight will be lowered so that it hovers above the actual usage and
+ * B would be able to use the rest.
+ *
+ * As we don't want to penalize a cgroup for donating its weight, the
+ * surplus weight adjustment factors in a margin and has an immediate
+ * snapback mechanism in case the cgroup needs more IO vtime for itself.
+ *
+ * Note that adjusting down surplus weights has the same effects as
+ * accelerating vtime for other cgroups and work conservation can also be
+ * implemented by adjusting vrate dynamically.  However, squaring who can
+ * donate and should take back how much requires hweight propagations
+ * anyway making it easier to implement and understand as a separate
+ * mechanism.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+#include <linux/time64.h>
+#include <linux/parser.h>
+#include <linux/sched/signal.h>
+#include <linux/blk-cgroup.h>
+#include "blk-rq-qos.h"
+#include "blk-stat.h"
+#include "blk-wbt.h"
+
+#ifdef CONFIG_TRACEPOINTS
+
+/* copied from TRACE_CGROUP_PATH, see cgroup-internal.h */
+#define TRACE_IOWG_PATH_LEN 1024
+static DEFINE_SPINLOCK(trace_iowg_path_lock);
+static char trace_iowg_path[TRACE_IOWG_PATH_LEN];
+
+#define TRACE_IOWG_PATH(type, iowg, ...)					\
+	do {									\
+		unsigned long flags;						\
+		if (trace_ioweight_##type##_enabled()) {			\
+			spin_lock_irqsave(&trace_iowg_path_lock, flags);	\
+			cgroup_path(iowg_to_blkg(iowg)->blkcg->css.cgroup,	\
+				    trace_iowg_path, TRACE_IOWG_PATH_LEN);	\
+			trace_ioweight_##type(iowg, trace_iowg_path,		\
+					      ##__VA_ARGS__);			\
+			spin_unlock_irqrestore(&trace_iowg_path_lock, flags);	\
+		}								\
+	} while (0)
+
+#endif /* CONFIG_TRACE_POINTS */
+
+enum {
+	MILLION			= 1000000,
+
+	/* timer period is calculated from latency requirements, bound it */
+	MIN_PERIOD		= USEC_PER_MSEC,
+	MAX_PERIOD		= USEC_PER_SEC,
+
+	/*
+	 * A cgroup's vtime can run 50% behind the device vtime, which
+	 * serves as its IO credit buffer.  Surplus weight adjustment is
+	 * immediately canceled if the vtime margin runs below 10%.
+	 */
+	MARGIN_PCT		= 50,
+	INUSE_MARGIN_PCT	= 10,
+
+	/* Have some play in waitq timer operations */
+	WAITQ_TIMER_MARGIN_PCT	= 5,
+
+	/*
+	 * vtime can wrap well within a reasonable uptime when vrate is
+	 * consistently raised.  Don't trust recorded cgroup vtime if the
+	 * period counter indicates that it's older than 5mins.
+	 */
+	VTIME_VALID_DUR		= 300 * USEC_PER_SEC,
+
+	/*
+	 * Remember the past three non-zero usages and use the max for
+	 * surplus calculation.  Three slots guarantee that we remember one
+	 * full period usage from the last active stretch even after
+	 * partial deactivation and re-activation periods.  Don't start
+	 * giving away weight before collecting two data points to prevent
+	 * hweight adjustments based on one partial activation period.
+	 */
+	NR_USAGE_SLOTS		= 3,
+	MIN_VALID_USAGES	= 2,
+
+	/* 1/64k is granular enough and can easily be handled w/ u32 */
+	HWEIGHT_WHOLE		= 1 << 16,
+
+	/*
+	 * As vtime is used to calculate the cost of each IO, it needs to
+	 * be fairly high precision.  For example, it should be able to
+	 * represent the cost of a single page worth of discard with
+	 * suffificient accuracy.  At the same time, it should be able to
+	 * represent reasonably long enough durations to be useful and
+	 * convenient during operation.
+	 *
+	 * 1s worth of vtime is 2^37.  This gives us both sub-nanosecond
+	 * granularity and days of wrap-around time even at extreme vrates.
+	 */
+	VTIME_PER_SEC_SHIFT	= 37,
+	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
+	VTIME_PER_USEC		= VTIME_PER_SEC / USEC_PER_SEC,
+
+	/* bound vrate adjustments within two orders of magnitude */
+	VRATE_MIN_PPM		= 10000,	/* 1% */
+	VRATE_MAX_PPM		= 100000000,	/* 10000% */
+
+	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
+	VRATE_CLAMP_ADJ_PCT	= 4,
+
+	/* if IOs end up waiting for requests, issue less */
+	RQ_WAIT_BUSY_PCT	= 5,
+
+	/* unbusy hysterisis */
+	UNBUSY_THR_PCT		= 75,
+
+	/* don't let cmds which take a very long time pin lagging for too long */
+	MAX_LAGGING_PERIODS	= 10,
+
+	/*
+	 * If usage% * 1.25 + 2% is lower than hweight% by more than 3%,
+	 * donate the surplus.
+	 */
+	SURPLUS_SCALE_PCT	= 125,			/* * 125% */
+	SURPLUS_SCALE_ABS	= HWEIGHT_WHOLE / 50,	/* + 2% */
+	SURPLUS_MIN_ADJ_DELTA	= HWEIGHT_WHOLE / 33,	/* 3% */
+
+	/* switch iff the conditions are met for longer than this */
+	AUTOP_CYCLE_NSEC	= 10 * NSEC_PER_SEC,
+
+	/*
+	 * Count IO size in 4k pages.  The 12bit shift helps keeping
+	 * size-proportional components of cost calculation in closer
+	 * numbers of digits to per-IO cost components.
+	 */
+	IOW_PAGE_SHIFT		= 12,
+	IOW_PAGE_SIZE		= 1 << IOW_PAGE_SHIFT,
+	IOW_SECT_TO_PAGE_SHIFT	= IOW_PAGE_SHIFT - SECTOR_SHIFT,
+
+	/* if apart further than 16M, consider randio for linear model */
+	LCOEF_RANDIO_PAGES	= 4096,
+};
+
+enum iow_running {
+	IOW_IDLE,
+	IOW_RUNNING,
+	IOW_STOP,
+};
+
+/* IO latency QoS controls including per-dev enable of the whole controller */
+enum {
+	QOS_ENABLE,
+	QOS_CTRL,
+	NR_QOS_CTRL_PARAMS,
+};
+
+/* IO latency QoS params */
+enum {
+	QOS_RPPM,
+	QOS_RLAT,
+	QOS_WPPM,
+	QOS_WLAT,
+	QOS_MIN,
+	QOS_MAX,
+	NR_QOS_PARAMS,
+};
+
+/* cost model controls */
+enum {
+	COST_CTRL,
+	COST_MODEL,
+	NR_COST_CTRL_PARAMS,
+};
+
+/* builtin linear cost model coefficients */
+enum {
+	I_LCOEF_RBPS,
+	I_LCOEF_RSEQIOPS,
+	I_LCOEF_RRANDIOPS,
+	I_LCOEF_WBPS,
+	I_LCOEF_WSEQIOPS,
+	I_LCOEF_WRANDIOPS,
+	NR_I_LCOEFS,
+};
+
+enum {
+	LCOEF_RPAGE,
+	LCOEF_RSEQIO,
+	LCOEF_RRANDIO,
+	LCOEF_WPAGE,
+	LCOEF_WSEQIO,
+	LCOEF_WRANDIO,
+	NR_LCOEFS,
+};
+
+enum {
+	AUTOP_INVALID,
+	AUTOP_HDD,
+	AUTOP_SSD_QD1,
+	AUTOP_SSD_DFL,
+	AUTOP_SSD_FAST,
+};
+
+struct iow_gq;
+
+struct iow_params {
+	u32				qos[NR_QOS_PARAMS];
+	u64				i_lcoefs[NR_I_LCOEFS];
+	u64				lcoefs[NR_LCOEFS];
+	u32				too_fast_vrate_pct;
+	u32				too_slow_vrate_pct;
+};
+
+struct iow_missed {
+	u32				nr_met;
+	u32				nr_missed;
+	u32				last_met;
+	u32				last_missed;
+};
+
+struct iow_pcpu_stat {
+	struct iow_missed		missed[2];
+
+	u64				rq_wait_ns;
+	u64				last_rq_wait_ns;
+};
+
+/* per device */
+struct iow {
+	struct rq_qos			rqos;
+
+	bool				enabled;
+
+	struct iow_params		params;
+	u32				period_us;
+	u32				margin_us;
+	u64				vrate_min;
+	u64				vrate_max;
+
+	spinlock_t			lock;
+	struct timer_list		timer;
+	struct list_head		active_iowgs;	/* active cgroups */
+	struct iow_pcpu_stat __percpu	*pcpu_stat;
+
+	enum iow_running		running;
+	atomic64_t			vtime_rate;
+
+	seqcount_t			period_seqcount;
+	u32				period_at;	/* wallclock starttime */
+	u64				period_at_vtime; /* vtime starttime */
+
+	atomic64_t			cur_period;	/* inc'd each period */
+	int				busy_level;	/* saturation history */
+
+	u64				inuse_margin_vtime;
+	bool				weights_updated;
+	atomic_t			hweight_gen;	/* for lazy hweights */
+
+	u64				autop_too_fast_at;
+	u64				autop_too_slow_at;
+	int				autop_idx;
+	bool				user_qos_params:1;
+	bool				user_cost_model:1;
+};
+
+/* per device-cgroup pair */
+struct iow_gq {
+	struct blkg_policy_data		pd;
+	struct iow			*iow;
+
+	/*
+	 * A iowg can get its weight from two sources - an explicit
+	 * per-device-cgroup configuration or the default weight of the
+	 * cgroup.  `cfg_weight` is the explicit per-device-cgroup
+	 * configuration.  `weight` is the effective considering both
+	 * sources.
+	 *
+	 * When an idle cgroup becomes active its `active` goes from 0 to
+	 * `weight`.  `inuse` is the surplus adjusted active weight.
+	 * `active` and `inuse` are used to calculate `hweight_active` and
+	 * `hweight_inuse`.
+	 *
+	 * `last_inuse` remembers `inuse` while an iowg is idle to persist
+	 * surplus adjustments.
+	 */
+	u32				cfg_weight;
+	u32				weight;
+	u32				active;
+	u32				inuse;
+	u32				last_inuse;
+
+	sector_t			cursor;		/* to detect randio */
+
+	/*
+	 * `vtime` is this iowg's vtime cursor which progresses as IOs are
+	 * issued.  If lagging behind device vtime, the delta represents
+	 * the currently available IO budget.  If runnning ahead, the
+	 * overage.
+	 *
+	 * `vtime_done` is the same but progressed on completion rather
+	 * than issue.  The delta behind `vtime` represents the cost of
+	 * currently in-flight IOs.
+	 *
+	 * `last_vtime` is used to remember `vtime` at the end of the last
+	 * period to calculate utilization.
+	 */
+	atomic64_t			vtime;
+	atomic64_t			done_vtime;
+	u64				last_vtime;
+
+	/*
+	 * The period this iowg was last active in.  Used for deactivation
+	 * and invalidating `vtime`.
+	 */
+	atomic64_t			active_period;
+	struct list_head		active_list;
+
+	/* see __propagate_active_weight() and current_hweight() for details */
+	u64				child_active_sum;
+	u64				child_inuse_sum;
+	int				hweight_gen;
+	u32				hweight_active;
+	u32				hweight_inuse;
+	bool				has_surplus;
+
+	struct wait_queue_head		waitq;
+	struct hrtimer			waitq_timer;
+	struct hrtimer			delay_timer;
+
+	/* usage is recorded as fractions of HWEIGHT_WHOLE */
+	int				usage_idx;
+	u32				usages[NR_USAGE_SLOTS];
+
+	/* this iowg's depth in the hierarchy and ancestors including self */
+	int				level;
+	struct iow_gq			*ancestors[];
+};
+
+/* per cgroup */
+struct iow_cgrp {
+	struct blkcg_policy_data	cpd;
+	unsigned int			dfl_weight;
+};
+
+struct iow_now {
+	u64				now_ns;
+	u32				now;
+	u64				vnow;
+	u64				vrate;
+};
+
+struct iowg_wait {
+	struct wait_queue_entry		wait;
+	struct bio			*bio;
+	u64				abs_cost;
+	bool				committed;
+};
+
+struct iowg_wake_ctx {
+	struct iow_gq			*iowg;
+	u32				hw_inuse;
+	s64				vbudget;
+};
+
+static const struct iow_params autop[] = {
+	[AUTOP_HDD] = {
+		.qos				= {
+			[QOS_RLAT]		=         50000, /* 50ms */
+			[QOS_WLAT]		=         50000,
+			[QOS_MIN]		= VRATE_MIN_PPM,
+			[QOS_MAX]		= VRATE_MAX_PPM,
+		},
+		.i_lcoefs			= {
+			[I_LCOEF_RBPS]		=     174019176,
+			[I_LCOEF_RSEQIOPS]	=         41708,
+			[I_LCOEF_RRANDIOPS]	=           370,
+			[I_LCOEF_WBPS]		=     178075866,
+			[I_LCOEF_WSEQIOPS]	=         42705,
+			[I_LCOEF_WRANDIOPS]	=           378,
+		},
+	},
+	[AUTOP_SSD_QD1] = {
+		.qos				= {
+			[QOS_RLAT]		=         25000, /* 25ms */
+			[QOS_WLAT]		=         25000,
+			[QOS_MIN]		= VRATE_MIN_PPM,
+			[QOS_MAX]		= VRATE_MAX_PPM,
+		},
+		.i_lcoefs			= {
+			[I_LCOEF_RBPS]		=     245855193,
+			[I_LCOEF_RSEQIOPS]	=         61575,
+			[I_LCOEF_RRANDIOPS]	=          6946,
+			[I_LCOEF_WBPS]		=     141365009,
+			[I_LCOEF_WSEQIOPS]	=         33716,
+			[I_LCOEF_WRANDIOPS]	=         26796,
+		},
+	},
+	[AUTOP_SSD_DFL] = {
+		.qos				= {
+			[QOS_RLAT]		=         25000, /* 25ms */
+			[QOS_WLAT]		=         25000,
+			[QOS_MIN]		= VRATE_MIN_PPM,
+			[QOS_MAX]		= VRATE_MAX_PPM,
+		},
+		.i_lcoefs			= {
+			[I_LCOEF_RBPS]		=     488636629,
+			[I_LCOEF_RSEQIOPS]	=          8932,
+			[I_LCOEF_RRANDIOPS]	=          8518,
+			[I_LCOEF_WBPS]		=     427891549,
+			[I_LCOEF_WSEQIOPS]	=         28755,
+			[I_LCOEF_WRANDIOPS]	=         21940,
+		},
+		.too_fast_vrate_pct		=           500,
+	},
+	[AUTOP_SSD_FAST] = {
+		.qos				= {
+			[QOS_RLAT]		=          5000, /* 5ms */
+			[QOS_WLAT]		=          5000,
+			[QOS_MIN]		= VRATE_MIN_PPM,
+			[QOS_MAX]		= VRATE_MAX_PPM,
+		},
+		.i_lcoefs			= {
+			[I_LCOEF_RBPS]		=    2338259289,
+			[I_LCOEF_RSEQIOPS]	=         15336,
+			[I_LCOEF_RRANDIOPS]	=         14588,
+			[I_LCOEF_WBPS]		=    1897549999,
+			[I_LCOEF_WSEQIOPS]	=         51317,
+			[I_LCOEF_WRANDIOPS]	=         37157,
+		},
+		.too_slow_vrate_pct		=            10,
+	},
+};
+
+/*
+ * vrate adjust percentages indexed by iow->busy_level.  We adjust up on
+ * vtime credit shortage and down on device saturation.
+ */
+static u32 vrate_adj_pct[] =
+	{ 0, 0, 0, 0,
+	  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
+	  4, 4, 4, 4, 4, 4, 4, 4, 8, 8, 8, 8, 8, 8, 8, 8, 16 };
+
+static struct blkcg_policy blkcg_policy_iow;
+
+/* accessors and helpers */
+static struct iow *rqos_to_iow(struct rq_qos *rqos)
+{
+	return container_of(rqos, struct iow, rqos);
+}
+
+static struct iow *q_to_iow(struct request_queue *q)
+{
+	return rqos_to_iow(rq_qos_id(q, RQ_QOS_WEIGHT));
+}
+
+static const char *q_name(struct request_queue *q)
+{
+	if (test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+		return kobject_name(q->kobj.parent);
+	else
+		return "<unknown>";
+}
+
+static const char *iow_name(struct iow *iow)
+{
+	return q_name(iow->rqos.q);
+}
+
+static struct iow_gq *pd_to_iowg(struct blkg_policy_data *pd)
+{
+	return pd ? container_of(pd, struct iow_gq, pd) : NULL;
+}
+
+static struct iow_gq *blkg_to_iowg(struct blkcg_gq *blkg)
+{
+	return pd_to_iowg(blkg_to_pd(blkg, &blkcg_policy_iow));
+}
+
+struct blkcg_gq *iowg_to_blkg(struct iow_gq *iowg)
+{
+	return pd_to_blkg(&iowg->pd);
+}
+
+static struct iow_cgrp *blkcg_to_iowc(struct blkcg *blkcg)
+{
+	return container_of(blkcg_to_cpd(blkcg, &blkcg_policy_iow),
+			    struct iow_cgrp, cpd);
+}
+
+/*
+ * Scale @abs_cost to the inverse of @hw_inuse.  The lower the hierarchical
+ * weight, the more expensive each IO.
+ */
+static u64 abs_cost_to_cost(u64 abs_cost, u32 hw_inuse)
+{
+	return DIV64_U64_ROUND_UP(abs_cost * HWEIGHT_WHOLE, hw_inuse);
+}
+
+static void iowg_commit_bio(struct iow_gq *iowg, struct bio *bio, u64 cost)
+{
+	bio->bi_ioweight_cost = cost;
+	atomic64_add(cost, &iowg->vtime);
+}
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/ioweight.h>
+
+/* latency Qos params changed, update period_us and all the dependent params */
+static void iow_refresh_period_us(struct iow *iow)
+{
+	u32 ppm, lat, multi, period_us;
+
+	lockdep_assert_held(&iow->lock);
+
+	/* pick the higher latency target */
+	if (iow->params.qos[QOS_RLAT] >= iow->params.qos[QOS_WLAT]) {
+		ppm = iow->params.qos[QOS_RPPM];
+		lat = iow->params.qos[QOS_RLAT];
+	} else {
+		ppm = iow->params.qos[QOS_WPPM];
+		lat = iow->params.qos[QOS_WLAT];
+	}
+
+	/*
+	 * We want the period to be long enough to contain a healthy number
+	 * of IOs while short enough for granular control.  Define it as a
+	 * multiple of the latency target.  Ideally, the multiplier should
+	 * be scaled according to the percentile so that it would nominally
+	 * contain a certain number of requests.  Let's be simpler and
+	 * scale it linearly so that it's 2x >= pct(90) and 10x at pct(50).
+	 */
+	if (ppm)
+		multi = max_t(u32, (MILLION - ppm) / 50000, 2);
+	else
+		multi = 2;
+	period_us = multi * lat;
+	period_us = clamp_t(u32, period_us, MIN_PERIOD, MAX_PERIOD);
+
+	/* calculate dependent params */
+	iow->period_us = period_us;
+	iow->margin_us = period_us * MARGIN_PCT / 100;
+	iow->inuse_margin_vtime = DIV64_U64_ROUND_UP(
+			period_us * VTIME_PER_USEC * INUSE_MARGIN_PCT, 100);
+}
+
+static int iow_autop_idx(struct iow *iow)
+{
+	int idx = iow->autop_idx;
+	const struct iow_params *p = &autop[idx];
+	u32 vrate_pct;
+	u64 now_ns;
+
+	/* rotational? */
+	if (!blk_queue_nonrot(iow->rqos.q))
+		return AUTOP_HDD;
+
+	/* handle SATA SSDs w/ broken NCQ */
+	if (blk_queue_depth(iow->rqos.q) == 1)
+		return AUTOP_SSD_QD1;
+
+	/* use one of the normal ssd sets */
+	if (idx < AUTOP_SSD_DFL)
+		return AUTOP_SSD_DFL;
+
+	/* if user is overriding anything, maintain what was there */
+	if (iow->user_qos_params || iow->user_cost_model)
+		return idx;
+
+	/* step up/down based on the vrate */
+	vrate_pct = div64_u64(atomic64_read(&iow->vtime_rate) * 100,
+			      VTIME_PER_USEC);
+	now_ns = ktime_get_ns();
+
+	if (p->too_fast_vrate_pct && p->too_fast_vrate_pct <= vrate_pct) {
+		if (!iow->autop_too_fast_at)
+			iow->autop_too_fast_at = now_ns;
+		if (now_ns - iow->autop_too_fast_at >= AUTOP_CYCLE_NSEC)
+			return idx + 1;
+	} else {
+		iow->autop_too_fast_at = 0;
+	}
+
+	if (p->too_slow_vrate_pct && p->too_slow_vrate_pct >= vrate_pct) {
+		if (!iow->autop_too_slow_at)
+			iow->autop_too_slow_at = now_ns;
+		if (now_ns - iow->autop_too_slow_at >= AUTOP_CYCLE_NSEC)
+			return idx - 1;
+	} else {
+		iow->autop_too_slow_at = 0;
+	}
+
+	return idx;
+}
+
+/*
+ * Take the followings as input
+ *
+ *  @bps	maximum sequential throughput
+ *  @seqiops	maximum sequential 4k iops
+ *  @randiops	maximum random 4k iops
+ *
+ * and calculate the linear model cost coefficients.
+ *
+ *  *@page	per-page cost		1s / (@bps / 4096)
+ *  *@seqio	base cost of a seq IO	max((1s / @seqiops) - *@page, 0)
+ *  @randiops	base cost of a rand IO	max((1s / @randiops) - *@page, 0)
+ */
+static void calc_lcoefs(u64 bps, u64 seqiops, u64 randiops,
+			u64 *page, u64 *seqio, u64 *randio)
+{
+	u64 v;
+
+	*page = *seqio = *randio = 0;
+
+	if (bps)
+		*page = DIV64_U64_ROUND_UP(VTIME_PER_SEC,
+					   DIV_ROUND_UP_ULL(bps, IOW_PAGE_SIZE));
+
+	if (seqiops) {
+		v = DIV64_U64_ROUND_UP(VTIME_PER_SEC, seqiops);
+		if (v > *page)
+			*seqio = v - *page;
+	}
+
+	if (randiops) {
+		v = DIV64_U64_ROUND_UP(VTIME_PER_SEC, randiops);
+		if (v > *page)
+			*randio = v - *page;
+	}
+}
+
+static void iow_refresh_lcoefs(struct iow *iow)
+{
+	u64 *u = iow->params.i_lcoefs;
+	u64 *c = iow->params.lcoefs;
+
+	calc_lcoefs(u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
+		    &c[LCOEF_RPAGE], &c[LCOEF_RSEQIO], &c[LCOEF_RRANDIO]);
+	calc_lcoefs(u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS],
+		    &c[LCOEF_WPAGE], &c[LCOEF_WSEQIO], &c[LCOEF_WRANDIO]);
+}
+
+static bool iow_refresh_params(struct iow *iow, bool force)
+{
+	const struct iow_params *p;
+	int idx;
+
+	lockdep_assert_held(&iow->lock);
+
+	idx = iow_autop_idx(iow);
+	p = &autop[idx];
+
+	if (idx == iow->autop_idx && !force)
+		return false;
+
+	if (idx != iow->autop_idx)
+		atomic64_set(&iow->vtime_rate, VTIME_PER_USEC);
+
+	iow->autop_idx = idx;
+	iow->autop_too_fast_at = 0;
+	iow->autop_too_slow_at = 0;
+
+	if (!iow->user_qos_params)
+		memcpy(iow->params.qos, p->qos, sizeof(p->qos));
+	if (!iow->user_cost_model)
+		memcpy(iow->params.i_lcoefs, p->i_lcoefs, sizeof(p->i_lcoefs));
+
+	iow_refresh_period_us(iow);
+	iow_refresh_lcoefs(iow);
+
+	iow->vrate_min = DIV64_U64_ROUND_UP((u64)iow->params.qos[QOS_MIN] *
+					    VTIME_PER_USEC, MILLION);
+	iow->vrate_max = div64_u64((u64)iow->params.qos[QOS_MAX] *
+				   VTIME_PER_USEC, MILLION);
+
+	return true;
+}
+
+/* take a snapshot of the current [v]time and vrate */
+static void iow_now(struct iow *iow, struct iow_now *now)
+{
+	unsigned seq;
+
+	now->now_ns = ktime_get();
+	now->now = ktime_to_us(now->now_ns);
+	now->vrate = atomic64_read(&iow->vtime_rate);
+
+	/*
+	 * The current vtime is
+	 *
+	 *   vtime at period start + (wallclock time since the start) * vrate
+	 *
+	 * As a consistent snapshot of `period_at_vtime` and `period_at` is
+	 * needed, they're seqcount protected.
+	 */
+	do {
+		seq = read_seqcount_begin(&iow->period_seqcount);
+		now->vnow = iow->period_at_vtime +
+			(now->now - iow->period_at) * now->vrate;
+	} while (read_seqcount_retry(&iow->period_seqcount, seq));
+}
+
+static void iow_start_period(struct iow *iow, struct iow_now *now)
+{
+	lockdep_assert_held(&iow->lock);
+	WARN_ON_ONCE(iow->running != IOW_RUNNING);
+
+	write_seqcount_begin(&iow->period_seqcount);
+	iow->period_at = now->now;
+	iow->period_at_vtime = now->vnow;
+	write_seqcount_end(&iow->period_seqcount);
+
+	iow->timer.expires = jiffies + usecs_to_jiffies(iow->period_us);
+	add_timer(&iow->timer);
+}
+
+/*
+ * Update @iowg's `active` and `inuse` to @active and @inuse, update level
+ * weight sums and propagate upwards accordingly.
+ */
+static void __propagate_active_weight(struct iow_gq *iowg, u32 active, u32 inuse)
+{
+	struct iow *iow = iowg->iow;
+	int lvl;
+
+	lockdep_assert_held(&iow->lock);
+
+	inuse = min(active, inuse);
+
+	for (lvl = iowg->level - 1; lvl >= 0; lvl--) {
+		struct iow_gq *parent = iowg->ancestors[lvl];
+		struct iow_gq *child = iowg->ancestors[lvl + 1];
+		u32 parent_active = 0, parent_inuse = 0;
+
+		/* update the level sums */
+		parent->child_active_sum += (s32)(active - child->active);
+		parent->child_inuse_sum += (s32)(inuse - child->inuse);
+		/* apply the udpates */
+		child->active = active;
+		child->inuse = inuse;
+
+		/*
+		 * The delta between inuse and active sums indicates that
+		 * that much of weight is being given away.  Parent's inuse
+		 * and active should reflect the ratio.
+		 */
+		if (parent->child_active_sum) {
+			parent_active = parent->weight;
+			parent_inuse = DIV64_U64_ROUND_UP(
+				parent_active * parent->child_inuse_sum,
+				parent->child_active_sum);
+		}
+
+		/* do we need to keep walking up? */
+		if (parent_active == parent->active &&
+		    parent_inuse == parent->inuse)
+			break;
+
+		active = parent_active;
+		inuse = parent_inuse;
+	}
+
+	iow->weights_updated = true;
+}
+
+static void commit_active_weights(struct iow *iow)
+{
+	lockdep_assert_held(&iow->lock);
+
+	if (iow->weights_updated) {
+		/* paired with rmb in current_hweight(), see there */
+		smp_wmb();
+		atomic_inc(&iow->hweight_gen);
+		iow->weights_updated = false;
+	}
+}
+
+static void propagate_active_weight(struct iow_gq *iowg, u32 active, u32 inuse)
+{
+	__propagate_active_weight(iowg, active, inuse);
+	commit_active_weights(iowg->iow);
+}
+
+static void current_hweight(struct iow_gq *iowg, u32 *hw_activep, u32 *hw_inusep)
+{
+	struct iow *iow = iowg->iow;
+	int lvl;
+	u32 hwa, hwi;
+	int iow_gen;
+
+	/* hot path - if uptodate, use cached */
+	iow_gen = atomic_read(&iow->hweight_gen);
+	if (iow_gen == iowg->hweight_gen)
+		goto out;
+
+	/*
+	 * Paired with wmb in commit_active_weights().  If we saw the
+	 * updated hweight_gen, all the weight updates from
+	 * __propagate_active_weight() are visible too.
+	 *
+	 * We can race with weight updates during calculation and get it
+	 * wrong.  However, hweight_gen would have changed and a future
+	 * reader will recalculate and we're guaranteed to discard the
+	 * wrong result soon.
+	 */
+	smp_rmb();
+
+	hwa = hwi = HWEIGHT_WHOLE;
+	for (lvl = 0; lvl <= iowg->level - 1; lvl++) {
+		struct iow_gq *parent = iowg->ancestors[lvl];
+		struct iow_gq *child = iowg->ancestors[lvl + 1];
+		u32 active_sum = READ_ONCE(parent->child_active_sum);
+		u32 inuse_sum = READ_ONCE(parent->child_inuse_sum);
+		u32 active = READ_ONCE(child->active);
+		u32 inuse = READ_ONCE(child->inuse);
+
+		if (!active_sum)
+			continue;
+
+		active_sum = max(active, active_sum);
+		hwa = hwa * active / active_sum;	/* max 16bits * 10000 */
+
+		inuse_sum = max(inuse, inuse_sum);
+		hwi = hwi * inuse / inuse_sum;		/* max 16bits * 10000 */
+	}
+
+	iowg->hweight_active = max_t(u32, hwa, 1);
+	iowg->hweight_inuse = max_t(u32, hwi, 1);
+	iowg->hweight_gen = iow_gen;
+out:
+	if (hw_activep)
+		*hw_activep = iowg->hweight_active;
+	if (hw_inusep)
+		*hw_inusep = iowg->hweight_inuse;
+}
+
+static void weight_updated(struct iow_gq *iowg)
+{
+	struct iow *iow = iowg->iow;
+	struct blkcg_gq *blkg = iowg_to_blkg(iowg);
+	struct iow_cgrp *iowc = blkcg_to_iowc(blkg->blkcg);
+	u32 weight;
+
+	lockdep_assert_held(&iow->lock);
+
+	weight = iowg->cfg_weight ?: iowc->dfl_weight;
+	if (weight != iowg->weight && iowg->active)
+		propagate_active_weight(iowg, weight,
+			DIV64_U64_ROUND_UP(iowg->inuse * weight, iowg->weight));
+	iowg->weight = weight;
+}
+
+static bool iowg_activate(struct iow_gq *iowg, struct iow_now *now)
+{
+	struct iow *iow = iowg->iow;
+	u64 last_period, cur_period, max_period_delta;
+	u64 vtime, vmargin, vmin;
+	int i;
+
+	/*
+	 * If seem to be already active, just update the stamp to tell the
+	 * timer that we're still active.  We don't mind occassional races.
+	 */
+	if (!list_empty(&iowg->active_list)) {
+		iow_now(iow, now);
+		cur_period = atomic64_read(&iow->cur_period);
+		if (atomic64_read(&iowg->active_period) != cur_period)
+			atomic64_set(&iowg->active_period, cur_period);
+		return true;
+	}
+
+	/* racy check on internal node IOs, treat as root level IOs */
+	if (iowg->child_active_sum)
+		return false;
+
+	spin_lock_irq(&iow->lock);
+
+	iow_now(iow, now);
+
+	/* update period */
+	cur_period = atomic64_read(&iow->cur_period);
+	last_period = atomic64_read(&iowg->active_period);
+	atomic64_set(&iowg->active_period, cur_period);
+
+	/* already activated or breaking leaf-only constraint? */
+	for (i = iowg->level; i > 0; i--)
+		if (!list_empty(&iowg->active_list))
+			goto fail_unlock;
+	if (iowg->child_active_sum)
+		goto fail_unlock;
+
+	/*
+	 * vtime may wrap when vrate is raised substantially due to
+	 * underestimated IO costs.  Look at the period and ignore its
+	 * vtime if the iowg has been idle for too long.  Also, cap the
+	 * budget it can start with to the margin.
+	 */
+	max_period_delta = DIV64_U64_ROUND_UP(VTIME_VALID_DUR, iow->period_us);
+	vtime = atomic64_read(&iowg->vtime);
+	vmargin = iow->margin_us * now->vrate;
+	vmin = now->vnow - vmargin;
+
+	if (last_period + max_period_delta < cur_period ||
+	    time_before64(vtime, vmin)) {
+		atomic64_add(vmin - vtime, &iowg->vtime);
+		atomic64_add(vmin - vtime, &iowg->done_vtime);
+		vtime = vmin;
+	}
+
+	/* activate, propagate weight and start period timer if not running */
+	iowg->hweight_gen = atomic_read(&iow->hweight_gen);
+	list_add(&iowg->active_list, &iow->active_iowgs);
+	propagate_active_weight(iowg, iowg->weight,
+				iowg->last_inuse ?: iowg->weight);
+
+	TRACE_IOWG_PATH(iowg_activate, iowg, now,
+			last_period, cur_period, vtime);
+
+	iowg->last_vtime = vtime;
+
+	if (iow->running == IOW_IDLE) {
+		iow->running = IOW_RUNNING;
+		iow_start_period(iow, now);
+	}
+
+	spin_unlock_irq(&iow->lock);
+	return true;
+
+fail_unlock:
+	spin_unlock_irq(&iow->lock);
+	return false;
+}
+
+static int iowg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
+			int flags, void *key)
+{
+	struct iowg_wait *wait = container_of(wq_entry, struct iowg_wait, wait);
+	struct iowg_wake_ctx *ctx = (struct iowg_wake_ctx *)key;
+	u64 cost = abs_cost_to_cost(wait->abs_cost, ctx->hw_inuse);
+
+	ctx->vbudget -= cost;
+
+	if (ctx->vbudget < 0)
+		return -1;
+
+	iowg_commit_bio(ctx->iowg, wait->bio, cost);
+
+	/*
+	 * autoremove_wake_function() removes the wait entry only when it
+	 * actually changed the task state.  We want the wait always
+	 * removed.  Remove explicitly and use default_wake_function().
+	 */
+	list_del_init(&wq_entry->entry);
+	wait->committed = true;
+
+	default_wake_function(wq_entry, mode, flags, key);
+	return 0;
+}
+
+static void iowg_kick_waitq(struct iow_gq *iowg, struct iow_now *now)
+{
+	struct iow *iow = iowg->iow;
+	struct iowg_wake_ctx ctx = { .iowg = iowg };
+	u64 margin_ns = (u64)(iow->period_us *
+			      WAITQ_TIMER_MARGIN_PCT / 100) * NSEC_PER_USEC;
+	u64 vshortage, expires, oexpires;
+
+	lockdep_assert_held(&iowg->waitq.lock);
+
+	/*
+	 * Wake up the ones which are due and see how much vtime we'll need
+	 * for the next one.
+	 */
+	current_hweight(iowg, NULL, &ctx.hw_inuse);
+	ctx.vbudget = now->vnow - atomic64_read(&iowg->vtime);
+	__wake_up_locked_key(&iowg->waitq, TASK_NORMAL, &ctx);
+	if (!waitqueue_active(&iowg->waitq))
+		return;
+	if (WARN_ON_ONCE(ctx.vbudget >= 0))
+		return;
+
+	/* determine next wakeup, add a quarter margin to guarantee chunking */
+	vshortage = -ctx.vbudget;
+	expires = now->now_ns +
+		DIV64_U64_ROUND_UP(vshortage, now->vrate) * NSEC_PER_USEC;
+	expires += margin_ns / 4;
+
+	/* if already active and close enough, don't bother */
+	oexpires = ktime_to_ns(hrtimer_get_softexpires(&iowg->waitq_timer));
+	if (hrtimer_is_queued(&iowg->waitq_timer) &&
+	    abs(oexpires - expires) <= margin_ns / 4)
+		return;
+
+	hrtimer_start_range_ns(&iowg->waitq_timer, ns_to_ktime(expires),
+			       margin_ns / 4, HRTIMER_MODE_ABS);
+}
+
+static enum hrtimer_restart iowg_waitq_timer_fn(struct hrtimer *timer)
+{
+	struct iow_gq *iowg = container_of(timer, struct iow_gq, waitq_timer);
+	struct iow_now now;
+	unsigned long flags;
+
+	iow_now(iowg->iow, &now);
+
+	spin_lock_irqsave(&iowg->waitq.lock, flags);
+	iowg_kick_waitq(iowg, &now);
+	spin_unlock_irqrestore(&iowg->waitq.lock, flags);
+
+	return HRTIMER_NORESTART;
+}
+
+static void iowg_kick_delay(struct iow_gq *iowg, struct iow_now *now, u64 cost)
+{
+	struct iow *iow = iowg->iow;
+	struct blkcg_gq *blkg = iowg_to_blkg(iowg);
+	u64 vtime = atomic64_read(&iowg->vtime);
+	u64 vmargin = iow->margin_us * now->vrate;
+	u64 margin_ns = iow->margin_us * NSEC_PER_USEC;
+	u64 expires, oexpires;
+
+	/* clear or maintain depending on the overage */
+	if (time_before_eq64(vtime, now->vnow)) {
+		blkcg_clear_delay(blkg);
+		return;
+	}
+	if (!atomic_read(&blkg->use_delay) &&
+	    time_before_eq64(vtime, now->vnow + vmargin))
+		return;
+
+	/* use delay */
+	if (cost) {
+		u64 cost_ns = DIV64_U64_ROUND_UP(cost * NSEC_PER_USEC,
+						 now->vrate);
+		blkcg_add_delay(blkg, now->now_ns, cost_ns);
+	}
+	blkcg_use_delay(blkg);
+
+	expires = now->now_ns + DIV64_U64_ROUND_UP(vtime - now->vnow,
+						   now->vrate) * NSEC_PER_USEC;
+
+	/* if already active and close enough, don't bother */
+	oexpires = ktime_to_ns(hrtimer_get_softexpires(&iowg->delay_timer));
+	if (hrtimer_is_queued(&iowg->delay_timer) &&
+	    abs(oexpires - expires) <= margin_ns / 4)
+		return;
+
+	hrtimer_start_range_ns(&iowg->delay_timer, ns_to_ktime(expires),
+			       margin_ns / 4, HRTIMER_MODE_ABS);
+}
+
+static enum hrtimer_restart iowg_delay_timer_fn(struct hrtimer *timer)
+{
+	struct iow_gq *iowg = container_of(timer, struct iow_gq, delay_timer);
+	struct iow_now now;
+
+	iow_now(iowg->iow, &now);
+	iowg_kick_delay(iowg, &now, 0);
+
+	return HRTIMER_NORESTART;
+}
+
+static void iow_lat_stat(struct iow *iow, u32 *missed_ppm_ar, u32 *rq_wait_pct_p)
+{
+	u32 nr_met[2] = { };
+	u32 nr_missed[2] = { };
+	u64 rq_wait_ns = 0;
+	int cpu, rw;
+
+	for_each_online_cpu(cpu) {
+		struct iow_pcpu_stat *stat = per_cpu_ptr(iow->pcpu_stat, cpu);
+		u64 this_rq_wait_ns;
+
+		for (rw = READ; rw <= WRITE; rw++) {
+			u32 this_met = READ_ONCE(stat->missed[rw].nr_met);
+			u32 this_missed = READ_ONCE(stat->missed[rw].nr_missed);
+
+			nr_met[rw] += this_met - stat->missed[rw].last_met;
+			nr_missed[rw] += this_missed - stat->missed[rw].last_missed;
+			stat->missed[rw].last_met = this_met;
+			stat->missed[rw].last_missed = this_missed;
+		}
+
+		this_rq_wait_ns = READ_ONCE(stat->rq_wait_ns);
+		rq_wait_ns += this_rq_wait_ns - stat->last_rq_wait_ns;
+		stat->last_rq_wait_ns = this_rq_wait_ns;
+	}
+
+	for (rw = READ; rw <= WRITE; rw++) {
+		if (nr_met[rw] + nr_missed[rw])
+			missed_ppm_ar[rw] =
+				DIV64_U64_ROUND_UP((u64)nr_missed[rw] * MILLION,
+						   nr_met[rw] + nr_missed[rw]);
+		else
+			missed_ppm_ar[rw] = 0;
+	}
+
+	*rq_wait_pct_p = div64_u64(rq_wait_ns * 100,
+				   iow->period_us * NSEC_PER_USEC);
+}
+
+/* was iowg idle this period? */
+static bool iowg_is_idle(struct iow_gq *iowg)
+{
+	struct iow *iow = iowg->iow;
+
+	/* did something get issued this period? */
+	if (atomic64_read(&iowg->active_period) ==
+	    atomic64_read(&iow->cur_period))
+		return false;
+
+	/* is something in flight? */
+	if (atomic64_read(&iowg->done_vtime) < atomic64_read(&iowg->vtime))
+		return false;
+
+	return true;
+}
+
+/* returns usage with margin added if surplus is large enough */
+static u32 surplus_adjusted_hweight_inuse(u32 usage, u32 hw_inuse)
+{
+	/* add margin */
+	usage = DIV_ROUND_UP(usage * SURPLUS_SCALE_PCT, 100);
+	usage += SURPLUS_SCALE_ABS;
+
+	/* don't bother if the surplus is too small */
+	if (usage + SURPLUS_MIN_ADJ_DELTA > hw_inuse)
+		return 0;
+
+	return usage;
+}
+
+static void iow_timer_fn(struct timer_list *timer)
+{
+	struct iow *iow = container_of(timer, struct iow, timer);
+	struct iow_gq *iowg, *tiowg;
+	struct iow_now now;
+	int nr_surpluses = 0, nr_shortages = 0, nr_lagging = 0;
+	u32 ppm_rthr = MILLION - iow->params.qos[QOS_RPPM];
+	u32 ppm_wthr = MILLION - iow->params.qos[QOS_WPPM];
+	u32 missed_ppm[2], rq_wait_pct;
+	u64 period_vtime;
+	int i;
+
+	/* how were the latencies during the period? */
+	iow_lat_stat(iow, missed_ppm, &rq_wait_pct);
+
+	/* take care of active iowgs */
+	spin_lock_irq(&iow->lock);
+
+	iow_now(iow, &now);
+
+	period_vtime = now.vnow - iow->period_at_vtime;
+	if (WARN_ON_ONCE(!period_vtime)) {
+		spin_unlock_irq(&iow->lock);
+		return;
+	}
+
+	/*
+	 * Waiters determine the sleep durations based on the vrate they
+	 * saw at the time of sleep.  If vrate has increased, some waiters
+	 * could be sleeping for too long.  Wake up tardy waiters which
+	 * should have woken up in the last period and expire idle iowgs.
+	 */
+	list_for_each_entry_safe(iowg, tiowg, &iow->active_iowgs, active_list) {
+		if (!waitqueue_active(&iowg->waitq) && !iowg_is_idle(iowg))
+			continue;
+
+		spin_lock(&iowg->waitq.lock);
+
+		if (waitqueue_active(&iowg->waitq)) {
+			/* might be oversleeping vtime / hweight changes, kick */
+			iowg_kick_waitq(iowg, &now);
+			iowg_kick_delay(iowg, &now, 0);
+		} else if (iowg_is_idle(iowg)) {
+			/* no waiter and idle, deactivate */
+			iowg->last_inuse = iowg->inuse;
+			__propagate_active_weight(iowg, 0, 0);
+			list_del_init(&iowg->active_list);
+		}
+
+		spin_unlock(&iowg->waitq.lock);
+	}
+	commit_active_weights(iow);
+
+	/* calc usages and see whether some weights need to be moved around */
+	list_for_each_entry(iowg, &iow->active_iowgs, active_list) {
+		u64 vdone, vtime, vusage, vmargin, vmin;
+		u32 hw_active, hw_inuse, usage;
+
+		/*
+		 * Collect unused and wind vtime closer to vnow to prevent
+		 * iowgs from accumulating a large amount of budget.
+		 */
+		vdone = atomic64_read(&iowg->done_vtime);
+		vtime = atomic64_read(&iowg->vtime);
+		current_hweight(iowg, &hw_active, &hw_inuse);
+
+		/*
+		 * Latency QoS detection doesn't account for IOs which are
+		 * in-flight for longer than a period.  Detect them by
+		 * comparing vdone against period start.  If lagging behind
+		 * IOs from past periods, don't increase vrate.
+		 */
+		if (!atomic_read(&iowg_to_blkg(iowg)->use_delay) &&
+		    time_after64(vtime, vdone) &&
+		    time_after64(vtime, now.vnow -
+				 MAX_LAGGING_PERIODS * period_vtime) &&
+		    time_before64(vdone, now.vnow - period_vtime))
+			nr_lagging++;
+
+		if (waitqueue_active(&iowg->waitq))
+			vusage = now.vnow - iowg->last_vtime;
+		else if (time_before64(iowg->last_vtime, vtime))
+			vusage = vtime - iowg->last_vtime;
+		else
+			vusage = 0;
+
+		iowg->last_vtime += vusage;
+		/*
+		 * Factor in in-flight vtime into vusage to avoid
+		 * high-latency completions appearing as idle.  This should
+		 * be done after the above ->last_time adjustment.
+		 */
+		vusage = max(vusage, vtime - vdone);
+
+		/* calculate hweight based usage ratio and record */
+		if (vusage) {
+			usage = DIV64_U64_ROUND_UP(vusage * hw_inuse,
+						   period_vtime);
+			iowg->usage_idx = (iowg->usage_idx + 1) % NR_USAGE_SLOTS;
+			iowg->usages[iowg->usage_idx] = usage;
+		} else {
+			usage = 0;
+		}
+
+		/* see whether there's surplus vtime */
+		vmargin = iow->margin_us * now.vrate;
+		vmin = now.vnow - vmargin;
+
+		iowg->has_surplus = false;
+
+		if (!waitqueue_active(&iowg->waitq) &&
+		    time_before64(vtime, vmin)) {
+			u64 delta = vmin - vtime;
+
+			/* throw away surplus vtime */
+			atomic64_add(delta, &iowg->vtime);
+			atomic64_add(delta, &iowg->done_vtime);
+			iowg->last_vtime += delta;
+			/* if usage is sufficiently low, maybe it can donate */
+			if (surplus_adjusted_hweight_inuse(usage, hw_inuse)) {
+				iowg->has_surplus = true;
+				nr_surpluses++;
+			}
+		} else if (hw_inuse < hw_active) {
+			u32 new_hwi, new_inuse;
+
+			/* was donating but might need to take back some */
+			if (waitqueue_active(&iowg->waitq)) {
+				new_hwi = hw_active;
+			} else {
+				new_hwi = max(hw_inuse,
+					      usage * SURPLUS_SCALE_PCT / 100 +
+					      SURPLUS_SCALE_ABS);
+			}
+
+			new_inuse = div64_u64((u64)iowg->inuse * new_hwi,
+					      hw_inuse);
+			new_inuse = clamp_t(u32, new_inuse, 1, iowg->active);
+
+			if (new_inuse > iowg->inuse) {
+				TRACE_IOWG_PATH(inuse_takeback, iowg, &now,
+						iowg->inuse, new_inuse,
+						hw_inuse, new_hwi);
+				__propagate_active_weight(iowg, iowg->weight,
+							  new_inuse);
+			}
+		} else {
+			/* genuninely out of vtime */
+			nr_shortages++;
+		}
+	}
+
+	if (!nr_shortages || !nr_surpluses)
+		goto skip_surplus_transfers;
+
+	/* there are both shortages and surpluses, transfer surpluses */
+	list_for_each_entry(iowg, &iow->active_iowgs, active_list) {
+		u32 usage, hw_active, hw_inuse, new_hwi, new_inuse;
+		int nr_valid = 0;
+
+		if (!iowg->has_surplus)
+			continue;
+
+		/* base the decision on max historical usage */
+		for (i = 0, usage = 0; i < NR_USAGE_SLOTS; i++) {
+			if (iowg->usages[i]) {
+				usage = max(usage, iowg->usages[i]);
+				nr_valid++;
+			}
+		}
+		if (nr_valid < MIN_VALID_USAGES)
+			continue;
+
+		current_hweight(iowg, &hw_active, &hw_inuse);
+		new_hwi = surplus_adjusted_hweight_inuse(usage, hw_inuse);
+		if (!new_hwi)
+			continue;
+
+		new_inuse = DIV64_U64_ROUND_UP((u64)iowg->inuse * new_hwi,
+					       hw_inuse);
+		if (new_inuse < iowg->inuse) {
+			TRACE_IOWG_PATH(inuse_giveaway, iowg, &now,
+					iowg->inuse, new_inuse,
+					hw_inuse, new_hwi);
+			__propagate_active_weight(iowg, iowg->weight, new_inuse);
+		}
+	}
+skip_surplus_transfers:
+	commit_active_weights(iow);
+
+	/*
+	 * If q is getting clogged or we're missing too much, we're issuing
+	 * too much IO and should lower vtime rate.  If we're not missing
+	 * and experiencing shortages but not surpluses, we're too stingy
+	 * and should increase vtime rate.
+	 */
+	if (rq_wait_pct > RQ_WAIT_BUSY_PCT ||
+	    missed_ppm[READ] > ppm_rthr ||
+	    missed_ppm[WRITE] > ppm_wthr) {
+		iow->busy_level = max(iow->busy_level, 0);
+		iow->busy_level++;
+	} else if (nr_lagging) {
+		iow->busy_level = max(iow->busy_level, 0);
+	} else if (nr_shortages && !nr_surpluses &&
+		   rq_wait_pct <= RQ_WAIT_BUSY_PCT * UNBUSY_THR_PCT / 100 &&
+		   missed_ppm[READ] <= ppm_rthr * UNBUSY_THR_PCT / 100 &&
+		   missed_ppm[WRITE] <= ppm_wthr * UNBUSY_THR_PCT / 100) {
+		iow->busy_level = min(iow->busy_level, 0);
+		iow->busy_level--;
+	} else {
+		iow->busy_level = 0;
+	}
+
+	iow->busy_level = clamp(iow->busy_level, -1000, 1000);
+
+	if (iow->busy_level) {
+		u64 vrate = atomic64_read(&iow->vtime_rate);
+		u64 vrate_min = iow->vrate_min, vrate_max = iow->vrate_max;
+
+		/* rq_wait signal is always reliable, ignore user vrate_min */
+		if (rq_wait_pct > RQ_WAIT_BUSY_PCT)
+			vrate_min = VRATE_MIN;
+
+		/*
+		 * If vrate is out of bounds, apply clamp gradually as the
+		 * bounds can change abruptly.  Otherwise, apply busy_level
+		 * based adjustment.
+		 */
+		if (vrate < vrate_min) {
+			vrate = div64_u64(vrate * (100 + VRATE_CLAMP_ADJ_PCT),
+					  100);
+			vrate = min(vrate, vrate_min);
+		} else if (vrate > vrate_max) {
+			vrate = div64_u64(vrate * (100 - VRATE_CLAMP_ADJ_PCT),
+					  100);
+			vrate = max(vrate, vrate_max);
+		} else {
+			int idx = min_t(int, abs(iow->busy_level),
+					ARRAY_SIZE(vrate_adj_pct) - 1);
+			u32 adj_pct = vrate_adj_pct[idx];
+
+			if (iow->busy_level > 0)
+				adj_pct = 100 - adj_pct;
+			else
+				adj_pct = 100 + adj_pct;
+
+			vrate = clamp(DIV64_U64_ROUND_UP(vrate * adj_pct, 100),
+				      vrate_min, vrate_max);
+		}
+
+		trace_ioweight_iow_vrate_adj(iow, vrate, &missed_ppm, rq_wait_pct,
+					     nr_lagging, nr_shortages,
+					     nr_surpluses);
+
+		atomic64_set(&iow->vtime_rate, vrate);
+		iow->inuse_margin_vtime = DIV64_U64_ROUND_UP(
+			iow->period_us * vrate * INUSE_MARGIN_PCT, 100);
+	}
+
+	iow_refresh_params(iow, false);
+
+	/*
+	 * This period is done.  Move onto the next one.  If nothing's
+	 * going on with the device, stop the timer.
+	 */
+	atomic64_inc(&iow->cur_period);
+
+	if (iow->running != IOW_STOP) {
+		if (!list_empty(&iow->active_iowgs)) {
+			iow_start_period(iow, &now);
+		} else {
+			iow->busy_level = 0;
+			iow->running = IOW_IDLE;
+		}
+	}
+
+	spin_unlock_irq(&iow->lock);
+}
+
+static void calc_vtime_cost_builtin(struct bio *bio, struct iow_gq *iowg,
+				    bool is_merge, u64 *costp)
+{
+	struct iow *iow = iowg->iow;
+	u64 coef_seqio, coef_randio, coef_page;
+	u64 pages = max_t(u64, bio_sectors(bio) >> IOW_SECT_TO_PAGE_SHIFT, 1);
+	u64 seek_pages = 0;
+	u64 cost = 0;
+
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
+		coef_seqio	= iow->params.lcoefs[LCOEF_RSEQIO];
+		coef_randio	= iow->params.lcoefs[LCOEF_RRANDIO];
+		coef_page	= iow->params.lcoefs[LCOEF_RPAGE];
+		break;
+	case REQ_OP_WRITE:
+		coef_seqio	= iow->params.lcoefs[LCOEF_WSEQIO];
+		coef_randio	= iow->params.lcoefs[LCOEF_WRANDIO];
+		coef_page	= iow->params.lcoefs[LCOEF_WPAGE];
+		break;
+	default:
+		goto out;
+	}
+
+	if (iowg->cursor) {
+		seek_pages = abs(bio->bi_iter.bi_sector - iowg->cursor);
+		seek_pages >>= IOW_SECT_TO_PAGE_SHIFT;
+	}
+
+	if (!is_merge) {
+		if (seek_pages > LCOEF_RANDIO_PAGES) {
+			cost += coef_randio;
+		} else {
+			cost += coef_seqio;
+		}
+	}
+	cost += pages * coef_page;
+out:
+	*costp = cost;
+}
+
+static u64 calc_vtime_cost(struct bio *bio, struct iow_gq *iowg, bool is_merge)
+{
+	u64 cost;
+
+	calc_vtime_cost_builtin(bio, iowg, is_merge, &cost);
+	return cost;
+}
+
+static void iow_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
+{
+	struct blkcg_gq *blkg = bio->bi_blkg;
+	struct iow *iow = rqos_to_iow(rqos);
+	struct iow_gq *iowg = blkg_to_iowg(blkg);
+	struct iow_now now;
+	struct iowg_wait wait;
+	u32 hw_active, hw_inuse;
+	u64 abs_cost, cost, vtime;
+
+	/* bypass IOs if disabled or for root cgroup */
+	if (!iow->enabled || !iowg->level)
+		return;
+
+	/* always activate so that even 0 cost IOs get protected to some level */
+	if (!iowg_activate(iowg, &now))
+		return;
+
+	/* calculate the absolute vtime cost */
+	abs_cost = calc_vtime_cost(bio, iowg, false);
+	if (!abs_cost)
+		return;
+
+	iowg->cursor = bio_end_sector(bio);
+
+	vtime = atomic64_read(&iowg->vtime);
+	current_hweight(iowg, &hw_active, &hw_inuse);
+
+	if (hw_inuse < hw_active &&
+	    time_after_eq64(vtime + iow->inuse_margin_vtime, now.vnow)) {
+		TRACE_IOWG_PATH(inuse_reset, iowg, &now,
+				iowg->inuse, iowg->weight, hw_inuse, hw_active);
+		spin_lock_irq(&iow->lock);
+		propagate_active_weight(iowg, iowg->weight, iowg->weight);
+		spin_unlock_irq(&iow->lock);
+		current_hweight(iowg, &hw_active, &hw_inuse);
+	}
+
+	cost = abs_cost_to_cost(abs_cost, hw_inuse);
+
+	/*
+	 * If no one's waiting and within budget, issue right away.  The
+	 * tests are racy but the races aren't systemic - we only miss once
+	 * in a while which is fine.
+	 */
+	if (!waitqueue_active(&iowg->waitq) &&
+	    time_before_eq64(vtime + cost, now.vnow)) {
+		iowg_commit_bio(iowg, bio, cost);
+		return;
+	}
+
+	if (bio_issue_as_root_blkg(bio) || fatal_signal_pending(current)) {
+		iowg_commit_bio(iowg, bio, cost);
+		iowg_kick_delay(iowg, &now, cost);
+		return;
+	}
+
+	/*
+	 * Append self to the waitq and schedule the wakeup timer if we're
+	 * the first waiter.  The timer duration is calculated based on the
+	 * current vrate.  vtime and hweight changes can make it too short
+	 * or too long.  Each wait entry records the absolute cost it's
+	 * waiting for to allow re-evaluation using a custom wait entry.
+	 *
+	 * If too short, the timer simply reschedules itself.  If too long,
+	 * the period timer will notice and trigger wakeups.
+	 *
+	 * All waiters are on iowg->waitq and the wait states are
+	 * synchronized using waitq.lock.
+	 */
+	spin_lock_irq(&iowg->waitq.lock);
+
+	/*
+	 * We activated above but w/o any synchronization.  Deactivation is
+	 * synchronized with waitq.lock and we won't get deactivated as
+	 * long as we're waiting, so we're good if we're activated here.
+	 * In the unlikely case that we are deactivated, just issue the IO.
+	 */
+	if (unlikely(list_empty(&iowg->active_list))) {
+		spin_unlock_irq(&iowg->waitq.lock);
+		iowg_commit_bio(iowg, bio, cost);
+		return;
+	}
+
+	init_waitqueue_func_entry(&wait.wait, iowg_wake_fn);
+	wait.wait.private = current;
+	wait.bio = bio;
+	wait.abs_cost = abs_cost;
+	wait.committed = false;	/* will be set true by waker */
+
+	__add_wait_queue_entry_tail(&iowg->waitq, &wait.wait);
+	iowg_kick_waitq(iowg, &now);
+
+	spin_unlock_irq(&iowg->waitq.lock);
+
+	while (true) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (wait.committed)
+			break;
+		io_schedule();
+	}
+
+	/* waker already committed us, proceed */
+	finish_wait(&iowg->waitq, &wait.wait);
+}
+
+static void iow_rqos_merge(struct rq_qos *rqos, struct request *rq,
+			   struct bio *bio)
+{
+	struct iow_gq *iowg = blkg_to_iowg(bio->bi_blkg);
+	sector_t bio_end = bio_end_sector(bio);
+	u32 hw_active, hw_inuse;
+	u64 abs_cost, cost;
+
+	/* add iff the existing request has cost assigned */
+	if (!rq->bio || !rq->bio->bi_ioweight_cost)
+		return;
+
+	abs_cost = calc_vtime_cost(bio, iowg, true);
+	if (!abs_cost)
+		return;
+
+	/* update cursor if backmerging into the request at the cursor */
+	if (blk_rq_pos(rq) < bio_end &&
+	    blk_rq_pos(rq) + blk_rq_sectors(rq) == iowg->cursor)
+		iowg->cursor = bio_end;
+
+	current_hweight(iowg, &hw_active, &hw_inuse);
+	cost = div64_u64(abs_cost * HWEIGHT_WHOLE, hw_inuse);
+	bio->bi_ioweight_cost = cost;
+
+	atomic64_add(cost, &iowg->vtime);
+}
+
+static void iow_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
+{
+	struct iow_gq *iowg = blkg_to_iowg(bio->bi_blkg);
+
+	if (iowg && bio->bi_ioweight_cost)
+		atomic64_add(bio->bi_ioweight_cost, &iowg->done_vtime);
+}
+
+static void iow_rqos_done(struct rq_qos *rqos, struct request *rq)
+{
+	struct iow *iow = rqos_to_iow(rqos);
+	u64 on_q_ns, rq_wait_ns;
+	int pidx, rw;
+
+	if (!iow->enabled || !rq->pre_start_time_ns || !rq->start_time_ns)
+		return;
+
+	switch (req_op(rq) & REQ_OP_MASK) {
+	case REQ_OP_READ:
+		pidx = QOS_RLAT;
+		rw = READ;
+		break;
+	case REQ_OP_WRITE:
+		pidx = QOS_WLAT;
+		rw = WRITE;
+		break;
+	default:
+		return;
+	}
+
+	on_q_ns = ktime_get_ns() - rq->pre_start_time_ns;
+	rq_wait_ns = rq->start_time_ns - rq->pre_start_time_ns;
+
+	if (on_q_ns <= iow->params.qos[pidx] * NSEC_PER_USEC)
+		this_cpu_inc(iow->pcpu_stat->missed[rw].nr_met);
+	else
+		this_cpu_inc(iow->pcpu_stat->missed[rw].nr_missed);
+
+	this_cpu_add(iow->pcpu_stat->rq_wait_ns, rq_wait_ns);
+}
+
+static void iow_rqos_queue_depth_changed(struct rq_qos *rqos)
+{
+	struct iow *iow = rqos_to_iow(rqos);
+
+	spin_lock_irq(&iow->lock);
+	iow_refresh_params(iow, false);
+	spin_unlock_irq(&iow->lock);
+}
+
+static void iow_rqos_exit(struct rq_qos *rqos)
+{
+	struct iow *iow = rqos_to_iow(rqos);
+
+	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iow);
+
+	spin_lock_irq(&iow->lock);
+	iow->running = IOW_STOP;
+	spin_unlock_irq(&iow->lock);
+
+	del_timer_sync(&iow->timer);
+	free_percpu(iow->pcpu_stat);
+	kfree(iow);
+}
+
+static struct rq_qos_ops iow_rqos_ops = {
+	.throttle = iow_rqos_throttle,
+	.merge = iow_rqos_merge,
+	.done_bio = iow_rqos_done_bio,
+	.done = iow_rqos_done,
+	.queue_depth_changed = iow_rqos_queue_depth_changed,
+	.exit = iow_rqos_exit,
+};
+
+static int blk_ioweight_init(struct request_queue *q)
+{
+	struct iow *iow;
+	struct rq_qos *rqos;
+	int ret;
+
+	iow = kzalloc(sizeof(*iow), GFP_KERNEL);
+	if (!iow)
+		return -ENOMEM;
+
+	iow->pcpu_stat = alloc_percpu(struct iow_pcpu_stat);
+	if (!iow->pcpu_stat) {
+		kfree(iow);
+		return -ENOMEM;
+	}
+
+	rqos = &iow->rqos;
+	rqos->id = RQ_QOS_WEIGHT;
+	rqos->ops = &iow_rqos_ops;
+	rqos->q = q;
+
+	spin_lock_init(&iow->lock);
+	timer_setup(&iow->timer, iow_timer_fn, 0);
+	INIT_LIST_HEAD(&iow->active_iowgs);
+
+	iow->running = IOW_IDLE;
+	atomic64_set(&iow->vtime_rate, VTIME_PER_USEC);
+	seqcount_init(&iow->period_seqcount);
+	iow->period_at = ktime_to_us(ktime_get());
+	atomic64_set(&iow->cur_period, 0);
+	atomic_set(&iow->hweight_gen, 0);
+
+	spin_lock_irq(&iow->lock);
+	iow->autop_idx = AUTOP_INVALID;
+	iow_refresh_params(iow, true);
+	spin_unlock_irq(&iow->lock);
+
+	rq_qos_add(q, rqos);
+	ret = blkcg_activate_policy(q, &blkcg_policy_iow);
+	if (ret) {
+		rq_qos_del(q, rqos);
+		kfree(iow);
+		return ret;
+	}
+	return 0;
+}
+
+static struct blkcg_policy_data *iow_cpd_alloc(gfp_t gfp)
+{
+	struct iow_cgrp *iowc;
+
+	iowc = kzalloc(sizeof(struct iow_cgrp), gfp);
+	iowc->dfl_weight = CGROUP_WEIGHT_DFL;
+
+	return &iowc->cpd;
+}
+
+static void iow_cpd_free(struct blkcg_policy_data *cpd)
+{
+	kfree(container_of(cpd, struct iow_cgrp, cpd));
+}
+
+static struct blkg_policy_data *iow_pd_alloc(gfp_t gfp, struct request_queue *q,
+					     struct blkcg *blkcg)
+{
+	int levels = blkcg->css.cgroup->level + 1;
+	struct iow_gq *iowg;
+
+	iowg = kzalloc_node(sizeof(*iowg) + levels * sizeof(iowg->ancestors[0]),
+			    gfp, q->node);
+	if (!iowg)
+		return NULL;
+
+	return &iowg->pd;
+}
+
+static void iow_pd_init(struct blkg_policy_data *pd)
+{
+	struct iow_gq *iowg = pd_to_iowg(pd);
+	struct blkcg_gq *blkg = pd_to_blkg(&iowg->pd);
+	struct iow *iow = q_to_iow(blkg->q);
+	struct iow_now now;
+	struct blkcg_gq *tblkg;
+	unsigned long flags;
+
+	iow_now(iow, &now);
+
+	iowg->iow = iow;
+	atomic64_set(&iowg->vtime, now.vnow);
+	atomic64_set(&iowg->done_vtime, now.vnow);
+	atomic64_set(&iowg->active_period, atomic64_read(&iow->cur_period));
+	INIT_LIST_HEAD(&iowg->active_list);
+
+	init_waitqueue_head(&iowg->waitq);
+	hrtimer_init(&iowg->waitq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	iowg->waitq_timer.function = iowg_waitq_timer_fn;
+	hrtimer_init(&iowg->delay_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	iowg->delay_timer.function = iowg_delay_timer_fn;
+
+	iowg->level = blkg->blkcg->css.cgroup->level;
+
+	for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
+		struct iow_gq *tiowg = blkg_to_iowg(tblkg);
+		iowg->ancestors[tiowg->level] = tiowg;
+	}
+
+	spin_lock_irqsave(&iow->lock, flags);
+	weight_updated(iowg);
+	spin_unlock_irqrestore(&iow->lock, flags);
+}
+
+static void iow_pd_free(struct blkg_policy_data *pd)
+{
+	struct iow_gq *iowg = pd_to_iowg(pd);
+	struct iow *iow = iowg->iow;
+
+	if (iow) {
+		hrtimer_cancel(&iowg->waitq_timer);
+		hrtimer_cancel(&iowg->delay_timer);
+
+		spin_lock(&iow->lock);
+		if (!list_empty(&iowg->active_list)) {
+			propagate_active_weight(iowg, 0, 0);
+			list_del_init(&iowg->active_list);
+		}
+		spin_unlock(&iow->lock);
+	}
+	kfree(iowg);
+}
+
+static u64 iow_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
+			     int off)
+{
+	const char *dname = blkg_dev_name(pd->blkg);
+	struct iow_gq *iowg = pd_to_iowg(pd);
+
+	if (dname && iowg->cfg_weight)
+		seq_printf(sf, "%s %u\n", dname, iowg->cfg_weight);
+	return 0;
+}
+
+
+static int iow_weight_show(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct iow_cgrp *iowc = blkcg_to_iowc(blkcg);
+
+	seq_printf(sf, "default %u\n", iowc->dfl_weight);
+	blkcg_print_blkgs(sf, blkcg, iow_weight_prfill,
+			  &blkcg_policy_iow, seq_cft(sf)->private, false);
+	return 0;
+}
+
+static ssize_t iow_weight_write(struct kernfs_open_file *of, char *buf,
+				size_t nbytes, loff_t off)
+{
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	struct iow_cgrp *iowc = blkcg_to_iowc(blkcg);
+	struct blkg_conf_ctx ctx;
+	struct iow_gq *iowg;
+	u32 v;
+	int ret;
+
+	if (!strchr(buf, ':')) {
+		struct blkcg_gq *blkg;
+
+		if (!sscanf(buf, "default %u", &v) && !sscanf(buf, "%u", &v))
+			return -EINVAL;
+
+		if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
+			return -EINVAL;
+
+		spin_lock(&blkcg->lock);
+		iowc->dfl_weight = v;
+		hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+			struct iow_gq *iowg = blkg_to_iowg(blkg);
+
+			if (iowg) {
+				spin_lock_irq(&iowg->iow->lock);
+				weight_updated(iowg);
+				spin_unlock_irq(&iowg->iow->lock);
+			}
+		}
+		spin_unlock(&blkcg->lock);
+
+		return nbytes;
+	}
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_iow, buf, &ctx);
+	if (ret)
+		return ret;
+
+	iowg = blkg_to_iowg(ctx.blkg);
+
+	if (!strncmp(ctx.body, "default", 7)) {
+		v = 0;
+	} else {
+		if (!sscanf(ctx.body, "%u", &v))
+			goto einval;
+		if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
+			goto einval;
+	}
+
+	spin_lock_irq(&iowg->iow->lock);
+	iowg->cfg_weight = v;
+	weight_updated(iowg);
+	spin_unlock_irq(&iowg->iow->lock);
+
+	blkg_conf_finish(&ctx);
+	return nbytes;
+
+einval:
+	blkg_conf_finish(&ctx);
+	return -EINVAL;
+}
+
+static u64 iow_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
+			  int off)
+{
+	const char *dname = blkg_dev_name(pd->blkg);
+	struct iow *iow = pd_to_iowg(pd)->iow;
+
+	if (!dname)
+		return 0;
+
+	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
+		   dname, iow->enabled, iow->user_qos_params ? "user" : "auto",
+		   iow->params.qos[QOS_RPPM] / 10000,
+		   iow->params.qos[QOS_RPPM] % 10000 / 100,
+		   iow->params.qos[QOS_RLAT],
+		   iow->params.qos[QOS_WPPM] / 10000,
+		   iow->params.qos[QOS_WPPM] % 10000 / 100,
+		   iow->params.qos[QOS_WLAT],
+		   iow->params.qos[QOS_MIN] / 10000,
+		   iow->params.qos[QOS_MIN] % 10000 / 100,
+		   iow->params.qos[QOS_MAX] / 10000,
+		   iow->params.qos[QOS_MAX] % 10000 / 100);
+	return 0;
+}
+
+static int iow_qos_show(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+
+	blkcg_print_blkgs(sf, blkcg, iow_qos_prfill,
+			  &blkcg_policy_iow, seq_cft(sf)->private, false);
+	return 0;
+}
+
+static const match_table_t qos_ctrl_tokens = {
+	{ QOS_ENABLE,		"enable=%u"	},
+	{ QOS_CTRL,		"ctrl=%s"	},
+	{ NR_QOS_CTRL_PARAMS,	NULL		},
+};
+
+static const match_table_t qos_tokens = {
+	{ QOS_RPPM,		"rpct=%s"	},
+	{ QOS_RLAT,		"rlat=%u"	},
+	{ QOS_WPPM,		"wpct=%s"	},
+	{ QOS_WLAT,		"wlat=%u"	},
+	{ QOS_MIN,		"min=%s"	},
+	{ QOS_MAX,		"max=%s"	},
+	{ NR_QOS_PARAMS,	NULL		},
+};
+
+static ssize_t iow_qos_write(struct kernfs_open_file *of, char *input,
+			     size_t nbytes, loff_t off)
+{
+	struct gendisk *disk;
+	struct iow *iow;
+	u32 qos[NR_QOS_PARAMS];
+	bool enable, user;
+	char *p;
+	int ret;
+
+	disk = blkcg_conf_get_disk(&input);
+	if (IS_ERR(disk))
+		return PTR_ERR(disk);
+
+	iow = q_to_iow(disk->queue);
+	if (!iow) {
+		ret = blk_ioweight_init(disk->queue);
+		if (ret)
+			goto err;
+		iow = q_to_iow(disk->queue);
+	}
+
+	spin_lock_irq(&iow->lock);
+	memcpy(qos, iow->params.qos, sizeof(qos));
+	enable = iow->enabled;
+	user = iow->user_qos_params;
+	spin_unlock_irq(&iow->lock);
+
+	while ((p = strsep(&input, " \t\n"))) {
+		substring_t args[MAX_OPT_ARGS];
+		char buf[32];
+		int tok;
+		s64 v;
+
+		if (!*p)
+			continue;
+
+		switch (match_token(p, qos_ctrl_tokens, args)) {
+		case QOS_ENABLE:
+			match_u64(&args[0], &v);
+			enable = v;
+			continue;
+		case QOS_CTRL:
+			match_strlcpy(buf, &args[0], sizeof(buf));
+			if (!strcmp(buf, "auto"))
+				user = false;
+			else if (!strcmp(buf, "user"))
+				user = true;
+			else
+				goto einval;
+			continue;
+		}
+
+		tok = match_token(p, qos_tokens, args);
+		switch (tok) {
+		case QOS_RPPM:
+		case QOS_WPPM:
+			if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
+			    sizeof(buf))
+				goto einval;
+			if (cgroup_parse_float(buf, 4, &v))
+				goto einval;
+			qos[tok] = clamp_t(s64, v, 0, MILLION);
+			break;
+		case QOS_RLAT:
+		case QOS_WLAT:
+			if (match_u64(&args[0], &v))
+				goto einval;
+			qos[tok] = v;
+			break;
+		case QOS_MIN:
+		case QOS_MAX:
+			if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
+			    sizeof(buf))
+				goto einval;
+			if (cgroup_parse_float(buf, 4, &v))
+				goto einval;
+			qos[tok] = clamp_t(s64, v, VRATE_MIN_PPM, VRATE_MAX_PPM);
+			break;
+		default:
+			goto einval;
+		}
+		user = true;
+	}
+
+	if (qos[QOS_MIN] > qos[QOS_MAX])
+		goto einval;
+
+	spin_lock_irq(&iow->lock);
+
+	if (enable) {
+		blk_queue_flag_set(QUEUE_FLAG_REC_PRESTART, iow->rqos.q);
+		iow->enabled = true;
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_REC_PRESTART, iow->rqos.q);
+		iow->enabled = false;
+	}
+
+	if (user) {
+		memcpy(iow->params.qos, qos, sizeof(qos));
+		iow->user_qos_params = true;
+	} else {
+		iow->user_qos_params = false;
+	}
+
+	iow_refresh_params(iow, true);
+	spin_unlock_irq(&iow->lock);
+
+	put_disk_and_module(disk);
+	return nbytes;
+einval:
+	ret = -EINVAL;
+err:
+	put_disk_and_module(disk);
+	return ret;
+}
+
+static u64 iow_cost_model_prfill(struct seq_file *sf,
+				 struct blkg_policy_data *pd, int off)
+{
+	const char *dname = blkg_dev_name(pd->blkg);
+	struct iow *iow = pd_to_iowg(pd)->iow;
+	u64 *u = iow->params.i_lcoefs;
+
+	if (!dname)
+		return 0;
+
+	seq_printf(sf, "%s ctrl=%s model=linear "
+		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
+		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
+		   dname, iow->user_cost_model ? "user" : "auto",
+		   u[I_LCOEF_RBPS],
+		   u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
+		   u[I_LCOEF_WBPS],
+		   u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
+	return 0;
+}
+
+static int iow_cost_model_show(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+
+	blkcg_print_blkgs(sf, blkcg, iow_cost_model_prfill,
+			  &blkcg_policy_iow, seq_cft(sf)->private, false);
+	return 0;
+}
+
+static const match_table_t cost_ctrl_tokens = {
+	{ COST_CTRL,		"ctrl=%s"	},
+	{ COST_MODEL,		"model=%s"	},
+	{ NR_COST_CTRL_PARAMS,	NULL		},
+};
+
+static const match_table_t i_lcoef_tokens = {
+	{ I_LCOEF_RBPS,		"rbps=%u"	},
+	{ I_LCOEF_RSEQIOPS,	"rseqiops=%u"	},
+	{ I_LCOEF_RRANDIOPS,	"rrandiops=%u"	},
+	{ I_LCOEF_WBPS,		"wbps=%u"	},
+	{ I_LCOEF_WSEQIOPS,	"wseqiops=%u"	},
+	{ I_LCOEF_WRANDIOPS,	"wrandiops=%u"	},
+	{ NR_I_LCOEFS,		NULL		},
+};
+
+ssize_t iow_cost_model_write(struct kernfs_open_file *of, char *input,
+			     size_t nbytes, loff_t off)
+{
+	struct gendisk *disk;
+	struct iow *iow;
+	u64 u[NR_I_LCOEFS];
+	bool user;
+	char *p;
+	int ret;
+
+	disk = blkcg_conf_get_disk(&input);
+	if (IS_ERR(disk))
+		return PTR_ERR(disk);
+
+	iow = q_to_iow(disk->queue);
+	if (!iow) {
+		ret = blk_ioweight_init(disk->queue);
+		if (ret)
+			goto err;
+		iow = q_to_iow(disk->queue);
+	}
+
+	spin_lock_irq(&iow->lock);
+	memcpy(u, iow->params.i_lcoefs, sizeof(u));
+	user = iow->user_cost_model;
+	spin_unlock_irq(&iow->lock);
+
+	while ((p = strsep(&input, " \t\n"))) {
+		substring_t args[MAX_OPT_ARGS];
+		char buf[32];
+		int tok;
+		u64 v;
+
+		if (!*p)
+			continue;
+
+		switch (match_token(p, cost_ctrl_tokens, args)) {
+		case COST_CTRL:
+			match_strlcpy(buf, &args[0], sizeof(buf));
+			if (!strcmp(buf, "auto"))
+				user = false;
+			else if (!strcmp(buf, "user"))
+				user = true;
+			else
+				goto einval;
+			continue;
+		case COST_MODEL:
+			match_strlcpy(buf, &args[0], sizeof(buf));
+			if (strcmp(buf, "linear"))
+				goto einval;
+			continue;
+		}
+
+		tok = match_token(p, i_lcoef_tokens, args);
+		if (tok == NR_I_LCOEFS)
+			goto einval;
+		if (match_u64(&args[0], &v))
+			goto einval;
+		u[tok] = v;
+		user = true;
+	}
+
+	spin_lock_irq(&iow->lock);
+	if (user) {
+		memcpy(iow->params.i_lcoefs, u, sizeof(u));
+		iow->user_cost_model = true;
+	} else {
+		iow->user_cost_model = false;
+	}
+	iow_refresh_params(iow, true);
+	spin_unlock_irq(&iow->lock);
+
+	put_disk_and_module(disk);
+	return nbytes;
+
+einval:
+	ret = -EINVAL;
+err:
+	put_disk_and_module(disk);
+	return ret;
+}
+
+static struct cftype iow_files[] = {
+	{
+		.name = "weight",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = iow_weight_show,
+		.write = iow_weight_write,
+	},
+	{
+		.name = "weight.qos",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.seq_show = iow_qos_show,
+		.write = iow_qos_write,
+	},
+	{
+		.name = "weight.cost_model",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.seq_show = iow_cost_model_show,
+		.write = iow_cost_model_write,
+	},
+	{}
+};
+
+static struct blkcg_policy blkcg_policy_iow = {
+	.dfl_cftypes	= iow_files,
+	.cpd_alloc_fn	= iow_cpd_alloc,
+	.cpd_free_fn	= iow_cpd_free,
+	.pd_alloc_fn	= iow_pd_alloc,
+	.pd_init_fn	= iow_pd_init,
+	.pd_free_fn	= iow_pd_free,
+};
+
+static int __init iow_init(void)
+{
+	return blkcg_policy_register(&blkcg_policy_iow);
+}
+
+static void __exit iow_exit(void)
+{
+	return blkcg_policy_unregister(&blkcg_policy_iow);
+}
+
+module_init(iow_init);
+module_exit(iow_exit);
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 5f8b75826a98..1db79a2b48ff 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -15,6 +15,7 @@ struct blk_mq_debugfs_attr;
 enum rq_qos_id {
 	RQ_QOS_WBT,
 	RQ_QOS_LATENCY,
+	RQ_QOS_WEIGHT,
 };
 
 struct rq_wait {
@@ -84,6 +85,8 @@ static inline const char *rq_qos_id_to_name(enum rq_qos_id id)
 		return "wbt";
 	case RQ_QOS_LATENCY:
 		return "latency";
+	case RQ_QOS_WEIGHT:
+		return "weight";
 	}
 	return "unknown";
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 678932cc42c5..17db42b104bb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -174,6 +174,9 @@ struct bio {
 	 */
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
+#ifdef CONFIG_BLK_CGROUP_IOWEIGHT
+	u64			bi_ioweight_cost;
+#endif
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
diff --git a/include/trace/events/ioweight.h b/include/trace/events/ioweight.h
new file mode 100644
index 000000000000..8e5104f46408
--- /dev/null
+++ b/include/trace/events/ioweight.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ioweight
+
+#if !defined(_TRACE_BLK_IOWEIGHT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BLK_IOWEIGHT_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(ioweight_iowg_activate,
+
+	TP_PROTO(struct iow_gq *iowg, const char *path, struct iow_now *now,
+		u64 last_period, u64 cur_period, u64 vtime),
+
+	TP_ARGS(iowg, path, now, last_period, cur_period, vtime),
+
+	TP_STRUCT__entry (
+		__string(devname, iow_name(iowg->iow))
+		__string(cgroup, path)
+		__field(u64, now)
+		__field(u64, vnow)
+		__field(u64, vrate)
+		__field(u64, last_period)
+		__field(u64, cur_period)
+		__field(u64, last_vtime)
+		__field(u64, vtime)
+		__field(u32, weight)
+		__field(u32, inuse)
+		__field(u64, hweight_active)
+		__field(u64, hweight_inuse)
+	),
+
+	TP_fast_assign(
+		__assign_str(devname, iow_name(iowg->iow));
+		__assign_str(cgroup, path);
+		__entry->now = now->now;
+		__entry->vnow = now->vnow;
+		__entry->vrate = now->vrate;
+		__entry->last_period = last_period;
+		__entry->cur_period = cur_period;
+		__entry->last_vtime = iowg->last_vtime;
+		__entry->vtime = vtime;
+		__entry->weight = iowg->weight;
+		__entry->inuse = iowg->inuse;
+		__entry->hweight_active = iowg->hweight_active;
+		__entry->hweight_inuse = iowg->hweight_inuse;
+	),
+
+	TP_printk("[%s:%s] now=%llu:%llu vrate=%llu "
+		  "period=%llu->%llu vtime=%llu->%llu "
+		  "weight=%u/%u hweight=%llu/%llu",
+		__get_str(devname), __get_str(cgroup),
+		__entry->now, __entry->vnow, __entry->vrate,
+		__entry->last_period, __entry->cur_period,
+		__entry->last_vtime, __entry->vtime,
+		__entry->inuse, __entry->weight,
+		__entry->hweight_inuse, __entry->hweight_active
+	)
+);
+
+DECLARE_EVENT_CLASS(iowg_inuse_update,
+
+	TP_PROTO(struct iow_gq *iowg, const char *path, struct iow_now *now,
+		u32 old_inuse, u32 new_inuse,
+		u64 old_hw_inuse, u64 new_hw_inuse),
+
+	TP_ARGS(iowg, path, now, old_inuse, new_inuse,
+		old_hw_inuse, new_hw_inuse),
+
+	TP_STRUCT__entry (
+		__string(devname, iow_name(iowg->iow))
+		__string(cgroup, path)
+		__field(u64, now)
+		__field(u32, old_inuse)
+		__field(u32, new_inuse)
+		__field(u64, old_hweight_inuse)
+		__field(u64, new_hweight_inuse)
+	),
+
+	TP_fast_assign(
+		__assign_str(devname, iow_name(iowg->iow));
+		__assign_str(cgroup, path);
+		__entry->now = now->now;
+		__entry->old_inuse = old_inuse;
+		__entry->new_inuse = new_inuse;
+		__entry->old_hweight_inuse = old_hw_inuse;
+		__entry->new_hweight_inuse = new_hw_inuse;
+	),
+
+	TP_printk("[%s:%s] now=%llu inuse=%u->%u hw_inuse=%llu->%llu",
+		__get_str(devname), __get_str(cgroup), __entry->now,
+		__entry->old_inuse, __entry->new_inuse,
+		__entry->old_hweight_inuse, __entry->new_hweight_inuse
+	)
+);
+
+DEFINE_EVENT(iowg_inuse_update, ioweight_inuse_takeback,
+
+	TP_PROTO(struct iow_gq *iowg, const char *path, struct iow_now *now,
+		u32 old_inuse, u32 new_inuse,
+		u64 old_hw_inuse, u64 new_hw_inuse),
+
+	TP_ARGS(iowg, path, now, old_inuse, new_inuse,
+		old_hw_inuse, new_hw_inuse)
+);
+
+DEFINE_EVENT(iowg_inuse_update, ioweight_inuse_giveaway,
+
+	TP_PROTO(struct iow_gq *iowg, const char *path, struct iow_now *now,
+		u32 old_inuse, u32 new_inuse,
+		u64 old_hw_inuse, u64 new_hw_inuse),
+
+	TP_ARGS(iowg, path, now, old_inuse, new_inuse,
+		old_hw_inuse, new_hw_inuse)
+);
+
+DEFINE_EVENT(iowg_inuse_update, ioweight_inuse_reset,
+
+	TP_PROTO(struct iow_gq *iowg, const char *path, struct iow_now *now,
+		u32 old_inuse, u32 new_inuse,
+		u64 old_hw_inuse, u64 new_hw_inuse),
+
+	TP_ARGS(iowg, path, now, old_inuse, new_inuse,
+		old_hw_inuse, new_hw_inuse)
+);
+
+TRACE_EVENT(ioweight_iow_vrate_adj,
+
+	TP_PROTO(struct iow *iow, u64 new_vrate, u32 (*missed_ppm)[2],
+		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
+		int nr_surpluses),
+
+	TP_ARGS(iow, new_vrate, missed_ppm, rq_wait_pct, nr_lagging, nr_shortages,
+		nr_surpluses),
+
+	TP_STRUCT__entry (
+		__string(devname, iow_name(iow))
+		__field(u64, old_vrate)
+		__field(u64, new_vrate)
+		__field(int, busy_level)
+		__field(u32, read_missed_ppm)
+		__field(u32, write_missed_ppm)
+		__field(u32, rq_wait_pct)
+		__field(int, nr_lagging)
+		__field(int, nr_shortages)
+		__field(int, nr_surpluses)
+	),
+
+	TP_fast_assign(
+		__assign_str(devname, iow_name(iow));
+		__entry->old_vrate = atomic64_read(&iow->vtime_rate);;
+		__entry->new_vrate = new_vrate;
+		__entry->busy_level = iow->busy_level;
+		__entry->read_missed_ppm = (*missed_ppm)[READ];
+		__entry->write_missed_ppm = (*missed_ppm)[WRITE];
+		__entry->rq_wait_pct = rq_wait_pct;
+		__entry->nr_lagging = nr_lagging;
+		__entry->nr_shortages = nr_shortages;
+		__entry->nr_surpluses = nr_surpluses;
+	),
+
+	TP_printk("[%s] vrate=%llu->%llu busy=%d missed_ppm=%u:%u rq_wait_pct=%u lagging=%d shortages=%d surpluses=%d",
+		__get_str(devname), __entry->old_vrate, __entry->new_vrate,
+		__entry->busy_level,
+		__entry->read_missed_ppm, __entry->write_missed_ppm,
+		__entry->rq_wait_pct, __entry->nr_lagging, __entry->nr_shortages,
+		__entry->nr_surpluses
+	)
+);
+
+#endif /* _TRACE_BLK_IOWEIGHT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

