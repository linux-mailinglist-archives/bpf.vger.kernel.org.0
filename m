Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8B66BC36A
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCPBll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPBlg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:41:36 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4207B7D89;
        Wed, 15 Mar 2023 18:41:31 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id c18so277329qte.5;
        Wed, 15 Mar 2023 18:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678930890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5WS6KKdTFofb6bEzbdOSRo28ZlNPT8Pg4JD2YjEh/o=;
        b=dxZM2Ru5wkdwrm70UKwkWC/QWBoKkFZk9jt0ESDRPwF9OrgK05bI7qcInPmSabuwMr
         msfT/qZbSIFEoewzJTF4pIeM/qCsUlO7+8PIPh2LKrexM9iEyyw5b6JMNINPFfB8r9cu
         KGT0SvQNQFEoZrRBBbBsVcIJyW2XTjy6pA1VaiMpFh+96eonDdIwcaFcsKCJlEZZkPk+
         ycfIpLojSN3599IMeIq0M/4FqNG1fhKJwk03TZTR976IXDwk6u04kydSSWJp1dXduOxI
         l9Hwch57+80rA4qqP/1+dfUqK/4I/AfCKu5OGeHWezFYDMsK1WCE3Cbr/qL1V0nxyOHJ
         R+Dw==
X-Gm-Message-State: AO0yUKUXvq7SprnoQQPFAazWJbCWtohdtFEHmgXHZ0AzpItwaXrLMUIb
        ZqX6+Nnp02YmhucKygc2jhtjKbwECToyWgWX
X-Google-Smtp-Source: AK7set+62/FUD1hxv9bzam/0biCdSALeg9Mog6Spcx9nOiVx9MjxbxPoD/vRyBsjvg7+Zy7w6dDspA==
X-Received: by 2002:ac8:7d02:0:b0:3bf:daae:7f2a with SMTP id g2-20020ac87d02000000b003bfdaae7f2amr3221891qtb.68.1678930889901;
        Wed, 15 Mar 2023 18:41:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:5c58])
        by smtp.gmail.com with ESMTPSA id c1-20020ac853c1000000b003bfc1f49ad1sm4938505qtq.87.2023.03.15.18.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 18:41:29 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 4/5] bpf: Remove bpf_cpumask_kptr_get() kfunc
Date:   Wed, 15 Mar 2023 20:41:21 -0500
Message-Id: <20230316014122.678082-5-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316014122.678082-1-void@manifault.com>
References: <20230316014122.678082-1-void@manifault.com>
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

Now that struct bpf_cpumask is RCU safe, there's no need for this kfunc.
Rather than doing the following:

private(MASK) static struct bpf_cpumask __kptr *global;

int BPF_PROG(prog, s32 cpu, ...)
{
	struct bpf_cpumask *cpumask;

	bpf_rcu_read_lock();
	cpumask = bpf_cpumask_kptr_get(&global);
	if (!cpumask) {
		bpf_rcu_read_unlock();
		return -1;
	}
	bpf_cpumask_setall(cpumask);
	...
	bpf_cpumask_release(cpumask);
	bpf_rcu_read_unlock();
}

Programs can instead simply do this (assume same global cpumask):

int BPF_PROG(prog, ...)
{
	struct bpf_cpumask *cpumask;

	bpf_rcu_read_lock();
	cpumask = global;
	if (!cpumask) {
		bpf_rcu_read_unlock();
		return -1;
	}
	bpf_cpumask_setall(cpumask);
	...
	bpf_rcu_read_unlock();
}

In other words, no extra atomic acquire / release, and less boilerplate
code.

This patch removes both the kfunc, and its selftests. A subsequent patch
will update the BPF documentation to use the new method for accessing
cpumasks with RCU protection.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/cpumask.c                          | 29 ------------------
 .../selftests/bpf/prog_tests/cpumask.c        |  1 -
 .../selftests/bpf/progs/cpumask_common.h      |  1 -
 .../selftests/bpf/progs/cpumask_failure.c     | 24 ---------------
 .../selftests/bpf/progs/cpumask_success.c     | 30 -------------------
 5 files changed, 85 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 9ab462c5848a..5329d07114e9 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -81,34 +81,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 	return cpumask;
 }
 
