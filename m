Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93AE63D08F
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiK3I1J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiK3I0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:26:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F7654E3;
        Wed, 30 Nov 2022 00:24:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id o1so11608176pfp.12;
        Wed, 30 Nov 2022 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z3GprH1pp84MWfe+7OnmUCElSOiK2zPKNBF1OgTbsQ=;
        b=GMkv+ohqpS1dMznFVn3RUzHRhXhriAHoM9YlFlSR5agq6W6y+rPOh2W3C/ErRz7eOt
         9aBqm8jGEu5MCG9wdrJlsvsH/IKP57iYLGIf3NEmRpWFO2ERE4+iefqpUzujONrjA04l
         LAVzSgbt2AvXARIKAEz0iUT4ksAlPBn0LnvCFc8OGmr5HcfBkMbTIrtbnePAVFDCovvK
         m+3x1oReNUojIC3w6h9aqs9HQRT344qCqjnygzp/M5jMca71zjJZ1iP9YR2DbzVXD/6D
         T8ETeRrhc+95FDmiDgHbEHdQ6EwPb7cWPIPuXiDAOOL7Cc3ehMvR46LOar/ol3KAcUe5
         Skhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5z3GprH1pp84MWfe+7OnmUCElSOiK2zPKNBF1OgTbsQ=;
        b=Vh+95ttd4SeR6DC57UvfxpO9KMCLpT8eWiJx3x4zW+vqQsP4JocCzQ3MSfgONdpmkw
         E0eDn+2qrnzH3HimnSf87hv8WnWIUiEGeLYgnsoHTE7LolGIzzHFSkrtWZHgHuPvSdPA
         i1/gRhnZOrvLuUbrMbOb3if/8w2LOq6IzVccNmG06WUz1p1LdMwQF2zlWSCfHcwNemLA
         YL7nVb6mSC2lMpLtXQ3qx8zKsYO20+VYR+DC54dQP4lUZhawucaRDuG/haZLI776Moek
         f5Lea00tRXhmpFjUKn9ZbkMoeXhnC06NCpzC67IyZqGD84MEUn7ipYI1QzOHvGC6WH8Y
         QQWQ==
X-Gm-Message-State: ANoB5pm3JHZucLvOwjtP7qIU6QvFX88ooraNqAsSU2wKQLhS3wR8t+Rg
        iKEZ8mwgvgxhLI43yBs4V4g=
X-Google-Smtp-Source: AA0mqf5abYIzg94lJG4TmTISQGdiVpSgpIHOaET9p3gg21b01KHPIESCEdxzJRsJI4BqNja20sqkDw==
X-Received: by 2002:a63:fc63:0:b0:478:18d6:ad22 with SMTP id r35-20020a63fc63000000b0047818d6ad22mr12578836pgk.492.1669796674939;
        Wed, 30 Nov 2022 00:24:34 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b00187197c4999sm748502pls.167.2022.11.30.00.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 27/31] sched_ext: Implement sched_ext_ops.cpu_online/offline()
Date:   Tue, 29 Nov 2022 22:23:09 -1000
Message-Id: <20221130082313.3241517-28-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
 kernel/sched/ext.c        | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 61f45aa03704..d9f941e23011 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -384,6 +384,24 @@ struct sched_ext_ops {
 	 */
 	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 
+	/**
+	 * cpu_online - A CPU became online
+	 * @cpu: CPU which just came up
+	 *
+	 * @cpu just came online. @cpu doesn't call ->enqueue() or consume tasks
+	 * associated with other CPUs beforehand.
+	 */
+	void (*cpu_online)(s32 cpu);
+
+	/**
+	 * cpu_offline - A CPU is going offline
+	 * @cpu: CPU which is going offline
+	 *
+	 * @cpu is going offline. @cpu doesn't call ->enqueue() or consume tasks
+	 * associated with other CPUs afterwards.
+	 */
+	void (*cpu_offline)(s32 cpu);
+
 	/**
 	 * prep_enable - Prepare to enable BPF scheduling for a task
 	 * @p: task to prepare BPF scheduling for
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9a7a4e54e8fa..aab9ae13b88f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1574,6 +1574,18 @@ void __scx_update_idle(struct rq *rq, bool idle)
 	}
 }
 
+static void rq_online_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (SCX_HAS_OP(cpu_online) && reason == RQ_ONOFF_HOTPLUG)
+		scx_ops.cpu_online(cpu_of(rq));
+}
+
+static void rq_offline_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (SCX_HAS_OP(cpu_offline) && reason == RQ_ONOFF_HOTPLUG)
+		scx_ops.cpu_offline(cpu_of(rq));
+}
+
 #else /* !CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
@@ -2049,6 +2061,9 @@ DEFINE_SCHED_CLASS(ext) = {
 	.pick_task		= pick_task_scx,
 
 	.set_cpus_allowed	= set_cpus_allowed_scx,
+
+	.rq_online		= rq_online_scx,
+	.rq_offline		= rq_offline_scx,
 #endif
 
 	.task_tick		= task_tick_scx,
-- 
2.38.1

