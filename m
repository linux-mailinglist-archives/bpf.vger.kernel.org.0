Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1584C1049
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 11:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiBWK3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 05:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiBWK3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 05:29:16 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0548C7DF;
        Wed, 23 Feb 2022 02:28:47 -0800 (PST)
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K3XH23xk5z9sGb;
        Wed, 23 Feb 2022 18:25:18 +0800 (CST)
Received: from linux-suse12sp5.huawei.com (10.67.133.175) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 23 Feb 2022 18:28:43 +0800
From:   Yan Zhu <zhuyan34@huawei.com>
To:     <mcgrof@kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <kafai@fb.com>,
        <keescook@chromium.org>, <kpsingh@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liucheng32@huawei.com>, <netdev@vger.kernel.org>,
        <nixiaoming@huawei.com>, <songliubraving@fb.com>,
        <xiechengliang1@huawei.com>, <yhs@fb.com>, <yzaikin@google.com>,
        <zengweilin@huawei.com>, <zhuyan34@huawei.com>
Subject: [PATCH v2 sysctl-next] bpf: move the bpf syscall sysctl table to bpf module
Date:   Wed, 23 Feb 2022 18:28:08 +0800
Message-ID: <20220223102808.80846-1-zhuyan34@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <YhWQ+0qPorcJ/Z8l@bombadil.infradead.org>
References: <YhWQ+0qPorcJ/Z8l@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.175]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Aggregating the code of the feature in the code file of the feature
itself can improve readability and reduce merge conflicts. So move
the bpf syscall sysctl table to kernel/bpf/syscall.c

Signed-off-by: Yan Zhu <zhuyan34@huawei.com>

---
v1->v2:
  1.Added patch branch identifier sysctl-next.
  2.Re-describe the reason for the patch submission.
---
 kernel/bpf/syscall.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c      | 71 ----------------------------------------------
 2 files changed, 80 insertions(+), 71 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 35646db3d950..50f85b47d478 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4888,3 +4888,83 @@ const struct bpf_verifier_ops bpf_syscall_verifier_ops = {
 const struct bpf_prog_ops bpf_syscall_prog_ops = {
 	.test_run = bpf_prog_test_run_syscall,
 };
+
+#ifdef CONFIG_SYSCTL
+static int bpf_stats_handler(struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct static_key *key = (struct static_key *)table->data;
+	static int saved_val;
+	int val, ret;
+	struct ctl_table tmp = {
+		.data   = &val,
+		.maxlen = sizeof(val),
+		.mode   = table->mode,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_ONE,
+	};
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&bpf_stats_enabled_mutex);
+	val = saved_val;
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret && val != saved_val) {
+		if (val)
+			static_key_slow_inc(key);
+		else
+			static_key_slow_dec(key);
+		saved_val = val;
+	}
+	mutex_unlock(&bpf_stats_enabled_mutex);
+	return ret;
+}
+
+static int bpf_unpriv_handler(struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, unpriv_enable = *(int *)table->data;
+	bool locked_state = unpriv_enable == 1;
+	struct ctl_table tmp = *table;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	tmp.data = &unpriv_enable;
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret) {
+		if (locked_state && unpriv_enable != 1)
+			return -EPERM;
+		*(int *)table->data = unpriv_enable;
+	}
+	return ret;
+}
+
+static struct ctl_table bpf_syscall_table[] = {
+	{
+		.procname	= "unprivileged_bpf_disabled",
+		.data		= &sysctl_unprivileged_bpf_disabled,
+		.maxlen		= sizeof(sysctl_unprivileged_bpf_disabled),
+		.mode		= 0644,
+		.proc_handler	= bpf_unpriv_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{
+		.procname	= "bpf_stats_enabled",
+		.data		= &bpf_stats_enabled_key.key,
+		.maxlen		= sizeof(bpf_stats_enabled_key),
+		.mode		= 0644,
+		.proc_handler	= bpf_stats_handler,
+	},
+	{ }
+};
+
+static int __init bpf_syscall_sysctl_init(void)
+{
+	register_sysctl_init("kernel", bpf_syscall_table);
+	return 0;
+}
+late_initcall(bpf_syscall_sysctl_init);
+#endif /* CONFIG_SYSCTL */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ae5e59396b5d..c64db3755d9c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -146,59 +146,6 @@ static const int max_extfrag_threshold = 1000;
 
 #endif /* CONFIG_SYSCTL */
 
-#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
-static int bpf_stats_handler(struct ctl_table *table, int write,
-			     void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct static_key *key = (struct static_key *)table->data;
-	static int saved_val;
-	int val, ret;
-	struct ctl_table tmp = {
-		.data   = &val,
-		.maxlen = sizeof(val),
-		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
-		.extra2 = SYSCTL_ONE,
-	};
-
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	mutex_lock(&bpf_stats_enabled_mutex);
-	val = saved_val;
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
-	if (write && !ret && val != saved_val) {
-		if (val)
-			static_key_slow_inc(key);
-		else
-			static_key_slow_dec(key);
-		saved_val = val;
-	}
-	mutex_unlock(&bpf_stats_enabled_mutex);
-	return ret;
-}
-
-static int bpf_unpriv_handler(struct ctl_table *table, int write,
-			      void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int ret, unpriv_enable = *(int *)table->data;
-	bool locked_state = unpriv_enable == 1;
-	struct ctl_table tmp = *table;
-
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	tmp.data = &unpriv_enable;
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
-	if (write && !ret) {
-		if (locked_state && unpriv_enable != 1)
-			return -EPERM;
-		*(int *)table->data = unpriv_enable;
-	}
-	return ret;
-}
-#endif /* CONFIG_BPF_SYSCALL && CONFIG_SYSCTL */
-
 /*
  * /proc/sys support
  */
@@ -2188,24 +2135,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-#ifdef CONFIG_BPF_SYSCALL
-	{
-		.procname	= "unprivileged_bpf_disabled",
-		.data		= &sysctl_unprivileged_bpf_disabled,
-		.maxlen		= sizeof(sysctl_unprivileged_bpf_disabled),
-		.mode		= 0644,
-		.proc_handler	= bpf_unpriv_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "bpf_stats_enabled",
-		.data		= &bpf_stats_enabled_key.key,
-		.maxlen		= sizeof(bpf_stats_enabled_key),
-		.mode		= 0644,
-		.proc_handler	= bpf_stats_handler,
-	},
-#endif
 #if defined(CONFIG_TREE_RCU)
 	{
 		.procname	= "panic_on_rcu_stall",
-- 
2.12.3

