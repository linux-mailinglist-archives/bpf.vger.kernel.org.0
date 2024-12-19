Return-Path: <bpf+bounces-47353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3BC9F85DB
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611417A1518
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0111D63CD;
	Thu, 19 Dec 2024 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3YGISUE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E01A42C4;
	Thu, 19 Dec 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639980; cv=none; b=q7Phrn91SgRkMDZrCtJsGQwqq2PXlQYOO9IF/t7NnUTL9G5jKks0x6f00nAckPiV3g93E5T/kr1uvvXlKR5zVuAw32gpNfhMpeT6Gip6sZ0Ts+a/9MEg6iKS9e1dbE3xpaCx9eO4T3bkv1gRIhVmHt336ajnWoAjJ0IsujiRWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639980; c=relaxed/simple;
	bh=TGmHUu/udU2dbRrsqhZT9+qVH+JARv086QbCbxF9jG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od/sXsaUya0gTQqEBvpFJDTtVyR5W1tJUo22ckehbQN9GIPb0LMSZHMNDPGNdUaMhVpL3vpAmzsX2WKjcnvudQjyW1ZidudGyj8j/+Gvve9un5Cj31ghjAa2/0EVKonhirDdCZ/PcVU4CIyWGb92yk0MiBR5jwskew+Abs8+jxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3YGISUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E3DC4CED4;
	Thu, 19 Dec 2024 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639979;
	bh=TGmHUu/udU2dbRrsqhZT9+qVH+JARv086QbCbxF9jG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3YGISUEilDTVakSLwwdfv49oRiYFrru8fbXESSG5r8LkeA5T/gPxyC+bbdcKarOP
	 GsOTspff+YkMbb/G5IIkPmNbVWAVZh61kj0Vvx7AiEZu+rfyfc+QwkMbTIG+881pw2
	 5oLRIRZvDx4u9buTZ4B5Z14iWthKHfGTEreYqWoGq/6HGGMuU2k5Ycu9hmU/P8rYni
	 At62TcTv/Nkb9hzwFbwNfh1BH+0njHFaYQpo6Q4z80wDqWyDquNCev3YTZtQWHfVGC
	 3FU1L9SFTkfUnBQZwAQvFkL2zMP3ktKQbe7efZpH9XbzpssVzzfFJrVBI8kuMgc/k7
	 rceN8RoIrUkDw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v6 bpf-next 4/7] bpf: Extend btf_kfunc_id_set to handle kfunc polymorphism
Date: Thu, 19 Dec 2024 12:25:33 -0800
Message-ID: <20241219202536.1625216-5-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219202536.1625216-1-song@kernel.org>
References: <20241219202536.1625216-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Polymorphism exists in kernel functions, BPF helpers, as well as kfuncs.
When called from different contexts, it is necessary to pick the right
version of a kfunc. One of such example is bpf_dynptr_from_skb vs.
bpf_dynptr_from_skb_rdonly.

To avoid the burden on the users, the verifier can inspect the calling
context and select the right version of kfunc. However, with more kfuncs
being added to the kernel, it is not scalable to push all these logic
to the verifiler.

Extend btf_kfunc_id_set to handle kfunc polymorphism. Specifically,
a list of kfuncs, "hidden_set", and a new method "remap" is added to
btf_kfunc_id_set. kfuncs in hidden_set do not have BTF_SET8_KFUNCS flag,
and are not exposed in vmlinux.h. The remap method is used to inspect
the calling context, and when necessary, remap the user visible kfuncs
(for example, bpf_dynptr_from_skb), to its hidden version (for example,
bpf_dynptr_from_skb_rdonly).

The verifier calls in these remap logic via the new btf_kfunc_id_remap()
API, and picks the right kfuncs for the context.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/btf.h     |  20 +++++++
 include/linux/btf_ids.h |   3 ++
 kernel/bpf/btf.c        | 117 ++++++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c   |  11 +++-
 4 files changed, 132 insertions(+), 19 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..64f57edba626 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -114,11 +114,23 @@ struct btf_id_set;
 struct bpf_prog;
 
 typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 kfunc_id);
