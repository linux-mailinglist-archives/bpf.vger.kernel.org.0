Return-Path: <bpf+bounces-34292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8658192C4EC
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408B82830C4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732DC187851;
	Tue,  9 Jul 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKNj5L24"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEE149C40
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557789; cv=none; b=j3BzMuNPocZXjth5aP6JElgRlMrorEk81ylQ9+Co/xWXProSR6xT9v9KmAGj/aQ/P/G31h16XJZmN42sduUnwx0uiUKwfpsiG4jSt7xGUvXo2cQsgXnBImXfBPMPOtQ5V44U2opSL4JgxLx0sHbp8EOKKPrbhmmFLEHICK9Eyww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557789; c=relaxed/simple;
	bh=+9jpZjOCZAyOPgnFUaMIL0c75rF54bF41tQH1aEgnRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1ELZHqQAF0GTudjDQscEXMc0eDsZtlZAfhX9osEh+RQiF/t0OqRWDOFh9MIW4vtDXeybw7HrpNciXERWgg2+nb9KIL8DWjuam7SMYt+9Nbk86X5/Gi7prk5DXV42/84D+57W4kZe3gLdK2tLzWhQOr8HB8BD+c9rGhhiByNspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKNj5L24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C012C3277B;
	Tue,  9 Jul 2024 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557788;
	bh=+9jpZjOCZAyOPgnFUaMIL0c75rF54bF41tQH1aEgnRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKNj5L24TmI7UHUd+8Tc+HQ3syfb1w4WGfckJL3jLjIrwZM6BiJyMio0ayUOCu8ds
	 5JhEDTMW0GfAj6LRuECJRxoNASWOBsp+9kW4q1Ys4kgoQqAm9Xj+Q32QUjTQTdnV7e
	 vqsYL1E7UnkmTmcS7nZz9Uk7JNRjspulEkktLZrDssyhfoL1q5jY+NMzi7qmCBDwhH
	 BKnFSiC1bhN8KWW9qQSwqL8iUJ7K0NmM7tEC68tzcfhuBjnfs/y7kLJBTCwAcdqWzo
	 shbZBo91h3MwrA/RTUsig7F4hznRtXequGhZ7ElvAw6t7WHlag5ec9Vsj+cKUAH2M2
	 FTt3Zj/Jcqyig==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH bpf-next 05/10] lib/buildid: implement sleepable build_id_parse() API
Date: Tue,  9 Jul 2024 13:42:40 -0700
Message-ID: <20240709204245.3847811-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709204245.3847811-1-andrii@kernel.org>
References: <20240709204245.3847811-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend freader with a flag specifying whether it's OK to cause page
fault to fetch file data that is not already physically present in
memory. With this, it's now easy to wait for data if the caller is
running in sleepable (faultable) context.

We utilize read_cache_folio() to bring the desired file page into page
cache, after which the rest of the logic works just the same at page level.

Suggested-by: Omar Sandoval <osandov@fb.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 5f898fee43d7..23bfc811981a 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -20,6 +20,7 @@ struct freader {
 			struct page *page;
 			void *page_addr;
 			u64 file_off;
+			bool may_fault;
 		};
 		struct {
 			const char *data;
@@ -29,12 +30,13 @@ struct freader {
 };
 
 static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
-				   struct address_space *mapping)
+				   struct address_space *mapping, bool may_fault)
 {
 	memset(r, 0, sizeof(*r));
 	r->buf = buf;
 	r->buf_sz = buf_sz;
 	r->mapping = mapping;
+	r->may_fault = may_fault;
 }
 
 static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
@@ -60,6 +62,17 @@ static int freader_get_page(struct freader *r, u64 file_off)
 	freader_put_page(r);
 
 	r->page = find_get_page(r->mapping, pg_off);
+
+	if (!r->page && r->may_fault) {
+		struct folio *folio;
+
+		folio = read_cache_folio(r->mapping, pg_off, NULL, NULL);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
+
+		r->page = folio_file_page(folio, pg_off);
+	}
+
 	if (!r->page)
 		return -EFAULT;	/* page not mapped */
 
@@ -270,18 +283,8 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
 #define MAX_FREADER_BUF_SZ 64
 
-/*
- * Parse build ID of ELF file mapped to vma
- * @vma:      vma object
- * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
- * @size:     returns actual build id size in case of success
- *
- * Assumes no page fault can be taken, so if relevant portions of ELF file are
- * not already paged in, fetching of build ID fails.
- *
- * Return: 0 on success; negative error, otherwise
- */
-int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+			    __u32 *size, bool may_fault)
 {
 	const Elf32_Ehdr *ehdr;
 	struct freader r;
@@ -292,7 +295,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -320,6 +323,22 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	return ret;
 }
 
+/*
+ * Parse build ID of ELF file mapped to vma
+ * @vma:      vma object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes no page fault can be taken, so if relevant portions of ELF file are
+ * not already paged in, fetching of build ID fails.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
+{
+	return __build_id_parse(vma, build_id, size, false /* !may_fault */);
+}
+
 /*
  * Parse build ID of ELF file mapped to VMA
  * @vma:      vma object
@@ -333,7 +352,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	return -EOPNOTSUPP;
+	return __build_id_parse(vma, build_id, size, true /* may_fault */);
 }
 
 /**
-- 
2.43.0


