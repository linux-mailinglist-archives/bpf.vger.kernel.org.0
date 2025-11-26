Return-Path: <bpf+bounces-75526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9CC87B2F
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99ADA3B5B6F
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DD2FC034;
	Wed, 26 Nov 2025 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozOqoMmw"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B2FB99B
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120587; cv=none; b=UpCjZFJRBCTQvroBlOj5h+KWeVV0Gyw7cUjfkv0+ubABVUsabT4o8oBqysDh8R3xWQhRshNqq7//aLnbrLfvKqkrFeauOPKPsYtmvSl1hE1pnvEAHpE3xeHQQMSJ8PR95OWU8c17c2fChQSz7uOy0zVnxKJIIAO2IN/bRKBMm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120587; c=relaxed/simple;
	bh=xCvFs1xbcVN6h+Vy2tQsGp0ZQAuYsMF+spiFOaf/Irg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/A/G+e/uRv7f2hTOr+AfhKZQorm/ryw/cCoTLsCQ1zyCp6PTYF5Fpl1yaxXOLE+UWsfFHLhI4HRQDBdX/svT1ifewzNojodDDlJdU/x+yB5ymIhAddqjM10ivo+zzmhXRY9ArQ8Z2BOBN4X/GwVnx4Kj6yhwGeNRCMBqKt3khM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozOqoMmw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764120583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OxpVlu97uQOGmIsABXF9JpduqMEidWW+QhnLTm9npg=;
	b=ozOqoMmwYEy7W1BpWVntj+K2UBfM18cylAmrgcVy5bN2TCF+A6jmJZ/GfdoJ7MSxh5s7QG
	Mh3Ssvs5JU9yzDE+uTsJj1SHogTx+3YHwb39wkmPpJTn0cSEzn0+VpTZT91ip94Lo6GgMl
	ipeh+NywOo7JuYy7x6MWBJIYgxG2etE=
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
	Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH bpf-next v1 3/4] resolve_btfids: introduce enum btf_id_kind
Date: Tue, 25 Nov 2025 17:26:55 -0800
Message-ID: <20251126012656.3546071-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
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
 tools/bpf/resolve_btfids/main.c | 61 ++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index b7b44e72e765..7f5a9f7dde7f 100644
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
@@ -288,7 +301,10 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 		return NULL;
 	}
 
-	return btf_id__add(root, id, false);
+	btf_id = btf_id__add(root, id, false);
+	btf_id->kind = BTF_ID_KIND_SYM;
+
+	return btf_id;
 }
 
 /* Older libelf.h and glibc elf.h might not yet define the ELF compression types. */
@@ -491,28 +507,24 @@ static int symbols_collect(struct object *obj)
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
@@ -643,7 +655,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	/* For set, set8, id->id may be 0 */
-	if (!id->id && !id->is_set && !id->is_set8) {
+	if (!id->id && id->kind == BTF_ID_KIND_SYM) {
 		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
 		warnings++;
 	}
@@ -696,6 +708,7 @@ static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
 	struct rb_node *next;
+	int cnt;
 
 	next = rb_first(&obj->sets);
 	while (next) {
@@ -715,11 +728,15 @@ static int sets_patch(struct object *obj)
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
@@ -744,10 +761,14 @@ static int sets_patch(struct object *obj)
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


