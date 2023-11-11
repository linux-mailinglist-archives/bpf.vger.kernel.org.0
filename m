Return-Path: <bpf+bounces-14834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E67E8884
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F0280EDE
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9645673;
	Sat, 11 Nov 2023 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE2RHUOZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4015B8
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:00 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08204C12;
	Fri, 10 Nov 2023 18:49:23 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a956887c20so97884139f.1;
        Fri, 10 Nov 2023 18:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670962; x=1700275762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwOH9dLJwGai+eV9Oi5DDLHqy9Me6b8SBNkRrvpEcIQ=;
        b=WE2RHUOZKgvI+22OWFe3+vukpY6zg5eK7tFxFbwtGpnOf0EVUC/fUqN/EwZcZ/dP14
         Fgsjfc0NP+MjAxACcpLt5JhchrReNNYc6Ur4pIFrEEwGNlhkZ7HI6GueYW5Arj7JDz9B
         sqzBxXVaBH2X0sbKo4luOR+fiMJMWEqtL04iw4yVNdPXoMiWLxu06gYQQR3iQAikACSR
         jpwc/35Oy6/z6ksUdSi2VoCrPFjBndJ20LzJGhVuja9nf8eJB9sIorw6VS/zGnlO/HIp
         qTiGGsklOgpufuDtFZGUfd2JTbsNVixPm1avQf3ShMHVBTyj9xKqpuwPlW9Pt6hOnyGC
         whAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670962; x=1700275762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RwOH9dLJwGai+eV9Oi5DDLHqy9Me6b8SBNkRrvpEcIQ=;
        b=Efim6XJmQF7/8EmUuD8Q5VorlQt4HrY54238oRhubH7mvjW0xzHy3EdtLgMljhVdaq
         ctAyHuS9PDLZ7oXupfg39wzjLdR2QcGX81iEXmBSxNNwSNesl+0Lj8oSAWEVeMOwc7lp
         Q8GCX8rYCgSmeC5l2mJZNaql/kPvEhBEhInxQW3/5QbYm9Io8fF6Ca9brbs5KRZbRtkF
         LRzHX7lSAAE5oEwrYE7lKidXcfFm/YxbVQfzr9z45EnlVsMOiOf5aTPnCIQXj72o34Rz
         z5dGJ8bGfsYd2c1aZoHbBWfUG0ShvghD6yRWRPNPpVwHA76Ri8SUOYw/hyzzba68eEBk
         eSYA==
X-Gm-Message-State: AOJu0YwsnzvSuNGfv9Gi8I0gA12lIs1+d9D/eh41/gHUzJIbEzZgjLKN
	5UWlDKbFLo/usVDyd6M1Ppc=
X-Google-Smtp-Source: AGHT+IEBlSpGsBlCTi2G7dFacP4UbHRv1CicIceJ19j2Pglm+DULdhdkJzM8Q6/qjhkCZeWGoLakUA==
X-Received: by 2002:a05:6e02:12e2:b0:350:f352:4853 with SMTP id l2-20020a056e0212e200b00350f3524853mr1476114iln.25.1699670962276;
        Fri, 10 Nov 2023 18:49:22 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001b9f032bb3dsm358583pls.3.2023.11.10.18.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:21 -0800 (PST)
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
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/36] sched_ext: Add sysrq-S which disables the BPF scheduler
Date: Fri, 10 Nov 2023 16:47:40 -1000
Message-ID: <20231111024835.2164816-15-tj@kernel.org>
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

This enables the admin to abort the BPF scheduler and revert to CFS anytime.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 drivers/tty/sysrq.c         |  1 +
 include/linux/sched/ext.h   |  1 +
 kernel/sched/build_policy.c |  1 +
 kernel/sched/ext.c          | 20 ++++++++++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 23198e3f1461..eebdf76b05b4 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -519,6 +519,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* P */
 	NULL,				/* Q */
 	NULL,				/* R */
+	/* S: May be registered by sched_ext for resetting */
 	NULL,				/* S */
 	NULL,				/* T */
 	NULL,				/* U */
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index b6462d953ec6..cad8ab4d782a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -55,6 +55,7 @@ enum scx_exit_kind {
 	SCX_EXIT_DONE,
 
 	SCX_EXIT_UNREG = 64,	/* BPF unregistration */
+	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 4c658b21f603..005025f55bea 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/sysrq.h>
 #include <linux/percpu-rwsem.h>
 
 #include <uapi/linux/sched/types.h>
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7b78f77d2293..2d9996a96d3a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1981,6 +1981,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
 		break;
+	case SCX_EXIT_SYSRQ:
+		reason = "disabled by sysrq-S";
+		break;
 	case SCX_EXIT_ERROR:
 		reason = "runtime error";
 		break;
@@ -2599,6 +2602,21 @@ struct bpf_struct_ops bpf_sched_ext_ops = {
 	.name = "sched_ext_ops",
 };
 
+static void sysrq_handle_sched_ext_reset(u8 key)
+{
+	if (scx_ops_helper)
+		scx_ops_disable(SCX_EXIT_SYSRQ);
+	else
+		pr_info("sched_ext: BPF scheduler not yet used\n");
+}
+
+static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
+	.handler	= sysrq_handle_sched_ext_reset,
+	.help_msg	= "reset-sched-ext(S)",
+	.action_msg	= "Disable sched_ext and revert all tasks to CFS",
+	.enable_mask	= SYSRQ_ENABLE_RTNICE,
+};
+
 void __init init_sched_ext_class(void)
 {
 	int cpu;
@@ -2622,6 +2640,8 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 	}
+
+	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 }
 
 
-- 
2.42.0


