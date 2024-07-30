Return-Path: <bpf+bounces-36089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB55F9421AF
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809E21F24371
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBC21684BE;
	Tue, 30 Jul 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc3WtjQV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDB184553
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722371978; cv=none; b=jFiZVo9TaQ8oAl2IV4EfP/hTsppITOjnyD/WY/xq+y3dtTnc+3MzEmp1RJ2gDg7TQd8Tlg9KBCH8jxwa9uO/uScJOAiDCadbTqfGKpUmiGxrWin0/oA3lv3HzaIRBemDZ6BDhv6d5srBpJXRM5ji0hzV/BZjTUTOdCmPlWm0M1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722371978; c=relaxed/simple;
	bh=mldgb2yfjVUsP4mxlrdfmqOiY8Dxht1DRa2moFmeLSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoLhaFRie6QKCMhJsVI+qlHH3QWGQMJoaOTUHh+3MSgp/Dpa18YK3T/uVDazEbmnPvtG3Y/xfa2JaxOJH7bePSsWNnLbi26hGS2jHEAs0/YegR2cYy+yYu1w1hK1e+GmPtOQ06jJY1SUc0YPfbnBRr0SbXOYE5ppAjvnH8XJVa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc3WtjQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553D6C4AF09;
	Tue, 30 Jul 2024 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722371977;
	bh=mldgb2yfjVUsP4mxlrdfmqOiY8Dxht1DRa2moFmeLSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc3WtjQV1RhkYq/0gaCoIYSRMgWSZpcWPSPs54HREl6QCh03Z8l6eGy/SsDNY2c4j
	 QtgbkRacBuGCav7W98Cq4L02LDCFhH/9gtPHBK0/P3w5sXj+jYNxootCOvet9CFVK6
	 +FRY9HwBvzwnbdYGbtci7Z/7JmRi5fks0PwqPA3Rak22GXL0yiTF7gYi5sR5QPGmWW
	 XKS8opfEJ90/BLeQSTtEBxhNaX6x9iar/J1lpTrcWpXn0LeHdyZ54HS8EurCkrHf6e
	 5tge3wlug/esW5mYETpzo4bI4yXh6xb3xFxFGKYfcsu+lRAIzPeM+m8J4pUKWReFyb
	 SH37o8VBbvNVw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	jannh@google.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH v3 bpf-next 06/10] lib/buildid: implement sleepable build_id_parse() API
Date: Tue, 30 Jul 2024 13:39:10 -0700
Message-ID: <20240730203914.1182569-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730203914.1182569-1-andrii@kernel.org>
References: <20240730203914.1182569-1-andrii@kernel.org>
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
 lib/buildid.c | 50 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 5c869a2a30ab..6b5558cd95bf 100644
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
 
@@ -273,18 +286,8 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
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
@@ -295,7 +298,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -323,6 +326,22 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
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
@@ -336,8 +355,7 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	/* fallback to non-faultable version for now */
-	return build_id_parse_nofault(vma, build_id, size);
+	return __build_id_parse(vma, build_id, size, true /* may_fault */);
 }
 
 /**
-- 
2.43.0


