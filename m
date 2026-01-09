Return-Path: <bpf+bounces-78356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D05D0BEE3
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 459073026DAD
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5402DEA73;
	Fri,  9 Jan 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cARZLPNB"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AA2FDC3C
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984584; cv=none; b=dcKPMCJ1Om2502mpVdIpjolZaMj/yqoKV+EKuhMc8N2scT5qzUqz7IkLvec3yEUu2jKN8w0xHyMV6rIY6HrHufrTjvw1ezpaQxSPJkLwmLl6O3GtRTQHHszm4EQPjoNbrOyMS6WPxuFggsB6S0rKIy/AXIPm1EDcUmNhQB2wJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984584; c=relaxed/simple;
	bh=SNs1i8LcwXa9cchGiRUFS/dIt7OS7g3yh0iQEBysHAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5EpyUVfQKX2U4AaT5UmlOBvuhKa5lBNUt+li3gnCRoMvjX7UEGC5I1IZh1MNDD33bpbvpUjAoStANnzjMUUol59igM0fRgtiv2x581KxMZpiBlxxHn0SVsFZeIzXNf4xoaTQ6ppnGnNUMuCzsv4GQEK9EvWFsu0VbYoRP+oH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cARZLPNB; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHBcpvdYxSh081KgasitZRLy+wsjBEkvKgfdrrzW0MA=;
	b=cARZLPNBS+q4FSKx7ZouYfUFF6m4J6o15DVE6/Q58SaTBQkKqWbZ9cSw6+vKK6YJANfw7V
	PxdotazeZ4rkepF89Z6sBhPz8sXHHLhlmmYDVjsRHI6TBjweDksHezNSGqrChAskW6X3kN
	FI7+cJr8hqbPn4TrURnTuQtSSVNfxLc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 04/10] resolve_btfids: Support for KF_IMPLICIT_ARGS
Date: Fri,  9 Jan 2026 10:48:46 -0800
Message-ID: <20260109184852.1089786-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement BTF modifications in resolve_btfids to support BPF kernel
functions with implicit arguments.

For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
prototype is added to BTF that does not have implicit arguments. The
kfunc's prototype is then updated to a new one in BTF. This prototype
is the intended interface for the BPF programs.

A <func_name>_impl function is added to BTF to make the original kfunc
prototype searchable for the BPF verifier. If a <func_name>_impl
function already exists in BTF, its interpreted as a legacy case, and
this step is skipped.

Whether an argument is implicit is determined by its type:
currently only `struct bpf_prog_aux *` is supported.

As a result, the BTF associated with kfunc is changed from

    __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);

into

    bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
    __bpf_kfunc bpf_foo(int arg1);

For more context see previous discussions and patches [1][2].

