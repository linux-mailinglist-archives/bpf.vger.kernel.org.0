Return-Path: <bpf+bounces-21304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1D84B582
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E641C23E9C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9591AB813;
	Tue,  6 Feb 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRCahv4s"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159291AB811
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223587; cv=none; b=iSni50Z+ckBSu29AmjOLNxGRZA+pZR48NzcRshAX/hyrEsw8SoDRJlfoiXv6m/sQY+dz3nh4xHbSwvP1a2IibRdd5/8FHP6Pa93qMupKzYiI1/BSPKsrKbeCCAT4Xe8ay3Rn+eb1cMXH+5FEYIkaS7OeB3yE/JpfZvj+nYm2BPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223587; c=relaxed/simple;
	bh=w576WHi8go0XjsUmizF7K/ethUMHzLUMwSVkgRKNDMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNqxNRaZvLkyqrNvFbZyg5HVIfalNWIGiZjXO8RtVjKG7Q3zM5Pe9TTZiq9Zw9rlLYmOGhHpF8kYAbiTYh34SNGlMqUFMTtyiLd2ex5+tVFAkXShmD/EAJ0xFTdJ3cMy5Qtz27W9ZPbkBLki3X36dCEzRI80a4O035W/eG/zPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRCahv4s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707223584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyFVFD8BdjZIjhrMlL8+asG+VLdbCCtDngHmJkYWB7A=;
	b=GRCahv4sA+rpEl0msNLiD4l92vHwU4U/h1UrFPg1JWMNjgbOMx/OI/rE7B3oEgZ9A19dIu
	2YMdpQx6digAU8PcwTd5Pm0O8z+MXqfGHWcLDEjGAwd3QMtg+sh68xXTDShh0D6hEhJfV4
	EwAX3bdlTFMPllVAmIt1UmNoy7S9iKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-2d93b7-cPTW4Xu75IYn1HQ-1; Tue, 06 Feb 2024 07:46:21 -0500
X-MC-Unique: 2d93b7-cPTW4Xu75IYn1HQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFF31101FA2D;
	Tue,  6 Feb 2024 12:46:20 +0000 (UTC)
Received: from dhcph057.fit.vutbr.com (unknown [10.45.225.89])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 871221121312;
	Tue,  6 Feb 2024 12:46:17 +0000 (UTC)
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Manu Bretelle <chantr4@gmail.com>
Subject: [PATCH bpf-next v4 1/2] tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
Date: Tue,  6 Feb 2024 13:46:09 +0100
Message-ID: <ff7f062ddf6a00815fda3087957c4ce667f50532.1707223196.git.vmalik@redhat.com>
In-Reply-To: <cover.1707223196.git.vmalik@redhat.com>
References: <cover.1707223196.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
 tools/bpf/resolve_btfids/main.c | 35 ++++++++++++++++++++-------------
 tools/include/linux/btf_ids.h   |  9 +++++++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 27a23196d58e..32634f00abba 100644
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
@@ -649,19 +650,18 @@ static int cmp_id(const void *pa, const void *pb)
 static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
-	int *ptr = data->d_buf;
 	struct rb_node *next;
 
 	next = rb_first(&obj->sets);
 	while (next) {
-		unsigned long addr, idx;
+		struct btf_id_set8 *set8;
+		struct btf_id_set *set;
+		unsigned long addr, off;
 		struct btf_id *id;
-		int *base;
-		int cnt;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
-		idx  = addr - obj->efile.idlist_addr;
+		off = addr - obj->efile.idlist_addr;
 
 		/* sets are unique */
 		if (id->addr_cnt != 1) {
@@ -670,14 +670,21 @@ static int sets_patch(struct object *obj)
 			return -1;
 		}
 
-		idx = idx / sizeof(int);
-		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
-		cnt = ptr[idx];
+		if (id->is_set) {
+			set = data->d_buf + off;
+			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
+		} else {
+			set8 = data->d_buf + off;
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
+			 off, id->is_set ? set->cnt : set8->cnt, id->name);
 
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


