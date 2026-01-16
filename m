Return-Path: <bpf+bounces-79325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96DD386F3
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E07B73012EB9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5B83A4AAB;
	Fri, 16 Jan 2026 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PoYGGZqI"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4B2F3624
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594647; cv=none; b=X5n6BEnaWW0mH/JYKY5wivAd1bJ61+C/0Kx9KUAsvHkDxpvpxLpEiNFwzJ854jC2dEjK0RR4np6EmD/YXO6clEoEZSTe6uVC2clw20fvpP5soHH3nagU2YJ+UgXbL2hCMijbTpcjazfUE07kDIp7Wy0OnI6Z7AZFJpVDveGk8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594647; c=relaxed/simple;
	bh=EGDaZxphteys4MDa8MzuZ1bd1Xd4XXDAHrpujbR+TGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVeNNIXPOOriJq2C/nw3zJSZ5NPs5caxxdxvXCsrYAP3BMH1j8JSJAN0zb31crin8SK/hEdEdKuwG6URk2SY0nSmp1LmJqyH0z6XKu6oQCqk2NfWPKDrc90hFZp36OMUUxA6dwKFpvjFWHDDjUQFHPngEPgg9SSxjqyugg1nLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PoYGGZqI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6eFTBE8G/ALAVO9QF3Nim9O//OBqjjYmjnaMs7N+SE=;
	b=PoYGGZqIKUmpfhnbZeK4cRNhVsYv/wowjrgfD3xhIpSzJwWKDOtfxITm8Kb8Bk9vYMtT7D
	wcokQspuZU1nMEpGwqvHzv6MLvDBISooEv54Mkk0xNnHUAeATm4cFKT6PShzZ7rWrL3mK2
	QTrFE8Q7RcWdD/fe/RGz8HmURYfNyHE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 01/13] bpf: Refactor btf_kfunc_id_set_contains
Date: Fri, 16 Jan 2026 12:16:48 -0800
Message-ID: <20260116201700.864797-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
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
If it returns NULL instead of a valid pointer, it's interpreted as an
illegal kfunc usage failing the verification.

There are two potential reasons for btf_kfunc_id_set_contains() to
return NULL:

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
only caller of btf_kfunc_id_set_contains().

However in subsequent patches of this series it is necessary to
inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().

To resolve this, refactor btf_kfunc_id_set_contains() into two
interface functions:
  * btf_kfunc_flags() that simply returns pointer to kfunc_flags
    without applying the filters
  * btf_kfunc_is_allowed() that both checks for kfunc_flags existence
    (which is a requirement for a kfunc to be allowed) and applies the
    prog filters

See [3] for the previous version of this patch.

[1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isovalent.com/
[2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.com/
[3] https://lore.kernel.org/bpf/20251029190113.3323406-3-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h   |  4 +--
 kernel/bpf/btf.c      | 70 ++++++++++++++++++++++++++++++++-----------
 kernel/bpf/verifier.c |  6 ++--
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 78dc79810c7d..a2f4f383f5b6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -575,8 +575,8 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
-u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
-			       const struct bpf_prog *prog);
+u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
+bool btf_kfunc_is_allowed(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 364dd84bfc5a..d10b3404260f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8757,24 +8757,17 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
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
@@ -8785,6 +8778,28 @@ static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 	return id + 1;
 }
 
+static bool __btf_kfunc_is_allowed(const struct btf *btf,
+				   enum btf_kfunc_hook hook,
+				   u32 kfunc_btf_id,
+				   const struct bpf_prog *prog)
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
@@ -8832,6 +8847,26 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	}
 }
 
+bool btf_kfunc_is_allowed(const struct btf *btf,
+			  u32 kfunc_btf_id,
+			  const struct bpf_prog *prog)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum btf_kfunc_hook hook;
+	u32 *kfunc_flags;
+
+	kfunc_flags = btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id);
+	if (kfunc_flags && __btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog))
+		return true;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	kfunc_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
+	if (kfunc_flags && __btf_kfunc_is_allowed(btf, hook, kfunc_btf_id, prog))
+		return true;
+
+	return false;
+}
+
 /* Caution:
  * Reference to the module (obtained using btf_try_get_module) corresponding to
  * the struct btf *MUST* be held when calling this function from verifier
@@ -8839,26 +8874,27 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
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
 }
 
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
-	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog);
+	if (!__btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog))
+		return NULL;
+
+	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..bd9bd797f5a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13723,10 +13723,10 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
-	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, func_id, env->prog);
-	if (!kfunc_flags) {
+	if (!btf_kfunc_is_allowed(desc_btf, func_id, env->prog))
 		return -EACCES;
-	}
+
+	kfunc_flags = btf_kfunc_flags(desc_btf, func_id, env->prog);
 
 	memset(meta, 0, sizeof(*meta));
 	meta->btf = desc_btf;
-- 
2.52.0


