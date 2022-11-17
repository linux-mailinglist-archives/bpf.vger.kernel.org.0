Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1162D195
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 04:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiKQDYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 22:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiKQDYJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 22:24:09 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6AC770;
        Wed, 16 Nov 2022 19:24:06 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id w9so366000qtv.13;
        Wed, 16 Nov 2022 19:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SealKgl69ME79mh49mRQon+sANiNWJ4d1I734p+o5U0=;
        b=JtGHETrjrt7HpAx7Qy3ILMGrDagE9BKzUGXhYyd2yYiBj7Ozg7jsQMNokHyRe0m7qS
         t8to8Gl25cgLjj8HwY4NwqApLxUyvZZ4ckEjUoN+bYEwhz46IQRFmzPudNgsdCbskZys
         Wr8ZqykCQeVO458ust+M0kei5fzNVmXVFqSgjC925UOdLsNzcGXzsEnWT+Pjadcd+qt/
         0iA6+wPVcIcWcSI7ok/EvX34Abc4iUw8rwKKnvwtOQdSrPQTaHCS6udaE8dEX2b1y+FT
         tx76uC1wgsqt9VtMRCuKc6Fumd6C/0A8ROqMirLXkzIHg+kbwG4kT2SfEvoNdPb+IuvJ
         0ePQ==
X-Gm-Message-State: ANoB5pnVMQGtoxTTEAm83Og91CXqQvVeIaUvemeMAbSOZBFr+VXIckHN
        L2Wpsnk0mAz2PeqC5+MohAoN9iwzoFl6g6zC
X-Google-Smtp-Source: AA0mqf5evf4I2Hrf0D4b12ji9c25cpZYIpu1UYWy2RrdVuEPPNfFM+P5jJ1+4Fbm3MSzRXBdHMzjbw==
X-Received: by 2002:ac8:5204:0:b0:3a5:6a35:bac8 with SMTP id r4-20020ac85204000000b003a56a35bac8mr701755qtn.615.1668655445554;
        Wed, 16 Nov 2022 19:24:05 -0800 (PST)
Received: from localhost (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id g10-20020ae9e10a000000b006fa4cac54a5sm10877757qkm.72.2022.11.16.19.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 19:24:05 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, memxor@gmail.com, yhs@fb.com,
        song@kernel.org, sdf@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, haoluo@google.com,
        tj@kernel.org, kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 2/3] bpf: Add kfuncs for storing struct task_struct * as a kptr
Date:   Wed, 16 Nov 2022 21:24:01 -0600
Message-Id: <20221117032402.2356776-3-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117032402.2356776-1-void@manifault.com>
References: <20221117032402.2356776-1-void@manifault.com>
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
 kernel/bpf/helpers.c | 83 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7bc71995f17c..532063c9a3a2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1738,20 +1738,93 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	}
 }
 
-BTF_SET8_START(tracing_btf_ids)
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+/**
+ * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
+ * kfunc which is not stored in a map as a kptr, must be released by calling
+ * bpf_task_release().
+ * @p: The task on which a reference is being acquired.
+ */
+__used noinline
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
+__used noinline
+struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
+{
+	struct task_struct *p;
+
+	rcu_read_lock();
+	p = READ_ONCE(*pp);
+	if (p && !refcount_inc_not_zero(&p->rcu_users))
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
+__used noinline void bpf_task_release(struct task_struct *p)
+{
+	if (!p)
+		return;
+
+	put_task_struct_rcu_user(p);
+}
+
+__diag_pop();
+
+BTF_SET8_START(generic_kfunc_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
-BTF_SET8_END(tracing_btf_ids)
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
+BTF_SET8_END(generic_kfunc_btf_ids)
 
-static const struct btf_kfunc_id_set tracing_kfunc_set = {
+static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set   = &tracing_btf_ids,
+	.set   = &generic_kfunc_btf_ids,
 };
 
+BTF_ID_LIST(generic_kfunc_dtor_ids)
+BTF_ID(struct, task_struct)
+BTF_ID(func, bpf_task_release)
+
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+	int ret;
+	const struct btf_id_dtor_kfunc generic_kfunc_dtors[] = {
+		{
+			.btf_id       = generic_kfunc_dtor_ids[0],
+			.kfunc_btf_id = generic_kfunc_dtor_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(generic_kfunc_dtors,
+						  ARRAY_SIZE(generic_kfunc_dtors),
+						  THIS_MODULE);
 }
 
 late_initcall(kfunc_init);
-- 
2.38.1

