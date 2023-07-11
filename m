Return-Path: <bpf+bounces-4677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3D474E33C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41677281580
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528692104;
	Tue, 11 Jul 2023 01:15:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697920FE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:15:22 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91106E6F;
	Mon, 10 Jul 2023 18:14:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6689430d803so2674357b3a.0;
        Mon, 10 Jul 2023 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038084; x=1691630084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tYps2k7FntAJcDgxrMW3BMcrEpXH1yKukKcIVwMfEs=;
        b=LQ5hYeAYtfLNdodZiytb8PmLv/7pqQYriIk9XN9F0YoCZOBRtpBG6s5q7rHnDTJHkK
         +1GzxaM82IuCps5Bi3JbhDdo5DAWdOwQwj98wtDOxA+k0EIX5SsTpE0IuRwe8Ar1Mwmi
         vpDfUbqdEEPVMxx+4KYrvSe45OY3KeKGJtcoHwTLoBaoQxjtBCNibkZ34Vky7o3aGXV0
         qCSwnjx8biI7SXKgDTkWbjfgZZMKLgwDvCBB8EZkj0fOUj+cPWhI185p+ZmVfYUkI46y
         4c+OAf58QQcy/vm/Id5ZU7a6/JM6v+KFvm3+NqjPrGuJ2jCG7W4Iboj7C5TSAacE2xjv
         P/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038084; x=1691630084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tYps2k7FntAJcDgxrMW3BMcrEpXH1yKukKcIVwMfEs=;
        b=VwtIT2FGZZCRyDVCx6zAK44TilKzkviz0Wzb10MP28b0yH0+L6vGe0FE+MLtMZsbE5
         wEdoBcv/474RZFIL9D36ypIvleE3cns7GAZUuhKxkZl6Zi1K7WEWoDE3msKRHEkeTmP2
         Ay4WiuNi4tnIrmrOxKm7Ru0/CbIAiDFF00de7fnZjkK2NEc2Vk962JQCJ1IRr1PZ8IMG
         ENDQx62DG/j/lz0DmH19mbn41QBhe1bBoJ4XAkl6QFnWMWj2Yxdwpxfjoa1Q8XMjR1nB
         um7Him3KJLceezzE6iHSmSD2OIIIisSOsL9r3VzE//aYzwVIpK1mvulyk9jJE676ucAl
         7+iA==
X-Gm-Message-State: ABy/qLb/C9bEWqvFU4hG31BL9TZLXWuSFL5Ej7s6tXYTLTumkrRaf+Ag
	THcDsqW8Ws4nHEg5qMKxy5I=
X-Google-Smtp-Source: APBJJlGPpL1xYZMLJSDkm+Qf23ZwEKCLUeqIjjpQcx4LazmwAoEtMWqUJipDcuAUrkgK3bByPkAvqg==
X-Received: by 2002:a05:6a00:80f:b0:67f:e74a:d309 with SMTP id m15-20020a056a00080f00b0067fe74ad309mr14388426pfk.30.1689038084289;
        Mon, 10 Jul 2023 18:14:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id m16-20020aa79010000000b006579b062d5dsm421669pfo.21.2023.07.10.18.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:43 -0700 (PDT)
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
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/34] sched_ext: Add sysrq-S which disables the BPF scheduler
Date: Mon, 10 Jul 2023 15:13:32 -1000
Message-ID: <20230711011412.100319-15-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index b6e70c5cfa17..ddfcdb6aecd7 100644
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
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 92011a63cc15..2f24642bbf2e 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -55,6 +55,7 @@ enum scx_exit_type {
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
index 51d77459d208..f33df61c24cb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1971,6 +1971,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
 		break;
+	case SCX_EXIT_SYSRQ:
+		reason = "disabled by sysrq-S";
+		break;
 	case SCX_EXIT_ERROR:
 		reason = "runtime error";
 		break;
@@ -2593,6 +2596,21 @@ struct bpf_struct_ops bpf_sched_ext_ops = {
 	.name = "sched_ext_ops",
 };
 
+static void sysrq_handle_sched_ext_reset(int key)
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
@@ -2616,6 +2634,8 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 	}
+
+	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 }
 
 
-- 
2.41.0


