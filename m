Return-Path: <bpf+bounces-65941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7834B2B5E9
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7211B7AC1FB
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A31E32B9;
	Tue, 19 Aug 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGEpAe9p"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F31DF258
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566765; cv=none; b=OC3y6GDkBFulLP8RiLFtnZLBNLdwuQOS3xvQDJcSSCOZrm5mfzIAZHZmfd74/5cMw0PLs8VGRu12R9hA6UXmFe6ysWfWahcKv0oRBPspVsGG2ivuaQwNvLxH9wdlcqEQedYOgfyt7pnm+Oc8jtXPpt0LQGuasS+Do+RF2jqWWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566765; c=relaxed/simple;
	bh=qS9EVZvWe/Z3DofjYGUHyF5IeO/lgGIW+z86qAm6dmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW5tvpf4SvRFZ5P8BNPZxod7gwF1YWhtXq+aK004MG0xlySIm1iVI4mY6YfSNv7ucvIdY00Q2IX3PjuxhOyIirSXkLz12EVYlosRQnyUvckD4id9kdSl/WaeMs6kGTi6eNmNovn737zocSV2O9WnuGvosbVhN6THg7tGdr1XHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGEpAe9p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuIVO/3ks2sLjikS1WPErMnslVg2WZpPHh+YXJdQXnY=;
	b=MGEpAe9plbtkjC64LnnWW1Us2lXUsuakidwa1wdMGIAVfOOotrKveqQ0vKuoDCm5HY3l3U
	AU+zvdtFhoSEfE/NMJVjMcLuUqfBhC/qonBVnVefeClvimtmnJ9CSsvcJ/PG+l9gOuZJc4
	LNEsjlSTX32tzjdQdwJTtYcbOMM688w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-N7j_SzEtOFKfquQQwKwnkQ-1; Mon,
 18 Aug 2025 21:26:01 -0400
X-MC-Unique: N7j_SzEtOFKfquQQwKwnkQ-1
X-Mimecast-MFC-AGG-ID: N7j_SzEtOFKfquQQwKwnkQ_1755566758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC12B1954236;
	Tue, 19 Aug 2025 01:25:57 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36312180028D;
	Tue, 19 Aug 2025 01:25:43 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: bpf@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	systemd-devel@lists.freedesktop.org,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCHv5 04/12] bpf: Introduce decompressor kfunc
Date: Tue, 19 Aug 2025 09:24:20 +0800
Message-ID: <20250819012428.6217-5-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This commit bridges the gap between bpf-prog and the kernel
decompression routines. At present, only a global memory allocator is
used for the decompression. Later, if needed, the decompress_fn's
prototype can be changed to pass in a task related allocator.

This memory allocator can allocate 2MB each time with a transient
virtual address, up to a 1GB limit.  After decompression finishes, it
presents all of the decompressed data in a new unified virtual
address space.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
To: bpf@vger.kernel.org
---
 kernel/bpf/helpers.c | 226 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bd83ec9a2b2a6..895fe8fdaa78d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
+#include <linux/decompress/generic.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3703,6 +3704,230 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
 }
 
