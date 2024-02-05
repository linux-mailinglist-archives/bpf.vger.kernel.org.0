Return-Path: <bpf+bounces-21241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCF184A28D
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70601F23644
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D102481A2;
	Mon,  5 Feb 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avnQT46U"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6745034
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158380; cv=none; b=DUPIU/f4Ebc6fvXaM1+Ax8D0EuEAshpCnzpNdjKCC1A2M4wpS/3Cm7BMdUiitmuoppetz/3Y9LPRx4gSVbmtbKPZbG5Qfdgu66hN01/kf29VzQoYOfAopDk7uMFDgdNZVtiVjWNz3PPcH2JHw9GA2MaPItrRuy29YtILLGq28Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158380; c=relaxed/simple;
	bh=0Azj6oT4pHRBTfd8Ulm7NwL3tDSi2UlIB+HrKaeA/MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vzsy9+t1Jnby42dF3sv4OICQipzr6Jxc3z8+DwylmXy6Qerm7Dc/llXCtYANYAck0FcaD7bvum2qz7qN/KKML1UxOD0QSc+nPGgNN6p+vkKA1kxihn2++L6CsM22dSq8/QoRqT6L+2xRqyRDepst3eJaasHZk0YDZzrF+zNEURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avnQT46U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707158378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pnWgxLP75dv+KKvngPKPjALIKVQc3BW0agScjA5zKo=;
	b=avnQT46U1c4Arex8huGXFLw0Fn7xHbd0uF3QnJvV0ZzXxboa08P2g9eAhHEb0nwO+xOKrS
	iYqZM+B0Axi3vtiXjKuOv/WkxQTVwlW1ECZDl5w73c+CBn1RmSjNXf/o852ImpYjyb5C0U
	vHiKc8V5rX4loUBZkC89Gq0HNva1D8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-abxdC-vDOLufWGCoaABLDg-1; Mon, 05 Feb 2024 13:39:35 -0500
X-MC-Unique: abxdC-vDOLufWGCoaABLDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09576869EC0;
	Mon,  5 Feb 2024 18:39:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.202])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 640702026D66;
	Mon,  5 Feb 2024 18:39:30 +0000 (UTC)
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
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Manu Bretelle <chantr4@gmail.com>
Subject: [PATCH bpf-next v3 1/2] tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
Date: Mon,  5 Feb 2024 19:39:22 +0100
Message-ID: <8e84b14c36d2a855071edfb9121787e7f0f0ddca.1707157553.git.vmalik@redhat.com>
In-Reply-To: <cover.1707157553.git.vmalik@redhat.com>
References: <cover.1707157553.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

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
 tools/bpf/resolve_btfids/main.c | 29 +++++++++++++++++++----------
 tools/include/linux/btf_ids.h   |  9 +++++++++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 27a23196d58e..9ffe8163081a 100644
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
@@ -654,10 +655,10 @@ static int sets_patch(struct object *obj)
 
 	next = rb_first(&obj->sets);
 	while (next) {
+		struct btf_id_set8 *set8;
+		struct btf_id_set *set;
 		unsigned long addr, idx;
 		struct btf_id *id;
-		int *base;
-		int cnt;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
@@ -671,13 +672,21 @@ static int sets_patch(struct object *obj)
 		}
 
 		idx = idx / sizeof(int);
-		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
-		cnt = ptr[idx];
+		if (id->is_set) {
+			set = (struct btf_id_set *)&ptr[idx];
+			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
+		} else {
+			set8 = (struct btf_id_set8 *)&ptr[idx];
+			/*
+			 * Make sure id is at the beginning of the pairs
+			 * struct, otherwise the below qsort would not work.
+			 */
+			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
+			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
+		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-			 (idx + 1) * sizeof(int), cnt, id->name);
-
-		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
+			 (idx + 1) * sizeof(int), id->is_set ? set->cnt : set8->cnt, id->name);
 
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


