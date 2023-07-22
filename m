Return-Path: <bpf+bounces-5665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75F75DA33
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 07:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EABA28258B
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8ADDC8;
	Sat, 22 Jul 2023 05:22:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822A58F66
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 05:22:56 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515AE10E5
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:55 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-583ae4818c8so8043667b3.3
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 22:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690003374; x=1690608174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlxSHgJGlFykHH+k1FlZ53S+R2hnwxo5bwOcJk4LJ1s=;
        b=CDXlG3EEwAs8FWfuE4Z3e3vXBCulExNy/T8LwiAegOHr8oSuLV050GAhN82xUKP3W5
         G5ak/sNmUz8CBQ2CqAmX/FMt0h8tYsX7qxyefgEj+PTlwl//5Fxz/OrxRqdHnujd+qrj
         WJE8MmOO+m3MhAmTY1U8iSBCtCAHP+u61huYJDDpGvtfu1k8K5PYdaksCApiqpc/dsOH
         /Dw2m1MyiNH0O/AR6PSSA41UXxaXygmhC11SRX8TfMEK0CvGEvxdtIo9nyWH9ptzV/qi
         ZLmiLYpK3qtO8KovXz10qcmECqFwN7180xOt7/pr/lLbKQR2pSV3n/179pdjo+3hopFI
         XTng==
X-Gm-Message-State: ABy/qLYEO6tu/zXUo9wLt/orUTDbADvhp6PeH2Ys+jeEtN1zKtm4wtY8
	BXp2u07IBYCYc80A6aQFMK5Z8t01q4SFtg==
X-Google-Smtp-Source: APBJJlHVJPHjYldCrMX3s1rHo8Ssn3IzdmzfjDWV50KFK6/s3WN6DGg6h3E8BzvtOn6wEX/Wt+UyZg==
X-Received: by 2002:a0d:f282:0:b0:576:e4b7:35ed with SMTP id b124-20020a0df282000000b00576e4b735edmr1900921ywf.30.1690003374245;
        Fri, 21 Jul 2023 22:22:54 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c289:3eeb:eb78:fe3b])
        by smtp.gmail.com with ESMTPSA id y191-20020a0dd6c8000000b00577335ea38csm1397829ywd.121.2023.07.21.22.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 22:22:53 -0700 (PDT)
From: kuifeng@meta.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [RFC bpf-next 2/5] bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
Date: Fri, 21 Jul 2023 22:22:45 -0700
Message-Id: <20230722052248.1062582-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722052248.1062582-1-kuifeng@meta.com>
References: <20230722052248.1062582-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new kfunc to
copy data from an kernel space buffer to a user space buffer. They are only
available for sleepable BPF programs.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 kernel/bpf/cgroup.c  |  6 ++++++
 kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b268bbfa6c53..8e3a615f3fc8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2413,6 +2413,12 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
+
+	case BPF_FUNC_copy_from_user:
+		if (prog->aux->sleepable)
+			return &bpf_copy_from_user_proto;
+		return NULL;
+
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 56ce5008aedd..5b1a62c20bb8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -669,6 +669,26 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+/**
+ * long bpf_copy_to_user(void *dst, u32 size, const void *kern_ptr)
+ *     Description
+ *             Read *size* bytes from kernel space address *kern_ptr* and
+ *              store the data in user space address *dst*. This is a
+ *              wrapper of **copy_to_user**\ ().
+ *     Return
+ *             0 on success, or a negative error in case of failure.
+ */
+__bpf_kfunc int bpf_copy_to_user(void *dst__uninit, u32 dst__sz,
+				 const void *src__ign)
+{
+	int ret = copy_to_user(dst__uninit, src__ign, dst__sz);
+
+	if (unlikely(ret))
+		return -EFAULT;
+
+	return ret;
+}
+
 BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 	   const void __user *, user_ptr, struct task_struct *, tsk, u64, flags)
 {
@@ -2456,6 +2476,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_copy_to_user, KF_SLEEPABLE)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
@@ -2494,6 +2515,15 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 	.set   = &common_btf_ids,
 };
 
+BTF_SET8_START(cgroup_common_btf_ids)
+BTF_ID_FLAGS(func, bpf_copy_to_user, KF_SLEEPABLE)
+BTF_SET8_END(cgroup_common_btf_ids)
+
+static const struct btf_kfunc_id_set cgroup_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &cgroup_common_btf_ids,
+};
+
 static int __init kfunc_init(void)
 {
 	int ret;
@@ -2513,6 +2543,7 @@ static int __init kfunc_init(void)
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &cgroup_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.34.1


