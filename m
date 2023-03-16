Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B36BC5C5
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 06:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCPFkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 01:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCPFkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 01:40:42 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA75F21D;
        Wed, 15 Mar 2023 22:40:40 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id t9so630315qtx.8;
        Wed, 15 Mar 2023 22:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678945239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa2fhlw1TqFXS4nJVOwTl5oF6HLkgTrJ78c4jwZcDqU=;
        b=J1aGYm4XpzzJNzoci0JgQFAA5Yb5hgQwylVi/6HvBAnpI72YsuZj3CumC2gNQm7cwu
         qDlCeZi4h7DgNg9vNEY+5Fm9A3bxJGAK3WcKjeWOmwzCACg/Kmj5VWzuddxLwZDKf8zZ
         885sIOorIvcz8K1Bp7zoCtI+ziyP5C1zu0zrqQOJlML1mSDDXzhVbnAZrXf6WLNdinVa
         5Ubu7oWm1v5n44Y2SXIeDlsunluOFEzeFBtSpTVuwLawJoIz5kgBPjIzgqY4gGkg+MPC
         xkn9zJlYfWeXMyT2gH3kpp9NLApSuvJWPLAFpVQLDBHbRlnbo4EI+Fd0VS53rvAWTI/B
         Mgog==
X-Gm-Message-State: AO0yUKU1BwDviIYwGrE1RerHzSLnW24zIJl3Jk362HmGNNCGq9LitiG+
        D/AmzUMZ/Kppe0mLu9/c4ODDr66Ivzqi1JGD
X-Google-Smtp-Source: AK7set+rZ9Aply+gc6/6dEFQe9Yi92wuLTMOtrpEXExmliE4f0Rsh6NZRkibpaiPeVAVFtxP2d+kgw==
X-Received: by 2002:a05:622a:174c:b0:3bf:db29:b793 with SMTP id l12-20020a05622a174c00b003bfdb29b793mr4696811qtk.20.1678945239228;
        Wed, 15 Mar 2023 22:40:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7f57])
        by smtp.gmail.com with ESMTPSA id d192-20020ae9efc9000000b00745df1fac2bsm3876535qkg.76.2023.03.15.22.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:40:38 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/5] bpf/selftests: Test using global cpumask kptr with RCU
Date:   Thu, 16 Mar 2023 00:40:26 -0500
Message-Id: <20230316054028.88924-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316054028.88924-1-void@manifault.com>
References: <20230316054028.88924-1-void@manifault.com>
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

Now that struct bpf_cpumask * is considered an RCU-safe type according
to the verifier, we should add tests that validate its common usages.
This patch adds those tests to the cpumask test suite. A subsequent
changes will remove bpf_cpumask_kptr_get(), and will adjust the selftest
and BPF documentation accordingly.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_common.h      |  6 ++
 .../selftests/bpf/progs/cpumask_failure.c     | 62 +++++++++++++++++++
 .../selftests/bpf/progs/cpumask_success.c     | 33 ++++++++++
 4 files changed, 102 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 5fbe457c4ebe..6c0fe23498c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -17,6 +17,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_insert_leave",
 	"test_insert_remove_release",
 	"test_insert_kptr_get_release",
+	"test_global_mask_rcu",
 };
 
 static void verify_success(const char *prog_name)
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 65e5496ca1b2..7623782fbd62 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -9,6 +9,9 @@
 
 int err;
 
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+private(MASK) static struct bpf_cpumask __kptr * global_mask;
+
 struct __cpumask_map_value {
 	struct bpf_cpumask __kptr * cpumask;
 };
@@ -51,6 +54,9 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym
 u32 bpf_cpumask_any(const struct cpumask *src) __ksym;
 u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2) __ksym;
 
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
 static inline const struct cpumask *cast(struct bpf_cpumask *cpumask)
 {
 	return (const struct cpumask *)cpumask;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index cfe83f0ef9e2..9f726d55f747 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -127,3 +127,65 @@ int BPF_PROG(test_cpumask_null, struct task_struct *task, u64 clone_flags)
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("R2 must be a rcu pointer")
+int BPF_PROG(test_global_mask_out_of_rcu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local, *prev;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask, local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	local = global_mask;
+	if (!local) {
+		err = 4;
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	bpf_rcu_read_unlock();
+
+	/* RCU region is exited before calling KF_RCU kfunc. */
+
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)local);
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("NULL pointer passed to trusted arg1")
+int BPF_PROG(test_global_mask_no_null_check, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local, *prev;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask, local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	local = global_mask;
+
+	/* No NULL check is performed on global cpumask kptr. */
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)local);
+
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 97ed08c4ff03..fe928ff72a06 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -423,3 +423,36 @@ int BPF_PROG(test_insert_kptr_get_release, struct task_struct *task, u64 clone_f
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local, *prev;
+
+	if (!is_test_task())
+		return 0;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask, local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	bpf_rcu_read_lock();
+	local = global_mask;
+	if (!local) {
+		err = 4;
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)local);
+	bpf_rcu_read_unlock();
+
+	return 0;
+}
-- 
2.39.0

