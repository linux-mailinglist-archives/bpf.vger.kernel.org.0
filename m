Return-Path: <bpf+bounces-4692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4819274E35B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B342815A7
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F88443C;
	Tue, 11 Jul 2023 01:16:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC82440F
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:16:09 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E019BB;
	Mon, 10 Jul 2023 18:15:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6682909acadso2727181b3a.3;
        Mon, 10 Jul 2023 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038114; x=1691630114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTtwZghJ4JhtTlqFDfOdJ5L/z7fNHZMyuvWm/nhKKUY=;
        b=J2Mw5n9DjMmiu/emNkwN0uoo7jBcJfRIOU9Ha2CTeCYeTmTzVlwhzABJgrrt0ZURZc
         LAo14QIdHwaTrJ2imOc9QJ0xaEgTniY0Jk4nHsEezFOP2mSAKtB0NlgXfFS4+r+2OwEH
         JZ32muCg+O2SosQiDZzQTnvl4AkPdy3I70SR92eqYdRqmDBs85ZrUVYrUauzMxmlFruu
         Tb1tri+10ymjGV+boWdujM3q+GEu6R92tk+UTY4gzPbR4G4BXoGgzFaU9WFapwaKuF68
         veu+unRz6mDTcHXetfiUqYytW5T86BUJjkA+Ei3bVMP5ItKRzTaxN3pW/x06bb2wxLVw
         maZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038114; x=1691630114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTtwZghJ4JhtTlqFDfOdJ5L/z7fNHZMyuvWm/nhKKUY=;
        b=O2cOKgUX9nMQJAA8ndoh68x9MF4xC2k5Vtj/FLL9uPTMe4f4dm2iSXwYQP+WxvVLNe
         TN2sH2kAoVStbnUnne5vPmI7288GPl90V0cVvbCBAZiuL+G9g6zFnpEXVwJmjRHl4Q6a
         21Y9/n5/ec7ps8BX6gR/JrhUpBU0n+259MI0nf1oFb3yB0PDM33l4ABDqSi0oDlcaDa7
         xNPr0S54PtMLkcuodPWyEtP5JGuo936ZrBxaWcFseXsEgP5tv1D4AzFU9LXb5tZAnQCA
         KP93U+bhGWhf2+tWFoCxYwnuum1QKjYToY4vwOnyAVI4ekYLNrMf782Vn2VCzXpRfzqW
         otiw==
X-Gm-Message-State: ABy/qLa/+BA0NnDSGnuCs5sNqAVpC5bz93ApmYi7kat/zGPVUseFvkth
	jRQJBFXR7hyy7LvY4bOufrE=
X-Google-Smtp-Source: APBJJlEfXm8iLFolbUGOZWCUXKHTTq3l0tryKuG5xBCaKb4lAXLyM/lWQ/RICgTlCtkgax9SOMMc+A==
X-Received: by 2002:a05:6a00:39a1:b0:67e:bf65:ae61 with SMTP id fi33-20020a056a0039a100b0067ebf65ae61mr12366472pfb.28.1689038114360;
        Mon, 10 Jul 2023 18:15:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b00681783cfc85sm407529pfo.144.2023.07.10.18.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:14 -0700 (PDT)
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
Subject: [PATCH 29/34] sched_ext: Implement sched_ext_ops.cpu_online/offline()
Date: Mon, 10 Jul 2023 15:13:47 -1000
Message-ID: <20230711011412.100319-30-tj@kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ops.cpu_online/offline() which are invoked when CPUs come online and
offline respectively. As the enqueue path already automatically bypasses
tasks to the local dsq on a deactivated CPU, BPF schedulers are guaranteed
to see tasks only on CPUs which are between online() and offline().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h | 18 ++++++++++++++++++
 kernel/sched/ext.c        | 18 +++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 8a275ec05ee1..c17957bd75df 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -377,6 +377,24 @@ struct sched_ext_ops {
 	 */
 	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 
+	/**
+	 * cpu_online - A CPU became online
+	 * @cpu: CPU which just came up
+	 *
+	 * @cpu just came online. @cpu doesn't call ops.enqueue() or run tasks
+	 * associated with other CPUs beforehand.
+	 */
+	void (*cpu_online)(s32 cpu);
+
+	/**
+	 * cpu_offline - A CPU is going offline
+	 * @cpu: CPU which is going offline
+	 *
+	 * @cpu is going offline. @cpu doesn't call ops.enqueue() or run tasks
+	 * associated with other CPUs afterwards.
+	 */
+	void (*cpu_offline)(s32 cpu);
+
 	/**
 	 * prep_enable - Prepare to enable BPF scheduling for a task
 	 * @p: task to prepare BPF scheduling for
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1b83dddbdf10..e54d8c7d19a9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1392,7 +1392,8 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		 * emitted in scx_notify_pick_next_task().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq),
+				    NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -1852,6 +1853,18 @@ void __scx_update_idle(struct rq *rq, bool idle)
 #endif
 }
 
+static void rq_online_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (SCX_HAS_OP(cpu_online) && reason == RQ_ONOFF_HOTPLUG)
+		SCX_CALL_OP(SCX_KF_REST, cpu_online, cpu_of(rq));
+}
+
+static void rq_offline_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (SCX_HAS_OP(cpu_offline) && reason == RQ_ONOFF_HOTPLUG)
+		SCX_CALL_OP(SCX_KF_REST, cpu_offline, cpu_of(rq));
+}
+
 #else /* !CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
@@ -2370,6 +2383,9 @@ DEFINE_SCHED_CLASS(ext) = {
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
+
+	.rq_online		= rq_online_scx,
+	.rq_offline		= rq_offline_scx,
 #endif
 
 	.task_tick		= task_tick_scx,
-- 
2.41.0


