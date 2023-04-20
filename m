Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B936E8B6D
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjDTH2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjDTH2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 03:28:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E5D131
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:27:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52019617020so617058a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681975638; x=1684567638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AGDNBCroQ67ha7RBjKHaMJL6Jfwc8C2hS0pEsm+v2A=;
        b=OpSJ3fP8ohLBcF5v5MU5Rjik38xw5j2zLix4CDhL8qi3Fcc9Lp3haSVTs4u/Qi4Zsl
         hgjdGVRaLRxpOzn+r5mH/4godg3oJwPY6ozMKTjkZ41kbNqzaAfp1Zl+F+YhY8bPWjlg
         IhUf5LhT0ruVsyMuCH6Nvg8VIKPKH7wNGdopgQzjUUocPrFrUd74+kbaC/kobzz4T9OS
         b/CX5e0gDKgOrga5AFlkMu22zwDCComdkjGEGcDpdHYBGsP8QWNgqEFaDW9OelrTTpjN
         9VbL9NNmfrMEwf9PBx0G+xAqirzA6ynLKLX/zO7M/jbl/VshrsjaAX/qD10YYqLj33LA
         iHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681975638; x=1684567638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AGDNBCroQ67ha7RBjKHaMJL6Jfwc8C2hS0pEsm+v2A=;
        b=WSCZXhobyiN6AycFqEKi1Lzz3/f0T5XT7uwpqCLBbri6nolwLB81CGyXETcP7RINX/
         Fe7ewnGSLvdyu918BScQt3raMlQ22MpaHSrZzmaS7jSMGQAHTZqtGWBLubYCsrl8HqLw
         NtQkrfE+kVr+qwMrwBem48WVWRvo0zWgTLtxh52KuvwfYbBuW/CqyjW4QRyjvFxLVpeN
         FSNHIbHx1fQqTOs39z61SZRpnTQxdGsoqoZ0m06mX59Xr0UOqb4aF/QniALoJuqGx8DZ
         yMbpU310z4uuo+aBBg7FJSRDZnbXpsgS35bd1GJ16p89C7i+qXyTTByKLr1gQKRxAA9r
         htTg==
X-Gm-Message-State: AAQBX9fKsScOT6sTlSh5AH4Ir7Mo53yTaHDhafNAb6BU0UYzxCL1307/
        A/SChC+DFcms4TiBk/vnHiVlUQ==
X-Google-Smtp-Source: AKy350ZFPlMmLIgo3dxD8Pjx/iOi0QJD5dfUllNmEoK8su1FQZkDUKeJ8zu4ovXLU4A8WJNAFZUQsA==
X-Received: by 2002:a17:90a:2cc1:b0:247:48a1:3fb2 with SMTP id n59-20020a17090a2cc100b0024748a13fb2mr826552pjd.19.1681975638511;
        Thu, 20 Apr 2023 00:27:18 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090ad71200b0023440af7aafsm612160pju.9.2023.04.20.00.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:27:18 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_task_under_cgroup helper
Date:   Thu, 20 Apr 2023 15:26:56 +0800
Message-Id: <20230420072657.80324-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230420072657.80324-1-zhoufeng.zf@bytedance.com>
References: <20230420072657.80324-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

This adds a bpf helper that's similar to the
bpf_current_task_under_cgroup. The difference is that it is a
designated task.

When hook sched related functions, sometimes it is necessary to
specify a task instead of the current task.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 kernel/bpf/verifier.c          |  4 +++-
 kernel/trace/bpf_trace.c       | 31 +++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4b20a7269bee..3d31ddb39e10 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5550,6 +5550,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_task_under_cgroup(struct bpf_map *map, struct task_struct *task, u32 index)
+ *	Description
+ *		Check whether the probe is being run is the context of a given
+ *		subset of the cgroup2 hierarchy. The cgroup2 to test is held by
+ *		*map* of type **BPF_MAP_TYPE_CGROUP_ARRAY**, at *index*.
+ *	Return
+ *		The return value depends on the result of the test, and can be:
+ *
+ *		* 1, if assigned task belongs to the cgroup2.
+ *		* 0, if assigned task does not belong to the cgroup2.
+ *		* A negative error code, if an error occurred.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5764,6 +5776,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(task_under_cgroup, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e05355facdc..1e2c3c3e8d5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7771,7 +7771,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		break;
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 		if (func_id != BPF_FUNC_skb_under_cgroup &&
-		    func_id != BPF_FUNC_current_task_under_cgroup)
+		    func_id != BPF_FUNC_current_task_under_cgroup &&
+		    func_id != BPF_FUNC_task_under_cgroup)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
@@ -7902,6 +7903,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_current_task_under_cgroup:
+	case BPF_FUNC_task_under_cgroup:
 	case BPF_FUNC_skb_under_cgroup:
 		if (map->map_type != BPF_MAP_TYPE_CGROUP_ARRAY)
 			goto error;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcf91bc7bf71..b02a04768824 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -814,6 +814,35 @@ static const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
 	.arg2_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_3(bpf_task_under_cgroup, struct bpf_map *, map, struct task_struct *,
+	   task, u32, idx)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct cgroup *cgrp;
+
+	if (unlikely(!task))
+		return -ENOENT;
+
+	if (unlikely(idx >= array->map.max_entries))
+		return -E2BIG;
+
+	cgrp = READ_ONCE(array->ptrs[idx]);
+	if (unlikely(!cgrp))
+		return -EAGAIN;
+
+	return task_under_cgroup_hierarchy(task, cgrp);
+}
+
+static const struct bpf_func_proto bpf_task_under_cgroup_proto = {
+	.func           = bpf_task_under_cgroup,
+	.gpl_only       = false,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
+	.arg3_type      = ARG_ANYTHING,
+};
+
 struct send_signal_irq_work {
 	struct irq_work irq_work;
 	struct task_struct *task;
@@ -1510,6 +1539,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_task_under_cgroup:
+		return &bpf_task_under_cgroup_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4b20a7269bee..3d31ddb39e10 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5550,6 +5550,18 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_task_under_cgroup(struct bpf_map *map, struct task_struct *task, u32 index)
+ *	Description
+ *		Check whether the probe is being run is the context of a given
+ *		subset of the cgroup2 hierarchy. The cgroup2 to test is held by
+ *		*map* of type **BPF_MAP_TYPE_CGROUP_ARRAY**, at *index*.
+ *	Return
+ *		The return value depends on the result of the test, and can be:
+ *
+ *		* 1, if assigned task belongs to the cgroup2.
+ *		* 0, if assigned task does not belong to the cgroup2.
+ *		* A negative error code, if an error occurred.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5764,6 +5776,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(task_under_cgroup, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.20.1

