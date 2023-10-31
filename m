Return-Path: <bpf+bounces-13669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3A7DC5A4
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC15C281594
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 05:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740FC8F5;
	Tue, 31 Oct 2023 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VX7M9y5J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB286FD8
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 05:04:51 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B85C9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b92b852390so4009831a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698728689; x=1699333489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7JCp9A8T8BQUKcY2EItpe9D/Y+wTEq+ZM8JBxOMT8M=;
        b=VX7M9y5JwXuenVkBuVuomVgyNoj07Bv0LgASVAKS5DNiN2MTSSlSIVkLP8e1bxMG5Q
         +LGON9mGdGO25BR+vbKJmZ+1F8Q9l/LspFrFlOrFsLpWe4Kc9k19lfMHs/y0N/djQdIc
         wQ+HWHg4L2ROz3EqLSxqplTELzNmhEwZj+9l7XzUZaMoRXdi/T3bNZdV3GTR7oYCBTEe
         EdLqy0bKlqNueyzneBu1+2b3Xl/pI3S/dZpE15loh/WX9Ds4lW7lVGwyVDB8h3WzN9Gw
         eQ8VtyxmzhjvElOa7rnqptHu5+9sw/H4QWE9DwjycrpDyrld8ZNvDt4s0EkDXh3YQgH1
         RLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728689; x=1699333489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7JCp9A8T8BQUKcY2EItpe9D/Y+wTEq+ZM8JBxOMT8M=;
        b=AD4CAFj9NXnLhOp+SA3X2B8LOuK2p1BnlOtr4Bn9otpA0QvMPf5Z9l0rCg3qoGB0Vj
         sd19mgOd2oQ8eu3a1OsdjVivmebfE3ZB/PInnxtplCr99E1AANO+4FEsAD0CPAhAuGFZ
         STZJ7CHRgqTyD4Im9M77LrUF+We05ZBlqIJ2h9ZT3+K295LSHl4y80Zf1trc2wovkB7g
         lFjk6ow6xwrsmV0APY58j78lZipqjA1kDNqrcd8i0npRNWj7YTCLKlLQHz5SJL/+B4jO
         RnlMJrtUpLD4nvP2ZgR4oOTi+d5IHLw245ObymPrqBet8CbZmC0Mhjgu5Fg/pLkIlbfk
         maqg==
X-Gm-Message-State: AOJu0YwnbCQO4MiUj4IXrIFIfXCI3wv+Jeu973jGSbvjCYnp799rR24X
	u5yxZoV3gXNFZKUFKDfwTsCdq5eFcTtGbVLtaXk=
X-Google-Smtp-Source: AGHT+IG12fyhSHeGL4lKMTptdYtuwjedHinO3nP7jAwjRtZzq3eDxHpf5XQqbyd+6TqmhlSA3whppA==
X-Received: by 2002:a05:6a21:6d9c:b0:162:4f45:b415 with SMTP id wl28-20020a056a216d9c00b001624f45b415mr15906260pzb.51.1698728689089;
        Mon, 30 Oct 2023 22:04:49 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a195500b0027ce34334f5sm350951pjh.37.2023.10.30.22.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:04:48 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 1/3] bpf: Relax allowlist for css_task iter
Date: Tue, 31 Oct 2023 13:04:36 +0800
Message-Id: <20231031050438.93297-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231031050438.93297-1-zhouchuyi@bytedance.com>
References: <20231031050438.93297-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newly added open-coded css_task iter would try to hold the global
css_set_lock in bpf_iter_css_task_new, so the bpf side has to be careful in
where it allows to use this iter. The mainly concern is dead locking on
css_set_lock. check_css_task_iter_allowlist() in verifier enforced css_task
can only be used in bpf_lsm hooks and sleepable bpf_iter.

This patch relax the allowlist for css_task iter. Any lsm and any iter
(even non-sleepable) and any sleepable are safe since they would not hold
the css_set_lock before entering BPF progs context.

This patch also fixes the misused BPF_TRACE_ITER in
check_css_task_iter_allowlist which compared bpf_prog_type with
bpf_attach_type.

Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs")
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                            | 16 ++++++++++++----
 .../selftests/bpf/progs/iters_task_failure.c     |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..b2ddecfdff9d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11394,6 +11394,12 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 						  &meta->arg_rbtree_root.field);
 }
 
+/*
+ * css_task iter allowlist is needed to avoid dead locking on css_set_lock.
+ * LSM hooks and iters (both sleepable and non-sleepable) are safe.
+ * Any sleepable progs are also safe since bpf_check_attach_target() enforce
+ * them can only be attached to some specific hook points.
+ */
 static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -11401,10 +11407,12 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	switch (prog_type) {
 	case BPF_PROG_TYPE_LSM:
 		return true;
-	case BPF_TRACE_ITER:
-		return env->prog->aux->sleepable;
+	case BPF_PROG_TYPE_TRACING:
+		if (env->prog->expected_attach_type == BPF_TRACE_ITER)
+			return true;
+		fallthrough;
 	default:
-		return false;
+		return env->prog->aux->sleepable;
 	}
 }
 
@@ -11663,7 +11671,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_ITER:
 			if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
 				if (!check_css_task_iter_allowlist(env)) {
-					verbose(env, "css_task_iter is only allowed in bpf_lsm and bpf iter-s\n");
+					verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
 					return -EINVAL;
 				}
 			}
diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index c3bf96a67dba..6b1588d70652 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -84,8 +84,8 @@ int BPF_PROG(iter_css_lock_and_unlock)
 	return 0;
 }
 
-SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
 int BPF_PROG(iter_css_task_for_each)
 {
 	u64 cg_id = bpf_get_current_cgroup_id();
-- 
2.20.1


