Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092AC6BF44B
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCQVgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCQVgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED02DE51;
        Fri, 17 Mar 2023 14:35:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso6631116pjb.2;
        Fri, 17 Mar 2023 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K7uT5MTAAWZJBuE8qEaFUDCULD6bsJ7gIDLvBZb3/E=;
        b=Oe/grPgbOTYv/R7zibXuXsAM8Zrl3ckCZ56OLBvR2ChKOGmbhe0AVapP9Uj7NEjgxs
         T7gZt1VpGQR0rJ98GNhcQDMT7VSHR01oHGIojr9H7RWxS4PybzKt9Vqo/g9T7Ur90YLb
         GHgTMyx40348aKZYRDndi2oDlD0+gEpCsHpliC5LaWgxkyd4bmGK2hN489QKK/8ZKqVy
         ++zdt4jahFxNAuEQM88Qpk61vBzrVxgktcQlLOuvouNF3OAiBePKb3s4KFanJbD9gtf7
         Zm2fwYVC4W0SPZ9Lc+Uy1tvAUU1wz/t96uoNi1WIlmrWm1C9OFSp8BXA2dAM/yxTbyoB
         6SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1K7uT5MTAAWZJBuE8qEaFUDCULD6bsJ7gIDLvBZb3/E=;
        b=29SvO4QFUxq3sr/0OWit1h1MJ11QAXMKk9nDOaSenzGvSlccSTM2nNjZojdxc7HhZO
         VUIc7eqj5cfk4bTK+wRQZ/nIeRVJDDaudEZrSo4wUb+MuPItB2VOhHOYPL7UvdGgpvwe
         e3hcFAG0/IGF15DPAu2d34yFQQL6VR3E/u4+EWHM9MTHhmw8qdBZNE1c91Zf6Ye5N5tp
         Bqs6X4kWidrgmcEMJcde79obUuWurubnIhPKwsJ3IfATxW5cVj7irmpsP5mB/cvZJUZN
         KOhi7w9BtUcVWsIDknAjozXiz7u9A68Daeae0IZpGVWtWu/Gl6xo92iVE+06+TnSQ/bN
         oI/Q==
X-Gm-Message-State: AO0yUKUMptH48FW3otQlnIZyVVK+gGBMM3fwioN3ZGN6aI4y7bJN5pnf
        TplLuzWmGvj1siOv8GtEK54=
X-Google-Smtp-Source: AK7set9IeOIt4xesbDQMcxvHiPj21l0U+baQByfkZa9TbTX/L/B6X0ZBlgTl3DKVThowVemtrsjvGA==
X-Received: by 2002:a17:902:c651:b0:1a1:8b54:ab58 with SMTP id s17-20020a170902c65100b001a18b54ab58mr7079692pls.19.1679088850715;
        Fri, 17 Mar 2023 14:34:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b0019c2cf12d15sm1967084plb.116.2023.03.17.14.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:10 -0700 (PDT)
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
Subject: [PATCH 15/32] sched_ext: Add sysrq-S which disables the BPF scheduler
Date:   Fri, 17 Mar 2023 11:33:16 -1000
Message-Id: <20230317213333.2174969-16-tj@kernel.org>
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
index 45bf24a23c61..4b6b9386e2f8 100644
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
index 738ae1d7a8ee..9406869fbc90 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1930,6 +1930,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
 		break;
+	case SCX_EXIT_SYSRQ:
+		reason = "disabled by sysrq-S";
+		break;
 	case SCX_EXIT_ERROR:
 		reason = "runtime error";
 		break;
@@ -2539,6 +2542,21 @@ struct bpf_struct_ops bpf_sched_ext_ops = {
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
@@ -2562,6 +2580,8 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 	}
+
+	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 }
 
 
-- 
2.39.2

