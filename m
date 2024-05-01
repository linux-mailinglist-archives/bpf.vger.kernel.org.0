Return-Path: <bpf+bounces-28344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7048B8C98
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9D81C2299C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5E12F59A;
	Wed,  1 May 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsUWLLFx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FB1327FE;
	Wed,  1 May 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576431; cv=none; b=jYlwo35l5pq1EQN2ObHBVDlaXcuugxhcZgq5VlNS0sQm8A9KnkEUUAxiyEC9aAl2wIcuVph3AKzqbxzd1rlnnv0vms38YKL+CoBNdp2vSgpSBLUpVJfmP2Dd5NBERK3bHLHcJ3RR2lIkd85o0eUnUNWPbAkGvZAcDEYOA9SkZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576431; c=relaxed/simple;
	bh=c1dt4T5Ufzt5OkiA1M1KKtvwVAmkh+cq2lLazLPx1Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inFPMvlvRLyySU2CJ0As7SEytkJbxqKSsrBXmbLntlMO9KOLUmglYsIShZ2GYF+gby0DY59iWkggdeRHsB8hWMnY0vj45m72IuB71yMZbYF6DDdeyyOcWwBs+1FxKV3eGc0AcLTLmnFdd/TDQooUglRU5nUfyuiN1kTHv30F9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsUWLLFx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ee12766586so709228b3a.0;
        Wed, 01 May 2024 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576430; x=1715181230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awT6vKsXqFo3AXr5FuKoBvPmsq7G7rUiFEK+tTBGsA4=;
        b=JsUWLLFxZenN0y8ZaUYMmE+vCH/3mm3xzHKjJYRDHukm0Z7NCrd0KWeL+E7m39VOXj
         W42L6Fx8GVex+3dF8x/+8BNYlOgKrlSwE6DZnnckpYfmRcRe0NPC8Ze2xbC+7rPlxG7p
         5eKylvM5MsUJdH+jmiDpxU6ShQASR3apfwQPDJsJlK6vPdg4k0RxgOLumMffQQEKn1TC
         d8Ntl1gfux0BqTlzuQStPzd20HNo3B1LVsEc66JHfjeGsjnll9X2MMQFk/oQgsidY3ig
         7NL9fOVXRFxBAOPyG6ctY0A9gziKqe7ssyxzo9ltRzQApe+rwS2UGeipX5ogVkG+nlpT
         pGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576430; x=1715181230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awT6vKsXqFo3AXr5FuKoBvPmsq7G7rUiFEK+tTBGsA4=;
        b=a0oJTDdRdI4RkvGSRCjY8VEjkaDOmw7i4uCGov3A3mz5OXSnHDYGGXemEyUwwI6LYt
         joMCLXwSqGF95fWmvx0Z/iLgl+RWxSy5cW1y7nMWxeDOj9r96CSRlGvlmtiFCCiOBMz6
         +3f2k/+0iD4ooYWJtap1KOofbLULohjdtKTXVqUxHMkCgpFdIYpliHyXOIbsPJVkVWFW
         caTZI9ech1y0fnbb42+r5VkGEefXC769RvKE0OpwHSkslA4A3T+e73jtwUiu7Rfsq6r6
         phZfad7BRRpVjv2+A39POlS9/dZAhkPFv3mAbtmluU+mF9AosUrjN+eFN3CFh5pnUbXZ
         uicg==
X-Forwarded-Encrypted: i=1; AJvYcCVKdxnKgcBczB6bA0Wov6bQcxEdS2leal852VbzSNqKDyU7QNLLB7KSVuo1x5GkXhpLsZjdwtAwBop5pyP122iXxXXJ
X-Gm-Message-State: AOJu0Yza9LZ22HJMXUrckFr6qh4I7LyFAyx5lz/6UI93Zuda5dmPSyLn
	pboh4r7uz/kuL/7IDVb/y/WcqQ34fgN4/NRC+Qmq5MBRBC7sqoPv
X-Google-Smtp-Source: AGHT+IElJ6ajPpcgHbNc+2jXEKcB5gsh8qOU/5m2ShFfhb3kDCc/TBRlOLxZHtRWSpPTyTLJGxuxkA==
X-Received: by 2002:a05:6a00:2181:b0:6ea:f05c:5c16 with SMTP id h1-20020a056a00218100b006eaf05c5c16mr4430413pfi.5.1714576429734;
        Wed, 01 May 2024 08:13:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id e4-20020aa79804000000b006ecc858b67fsm23531151pfl.175.2024.05.01.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:49 -0700 (PDT)
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
Subject: [PATCH 16/39] sched_ext: Add sysrq-S which disables the BPF scheduler
Date: Wed,  1 May 2024 05:09:51 -1000
Message-ID: <20240501151312.635565-17-tj@kernel.org>
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

This enables the admin to abort the BPF scheduler and revert to CFS anytime.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 drivers/tty/sysrq.c         |  1 +
 kernel/sched/build_policy.c |  1 +
 kernel/sched/ext.c          | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..1ce3535cba6d 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -520,6 +520,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* P */
 	NULL,				/* Q */
 	NULL,				/* R */
+	/* S: May be registered by sched_ext for resetting */
 	NULL,				/* S */
 	NULL,				/* T */
 	NULL,				/* U */
diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 2a2f10367ceb..e0e73b44afe9 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -31,6 +31,7 @@
 #include <linux/suspend.h>
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
+#include <linux/sysrq.h>
 #include <linux/percpu-rwsem.h>
 
 #include <uapi/linux/sched/types.h>
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d4f52209111f..e017b79aa1e7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -20,6 +20,7 @@ enum scx_exit_kind {
 	SCX_EXIT_UNREG = 64,	/* user-space initiated unregistration */
 	SCX_EXIT_UNREG_BPF,	/* BPF-initiated unregistration */
 	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
+	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
@@ -2767,6 +2768,8 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 		return "Scheduler unregistered from BPF";
 	case SCX_EXIT_UNREG_KERN:
 		return "Scheduler unregistered from the main kernel";
+	case SCX_EXIT_SYSRQ:
+		return "disabled by sysrq-S";
 	case SCX_EXIT_ERROR:
 		return "runtime error";
 	case SCX_EXIT_ERROR_BPF:
@@ -3506,6 +3509,21 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
  * System integration and init.
  */
 
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
 	s32 cpu, v;
@@ -3529,6 +3547,8 @@ void __init init_sched_ext_class(void)
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 	}
+
+	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 }
 
 
-- 
2.44.0


