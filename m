Return-Path: <bpf+bounces-43023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85E9ADE23
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55796283005
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAF91AB530;
	Thu, 24 Oct 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciHCbXKO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB9171E6E;
	Thu, 24 Oct 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756097; cv=none; b=KNkRbvcgouq9ijn/FqN8Lfdg+Zv5UQ+KaCzXVisILqxR8/jwdpATC6xoZl5lZvyLBzcc3C4EmeimGHdydwmYJrwyc0WsX5dWESj9cKOaEJf8UKDqTqCLFEbmKj73XdiYdoJmv2dzP3tcA5157fHd4Whdzh4G7uq5oThOD1WOzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756097; c=relaxed/simple;
	bh=Uwe0jVobKIKamY27y1nMKy0mrRAseQCvrFz6/ckVHmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaBDzpozIPeLU2fcnu26iKKMtwZ2XD+0PEZ8LHLJy7dwTfwlSEYlBP1I0XmMxQuO2l493hs9Ihcbiqroyrn26ynNP5RdIhOljnYPV0TC6THTH+B+HXQjTz8oj1gXL+UEfG8pFm5iT/Fm34zsKFM5if64j5m7pjxfiOaCCDDVqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciHCbXKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40702C4CECC;
	Thu, 24 Oct 2024 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729756097;
	bh=Uwe0jVobKIKamY27y1nMKy0mrRAseQCvrFz6/ckVHmc=;
	h=From:To:Cc:Subject:Date:From;
	b=ciHCbXKOIYP1Me1h7W/WxW4ObhwCbsNFjfdXFbt4J6Qg3j28abMdGmRFXRvhhysO1
	 zuI1YzZm5TZpd3o32F0UBzexA+fBj+5+Ro1NEH0EHCL5XXATVMDZtcxQCwgSvSIOf5
	 EQBbhkw585/wb5SMhvuPhxWubHOLEfH/q6IwrJL+L6ze5Q15AemFtcKX+rKbodUuCn
	 c4XQg9lxCc/0yKiMXk7/56JJ4r4HJoQGK9LrrZgULUjdiEBB0AQUnZ7/yE71CCiuNK
	 qb7ZaTMhxOLMSAHjiNsfsr5Vm2rw8VmqhWsjZOykPw2UCi3pXFWL1r7XjUf832jRDG
	 vpXyFN5pB5TTw==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 bpf-next 1/2] bpf: Add open coded version of kmem_cache iterator
Date: Thu, 24 Oct 2024 00:48:14 -0700
Message-ID: <20241024074815.1255066-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new open coded iterator for kmem_cache which can be called from a
BPF program like below.  It doesn't take any argument and traverses all
kmem_cache entries.

  struct kmem_cache *pos;

  bpf_for_each(kmem_cache, pos) {
      ...
  }

As it needs to grab slab_mutex, it should be called from sleepable BPF
programs only.

Also update the existing iterator code to use the open coded version
internally as suggested by Andrii.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2)
 * prevent restart after the last element  (Martin)
 * update existing code to use the open coded version (Andrii)

 kernel/bpf/helpers.c         |   3 +
 kernel/bpf/kmem_cache_iter.c | 151 +++++++++++++++++++++++++----------
 2 files changed, 110 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5c3fdb29c1b1fe53..ddddb060835bac4b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3112,6 +3112,9 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
index ebc101d7da51b57c..3ae2158d767f4526 100644
--- a/kernel/bpf/kmem_cache_iter.c
+++ b/kernel/bpf/kmem_cache_iter.c
@@ -8,16 +8,116 @@
 
 #include "../../mm/slab.h" /* kmem_cache, slab_caches and slab_mutex */
 
