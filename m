Return-Path: <bpf+bounces-40781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063798E212
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79809B22018
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE91D1F6D;
	Wed,  2 Oct 2024 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFiiyiX1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198551D1F5A;
	Wed,  2 Oct 2024 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892599; cv=none; b=KGscHtiGPsWl+KBxQnGCwNwRzBscBx1PmmVPIBeSWo+Jklg4PgiTQTEhjzr8ZfIPx64ckCSaiGrZBQHlHxfqpMD+8VwLpvB5ZKQkASHVq/LFMlYtnuHOPjehwFLK7IIJf+DUY55pYbGEYDYflO3766tJJc9rwpCG61z4WKFxyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892599; c=relaxed/simple;
	bh=OspFckh9hcfNpQfmco31YwmJgcBtSOdPnDKdNDPKD04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2fjtkvg3BDAItMckvjGii1iJkhSPp9JWg3RjA9xRcn4FQbc+96XcTxr4ClV2wBbznaIipz3QvkL1QvlMRTL673AkQJBbA67Y58c0ve51vcS3nQn/2BHmluyVwiX+YQ9ziXUPDAYCOvVGUnf2UG4GZfq1Ur/dVivW7NckV1tsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFiiyiX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F97C4CED3;
	Wed,  2 Oct 2024 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727892598;
	bh=OspFckh9hcfNpQfmco31YwmJgcBtSOdPnDKdNDPKD04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFiiyiX1K3U6QE/qWPMNufn3ufF9eAQ7QU8VWg84F7VQkXI9sYF+Dqgx0QhzilOkB
	 yKEGYNBagzW52NB8dTcBOGGkaTx1puduS09f3KE4sAdGUdNtSXCIUWmib1raJAZyjs
	 yxSYo9a3zhUKsvt7TSFzKe5/+1EbgsEy1cO36RLt1LGeZRwgtstndGxlAya9ZGoi4a
	 xz62UNP+TEuOIQvLMVI3y7sYrIScLSIdirJIX2XXnwew/9qXIJrQ8VPDzH9x7b+nJh
	 YI5pWUHU5FY8r5qJIdNL7XImWGm8MKS+5tNxxwiemvHN9G4khA8pQPFUMqZBQP3PnK
	 10Hbz3ixnpkXg==
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
Subject: [PATCH v4 bpf-next 1/3] bpf: Add kmem_cache iterator
Date: Wed,  2 Oct 2024 11:09:54 -0700
Message-ID: <20241002180956.1781008-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002180956.1781008-1-namhyung@kernel.org>
References: <20241002180956.1781008-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new "kmem_cache" iterator will traverse the list of slab caches
and call attached BPF programs for each entry.  It should check the
argument (ctx.s) if it's NULL before using it.

Now the iteration grabs the slab_mutex only if it traverse the list and
releases the mutex when it runs the BPF program.  The kmem_cache entry
is protected by a refcount during the execution.

It includes the internal "mm/slab.h" header to access kmem_cache,
slab_caches and slab_mutex.  Hope it's ok to mm folks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
I've removed the Acked-by's from Roman and Vlastimil since it's changed
not to hold the slab_mutex and to manage the refcount.  Please review
this change again!

 include/linux/btf_ids.h      |   1 +
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/kmem_cache_iter.c | 174 +++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 kernel/bpf/kmem_cache_iter.c

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index c0e3e1426a82f5c4..139bdececdcfaefb 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -283,5 +283,6 @@ extern u32 btf_tracing_ids[];
 extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
 extern u32 btf_bpf_map_id[];
