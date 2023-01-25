Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD567B4F5
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjAYOko (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjAYOkj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:40:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA84458A3;
        Wed, 25 Jan 2023 06:39:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d3so1359092qte.8;
        Wed, 25 Jan 2023 06:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mdogbjDDxOCdZ0alUAk6mQb+ogExzfvAf37Mew5zHM=;
        b=X5I2xARDPC/Un8IHmgJbTyfdG0hoi5SlFBxMdHO7qknhgHGkgUZ/IelujZb+3jrAkU
         SgemhCdKZSCcPvUB0s5yvjF+Np186N/hjK3HjKW8lzFGRZUhBWlmtk1XgittD4aVKeqy
         CmYzV+0JRFMZ4zym1uDyVECfZRl7aOX3DFkfdnYpUB88LyWAsnAUKwp7rRCX+242ra/c
         /GJRmkH+NBA/at6puLQLCjaQrVYevBhL+HzjRqsIMYkrEScYQ3Jq0MyhiUexeUozSqFD
         76c7ClzJFYUvmKMDFcACbx3VIlN430fwNBOhYpeqgBedACvsom7bbm4baC39PGRnMJTS
         T26g==
X-Gm-Message-State: AFqh2kqkGkpDgNq7U07SoDEGkaeBjYS148+LpQpodsiIo2KLLKWCY1wF
        t+xzSYmHg2/FzsRHiKOheKooBS7QkuPZRXdB
X-Google-Smtp-Source: AMrXdXt0wdENI6l5Zdd5KfgNMitCeMESQwIhAY2xuE5qmJb5ZnX5X4YABTouxoIO6a5FqSJMEye0FQ==
X-Received: by 2002:ac8:75da:0:b0:3a7:e805:a010 with SMTP id z26-20020ac875da000000b003a7e805a010mr48476930qtq.21.1674657501611;
        Wed, 25 Jan 2023 06:38:21 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id d83-20020a376856000000b00706b6ce386fsm3598246qkc.70.2023.01.25.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:38:21 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v3 2/7] bpf: Enable cpumasks to be queried and used as kptrs
Date:   Wed, 25 Jan 2023 08:38:11 -0600
Message-Id: <20230125143816.721952-3-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125143816.721952-1-void@manifault.com>
References: <20230125143816.721952-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Certain programs may wish to be able to query cpumasks. For example, if
a program that is tracing percpu operations wishes to track which tasks
end up running on which CPUs, it could be useful to associate that with
the tasks' cpumasks. Similarly, programs tracking NUMA allocations, CPU
scheduling domains, etc, could potentially benefit from being able to
see which CPUs a task could be migrated to.

This patch enables these types of use cases by introducing a series of
bpf_cpumask_* kfuncs. Amongst these kfuncs, there are two separate
"classes" of operations:

1. kfuncs which allow the caller to allocate and mutate their own
   cpumask kptrs in the form of a struct bpf_cpumask * object. Such
   kfuncs include e.g. bpf_cpumask_create() to allocate the cpumask, and
   bpf_cpumask_or() to mutate it. "Regular" cpumasks such as p->cpus_ptr
   may not be passed to these kfuncs, and the verifier will ensure this
   is the case by comparing BTF IDs.

2. Read-only operations which operate on const struct cpumask *
   arguments. For example, bpf_cpumask_test_cpu(), which tests whether a
   CPU is set in the cpumask. Any trusted struct cpumask * or struct
   bpf_cpumask * may be passed to these kfuncs. The verifier allows
   struct bpf_cpumask * even though the kfunc is defined with struct
   cpumask * because the first element of a struct bpf_cpumask is a
   cpumask_t, so it is safe to cast.

A follow-on patch will add selftests which validate these kfuncs, and
another will document them.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/Makefile  |   1 +
 kernel/bpf/cpumask.c | 268 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)
 create mode 100644 kernel/bpf/cpumask.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3a12e6b400a2..02242614dcc7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
+obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
 obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
