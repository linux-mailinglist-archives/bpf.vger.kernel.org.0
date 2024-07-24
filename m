Return-Path: <bpf+bounces-35568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC193B948
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526641F2451E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA213D610;
	Wed, 24 Jul 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slxma4Nt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5186F068
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861537; cv=none; b=d0Ecq5R5b3Oa+XH1ZALNh28UH9lqeY+hOFR44LUVFs4elzqXctkxVxAOdFT7fkL8EUXrrMoy1gRtiQGmVxjKo0OEYMtNevdWONVkbZds2sV39nOk4YCeGlBCdI22Fz/O4ziYVD3m16ArbhO++QSfL01PL3r7DEGL0QDKwihmxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861537; c=relaxed/simple;
	bh=q2ogziqHOj9Wq6uIoecdUqbK1pcPKH+zumPWi1mLFts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/VLZFp4LfYJ1vZVy0Nz+udi6MuuULVs2/2hM4hD8Oug8vVhLl+oCwQ4p3K/hRN33Kr3BfKVT+EkzvCzGLRkLPct65zD2RT0AtmouKhqzdiqr6x+T/jWNPO6XAbfUGqM1oWgyNaWN9ZfuITMusyFdb1/g/JIvUPFI3rBxaaHMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slxma4Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD426C32781;
	Wed, 24 Jul 2024 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861537;
	bh=q2ogziqHOj9Wq6uIoecdUqbK1pcPKH+zumPWi1mLFts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slxma4Nt6lk2yBcUSWcrz/O7yhnKN6d/fDfC3KYyg3WMr2Yk/o3C8Jv6+8p7Beq4l
	 XTm2UNGjlMym9tAaGdUcxDI8YXIudpPK72idypZk6Yo1Bfsk3QgDu6LsTsZIro7OTH
	 amPRV6p8tMtq8H5nBXsjznhBSHbGF7taJWHmSnPUczHPxtNgK/7v8u+3XZEUAw2rgn
	 YS74qPwEl+2bnCgwwpCpy8t7NdX0SLMKw8qE9Z/tjHUA5lKddKoGo1w/SybTFlZww+
	 tc8qpt9dB2TBenH7LKXTzPggYsx/FxjFmjwkgnU7uPKPWFoE9Xc6Dz2GmqUzGgEBiT
	 egOMhKG7AoMmw==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 01/10] lib/buildid: add single page-based file reader abstraction
Date: Wed, 24 Jul 2024 15:52:01 -0700
Message-ID: <20240724225210.545423-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724225210.545423-1-andrii@kernel.org>
References: <20240724225210.545423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add freader abstraction that transparently manages fetching and local
mapping of the underlying file page(s) and provides a simple direct data
access interface.

freader_fetch() is the only and single interface necessary. It accepts
file offset and desired number of bytes that should be accessed, and
will return a kernel mapped pointer that caller can use to dereference
data up to requested size. Requested size can't be bigger than the size
of the extra buffer provided during initialization (because, worst case,
all requested data has to be copied into it, so it's better to flag
wrongly sized buffer unconditionally, regardless if requested data range
is crossing page boundaries or not).

If page is not paged in, or some of the conditions are not satisfied,
NULL is returned and more detailed error code can be accessed through
freader->err field. This approach makes the usage of freader_fetch()
cleaner.

To accommodate accessing file data that crosses page boundaries, user
has to provide an extra buffer that will be used to make a local copy,
if necessary. This is done to maintain a simple linear pointer data
access interface.

We switch existing build ID parsing logic to it, without changing or
lifting any of the existing constraints, yet. This will be done
separately.

Given existing code was written with the assumption that it's always
working with a single (first) page of the underlying ELF file, logic
passes direct pointers around, which doesn't really work well with
freader approach and would be limiting when removing the single page
limitation. So we adjust all the logic to work in terms of file offsets.

There is also a memory buffer-based version (freader_init_from_mem())
for cases when desired data is already available in kernel memory. This
is used for parsing vmlinux's own build ID note. In this mode assumption
is that provided data starts at "file offset" zero, which works great
when parsing ELF notes sections, as all the parsing logic is relative to
note section's start.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 278 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 217 insertions(+), 61 deletions(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 7954dd92e36c..1442a2483a8b 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -8,38 +8,174 @@
 
 #define BUILD_ID 3
 
