Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F72E5FF531
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJNVVn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJNVVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 17:21:41 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D377A1D1E00;
        Fri, 14 Oct 2022 14:21:40 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id z8so4511139qtv.5;
        Fri, 14 Oct 2022 14:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un9v/0s/QDKsNCY1plqqMOPWTqMpkXY8lPQPooSTmh0=;
        b=5wh2nrrJHlKWIe0cplPzD8I+mptExODoEj2p87il/CIazPwEDjBrxoV00C/wsNEH5m
         Ta40OvM0O2mVTnA7Sv1HWALcoaSOPHy4TP6/7LNKAGhia0Le98JhBoSNOM/lLg1SPVqq
         /TVLtQkM84MZRpVSjf3d0JysHas05aCk4FoTKFHPY5oAVN+pwjkHhswjLrt010kUfcLR
         Z/FtWETEMp/DT0QRnSqm2OrkfByonE0NQuRGkCXbNsSyEGBIOqIvV2RkzttIGEorOWrn
         KYqlG+jX0GoSE4nhQ3sUkpYET7q1CA1y7sNbvzoWOPwMSRnb8PgJgBYgbSb+enfs7167
         ZkUA==
X-Gm-Message-State: ACrzQf19GaCfBJIM0tvknFEuv4vxj457HIvx3JLxi7EEUmh/j+pM3Pek
        Tc+JD+ZErVjQhkGb8HUmT5kEFYNjquNx1w==
X-Google-Smtp-Source: AMsMyM7bB1twQ2/Aj0iY2Ma4xOuvqRFNs00cKBKuhk5rQ3APS64UsMFGGTItWm+w5eZ+UO+i3Rcakw==
X-Received: by 2002:a05:622a:94:b0:39c:db0e:ed3a with SMTP id o20-20020a05622a009400b0039cdb0eed3amr3291955qtw.655.1665782498927;
        Fri, 14 Oct 2022 14:21:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id p14-20020ac8740e000000b003992448029esm2748517qtq.19.2022.10.14.14.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:21:38 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v5 2/3] bpf: Add kfuncs for storing struct task_struct * as a kptr
Date:   Fri, 14 Oct 2022 16:21:32 -0500
Message-Id: <20221014212133.2520531-3-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014212133.2520531-1-void@manifault.com>
References: <20221014212133.2520531-1-void@manifault.com>
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

