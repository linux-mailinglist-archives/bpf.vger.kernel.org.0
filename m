Return-Path: <bpf+bounces-20839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164C844404
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF501F27CD7
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CA12BE8F;
	Wed, 31 Jan 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6bAzg8V"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7B84A40
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718268; cv=none; b=HZ/qgzgKMKsdjjsCxjJEp9cfzcUuZLt2egOUMKWD1mgBdbfh+oLYcUbMLzcitBj8Rf0WThWHfoqN6McmBlE4rSZFDt4CF9xnIbWzuaCY/ouq5niU3HCIwYw61TSpumkHkqOnn2ZJa+bBW8pIgk64Gbc04EyzVmAX/v0ZgcREokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718268; c=relaxed/simple;
	bh=WinTrrlC4/GcSuXn2q0cAw3EimWP+99bLz/XYfuAXoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g93BMKnBvPt2IdJtD2bUZzqxTaT+NgtnUHrRNMe4yowbZUfyef8HUGO4Ar6JCFYFoQMj7xzqAEVclQKhBceYO+06h+AwSh/K16z4BlV34UmPLMGFuRYCAzFebYdLtmm2LvBDny+53iatlyx/cIL8lfKbOW9mTkXTk6UA45IEgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6bAzg8V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706718266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oRoWVQWFZYQ6J6FgCQdZGyUGKarniIKRX4pS+stIi9Y=;
	b=Z6bAzg8VXhIxNR/JDHEq/BgeBctMwB9pZmN8yEKAwO81w0ljYY1iP70cSZMB42Om2PXCsw
	aQQ9DwZoVQ0kHUozSL6TPC5WUPBY1SdyoESIIYnVhkfGQUjjYdFtI8oyGuOjsAEf62MtPL
	NHkRsC5GrRXA8ot/M77ZA3tYkJ3EqOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-WCOl-z1wNtCTW3kux31nrQ-1; Wed, 31 Jan 2024 11:24:21 -0500
X-MC-Unique: WCOl-z1wNtCTW3kux31nrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45CB983FC24;
	Wed, 31 Jan 2024 16:24:20 +0000 (UTC)
Received: from dhcpf210.fit.vutbr.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 178741C060AF;
	Wed, 31 Jan 2024 16:24:16 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 1/2] tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
Date: Wed, 31 Jan 2024 17:24:08 +0100
Message-ID: <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>
In-Reply-To: <cover.1706717857.git.vmalik@redhat.com>
References: <cover.1706717857.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Instead of using magic offsets to access BTF ID set data, leverage types
from btf_ids.h (btf_id_set and btf_id_set8) which define the actual
layout of the data. Thanks to this change, set sorting should also
continue working if the layout changes.

This requires to sync the definition of 'struct btf_id_set8' from
include/linux/btf_ids.h to tools/include/linux/btf_ids.h. We don't sync
the rest of the file at the moment, b/c that would require to also sync
multiple dependent headers and we don't need any other defs from
btf_ids.h.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/bpf/resolve_btfids/main.c | 30 ++++++++++++++++++++++--------
 tools/include/linux/btf_ids.h   |  9 +++++++++
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 27a23196d58e..7badf1557e5c 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -70,6 +70,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <linux/btf_ids.h>
 #include <linux/rbtree.h>
 #include <linux/zalloc.h>
 #include <linux/err.h>
@@ -78,7 +79,7 @@
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
-#define BTF_ID		"__BTF_ID__"
+#define BTF_ID_PREFIX	"__BTF_ID__"
 
 #define BTF_STRUCT	"struct"
 #define BTF_UNION	"union"
@@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
 
 static bool is_btf_id(const char *name)
 {
-	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
+	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
 }
 
 static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
@@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
 		 * __BTF_ID__TYPE__vfs_truncate__0
 		 * prefix =  ^
 		 */
-		prefix = name + sizeof(BTF_ID) - 1;
+		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
 
 		/* struct */
 		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
@@ -656,8 +657,8 @@ static int sets_patch(struct object *obj)
 	while (next) {
 		unsigned long addr, idx;
 		struct btf_id *id;
-		int *base;
-		int cnt;
+		void *base;
+		int cnt, size;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
@@ -671,13 +672,26 @@ static int sets_patch(struct object *obj)
 		}
 
 		idx = idx / sizeof(int);
-		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
-		cnt = ptr[idx];
+		if (id->is_set) {
+			struct btf_id_set *set;
+
+			set = (struct btf_id_set *)&ptr[idx];
+			base = set->ids;
+			cnt = set->cnt;
+			size = sizeof(set->ids[0]);
+		} else {
+			struct btf_id_set8 *set8;
+
+			set8 = (struct btf_id_set8 *)&ptr[idx];
+			base = set8->pairs;
+			cnt = set8->cnt;
+			size = sizeof(set8->pairs[0]);
+		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
 			 (idx + 1) * sizeof(int), cnt, id->name);
 
-		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
+		qsort(base, cnt, size, cmp_id);
 
 		next = rb_next(next);
 	}
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 2f882d5cb30f..72535f00572f 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -8,6 +8,15 @@ struct btf_id_set {
 	u32 ids[];
 };
 
+struct btf_id_set8 {
+	u32 cnt;
+	u32 flags;
+	struct {
+		u32 id;
+		u32 flags;
+	} pairs[];
+};
+
 #ifdef CONFIG_DEBUG_INFO_BTF
 
 #include <linux/compiler.h> /* for __PASTE */
-- 
2.43.0