[1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
[2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 282 ++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index df39982f51df..b361e726fa36 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -152,6 +152,18 @@ struct object {
 	int nr_typedefs;
 };
 
+#define KF_IMPLICIT_ARGS (1 << 16)
+#define KF_IMPL_SUFFIX "_impl"
+#define MAX_BPF_FUNC_REG_ARGS 5
+#define MAX_KFUNCS 256
+#define MAX_DECL_TAGS (MAX_KFUNCS * 4)
+
+struct btf2btf_context {
+	struct btf *btf;
+	u32 nr_decl_tags;
+	s32 decl_tags[MAX_DECL_TAGS];
+};
+
 static int verbose;
 static int warnings;
 
@@ -972,6 +984,273 @@ static int patch_btfids(const char *btfids_path, const char *elf_path)
 	return err;
 }
 
+static s64 collect_kfunc_ids_by_flags(struct object *obj,
+				      u32 flags,
+				      s32 kfunc_ids[],
+				      const u32 kfunc_ids_sz)
+{
+	Elf_Data *data = obj->efile.idlist;
+	struct rb_node *next;
+	s64 nr_kfuncs = 0;
+	int i;
+
+	next = rb_first(&obj->sets);
+	while (next) {
+		struct btf_id_set8 *set8 = NULL;
+		unsigned long addr, off;
+		struct btf_id *id;
+
+		id = rb_entry(next, struct btf_id, rb_node);
+
+		if (id->kind != BTF_ID_KIND_SET8)
+			goto skip;
+
+		addr = id->addr[0];
+		off = addr - obj->efile.idlist_addr;
+		set8 = data->d_buf + off;
+
+		for (i = 0; i < set8->cnt; i++) {
+			if (set8->pairs[i].flags & flags) {
+				if (nr_kfuncs >= kfunc_ids_sz) {
+					pr_err("ERROR: resolve_btfids: too many kfuncs with flags %u - limit %d\n",
+					       flags, kfunc_ids_sz);
+					return -E2BIG;
+				}
+				kfunc_ids[nr_kfuncs++] = set8->pairs[i].id;
+			}
+		}
+skip:
+		next = rb_next(next);
+	}
+
+	return nr_kfuncs;
+}
+
+static const struct btf_type *btf__unqualified_type_by_id(const struct btf *btf, s32 type_id)
+{
+	const struct btf_type *t = btf__type_by_id(btf, type_id);
+
+	while (btf_is_mod(t))
+		t = btf__type_by_id(btf, t->type);
+
+	return t;
+}
+
+/* Implicit BPF kfunc arguments can only be of particular types */
+static bool btf__is_kf_implicit_arg(const struct btf *btf, const struct btf_param *p)
+{
+	static const char *const kf_implicit_arg_types[] = {
+		"bpf_prog_aux",
+	};
+	const struct btf_type *t;
+	const char *name;
+
+	t = btf__unqualified_type_by_id(btf, p->type);
+	if (!btf_is_ptr(t))
+		return false;
+
+	t = btf__unqualified_type_by_id(btf, t->type);
+	if (!btf_is_struct(t))
+		return false;
+
+	name = btf__name_by_offset(btf, t->name_off);
+	if (!name)
+		return false;
+
+	for (int i = 0; i < ARRAY_SIZE(kf_implicit_arg_types); i++)
+		if (strcmp(name, kf_implicit_arg_types[i]) == 0)
+			return true;
+
+	return false;
+}
+
+/*
+ * For a kfunc with KF_IMPLICIT_ARGS we do the following:
+ *   1. Add a new function with _impl suffix in the name, with the prototype
+ *      of the original kfunc.
+ *   2. Add all decl tags except "bpf_kfunc" for the _impl func.
+ *   3. Add a new function prototype with modified list of arguments:
+ *      omitting implicit args.
+ *   4. Change the prototype of the original kfunc to the new one.
+ *
+ * This way we transform the BTF associated with the kfunc from
+ *	__bpf_kfunc bpf_foo(int arg1, void *implicit_arg);
+ * into
+ *	bpf_foo_impl(int arg1, void *implicit_arg);
+ *	__bpf_kfunc bpf_foo(int arg1);
+ *
+ * If a kfunc with KF_IMPLICIT_ARGS already has an _impl counterpart
+ * in BTF, then it's a legacy case: an _impl function is declared in the
+ * source code. In this case, we can skip adding an _impl function, but we
+ * still have to add a func prototype that omits implicit args.
+ */
+static s64 process_kfunc_with_implicit_args(struct btf2btf_context *ctx, s32 kfunc_id)
+{
+	struct btf_param new_params[MAX_BPF_FUNC_REG_ARGS];
+	const char *kfunc_name, *param_name, *tag_name;
+	s32 proto_id, new_proto_id, new_func_id;
+	int err, len, name_len, nr_params;
+	const struct btf_param *params;
+	enum btf_func_linkage linkage;
+	char tmp_name[KSYM_NAME_LEN];
+	struct btf *btf = ctx->btf;
+	struct btf_type *t;
+
+	t = (struct btf_type *)btf__type_by_id(btf, kfunc_id);
+	if (!t || !btf_is_func(t)) {
+		pr_err("WARN: resolve_btfids: btf id %d is not a function\n", kfunc_id);
+		return -EINVAL;
+	}
+
+	kfunc_name = btf__name_by_offset(btf, t->name_off);
+	name_len = strlen(kfunc_name);
+	linkage = btf_vlen(t);
+
+	proto_id = t->type;
+	t = (struct btf_type *)btf__type_by_id(btf, proto_id);
+	if (!t || !btf_is_func_proto(t)) {
+		pr_err("ERROR: resolve_btfids: btf id %d is not a function prototype\n", proto_id);
+		return -EINVAL;
+	}
+
+	len = snprintf(tmp_name, sizeof(tmp_name), "%s%s", kfunc_name, KF_IMPL_SUFFIX);
+	if (len < 0 || len >= sizeof(tmp_name)) {
+		pr_err("ERROR: function name is too long: %s%s\n", kfunc_name, KF_IMPL_SUFFIX);
+		return -E2BIG;
+	}
+
+	if (btf__find_by_name_kind(btf, tmp_name, BTF_KIND_FUNC) > 0) {
+		pr_debug("resolve_btfids: function %s already exists in BTF\n", tmp_name);
+		goto add_new_proto;
+	}
+
+	/* Add a new function with _impl suffix and original prototype */
+	new_func_id = btf__add_func(btf, tmp_name, linkage, proto_id);
+	if (new_func_id < 0) {
+		pr_err("ERROR: resolve_btfids: failed to add func %s to BTF\n", tmp_name);
+		return new_func_id;
+	}
+
+	/* Copy all decl tags except "bpf_kfunc" from the original kfunc to the new one */
+	for (int i = 0; i < ctx->nr_decl_tags; i++) {
+		t = (struct btf_type *)btf__type_by_id(btf, ctx->decl_tags[i]);
+		if (t->type != kfunc_id)
+			continue;
+
+		tag_name = btf__name_by_offset(btf, t->name_off);
+		if (strcmp(tag_name, "bpf_kfunc") == 0)
+			continue;
+
+		err = btf__add_decl_tag(btf, tag_name, new_func_id, -1);
+		if (err < 0) {
+			pr_err("ERROR: resolve_btfids: failed to add decl tag %s for %s\n",
+			       tag_name, tmp_name);
+			return -EINVAL;
+		}
+	}
+
+add_new_proto:
+	/*
+	 * Drop the _impl suffix and point kfunc_name to the local buffer for later use.
+	 * When BTF is modified the original pointer is invalidated.
+	 */
+	tmp_name[name_len] = '\0';
+	kfunc_name = tmp_name;
+
+	/* Load non-implicit args from the original prototype */
+	t = (struct btf_type *)btf__type_by_id(btf, proto_id);
+	params = btf_params(t);
+	nr_params = 0;
+	for (int i = 0; i < btf_vlen(t); i++) {
+		if (btf__is_kf_implicit_arg(btf, &params[i]))
+			break;
+		new_params[nr_params++] = params[i];
+	}
+
+	new_proto_id = btf__add_func_proto(btf, t->type);
+	if (new_proto_id < 0) {
+		pr_err("ERROR: resolve_btfids: failed to add func proto for %s\n", kfunc_name);
+		return new_proto_id;
+	}
+
+	/* Add non-implicit args to the new prototype */
+	for (int i = 0; i < nr_params; i++) {
+		param_name = btf__name_by_offset(btf, new_params[i].name_off);
+		err = btf__add_func_param(btf, param_name, new_params[i].type);
+		if (err < 0) {
+			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
+			       param_name, kfunc_name);
+			return err;
+		}
+	}
+
+	/* Finally change the prototype of the original kfunc to the new one */
+	t = (struct btf_type *)btf__type_by_id(btf, kfunc_id);
+	t->type = new_proto_id;
+
+	pr_debug("resolve_btfids: updated BTF for kfunc with implicit args %s\n", kfunc_name);
+
+	return 0;
+}
+
+static s64 btf__collect_decl_tags(const struct btf *btf, s32 *decl_tags, u32 decl_tags_sz)
+{
+	const u32 type_cnt = btf__type_cnt(btf);
+	const struct btf_type *t;
+	s64 nr_decl_tags = 0;
+
+	for (u32 id = 1; id < type_cnt; id++) {
+		t = btf__type_by_id(btf, id);
+		if (!btf_is_decl_tag(t))
+			continue;
+		if (nr_decl_tags >= decl_tags_sz) {
+			pr_err("ERROR: resolve_btfids: too many decl tags in BTF - limit %s\n",
+				decl_tags_sz);
+			return -E2BIG;
+		}
+		decl_tags[nr_decl_tags++] = id;
+	}
+
+	return nr_decl_tags;
+}
+
+static s64 build_btf2btf_context(struct object *obj, struct btf2btf_context *ctx)
+{
+	s64 nr_decl_tags;
+
+	nr_decl_tags = btf__collect_decl_tags(obj->btf, ctx->decl_tags, ARRAY_SIZE(ctx->decl_tags));
+	if (nr_decl_tags < 0)
+		return nr_decl_tags;
+
+	ctx->btf = obj->btf;
+	ctx->nr_decl_tags = nr_decl_tags;
+
+	return 0;
+}
+
+static s64 finalize_btf(struct object *obj)
+{
+	struct btf2btf_context ctx = {};
+	s32 kfuncs[MAX_KFUNCS];
+	s64 err, nr_kfuncs;
+
+	err = build_btf2btf_context(obj, &ctx);
+	if (err < 0)
+		return err;
+
+	nr_kfuncs = collect_kfunc_ids_by_flags(obj, KF_IMPLICIT_ARGS, kfuncs, ARRAY_SIZE(kfuncs));
+	if (nr_kfuncs < 0)
+		return nr_kfuncs;
+
+	for (u32 i = 0; i < nr_kfuncs; i++) {
+		err = process_kfunc_with_implicit_args(&ctx, kfuncs[i]);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static const char * const resolve_btfids_usage[] = {
 	"resolve_btfids [<options>] <ELF object>",
 	"resolve_btfids --patch_btfids <.BTF_ids file> <ELF object>",
@@ -1047,6 +1326,9 @@ int main(int argc, const char **argv)
 	if (symbols_patch(&obj))
 		goto out;
 
+	if (finalize_btf(&obj))
+		goto out;
+
 	err = make_out_path(out_path, sizeof(out_path), obj.path, BTF_IDS_SECTION);
 	err = err ?: dump_raw_btf_ids(&obj, out_path);
 	if (err)
-- 
2.52.0