+extern u32 bpf_kmem_cache_btf_id[];
 
 #endif
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9b9c151b5c826b31..105328f0b9c04e37 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
+obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
diff --git a/kernel/bpf/kmem_cache_iter.c b/kernel/bpf/kmem_cache_iter.c
new file mode 100644
index 0000000000000000..e103d25175126ab0
--- /dev/null
+++ b/kernel/bpf/kmem_cache_iter.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Google */
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+
+#include "../../mm/slab.h" /* kmem_cache, slab_caches and slab_mutex */
+
+struct bpf_iter__kmem_cache {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct kmem_cache *, s);
+};
+
+static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t cnt = 0;
+	bool found = false;
+	struct kmem_cache *s;
+
+	mutex_lock(&slab_mutex);
+
+	/*
+	 * Find an entry at the given position in the slab_caches list instead
+	 * of keeping a reference (of the last visited entry, if any) out of
+	 * slab_mutex. It might miss something if one is deleted in the middle
+	 * while it releases the lock.  But it should be rare and there's not
+	 * much we can do about it.
+	 */
+	list_for_each_entry(s, &slab_caches, list) {
+		if (cnt == *pos) {
+			/*
+			 * Make sure this entry remains in the list by getting
+			 * a new reference count.  Note that boot_cache entries
+			 * have a negative refcount, so don't touch them.
+			 */
+			if (s->refcount > 0)
+				s->refcount++;
+			found = true;
+			break;
+		}
+		cnt++;
+	}
+	mutex_unlock(&slab_mutex);
+
+	if (!found)
+		return NULL;
+
+	++*pos;
+	return s;
+}
+
+static void kmem_cache_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_iter__kmem_cache ctx = {
+		.meta = &meta,
+		.s = v,
+	};
+	struct bpf_prog *prog;
+	bool destroy = false;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, true);
+	if (prog)
+		bpf_iter_run_prog(prog, &ctx);
+
+	if (ctx.s == NULL)
+		return;
+
+	mutex_lock(&slab_mutex);
+
+	/* Skip kmem_cache_destroy() for active entries */
+	if (ctx.s->refcount > 1)
+		ctx.s->refcount--;
+	else if (ctx.s->refcount == 1)
+		destroy = true;
+
+	mutex_unlock(&slab_mutex);
+
+	if (destroy)
+		kmem_cache_destroy(ctx.s);
+}
+
+static void *kmem_cache_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct kmem_cache *s = v;
+	struct kmem_cache *next = NULL;
+	bool destroy = false;
+
+	++*pos;
+
+	mutex_lock(&slab_mutex);
+
+	if (list_last_entry(&slab_caches, struct kmem_cache, list) != s) {
+		next = list_next_entry(s, list);
+		if (next->refcount > 0)
+			next->refcount++;
+	}
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
+
+	return next;
+}
+
+static int kmem_cache_iter_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_iter__kmem_cache ctx = {
+		.meta = &meta,
+		.s = v,
+	};
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (prog)
+		ret = bpf_iter_run_prog(prog, &ctx);
+
+	return ret;
+}
+
+static const struct seq_operations kmem_cache_iter_seq_ops = {
+	.start  = kmem_cache_iter_seq_start,
+	.next   = kmem_cache_iter_seq_next,
+	.stop   = kmem_cache_iter_seq_stop,
+	.show   = kmem_cache_iter_seq_show,
+};
+
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_kmem_cache_btf_id, struct, kmem_cache)
+
+static const struct bpf_iter_seq_info kmem_cache_iter_seq_info = {
+	.seq_ops		= &kmem_cache_iter_seq_ops,
+};
+
+static void bpf_iter_kmem_cache_show_fdinfo(const struct bpf_iter_aux_info *aux,
+					    struct seq_file *seq)
+{
+	seq_puts(seq, "kmem_cache iter\n");
+}
+
+DEFINE_BPF_ITER_FUNC(kmem_cache, struct bpf_iter_meta *meta,
+		     struct kmem_cache *s)
+
+static struct bpf_iter_reg bpf_kmem_cache_reg_info = {
+	.target			= "kmem_cache",
+	.feature		= BPF_ITER_RESCHED,
+	.show_fdinfo		= bpf_iter_kmem_cache_show_fdinfo,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__kmem_cache, s),
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
+	},
+	.seq_info		= &kmem_cache_iter_seq_info,
+};
+
+static int __init bpf_kmem_cache_iter_init(void)
+{
+	bpf_kmem_cache_reg_info.ctx_arg_info[0].btf_id = bpf_kmem_cache_btf_id[0];
+	return bpf_iter_reg_target(&bpf_kmem_cache_reg_info);
+}
+
+late_initcall(bpf_kmem_cache_iter_init);
-- 
2.46.1.824.gd892dcdcdd-goog