+typedef u32 (*btf_kfunc_remap_t)(const struct bpf_prog *prog, u32 kfunc_id);
 
 struct btf_kfunc_id_set {
 	struct module *owner;
 	struct btf_id_set8 *set;
+
+	/* *hidden_set* contains kfuncs that are not exposed as kfunc in
+	 * vmlinux.h. These kfuncs are usually a variation of a kfunc
+	 * in *set*.
+	 */
+	struct btf_id_set8 *hidden_set;
 	btf_kfunc_filter_t filter;
+
+	/* *remap* method remaps kfuncs in *set* to proper version in
+	 * *hidden_set*.
+	 */
+	btf_kfunc_remap_t remap;
 };
 
 struct btf_id_dtor_kfunc {
@@ -570,6 +582,8 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
+u32 btf_kfunc_id_remap(const struct btf *btf, u32 kfunc_btf_id,
+		       const struct bpf_prog *prog);
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
@@ -632,6 +646,12 @@ static inline u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 {
 	return NULL;
 }
+static inline u32 btf_kfunc_id_remap(const struct btf *btf, u32 kfunc_btf_id,
+				     const struct bpf_prog *prog)
+{
+	return kfunc_btf_id;
+}
+
 static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 					    const struct btf_kfunc_id_set *s)
 {
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 139bdececdcf..e95b72fbba48 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -212,6 +212,9 @@ extern struct btf_id_set8 name;
 #define BTF_KFUNCS_START(name)				\
 __BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
 
+#define BTF_HIDDEN_KFUNCS_START(name)			\
+__BTF_SET8_START(name, local, 0)
+
 #define BTF_KFUNCS_END(name)				\
 BTF_SET8_END(name)
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 28246c59e12e..e7766f8e02ba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -226,6 +226,7 @@ enum {
 	BTF_KFUNC_SET_MAX_CNT = 256,
 	BTF_DTOR_KFUNC_MAX_CNT = 256,
 	BTF_KFUNC_FILTER_MAX_CNT = 16,
+	BTF_KFUNC_REMAP_MAX_CNT = 16,
 };
 
 struct btf_kfunc_hook_filter {
@@ -233,9 +234,15 @@ struct btf_kfunc_hook_filter {
 	u32 nr_filters;
 };
 
+struct btf_kfunc_hook_remap {
+	btf_kfunc_remap_t remaps[BTF_KFUNC_REMAP_MAX_CNT];
+	u32 nr_remaps;
+};
+
 struct btf_kfunc_set_tab {
 	struct btf_id_set8 *sets[BTF_KFUNC_HOOK_MAX];
 	struct btf_kfunc_hook_filter hook_filters[BTF_KFUNC_HOOK_MAX];
+	struct btf_kfunc_hook_remap hook_remaps[BTF_KFUNC_HOOK_MAX];
 };
 
 struct btf_id_dtor_kfunc_tab {
@@ -8377,16 +8384,35 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 
 /* Kernel Function (kfunc) BTF ID set registration API */
 
+static void btf_add_kfunc_to_set(struct btf *btf, struct btf_id_set8 *set,
+				 struct btf_id_set8 *add_set)
+{
+	u32 i;
+
+	if (!add_set)
+		return;
+	/* Concatenate the two sets */
+	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
+	/* Now that the set is copied, update with relocated BTF ids */
+	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
+		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
+
+	set->cnt += add_set->cnt;
+
+	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
+}
+
 static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 				  const struct btf_kfunc_id_set *kset)
 {
 	struct btf_kfunc_hook_filter *hook_filter;
-	struct btf_id_set8 *add_set = kset->set;
+	struct btf_kfunc_hook_remap *hook_remap;
 	bool vmlinux_set = !btf_is_module(btf);
 	bool add_filter = !!kset->filter;
+	bool add_remap = !!kset->remap;
 	struct btf_kfunc_set_tab *tab;
 	struct btf_id_set8 *set;
-	u32 set_cnt, i;
+	u32 set_cnt, add_cnt, i;
 	int ret;
 
 	if (hook >= BTF_KFUNC_HOOK_MAX) {
@@ -8394,14 +8420,16 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		goto end;
 	}
 
-	if (!add_set->cnt)
+	add_cnt = kset->set->cnt;
+	if (kset->hidden_set)
+		add_cnt += kset->hidden_set->cnt;
+
+	if (!add_cnt)
 		return 0;
 
 	tab = btf->kfunc_set_tab;
 
 	if (tab && add_filter) {
-		u32 i;
-
 		hook_filter = &tab->hook_filters[hook];
 		for (i = 0; i < hook_filter->nr_filters; i++) {
 			if (hook_filter->filters[i] == kset->filter) {
@@ -8416,6 +8444,21 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		}
 	}
 
+	if (tab && add_remap) {
+		hook_remap = &tab->hook_remaps[hook];
+		for (i = 0; i < hook_remap->nr_remaps; i++) {
+			if (hook_remap->remaps[i] == kset->remap) {
+				add_remap = false;
+				break;
+			}
+		}
+
+		if (add_remap && hook_remap->nr_remaps == BTF_KFUNC_REMAP_MAX_CNT) {
+			ret = -E2BIG;
+			goto end;
+		}
+	}
+
 	if (!tab) {
 		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
 		if (!tab)
@@ -8444,19 +8487,19 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	 */
 	set_cnt = set ? set->cnt : 0;
 
-	if (set_cnt > U32_MAX - add_set->cnt) {
+	if (set_cnt > U32_MAX - add_cnt) {
 		ret = -EOVERFLOW;
 		goto end;
 	}
 
-	if (set_cnt + add_set->cnt > BTF_KFUNC_SET_MAX_CNT) {
+	if (set_cnt + add_cnt > BTF_KFUNC_SET_MAX_CNT) {
 		ret = -E2BIG;
 		goto end;
 	}
 
 	/* Grow set */
 	set = krealloc(tab->sets[hook],
-		       offsetof(struct btf_id_set8, pairs[set_cnt + add_set->cnt]),
+		       offsetof(struct btf_id_set8, pairs[set_cnt + add_cnt]),
 		       GFP_KERNEL | __GFP_NOWARN);
 	if (!set) {
 		ret = -ENOMEM;
@@ -8468,20 +8511,18 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 		set->cnt = 0;
 	tab->sets[hook] = set;
 
-	/* Concatenate the two sets */
-	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
-	/* Now that the set is copied, update with relocated BTF ids */
-	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
-		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
-
-	set->cnt += add_set->cnt;
-
-	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
+	btf_add_kfunc_to_set(btf, set, kset->set);
+	btf_add_kfunc_to_set(btf, set, kset->hidden_set);
 
 	if (add_filter) {
 		hook_filter = &tab->hook_filters[hook];
 		hook_filter->filters[hook_filter->nr_filters++] = kset->filter;
 	}
+
+	if (add_remap) {
+		hook_remap = &tab->hook_remaps[hook];
+		hook_remap->remaps[hook_remap->nr_remaps++] = kset->remap;
+	}
 	return 0;
 end:
 	btf_free_kfunc_set_tab(btf);
@@ -8516,6 +8557,28 @@ static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 	return id + 1;
 }
 
+static u32 __btf_kfunc_id_remap(const struct btf *btf,
+				enum btf_kfunc_hook hook,
+				u32 kfunc_btf_id,
+				const struct bpf_prog *prog)
+{
+	struct btf_kfunc_hook_remap *hook_remap;
+	u32 i, remap_id = 0;
+
+	if (hook >= BTF_KFUNC_HOOK_MAX)
+		return 0;
+	if (!btf->kfunc_set_tab)
+		return 0;
+	hook_remap = &btf->kfunc_set_tab->hook_remaps[hook];
+
+	for (i = 0; i < hook_remap->nr_remaps; i++) {
+		remap_id = hook_remap->remaps[i](prog, kfunc_btf_id);
+		if (remap_id)
+			break;
+	}
+	return remap_id;
+}
+
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
@@ -8584,6 +8647,26 @@ u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id, prog);
 }
 
+/* Reference to the module (obtained using btf_try_get_module)
+ * corresponding to the struct btf *MUST* be held when calling this
+ * function from the verifier
+ */
+u32 btf_kfunc_id_remap(const struct btf *btf, u32 kfunc_btf_id,
+		       const struct bpf_prog *prog)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	enum btf_kfunc_hook hook;
+	u32 remap_id;
+
+	remap_id = __btf_kfunc_id_remap(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog);
+	if (remap_id)
+		return remap_id;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	remap_id = __btf_kfunc_id_remap(btf, hook, kfunc_btf_id, prog);
+	return remap_id ?: kfunc_btf_id;
+}
+
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e5..a5b02a8665f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3224,10 +3224,17 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 			return -EPERM;
 		}
 
-		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
+		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
 			ret = add_subprog(env, i + insn->imm + 1);
-		else
+		} else {
+			struct btf *desc_btf;
+
+			desc_btf = find_kfunc_desc_btf(env, insn->off);
+			if (IS_ERR(desc_btf))
+				return PTR_ERR(desc_btf);
+			insn->imm = btf_kfunc_id_remap(desc_btf, insn->imm, env->prog);
 			ret = add_kfunc_call(env, insn->imm, insn->off);
+		}
 
 		if (ret < 0)
 			return ret;
-- 
2.43.5


