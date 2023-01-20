Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F7E675DEF
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjATTZj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjATTZf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:35 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F2CB50A;
        Fri, 20 Jan 2023 11:25:30 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id t7so4453571qvv.3;
        Fri, 20 Jan 2023 11:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJ/CIF8V3Oz85fXn1ATcxkeRERKTOn9zuVe6bz+JYpA=;
        b=wQT3eh4Mo7zXBcxmWSL6uJRsj/5QGoGRpazZxOn4PsDBd8csQGHW2EDOrB7keJapf+
         4pgw59WLie/iyuc8QZZtrXsn7pDgw/fthGNpmExKbZ9Ar1H69N6BC7xyP9KtvYKiyZYA
         IxfvvxtpSLrbnowCO7qzrkR3vN/Fr6IJg+tE/vIJAKOF3TemusbmPmnkZyS7c1Zoe5ua
         8jyse6PIVd9FGLKRSpJQuT4sbaS5tFErfV4hcW/KMFtfr/K3O5Brh8ZDD//orJCks2P+
         Ws13mjWLgWkEClJxwpVt53AVnRPdMsW+rC5os4e18/SCkXbfgDlM5oTVPKWME2zVSB4q
         P1Ig==
X-Gm-Message-State: AFqh2kqXpsGekQ4K8A660DqfpwL1cjy/esy/JAowIk+wyt0hOxtYS7TT
        buwkS+jbPjaCBaMtYa63TK+ME6APBTHACwbm
X-Google-Smtp-Source: AMrXdXs14Di1mE3nUh3fZe+Fynxkq/nd7+2wjQZJSVsF6Czh5ka4fvGce7GL/2nXK3TVWW7uqU9QeQ==
X-Received: by 2002:ad4:584b:0:b0:531:8b4b:b59d with SMTP id de11-20020ad4584b000000b005318b4bb59dmr51044840qvb.50.1674242728609;
        Fri, 20 Jan 2023 11:25:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id br38-20020a05620a462600b00706b09b16fasm6085348qkb.11.2023.01.20.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:28 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 3/9] bpf: Disallow NULLable pointers for trusted kfuncs
Date:   Fri, 20 Jan 2023 13:25:17 -0600
Message-Id: <20230120192523.3650503-4-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
References: <20230120192523.3650503-1-void@manifault.com>
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
address memory by bitmap operations. So when the verifier analyzes the
register, it interprets it as a pointer to a scalar struct, which is an
array of size 8. check_mem_reg() then sees that the register is NULL,
and returns 0, and the kfunc crashes when it passes it down to the
cpumask wrappers.

To fix this, this patch adds a check for KF_ARG_PTR_TO_MEM which
verifies that the register doesn't contain a possibly-NULL pointer if
the kfunc is KF_TRUSTED_ARGS.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/verifier.c                               | 6 ++++++
 tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/task_kfunc.c | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca5d601fb3cf..a466887f5334 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8937,6 +8937,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 18848c31e36f..a4f49e8dc7e8 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -87,11 +87,11 @@ static struct {
 	const char *prog_name;
 	const char *expected_err_msg;
 } failure_tests[] = {
-	{"task_kfunc_acquire_untrusted", "R1 must be referenced or trusted"},
+	{"task_kfunc_acquire_untrusted", "Possibly NULL pointer passed to trusted arg0"},
 	{"task_kfunc_acquire_fp", "arg#0 pointer type STRUCT task_struct must point"},
 	{"task_kfunc_acquire_unsafe_kretprobe", "reg type unsupported for arg#0 function"},
 	{"task_kfunc_acquire_trusted_walked", "R1 must be referenced or trusted"},
-	{"task_kfunc_acquire_null", "arg#0 pointer type STRUCT task_struct must point"},
+	{"task_kfunc_acquire_null", "Possibly NULL pointer passed to trusted arg0"},
 	{"task_kfunc_acquire_unreleased", "Unreleased reference"},
 	{"task_kfunc_get_non_kptr_param", "arg#0 expected pointer to map value"},
 	{"task_kfunc_get_non_kptr_acquired", "arg#0 expected pointer to map value"},
-- 
2.39.0

