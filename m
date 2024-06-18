Return-Path: <bpf+bounces-32439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71990DE23
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58443284930
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062B185E68;
	Tue, 18 Jun 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px2Yft+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7641849E8;
	Tue, 18 Jun 2024 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745676; cv=none; b=rlqe+wiep/lGkYqQvmiFsvX28+cimRqSQB6hgo9YewYASalOsBCJcILNZqyP3PelMToAwDTpih4B6FxGLWP/TAgOXlblXHtCGY9ktqnC1WCdQnhplPyDt33Yq0SVVnKTL/BIQRPkMA44plmMmabN8B1+4KksATR6FnFWEFTrMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745676; c=relaxed/simple;
	bh=SXYPkoZDfmM5Ix3tP92WtcgMdtbRQHskPQERvHqGRSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjtC4VHfcwa7btMUvotYdR4CPUY/gylsIcsTI0OwDCwOQUZSaCLxbgdOx126IMxQVHcbZnxsV+fxIndWOWb/9YsPxRpc3Jrcw0Ua7SKRFOsOVJhkemQVwEOCKSuox5fosX2hZo8+8vaeCfxMvc0sFVquLyuRmOadKCgL/+turHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px2Yft+M; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3758fdbd2daso22004115ab.3;
        Tue, 18 Jun 2024 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745674; x=1719350474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNpQW1+Fa5yVpJMM/vdbkqN/XoXZvLH3jAAduQFqjnE=;
        b=Px2Yft+MqJ+U2zvy/+Ktaxf3gzTZnNEeiTk6CePgSKaXMSWlnFFT+BoElLXdYnuvvm
         ybOM7xIG4+eS1f60+HwU3bBwj+jRRmysX9mTnFi4bxJMYP3ADsb3coe3F6Vd9rX+ysNi
         lcjQE/rdmWU6TCXuu0Lq8UY+pX9RMRTgmfHljbbS1u5316Br2ohHvT2mITIz6tdP87ww
         ASZax04KcAD0RH5iaw1gkr7ukNUP+Xd6imQ1NVMtaL0GFuV611cn5Q8F96fxGndH/ol3
         HuX+VqGso7fxMjcr9bK+AtJoMWUo9nAIEdVxD6dPBsMSrApk2RheOFAEJ1ai7NnN2VfH
         L4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745674; x=1719350474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNpQW1+Fa5yVpJMM/vdbkqN/XoXZvLH3jAAduQFqjnE=;
        b=nCraz7OlkkMo3NmCOEDck6y9Vflp+4z20iOLffkOb9DyjZpi9qjtXDsoLNlHaDIoNy
         gtnc+/6dTdcJnLBrV8bob29b4h1pgLqDdn0Toq1rnXcWprMmJI+sin2PeALoBebeoGiU
         mkcGGjGgba3X+CKEYktwlg9ofjTyuAErRKWK2UlV/rkfASiBdfMWl9+UZ+N9z+IbysIn
         kyceO5cW7YqVQQAYcCSDm8R9XIcsxZ8XubHIfk9eni8hh/OkpOfW0neyXFksn2VPBSaN
         5n8eZZrhtW5sFgOmUeQqJjUM943KWwjAmYLAtaVsPPb3VC84X+Vy6GZvkJSIypDf3Epl
         U48g==
X-Forwarded-Encrypted: i=1; AJvYcCWsrP5uypIk/iV7vi6ebYwhIODKl6vEh7nNmSJYpYg5JME1Nv/Vx8zxsjM0uWnMnKQGSLURp2BBJ7FXoldhwSFdHck5
X-Gm-Message-State: AOJu0Yx7UR8aC4bkTM/lOmJwiV7qO3T2bROgCTcKMUvIE9hirJZhtyLQ
	+my9GaNEizh3OelfkGcQAPziu3+I2HE/kHqAdfcGbZqloay5EjOW
X-Google-Smtp-Source: AGHT+IH9nQdfGZz3iGe8BNEgJ+HYJS7xz3dXYDidIgMnMBRkzAElMEdvMBIY2g0DT9ytb6GBt2ov0g==
X-Received: by 2002:a05:6e02:1b0a:b0:375:a994:6de0 with SMTP id e9e14a558f8ab-3761d66ed1fmr8978345ab.13.1718745673625;
        Tue, 18 Jun 2024 14:21:13 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3baa63dsm8473020a12.88.2024.06.18.14.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/30] sched: Factor out cgroup weight conversion functions
