Return-Path: <bpf+bounces-77107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79149CCE351
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 03:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF5DA302E2D3
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3CC28000B;
	Fri, 19 Dec 2025 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITYaVzMl"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEB283FD6
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766109660; cv=none; b=n0Os7xsa7wVy/X/2mO3A4QH82MlmOZHn/qpYFKJzh2jwut0Sv3MJnOfMHF1W1EmQvC75sia1QshiExf0r07QMBeQQAfq/sSAitYTJewcmVaKjlybR3CtdhoiM9gQIxTb2vHTEfgu41lhHOJ3DDdQ5qLJn2+7upsCkDEn2NMvI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766109660; c=relaxed/simple;
	bh=3FEIiRUylmj0GITPIIkPwx+DdvKez+ddqxbv/x6D4l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAD/pO6PzkW0ib44WlIDC+D9y1eEQjwGliElGtYG1UUTOjMtV3Q6pER2x41g8z7rhcBh3Z58ZVKAEkMJWysvnBZOJ5kTOBEa/8eSONb6siex4KYdQdISEDCfp6YLeovsp5nLv5JcWAqMS24dnrE/8PNcjbOPtmi5xhEUS8POOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITYaVzMl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766109653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sF5NRKZEGl/G+udktejbKoJb2K4tJj9XzuRyl23IiwY=;
	b=ITYaVzMldxMC67QL1N+DuRvm7Tups3VodTT8+eawC+XURqAU/13IDKQ3yOZ1hIxkBoF4fj
	/D1rbaOc5LLbmx7f9Jl/FtNOvcAx6jHn21cng24NliS1fGS/J/71DnEecsoB5HTvc7IXao
	dctxpeBEH3aQPSm8o0cUR8BPmJHKrpg=
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
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-kbuild@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v6 3/8] resolve_btfids: Introduce enum btf_id_kind
Date: Thu, 18 Dec 2025 18:00:01 -0800
Message-ID: <20251219020006.785065-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251219020006.785065-1-ihor.solodrai@linux.dev>
References: <20251219020006.785065-1-ihor.solodrai@linux.dev>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 83 ++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 23 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index b4caae1170dd..e721e20a2bbd 100644
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
 
@@ -197,8 +203,10 @@ static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
 	return NULL;
 }
 
-static struct btf_id *
-btf_id__add(struct rb_root *root, char *name, bool unique)
+static struct btf_id *__btf_id__add(struct rb_root *root,
+				    char *name,
+				    enum btf_id_kind kind,
+				    bool unique)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
@@ -221,12 +229,23 @@ btf_id__add(struct rb_root *root, char *name, bool unique)
 	if (id) {
 		pr_debug("adding symbol %s\n", name);
 		id->name = name;
+		id->kind = kind;
 		rb_link_node(&id->rb_node, parent, p);
 		rb_insert_color(&id->rb_node, root);
 	}
 	return id;
 }
 
+static inline struct btf_id *btf_id__add(struct rb_root *root, char *name, enum btf_id_kind kind)
+{
+	return __btf_id__add(root, name, kind, false);
+}
+
+static inline struct btf_id *btf_id__add_unique(struct rb_root *root, char *name, enum btf_id_kind kind)
+{
+	return __btf_id__add(root, name, kind, true);
+}
+
 static char *get_id(const char *prefix_end)
 {
 	/*
@@ -260,22 +279,36 @@ static char *get_id(const char *prefix_end)
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
 
+	id = name + prefixlen;
 	if (id >= name + len) {
 		pr_err("FAILED to parse set name: %s\n", name);
 		return NULL;
 	}
 
-	return btf_id__add(&obj->sets, id, true);
+	return btf_id__add_unique(&obj->sets, id, kind);
 }
 
 static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
@@ -288,7 +321,7 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 		return NULL;
 	}
 
-	return btf_id__add(root, id, false);
+	return btf_id__add(root, id, BTF_ID_KIND_SYM);
 }
 
 /* Older libelf.h and glibc elf.h might not yet define the ELF compression types. */
@@ -491,35 +524,31 @@ static int symbols_collect(struct object *obj)
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
 		}
 
 		if (!id)
-			return -ENOMEM;
+			return -EINVAL;
 
 		if (id->addr_cnt >= ADDR_CNT) {
 			pr_err("FAILED symbol %s crossed the number of allowed lists\n",
@@ -643,7 +672,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	/* For set, set8, id->id may be 0 */
-	if (!id->id && !id->is_set && !id->is_set8) {
+	if (!id->id && id->kind != BTF_ID_KIND_SET && id->kind != BTF_ID_KIND_SET8) {
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
 		warnings++;
 	}
@@ -696,6 +725,7 @@ static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
 	struct rb_node *next;
+	int cnt;
 
 	next = rb_first(&obj->sets);
 	while (next) {
@@ -715,11 +745,15 @@ static int sets_patch(struct object *obj)
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
@@ -744,10 +778,13 @@ static int sets_patch(struct object *obj)
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


