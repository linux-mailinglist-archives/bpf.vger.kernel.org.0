Return-Path: <bpf+bounces-28349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE068B8CA3
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D46E1F21503
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7913342C;
	Wed,  1 May 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1ven8NB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC2132C1C;
	Wed,  1 May 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576438; cv=none; b=mBBONblxVNv1Y/ARDatc0p7Aco8wztygGyRAp5rM2sFApqc/gLjiY3vuAktM0B2XC/ERSklWQoX66dtdkApfaBRYMF2/ogLDZdn13wPrRydlZtXLmI6jaBN+sq+03syrs9dYhSuj8opZDyAFn57xLvLk81AQq11TQ4/MZj9l6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576438; c=relaxed/simple;
	bh=1TaXLchZIIQq8Q0S2iJIFahxmDwj+k6Fd0DD6Br6kYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDRa5U7Y3K1227vQPArRYuvlmR+fzfd7Mtj0sUe+yGfldcuaHzgd106ATtkMDd4VILnbzqO9nk0ycJnZVLSd6R9GOKdPtvcdJHnLwVlFI8xMvjkNbNFbep1vx7TGXjStGvqN7hrBEyDsrqGCMqJv5P5eH03A3NEmzx+KcPIUDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1ven8NB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so5457712a12.3;
        Wed, 01 May 2024 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576436; x=1715181236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwEgxIWnM32F+RkCian+6qBxGOxyE8YmncEkkrcQ/lM=;
        b=X1ven8NBleWzrRTMgwOri4X3SE57V+hNuwcnm00eSapPyhOIhGmNWweqXjqQowZh4a
         AvqvJAyapoh2WKiti/aNPwc+e61BpXX7uvF7kYB8YdO7JOk7tGpkMydFqIJFhgXygGJg
         qp75n/yqxVDdL+n6yBhQ5d/cTGLWGU5jvnOJZn+bM7fWEZ7OuzZVgcLdELppi6Uqnl1c
         JwmNtOR734Q3cA1kCNQJbBfJzv2W9KgDfcTIQlLm5X4Dty1KQcv1Bt47R0SIzSK47Gmu
         HQVAASIiHujV78dur9phn3jVxjwZbjb3Ms9tqd9iXGOtbcZb7GEYhGC25CAwBpnQdQWP
         9+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576436; x=1715181236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwEgxIWnM32F+RkCian+6qBxGOxyE8YmncEkkrcQ/lM=;
        b=j4R7TAgW44S3NKEZeR9J10AjnQjwKAB9CscRTWN9BX09ZZlCjGypLD5+9gyyLbBcIz
         7tI8lURx0IyNKFTst5zKOlEO0s3Cfd7KScQBjuVLdpzo1jOSb6SPavFYcFhAP4MZzv0V
         Dt0bawyefXIGvckHEYffvQhM8QndKzVJgYFLBtaBDuNTW+m9hTaA7DKDlFlwE/yyDmQw
         nlxWCvPjpxM2+CieSZfBK0noDVQ6zMrg2I5WH+5fh/iU02tFw291tQVjAJbkPCepaRhG
         jBge7M/j9PLYnnrCB3B/LeKJnJi9RwhME8PNK4Do2qF71N6jzZ92WFKTQUBi5giayg3H
         Fj6g==
X-Forwarded-Encrypted: i=1; AJvYcCWLRZRRUMO0R4K3+F+xlRp7gT2hNkPAEPDP6wryuN9P/2aR3c7kygSELjd9rxhCQMbNMWmY3/pKPIWsLholFeHLe97h
X-Gm-Message-State: AOJu0YyOa4xghoHaMtr/8J4kTgEdhmFX3N33dXg5bbeSR9W47JcNUURN
	ID5INTY40xdO/5fAYBmdLQhSiipQLAWZg4fW2jTAypliSrUaVVNM
X-Google-Smtp-Source: AGHT+IEwtElQk62uHLg4jd2meq8S74Er33NRSjGgoEAuMbYhnxt8sctLxBBKBhAEaULGw21ZpKRdkw==
X-Received: by 2002:a17:90b:4b41:b0:2af:8fa4:40e with SMTP id mi1-20020a17090b4b4100b002af8fa4040emr2675934pjb.1.1714576435472;
        Wed, 01 May 2024 08:13:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090aac0900b002ad059491f6sm1443299pjq.5.2024.05.01.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:55 -0700 (PDT)
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
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/39] sched_ext: Print sched_ext info when dumping stack
Date: Wed,  1 May 2024 05:09:54 -1000
Message-ID: <20240501151312.635565-20-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Vernet <void@manifault.com>