+/* open-coded version */
+struct bpf_iter_kmem_cache {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_kmem_cache_kern {
+	struct kmem_cache *pos;
+} __attribute__((aligned(8)));
+
+#define KMEM_CACHE_POS_START  ((void *)1L)
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it)
+{
+	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	kit->pos = KMEM_CACHE_POS_START;
+	return 0;
+}
+
+__bpf_kfunc struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it)
+{
+	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
+	struct kmem_cache *prev = kit->pos;
+	struct kmem_cache *next;
+	bool destroy = false;
+
+	if (!prev)
+		return NULL;
+
+	mutex_lock(&slab_mutex);
+
+	if (list_empty(&slab_caches)) {
+		mutex_unlock(&slab_mutex);
+		return NULL;
+	}
+
+	if (prev == KMEM_CACHE_POS_START)
+		next = list_first_entry(&slab_caches, struct kmem_cache, list);
+	else if (list_last_entry(&slab_caches, struct kmem_cache, list) == prev)
+		next = NULL;
+	else
+		next = list_next_entry(prev, list);
+
+	/* boot_caches have negative refcount, don't touch them */
+	if (next && next->refcount > 0)
+		next->refcount++;
+
+	/* Skip kmem_cache_destroy() for active entries */
+	if (prev && prev != KMEM_CACHE_POS_START) {
+		if (prev->refcount > 1)
+			prev->refcount--;
+		else if (prev->refcount == 1)
+			destroy = true;
+	}
+
+	mutex_unlock(&slab_mutex);
+
+	if (destroy)
+		kmem_cache_destroy(prev);
+
+	kit->pos = next;
+	return next;
+}
+
+__bpf_kfunc void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it)
+{
+	struct bpf_iter_kmem_cache_kern *kit = (void *)it;
+	struct kmem_cache *s = kit->pos;
+	bool destroy = false;
+
+	if (s == NULL || s == KMEM_CACHE_POS_START)
+		return;
+
+	mutex_lock(&slab_mutex);
+
+	/* Skip kmem_cache_destroy() for active entries */
+	if (s->refcount > 1)
+		s->refcount--;
+	else if (s->refcount == 1)
+		destroy = true;
+
+	mutex_unlock(&slab_mutex);
+
+	if (destroy)
+		kmem_cache_destroy(s);
+}
+
+__bpf_kfunc_end_defs();
+
 struct bpf_iter__kmem_cache {
 	__bpf_md_ptr(struct bpf_iter_meta *, meta);
 	__bpf_md_ptr(struct kmem_cache *, s);
 };
 
+union kmem_cache_iter_priv {
+	struct bpf_iter_kmem_cache it;
+	struct bpf_iter_kmem_cache_kern kit;
+};
+
 static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	loff_t cnt = 0;
 	bool found = false;
 	struct kmem_cache *s;
+	union kmem_cache_iter_priv *p = seq->private;
 
 	mutex_lock(&slab_mutex);
 
@@ -43,8 +143,9 @@ static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos)
 	mutex_unlock(&slab_mutex);
 
 	if (!found)
-		return NULL;
+		s = NULL;
 
+	p->kit.pos = s;
 	return s;
 }
 
@@ -55,63 +156,24 @@ static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
 		.meta = &meta,
 		.s = v,
 	};
+	union kmem_cache_iter_priv *p = seq->private;
 	struct bpf_prog *prog;
-	bool destroy = false;
 
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, true);
 	if (prog && !ctx.s)
 		bpf_iter_run_prog(prog, &ctx);
 
-	if (ctx.s == NULL)
-		return;
-
-	mutex_lock(&slab_mutex);
-
-	/* Skip kmem_cache_destroy() for active entries */
-	if (ctx.s->refcount > 1)
-		ctx.s->refcount--;
-	else if (ctx.s->refcount == 1)
-		destroy = true;
-
-	mutex_unlock(&slab_mutex);
-
-	if (destroy)
-		kmem_cache_destroy(ctx.s);
+	bpf_iter_kmem_cache_destroy(&p->it);
 }
 
 static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct kmem_cache *s = v;
-	struct kmem_cache *next = NULL;
-	bool destroy = false;
+	union kmem_cache_iter_priv *p = seq->private;
 
 	++*pos;
 
-	mutex_lock(&slab_mutex);
-
-	if (list_last_entry(&slab_caches, struct kmem_cache, list) != s) {
-		next = list_next_entry(s, list);
-
-		WARN_ON_ONCE(next->refcount == 0);
-
-		/* boot_caches have negative refcount, don't touch them */
-		if (next->refcount > 0)
-			next->refcount++;
-	}
-
-	/* Skip kmem_cache_destroy() for active entries */
-	if (s->refcount > 1)
-		s->refcount--;
-	else if (s->refcount == 1)
-		destroy = true;
-
-	mutex_unlock(&slab_mutex);
-
-	if (destroy)
-		kmem_cache_destroy(s);
-
-	return next;
+	return bpf_iter_kmem_cache_next(&p->it);
 }
 
 static int kmem_cache_iter_seq_show(struct seq_file *seq, void *v)
@@ -143,6 +205,7 @@ BTF_ID_LIST_GLOBAL_SINGLE(bpf_kmem_cache_btf_id, struct, kmem_cache)
 
 static const struct bpf_iter_seq_info kmem_cache_iter_seq_info = {
 	.seq_ops		= &kmem_cache_iter_seq_ops,
+	.seq_priv_size		= sizeof(union kmem_cache_iter_priv),
 };
 
 static void bpf_iter_kmem_cache_show_fdinfo(const struct bpf_iter_aux_info *aux,
-- 
2.47.0.105.g07ac214952-goog


