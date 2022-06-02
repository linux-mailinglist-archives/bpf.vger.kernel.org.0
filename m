Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24053BF0A
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiFBTnD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Jun 2022 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiFBTmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 15:42:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2B60DD
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 12:42:52 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252D0tNP023025
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 12:42:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gewq92pme-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 12:42:52 -0700
Received: from twshared24024.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 12:42:45 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 117FA86C0112; Thu,  2 Jun 2022 12:37:22 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>, <jolsa@kernel.org>,
        <mhiramat@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 5/5] bpf: trampoline: support FTRACE_OPS_FL_SHARE_IPMODIFY
Date:   Thu, 2 Jun 2022 12:37:06 -0700
Message-ID: <20220602193706.2607681-6-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602193706.2607681-1-song@kernel.org>
References: <20220602193706.2607681-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 969mtVx525s5BnEIVjHspkzG3A2mjSqc
X-Proofpoint-GUID: 969mtVx525s5BnEIVjHspkzG3A2mjSqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows bpf trampoline to trace kernel functions with live patch.
Also, move bpf trampoline to *_ftrace_direct_multi APIs, which allows
setting different flags of ftrace_ops.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/bpf.h     |   3 ++
 kernel/bpf/trampoline.c | 109 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a6e06f384e81..20a8ed600ca6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -44,6 +44,7 @@ struct kobject;
 struct mem_cgroup;
 struct module;
 struct bpf_func_state;
+struct ftrace_ops;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -816,6 +817,7 @@ struct bpf_tramp_image {
 struct bpf_trampoline {
 	/* hlist for trampoline_table */
 	struct hlist_node hlist;
+	struct ftrace_ops *fops;
 	/* serializes access to fields of this trampoline */
 	struct mutex mutex;
 	refcount_t refcnt;
@@ -838,6 +840,7 @@ struct bpf_trampoline {
 	struct bpf_tramp_image *cur_image;
 	u64 selector;
 	struct module *mod;
+	bool indirect_call;
 };
 
 struct bpf_attach_target_info {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 93c7675f0c9e..447c788c5520 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -27,6 +27,44 @@ static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline_table */
 static DEFINE_MUTEX(trampoline_mutex);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
+
+static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd cmd)
+{
+	struct bpf_trampoline *tr = ops->private;
+	int ret;
+
+	/*
+	 * The normal locking order is
+	 *    tr->mutex => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
+	 *
+	 * This is called from prepare_direct_functions_for_ipmodify, with
+	 * direct_mutex locked. Use mutex_trylock() to avoid dead lock.
+	 * Also, bpf_trampoline_update here should not lock direct_mutex.
+	 */
+	if (!mutex_trylock(&tr->mutex))
+		return -EAGAIN;
+
+	switch (cmd) {
+	case FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY:
+		tr->indirect_call = true;
+		ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */);
+		break;
+	case FTRACE_OPS_CMD_DISABLE_SHARE_IPMODIFY:
+		tr->indirect_call = false;
+		tr->fops->flags &= ~FTRACE_OPS_FL_SHARE_IPMODIFY;
+		ret = bpf_trampoline_update(tr, false /* lock_direct_mutex */);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	};
+	mutex_unlock(&tr->mutex);
+	return ret;
+}
+#endif
+
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 {
 	enum bpf_attach_type eatype = prog->expected_attach_type;
@@ -87,7 +125,16 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
 		goto out;
-
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
+	if (!tr->fops) {
+		kfree(tr);
+		tr = NULL;
+		goto out;
+	}
+	tr->fops->private = tr;
+	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
+#endif
 	tr->key = key;
 	INIT_HLIST_NODE(&tr->hlist);
 	hlist_add_head(&tr->hlist, head);
@@ -126,7 +173,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct((long)ip, (long)old_addr);
+		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -135,15 +182,20 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	return ret;
 }
 
-static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr)
+static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr,
+			 bool lock_direct_mutex)
 {
 	void *ip = tr->func.addr;
 	int ret;
 
-	if (tr->func.ftrace_managed)
-		ret = modify_ftrace_direct((long)ip, (long)old_addr, (long)new_addr);
-	else
+	if (tr->func.ftrace_managed) {
+		if (lock_direct_mutex)
+			ret = modify_ftrace_direct_multi(tr->fops, (long)new_addr);
+		else
+			ret = modify_ftrace_direct_multi_nolock(tr->fops, (long)new_addr);
+	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
+	}
 	return ret;
 }
 
@@ -161,10 +213,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	if (bpf_trampoline_module_get(tr))
 		return -ENOENT;
 
-	if (tr->func.ftrace_managed)
-		ret = register_ftrace_direct((long)ip, (long)new_addr);
-	else
+	if (tr->func.ftrace_managed) {
+		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 0);
+		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
+		if (ret)
+			ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 1, 0);
+
+	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
+	}
 
 	if (ret)
 		bpf_trampoline_module_put(tr);
@@ -330,7 +387,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr)
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_links *tlinks;
@@ -363,20 +420,45 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
 	if (ip_arg)
 		flags |= BPF_TRAMP_F_IP_ARG;
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+again:
+	if (tr->indirect_call)
+		flags |= BPF_TRAMP_F_ORIG_STACK;
+#endif
+
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
 					  &tr->func.model, flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
 		goto out;
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	if (tr->indirect_call)
+		tr->fops->flags |= FTRACE_OPS_FL_SHARE_IPMODIFY;
+#endif
+
 	WARN_ON(tr->cur_image && tr->selector == 0);
 	WARN_ON(!tr->cur_image && tr->selector);
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = modify_fentry(tr, tr->cur_image->image, im->image);
+		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
 	else
 		/* first time registering */
 		err = register_fentry(tr, im->image);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	if (err == -EAGAIN) {
+		if (WARN_ON_ONCE(tr->indirect_call))
+			goto out;
+		/* should only retry on the first register */
+		if (WARN_ON_ONCE(tr->cur_image))
+			goto out;
+		tr->indirect_call = true;
+		tr->fops->func = NULL;
+		tr->fops->trampoline = 0;
+		goto again;
+	}
+#endif
 	if (err)
 		goto out;
 	if (tr->cur_image)
@@ -460,7 +542,7 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline
 
 	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
-	err = bpf_trampoline_update(tr);
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
 		tr->progs_cnt[kind]--;
@@ -487,7 +569,7 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
-	err = bpf_trampoline_update(tr);
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 out:
 	mutex_unlock(&tr->mutex);
 	return err;
@@ -535,6 +617,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 * multiple rcu callbacks.
 	 */
 	hlist_del(&tr->hlist);
+	kfree(tr->fops);
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
-- 
2.30.2

