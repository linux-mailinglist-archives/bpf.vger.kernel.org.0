Return-Path: <bpf+bounces-7518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E548778686
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AAA281FB1
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF901863;
	Fri, 11 Aug 2023 04:31:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56C1848
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:39 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D512696
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso1265899276.0
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728297; x=1692333097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpGHHkDwFcMkpaRoNhESkySt4m0eL6u0f0BnGicWv54=;
        b=OZK9IXBiBJHGGRC52II9Yrkfa52haWlv15dBiWY9NY0WMH08O3TBvJGuv/+gRDrFHk
         vU7UxwQS9UNOAGN66M4MbfRusfH2gtoiUNPZ25CWlmvTaQYJGq3zthyCPHtXme2vhOgy
         7C84om0vgEpS1rvHhqBgO50FWWRXF80/FShULvqzW+7Z4vKxjGCoZ7oO2QvNLqQ0i0GP
         cagqpbtGkP/zjtIHH/wwYJ7GgScbEtm4ID8hJzxmvU4iKH4aVKipwkvnGyB27egGrJ4/
         GUyU7nLR0cOpTIemk5TDuuiApegIibiaXtFoveDxDuxVK1zzHxzYazwiloywhy0cBDmP
         QrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728297; x=1692333097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpGHHkDwFcMkpaRoNhESkySt4m0eL6u0f0BnGicWv54=;
        b=klsz2kMHW1ceyWKRDlpREhAu5u8QL5OXFeiCR5Qx35uOvmwWoVGtyXWaykZWTcYctk
         hGbBRinan0NcvPU09ET+uh1/FCXmm9pqlcVQyOOWVpU3nFpJxVA4Saazm7jJt8xVWWA+
         Vb7CUQqkWYmoEnFOjHUyGSX+z8WrqSgo00k1bUuln9rbbibM2ihmo2E8no4tO6GjGVN9
         E0kLFbN5nssOWX/vpBD0KhMXFvLNEs4SXOf8x39AUFxncXf1QRw/CFtrpUlpDEhueycS
         cVvx7F3PnNrCxusjO+HfuT3Z6qWvPX7gRYASR7udMjKmeFfrYZ07GHZ1xPCEW5AoWenE
         O+pw==
X-Gm-Message-State: AOJu0Yziv4i3bHBIoBdqG4DTmOGuc4w/IiKHWWuM9rKXbtybP9n+jnXW
	xfXqJPMHxg7e86cTHKNChJmxw1AuF8YLOg==
X-Google-Smtp-Source: AGHT+IEQ9mdJSORbl3UMaxKh56WJNASdbnjSo5u5IZBSBeoNUdG1MlPBbnHjZauh9xZwv46MuZ7oWA==
X-Received: by 2002:a81:6d43:0:b0:586:a14f:ecc6 with SMTP id i64-20020a816d43000000b00586a14fecc6mr764105ywc.47.1691728297034;
        Thu, 10 Aug 2023 21:31:37 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:36 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 4/6] bpf: Provide bpf_copy_from_user() and bpf_copy_to_user().
Date: Thu, 10 Aug 2023 21:31:25 -0700
Message-Id: <20230811043127.1318152-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811043127.1318152-1-thinker.li@gmail.com>
References: <20230811043127.1318152-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new kfunc to
copy data from an kernel space buffer to a user space buffer. They are only
available for sleepable BPF programs. bpf_copy_to_user() is only available
to the BPF programs attached to cgroup/getsockopt.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/cgroup.c  |  6 ++++++
 kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5bf3115b265c..c15a72860d2a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index eb91cae0612a..ff240db1512c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -669,6 +669,26 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+/**
+ * int bpf_copy_to_user(void *dst, u32 size, const void *kern_ptr)
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


