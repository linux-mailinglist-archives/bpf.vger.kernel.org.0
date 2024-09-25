Return-Path: <bpf+bounces-40324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABB898692F
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 00:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D85A1C23D1A
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 22:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B716C6B7;
	Wed, 25 Sep 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP3uzsJa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B15B0FC;
	Wed, 25 Sep 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303427; cv=none; b=tir6cgv0yDtDamdywfjmpHvC2dwomjgl5SLohvgwCn5Jru5Pa1wwqi7q2rouTvCIUxYGbeN4WAIlRWYHVT8lHlZsAEYIYOQBPaveFmxBY1v0QsOgAaVxPmf7C3HlAjSexrSSAzEiQgSJyWtWfCyUZrAbBtl1UUDNtpzfFLBuVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303427; c=relaxed/simple;
	bh=IZbnpYx7HLrnxLUhGSarNuN3sSbeCYpJAfQP4eedA0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX2FSvyV6UQrhx/OYHIorzaer9B1dgwJ8UNRT0WMDIB9/p/bdRTUhBLS6IlEOb07RLSmps4UqOBGoy6KvASyZGTQgc66AQui4/oKr8M4gBzGSHiwbcBPJRcv/xIn/qOHzs6ukHiUTW8yeYxNAQHJWbXtg5RhyoVg5METeYu/Utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP3uzsJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8CEC4CED0;
	Wed, 25 Sep 2024 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727303425;
	bh=IZbnpYx7HLrnxLUhGSarNuN3sSbeCYpJAfQP4eedA0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hP3uzsJaqEqSbMN7cXerNzoM3ytZTbTgvmYg9KxlAbUC1BGyI+422hsFAGVd87g0t
	 cDpwrOhWNY8UsLK/+XC0deTSKHwKUcsG8EttSMg6ER6dzJ94mtkN8L57W8ytbGzC+Y
	 KlJsOcoLrYvzifR4kKqaHRNWOr8IcpaS2mq6BMYmQzZcT5HR5X3cFs1alBeQlSNbdc
	 +KAVT4Vzj5Ef3dLH73ZZrsReLp4Xh2pFGsvK1DYEaqUSxqfiuf6trArB9ktUz/ITxA
	 oYx4Jo3yk1MFiV6icw6J3rmuc8+x4t14fYCwe4Z3cNeddfvknOVGXV+oqFAD8oGw2C
	 /rEPG0rwhjSkw==
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
	linux-mm@kvack.org
Subject: [RFC/PATCH bpf-next 1/3] bpf: Add slab iterator
Date: Wed, 25 Sep 2024 15:30:21 -0700
Message-ID: <20240925223023.735947-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925223023.735947-1-namhyung@kernel.org>
References: <20240925223023.735947-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new "slab" iterator will traverse the list of slab caches
(kmem_cache) and call attached BPF programs for each entry.  It should
check the argument (ctx.s) if it's NULL before using it.

The iteration will be done with slab_mutex held but it'd break and
return to user if the BPF program emits data to seq buffer more than
the buffer size given by the user.  IOW the whole iteration would be
protected by the slab_mutex as long as it won't emit anything.

It includes the internal "mm/slab.h" header to access kmem_cache,
slab_caches and slab_mutex.  Hope it's ok to mm folks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/btf_ids.h |   1 +
 kernel/bpf/Makefile     |   1 +
 kernel/bpf/slab_iter.c  | 131 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 kernel/bpf/slab_iter.c

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index c0e3e1426a82f5c4..1474ab7f44a9cff6 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -283,5 +283,6 @@ extern u32 btf_tracing_ids[];
 extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
 extern u32 btf_bpf_map_id[];
+extern u32 bpf_slab_btf_id[];
 
 #endif
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9b9c151b5c826b31..e18b09069349e1e9 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
+obj-$(CONFIG_BPF_SYSCALL) += slab_iter.o
diff --git a/kernel/bpf/slab_iter.c b/kernel/bpf/slab_iter.c
new file mode 100644
index 0000000000000000..bf1e50bd7497220e
--- /dev/null
+++ b/kernel/bpf/slab_iter.c
@@ -0,0 +1,131 @@
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
+struct bpf_iter__slab {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct kmem_cache *, s);
+};
+
+static void *slab_iter_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	loff_t cnt = 0;
+	struct kmem_cache *s = NULL;
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
+		if (cnt == *pos)
+			break;
+
+		cnt++;
+	}
+
+	if (cnt != *pos)
+		return NULL;
+
+	++*pos;
+	return s;
+}
+
+static void slab_iter_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_iter__slab ctx = {
+		.meta = &meta,
+		.s = v,
+	};
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, true);
+	if (prog)
+		bpf_iter_run_prog(prog, &ctx);
+
+	mutex_unlock(&slab_mutex);
+}
+
+static void *slab_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct kmem_cache *s = v;
+
+	++*pos;
+
+	if (list_last_entry(&slab_caches, struct kmem_cache, list) == s)
+		return NULL;
+
+	return list_next_entry(s, list);
+}
+
+static int slab_iter_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_iter__slab ctx = {
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
+static const struct seq_operations slab_iter_seq_ops = {
+	.start  = slab_iter_seq_start,
+	.next   = slab_iter_seq_next,
+	.stop   = slab_iter_seq_stop,
+	.show   = slab_iter_seq_show,
+};
+
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_slab_btf_id, struct, kmem_cache)
+
+static const struct bpf_iter_seq_info slab_iter_seq_info = {
+	.seq_ops		= &slab_iter_seq_ops,
+};
+
+static void bpf_iter_slab_show_fdinfo(const struct bpf_iter_aux_info *aux,
+				      struct seq_file *seq)
+{
+	seq_puts(seq, "slab iter\n");
+}
+
+DEFINE_BPF_ITER_FUNC(slab, struct bpf_iter_meta *meta,
+		     struct kmem_cache *s)
+
+static struct bpf_iter_reg bpf_slab_reg_info = {
+	.target			= "slab",
+	.feature		= BPF_ITER_RESCHED,
+	.show_fdinfo		= bpf_iter_slab_show_fdinfo,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__slab, s),
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
+	},
+	.seq_info		= &slab_iter_seq_info,
+};
+
+static int __init bpf_slab_iter_init(void)
+{
+	bpf_slab_reg_info.ctx_arg_info[0].btf_id = bpf_slab_btf_id[0];
+	return bpf_iter_reg_target(&bpf_slab_reg_info);
+}
+
+late_initcall(bpf_slab_iter_init);
-- 
2.46.0.792.g87dc391469-goog


