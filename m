Return-Path: <bpf+bounces-11611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FA7BC7C7
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10F71C20A60
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 12:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B023749;
	Sat,  7 Oct 2023 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a9TFgEW8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA791F5F6
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 12:45:59 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8894119
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:45:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2774874c3daso2270329a91.1
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682752; x=1697287552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5nHGgcorL6nTo4Bd2JPYgDkdxlRNl3YeAVkUVjikAc=;
        b=a9TFgEW8qNv6lI4l2HKipMyNN+jMY78H2Xz5vYIDcPFj9Mktd0VGiOawfpepn+X6Te
         LXPiO+cbFgw1DVFPL4OL3EdXy/8roTZ+rQPlr5gw4W3GKaY03C2r+7M7tJTMDtooJ9Md
         rN5bPddpBL+y3P081RvP/+hRztmvbyQji7FzP8fagVMh0D7X1f/znLbWYr1VJtqylOe7
         MQ5/7pgiGf93cRhAj6AP1MvtHqFmFxdp+bpjFMvBfDYBapaiG+8tla4VYIPplDjFCXTa
         N+9kCf3jMZ4P8LwW2/UP1SJaZZNH23Qg3qrTSve0Hh2QMVSDSkNiHlXWVJsdtivyeej9
         hTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682752; x=1697287552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5nHGgcorL6nTo4Bd2JPYgDkdxlRNl3YeAVkUVjikAc=;
        b=nbK+B70TlrigDkhB94dCaziM56egZkUfNoqI+4P9N35hQEUu8PfNW7f8lKsEUHdDj+
         0+j9tsCO2UuUbr8UeBPJNhKqSlRQpgqZPik3WbHG2EwNfEq1n+WTcKfjdlbdFGCsmAPJ
         H7Jox/yD8pb+fWtrEZoi+ZgQZjbwuyE5Wx2o0/ixRFgeup/xr8by53xgePv4XbudY6jL
         EE11dcnx7zzER4jjPYw7oDVLb1SN7owDZy7D0Hu5mFqxQU3QPxDDBIEzc4J6aDkIymlW
         GkqHRIf/YB3qy8x9jCNt7vNlHj/dcxL0pXQiO0blXeOJAc7ngnmoUDzWi8YvKOvVMFWD
         2WBA==
X-Gm-Message-State: AOJu0YzyGMO4Lrf1sAr+bjSzogrkaTzIiRm8d2Jc8C8M0vJ35484poii
	3kf7Bl7+ERl3biUA3V0JLiXRpsJKUGUsSeKOQHI=
X-Google-Smtp-Source: AGHT+IGlVZ36ENR5ndQomm9+bSekaLzX2lrkJ5cYf8fwBGgagYuwuccybjivPO984y+m870S7FP9Qg==
X-Received: by 2002:a17:90b:374b:b0:26b:4a9e:3c7e with SMTP id ne11-20020a17090b374b00b0026b4a9e3c7emr10333461pjb.4.1696682752627;
        Sat, 07 Oct 2023 05:45:52 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:52 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 6/8] bpf: Let bpf_iter_task_new accept null task ptr
Date: Sat,  7 Oct 2023 20:45:20 +0800
Message-Id: <20231007124522.34834-7-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When using task_iter to iterate all threads of a specific task, we enforce
that the user must pass a valid task pointer to ensure safety. However,
when iterating all threads/process in the system, BPF verifier still
require a valid ptr instead of "nullable" pointer, even though it's
pointless, which is a kind of surprising from usability standpoint. It
would be nice if we could let that kfunc accept a explicit null pointer
when we are using BPF_TASK_ITER_ALL_{PROCS, THREADS} and a valid pointer
when using BPF_TASK_ITER_THREAD.

Given a trival kfunc:
	__bpf_kfunc void FN(struct TYPE_A *obj);

BPF Prog would reject a nullptr for obj. The error info is:
"arg#x pointer type xx xx must point to scalar, or struct with scalar"
reported by get_kfunc_ptr_arg_type(). The reg->type is SCALAR_VALUE and
the btf type of ref_t is not scalar or scalar_struct which leads to the
rejection of get_kfunc_ptr_arg_type.

This patch add "__nullable" annotation:
	__bpf_kfunc void FN(struct TYPE_A *obj__nullable);
Here __nullable indicates obj can be optional, user can pass a explicit
nullptr or a normal TYPE_A pointer. In get_kfunc_ptr_arg_type(), we will
detect whether the current arg is optional and register is null, If so,
return a new kfunc_ptr_arg_type KF_ARG_PTR_TO_NULL and skip to the next
arg in check_kfunc_args().

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/task_iter.c |  7 +++++--
 kernel/bpf/verifier.c  | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c2e1c3cbffea..773be9a221f5 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -873,7 +873,7 @@ enum {
 };
 
 __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
-		struct task_struct *task, unsigned int flags)
+		struct task_struct *task__nullable, unsigned int flags)
 {
 	struct bpf_iter_task_kern *kit = (void *)it;
 
@@ -885,14 +885,17 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
 	switch (flags) {
 	case BPF_TASK_ITER_ALL_THREADS:
 	case BPF_TASK_ITER_ALL_PROCS:
+		break;
 	case BPF_TASK_ITER_PROC_THREADS:
+		if (!task__nullable)
+			return -EINVAL;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	if (flags == BPF_TASK_ITER_PROC_THREADS)
-		kit->task = task;
+		kit->task = task__nullable;
 	else
 		kit->task = &init_task;
 	kit->pos = kit->task;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3a60cc87520e..d09697dbfd9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10310,6 +10310,11 @@ static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const struct btf
 	return __kfunc_param_match_suffix(btf, arg, "__refcounted_kptr");
 }
 
+static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__nullable");
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -10452,6 +10457,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
+	KF_ARG_PTR_TO_NULL,
 };
 
 enum special_kfunc_type {
@@ -10608,6 +10614,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
+		return KF_ARG_PTR_TO_NULL;
 
 	if (argno + 1 < nargs &&
 	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
@@ -11158,7 +11166,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type))) {
+		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
+			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -11183,6 +11192,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_NULL:
+			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-- 
2.20.1