new file mode 100644
index 000000000000..409ae2447a9b
--- /dev/null
+++ b/kernel/bpf/cpumask.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Meta, Inc */
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/cpumask.h>
+
+/**
+ * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
+ * @cpumask:	The actual cpumask embedded in the struct.
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released back to the BPF allocator, which provides
+ *		RCU safety.
+ *
+ * Note that we explicitly embed a cpumask_t rather than a cpumask_var_t.  This
+ * is done to avoid confusing the verifier due to the typedef of cpumask_var_t
+ * changing depending on whether CONFIG_CPUMASK_OFFSTACK is defined or not. See
+ * the details in <linux/cpumask.h>. The consequence is that this structure is
+ * likely a bit larger than it needs to be when CONFIG_CPUMASK_OFFSTACK is
+ * defined due to embedding the whole NR_CPUS-size bitmap, but the extra memory
+ * overhead is minimal. For the more typical case of CONFIG_CPUMASK_OFFSTACK
+ * not being defined, the structure is the same size regardless.
+ */
+struct bpf_cpumask {
+	cpumask_t cpumask;
+	refcount_t usage;
+};
+
+static struct bpf_mem_alloc bpf_cpumask_ma;
+
+static bool cpu_valid(u32 cpu)
+{
+	return cpu < nr_cpu_ids;
+}
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global kfuncs as their definitions will be in BTF");
+
+struct bpf_cpumask *bpf_cpumask_create(void)
+{
+	struct bpf_cpumask *cpumask;
+
+	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
+	if (!cpumask)
+		return NULL;
+
+	memset(cpumask, 0, sizeof(*cpumask));
+	refcount_set(&cpumask->usage, 1);
+
+	return cpumask;
+}
+
+struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
+{
+	refcount_inc(&cpumask->usage);
+	return cpumask;
+}
+
+struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
+{
+	struct bpf_cpumask *cpumask;
+
+	/* The BPF memory allocator frees memory backing its caches in an RCU
+	 * callback. Thus, we can safely use RCU to ensure that the cpumask is
+	 * safe to read.
+	 */
+	rcu_read_lock();
+
+	cpumask = READ_ONCE(*cpumaskp);
+	if (cpumask && !refcount_inc_not_zero(&cpumask->usage))
+		cpumask = NULL;
+
+	rcu_read_unlock();
+	return cpumask;
+}
+
+void bpf_cpumask_release(struct bpf_cpumask *cpumask)
+{
+	if (!cpumask)
+		return;
+
+	if (refcount_dec_and_test(&cpumask->usage)) {
+		migrate_disable();
+		bpf_mem_free(&bpf_cpumask_ma, cpumask);
+		migrate_enable();
+	}
+}
+
+u32 bpf_cpumask_first(const struct cpumask *cpumask)
+{
+	return cpumask_first(cpumask);
+}
+
+u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
+{
+	return cpumask_first_zero(cpumask);
+}
+
+void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+{
+	if (!cpu_valid(cpu))
+		return;
+
+	cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
+}
+
+void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+{
+	if (!cpu_valid(cpu))
+		return;
+
+	cpumask_clear_cpu(cpu, (struct cpumask *)cpumask);
+}
+
+bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
+{
+	if (!cpu_valid(cpu))
+		return false;
+
+	return cpumask_test_cpu(cpu, (struct cpumask *)cpumask);
+}
+
+bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+{
+	if (!cpu_valid(cpu))
+		return false;
+
+	return cpumask_test_and_set_cpu(cpu, (struct cpumask *)cpumask);
+}
+
+bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
+{
+	if (!cpu_valid(cpu))
+		return false;
+
+	return cpumask_test_and_clear_cpu(cpu, (struct cpumask *)cpumask);
+}
+
+void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
+{
+	cpumask_setall((struct cpumask *)cpumask);
+}
+
+void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
+{
+	cpumask_clear((struct cpumask *)cpumask);
+}
+
+bool bpf_cpumask_and(struct bpf_cpumask *dst,
+		     const struct cpumask *src1,
+		     const struct cpumask *src2)
+{
+	return cpumask_and((struct cpumask *)dst, src1, src2);
+}
+
+void bpf_cpumask_or(struct bpf_cpumask *dst,
+		    const struct cpumask *src1,
+		    const struct cpumask *src2)
+{
+	cpumask_or((struct cpumask *)dst, src1, src2);
+}
+
+void bpf_cpumask_xor(struct bpf_cpumask *dst,
+		     const struct cpumask *src1,
+		     const struct cpumask *src2)
+{
+	cpumask_xor((struct cpumask *)dst, src1, src2);
+}
+
+bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
+{
+	return cpumask_equal(src1, src2);
+}
+
+bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
+{
+	return cpumask_intersects(src1, src2);
+}
+
+bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
+{
+	return cpumask_subset(src1, src2);
+}
+
+bool bpf_cpumask_empty(const struct cpumask *cpumask)
+{
+	return cpumask_empty(cpumask);
+}
+
+bool bpf_cpumask_full(const struct cpumask *cpumask)
+{
+	return cpumask_full(cpumask);
+}
+
+void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
+{
+	cpumask_copy((struct cpumask *)dst, src);
+}
+
+u32 bpf_cpumask_any(const struct cpumask *cpumask)
+{
+	return cpumask_any(cpumask);
+}
+
+u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
+{
+	return cpumask_any_and(src1, src2);
+}
+
+__diag_pop();
+
+BTF_SET8_START(cpumask_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_cpumask_first, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_first_zero, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_set_cpu, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_clear_cpu, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_test_cpu, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_test_and_set_cpu, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_test_and_clear_cpu, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_setall, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_clear, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_and, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_or, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_xor, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_equal, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_intersects, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_subset, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_full, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_any, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_any_and, KF_TRUSTED_ARGS)
+BTF_SET8_END(cpumask_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set cpumask_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &cpumask_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(cpumask_dtor_ids)
+BTF_ID(struct, bpf_cpumask)
+BTF_ID(func, bpf_cpumask_release)
+
+static int __init cpumask_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc cpumask_dtors[] = {
+		{
+			.btf_id	      = cpumask_dtor_ids[0],
+			.kfunc_btf_id = cpumask_dtor_ids[1]
+		},
+	};
+
+	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, 0, false);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
+						   ARRAY_SIZE(cpumask_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(cpumask_kfunc_init);
-- 
2.39.0