-/**
- * bpf_cpumask_kptr_get() - Attempt to acquire a reference to a BPF cpumask
- *			    stored in a map.
- * @cpumaskp: A pointer to a BPF cpumask map value.
- *
- * Attempts to acquire a reference to a BPF cpumask stored in a map value. The
- * cpumask returned by this function must either be embedded in a map as a
- * kptr, or freed with bpf_cpumask_release(). This function may return NULL if
- * no BPF cpumask was found in the specified map value.
- */
-__bpf_kfunc struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
-{
-	struct bpf_cpumask *cpumask;
-
-	/* The BPF memory allocator frees memory backing its caches in an RCU
-	 * callback. Thus, we can safely use RCU to ensure that the cpumask is
-	 * safe to read.
-	 */
-	rcu_read_lock();
-
-	cpumask = READ_ONCE(*cpumaskp);
-	if (cpumask && !refcount_inc_not_zero(&cpumask->usage))
-		cpumask = NULL;
-
-	rcu_read_unlock();
-	return cpumask;
-}
-
 static void cpumask_free_cb(struct rcu_head *head)
 {
 	struct bpf_cpumask *cpumask;
@@ -434,7 +406,6 @@ BTF_SET8_START(cpumask_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_cpumask_kptr_get, KF_ACQUIRE | KF_KPTR_GET | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cpumask_first, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_first_zero, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_set_cpu, KF_RCU)
diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 6c0fe23498c7..cdf4acc18e4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -16,7 +16,6 @@ static const char * const cpumask_success_testcases[] = {
 	"test_copy_any_anyand",
 	"test_insert_leave",
 	"test_insert_remove_release",
-	"test_insert_kptr_get_release",
 	"test_global_mask_rcu",
 };
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 7623782fbd62..0c5b785a93e4 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -26,7 +26,6 @@ struct array_map {
 struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
 void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
 struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask) __ksym;
-struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumask) __ksym;
 u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym;
 u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
 void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 9f726d55f747..db4f94e72b61 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -94,30 +94,6 @@ int BPF_PROG(test_insert_remove_no_release, struct task_struct *task, u64 clone_
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-__failure __msg("Unreleased reference")
-int BPF_PROG(test_kptr_get_no_release, struct task_struct *task, u64 clone_flags)
-{
-	struct bpf_cpumask *cpumask;
-	struct __cpumask_map_value *v;
-
-	cpumask = create_cpumask();
-	if (!cpumask)
-		return 0;
-
-	if (cpumask_map_insert(cpumask))
-		return 0;
-
-	v = cpumask_map_value_lookup();
-	if (!v)
-		return 0;
-
-	cpumask = bpf_cpumask_kptr_get(&v->cpumask);
-
-	/* cpumask is never released. */
-	return 0;
-}
-
 SEC("tp_btf/task_newtask")
 __failure __msg("NULL pointer passed to trusted arg0")
 int BPF_PROG(test_cpumask_null, struct task_struct *task, u64 clone_flags)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index fe928ff72a06..2fcdd7f68ac7 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -394,36 +394,6 @@ int BPF_PROG(test_insert_remove_release, struct task_struct *task, u64 clone_fla
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-int BPF_PROG(test_insert_kptr_get_release, struct task_struct *task, u64 clone_flags)
-{
-	struct bpf_cpumask *cpumask;
-	struct __cpumask_map_value *v;
-
-	cpumask = create_cpumask();
-	if (!cpumask)
-		return 0;
-
-	if (cpumask_map_insert(cpumask)) {
-		err = 3;
-		return 0;
-	}
-
-	v = cpumask_map_value_lookup();
-	if (!v) {
-		err = 4;
-		return 0;
-	}
-
-	cpumask = bpf_cpumask_kptr_get(&v->cpumask);
-	if (cpumask)
-		bpf_cpumask_release(cpumask);
-	else
-		err = 5;
-
-	return 0;
-}
-
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 {
-- 
2.39.0

