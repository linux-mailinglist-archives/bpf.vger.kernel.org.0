Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD25F140E
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 22:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiI3Urc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiI3Ur3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 16:47:29 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155641FCC80;
        Fri, 30 Sep 2022 13:47:27 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id d17so3543775qko.13;
        Fri, 30 Sep 2022 13:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jL03iSEn8nbqTPX0ryu/ndd+1KOISmUpaEAI2gzB6vU=;
        b=adQPFbaoXjaelzFPejChDjrB899ABNCdfrTIdQxdPZ9oa9p0lrM8/f843uWmgAgn0t
         pNWx8hes0lVi7Dv9YL9XJsV3cuT0f8wo+zwVVY9Am3oUE8/yD7AYYou9WPLbohnHAcgy
         EjXwtRLWiFqMcG+tmhNH3o370b0+O3gJ16+jl5W/s5QSnll9aWVuxclqNkzqAZwaYw8Z
         ciRxN0ZypBuCpSdwb+W9zMYw9H0zOtw8fbnmlna2vb3tNzm7mOYjZB83tGsrEzoEeCb3
         4odz3jAAqq4kRMc0cAeG6RZ/WZ3Nou7m1ycFDHDNEbydbpTnDG8AHEgpvAuQfQS/G61A
         LFBw==
X-Gm-Message-State: ACrzQf2xIR7m0L+BuBbiccrRlur1Uqvt+d0MObimakvnZDJ3HOZyaBdb
        Icl0iSmdAYyMIVkDhYUYLjk=
X-Google-Smtp-Source: AMsMyM4k985WTzrOA/j6Foc42MXzKn+w7OmMgITF1PH4NVmNHc4FWXtCmqWMRlqF6ctHu9V6O0kLKg==
X-Received: by 2002:a05:620a:462b:b0:6ce:7dce:82d6 with SMTP id br43-20020a05620a462b00b006ce7dce82d6mr7481060qkb.476.1664570846082;
        Fri, 30 Sep 2022 13:47:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::dcb2])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a248d00b006cbe3be300esm3555078qkn.12.2022.09.30.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:47:25 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev
Cc:     kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        memxor@gmail.com
Subject: [PATCH 1/2] bpf: Add kfuncs for storing struct task_struct * as a kptr
Date:   Fri, 30 Sep 2022 15:47:19 -0500
Message-Id: <20220930204720.3116493-2-void@manifault.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930204720.3116493-1-void@manifault.com>
References: <20220930204720.3116493-1-void@manifault.com>
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
 kernel/bpf/helpers.c | 75 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b069517a3da0..eb9950eaec35 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1711,9 +1711,82 @@ static const struct btf_kfunc_id_set tracing_kfunc_set = {
 	.set   = &tracing_btf_ids,
 };
 
+/**
+ * bpf_task_acquire - Acquire a reference to a task. A task acquired by this
+ * kfunc which is not stored in a map as a kptr, must be released by calling
+ * bpf_task_release().
+ */
+__used noinline
+struct task_struct *bpf_task_acquire(struct task_struct *p)
+{
+	refcount_inc(&p->rcu_users);
+	return p;
+}
+
+/**
+ * bpf_task_kptr_get - Acquire a reference on a struct task_struct * kptr. A
+ * task kptr acquired by this kfunc which is not stored in a map as a kptr,
+ * must be released by calling bpf_task_release().
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
+ */
+__used noinline void bpf_task_release(struct task_struct *p)
+{
+	if (!p)
+		return;
+
+	put_task_struct_rcu_user(p);
+}
+
+BTF_SET8_START(task_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_task_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE | KF_TRUSTED_ARGS)
+BTF_SET8_END(task_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set task_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &task_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(task_dtor_kfunc_ids)
+BTF_ID(struct, task_struct)
+BTF_ID(func, bpf_task_release)
+
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+	int ret;
+	const struct btf_id_dtor_kfunc helper_dtor_kfuncs[] = {
+		{
+			.btf_id       = task_dtor_kfunc_ids[0],
+			.kfunc_btf_id = task_dtor_kfunc_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &task_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &task_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(helper_dtor_kfuncs,
+						  ARRAY_SIZE(helper_dtor_kfuncs),
+						  THIS_MODULE);
 }
 
 late_initcall(kfunc_init);
-- 
2.37.3

