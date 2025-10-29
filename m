Return-Path: <bpf+bounces-72855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC996C1CDD0
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7A6560640
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794A3358D0;
	Wed, 29 Oct 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uijZlh5r"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D095307ACA
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764508; cv=none; b=tuUeOSWazJ8WW1zn7R0L3+dtSiBJZBOkyUc/dGe2Ehy8T4LbOX0pGKU3hTVXmxrwRpyG7172BOSDN9fdDLBAdThc0wgFz9aQ1veSKxqkGdk8A4zJjCkrp6c8QDvdSRtA36Yzp5vG64dtc+a8UuFkMCDTxma1t1b7Q92wFb3Z48I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764508; c=relaxed/simple;
	bh=W1TReNxz1kPa3xn0UZL0KTHpKw3SV/fOBbxAQ7Q3MYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLMTHuoX7u1V2VNiDLc7zfNY8ZKN1lImxgPEomWs0mRHSQrvAkanxarWQuYQg3xg8ZyKHeSBWfY2c6r2Ic3rYfF3wEPO5qbEWj5M8MAmCZcHqoMOhbSjYFkpyEdKr2iCnCVkYuHhPlbu5gSbW/PQQazatUqxsc3u4LBOHT6H5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uijZlh5r; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndOGLoJeWjtIlTgSGcAUA5qZ3dzeQiiZkuCwMzLhBN8=;
	b=uijZlh5rgxiFp+QMu9Qe7Ds//HbL3BqRQzRKmV4GKuDRMPmhbjXuNswFaNPOp2cR9JX837
	J72Qiz89OiEEHpxfLfPo1PXRnoWPzcOZsP3HGRxJ/NLClqJtXXFAoy4sLeaa+zsmmwoBgy
	aOowNLmrWPMCkg9AWCO3B3gIKqPXxKI=
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
Subject: [PATCH bpf-next v1 2/8] bpf: Refactor btf_kfunc_id_set_contains
Date: Wed, 29 Oct 2025 12:01:07 -0700
Message-ID: <20251029190113.3323406-3-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf_kfunc_id_set_contains() is called by fetch_kfunc_meta() in the BPF
verifier to get the kfunc flags stored in the .BTF_ids ELF section.
If it returns NULL instead of a valid pointer, it's interpreted by the
verifier as an illegal kfunc usage which fails the verification.

Conceptually, there are two potential reasons for
btf_kfunc_id_set_contains() to return NULL:

  1. Provided kfunc BTF id is not present in relevant kfunc id sets.
  2. The kfunc is not allowed, as determined by the program type
     specific filter [1].

The filter functions accept a pointer to `struct bpf_prog`, so they
might implicitly depend on earlier stages of verification, when
bpf_prog members are set.

For example, bpf_qdisc_kfunc_filter() in linux/net/sched/bpf_qdisc.c
inspects prog->aux->st_ops [2], which is initialized in:

    check_attach_btf_id() -> check_struct_ops_btf_id()

So far this hasn't been an issue, because fetch_kfunc_meta() is the
only place where lookup + filter logic is applied to a kfunc id.

However in subsequent patches of this series it is necessary to
inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().

To resolve this, refactor btf_kfunc_id_set_contains() into two
interface functions: btf_kfunc_flags() that does not apply the
filters, and btf_kfunc_flags_if_allowed() that does.

[1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isovalent.com/
[2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |  6 ++--
 kernel/bpf/btf.c      | 70 ++++++++++++++++++++++++++++++++-----------
 kernel/bpf/verifier.c |  2 +-
 3 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..9c64bc5e5789 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -575,8 +575,10 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
-u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
-			       const struct bpf_prog *prog);
+u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
+u32 *btf_kfunc_flags_if_allowed(const struct btf *btf,
+				u32 kfunc_btf_id,
+				const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..4d31b8061daf 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8640,24 +8640,17 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	return ret;
 }
 
-static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
-					enum btf_kfunc_hook hook,
-					u32 kfunc_btf_id,
-					const struct bpf_prog *prog)
+static u32 *btf_kfunc_id_set_contains(const struct btf *btf,
+				      enum btf_kfunc_hook hook,
+				      u32 kfunc_btf_id)
 {
-	struct btf_kfunc_hook_filter *hook_filter;
 	struct btf_id_set8 *set;
-	u32 *id, i;
+	u32 *id;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX)
 		return NULL;
 	if (!btf->kfunc_set_tab)
 		return NULL;
-	hook_filter = &btf->kfunc_set_tab->hook_filters[hook];
-	for (i = 0; i < hook_filter->nr_filters; i++) {
-		if (hook_filter->filters[i](prog, kfunc_btf_id))
-			return NULL;
-	}
 	set = btf->kfunc_set_tab->sets[hook];
 	if (!set)
 		return NULL;
@@ -8668,6 +8661,28 @@ static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 	return id + 1;
 }
 
+static bool btf_kfunc_is_allowed(const struct btf *btf,
+				 enum btf_kfunc_hook hook,
+				 u32 kfunc_btf_id,
+				 const struct bpf_prog *prog)
+{
+	struct btf_kfunc_hook_filter *hook_filter;
+	int i;
+
+	if (hook >= BTF_KFUNC_HOOK_MAX)
+		return false;
+	if (!btf->kfunc_set_tab)
+		return false;
+
+	hook_filter = &btf->kfunc_set_tab->hook_filters[hook];
+	for (i = 0; i < hook_filter->nr_filters; i++) {
+		if (hook_filter->filters[i](prog, kfunc_btf_id))
+			return false;
+	}
+
+	return true;
+}
+
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
@@ -8721,26 +8736,47 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
  * keeping the reference for the duration of the call provides the necessary
  * protection for looking up a well-formed btf->kfunc_set_tab.
  */
-u32 *btf_kfunc_id_set_contains(const struct btf *btf,
-			       u32 kfunc_btf_id,
-			       const struct bpf_prog *prog)
+u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 	enum btf_kfunc_hook hook;
 	u32 *kfunc_flags;
 
-	kfunc_flags = __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog);
+	kfunc_flags = btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
 	if (kfunc_flags)
 		return kfunc_flags;
 
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
-	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id, prog);
+	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+}
+
+u32 *btf_kfunc_flags_if_allowed(const struct btf *btf,
+				u32 kfunc_btf_id,
+				const struct bpf_prog *prog)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum btf_kfunc_hook hook;
+	u32 *kfunc_flags;
+
+	kfunc_flags = btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
+	if (kfunc_flags && btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog))
+		return kfunc_flags;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	kfunc_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+	if (kfunc_flags && btf_kfunc_is_allowed(btf, hook, kfunc_btf_id, prog))
+		return kfunc_flags;
+
+	return NULL;
 }
 
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
-	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog);
+	if (!btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog))
+		return NULL;
+
+	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..cb1b483be0fa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13631,7 +13631,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
-	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
+	kfunc_flags = btf_kfunc_flags_if_allowed(desc_btf, func_id, env->prog);
 	if (!kfunc_flags) {
 		return -EACCES;
 	}
-- 
2.51.1


