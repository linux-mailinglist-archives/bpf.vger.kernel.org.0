Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8C6C90FF
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCYVci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCYVch (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 17:32:37 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED9CDC4;
        Sat, 25 Mar 2023 14:32:22 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id oe8so4357673qvb.6;
        Sat, 25 Mar 2023 14:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679779941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymXFAuFh5pPtwakSStE/sGoAQn9sSnVKHVs/cMSsm24=;
        b=urKKe0As+/i1yMuTglJxqBP1mOnE+zMUZrQaNSv1T82YKu0+KP950K+b85iNskooRl
         opdsBDY0g8nodhYggisrnzYhGuMvAQMDcn6/5AlzeMQMExR9nGiB3ggA/vGsS0E6nzw4
         nksmaDeIAYXnxCrpeulD58J0jw0Zqv4kbc1cROEsblSTOMA5W/VB6taTQXxKuiqdHUT/
         LWIKikhkAxZCQjMUHBGWZB/s1HSjZqV08LWUfgphyHlWjyx+vn3MkIH7l4c9QYUGg4gA
         0/gvH6JdtXnctcKRYkXBM5DSNSBJ39V7raRfC6B53WzWG7od6qL8BaF529pRAV0bs2xy
         4GNA==
X-Gm-Message-State: AAQBX9dPvpgVgc7p0Qp9Sxp50XWWwGrmOUuTN5cUro78bRwUr8/Nq9so
        FA9LpIF6bFLkdpGEG4qcdXe5bvK689H41ecvNjI=
X-Google-Smtp-Source: AKy350bR4z0vdfZ03fsSDuQu7iv08skG6woA2Ct9wpdoPpeKmFROO9T9d81Hg2u04jlM+z+Nd4hTWQ==
X-Received: by 2002:a05:6214:2588:b0:56e:a290:aa92 with SMTP id fq8-20020a056214258800b0056ea290aa92mr13749016qvb.9.1679779941048;
        Sat, 25 Mar 2023 14:32:21 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id mk16-20020a056214581000b005dd8b9345a9sm1698176qvb.65.2023.03.25.14.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 14:32:20 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 3/3] bpf: Treat KF_RELEASE kfuncs as KF_TRUSTED_ARGS
Date:   Sat, 25 Mar 2023 16:31:46 -0500
Message-Id: <20230325213144.486885-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230325213144.486885-1-void@manifault.com>
References: <20230325213144.486885-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

KF_RELEASE kfuncs are not currently treated as having KF_TRUSTED_ARGS,
even though they have a superset of the requirements of KF_TRUSTED_ARGS.
Like KF_TRUSTED_ARGS, KF_RELEASE kfuncs require a 0-offset argument, and
don't allow NULL-able arguments. Unlike KF_TRUSTED_ARGS which require
_either_ an argument with ref_obj_id > 0, _or_ (ref->type &
BPF_REG_TRUSTED_MODIFIERS) (and no unsafe modifiers allowed), KF_RELEASE
only allows for ref_obj_id > 0.  Because KF_RELEASE today doesn't
automatically imply KF_TRUSTED_ARGS, some of these requirements are
enforced in different ways that can make the behavior of the verifier
feel unpredictable. For example, a KF_RELEASE kfunc with a NULL-able
argument will currently fail in the verifier with a message like, "arg#0
is ptr_or_null_ expected ptr_ or socket" rather than "Possibly NULL
pointer passed to trusted arg0". Our intention is the same, but the
semantics are different due to implemenetation details that kfunc authors
and BPF program writers should not need to care about.

Let's make the behavior of the verifier more consistent and intuitive by
having KF_RELEASE kfuncs imply the presence of KF_TRUSTED_ARGS. Our
eventual goal is to have all kfuncs assume KF_TRUSTED_ARGS by default
anyways, so this takes us a step in that direction.

