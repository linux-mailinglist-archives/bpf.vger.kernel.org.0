Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83108631109
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiKSVHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiKSVHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 16:07:54 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3D165A9;
        Sat, 19 Nov 2022 13:07:53 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id 8so5798157qka.1;
        Sat, 19 Nov 2022 13:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG783cJBzhJI3FEVV7fYqSL6/RL6gVAUQblCpuAVDEg=;
        b=6TMzDNs8610JbKmtxsdkaipJdf/dqy/H/NVI/HYY2fmytyX0JUWgYSuJE4GbwiehjV
         2hHcU3j8bi/twSGTZ3qqSmRty0bmKDqcWKdzuImERRVFaJMpbuDQbDcn1l+2/u8u5456
         RyWxhRQ2YQdMM9M2WyfiXehGtmyoTLX92CkOJe8k89FAP9Y3cPwFBL6hdq95jYccVpo3
         +rKTYXHsuOMPpWyPNHOZfTgI9Gx0k1RQiWTeKurtU7Kq4ol9P2auUKzVjHU8JYZjjaga
         xNZIxw4pdTAkCqmMLid6Q5DPBjkCrLxFhA/0Ct1eFLl0mmOVvVA/aSdzi4yZ6/+xZeM+
         zZaw==
X-Gm-Message-State: ANoB5plzO4S2HH+57Ocwvjt6iZPJEB3OC1WRh/LKyi4biAdVAMzC33Uy
        9G1+ZN/SxkgPWqPV2TvncO0rth8D5niEwEu7
X-Google-Smtp-Source: AA0mqf7MYyO6iNZi7npFxcGBbEha9m7GNtFKKho5wW5yvztvIRU25HXgACS0Awgbjk/JvN+IG1TlDA==
X-Received: by 2002:a05:620a:6011:b0:6e8:1fa:13e9 with SMTP id dw17-20020a05620a601100b006e801fa13e9mr11050158qkb.393.1668892072683;
        Sat, 19 Nov 2022 13:07:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6319])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a410800b006ecb9dfdd15sm5215733qko.92.2022.11.19.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 13:07:52 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next v8 2/3] bpf: Add kfuncs for storing struct task_struct * as a kptr
Date:   Sat, 19 Nov 2022 15:07:47 -0600
Message-Id: <20221119210748.3325667-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119210748.3325667-1-void@manifault.com>
References: <20221119210748.3325667-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that BPF supports adding new kernel functions with kfuncs, and
storing kernel objects in maps with kptrs, we can add a set of kfuncs
which allow struct task_struct objects to be stored in maps as
referenced kptrs. The possible use cases for doing this are plentiful.
During tracing, for example, it would be useful to be able to collect
some tasks that performed a certain operation, and then periodically
summarize who they are, which cgroup they're in, how much CPU time
they've utilized, etc.

In order to enable this, this patch adds three new kfuncs:

struct task_struct *bpf_task_acquire(struct task_struct *p);
struct task_struct *bpf_task_kptr_get(struct task_struct **pp);
void bpf_task_release(struct task_struct *p);

A follow-on patch will add selftests validating these kfuncs.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 78 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 212e791d7452..89a95f3d854c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1824,6 +1824,63 @@ struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, true);
 }
 
+/**
+ * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
+ * kfunc which is not stored in a map as a kptr, must be released by calling
+ * bpf_task_release().
+ * @p: The task on which a reference is being acquired.
+ */
+struct task_struct *bpf_task_acquire(struct task_struct *p)
+{
+	refcount_inc(&p->rcu_users);
+	return p;
+}
+
+/**
+ * bpf_task_kptr_get - Acquire a reference on a struct task_struct kptr. A task
+ * kptr acquired by this kfunc which is not subsequently stored in a map, must
+ * be released by calling bpf_task_release().
+ * @pp: A pointer to a task kptr on which a reference is being acquired.
+ */
+struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
+{
+	struct task_struct *p;
+
+	rcu_read_lock();
+	p = READ_ONCE(*pp);
+
+	/* Another context could remove the task from the map and release it at
+	 * any time, including after we've done the lookup above. This is safe
+	 * because we're in an RCU read region, so the task is guaranteed to
+	 * remain valid until at least the rcu_read_unlock() below.
+	 */
+	if (p && !refcount_inc_not_zero(&p->rcu_users))
+		/* If the task had been removed from the map and freed as
+		 * described above, refcount_inc_not_zero() will return false.
+		 * The task will be freed at some point after the current RCU
+		 * gp has ended, so just return NULL to the user.
+		 */
+		p = NULL;
+	rcu_read_unlock();
+
+	return p;
+}
+
+/**
+ * bpf_task_release - Release the reference acquired on a struct task_struct *.
+ * If this kfunc is invoked in an RCU read region, the task_struct is
+ * guaranteed to not be freed until the current grace period has ended, even if
+ * its refcount drops to 0.
+ * @p: The task on which a reference is being released.
+ */
+void bpf_task_release(struct task_struct *p)
+{
+	if (!p)
+		return;
+
+	put_task_struct_rcu_user(p);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -1836,6 +1893,9 @@ BTF_ID_FLAGS(func, bpf_list_push_front)
 BTF_ID_FLAGS(func, bpf_list_push_back)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
@@ -1843,14 +1903,26 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };
 
+BTF_ID_LIST(generic_dtor_ids)
+BTF_ID(struct, task_struct)
+BTF_ID(func, bpf_task_release)
+
 static int __init kfunc_init(void)
 {
 	int ret;
+	const struct btf_id_dtor_kfunc generic_dtors[] = {
+		{
+			.btf_id       = generic_dtor_ids[0],
+			.kfunc_btf_id = generic_dtor_ids[1]
+		},
+	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
-	if (ret)
-		return ret;
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
+						  ARRAY_SIZE(generic_dtors),
+						  THIS_MODULE);
 }
 
 late_initcall(kfunc_init);
-- 
2.38.1

