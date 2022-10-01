Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734785F1CED
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAOrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Oct 2022 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJAOrY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Oct 2022 10:47:24 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1BE76743;
        Sat,  1 Oct 2022 07:47:23 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id b23so4235259qtr.13;
        Sat, 01 Oct 2022 07:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VidvE1xSF2fHCJOGZEjxFCLuqmC98hLIGCmdRztk3Qs=;
        b=zPV+UySQERIMhQT/qNCyvTA+MLyCrnTBpPTzKkfhaB2EYCZ/JnJJZ6ypDnbcP3TR1y
         gA6gVK/3c+S+z1VzCPXUBwiDSdGw8m55gKdTPbK2+moVCME4YELGsLoC99gTz1d2Ij52
         Kb/PaYm1zBv7suPVXeSi/ZKkdnFAr+aRB0HP/SqsIAqjzTCo4Hsn+ABcvJWMnyKMiSFd
         SV15IdTinMHCiFk8UlcwlR8lKyyOh2lGcovjkKdNtnpoyOJvkfEqmtqia4UrDUB2Mu07
         nmDUum4mTPVj/DegKvcjF9f1VDzvY9BUU26qJO6XFw7cKGLpgnJ/GiX27OjOsWiRfmRc
         IX9g==
X-Gm-Message-State: ACrzQf3NmrjxqtzIzEzFbRq3WMeqTV1QRfypGr11h3RS/pFMScSF0q+Z
        oyOnFWHt7Yooxv53umJBm4I=
X-Google-Smtp-Source: AMsMyM5iN1wyWopywKZiydPfLjG7EIZhNhRoSASuNHtD0wjaB7cylS1ChFrcQQF0gXAOlrW1I0UvQA==
X-Received: by 2002:a05:622a:64b:b0:35d:5860:ea86 with SMTP id a11-20020a05622a064b00b0035d5860ea86mr10838833qtb.277.1664635641985;
        Sat, 01 Oct 2022 07:47:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::dcb2])
        by smtp.gmail.com with ESMTPSA id v19-20020a05622a131300b0031e9ab4e4cesm5213096qtk.26.2022.10.01.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:47:21 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
Subject: [PATCH v2 1/2] bpf: Add kfuncs for storing struct task_struct * as a kptr
Date:   Sat,  1 Oct 2022 09:47:15 -0500
Message-Id: <20221001144716.3403120-2-void@manifault.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001144716.3403120-1-void@manifault.com>
References: <20221001144716.3403120-1-void@manifault.com>
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

Now that BPF supports adding new kernel functions with kfuncs, and
storing kernel objects in maps with kptrs, we can add a set of kfuncs
which allow struct task_struct objects to be stored in maps as
referenced kptrs. The possible use-cases for doing this are plentiful.
During tracing, for example, it would be useful to be able to collect
some tasks that performed a certain operation, and then periodically
summarize who they are, which cgroup they're in, how much CPU time
they've spent, etc.

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
index b069517a3da0..36cbe1b8f8b1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1700,20 +1700,93 @@ bpf_base_func_proto(enum bpf_func_id func_id)
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
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE)
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
2.37.3