+#ifdef CONFIG_KEXEC_PE_IMAGE
+
+#define MAX_UNCOMPRESSED_BUF_SIZE	(1 << 28)
+/* a chunk should be large enough to contain a decompressing */
+#define CHUNK_SIZE	(1 << 23)
+
+/*
+ * At present, one global allocator for decompression. Later if needed, changing the
+ * prototype of decompress_fn to introduce each task's allocator.
+ */
+static DEFINE_MUTEX(output_buf_mutex);
+
+struct decompress_mem_allocator {
+	struct page **pages;
+	unsigned int pg_idx;
+	void *chunk_start;
+	unsigned int chunk_size;
+	void *chunk_cur;
+};
+
+static struct decompress_mem_allocator dcmpr_allocator;
+
+/*
+ * Set up an active chunk to hold partial decompressed data.
+ */
+static void *vmap_decompressed_chunk(void)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	unsigned int i, pg_cnt = a->chunk_size >> PAGE_SHIFT;
+	struct page **pg_start = &a->pages[a->pg_idx];
+
+	for (i = 0; i < pg_cnt; i++)
+		a->pages[a->pg_idx++] = alloc_page(GFP_KERNEL | __GFP_ACCOUNT);
+
+	return vmap(pg_start, pg_cnt, VM_MAP, PAGE_KERNEL);
+}
+
+/*
+ * Present the scattered pages containing decompressed data at a unified virtual
+ * address.
+ */
+static int decompress_mem_allocator_handover(struct decompress_mem_allocator *a,
+		struct mem_range_result *range)
+{
+	unsigned long pg_array_sz = a->pg_idx * sizeof(struct page *);
+
+	range->pages = vmalloc(pg_array_sz);
+	if (!range->pages)
+		return -ENOMEM;
+
+	range->pg_cnt = a->pg_idx;
+	memcpy(range->pages, a->pages, pg_array_sz);
+	range->buf = vmap(range->pages, range->pg_cnt, VM_MAP, PAGE_KERNEL);
+	if (!range->buf) {
+		vfree(range->pages);
+		return -1;
+	}
+	/*
+	 * Free the tracing pointer; The pages are freed when mem_range_result
+	 * is released.
+	 */
+	vfree(a->pages);
+	a->pages = NULL;
+
+	/* vmap-ed */
+	range->alloc_type = TYPE_VMAP;
+	range->buf_sz = a->pg_idx << PAGE_SHIFT;
+	range->data_sz = range->buf_sz - a->chunk_size;
+	range->data_sz += a->chunk_cur - a->chunk_start;
+
+	return 0;
+}
+
+static int decompress_mem_allocator_init(
+	struct decompress_mem_allocator *allocator,
+	unsigned int chunk_size)
+{
+	unsigned long sz = (MAX_UNCOMPRESSED_BUF_SIZE >> PAGE_SHIFT) * sizeof(struct page *);
+
+	allocator->pages = __vmalloc(sz, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!allocator->pages)
+		return -ENOMEM;
+
+	allocator->pg_idx = 0;
+	allocator->chunk_start = NULL;
+	allocator->chunk_size = chunk_size;
+	allocator->chunk_cur = NULL;
+	return 0;
+}
+
+static void decompress_mem_allocator_fini(struct decompress_mem_allocator *allocator)
+{
+	unsigned int i;
+
+	/* unmap the active chunk */
+	if (!!allocator->chunk_start)
+		vunmap(allocator->chunk_start);
+	if (!!allocator->pages) {
+		for (i = 0; i < allocator->pg_idx; i++)
+			__free_pages(allocator->pages[i], 0);
+		vfree(allocator->pages);
+	}
+}
+
+/*
+ * This is a callback for decompress_fn.
+ *
+ * It copies the partial decompressed content in [buf, buf + len) to dst. If the
+ * active chunk is not large enough, retire it and activate a new chunk to hold
+ * the remaining data.
+ */
+static long flush(void *buf, unsigned long len)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	long free, copied = 0;
+
+	/* The first time allocation */
+	if (unlikely(!a->chunk_start)) {
+		a->chunk_start = a->chunk_cur = vmap_decompressed_chunk();
+		if (unlikely(!a->chunk_start))
+			return -1;
+	}
+
+	free = a->chunk_start + a->chunk_size - a->chunk_cur;
+	BUG_ON(free < 0);
+	if (free < len) {
+		/*
+		 * If the totoal size exceeds MAX_UNCOMPRESSED_BUF_SIZE,
+		 * return -1 to indicate the decompress method that something
+		 * is wrong
+		 */
+		if (unlikely((a->pg_idx >= MAX_UNCOMPRESSED_BUF_SIZE >> PAGE_SHIFT)))
+			return -1;
+		memcpy(a->chunk_cur, buf, free);
+		copied += free;
+		a->chunk_cur += free;
+		len -= free;
+		/*
+		 * When retiring the active chunk, release its virtual address
+		 * but do not release the contents in the pages.
+		 */
+		vunmap(a->chunk_start);
+		a->chunk_start = a->chunk_cur = vmap_decompressed_chunk();
+		if (unlikely(!a->chunk_start))
+			return -1;
+	}
+	memcpy(a->chunk_cur, buf, len);
+	copied += len;
+	a->chunk_cur += len;
+	return copied;
+}
+
+__bpf_kfunc struct mem_range_result *bpf_decompress(char *image_gz_payload, int image_gz_sz)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	decompress_fn decompressor;
+	struct mem_cgroup *memcg, *old_memcg;
+	struct mem_range_result *range;
+	const char *name;
+	char *input_buf;
+	int ret;
+
+	memcg = get_mem_cgroup_from_current();
+	old_memcg = set_active_memcg(memcg);
+	range = mem_range_result_alloc();
+	if (!range) {
+		pr_err("fail to allocate mem_range_result\n");
+		goto error;
+	}
+
+	input_buf = __vmalloc(image_gz_sz, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!input_buf) {
+		kfree(range);
+		pr_err("fail to allocate input buffer\n");
+		goto error;
+	}
+
+	ret = copy_from_kernel_nofault(input_buf, image_gz_payload, image_gz_sz);
+	if (ret < 0) {
+		kfree(range);
+		vfree(input_buf);
+		pr_err("Error when copying from 0x%p, size:0x%x\n",
+				image_gz_payload, image_gz_sz);
+		goto error;
+	}
+
+	mutex_lock(&output_buf_mutex);
+	decompress_mem_allocator_init(a, CHUNK_SIZE);
+	decompressor = decompress_method(input_buf, image_gz_sz, &name);
+	if (!decompressor) {
+		kfree(range);
+		vfree(input_buf);
+		pr_err("Can not find decompress method\n");
+		goto error;
+	}
+	ret = decompressor(input_buf, image_gz_sz, NULL, flush,
+				NULL, NULL, NULL);
+
+	vfree(input_buf);
+	if (ret == 0) {
+		ret = decompress_mem_allocator_handover(a, range);
+		if (!!ret)
+			goto fail;
+		range->status = 0;
+		mem_cgroup_tryget(memcg);
+		range->memcg = memcg;
+		set_active_memcg(old_memcg);
+	}
+fail:
+	decompress_mem_allocator_fini(a);
+	mutex_unlock(&output_buf_mutex);
+	if (!!ret) {
+		kfree(range);
+		range = NULL;
+		pr_err("Decompress error\n");
+	}
+
+error:
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+	return range;
+}
+#endif
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3710,6 +3935,7 @@ BTF_KFUNCS_START(generic_btf_ids)
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 #ifdef CONFIG_KEXEC_PE_IMAGE
+BTF_ID_FLAGS(func, bpf_decompress, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_mem_range_result_put, KF_RELEASE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_to_kernel, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 #endif
-- 
2.49.0


