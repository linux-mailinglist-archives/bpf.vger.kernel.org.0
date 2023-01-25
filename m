Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4267B4EE
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAYOkL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjAYOkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:40:09 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9014E89;
        Wed, 25 Jan 2023 06:39:38 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id k12so14211799qvj.5;
        Wed, 25 Jan 2023 06:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9V/N30yEutPTDBJE0EV1CzSj9vieGH2fZk1ThPLan28=;
        b=IU38gWK1nz3OK42svsvebf68Ij3Sl943AEGDj0omm4IZnnzJbYG2Q+TWuJTzphwjs8
         r3SXOuEQy8UfUKtz3oMhRpiS6liyNxjSnSFtaGUF3qyivCiB4FXy7vAuYmzsfVGxtMaL
         kqrc87v3WTRjY/jlfgFvbd1VaQj8qQimqVUGyRB7O/TA869jPWhsWDcJC/OTPPxMv7mK
         oSranPyvQM0lXlCtJda0Yhd9tIzEp4BDcLs3dm2HfUyii9bnQ/5Hp/C7ObIEUzMsGQ22
         Vv3Zhtx3mgsN+kW2jrm08tYNU3jCb6CO2HRlhkTj6wHdJRg9dbYhiM+604EYHn/utLtn
         0VpQ==
X-Gm-Message-State: AFqh2kp3aAOw3VpjyUI0h0q3wTW+GQwO2QX8bTMBwxffaE/9IUrzfXy4
        rA2vjgWYadoHwl5yKHBMROL6qA3c2tan/YL1
X-Google-Smtp-Source: AMrXdXtBU1RumqY5OgtHrnXwGx8PY0ST/fF2ErsBRPsavDfnyB3vquHeL8iOl/kw3rdF2+Mk2VkPrQ==
X-Received: by 2002:a05:6214:3291:b0:534:6aff:e5ca with SMTP id mu17-20020a056214329100b005346affe5camr45172327qvb.1.1674657500161;
        Wed, 25 Jan 2023 06:38:20 -0800 (PST)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b64-20020a378043000000b00704a9942708sm3579027qkd.73.2023.01.25.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:38:19 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v3 1/7] bpf: Disallow NULLable pointers for trusted kfuncs
Date:   Wed, 25 Jan 2023 08:38:10 -0600
Message-Id: <20230125143816.721952-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125143816.721952-1-void@manifault.com>
References: <20230125143816.721952-1-void@manifault.com>
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

KF_TRUSTED_ARGS kfuncs currently have a subtle and insidious bug in
validating pointers to scalars. Say that you have a kfunc like the
following, which takes an array as the first argument:

bool bpf_cpumask_empty(const struct cpumask *cpumask)
{
	return cpumask_empty(cpumask);
}

...
BTF_ID_FLAGS(func, bpf_cpumask_empty, KF_TRUSTED_ARGS)
...

If a BPF program were to invoke the kfunc with a NULL argument, it would
crash the kernel. The reason is that struct cpumask is defined as a
bitmap, which is itself defined as an array, and is accessed as a memory
address by bitmap operations. So when the verifier analyzes the
register, it interprets it as a pointer to a scalar struct, which is an
array of size 8. check_mem_reg() then sees that the register is NULL and
returns 0, and the kfunc crashes when it passes it down to the cpumask
wrappers.

To fix this, this patch adds a check for KF_ARG_PTR_TO_MEM which
verifies that the register doesn't contain a possibly-NULL pointer if
the kfunc is KF_TRUSTED_ARGS.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c                                  | 6 ++++++
 tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c    | 4 ++--
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66ec577fcb8b..bb38b01b738f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9194,6 +9194,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
+		if (is_kfunc_trusted_args(meta) &&
+		    (register_is_null(reg) || type_may_be_null(reg->type))) {
+			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
+			return -EACCES;
+		}
+
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
 				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index 973f0c5af965..f3bb0e16e088 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -93,11 +93,11 @@ static struct {
 	const char *prog_name;
 	const char *expected_err_msg;
 } failure_tests[] = {
-	{"cgrp_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
+	{"cgrp_kfunc_acquire_untrusted", "Possibly NULL pointer passed to trusted arg0"},
 	{"cgrp_kfunc_acquire_fp", "arg#0 pointer type STRUCT cgroup must point"},
 	{"cgrp_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
 	{"cgrp_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
-	{"cgrp_kfunc_acquire_null", "arg#0 pointer type STRUCT cgroup must point"},
+	{"cgrp_kfunc_acquire_null", "Possibly NULL pointer passed to trusted arg0"},
 	{"cgrp_kfunc_acquire_unreleased", "Unreleased reference"},
 	{"cgrp_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
 	{"cgrp_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index e6950d6a9cf0..f19d54eda4f1 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -28,7 +28,7 @@ static struct __tasks_kfunc_map_value *insert_lookup_task(struct task_struct *ta
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
@@ -86,7 +86,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 
 
 SEC("tp_btf/task_newtask")
-__failure __msg("arg#0 pointer type STRUCT task_struct must point")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
 int BPF_PROG(task_kfunc_acquire_null, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired;
-- 
2.39.0

