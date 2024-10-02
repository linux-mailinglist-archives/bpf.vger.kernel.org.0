Return-Path: <bpf+bounces-40745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E5A98CD71
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268F31C21B2F
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07066193430;
	Wed,  2 Oct 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCj6O5yM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6191885AD;
	Wed,  2 Oct 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852100; cv=none; b=dbWBZce72qXERhXc2oNS0piwtnzjpHLsxsGy+vVXiJUZ2i/xjTshTAtC8Bu6BSkp896cHvrugPLdtt9BXyrN/NTV+QGMAToqL9AfTd6X1gA4IVa+yXmdH3UQPXd89M0gA+Bj0fYBMieLmuEgUiLrygnk+5dVtbmxR3+TtU20wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852100; c=relaxed/simple;
	bh=CZ1VN+wISqfF7U/NBBkytViSmRb/vkGLNUY76gXrLxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVBNP327dHPreCth6h8L0XsSzeaJPqzKxX1BkyISX7CdExP/hmaQDZEAaqSyAtV850UwOUPnZyhOLF6yy0tGVgSLZ9RgAgOPtspOZE5jkh11Rnutu3/N9pdb+SLjQsPp9MW412sBob0usF7jvVxOkpIdYlHSqZ6iGJ0B97wLEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCj6O5yM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53748C4CED0;
	Wed,  2 Oct 2024 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727852100;
	bh=CZ1VN+wISqfF7U/NBBkytViSmRb/vkGLNUY76gXrLxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCj6O5yMWzyRyOC2sLEsE73j1nEyAtnVAWeVYuXspRu65PIzqY4xQgVm4L8nTDTqO
	 kR4bMLfJz0yHTW7hgwhx0Kyi9RCgz7FEGVu/s6n2CDpActnGsj+FE3vL0vRuTx5ihi
	 rMKduO0LhpTzkAHvr9vAIYmw4Y42AGhMUDBPaYw0qFuDSTs34ZCpM9FVGh4ero//3q
	 ilPuxyLgN60d9WEwkyjzVzA+y/GDOmaZAUCaTDI0dzldxb64qWNFlpSXcdD+TCn8U9
	 FJotUbQWrdeqRWtPHA++WD1UpIfiZ60ZwVtEiNTk/kfge5P9SGIpWfPlcQYxbAbHzx
	 bP/m61KKeHAoA==
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
Subject: [PATCH v3 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
Date: Tue,  1 Oct 2024 23:54:55 -0700
Message-ID: <20241002065456.1580143-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241002065456.1580143-1-namhyung@kernel.org>
References: <20241002065456.1580143-1-namhyung@kernel.org>
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
 mm/slab_common.c     | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4053f279ed4cc7ab..3709fb14288105c6 100644
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
index 7443244656150325..5484e1cd812f698e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
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
+	if (!virt_addr_valid(addr))
+		return NULL;
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


