Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE396BF460
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCQVhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCQVg3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527954BE95;
        Fri, 17 Mar 2023 14:35:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x37so3693643pga.1;
        Fri, 17 Mar 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFCkEOmw90Jjcera7igv6WX4z3OoBiQTwIKlnmq8L8s=;
        b=EQjZrfDdctZarieGDQuSWN9o8QXycWg6RDZ8NtZ35BpwmjqQXpoBYsTmKlZHb3hIZt
         wn2wDlkUSrAdeK2JZQdzDdsXvqU6QZG9hPm2zJhkJOtgbukIgIzxG+wC7GOBPLN4Fz6I
         L0lEK4Iz5DYKOXksnTFd+ubMJX6AplWMvcyEBbkQcPUCzbidTesCkWdYy9MTSlk/Dmea
         7CS8Owf1OA17Y+dLJ0EgFWnhMkpBT4FY18kC1fnnHIvKI0LIWnDyUpBs1vqYfddQO+/I
         u5mWoVvwKEBuMBwoYI9W8d+HVV9RFtcl7jYY7bFbHjh5uLhaU3WBCgZ7nfqyGWWA7zYe
         v4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFCkEOmw90Jjcera7igv6WX4z3OoBiQTwIKlnmq8L8s=;
        b=azyJAYKMtk/oKDY1Z0GNOBMBYqxsNkgT+EUqYVcVG/jEptbtVABrSTR5Vgn7p5zSo0
         Gu8VNcs/ZmO/H8qiI3kq0LnCe12TVgyoKyGxttyDsaFuf0IL1Ni5JkxRkqE95Qq2QA4f
         2ITXU/F3Mp9NO9ePee0IZ2/3B9IgXAxnf7WPW5XUB9KmnmFzo3cuFaD9nu40pYsdl4z5
         xWzV9Ggace/BGv2eavm5y5hBFJhJZszMhCnD/MkNK+Tz2wbxaMCxDCLXtg55K9XckkuG
         jUW/IfvIfMtiitGVhpOTH6+iUDMncakVvnutk3GqwH5tq/fsBKy6iqscb71gz6csNLMN
         Yfhw==
X-Gm-Message-State: AO0yUKVc0meSwjN2FxBHfmzsP61xtXm5ncsgd4SmLeibfFtqOOAzXqDT
        6OVzPilapqOr7t9sVgGR5Z0=
X-Google-Smtp-Source: AK7set+QbTsk+yt/GGE6IK0Z4aRTtBWCYNm5zrZEOnATrmEVYJkXFHJ1Qj6JxqxJUUdDzIkMKlmNTA==
X-Received: by 2002:a62:1dc3:0:b0:622:749a:b9de with SMTP id d186-20020a621dc3000000b00622749ab9demr7318031pfd.27.1679088872276;
        Fri, 17 Mar 2023 14:34:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79143000000b0059261bd5bacsm1944724pfi.202.2023.03.17.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:31 -0700 (PDT)
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
Subject: [PATCH 27/32] sched_ext: Implement sched_ext_ops.cpu_online/offline()
Date:   Fri, 17 Mar 2023 11:33:28 -1000
Message-Id: <20230317213333.2174969-28-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 kernel/sched/ext.c        | 18 +++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 826da32e29ba..63a011860f59 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -378,6 +378,24 @@ struct sched_ext_ops {
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
index 4f342b7a6f45..dbeec22bee73 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1393,7 +1393,8 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		 * emitted in scx_notify_pick_next_task().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq),
+				    NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -1824,6 +1825,18 @@ void __scx_update_idle(struct rq *rq, bool idle)
 	}
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
@@ -2329,6 +2342,9 @@ DEFINE_SCHED_CLASS(ext) = {
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
+
+	.rq_online		= rq_online_scx,
+	.rq_offline		= rq_offline_scx,
 #endif
 
 	.task_tick		= task_tick_scx,
-- 
2.39.2