Date: Tue, 18 Jun 2024 11:17:20 -1000
Message-ID: <20240618212056.2833381-6-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out sched_weight_from/to_cgroup() which convert between scheduler
shares and cgroup weight. No functional change. The factored out functions
will be used by a new BPF extensible sched_class so that the weights can be
exposed to the BPF programs in a way which is consistent cgroup weights and
easier to interpret.

The weight conversions will be used regardless of cgroup usage. It's just
borrowing the cgroup weight range as it's more intuitive.
CGROUP_WEIGHT_MIN/DFL/MAX constants are moved outside CONFIG_CGROUPS so that
the conversion helpers can always be defined.

v2: The helpers are now defined regardless of COFNIG_CGROUPS.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/cgroup.h |  4 ++--
 kernel/sched/core.c    | 28 +++++++++++++---------------
 kernel/sched/sched.h   | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..3cdaec701600 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -29,8 +29,6 @@
 
 struct kernel_clone_args;
 
-#ifdef CONFIG_CGROUPS
-
 /*
  * All weight knobs on the default hierarchy should use the following min,
  * default and max values.  The default value is the logarithmic center of
@@ -40,6 +38,8 @@ struct kernel_clone_args;
 #define CGROUP_WEIGHT_DFL		100
 #define CGROUP_WEIGHT_MAX		10000
 
+#ifdef CONFIG_CGROUPS
+
 enum {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b088fbeaf26d..0bfbceebc4e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9552,29 +9552,27 @@ static int cpu_local_stat_show(struct seq_file *sf,
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
+static unsigned long tg_weight(struct task_group *tg)
+{
+	return scale_load_down(tg->shares);
+}
+
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
-	struct task_group *tg = css_tg(css);
-	u64 weight = scale_load_down(tg->shares);
-
-	return DIV_ROUND_CLOSEST_ULL(weight * CGROUP_WEIGHT_DFL, 1024);
+	return sched_weight_to_cgroup(tg_weight(css_tg(css)));
 }
 
 static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
-				struct cftype *cft, u64 weight)
+				struct cftype *cft, u64 cgrp_weight)
 {
-	/*
-	 * cgroup weight knobs should use the common MIN, DFL and MAX
-	 * values which are 1, 100 and 10000 respectively.  While it loses
-	 * a bit of range on both ends, it maps pretty well onto the shares
-	 * value used by scheduler and the round-trip conversions preserve
-	 * the original value over the entire range.
-	 */
-	if (weight < CGROUP_WEIGHT_MIN || weight > CGROUP_WEIGHT_MAX)
+	unsigned long weight;
+
+	if (cgrp_weight < CGROUP_WEIGHT_MIN || cgrp_weight > CGROUP_WEIGHT_MAX)
 		return -ERANGE;
 
-	weight = DIV_ROUND_CLOSEST_ULL(weight * 1024, CGROUP_WEIGHT_DFL);
+	weight = sched_weight_from_cgroup(cgrp_weight);
 
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
@@ -9582,7 +9580,7 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
-	unsigned long weight = scale_load_down(css_tg(css)->shares);
+	unsigned long weight = tg_weight(css_tg(css));
 	int last_delta = INT_MAX;
 	int prio, delta;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ed4271cedf5..656a63c0d393 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -244,6 +244,24 @@ static inline void update_avg(u64 *avg, u64 sample)
 #define shr_bound(val, shift)							\
 	(val >> min_t(typeof(shift), shift, BITS_PER_TYPE(typeof(val)) - 1))
 
+/*
+ * cgroup weight knobs should use the common MIN, DFL and MAX values which are
+ * 1, 100 and 10000 respectively. While it loses a bit of range on both ends, it
+ * maps pretty well onto the shares value used by scheduler and the round-trip
+ * conversions preserve the original value over the entire range.
+ */
+static inline unsigned long sched_weight_from_cgroup(unsigned long cgrp_weight)
+{
+	return DIV_ROUND_CLOSEST_ULL(cgrp_weight * 1024, CGROUP_WEIGHT_DFL);
+}
+
+static inline unsigned long sched_weight_to_cgroup(unsigned long weight)
+{
+	return clamp_t(unsigned long,
+		       DIV_ROUND_CLOSEST_ULL(weight * CGROUP_WEIGHT_DFL, 1024),
+		       CGROUP_WEIGHT_MIN, CGROUP_WEIGHT_MAX);
+}
+
 /*
  * !! For sched_setattr_nocheck() (kernel) only !!
  *
-- 
2.45.2


