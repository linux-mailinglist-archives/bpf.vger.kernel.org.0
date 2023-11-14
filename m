Return-Path: <bpf+bounces-15075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5697EB6DA
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 20:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE162812F9
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E926AC5;
	Tue, 14 Nov 2023 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS+UUI5n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F101D684
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 19:24:01 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02326FB;
	Tue, 14 Nov 2023 11:24:00 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc0d0a0355so46000615ad.3;
        Tue, 14 Nov 2023 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699989839; x=1700594639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRg/9amNRCNDUA0dPsjr4YlY4vfRo/KbH+WFDWxlwMU=;
        b=VS+UUI5nc7/5i4wYaOLpMPq3OJlr1tqThDQq9XeNInB/i/Xaqaz9ZkSO/4p9Wkgrqi
         Lkm8vaI3tPl3JkNzKDuFNbhuh4pUl5dPaVV+P2ZY2M4tyiTI1Ihqr6FYHhrDazxjryRY
         lir8b6sPHCJO6QpjiQBTELJQK34FFyrjCVcUWnUXbCEVeJ167wPT/ToB/iPBwSQi9KKz
         wICW0NrBb3T0gQLhYOH0ctNkPh0uJ7KDMMFnenuw3xAuQWEn7vpy8F5Ar7hnORsHhmSj
         rd9Z7f5FmhyTEZhXU+vfs7XDdu1t2NK07hHrwhyJaYGwBPA2qSGucs7vSu4DLhyEGqrU
         WgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699989839; x=1700594639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRg/9amNRCNDUA0dPsjr4YlY4vfRo/KbH+WFDWxlwMU=;
        b=HyPzLLcVpRjGdU2QaiiPEuXXYvg1AUMqM42/KZoj6yHnfCC+yjeHDIyb3Zbg3EeWKq
         HHjy19RBexKWIdJRBAWxIRql+zDb2LnwvkCMwq+Wtv03FErAb0b76wCLXgaBCo1WCydh
         3MVmgZE6eg2PLQkCFy/pJzoDRCg0Hn6AtAN8uH+Z1hAnTQ0WkMjUAK0NT798dw8XWlmq
         vPmkc5TL5hNv0EJb7HrGoCgTQS+8WcctJvC2jCeEqVSQx3k0zbzwbUE1IE3hr43FEmgT
         YHO3mmN8yl/nyIqOAks1GMTbP/Wgi2R6F/t37spVeX7V5DVhqpNCS+7SVLcY9LurNUst
         I4VQ==
X-Gm-Message-State: AOJu0Ywq+08jsBaPR365ZR1rh4bfzo3D8xfNbkAAYqd+wdwB0xyX7ZCk
	DvjNY9jYkuXBb+7ZgJQM+x4=
X-Google-Smtp-Source: AGHT+IHS3uxflJr5xZ7v8R8SsVGqdz2WtqnBZlLldfgKr7b9dh6D9gGfP4deOLawiw5HY7ylZcunPg==
X-Received: by 2002:a17:903:1251:b0:1cc:50f6:7fca with SMTP id u17-20020a170903125100b001cc50f67fcamr3820996plh.24.1699989839296;
        Tue, 14 Nov 2023 11:23:59 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b001cc52ca2dfbsm5963116plt.120.2023.11.14.11.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:23:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 Nov 2023 09:23:57 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
	David Vernet <void@manifault.com>
Subject: [PATCH v2 18/36] sched_ext: Print sched_ext info when dumping stack
Message-ID: <ZVPJTc5ZNEnnYmei@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-19-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111024835.2164816-19-tj@kernel.org>

From e1a20d192fed44bf672682431d85186a46f275c9 Mon Sep 17 00:00:00 2001
From: David Vernet <void@manifault.com>
Date: Tue, 14 Nov 2023 09:19:48 -1000

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

v2: We are now using scx_ops_enable_state_str[] outside CONFIG_SCHED_DEBUG.
    Move it outside of CONFIG_SCHED_DEBUG and to the top. This was reported
    by Changwoo and Andrea.

Signed-off-by: David Vernet <void@manifault.com>
Reported-by: Changwoo Min <changwoo@igalia.com>
Reported-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

The sched_ext-v5 branch has been updated accordingly.

  https://github.com/htejun/sched_ext sched_ext-v5

Thanks.

 include/linux/sched/ext.h |  2 ++
 kernel/sched/core.c       |  1 +
 kernel/sched/ext.c        | 61 ++++++++++++++++++++++++++++++++++-----
 lib/dump_stack.c          |  1 +
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9d41acaf89c0..55f649bd065c 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -428,10 +428,12 @@ struct sched_ext_entity {
 };
 
 void sched_ext_free(struct task_struct *p);
+void print_scx_info(const char *log_lvl, struct task_struct *p);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
 static inline void sched_ext_free(struct task_struct *p) {}
+static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 #endif	/* _LINUX_SCHED_EXT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1906f8397c28..957ae28a6e3f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9217,6 +9217,7 @@ void sched_show_task(struct task_struct *p)
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
+	print_scx_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e2aa9f308fb..621559c9f9c5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -20,6 +20,14 @@ enum scx_ops_enable_state {
 	SCX_OPS_DISABLED,
 };
 
+static const char *scx_ops_enable_state_str[] = {
+	[SCX_OPS_PREPPING]	= "prepping",
+	[SCX_OPS_ENABLING]	= "enabling",
+	[SCX_OPS_ENABLED]	= "enabled",
+	[SCX_OPS_DISABLING]	= "disabling",
+	[SCX_OPS_DISABLED]	= "disabled",
+};
+
 /*
  * sched_ext_entity->ops_state
  *
@@ -2560,14 +2568,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 }
 
 #ifdef CONFIG_SCHED_DEBUG
-static const char *scx_ops_enable_state_str[] = {
-	[SCX_OPS_PREPPING]	= "prepping",
-	[SCX_OPS_ENABLING]	= "enabling",
-	[SCX_OPS_ENABLED]	= "enabled",
-	[SCX_OPS_DISABLING]	= "disabling",
-	[SCX_OPS_DISABLED]	= "disabled",
-};
-
 static int scx_debug_show(struct seq_file *m, void *v)
 {
 	mutex_lock(&scx_ops_enable_mutex);
@@ -2787,6 +2787,51 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
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
+		scnprintf(runnable_at_buf, sizeof(runnable_at_buf), "%+lldms",
+			  (s64)(runnable_at - jiffies) * (HZ / MSEC_PER_SEC));
+
+	/* Print everything onto one line to conserve console spce. */
+	printk("%sSched_ext: %s (%s%s), task: runnable_at=%s",
+	       log_lvl, scx_ops.name, scx_ops_enable_state_str[state], all,
+	       runnable_at_buf);
+}
+
 void __init init_sched_ext_class(void)
 {
 	int cpu;
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 83471e81501a..6e667c445539 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -68,6 +68,7 @@ void dump_stack_print_info(const char *log_lvl)
 
 	print_worker_info(log_lvl, current);
 	print_stop_info(log_lvl, current);
+	print_scx_info(log_lvl, current);
 }
 
 /**
-- 
2.42.1


