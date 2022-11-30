Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE58363D07B
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiK3IZh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiK3IYz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:24:55 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153F6DFFB;
        Wed, 30 Nov 2022 00:24:10 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w129so16152605pfb.5;
        Wed, 30 Nov 2022 00:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZXs/tHvndxmGX94M+8xZoj6QZaNPUzG00ObylI8ArA=;
        b=Xd5j4gE7oX5D6D+g9dm5qtSCevEdbriaEgZeism3Wy0ktHo9b9FkKWzenhpjinCxU3
         HDUXWRMyMwX1FwULxMO0LB1a623C10YCHFF4aAdZAenvucQNO3vu4NZ2TGatbRNLycC8
         V2DRgteQWjJW4y9yMKrkQDClSt8gaZHD6si/K1qvbLAD7lPCfsrQiWVmayAoyUqgcomQ
         H9mCSvQyZqZpuJOczOVpJdEemD8UmsiKY1ONDNUgPgvuWzVHbdlyXT1UUSx5FtAQqTf1
         73U/DLGfLayBXB3pf68BYDPGfIzfQPxQQzWAh5pF246kY+J4y2Y51evYVdRje0XhD750
         S42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JZXs/tHvndxmGX94M+8xZoj6QZaNPUzG00ObylI8ArA=;
        b=Lyy3g9qqtvt3xuU+vQJoJqecs6vy8n9rLoDLJIGyxNbksgnOqqcDoqiD94UZMEtHZ5
         biQ4ZMtlG3lZqfT6iqD/6t1Jsy2GxFIwmuJnAv15b/XhGPj4Q6XK2j8zLwUyxAcYD42L
         0T70Jz57spTw3VtJH8z8WL3pP3BKTAcVZoMx02J5W796zdOAcK5mrCG3fHWm4oBabALf
         XNJbn8Mzul0fznnQIhk6BWInvclIDcQIqVKeJ4kIcT10pIYGf7p0HYGDT1bOOqeu8kZK
         nptvdlypKMK2Vwh2BQKhgML/+BZpRLU8ebiD/NfOmGB/UDit2wjkC204jWuD3sVdGdnV
         nLJw==
X-Gm-Message-State: ANoB5pnIDjUd1DxTYbvYYY0HZsS106guGADzteivAjqE90YIBrJxzzLh
        lZzZ6fErdSiz4Bu4sWyG0T4=
X-Google-Smtp-Source: AA0mqf73gUCLJfUooieU9UjobbvjGv4CN28mvSpS8LEdRLMy+QDHVOIJ/bSQmXxdX6Cj6Ss4YWE6rA==
X-Received: by 2002:a62:840b:0:b0:575:2199:70e8 with SMTP id k11-20020a62840b000000b00575219970e8mr15236940pfd.14.1669796649470;
        Wed, 30 Nov 2022 00:24:09 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id z22-20020a63d016000000b004761e544ec6sm515630pgf.89.2022.11.30.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:09 -0800 (PST)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH 15/31] sched_ext: [TEMPORARY] Add temporary workaround kfunc helpers
Date:   Tue, 29 Nov 2022 22:22:57 -1000
Message-Id: <20221130082313.3241517-16-tj@kernel.org>
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

THIS IS A TEMPORARY WORKAROUND. WILL BE DROPPED.

These exist to work around till we have proper generic BPF helpers.

NOT_FOR_UPSTREAM
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Dave Marchevsky <davemarchevsky@meta.com>
---
 kernel/sched/ext.c | 84 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f42464d66de4..1428385093dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2745,6 +2745,86 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.set			= &scx_kfunc_ids_any,
 };
 
+/********************************************************************************
+ * Temporary BPF helpers to be replaced by generic non-scx-specific BPF helpers
+ */
+
+struct cgroup *scx_bpf_task_cgroup(const struct task_struct *p)
+{
+	struct task_group *tg = p->sched_task_group;
+
+	if (tg && tg->css.cgroup)
+		return tg->css.cgroup;
+	else
+		return &cgrp_dfl_root.cgrp;
+}
+
+struct task_struct *scx_bpf_find_task_by_pid(s32 pid)
+{
+	return find_task_by_pid_ns(pid, &init_pid_ns);
+}
+
+s32 scx_bpf_pick_idle_cpu_untyped(unsigned long cpus_allowed)
+{
+	return scx_bpf_pick_idle_cpu((const struct cpumask *)cpus_allowed);
+}
+
+bool scx_bpf_has_idle_cpus_among(const struct cpumask *cpus_allowed)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return false;
+	}
+#ifdef CONFIG_SMP
+	return cpumask_any_and(idle_masks.cpu, cpus_allowed) < nr_cpu_ids;
+#else
+	return false;
+#endif
+}
+
+s32 scx_bpf_has_idle_cpus_among_untyped(unsigned long cpus_allowed)
+{
+	return scx_bpf_has_idle_cpus_among((const struct cpumask *)cpus_allowed);
+}
+
+s32 scx_bpf_cpumask_test_cpu(s32 cpu, const struct cpumask *cpumask)
+{
+	return cpumask_test_cpu(cpu, cpumask);
+}
+
+s32 scx_bpf_cpumask_first(const struct cpumask *cpus_allowed)
+{
+	return cpumask_first(cpus_allowed);
+}
+
+s32 scx_bpf_cpumask_first_untyped(unsigned long cpus_allowed)
+{
+	return cpumask_first((const struct cpumask *)cpus_allowed);
+}
+
+bool scx_bpf_cpumask_intersects(const struct cpumask *src1p,
+				const struct cpumask *src2p)
+{
+	return cpumask_intersects(src1p, src2p);
+}
+
+BTF_SET8_START(scx_kfunc_ids_xxx)
+BTF_ID_FLAGS(func, scx_bpf_task_cgroup)
+BTF_ID_FLAGS(func, scx_bpf_find_task_by_pid, KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_untyped)
+BTF_ID_FLAGS(func, scx_bpf_has_idle_cpus_among)
+BTF_ID_FLAGS(func, scx_bpf_has_idle_cpus_among_untyped)
+BTF_ID_FLAGS(func, scx_bpf_cpumask_test_cpu)
+BTF_ID_FLAGS(func, scx_bpf_cpumask_first)
+BTF_ID_FLAGS(func, scx_bpf_cpumask_first_untyped)
+BTF_ID_FLAGS(func, scx_bpf_cpumask_intersects)
+BTF_SET8_END(scx_kfunc_ids_xxx)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_xxx = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_xxx,
+};
+
 __diag_pop();
 
 /*
@@ -2770,7 +2850,9 @@ static int __init register_ext_kfuncs(void)
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_online)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_any))) {
+					     &scx_kfunc_set_any)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_xxx))) {
 		pr_err("sched_ext: failed to register kfunc sets (%d)\n", ret);
 		return ret;
 	}
-- 
2.38.1

