Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC560D3DA
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiJYSqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiJYSpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:52 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C65FDF8
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 11:45:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666723541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQO6PkBXdrMfi6P+tengfg05Bcu+OUV7uO90cGd3Wh4=;
        b=D8wNDSwte48SuRjPB4ztKH4IbTfGPKawXYdyBI/IfRm5ByeOWBNwTQeqBbtd2okq9IR3NE
        LJ62nnNB63ExhqwBIOVU6HMX8z1D8tfKH7wiSoGrZteZ5X5Mn4GXg5vSnGZ+CWYUclvtW2
        JpRBGkus3fpqFHkTATwsMH17d19bHbI=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        'Song Liu ' <songliubraving@meta.com>, kernel-team@meta.com
Subject: [PATCH bpf-next 2/9] bpf: Append _recur naming to the bpf_task_storage helper proto
Date:   Tue, 25 Oct 2022 11:45:17 -0700
Message-Id: <20221025184524.3526117-3-martin.lau@linux.dev>
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

This patch adds the "_recur" naming to the bpf_task_storage_{get,delete}
proto.  In a latter patch, they will only be used by the tracing
programs that requires a deadlock detection because a tracing
prog may use bpf_task_storage_{get,delete} recursively and cause a
deadlock.

Another following patch will add a different helper proto for the non
tracing programs because they do not need the deadlock prevention.
This patch does this rename to prepare for this future proto
additions.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h           |  4 ++--
 kernel/bpf/bpf_task_storage.c | 12 ++++++------
 kernel/trace/bpf_trace.c      |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1279e699dc98..b04fe3f4342e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2519,8 +2519,8 @@ extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 extern const struct bpf_func_proto bpf_ktime_get_coarse_ns_proto;
 extern const struct bpf_func_proto bpf_sock_from_file_proto;
 extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
-extern const struct bpf_func_proto bpf_task_storage_get_proto;
-extern const struct bpf_func_proto bpf_task_storage_delete_proto;
+extern const struct bpf_func_proto bpf_task_storage_get_recur_proto;
+extern const struct bpf_func_proto bpf_task_storage_delete_recur_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 6f290623347e..bce50ae03f42 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -228,7 +228,7 @@ static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct *,
 	   task, void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
@@ -260,7 +260,7 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 		(unsigned long)sdata->data;
 }
 
-BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
+BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_struct *,
 	   task)
 {
 	int ret;
@@ -322,8 +322,8 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_owner_storage_ptr = task_storage_ptr,
 };
 
-const struct bpf_func_proto bpf_task_storage_get_proto = {
-	.func = bpf_task_storage_get,
+const struct bpf_func_proto bpf_task_storage_get_recur_proto = {
+	.func = bpf_task_storage_get_recur,
 	.gpl_only = false,
 	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1_type = ARG_CONST_MAP_PTR,
@@ -333,8 +333,8 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg4_type = ARG_ANYTHING,
 };
 
-const struct bpf_func_proto bpf_task_storage_delete_proto = {
-	.func = bpf_task_storage_delete,
+const struct bpf_func_proto bpf_task_storage_delete_recur_proto = {
+	.func = bpf_task_storage_delete_recur,
 	.gpl_only = false,
 	.ret_type = RET_INTEGER,
 	.arg1_type = ARG_CONST_MAP_PTR,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 49fb9ec8366d..591caf0eb973 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1488,9 +1488,9 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
 	case BPF_FUNC_task_storage_get:
-		return &bpf_task_storage_get_proto;
+		return &bpf_task_storage_get_recur_proto;
 	case BPF_FUNC_task_storage_delete:
-		return &bpf_task_storage_delete_proto;
+		return &bpf_task_storage_delete_recur_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_snprintf:
-- 
2.30.2

