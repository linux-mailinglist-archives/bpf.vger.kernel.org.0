Return-Path: <bpf+bounces-76940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668CCC9E65
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0772C302B139
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE921E0BA;
	Thu, 18 Dec 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EoFcamE8"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92A1F419A
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018079; cv=none; b=pajlcedDr7GcE57J71m5Jny9K7bQ+w9cmd4XUsLTJdEg+1uMNw2ALW6UqPsIPyls+GY6StoGclJ0a1oFXYcbxAthbWhqg1xt8mJE1yDA/SETWcqmz2xFc1/KF/zI7FWpj5TICEQ7kQPzVDwrgNT13pn4kIQznMYA0Sa4kTfGtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018079; c=relaxed/simple;
	bh=fCzeRlRwpfwdq09pWsGHLhqwM7mghvwuHQkXLQgZaz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID6PuODem/u94Q2Hl01Nz51lCc5ScxoazDIkeA6gMZJapGqgERqSKShvAUqc+kOhc3db94VWGc+i2lXGiXFUk+JWmFsDmJiSPwEdo8GfoAAzUgjLMIiOu75qaylmaTthiJP1PH/FMZOu9y2y+Ccwk9+i4Pu4XlZAvcReTcKnWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EoFcamE8; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766018069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNMkP7myGF28jLiMw3I/zn3SrObaDjt5AceM881sM28=;
	b=EoFcamE8Ipj35vJ30E1NX8tCHwZbkWlifo6v7IBMFjNEeXkFbJIYHalT/Ud0oX2tcl2jyX
	lL/vnSsd4R+24cst7rT3N71fXTZjEK0+VbOXtGI/0DTpOB3Gq8Bbz5Dp2IN9Q6Qm7xyb3w
	p6uNptZuVl0M3MMJUMXX9+FIHQHc8Gs=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Vernet <void@manifault.com>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v4 3/8] resolve_btfids: Introduce enum btf_id_kind
Date: Wed, 17 Dec 2025 16:33:09 -0800
Message-ID: <20251218003314.260269-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-1-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
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
index b4caae1170dd..da8c7d127632 100644
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
 
+	id = name + prefixlen - 1;
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