+struct freader {
+	void *buf;
+	u32 buf_sz;
+	int err;
+	union {
+		struct {
+			struct address_space *mapping;
+			struct page *page;
+			void *page_addr;
+			u64 file_off;
+		};
+		struct {
+			const char *data;
+			u64 data_sz;
+		};
+	};
+};
+
+static void freader_init_from_file(struct freader *r, void *buf, u32 buf_sz,
+				   struct address_space *mapping)
+{
+	memset(r, 0, sizeof(*r));
+	r->buf = buf;
+	r->buf_sz = buf_sz;
+	r->mapping = mapping;
+}
+
+static void freader_init_from_mem(struct freader *r, const char *data, u64 data_sz)
+{
+	memset(r, 0, sizeof(*r));
+	r->data = data;
+	r->data_sz = data_sz;
+}
+
+static void freader_put_page(struct freader *r)
+{
+	if (!r->page)
+		return;
+	kunmap_local(r->page_addr);
+	put_page(r->page);
+	r->page = NULL;
+}
+
+static int freader_get_page(struct freader *r, u64 file_off)
+{
+	pgoff_t pg_off = file_off >> PAGE_SHIFT;
+
+	freader_put_page(r);
+
+	r->page = find_get_page(r->mapping, pg_off);
+	if (!r->page)
+		return -EFAULT;	/* page not mapped */
+
+	r->page_addr = kmap_local_page(r->page);
+	r->file_off = file_off & PAGE_MASK;
+
+	return 0;
+}
+
+static const void *freader_fetch(struct freader *r, u64 file_off, size_t sz)
+{
+	int err;
+
+	/* provided internal temporary buffer should be sized correctly */
+	if (WARN_ON(r->buf && sz > r->buf_sz)) {
+		r->err = -E2BIG;
+		return NULL;
+	}
+
+	if (unlikely(file_off + sz < file_off)) {
+		r->err = -EOVERFLOW;
+		return NULL;
+	}
+
+	/* working with memory buffer is much more straightforward */
+	if (!r->buf) {
+		if (file_off + sz > r->data_sz) {
+			r->err = -ERANGE;
+			return NULL;
+		}
+		return r->data + file_off;
+	}
+
+	/* check if we need to fetch a different page first */
+	if (!r->page || file_off < r->file_off || file_off >= r->file_off + PAGE_SIZE) {
+		err = freader_get_page(r, file_off);
+		if (err) {
+			r->err = err;
+			return NULL;
+		}
+	}
+
+	/* if requested data is crossing page boundaries, we have to copy
+	 * everything into our local buffer to keep a simple linear memory
+	 * access interface
+	 */
+	if (file_off + sz > r->file_off + PAGE_SIZE) {
+		int part_sz = r->file_off + PAGE_SIZE - file_off;
+
+		/* copy the part that resides in the current page */
+		memcpy(r->buf, r->page_addr + (file_off - r->file_off), part_sz);
+
+		/* fetch next page */
+		err = freader_get_page(r, r->file_off + PAGE_SIZE);
+		if (err) {
+			r->err = err;
+			return NULL;
+		}
+
+		/* copy the rest of requested data */
+		memcpy(r->buf + part_sz, r->page_addr, sz - part_sz);
+
+		return r->buf;
+	}
+
+	/* if data fits in a single page, just return direct pointer */
+	return r->page_addr + (file_off - r->file_off);
+}
+
+static void freader_cleanup(struct freader *r)
+{
+	freader_put_page(r);
+}
+
 /*
  * Parse build id from the note segment. This logic can be shared between
  * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
  * identical.
  */
