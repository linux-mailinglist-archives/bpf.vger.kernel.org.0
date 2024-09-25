Return-Path: <bpf+bounces-40325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B5986930
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 00:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA711F21193
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2E170A01;
	Wed, 25 Sep 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1oejC7+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F715B12F;
	Wed, 25 Sep 2024 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303427; cv=none; b=KurqLeyKeAR+OvUEIwfILKC4++H94i5ZjT1Fz7CQLBkPY1PqdULok57EZ1eEAxUdZBu7BX9Y12noubvRSXuGNoeX5HxEiSq/CmHLHa4TrYUHNK6zlcpDic9NXXPujYcOa37zHINdY48sgWF76ULGfdtatg1tdoP5dHD2IM+VCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303427; c=relaxed/simple;
	bh=p9xJJCK3sjdnEPQSrpwEL4Bd6PM0VmkqDDJfyawq95E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBMDvtaYWbtG4ce7wOthqTcuwplVE8so1sLT6M8izkswA2W7dtmw6x17mlwrlB4xTI0mGN5NmZ6JId1yweHNkDfXSiXk3vO5atX1Q3bnbBAudWYR+BkNh6tKq/n3FKZAN+Ja9r5NHHd5XvxLpuqLKHJrz9dlPEnDQFPZpzD2BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1oejC7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91D4C4AF0D;
	Wed, 25 Sep 2024 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727303426;
	bh=p9xJJCK3sjdnEPQSrpwEL4Bd6PM0VmkqDDJfyawq95E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1oejC7+XVCwNRAWMWb4liG+RlJRSHTe6i7jZnnI1bsrdWYUvIbiYRhAcYn7mK9A6
	 Rb6y1UTGncPTi2bKRvBzAX3S29OJmrzbFtf7uooMNt3kb1kihPEz63vK+n5Q/rDBa+
	 QiV/ajK12l2NTZoqyuuczq0zNb6+Hm1CM3Am1n8TZYMmCU3JaDoOzrhlsJmWKwJ3PY
	 6fGuKaZLfIj2SPcMsxEFeRfCgIHQ7G+lRIVWwVdQbmFZMdUw0X5UwV4Hpma8I9kJSa
	 4P+1U360/3PhTx5bYR5nlRI1rWBbeAE0K2/ODtT9NWqFl18NqTXV/QetfcyQSILH2I
	 9Z+4pLAf+dk3w==
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
Subject: [RFC/PATCH bpf-next 2/3] mm/bpf: Add bpf_get_slab_cache() kfunc
Date: Wed, 25 Sep 2024 15:30:22 -0700
Message-ID: <20240925223023.735947-3-namhyung@kernel.org>
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

The bpf_get_slab_cache() is to get a slab cache information from a
virtual address like virt_to_cache().  If the address is a pointer
to a slab object, it'd return a valid kmem_cache pointer, otherwise
NULL is returned.

It doesn't grab a reference count of the kmem_cache so the caller is
responsible to manage the access.  The intended use case for now is to
symbolize locks in slab objects from the lock contention tracepoints.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/bpf/helpers.c |  1 +
 mm/slab_common.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab286c26..03db007a247175c4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_get_slab_cache, KF_RET_NULL)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7443244656150325..a87adcf182f49fc4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1322,6 +1322,20 @@ size_t ksize(const void *objp)
 }
 EXPORT_SYMBOL(ksize);
 
+#ifdef CONFIG_BPF_SYSCALL
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc struct kmem_cache *bpf_get_slab_cache(u64 addr)
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
2.46.0.792.g87dc391469-goog


