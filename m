Return-Path: <bpf+bounces-44280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C295A9C0D49
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DA61F2349B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57245216E1B;
	Thu,  7 Nov 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAFrcXhO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63121731B
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001881; cv=none; b=gNkmepoRmsbbR3pYkIkrVUIkOhrbiKLOwYBSVzembxF8HLeL9MMRNLs11tB0Nd6SRWXNPACRM8WZgZ787/12dMM+rxHxrzErZuqzEaix+I/EiD3/xVHQ3qY2Kx3EwdL6p5h0UhduBKZ7/3tx0KTZXXxmv/JTI/Hz/TdwuxrWFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001881; c=relaxed/simple;
	bh=SssuDJHNUfb+B3XdG4yEPvui3wWfooWvFplr+wbwL88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlA5miRyGsbZzcghoVFkZKF51gXGeP7uGXse1AgDZr+NbTrSwdQtppaa6H7tHstPbnu9BW+rut9e+6XLx3O6I5Hm0WpM9uChdZxFCDgbbdtspbeaxIwaS8Gu35Yd8OFlauk719W8YW67oYYe3idRBlULQXJUmNM93dm0FI9euVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAFrcXhO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7eae96e6624so936963a12.2
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001878; x=1731606678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRSryOh8sM1UxX8jcyoKiLmRfECM9qX3iEZDBbW57Io=;
        b=cAFrcXhOQAAjsiQQSEEzNerMllRAho2CbbabCwCIMTy8ATxCTZm+DxPfUzYQ2yWEY/
         F+QDsW4OaqGlT2GkF3gKNtfXDmoJN9zAJUTg9lOibtYlQWDx9H7jBisPJqElkl6ZqkVi
         QRUk7EwOTIqgpYhBCD+NZr8NbrD+jnJnlFX5NshLXtdYasYLhn1RhdmuJ7Ik7pg8bTfQ
         JiFOMXLymnJub3iKymyMNQQOvGjozZv8vJcLwtlqNJCJaUG4TSo+1mbQy+mOCtTEd4ak
         anp7PZMf9YfBvoRz9GvpspBEuNTHYhjTjUtDVJJ4wdaiKsYGNfVPMXNOFBixNWMGuc3z
         l30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001878; x=1731606678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRSryOh8sM1UxX8jcyoKiLmRfECM9qX3iEZDBbW57Io=;
        b=RzXsxP4pBktVwQ5U8eE7h7puK+UHbVOuWCdvaYpRs9kzCGtXWOQAOJa6GRmxuQARaH
         hkIByY3g/2V+fmxc8maQ6t7tOpfH11fh+1AoCThRNdkCpQTHfMllgKxOb+tG68kytc0/
         kGITg0sP5vfmfAm8hwB2yTF/lXUQbctBzlhyKW9t00Xyo0F769Tcqj5itXYtNuLJVVwf
         js7msmR/IZ7g9ejDvoWsCoT/M8HHHkJPnnsOmWRurfRhor6FOKz2hlIWemQ2LFwxAhS4
         QsLbVhFfoSzlbrMuBP5Js5cO87q91DRc/hMjCo2nmoP+IYtJSr4hOttRrpgCzJvE+u5u
         lu8A==
X-Gm-Message-State: AOJu0Yy87hUwZVxlXxGQaNxWG+WG1OT+IQBceV65khy8AI1xjC+ivzS3
	M5tccmIsAg37nbxN6N1MTgdQUFupJ/p0pXPzF4mx1APkoGjhfCxllVsMekbm
X-Google-Smtp-Source: AGHT+IEUhBbUYTd9adISnubrg7fyuBqkY6jiXSx9pYwPxvoDK33iZxZc4KZ7YtK1WvbpDLMRpF8Uug==
X-Received: by 2002:a17:90b:1a92:b0:2d8:82a2:b093 with SMTP id 98e67ed59e1d1-2e9b1720e9dmr44195a91.13.1731001877914;
        Thu, 07 Nov 2024 09:51:17 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:17 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 05/11] bpf: dynamic allocation for bpf_verifier_env->subprog_info
Date: Thu,  7 Nov 2024 09:50:34 -0800
Message-ID: <20241107175040.1659341-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up patches use add_hidden_subprog() to inject inlinable kfunc
bodies into bpf program as subprograms. At the moment only one hidden
subprogram is allowed, as bpf_verifier_env->subprog_info is allocated
in advance as array of fixed size. This patch removes the limitation
by using dynamic memory allocation for this array.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ed4eacfd4db7..b683dc3ede4a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -738,7 +738,7 @@ struct bpf_verifier_env {
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
-	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
+	struct bpf_subprog_info *subprog_info;
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
@@ -751,6 +751,7 @@ struct bpf_verifier_env {
 	struct backtrack_state bt;
 	struct bpf_jmp_history_entry *cur_hist_ent;
 	u32 pass_cnt; /* number of times do_check() was called */
+	u32 subprog_cap;
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
 	u32 prev_insn_processed, insn_processed;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b86308896358..d4ea7fd8a967 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19419,7 +19419,7 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 					      u32 off, u32 cnt)
 {
-	int i, j;
+	int i, j, first_hidden = env->subprog_cnt - env->hidden_subprog_cnt;
 
 	/* find first prog starting at or after off (first to remove) */
 	for (i = 0; i < env->subprog_cnt; i++)
@@ -19446,6 +19446,8 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 			env->subprog_info + j,
 			sizeof(*env->subprog_info) * move);
 		env->subprog_cnt -= j - i;
+		if (first_hidden <= j - 1)
+			env->hidden_subprog_cnt -= j - first_hidden;
 
 		/* remove func_info */
 		if (aux->func_info) {
@@ -21215,15 +21217,20 @@ static int resolve_kfunc_calls(struct bpf_verifier_env *env)
 /* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
 static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
-	struct bpf_subprog_info *info = env->subprog_info;
+	struct bpf_subprog_info *info, *tmp;
 	int cnt = env->subprog_cnt;
 	struct bpf_prog *prog;
 
-	/* We only reserve one slot for hidden subprogs in subprog_info. */
-	if (env->hidden_subprog_cnt) {
-		verbose(env, "verifier internal error: only one hidden subprog supported\n");
-		return -EFAULT;
+	if (cnt == env->subprog_cap) {
+		env->subprog_cap *= 2;
+		tmp = vrealloc(env->subprog_info,
+			       array_size(sizeof(*env->subprog_info), env->subprog_cap + 1),
+			       GFP_KERNEL | __GFP_ZERO);
+		if (!tmp)
+			return -ENOMEM;
+		env->subprog_info = tmp;
 	}
+	info = env->subprog_info;
 	/* We're not patching any existing instruction, just appending the new
 	 * ones for the hidden subprog. Hence all of the adjustment operations
 	 * in bpf_patch_insn_data are no-ops.
@@ -23122,6 +23129,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto err_free_env;
+	env->subprog_cap = BPF_MAX_SUBPROGS;
+	env->subprog_info = vzalloc(array_size(sizeof(*env->subprog_info),
+					       env->subprog_cap + 1 /* max + 1 for the fake subprog */));
+	if (!env->subprog_info) {
+		ret = -ENOMEM;
+		goto err_free_env;
+	}
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
@@ -23353,8 +23367,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-	vfree(env->insn_aux_data);
 err_free_env:
+	vfree(env->subprog_info);
+	vfree(env->insn_aux_data);
 	kvfree(env);
 	return ret;
 }
-- 
2.47.0