-static int parse_build_id_buf(unsigned char *build_id,
-			      __u32 *size,
-			      const void *note_start,
-			      Elf32_Word note_size)
+static int parse_build_id_buf(struct freader *r,
+			      unsigned char *build_id, __u32 *size,
+			      u64 note_offs, Elf32_Word note_size)
 {
-	Elf32_Word note_offs = 0, new_offs;
+	const char note_name[] = "GNU";
+	const size_t note_name_sz = sizeof(note_name);
+	u64 build_id_off, new_offs, note_end = note_offs + note_size;
+	u32 build_id_sz;
+	const Elf32_Nhdr *nhdr;
+	const char *data;
 
-	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
-		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+	while (note_offs + sizeof(Elf32_Nhdr) < note_end) {
+		nhdr = freader_fetch(r, note_offs, sizeof(Elf32_Nhdr) + note_name_sz);
+		if (!nhdr)
+			return r->err;
 
 		if (nhdr->n_type == BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU") &&
-		    !strcmp((char *)(nhdr + 1), "GNU") &&
+		    nhdr->n_namesz == note_name_sz &&
+		    !strcmp((char *)(nhdr + 1), note_name) &&
 		    nhdr->n_descsz > 0 &&
 		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
-			memcpy(build_id,
-			       note_start + note_offs +
-			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       nhdr->n_descsz);
-			memset(build_id + nhdr->n_descsz, 0,
-			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
+
+			build_id_off = note_offs + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
+			build_id_sz = nhdr->n_descsz;
+
+			/* freader_fetch() will invalidate nhdr pointer */
+			data = freader_fetch(r, build_id_off, build_id_sz);
+			if (!data)
+				return r->err;
+
+			memcpy(build_id, data, build_id_sz);
+			memset(build_id + build_id_sz, 0, BUILD_ID_SIZE_MAX - build_id_sz);
 			if (size)
-				*size = nhdr->n_descsz;
+				*size = build_id_sz;
 			return 0;
 		}
+
 		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
+			   ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
 		if (new_offs <= note_offs)  /* overflow */
 			break;
 		note_offs = new_offs;
@@ -48,73 +184,87 @@ static int parse_build_id_buf(unsigned char *build_id,
 	return -EINVAL;
 }
 
-static inline int parse_build_id(const void *page_addr,
+static inline int parse_build_id(struct freader *r,
 				 unsigned char *build_id,
 				 __u32 *size,
-				 const void *note_start,
+				 u64 note_start_off,
 				 Elf32_Word note_size)
 {
 	/* check for overflow */
-	if (note_start < page_addr || note_start + note_size < note_start)
+	if (note_start_off + note_size < note_start_off)
 		return -EINVAL;
 
 	/* only supports note that fits in the first page */
-	if (note_start + note_size > page_addr + PAGE_SIZE)
+	if (note_start_off + note_size > PAGE_SIZE)
 		return -EINVAL;
 
-	return parse_build_id_buf(build_id, size, note_start, note_size);
+	return parse_build_id_buf(r, build_id, size, note_start_off, note_size);
 }
 
 /* Parse build ID from 32-bit ELF */
-static int get_build_id_32(const void *page_addr, unsigned char *build_id,
-			   __u32 *size)
+static int get_build_id_32(struct freader *r, unsigned char *build_id, __u32 *size)
 {
-	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
-	Elf32_Phdr *phdr;
-	int i;
+	const Elf32_Ehdr *ehdr;
+	const Elf32_Phdr *phdr;
+	__u32 phnum, i;
+
+	ehdr = freader_fetch(r, 0, sizeof(Elf32_Ehdr));
+	if (!ehdr)
+		return r->err;
+
+	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
+	phnum = ehdr->e_phnum;
 
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
-	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
+	for (i = 0; i < phnum; ++i) {
+		phdr = freader_fetch(r, i * sizeof(Elf32_Phdr), sizeof(Elf32_Phdr));
+		if (!phdr)
+			return r->err;
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
-		if (phdr[i].p_type == PT_NOTE &&
-		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+		if (phdr->p_type == PT_NOTE &&
+		    !parse_build_id(r, build_id, size, phdr->p_offset, phdr->p_filesz))
 			return 0;
 	}
 	return -EINVAL;
 }
 
 /* Parse build ID from 64-bit ELF */
-static int get_build_id_64(const void *page_addr, unsigned char *build_id,
-			   __u32 *size)
+static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *size)
 {
-	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
-	Elf64_Phdr *phdr;
-	int i;
+	const Elf64_Ehdr *ehdr;
+	const Elf64_Phdr *phdr;
+	__u32 phnum, i;
+
+	ehdr = freader_fetch(r, 0, sizeof(Elf64_Ehdr));
+	if (!ehdr)
+		return r->err;
+
+	/* subsequent freader_fetch() calls invalidate pointers, so remember locally */
+	phnum = ehdr->e_phnum;
 
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
-	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
+	for (i = 0; i < phnum; ++i) {
+		phdr = freader_fetch(r, i * sizeof(Elf64_Phdr), sizeof(Elf64_Phdr));
+		if (!phdr)
+			return r->err;
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
-		if (phdr[i].p_type == PT_NOTE &&
-		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+		if (phdr->p_type == PT_NOTE &&
+		    !parse_build_id(r, build_id, size, phdr->p_offset, phdr->p_filesz))
 			return 0;
 	}
+
 	return -EINVAL;
 }
 
+/* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
+#define MAX_FREADER_BUF_SZ 64
+
 /*
  * Parse build ID of ELF file mapped to vma
  * @vma:      vma object
@@ -126,22 +276,25 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size)
 {
-	Elf32_Ehdr *ehdr;
-	struct page *page;
-	void *page_addr;
+	const Elf32_Ehdr *ehdr;
+	struct freader r;
+	char buf[MAX_FREADER_BUF_SZ];
 	int ret;
 
 	/* only works for page backed storage  */
 	if (!vma->vm_file)
 		return -EINVAL;
 
-	page = find_get_page(vma->vm_file->f_mapping, 0);
-	if (!page)
-		return -EFAULT;	/* page not mapped */
+	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file->f_mapping);
+
+	/* fetch first 18 bytes of ELF header for checks */
+	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
+	if (!ehdr) {
+		ret = r.err;
+		goto out;
+	}
 
 	ret = -EINVAL;
-	page_addr = kmap_local_page(page);
-	ehdr = (Elf32_Ehdr *)page_addr;
 
 	/* compare magic x7f "ELF" */
 	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0)
@@ -152,12 +305,11 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		goto out;
 
 	if (ehdr->e_ident[EI_CLASS] == ELFCLASS32)
-		ret = get_build_id_32(page_addr, build_id, size);
+		ret = get_build_id_32(&r, build_id, size);
 	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
-		ret = get_build_id_64(page_addr, build_id, size);
+		ret = get_build_id_64(&r, build_id, size);
 out:
-	kunmap_local(page_addr);
-	put_page(page);
+	freader_cleanup(&r);
 	return ret;
 }
 
@@ -171,7 +323,11 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 {
-	return parse_build_id_buf(build_id, NULL, buf, buf_size);
+	struct freader r;
+
+	freader_init_from_mem(&r, buf, buf_size);
+
+	return parse_build_id_buf(&r, build_id, NULL, 0, buf_size);
 }
 
 #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
-- 
2.43.0