It would be useful to see what the sched_ext scheduler state is, and what
scheduler is running, when we're dumping a task's stack. This patch
therefore adds a new print_scx_info() function that's called in the same
context as print_worker_info() and print_stop_info(). An example dump
follows.

  BUG: kernel NULL pointer dereference, address: 0000000000000999
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] PREEMPT SMP
  CPU: 13 PID: 2047 Comm: insmod Tainted: G           O       6.6.0-work-10323-gb58d4cae8e99-dirty #34
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS unknown 2/2/2022
  Sched_ext: qmap (enabled+all), task: runnable_at=-17ms
  RIP: 0010:init_module+0x9/0x1000 [test_module]
  ...

v3: - scx_ops_enable_state_str[] definition moved to an earlier patch as
      it's now used by core implementation.

    - Convert jiffy delta to msecs using jiffies_to_msecs() instead of
      multiplying by (HZ / MSEC_PER_SEC). The conversion is implemented in
      jiffies_delta_msecs().

v2: - We are now using scx_ops_enable_state_str[] outside
      CONFIG_SCHED_DEBUG. Move it outside of CONFIG_SCHED_DEBUG and to the
      top. This was reported by Changwoo and Andrea.

Signed-off-by: David Vernet <void@manifault.com>
Reported-by: Changwoo Min <changwoo@igalia.com>
Reported-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/core.c       |  1 +
 kernel/sched/ext.c        | 53 +++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c          |  1 +
 4 files changed, 57 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 2608a8f548db..123d6dffdf26 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -155,10 +155,12 @@ struct sched_ext_entity {
 };
 
 void sched_ext_free(struct task_struct *p);
+void print_scx_info(const char *log_lvl, struct task_struct *p);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
 static inline void sched_ext_free(struct task_struct *p) {}
+static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 #endif	/* _LINUX_SCHED_EXT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aae9c1297622..42fe654bf946 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9272,6 +9272,7 @@ void sched_show_task(struct task_struct *p)
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
+	print_scx_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8d2ff81e8dd4..ff080b5f0330 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -577,6 +577,14 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 
 #define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
 
+static long jiffies_delta_msecs(unsigned long at, unsigned long now)
+{
+	if (time_after(at, now))
+		return jiffies_to_msecs(at - now);
+	else
+		return -(long)jiffies_to_msecs(now - at);
+}
+
 /* if the highest set bit is N, return a mask with bits [N+1, 31] set */
 static u32 higher_bits(u32 flags)
 {
@@ -3695,6 +3703,51 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+/**
+ * print_scx_info - print out sched_ext scheduler state
+ * @log_lvl: the log level to use when printing
+ * @p: target task
+ *
+ * If a sched_ext scheduler is enabled, print the name and state of the
+ * scheduler. If @p is on sched_ext, print further information about the task.
+ *
+ * This function can be safely called on any task as long as the task_struct
+ * itself is accessible. While safe, this function isn't synchronized and may
+ * print out mixups or garbages of limited length.
+ */
+void print_scx_info(const char *log_lvl, struct task_struct *p)
+{
+	enum scx_ops_enable_state state = scx_ops_enable_state();
+	const char *all = READ_ONCE(scx_switching_all) ? "+all" : "";
+	char runnable_at_buf[22] = "?";
+	struct sched_class *class;
+	unsigned long runnable_at;
+
+	if (state == SCX_OPS_DISABLED)
+		return;
+
+	/*
+	 * Carefully check if the task was running on sched_ext, and then
+	 * carefully copy the time it's been runnable, and its state.
+	 */
+	if (copy_from_kernel_nofault(&class, &p->sched_class, sizeof(class)) ||
+	    class != &ext_sched_class) {
+		printk("%sSched_ext: %s (%s%s)", log_lvl, scx_ops.name,
+		       scx_ops_enable_state_str[state], all);
+		return;
+	}
+
+	if (!copy_from_kernel_nofault(&runnable_at, &p->scx.runnable_at,
+				      sizeof(runnable_at)))
+		scnprintf(runnable_at_buf, sizeof(runnable_at_buf), "%+ldms",
+			  jiffies_delta_msecs(runnable_at, jiffies));
+
+	/* print everything onto one line to conserve console space */
+	printk("%sSched_ext: %s (%s%s), task: runnable_at=%s",
+	       log_lvl, scx_ops.name, scx_ops_enable_state_str[state], all,
+	       runnable_at_buf);
+}
+
 void __init init_sched_ext_class(void)
 {
 	s32 cpu, v;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 222c6d6c8281..9581ef4efec5 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -68,6 +68,7 @@ void dump_stack_print_info(const char *log_lvl)
 
 	print_worker_info(log_lvl, current);
 	print_stop_info(log_lvl, current);
+	print_scx_info(log_lvl, current);
 }
 
 /**
-- 
2.44.0