Note that it does not make sense to assume KF_TRUSTED_ARGS for all
KF_ACQUIRE kfuncs. KF_ACQUIRE kfuncs can have looser semantics than
KF_RELEASE, with e.g. KF_RCU | KF_RET_NULL. We may want to have
KF_ACQUIRE imply KF_TRUSTED_ARGS _unless_ KF_RCU is specified, but that
can be left to another patch set, and there are no such subtleties to
address for KF_RELEASE.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst                           |  7 ++++---
 kernel/bpf/cpumask.c                                   |  2 +-
 kernel/bpf/verifier.c                                  |  2 +-
 net/bpf/test_run.c                                     |  6 ++++++
 tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c |  4 ++--
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c |  6 +++---
 tools/testing/selftests/bpf/verifier/calls.c           | 10 +++++++---
 tools/testing/selftests/bpf/verifier/ref_tracking.c    |  6 +++---
 8 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 69eccf6f98ef..bf1b85941452 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -179,9 +179,10 @@ both are orthogonal to each other.
 ---------------------
 
 The KF_RELEASE flag is used to indicate that the kfunc releases the pointer
-passed in to it. There can be only one referenced pointer that can be passed in.
-All copies of the pointer being released are invalidated as a result of invoking
-kfunc with this flag.
+passed in to it. There can be only one referenced pointer that can be passed
+in. All copies of the pointer being released are invalidated as a result of
+invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive the
+protection afforded by the KF_TRUSTED_ARGS flag described below.
 
 2.4.4 KF_KPTR_GET flag
 ----------------------
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index e991af7dc13c..7efdf5d770ca 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -402,7 +402,7 @@ __diag_pop();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_cpumask_first, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_first_zero, KF_RCU)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64f06f6e16bf..20eb2015842f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9307,7 +9307,7 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 
 static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->kfunc_flags & KF_TRUSTED_ARGS;
+	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
 }
 
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 27587f1c5f36..f1652f5fbd2e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -606,6 +606,11 @@ bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
 	return &prog_test_struct;
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p)
+{
+	WARN_ON_ONCE(1);
+}
+
 __bpf_kfunc struct prog_test_member *
 bpf_kfunc_call_memb_acquire(void)
 {
@@ -800,6 +805,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 807fb0ac41e9..48b2034cadb3 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -206,7 +206,7 @@ int BPF_PROG(cgrp_kfunc_get_unreleased, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("expects refcounted")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path)
 {
 	struct __cgrps_kfunc_map_value *v;
@@ -234,7 +234,7 @@ int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
 {
 	struct __cgrps_kfunc_map_value local, *v;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 27994d6b2914..2c374a7ffece 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -206,7 +206,7 @@ int BPF_PROG(task_kfunc_get_unreleased, struct task_struct *task, u64 clone_flag
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 is untrusted_ptr_or_null_ expected ptr_ or socket")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_flags)
 {
 	struct __tasks_kfunc_map_value *v;
@@ -234,7 +234,7 @@ int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
 {
 	struct __tasks_kfunc_map_value local, *v;
@@ -277,7 +277,7 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 is ptr_or_null_ expected ptr_ or socket")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 5702fc9761ef..1bdf2b43e49e 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -109,7 +109,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "arg#0 is ptr_or_null_ expected ptr_ or socket",
+	.errstr = "Possibly NULL pointer passed to trusted arg0",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
 		{ "bpf_kfunc_call_test_release", 5 },
@@ -165,19 +165,23 @@
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
 	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 16),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -4),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
-		{ "bpf_kfunc_call_test_release", 9 },
+		{ "bpf_kfunc_call_test_offset", 9 },
+		{ "bpf_kfunc_call_test_release", 12 },
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 9540164712b7..5a2e154dd1e0 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -142,7 +142,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 is ptr_or_null_ expected ptr_ or socket",
+	.errstr = "Possibly NULL pointer passed to trusted arg0",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_lookup_user_key", 2 },
 		{ "bpf_key_put", 4 },
@@ -163,7 +163,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 is ptr_or_null_ expected ptr_ or socket",
+	.errstr = "Possibly NULL pointer passed to trusted arg0",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_lookup_system_key", 1 },
 		{ "bpf_key_put", 3 },
@@ -182,7 +182,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
+	.errstr = "Possibly NULL pointer passed to trusted arg0",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_key_put", 1 },
 	},
-- 
2.39.0

