Return-Path: <bpf+bounces-16939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13933807B8C
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A981C21205
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB0328B4;
	Wed,  6 Dec 2023 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5p0jqfU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DF2D786
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 22:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B4C433C8;
	Wed,  6 Dec 2023 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902494;
	bh=VLBW+Mb1DM6lRUx5Ny/jagoOh5xYd7NEXPqCbKLqsfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X5p0jqfUBndeBsXdghsDmH9hFBmCTMzuD3+yXvRAMduVuNK70N2S0md2QwTDLz3UT
	 R7O55VqfbKmgbpFjicpqoP8sOSxrnDrSf/9OEQm1PK3diZ8cPVLSYl2opMiKZFl0Nv
	 pkMfInqmJd9UPWdis4244lpEMzR0ubhgOkBTtZhJ5k/d7QsKEiI0qcZxo8QFnZUkKa
	 kWXbwJFayg5EFSwn8Z68pmg2H67+dMwOK3qzaghPLnmUS4QWHp/pSaUC5nq+RvKzJ4
	 3GWToicEYz2OEKrvnai6IRrlPZajxbXB6C3YHyCVPkqk0HU/acIlChsy9eXmcoYSYr
	 DM0r9QhTCEzZQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v7 bpf-next 1/7] bpf: Let bpf_prog_pack_free handle any pointer
Date: Wed,  6 Dec 2023 14:40:48 -0800
Message-Id: <20231206224054.492250-2-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224054.492250-1-song@kernel.org>
References: <20231206224054.492250-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, bpf_prog_pack_free only can only free pointer to struct
bpf_binary_header, which is not flexible. Add a size argument to
bpf_prog_pack_free so that it can handle any pointer.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/filter.h  |  2 +-
 kernel/bpf/core.c       | 21 ++++++++++-----------
 kernel/bpf/dispatcher.c |  5 +----
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14354605ad26..12d907f17d36 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1067,7 +1067,7 @@ struct bpf_binary_header *
 bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
 
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns);
-void bpf_prog_pack_free(struct bpf_binary_header *hdr);
+void bpf_prog_pack_free(void *ptr, u32 size);
 
 static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ced511f44174..c34513d645c4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -928,20 +928,20 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	return ptr;
 }
 
-void bpf_prog_pack_free(struct bpf_binary_header *hdr)
+void bpf_prog_pack_free(void *ptr, u32 size)
 {
 	struct bpf_prog_pack *pack = NULL, *tmp;
 	unsigned int nbits;
 	unsigned long pos;
 
 	mutex_lock(&pack_mutex);
-	if (hdr->size > BPF_PROG_PACK_SIZE) {
-		bpf_jit_free_exec(hdr);
+	if (size > BPF_PROG_PACK_SIZE) {
+		bpf_jit_free_exec(ptr);
 		goto out;
 	}
 
 	list_for_each_entry(tmp, &pack_list, list) {
-		if ((void *)hdr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > (void *)hdr) {
+		if (ptr >= tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > ptr) {
 			pack = tmp;
 			break;
 		}
@@ -950,10 +950,10 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
 	if (WARN_ONCE(!pack, "bpf_prog_pack bug\n"))
 		goto out;
 
-	nbits = BPF_PROG_SIZE_TO_NBITS(hdr->size);
-	pos = ((unsigned long)hdr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
+	nbits = BPF_PROG_SIZE_TO_NBITS(size);
+	pos = ((unsigned long)ptr - (unsigned long)pack->ptr) >> BPF_PROG_CHUNK_SHIFT;
 
-	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
+	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
 
 	bitmap_clear(pack->bitmap, pos, nbits);
@@ -1100,8 +1100,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 
 	*rw_header = kvmalloc(size, GFP_KERNEL);
 	if (!*rw_header) {
-		bpf_arch_text_copy(&ro_header->size, &size, sizeof(size));
-		bpf_prog_pack_free(ro_header);
+		bpf_prog_pack_free(ro_header, size);
 		bpf_jit_uncharge_modmem(size);
 		return NULL;
 	}
@@ -1132,7 +1131,7 @@ int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
 	kvfree(rw_header);
 
 	if (IS_ERR(ptr)) {
-		bpf_prog_pack_free(ro_header);
+		bpf_prog_pack_free(ro_header, ro_header->size);
 		return PTR_ERR(ptr);
 	}
 	return 0;
@@ -1153,7 +1152,7 @@ void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 {
 	u32 size = ro_header->size;
 
-	bpf_prog_pack_free(ro_header);
+	bpf_prog_pack_free(ro_header, size);
 	kvfree(rw_header);
 	bpf_jit_uncharge_modmem(size);
 }
diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index fa3e9225aedc..56760fc10e78 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -150,10 +150,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 			goto out;
 		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
 		if (!d->rw_image) {
-			u32 size = PAGE_SIZE;
-
-			bpf_arch_text_copy(d->image, &size, sizeof(size));
-			bpf_prog_pack_free((struct bpf_binary_header *)d->image);
+			bpf_prog_pack_free(d->image, PAGE_SIZE);
 			d->image = NULL;
 			goto out;
 		}
-- 
2.34.1


