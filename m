Return-Path: <bpf+bounces-12516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124007CD453
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 08:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437AC1C20D24
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C518F7D;
	Wed, 18 Oct 2023 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WW3aO8hM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EA8F77
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:20:34 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D68198C
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso3823228a91.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697609892; x=1698214692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBjREUfdYjysteuQq+CF2MBmAUs5yTb/YGRZ4Q4shvo=;
        b=WW3aO8hMPq9dtwDyVMW8bvYBqA9W5ayBgjr8EyMbwXlENVQYLcT/O7MnckTrEdGeAg
         t3Ij9IMel+5V/0syQekAwBDa5pGTXJN50vM4JM/Ert0UO3OjadDmHxPrbzYIjEpp05YR
         8fckf4LZZ3YcnWgZBC+D3ppUdF1DZUnLWGicx7U3Vl7O531PMA4dtGJfd3VHaivS4sCL
         p5ePlszhPZWiR4srszNmO/1Uyo7dfe9UCHwRp/6uIloSdMXEBFBCC/FprMW3sGKB6ZdI
         noD7+sMWbwoACGT/faOYyZyYCEjEPBME58+XZ6OBAoubQZav46qxr2N5exRNtKxLUJMh
         NScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609892; x=1698214692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBjREUfdYjysteuQq+CF2MBmAUs5yTb/YGRZ4Q4shvo=;
        b=HGa1KbtQ6ZasvFmBbKQXYiS2bfhxXt3ViH1YBvd2pw2ItbnBWgvGfFDXuENaS9f0J7
         dEcixsNeqlffzeZVyZjSRtVO5ZiIs92iuPM1gTDolhiGwke7jkX6JLpwt6OW3IQDBXju
         M938zBbaNzLReC/mUl5a9Md6EOdhjWr42WreoZuEzF4SNshgQakG/eS4VE0+nqbsWOTN
         n8L17+7+IHy8/xEKrJ9cRk6FLW+GutPOe0oUQoqcXCRJ743mZAyY24rUKRUPMmXYaODY
         +j2UNnLxWG9vRsJiuQFF8kICtIdEfA32CUclNZoRh+u22O46JehD2J9MMHCjX3ClBb4n
         zM7Q==
X-Gm-Message-State: AOJu0YyD0EzE9iVZfN+Y1UqIyLxkR70wnDHaVs7m58/7LjsRwj1qVyKm
	/hIruQQSpI7ha2cqmvC+DA9RvKn/8Bk3YJUG3ozdMA==
X-Google-Smtp-Source: AGHT+IEcjcprgVH3l41ELy8Zj6cbhO4neAlWBPjwjSIwdE6So6A363RYv4MEKCuHWdtRisbJbwo7oQ==
X-Received: by 2002:a17:90a:31c:b0:27d:1ce5:1eb6 with SMTP id 28-20020a17090a031c00b0027d1ce51eb6mr4382459pje.17.1697609891808;
        Tue, 17 Oct 2023 23:18:11 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001c61acd5bd2sm2659116plb.112.2023.10.17.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:18:11 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RESEND PATCH bpf-next v6 6/8] bpf: Let bpf_iter_task_new accept null task ptr
Date: Wed, 18 Oct 2023 14:17:44 +0800
Message-Id: <20231018061746.111364-7-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/task_iter.c |  7 +++++--
 kernel/bpf/verifier.c  | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index faa1712c1df5..59e747938bdb 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -976,7 +976,7 @@ __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
 __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
-		struct task_struct *task, unsigned int flags)
+		struct task_struct *task__nullable, unsigned int flags)
 {
 	struct bpf_iter_task_kern *kit = (void *)it;
 
@@ -988,14 +988,17 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
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
index fcdf2382153a..e9bc5d4a25a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10332,6 +10332,11 @@ static bool is_kfunc_arg_refcounted_kptr(const struct btf *btf, const struct btf
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
@@ -10474,6 +10479,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
+	KF_ARG_PTR_TO_NULL,
 };
 
 enum special_kfunc_type {
@@ -10630,6 +10636,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
+	if (is_kfunc_arg_nullable(meta->btf, &args[argno]) && register_is_null(reg))
+		return KF_ARG_PTR_TO_NULL;
 
 	if (argno + 1 < nargs &&
 	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
@@ -11180,7 +11188,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type))) {
+		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
+			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -11205,6 +11214,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return kf_arg_type;
 
 		switch (kf_arg_type) {
+		case KF_ARG_PTR_TO_NULL:
+			continue;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-- 
2.20.1


