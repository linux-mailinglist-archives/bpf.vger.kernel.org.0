Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9759660D3DD
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiJYSqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiJYSqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:11 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4373328
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6PZ4VUfWyonNk0AZVq2qxMIyaU3cM8VoD81Jl31FMQ=;
        b=kfYnpeAg3s6DsHX82swSxH1kKSxYrD7gK+f+eixB4ihOsLX6iCg7qe9kupKIcBbKeBSr+Y
        Du2TnM/8CwP1KLNV0zfET033nNvqaVXcMG5ynb+OFrveV2tFnNmJt/byInxIg1e87MI6Rn
        AJNiTEh0AYHywQVBWfFtw2DP5lO/29o=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 5/9] bpf: Add new bpf_task_storage_get proto with no deadlock detection
Date:   Tue, 25 Oct 2022 11:45:20 -0700
Message-Id: <20221025184524.3526117-6-martin.lau@linux.dev>
In-Reply-To: <20221025184524.3526117-1-martin.lau@linux.dev>
References: <20221025184524.3526117-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

The bpf_lsm and bpf_iter do not recur that will cause a deadlock.
The situation is similar to the bpf_pid_task_storage_lookup_elem()
which is called from the syscall map_lookup_elem.  It does not need
deadlock detection.  Otherwise, it will cause unnecessary failure
when calling the bpf_task_storage_get() helper.

This patch adds bpf_task_storage_get proto that does not do deadlock
detection.  It will be used by bpf_lsm and bpf_iter programs.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h           |  1 +
 kernel/bpf/bpf_task_storage.c | 28 ++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c      |  5 ++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b04fe3f4342e..ef3f98afa45d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2520,6 +2520,7 @@ extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
 extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_recur_proto;
+extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_recur_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index bc52bc8b59f7..c3a841be438f 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -269,6 +269,23 @@ BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct
 	return (unsigned long)data;
 }
 
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags, gfp_t, gfp_flags)
+{
+	void *data;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
+		return (unsigned long)NULL;
+
+	bpf_task_storage_lock();
+	data = __bpf_task_storage_get(map, task, value, flags,
+				      gfp_flags, true);
+	bpf_task_storage_unlock();
+	return (unsigned long)data;
+}
+
 BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_struct *,
 	   task)
 {
@@ -342,6 +359,17 @@ const struct bpf_func_proto bpf_task_storage_get_recur_proto = {
 	.arg4_type = ARG_ANYTHING,
 };
 
+const struct bpf_func_proto bpf_task_storage_get_proto = {
+	.func = bpf_task_storage_get,
+	.gpl_only = false,
+	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type = ARG_ANYTHING,
+};
+
 const struct bpf_func_proto bpf_task_storage_delete_recur_proto = {
 	.func = bpf_task_storage_delete_recur,
 	.gpl_only = false,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 591caf0eb973..0986c1f0b8fc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/bpf_perf_event.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
@@ -1488,7 +1489,9 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
 	case BPF_FUNC_task_storage_get:
-		return &bpf_task_storage_get_recur_proto;
+		if (bpf_prog_check_recur(prog))
+			return &bpf_task_storage_get_recur_proto;
+		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
 		return &bpf_task_storage_delete_recur_proto;
 	case BPF_FUNC_for_each_map_elem:
-- 
2.30.2

