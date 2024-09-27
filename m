Return-Path: <bpf+bounces-40430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221DE988A3E
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF52B22305
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82FA1C2332;
	Fri, 27 Sep 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/xmwgNC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2C1C231E;
	Fri, 27 Sep 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727462498; cv=none; b=KMJZ9GijPBKkDPrSi5tOeIx3NGaTVlewlyc0uxXgYwCz2j1Mvfh5vi9kOZovfuhnRlc56D57tO7refLDtieH8/PjhAnQ24oGLdagOP8ZWt2tAG7Tt8sRQLi4JNOsl9tfRFMYkgQfDqD5v+W6FBP+c9rIc+k27w1u034T3AR1mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727462498; c=relaxed/simple;
	bh=aGXxmsEp/uzql1BOkNU+QldkkvWzmazSesv6pu9JlCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfD7fl0xB4Yzg7c/tt9MWoet5EfTJE6mfYdfOoNpBNHS3WxaeBy0xuzVa1uZXT6Z/6MkyRxiQB7i8RgYhZqYKWTR79R7Df+5UeLAqtJilxOEJwvWHBx2UM/MSxtBDt3FoQB4/ROcNpVzZ96HgUMwxkQN/FzNTUDxEo3k3x2oH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/xmwgNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1612C4CED9;
	Fri, 27 Sep 2024 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727462497;
	bh=aGXxmsEp/uzql1BOkNU+QldkkvWzmazSesv6pu9JlCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/xmwgNC9gCQMLx3EopU51gjZjDEszjSx7m0YzwM9dxl9jGiQIfZfu7fXfcf2beZz
	 d/SmetuGMSmmNIkLuEdEl53xnFkV5+JkvmJD79VTWBih+Z720cMEeOFnbFQ21+Gb5M
	 ZbMqLldLREXQzUUeKjYRGs5aEqw86o+UBP2TIqbLSO80yAV65emdDN7Tiy3gkHXRcP
	 fRxziCdTpjXwWpzBaEGpvJiZt+d5v3MoGa6drDAMezJzaQg9D8YiepRoq7StCxX3ZO
	 +2ATJyOcO4sK/7+bL5IhOebBEP3qkQwwSS7I8sIMgi9HAlDmMxpDg5ZdIRXCzsrOEi
	 pYWhKpTE5LbEA==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Date: Fri, 27 Sep 2024 11:41:32 -0700
Message-ID: <20240927184133.968283-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240927184133.968283-1-namhyung@kernel.org>
References: <20240927184133.968283-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_get_kmem_cache() is to get a slab cache information from a
virtual address like virt_to_cache().  If the address is a pointer
to a slab object, it'd return a valid kmem_cache pointer, otherwise
NULL is returned.

It doesn't grab a reference count of the kmem_cache so the caller is
responsible to manage the access.  The intended use case for now is to
symbolize locks in slab objects from the lock contention tracepoints.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/bpf/helpers.c |  1 +
 mm/slab_common.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab286c26..bbc5800ec3afc899 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7443244656150325..e648b05a635b94bf 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1322,6 +1322,22 @@ size_t ksize(const void *objp)
 }
 EXPORT_SYMBOL(ksize);
 
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/btf.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
+{
+	struct slab *slab;
+
+	slab = virt_to_slab((void *)(long)addr);
+	return slab ? slab->slab_cache : NULL;
+}
+
+__bpf_kfunc_end_defs();
+#endif /* CONFIG_BPF_SYSCALL */
+
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-- 
2.46.1.824.gd892dcdcdd-goog


