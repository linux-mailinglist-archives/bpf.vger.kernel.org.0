Return-Path: <bpf+bounces-32448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C526090DE34
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B185D1C23218
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4C18F2D1;
	Tue, 18 Jun 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVmyjvlB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556518EFD4;
	Tue, 18 Jun 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745693; cv=none; b=PUpDSl7OfXnbaJU9zgYfssQOgSOt8qTdShigC3+zupy3migGLpoqavcx8X1LJ5VQZlw1Rt4Tm8OfcvRX68CHcHAF6ltIKlKlPGYYIHTSIOLDq/nhhkKqzetBbpO5xYpwN4IAD2eRB/9fkOnQ9a1nsS14FnAV2EOOypLi4NG0/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745693; c=relaxed/simple;
	bh=RuC5g7MWTdWgG90aaNreaFWp7Evm9J7ZZmCyOISTg5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUmoqAC17LkPbzU4Lup8TQM4UgHyZGsbZ8PpvikUY/V7nwuiLrTUdHA8OuBBpP9VOeGDz6WiTYw92Q7hOvNU5MzggvT3mOwjpnXAd1DfC8Jz9I4laBxSwLXUXDVYoI0wG+QTF0Kjo7PcMmEkuPNLVAON2v1WOlsUoPnGX6hpT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVmyjvlB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9885d5c04so14969715ad.0;
        Tue, 18 Jun 2024 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745692; x=1719350492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlWXBAcaK8Ni/dW0U+2RpZNRNJOhBi6NFu1cj9+RBRQ=;
        b=dVmyjvlBus9DiXbnK4fzKrqBjfF0pMondZYhughJwOsNHrmJRoxhnELx5nd2Hp6WKZ
         BEUB2r3trANtpipbJl7t3pZVRqF3ckWySKFfeiuTlrSYlnXNl6/EjRRE/sGhayeMnxGq
         Zqn8M8NC8cjJoptRrpcB0HEztWvPMF+h8TzPCGH8y6dmU8+mZVzoTrkE8pYEEuREs2U9
         Y9IabHbfgtaMtEn2OGBT6cOmxhJeUi+HUCpTglYl7/wtQIb0FxckodtNZaYfPNzG2a2S
         kYUEeX3234oQ1vTtPUuJC95PpfFtzzTHDdIpfeyjAgxboLCrXof/YgSB3iEm5hgIlX/p
         V65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745692; x=1719350492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlWXBAcaK8Ni/dW0U+2RpZNRNJOhBi6NFu1cj9+RBRQ=;
        b=qR00kutjeKkNxG3ojuZQNrXZAZ1bYd4V4H7yc/kfXpbRNi/SzB376KDAliHly2ZmcQ
         TTtyaankNM6bnk1LmoW8+gohIIMM2nrYXFOLGXCCd3Jts6xs1r5U11BEIN4WnWmbzEVI
         G6F0D0i1XjgKj1z0YCATjUESbzGuQP7Rykww9ol9vKJEWQQWu5vJbj4cJEBvzzDoAmGm
         +Q7VEeLlOEBCCY/v2OSDLNqto8OlcjhI/JHI/EKcrcKr/o9aGNdloDI98WNp0fhEiOd8
         iJhnZIMeZwfFRChDpTRwurd3S5xCLkYRdi+SEseqc2c4Aa9PrakJXlh8MQEg93IuUuhf
         SWZg==
X-Forwarded-Encrypted: i=1; AJvYcCU1XLzpQ5oQkN391MNRxiauRfBnX1XZkFHeeLtkRDyXcuTOvhC2hlh2ZTmVS1knK4yK65eBLvqWAU/Up9qQ9gld0ggB
X-Gm-Message-State: AOJu0YwEZI/oFBorJ8FBxAjdhW+GTYPVxKLD4QFoH11Kcpm4I/wAd4gD
	koLFuMGeMVO6gI+ND9vk6t0PJpL3Clq0h+zNU5q1d9ZVXIqTMjin
X-Google-Smtp-Source: AGHT+IGdnpXUTOALhl6KDzpS9H4XItnNTkMAPNLYKOGjF7DCOUIewQv7aqxL87oHdC3Z8JJ/Dzl7Lg==
X-Received: by 2002:a17:902:ecc7:b0:1f7:1a9:bf05 with SMTP id d9443c01a7336-1f9aa469a1bmr11462555ad.53.1718745691529;
        Tue, 18 Jun 2024 14:21:31 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5a0d5sm102236325ad.43.2024.06.18.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:31 -0700 (PDT)
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
Subject: [PATCH 14/30] sched_ext: Print sched_ext info when dumping stack
Date: Tue, 18 Jun 2024 11:17:29 -1000
Message-ID: <20240618212056.2833381-15-tj@kernel.org>
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
index ea7c501ac819..85fb5dc725ef 100644
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
index f4365becdc13..1a3144c80af8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7486,6 +7486,7 @@ void sched_show_task(struct task_struct *p)
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
+	print_scx_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8ff30b80e862..6f4de29d7372 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -586,6 +586,14 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 
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
@@ -3715,6 +3723,51 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
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
2.45.2


