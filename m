Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71C9606B3D
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 00:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJTWYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 18:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJTWYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 18:24:36 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3331CFF5;
        Thu, 20 Oct 2022 15:24:32 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id a18so969048qko.0;
        Thu, 20 Oct 2022 15:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXY/7WwkgymSLRlAW+DunONjhNZ8QwLQppyVN0oPfPg=;
        b=MAiU3PgZ8dz0NtOQSsEhGfW3TMdoGbOEIOv4baNIyfCSzr5LiAV0bpIK0KR9IBfUti
         45+IfYit+EI/67uWEhyAbkh7qOtXQz76yU/DbjGmkt0kR+E9zIyY6LflkaDqW/sKCEZe
         wEkSTLpzh5WQBeJJ4QXBxXExZsYBSffCtYjPNhO1j7C/+GlvfcX/fvh+4sFlkoLPXpSb
         b8kXdwv/2ijYKmydoKzNvUqr1XLcVbcLvyaAMcYLVo0ZIYCD9yx0Zqg9WvVLMucWm56d
         eBa2qUoYq+EjPTN2cJ1yn19VoXzGasus4Z2AO/bUTL89bWuZnNPt5DsH7lLtyCjfJtHs
         kxIw==
X-Gm-Message-State: ACrzQf23Q7OaOHAtH1rR2lSiJBMG0rZH7XPYIsqHxV+7oVQVSfP/zFvl
        CVvA0hPimuwG+RZoxpntktmKDen/8sNjhA==
X-Google-Smtp-Source: AMsMyM54XnJPTH15cznmOBMXKlNl7r0FysqToqcHXL7IDBC9YtoYC+IctdQEMUsUIPPZFv98NnBfRg==
X-Received: by 2002:a05:620a:150b:b0:6ee:8d04:f70 with SMTP id i11-20020a05620a150b00b006ee8d040f70mr11522738qkk.101.1666304671096;
        Thu, 20 Oct 2022 15:24:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006cdd0939ffbsm7986045qkm.86.2022.10.20.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:24:30 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v6 2/3] bpf: Add kfuncs for storing struct task_struct * as a kptr
Date:   Thu, 20 Oct 2022 17:24:15 -0500
Message-Id: <20221020222416.3415511-3-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221020222416.3415511-1-void@manifault.com>
References: <20221020222416.3415511-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
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
 kernel/bpf/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a6b04faed282..bf2b1679aea8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1700,20 +1700,96 @@ bpf_base_func_proto(enum bpf_func_id func_id)
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
+	if (!p)
+		return NULL;
+
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
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
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
2.38.0

