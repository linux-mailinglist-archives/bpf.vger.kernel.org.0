Return-Path: <bpf+bounces-75657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC8C8FF31
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB2E4E6CDA
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6323016E4;
	Thu, 27 Nov 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ghYFeHis"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E33019BD
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764269616; cv=none; b=KraKkWhRPTgEgm8nN3Qra4419pKxUY+Wt1c+qeTUHbcy7asj+zwihnGIdh36s+Qy4oXQjUgWui++UxDqLIZsbuwaBbpZtnBEhGHIzoTgIdcy6He+acDl7lz8wqzfDhXE1ts9keLGx3rzdgIkG1U4/8wMICxnXKUaYHYr/hhbmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764269616; c=relaxed/simple;
	bh=j5XXpTzzdMx3lJGLdsHVgHP8craYMQ5WOsTTtqlKWns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avXdAJZBXapZKZqS7iFBjfKk2Q6xOPpIdvKNzymBC9WGhg+qCFWmLpKXRdrgEjb5eFJf7uVMf2E9xlP58NjEjLggrpcpmsVfpp7ccpaJf2ZBC+9/G5Q9TbwefOWt9aNqrGfV+Za47Jf+GfWqE7Hx3/HjkJRyDoFpg6gut/d+Zk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ghYFeHis; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764269612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmAGUFuRPKWCczXyIbvhxa8eaYDKpDkc1HqhWvoVOMI=;
	b=ghYFeHis+9VIIcviZuBskWl4tcsQ1HYmsLjxfi5DCplimNJw4uwiKJIQ9i5SM6oWAubzOQ
	3Od4CLymOR3b0kh4KScYonkmST/Jy58Nib4KjkB8sf08QNzgkOeUx9l5UUdoWhLS3RY2CU
	eyFVGPWfHqIY8UKqqUBDSLB7cA6gTyc=
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
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] resolve_btfids: introduce enum btf_id_kind
Date: Thu, 27 Nov 2025 10:52:41 -0800
Message-ID: <20251127185242.3954132-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
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
 tools/bpf/resolve_btfids/main.c | 62 ++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index b4caae1170dd..c60d303ca6ed 100644
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
-	int		 addr_cnt;
-	bool		 is_set;
-	bool		 is_set8;
+	enum btf_id_kind kind:8;
+	int		 addr_cnt:8;
 	Elf64_Addr	 addr[ADDR_CNT];
 };
 
@@ -260,26 +266,33 @@ static char *get_id(const char *prefix_end)
 	return id;
 }
 
-static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
+static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
 {
 	/*
 	 * __BTF_ID__set__name
 	 * name =    ^
 	 * id   =         ^
 	 */
-	char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
+	int prefixlen = kind == BTF_ID_KIND_SET8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__");
+	char *id = name + prefixlen - 1;
 	int len = strlen(name);
+	struct btf_id *btf_id;
 
 	if (id >= name + len) {
 		pr_err("FAILED to parse set name: %s\n", name);
 		return NULL;
 	}
 
-	return btf_id__add(&obj->sets, id, true);
+	btf_id = btf_id__add(&obj->sets, id, true);
+	if (btf_id)
+		btf_id->kind = kind;
+
+	return btf_id;
 }
 
 static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 {
+	struct btf_id *btf_id;
 	char *id;
 
 	id = get_id(name + size);
@@ -288,7 +301,11 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 		return NULL;
 	}
 
-	return btf_id__add(root, id, false);
+	btf_id = btf_id__add(root, id, false);
+	if (btf_id)
+		btf_id->kind = BTF_ID_KIND_SYM;
+
+	return btf_id;
 }
 
 /* Older libelf.h and glibc elf.h might not yet define the ELF compression types. */
@@ -491,28 +508,24 @@ static int symbols_collect(struct object *obj)
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
@@ -643,7 +656,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	/* For set, set8, id->id may be 0 */
-	if (!id->id && !id->is_set && !id->is_set8) {
+	if (!id->id && id->kind == BTF_ID_KIND_SYM) {
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
 		warnings++;
 	}
@@ -696,6 +709,7 @@ static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
 	struct rb_node *next;
+	int cnt;
 
 	next = rb_first(&obj->sets);
 	while (next) {
@@ -715,11 +729,15 @@ static int sets_patch(struct object *obj)
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
@@ -744,10 +762,14 @@ static int sets_patch(struct object *obj)
 						bswap_32(set8->pairs[i].flags);
 				}
 			}
+			break;
+		case BTF_ID_KIND_SYM:
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


