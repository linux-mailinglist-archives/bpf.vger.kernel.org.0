Return-Path: <bpf+bounces-41665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872BA9995B9
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57E2839C0
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE61E7C34;
	Thu, 10 Oct 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diCbxJ1V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063B1E7C0E;
	Thu, 10 Oct 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602708; cv=none; b=fF3ZUIgSMA27m6AktXnSbxIdl06fR2AZT6jOSvmrVz+lmkpYe1uzp0bgplZTsw1brt58mBYs8dLUeMo14U1MbX4+Ce2DqKCVxO0HYCma0YsUeD7gcvByNgW9P+WGWlkuRBM68r3HHXxyIrJBMytFGbsMwMa9ExrgmWEagk8ovhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602708; c=relaxed/simple;
	bh=qwr7dD1YMBw5Ph7vaygJ/ovjODa5iDddCD/l90SK30g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+bFUQRikA5+JOSNmC19s8fI5WacMC96vtVFL/0DLEwRSRMca3ONkOnVXSdJpeIRaHhbZTlaDwh10h4FiZ7+FB2Xq8MENQv9uAxHEElV3u+lJOqdMFZ1RMWalh0CdntjrHp6EzjE/JDTAEFP/7gHhR0A4fL28E6x6Z9lkJgA4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diCbxJ1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5BDC4CED1;
	Thu, 10 Oct 2024 23:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728602708;
	bh=qwr7dD1YMBw5Ph7vaygJ/ovjODa5iDddCD/l90SK30g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diCbxJ1VXjr7niALk+JJ9UkjhhtqbN2rskMmlYxFM/dazCKZtrvQLMHnp2MtoCxWM
	 xfPLdR8d3QYjj2YVpEf1v3jrOY9sv6YV/Bf1LAf58Qap8JNuQEokJX0BuJMf1D0H5H
	 xptQ7M2FOVg/6mPUkWJzrg32HcdwAdSlFYq62rIPL2621ftJ/0/EgDYgiRq6sNTXZ5
	 HLQrj654wA68XLE3Lv4Z8zXeOFrF22J63Wn//nIaI6pFnXQB7KpA/O8VKaNWWWQfHF
	 bE/hkHGZf+waYurr4ytGDdcGzZZ2uNzaPCWhyyCN9IdcRfTTH3i3x1X3Fw96akpxmF
	 yVkwUmSAotEiQ==
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
	Kees Cook <kees@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v5 bpf-next 1/3] bpf: Add kmem_cache iterator
Date: Thu, 10 Oct 2024 16:25:03 -0700
Message-ID: <20241010232505.1339892-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241010232505.1339892-1-namhyung@kernel.org>
References: <20241010232505.1339892-1-namhyung@kernel.org>
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
 include/linux/btf_ids.h      |   1 +
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/kmem_cache_iter.c | 175 +++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
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
index 0000000000000000..2de0682c6d4c773f
--- /dev/null
+++ b/kernel/bpf/kmem_cache_iter.c
@@ -0,0 +1,175 @@
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
+	/* Find an entry at the given position in the slab_caches list instead
+	 * of keeping a reference (of the last visited entry, if any) out of
+	 * slab_mutex. It might miss something if one is deleted in the middle
+	 * while it releases the lock.  But it should be rare and there's not
+	 * much we can do about it.
+	 */
+	list_for_each_entry(s, &slab_caches, list) {
+		if (cnt == *pos) {
+			/* Make sure this entry remains in the list by getting
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
+	if (prog && !ctx.s)
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
+
+		WARN_ON_ONCE(next->refcount == 0);
+
+		/* boot_caches have negative refcount, don't touch them */
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
+		  PTR_TO_BTF_ID_OR_NULL | PTR_UNTRUSTED },
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
2.47.0.rc1.288.g06298d1525-goog


