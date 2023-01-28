Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D3967F30D
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjA1AUH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjA1ATK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:19:10 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E6020D31;
        Fri, 27 Jan 2023 16:17:57 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u5so4032839pfm.10;
        Fri, 27 Jan 2023 16:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8dhPlwDkUf9/cVdreQsI02YoQT+NTF288fEP0czgDg=;
        b=TEdOLq/I1+MrAVG6CHqzZzek0q8+M8rJTdF7Sc7jRNZ5yzNPo8SP94e77wAO7XgQuC
         eZNsSRiZDQW1klMaAu/h8U6oXbWv3okaBEQoDGaZjUmhHol/MM5CDFj/qrSA0gsXBeBG
         kYqq829YNcy55wkrHNDklGNsEE8/IhYgAYdIIQfAUNcC7qhvbL9jjuWKzOS/xxv8qur4
         //xN9ie7fuly+nqM+l1nTvy11prnlNYu9NThokxGX+L3mGdaoaXg9kIKD3MZwvzpk9XA
         PERs+C1bKFW7+ajvwc79U/gaxqeViNRcUPdGdnxKKHV3i68k/IlGkeifH2e2x31iF+vN
         AcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q8dhPlwDkUf9/cVdreQsI02YoQT+NTF288fEP0czgDg=;
        b=ueseWKANu3YjGBt2uW16FLhtLJFdfMxuQUHCaj+5e16+ehepAWUq7Cjw09ZXrr1lmy
         vKA+oFU8IQep7TbMbE3/YnCVCJ/Yvh14YPk4HuYR+VJxHli018JDcqBSMMVakk5uJ1Hx
         96ORUNGLlqYHQ4zO7eINT/PVfH1qZha9rnlTbvc3ab6F5zTvQgKz8/NiId56/I3PrL+C
         OEnQmxvF2TV+N3ONDKqzkWPLtTmpEz2kmOHf9H87hWUh+sMFm9OpQV6CEh7bV+H4h6XU
         A8ZhSslipNmtJbMIDoDFBaEyBAC1yebCCmz3utBmARe82gdseNAOI3Y0t/e1FuQQQhd4
         99aw==
X-Gm-Message-State: AO0yUKUbbF9gw4QoeTrAr+FOMv8mI+uvUk1PSdd+mAalb9RS9Gzmr16N
        aDER4jmn3RyQrY8MohBaRjw=
X-Google-Smtp-Source: AK7set/hImDu1ceYY/CLBF2S6sibkELRQHuTEFfkzRzrjuk+xMH7BE4lJkXeuGvFe3dh6RMMy2s/2w==
X-Received: by 2002:a05:6a00:1707:b0:593:4815:b2ec with SMTP id h7-20020a056a00170700b005934815b2ecmr2944144pfc.8.1674865060487;
        Fri, 27 Jan 2023 16:17:40 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b00582bdaab584sm3202452pfd.81.2023.01.27.16.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:40 -0800 (PST)
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
Subject: [PATCH 26/30] sched_ext: Implement sched_ext_ops.cpu_online/offline()
Date:   Fri, 27 Jan 2023 14:16:35 -1000
Message-Id: <20230128001639.3510083-27-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 82ead36d1136..01c846445243 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -368,6 +368,24 @@ struct sched_ext_ops {
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
index 072082968f0f..e981b7111e0a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1727,6 +1727,18 @@ void __scx_update_idle(struct rq *rq, bool idle)
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
@@ -2215,6 +2227,9 @@ DEFINE_SCHED_CLASS(ext) = {
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
+
+	.rq_online		= rq_online_scx,
+	.rq_offline		= rq_offline_scx,
 #endif
 
 	.task_tick		= task_tick_scx,
-- 
2.39.1

