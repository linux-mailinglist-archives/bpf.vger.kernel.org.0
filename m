Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337865FF48E
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiJNU31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiJNU30 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:29:26 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7455D705;
        Fri, 14 Oct 2022 13:29:25 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id w3so4418009qtv.9;
        Fri, 14 Oct 2022 13:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTjXFsPHx8lMzd/jHgnZDnZpafMbI3eXMs2OxHMY/N4=;
        b=Cb5CWWIPN8+4ufPl/DpllomOr55cTtQrzW4hb/MpSgZTL/s4mFQkksmuj6CUWsDhQ2
         polFILliF6fNwLjG2u2kzaaTZTxpUehCaFC7xB4eU7pateYiY37zUVPCEU0pQ02IDgma
         XRwLpOMp0PKlzKYaA2I5hEL22sQYLGw5m5fe9knvAjFZHIWzk3XubPKEAtTCZ2QuklqJ
         pN9wi+Sya4oCptGppvbKFEVcJb6wZp9cqTkG1yFkq98vJrSGaHTbDfmLUOe77xE20bbO
         RydfwN/7tfWU/VvB1x60+L4f/XRgQZHhFojuW4i1wjaycjpDf02zSEzHSxdchhtUobZh
         vIwg==
X-Gm-Message-State: ACrzQf3cZFryxre64uw1pX3HvdQfrNG5L3lL4zvHg7QHjq2Uy4up+zYk
        hBWOpKOYoVNGgELNvbc7gFGR9psAYj59sA==
X-Google-Smtp-Source: AMsMyM7Et9aWyaGwsTnPIRXgW2/7R7hJHvhqWW9rLU/GePUfLQLoGUwAC/qRevSCvTf1joXsYuE28Q==
X-Received: by 2002:ac8:5889:0:b0:35c:cb1e:68cc with SMTP id t9-20020ac85889000000b0035ccb1e68ccmr5958072qta.406.1665779363989;
        Fri, 14 Oct 2022 13:29:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id fv18-20020a05622a4a1200b0039a55f78792sm2632548qtb.89.2022.10.14.13.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:29:23 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v4 2/3] Now that BPF supports adding new kernel functions with kfuncs, and storing kernel objects in maps with kptrs, we can add a set of kfuncs which allow struct task_struct objects to be stored in maps as referenced kptrs. The possible use cases for doing this are plentiful. During tracing, for example, it would be useful to be able to collect some tasks that performed a certain operation, and then periodically summarize who they are, which cgroup they're in, how much CPU time they've utilized, etc.
Date:   Fri, 14 Oct 2022 15:28:51 -0500
Message-Id: <20221014202852.2491657-3-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014202852.2491657-1-void@manifault.com>
References: <20221014202852.2491657-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
index a6b04faed282..9d0307969977 100644
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
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE | KF_TRUSTED_ARGS)
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

