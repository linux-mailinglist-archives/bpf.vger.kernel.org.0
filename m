Return-Path: <bpf+bounces-76184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA38CA97E5
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 23:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FA4E30351BA
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2F2E9EC6;
	Fri,  5 Dec 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EhgzH6nk"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC62E11AA
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764973921; cv=none; b=ffZbA+55FOoqrI+ELavBNHQO7dGvXKb8b3PjOyZ5l46p+yitolfLUP6LN30Rex3F+kV6nY92iS6a8+3yNsgAEX2VhjUJPxjWGbB7c0hOG5KM3+3omcyOKwZyH2RAMb9iGSoLxibvYnHzGiICbMMF16AA+UzBhW/EsGl5hYQqjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764973921; c=relaxed/simple;
	bh=cQP22BYy1g/JJlhq4yOteqEEMfKlLx68xSANcNE1aV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhNP1Z6lyF8dgJrXh9RQh0aT7qLN5ps6Ei1x+cMRHProkP8KZwGIPXvohzs7wnPTylPoeb1x/Q0aemGxHKWFtDfVXpST+ejZ1xe57m8BOfB2sbddSriDqiiHSzVDoezUMP/h6Ul14tbWFBNgz4hLIdxUFM5av7LkNu5bYnRtiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EhgzH6nk; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764973914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKCToaWQhyOoB9uV9T+sXccEZiEHy2WyaxYjNKPKlXU=;
	b=EhgzH6nk+ppWhiKvjDRcxAfKGlzspxbZFb/TRdzVPXZVP+MffN8vcNgrtUNj9dibXdwBBU
	zDdvMM9qLmMiEV+oRrIUzNqlZXsMDQvE65R7i/8I0jcO+kUtbMsu0UCAFiAMa6qGtsQskI
	jzgb2j5b/LuBT7sxHomYfcl8eeLzlQw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] resolve_btfids: Introduce enum btf_id_kind
Date: Fri,  5 Dec 2025 14:30:43 -0800
Message-ID: <20251205223046.4155870-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Instead of using multiple flags, make struct btf_id tagged with an
enum value indicating its kind in the context of resolve_btfids.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 76 ++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index b4caae1170dd..cb1e69eb0bd7 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -98,6 +98,13 @@
 # error "Unknown machine endianness!"
 #endif
 
+enum btf_id_kind {
+	BTF_ID_KIND_NONE,
+	BTF_ID_KIND_SYM,
+	BTF_ID_KIND_SET,
+	BTF_ID_KIND_SET8
+};
+
 struct btf_id {
 	struct rb_node	 rb_node;
 	char		*name;
@@ -105,9 +112,8 @@ struct btf_id {
 		int	 id;
 		int	 cnt;
 	};
+	enum btf_id_kind kind;
 	int		 addr_cnt;
-	bool		 is_set;
-	bool		 is_set8;
 	Elf64_Addr	 addr[ADDR_CNT];
 };
 
@@ -197,8 +203,7 @@ static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
 	return NULL;
 }
 
-static struct btf_id *
-btf_id__add(struct rb_root *root, char *name, bool unique)
+static struct btf_id *btf_id__add(struct rb_root *root, char *name, enum btf_id_kind kind)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
@@ -213,14 +218,19 @@ btf_id__add(struct rb_root *root, char *name, bool unique)
 			p = &(*p)->rb_left;
 		else if (cmp > 0)
 			p = &(*p)->rb_right;
-		else
-			return unique ? NULL : id;
+		else if (kind == BTF_ID_KIND_SYM && id->kind == BTF_ID_KIND_SYM)
+			return id;
+		else {
+			pr_err("Unexpected duplicate symbol %s of kind %d\n", name, id->kind);
+			return NULL;
+		}
 	}
 
 	id = zalloc(sizeof(*id));
 	if (id) {
 		pr_debug("adding symbol %s\n", name);
 		id->name = name;
+		id->kind = kind;
 		rb_link_node(&id->rb_node, parent, p);
 		rb_insert_color(&id->rb_node, root);
 	}
@@ -260,22 +270,36 @@ static char *get_id(const char *prefix_end)
 	return id;
 }
 
