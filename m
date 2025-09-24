Return-Path: <bpf+bounces-69621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D627DB9C411
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9928D3B7BCA
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B3E2868A2;
	Wed, 24 Sep 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k3yI59kO"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCB92417E6
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748662; cv=none; b=AVRlYqShS7hiaSITSJf66cw3ndH0By5SML07lfd8SeHIeDRemgXhyMAb6NF4EPCA16Y0ccDmyM8TDHMWoKSq4HK8/AiVh4lmV/6stvpLnHs0hcOFp1j7SLtkQtxxdUB/8vb3V9TTX5dFdV2hDBNWvBWBPThm8S44AthurXzbcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748662; c=relaxed/simple;
	bh=o/mHM4VHAPIZfWDdvS5Q3T7Zy1mbB75C13GQ8DLPdEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNdhRSZpYt/9cjNySuHMMHevvdwKZArJfAvr7l6nBh1oO48fXjLxOX5nJojTQM5zqeWnfrm5glIPc3MUjmmWFUkfLOP32tz/kQk5iaKB8kUREMxJDCv58OQcVYGE4RW6dPH+tvJ3ClLcMqvTZd0MSmqYnSgTWsGbP2v+jRGcihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k3yI59kO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSbSusNuKu+jc1W3pic04AkzE9iuCHfGjcDrmSnTttI=;
	b=k3yI59kO0rmkAHww8iPwEIYj2Y2YMPvSG2Wy6d17FvlAR5k7hVTuFRgW5HJ/nk8ajVPyZp
	uzpaUZoJWhd1zRfmtXq8Ypl7HHJ5YjKvTO6mpdzGQYVkADzaw2eGvlPewOTj7PegN1f2Mh
	7U+rRaqghVRB4IofwSA1iAvB+zHK7qo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
Date: Wed, 24 Sep 2025 14:17:11 -0700
Message-ID: <20250924211716.1287715-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Define KF_IMPLICIT_PROG_AUX_ARG and handle it in the BPF verifier.

The mechanism of patching is exactly the same as for __prog parameter
annotation: in check_kfunc_args() detect the relevant parameter and
remember regno in cur_aux(env)->arg_prog.

Then the (unchanged in this patch) fixup_kfunc_call() adds a mov
instruction to set the actual pointer to prog_aux.

The caveat for KF_IMPLICIT_PROG_AUX_ARG is in implicitness. We have to
separately check that the number of arguments is under
MAX_BPF_FUNC_REG_ARGS.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |  3 +++
 kernel/bpf/verifier.c | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..479ee96c2c97 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,9 @@
 #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
+/* kfunc takes a pointer to struct bpf_prog_aux as the last argument,
+ * passed implicitly in BPF */
+#define KF_IMPLICIT_PROG_AUX_ARG (1 << 16)
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..f1f9ea21f99b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11948,6 +11948,11 @@ static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RCU_PROTECTED;
 }
 
+static bool is_kfunc_with_implicit_prog_aux_arg(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->kfunc_flags & KF_IMPLICIT_PROG_AUX_ARG;
+}
+
 static bool is_kfunc_arg_mem_size(const struct btf *btf,
 				  const struct btf_param *arg,
 				  const struct bpf_reg_state *reg)
@@ -12029,6 +12034,18 @@ static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg
 	return btf_param_match_suffix(btf, arg, "__prog");
 }
 
+static int set_kfunc_arg_prog_regno(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta, u32 regno)
+{
+	if (meta->arg_prog) {
+		verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
+		return -EFAULT;
+	}
+	meta->arg_prog = true;
+	cur_aux(env)->arg_prog = regno;
+
+	return 0;
+}
+
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const struct btf_param *arg,
 					  const char *name)
@@ -13050,6 +13067,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		return -EINVAL;
 	}
 
+	/* KF_IMPLICIT_PROG_AUX_ARG means that the kfunc has one less argument in BTF,
+	 * so we have to set_kfunc_arg_prog_regno() outside the arg check loop.
+	 */
+	if (is_kfunc_with_implicit_prog_aux_arg(meta)) {
+		if (nargs + 1 > MAX_BPF_FUNC_REG_ARGS) {
+			verifier_bug(env, "A kfunc with KF_IMPLICIT_PROG_AUX_ARG flag has %d > %d args",
+				     nargs + 1, MAX_BPF_FUNC_REG_ARGS);
+			return -EFAULT;
+		}
+		u32 regno = nargs + 1;
+		ret = set_kfunc_arg_prog_regno(env, meta, regno);
+		if (ret)
+			return ret;
+	}
+
 	/* Check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -13066,14 +13098,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		if (is_kfunc_arg_ignore(btf, &args[i]))
 			continue;
 
+		/* __prog annotation check for backward compatibility */
 		if (is_kfunc_arg_prog(btf, &args[i])) {
-			/* Used to reject repeated use of __prog. */
-			if (meta->arg_prog) {
-				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
-				return -EFAULT;
-			}
-			meta->arg_prog = true;
-			cur_aux(env)->arg_prog = regno;
+			ret = set_kfunc_arg_prog_regno(env, meta, regno);
+			if (ret)
+				return ret;
 			continue;
 		}
 
-- 
2.51.0


