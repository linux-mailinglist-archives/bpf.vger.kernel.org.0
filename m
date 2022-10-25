Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A960D3DF
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiJYSqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiJYSqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:46:13 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2111180E86
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXq73w+LtHF+WdGDeIELxMLg1o/6f66BcLKsE7yjHtk=;
        b=ptDqyJ5Rb1dVSCYExQylZ8SHMYjUKr30CxyKnguu1rd7qmsGIB5oV0BOBoojq1464XeqQ2
        3H8XZy6DNOOg/YSf7xO6REvW1CAMJEN8VyTsVjUnxgRXHH1qmnkpqF/xkd/dNB8lxH2ch/
        Ph49bBi6kl60VoMzOmwhXYm1VUjsq0c=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 7/9] bpf: Add new bpf_task_storage_delete proto with no deadlock detection
Date:   Tue, 25 Oct 2022 11:45:22 -0700
Message-Id: <20221025184524.3526117-8-martin.lau@linux.dev>
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
The situation is similar to the bpf_pid_task_storage_delete_elem()
which is called from the syscall map_delete_elem.  It does not need
deadlock detection.  Otherwise, it will cause unnecessary failure
when calling the bpf_task_storage_delete() helper.

This patch adds bpf_task_storage_delete proto that does not do deadlock
detection.  It will be used by bpf_lsm and bpf_iter program.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h           |  1 +
 kernel/bpf/bpf_task_storage.c | 28 ++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c      |  4 +++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ef3f98afa45d..a5dbac8f5aba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2522,6 +2522,7 @@ extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_recur_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_recur_proto;
+extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index f3f79b618a68..ba3fe72d1fa5 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -311,6 +311,25 @@ BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_str
 	return ret;
 }
 
+BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
+	   task)
+{
+	int ret;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!task)
+		return -EINVAL;
+
+	bpf_task_storage_lock();
+	/* This helper must only be called from places where the lifetime of the task
+	 * is guaranteed. Either by being refcounted or by being protected
+	 * by an RCU read-side critical section.
+	 */
+	ret = task_storage_delete(task, map, true);
+	bpf_task_storage_unlock();
+	return ret;
+}
+
 static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	return -ENOTSUPP;
@@ -382,3 +401,12 @@ const struct bpf_func_proto bpf_task_storage_delete_recur_proto = {
 	.arg2_type = ARG_PTR_TO_BTF_ID,
 	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 };
+
+const struct bpf_func_proto bpf_task_storage_delete_proto = {
+	.func = bpf_task_storage_delete,
+	.gpl_only = false,
+	.ret_type = RET_INTEGER,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+};
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0986c1f0b8fc..139966c74a5a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1493,7 +1493,9 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 			return &bpf_task_storage_get_recur_proto;
 		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
-		return &bpf_task_storage_delete_recur_proto;
+		if (bpf_prog_check_recur(prog))
+			return &bpf_task_storage_delete_recur_proto;
+		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_snprintf:
-- 
2.30.2

