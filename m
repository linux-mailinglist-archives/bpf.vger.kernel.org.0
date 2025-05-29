Return-Path: <bpf+bounces-59265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C741AC7715
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226851C020D2
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4E2505BA;
	Thu, 29 May 2025 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aacdB8I1"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AE1E5B6F
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492379; cv=none; b=QBTSakO62o8DWn9Zsi3SEBJv8z1XA6CdZX7fZoU934Nqf3syXP1iKNC7ItteDAgr9gAJSSfUIs5GSyYHnbowBBnxfdy6zHLCoHPhhby95VXxoJpTCJ40sLoR0y/2VzKHk7fGBXmYLtWoK0eJRJuqOSm/fYGEyMiAaTd6HPULShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492379; c=relaxed/simple;
	bh=W+DAQs7xPova2vXkwgw7V2VeWAVxyCPGQfp8hoRcFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7MpP9ojLTQ2iwdvNOmjndkaTdQpjJN697My0B/9FEo/HS1z0wpFuAKnYsAYTwbpI6lWnE0bc7sqOOlVZ2EJVIL8gFtU4S9CsyD0Y/2u3G33M2lJhlXTbfX1L7QsmfWGJa6oIhBcCvJyGPxXnpNIspMPv4PIIgzVp/hBMPWlzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aacdB8I1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdWHT1perMY/ilaILk5jhZmkWKssh6zUyVvG2waTWcY=;
	b=aacdB8I1PUwpF6J2c86+bwP2oNfBvYdPOZ5oX6pU+8kZEAxdbQWN9a5QVSURIAsL1UyEt/
	jngRgGusrbmxBvU4149M+7npR5F2NiACXthmf2m8SjoKkOoGrXrQ2e9zOvzjPNGVdPg5gh
	kqfn2969zO9rZemy7VGo8JigU5aOflU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-Tv4T9c1KMTWX4BB937_ruQ-1; Thu,
 29 May 2025 00:19:31 -0400
X-MC-Unique: Tv4T9c1KMTWX4BB937_ruQ-1
X-Mimecast-MFC-AGG-ID: Tv4T9c1KMTWX4BB937_ruQ_1748492368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50B6F1956089;
	Thu, 29 May 2025 04:19:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70AB8180047F;
	Thu, 29 May 2025 04:19:15 +0000 (UTC)
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
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCHv3 4/9] bpf: Introduce decompressor kfunc
Date: Thu, 29 May 2025 12:17:39 +0800
Message-ID: <20250529041744.16458-5-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
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
 kernel/bpf/helpers.c | 111 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f4284e58400b..9748d6101d032 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/decompress/generic.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3194,12 +3195,122 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
 }
 
+#define MAX_UNCOMPRESSED_BUF_SIZE	(1 << 28)
+/*
+ * At present, one global allocator for decompression. Later if needed, changing the
+ * prototype of decompress_fn to introduce each task's allocator.
+ */
+static char *output_buf;
+static char *output_cur;
+static DEFINE_MUTEX(output_buf_mutex);
+
+/*
+ * Copy the partial decompressed content in [buf, buf + len) to dst.
+ * If the dst size is beyond the capacity, return -1 to indicate the
+ * decompress method that something is wrong.
+ */
+static long flush(void *buf, unsigned long len)
+{
+
+	if (output_cur - output_buf > MAX_UNCOMPRESSED_BUF_SIZE - len)
+		return -1;
+	memcpy(output_cur, buf, len);
+	output_cur += len;
+	return len;
+}
+
+__bpf_kfunc struct mem_range_result *bpf_decompress(char *image_gz_payload, int image_gz_sz)
+{
+	struct mem_cgroup *memcg, *old_memcg;
+	decompress_fn decompressor;
+	struct mem_range_result *range;
+	const char *name;
+	char *input_buf;
+	int ret;
+
+	memcg = get_mem_cgroup_from_current();
+	old_memcg = set_active_memcg(memcg);
+	range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
+	if (!range) {
+		pr_err("fail to allocate mem_range_result\n");
+		goto error;
+	}
+	kref_init(&range->ref);
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
+	output_buf = __vmalloc(MAX_UNCOMPRESSED_BUF_SIZE, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!output_buf) {
+		mutex_unlock(&output_buf_mutex);
+		kfree(range);
+		vfree(input_buf);
+		pr_err("fail to allocate output buffer\n");
+		goto error;
+	}
+	output_cur = output_buf;
+	decompressor = decompress_method(input_buf, image_gz_sz, &name);
+	if (!decompressor) {
+		kfree(range);
+		vfree(input_buf);
+		vfree(output_buf);
+		mutex_unlock(&output_buf_mutex);
+		pr_err("Can not find decompress method\n");
+		goto error;
+	}
+	ret = decompressor(input_buf, image_gz_sz, NULL, flush,
+				NULL, NULL, NULL);
+
+	vfree(input_buf);
+	/* Update the range map */
+	if (ret == 0) {
+		range->kmalloc = false;
+		range->buf = output_buf;
+		range->buf_sz = MAX_UNCOMPRESSED_BUF_SIZE;
+		range->data_sz = output_cur - output_buf;
+		output_buf = output_cur = NULL;
+		mutex_unlock(&output_buf_mutex);
+		range->status = 0;
+		/* Do not release the reference */
+		range->memcg = memcg;
+		set_active_memcg(old_memcg);
+		return range;
+	}
+
+	/* Decompression fails */
+	vfree(output_buf);
+	output_buf = output_cur = NULL;
+	mutex_unlock(&output_buf_mutex);
+	kfree(range);
+	pr_err("Decompress error\n");
+
+error:
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+	return NULL;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
 #ifdef CONFIG_CRASH_DUMP
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
+BTF_ID_FLAGS(func, bpf_decompress, KF_TRUSTED_ARGS | KF_ACQUIRE | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_mem_range_result_put, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_copy_to_kernel, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
-- 
2.49.0