-static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
+static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
 {
+	int len = strlen(name);
+	int prefixlen;
+	char *id;
+
 	/*
 	 * __BTF_ID__set__name
 	 * name =    ^
 	 * id   =         ^
 	 */
-	char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
-	int len = strlen(name);
+	switch (kind) {
+	case BTF_ID_KIND_SET:
+		prefixlen = sizeof(BTF_SET "__") - 1;
+		break;
+	case BTF_ID_KIND_SET8:
+		prefixlen = sizeof(BTF_SET8 "__") - 1;
+		break;
+	default:
+		pr_err("Unexpected kind %d passed to %s() for symbol %s\n", kind, __func__, name);
+		return NULL;
+	}
 
+	id = name + prefixlen - 1;
 	if (id >= name + len) {
 		pr_err("FAILED to parse set name: %s\n", name);
 		return NULL;
 	}
 
-	return btf_id__add(&obj->sets, id, true);
+	return btf_id__add(&obj->sets, id, kind);
 }
 
 static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
@@ -288,7 +312,7 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 		return NULL;
 	}
 
-	return btf_id__add(root, id, false);
+	return btf_id__add(root, id, BTF_ID_KIND_SYM);
 }
 
 /* Older libelf.h and glibc elf.h might not yet define the ELF compression types. */
@@ -491,28 +515,24 @@ static int symbols_collect(struct object *obj)
 			id = add_symbol(&obj->funcs, prefix, sizeof(BTF_FUNC) - 1);
 		/* set8 */
 		} else if (!strncmp(prefix, BTF_SET8, sizeof(BTF_SET8) - 1)) {
-			id = add_set(obj, prefix, true);
+			id = add_set(obj, prefix, BTF_ID_KIND_SET8);
 			/*
 			 * SET8 objects store list's count, which is encoded
 			 * in symbol's size, together with 'cnt' field hence
 			 * that - 1.
 			 */
-			if (id) {
+			if (id)
 				id->cnt = sym.st_size / sizeof(uint64_t) - 1;
-				id->is_set8 = true;
-			}
 		/* set */
 		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
-			id = add_set(obj, prefix, false);
+			id = add_set(obj, prefix, BTF_ID_KIND_SET);
 			/*
 			 * SET objects store list's count, which is encoded
 			 * in symbol's size, together with 'cnt' field hence
 			 * that - 1.
 			 */
-			if (id) {
+			if (id)
 				id->cnt = sym.st_size / sizeof(int) - 1;
-				id->is_set = true;
-			}
 		} else {
 			pr_err("FAILED unsupported prefix %s\n", prefix);
 			return -1;
@@ -643,7 +663,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	/* For set, set8, id->id may be 0 */
-	if (!id->id && !id->is_set && !id->is_set8) {
+	if (!id->id && id->kind != BTF_ID_KIND_SET && id->kind != BTF_ID_KIND_SET8) {
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
 		warnings++;
 	}
@@ -696,6 +716,7 @@ static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
 	struct rb_node *next;
+	int cnt;
 
 	next = rb_first(&obj->sets);
 	while (next) {
@@ -715,11 +736,15 @@ static int sets_patch(struct object *obj)
 			return -1;
 		}
 
-		if (id->is_set) {
+		switch (id->kind) {
+		case BTF_ID_KIND_SET:
 			set = data->d_buf + off;
+			cnt = set->cnt;
 			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
-		} else {
+			break;
+		case BTF_ID_KIND_SET8:
 			set8 = data->d_buf + off;
+			cnt = set8->cnt;
 			/*
 			 * Make sure id is at the beginning of the pairs
 			 * struct, otherwise the below qsort would not work.
@@ -744,10 +769,13 @@ static int sets_patch(struct object *obj)
 						bswap_32(set8->pairs[i].flags);
 				}
 			}
+			break;
+		default:
+			pr_err("Unexpected btf_id_kind %d for set '%s'\n", id->kind, id->name);
+			return -1;
 		}
 
-		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-			 off, id->is_set ? set->cnt : set8->cnt, id->name);
+		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n", off, cnt, id->name);
 
 		next = rb_next(next);
 	}
-- 
2.52.0


