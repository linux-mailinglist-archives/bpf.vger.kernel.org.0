Return-Path: <bpf+bounces-14836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECD7E8886
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C5C281310
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E0525B;
	Sat, 11 Nov 2023 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/GjNYQA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361C5690
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:05 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AA4ED3;
	Fri, 10 Nov 2023 18:49:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso22322665ad.3;
        Fri, 10 Nov 2023 18:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670970; x=1700275770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RomfD8j675UcHtAVNjV5ZY0vKiXSfadBEXJSFWyyOd0=;
        b=A/GjNYQA6C00pl0JrokeM+q232z6511hkljIAUCsza/jfPYtbtiV49xnaMbcA8JSkB
         Vt50P2nNfYQbvwtEdvapNrw3aQ0Lf5ynzAP/UpgVe/KpggJkHRnw7ce07EjUyOT4IOLY
         JSOwdvO+1ERHCKX6PQGHrhhVvZe4fCJsOQHCg3WS+eCrHYYW7PYdWzyhooXYPx+IM3f1
         DuAZfq2GJB2wovEli/9jN3lqeo4E6izKoW2Om6AO2WaGeSkP00TmpGQVDa4NA4fmSHcH
         k9Pt7KA0L3qev/CyzXLR3BpTdxuQL9JIPx2SnKMUvSmTo8N3eUqytNXWt736Y1Alz5hL
         0J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670970; x=1700275770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RomfD8j675UcHtAVNjV5ZY0vKiXSfadBEXJSFWyyOd0=;
        b=ENWh/zJHe3CAxXQvXXNtM0+AfkLdA53uMCukNcLTZmbNhRqT91XC4hAu7kAwdvaxmG
         jh3d3hVHgD7U+wzUSdeh+jBw0hSXeXHu6BpUjFW2A1Rp7uRGRWueXc5G7a5AliyGeMsd
         P7iHwW9nDOollL51uXUxgpNQVQAGR6xpd6PE0vT32xFjIDSLDVXS20g7Y0LCQympOEyM
         X6MAGmH3efksdp/t63oEx3jLs19lmJNI76Io3c7jgoP9ZX6o+3WnArvbOvfuf39JgKtV
         97K6E1PjtDjDd/PGIAWE+zvOWu27YHb96JBLHlmlgBkmqJ3lZMG9UlIBKewBtJLCDJp8
         iLwg==
X-Gm-Message-State: AOJu0YxASdB+xBzKglne8srpLeO5YzahgtRNTF9oCC8gt2BeZMU4bI5t
	rw9P021VTlaKlW0jSVQnN78=
X-Google-Smtp-Source: AGHT+IESQQOKe5PEPicMSMPzm6ve5X2FeApPuKdLJyVDJg10aKkBmipFcp18O642JVg21q4ZxkpQVQ==
X-Received: by 2002:a17:90b:390c:b0:280:29e8:4379 with SMTP id ob12-20020a17090b390c00b0028029e84379mr785733pjb.34.1699670969981;
        Fri, 10 Nov 2023 18:49:29 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001c9d968563csm357699plz.79.2023.11.10.18.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:29 -0800 (PST)
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
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/36] sched_ext: Print sched_ext info when dumping stack
Date: Fri, 10 Nov 2023 16:47:44 -1000
Message-ID: <20231111024835.2164816-19-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
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

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  2 ++
 kernel/sched/core.c       |  1 +
 kernel/sched/ext.c        | 45 +++++++++++++++++++++++++++++++++++++++
 lib/dump_stack.c          |  1 +
 4 files changed, 49 insertions(+)

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
index 4e2aa9f308fb..65ee99ea111b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
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
2.42.0


