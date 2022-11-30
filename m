Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7B63D07F
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiK3I0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiK3IZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:22 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E55F6F83F;
        Wed, 30 Nov 2022 00:24:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c15so6849988pfb.13;
        Wed, 30 Nov 2022 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvUGhplUugUdbhZ6AcFPSZ2kGK89RILzAfThTT+mh4o=;
        b=Aqi+ctOZLyxpQeJ9kP9vRp7mV73z26pS3NRvNv1lfheJ6bopv/MA0ovZiuVRnL8oLk
         LNHV5JKI6du5qZUhib95ZKiXhfCMkYZbrPPI/q49G4kv009reSMXAfF8i5K4k3uaW761
         Ro72iZOJE3TPBerxs0KqscMcI9avf5uHb3lofWm5zooDZngDttyV/3/BbK37Q74hK5S4
         nd4B8yQZYZS6EgBofp2InS5ng59u6hfTUjv8p/bI9XnXwzYCQ2vgH6S7nYVz0Aje5iUY
         6K5ZuRBnywC2ADe6uTHV9lSPJy+Gibxm+xw34ED+B+zQJ6lQxHpiicr1J46kgW6FXA2S
         rvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvUGhplUugUdbhZ6AcFPSZ2kGK89RILzAfThTT+mh4o=;
        b=HGzh6Buou/2iJgRenbUAgH5UemvcN0ohaKfo/iogsR/ix9jthtX3f+NO8aqbcQ8yia
         3lvPdb56Ud7NisEQGhr7McmJ8AwyMnJiDErIfBW/057vfxnnw+EiF0gwvxrfd/4JA8Lc
         9dZx/Kq0t+DYrD4L3FkCZIGf1m2vpQ79aLkci5NbYxT+lz/4mniPTRlJDdFeciF3UIlU
         CQ01LWgth00AQuyB3jhNe2Om1mSrfzehq1/0JWnTP3KIcVmygSCeMUE43ajb103FvTEE
         RVZaXr5juHGvmMdCQF90ja6Mf7a7nDS/34TilRPGPvNh79uU5NgvqnwD9OH82dVNuHgY
         CWfA==
X-Gm-Message-State: ANoB5ply8n1uKWEr3JudGXmX63q9kQNlA4al3YRlRg+WzcfEI7JeQW9w
        fWbGS3+XoyfiW/BivkTCO1CBbanhpvfy2A==
X-Google-Smtp-Source: AA0mqf5E5M8TU/Bwg2ulcTDcSUxY4JBCDG/ToY1x+skWe/Km784BlYrJdF5iBWCQDPeRHKrTlbqNww==
X-Received: by 2002:a65:4584:0:b0:478:50ca:cdf2 with SMTP id o4-20020a654584000000b0047850cacdf2mr4414909pgq.200.1669796653923;
        Wed, 30 Nov 2022 00:24:13 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a764400b0020087d7e778sm2558390pjl.37.2022.11.30.00.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:13 -0800 (PST)
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
Subject: [PATCH 17/31] sched_ext: Add sysrq-S which disables the BPF scheduler
Date:   Tue, 29 Nov 2022 22:22:59 -1000
Message-Id: <20221130082313.3241517-18-tj@kernel.org>
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
index d2b2720db6ca..b3c22bf5f0d1 100644
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
index e2e743ccd00d..1ec8be53057f 100644
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
index 1428385093dc..a0057a8447cb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1771,6 +1771,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
 		break;
+	case SCX_EXIT_SYSRQ:
+		reason = "disabled by sysrq-S";
+		break;
 	case SCX_EXIT_ERROR:
 		reason = "runtime error";
 		break;
@@ -2377,6 +2380,21 @@ struct bpf_struct_ops bpf_sched_ext_ops = {
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
@@ -2400,6 +2418,8 @@ void __init init_sched_ext_class(void)
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		rq->scx.nr_running = 0;
 	}
+
+	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 }
 
 
-- 
2.38.1

