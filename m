Return-Path: <bpf+bounces-72282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EF6C0B37D
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B061D3B9F13
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4702F657E;
	Sun, 26 Oct 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al17sLnd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B32DF716
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511158; cv=none; b=atlAhejtQKoUJKZq5CdGfKpd1thzcpwGWKbpy9f4w+WO7R/i0EtmX3cAP3LNZKI036ndBeXkLA/rA+7pkWLjJzZG0iUCtjVsIDOXMwiYRxD/06QOriNEC87fQtTvxqL/AQyEqUKepQOo4Ke8M3qBJeFuE6fE2DzYy7bitdgV7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511158; c=relaxed/simple;
	bh=LTwgBndDgEP+zoZExfbzSjdxz122PE91/gSx6czbxcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9cTaRqXSS/tGzVKIQZYHKkPf21pxUnXFBfelJ9pKPD0I/ehCRYkIO3kkyVZJg747jk2tHbGEkdvj3w6GRXnKsAGjpDC+cEJpc5LtkLW0BDWO+oxwq5eaGFEfvB6ajQGMTaGDY0uwnriQpoNAUUFHqLvtaf/4VtcWsghV7HPdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al17sLnd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so43554835e9.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511155; x=1762115955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRWe4BWBZ6A/KLjRwJUxbMK24jm00EDTNEyu/N/A2Ug=;
        b=al17sLndALREZIlg3TCs8Igmfr25Gf/m8KGY3HdPYSUGfJdQ+Q6MO2ZUFSSUGlQR6e
         fzFzxojDQWq7PO78VvppdyYvKePtAqaEPMEGxUZIY3HNJ8T9OA3sKyagFcx5ZbzxPGQ9
         JhQNT18K5B+tyiPgGpbuhwMVGqYplfClXg3/eCBVcJnzDmv27SR0SZDcNa62CLVbwi0e
         A4bOKLrMkryMHkGWcA9eZvmV9Q9lDe6e7hiSrThjiuyNOG/lDM+qA3PJB4Jt6TK2xZmG
         rnee9Sg90Fu8lG8lwGnddp5W0QhFuRV+3A1Pg7zB2baY6FNlfK0+oi0l99cD1NELdDIb
         W/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511155; x=1762115955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRWe4BWBZ6A/KLjRwJUxbMK24jm00EDTNEyu/N/A2Ug=;
        b=WkrvLiIaFdSiKIfzfhF0sk9+UniUrFFxWklOOb77BMLHGIIpYwPRIl6ar0NywEJElS
         hMeCYPtB3mNK75pCvAb8IPCoGcMN1KQzq5YUPWOjqrSVellUEiUMXc/MKg0L/QVkaQ9j
         ym+vce9cWO+FpkwEnauYsiSJsGhD89bxnstBZDUX4tYDgEMTl6grupv5ksTERLbbwyc5
         yHxzIYYU8NeSNpvH5n8R1PCgZrf3h4dmbt8LU0siPbYHjesEDKicPnFF2URO8w9Ml5z1
         9IZJGToRHlngbUY0SUMEjeCsyyfJcZ/KttlrZK16YTr4IRRsufonupeUJM/Q/PhFpbJb
         4X5g==
X-Gm-Message-State: AOJu0YzCXP+B+ycMRfPSi/i3gXTpRz5fZm3Q6/tNVWss24uFUCHzOZum
	TIlGpK2tKJmvEo1wts/SycvVgqACYFN1yxHcKALYEWIs9XYCVeJ7hZmSNQR8Rg==
X-Gm-Gg: ASbGncuMIS6ndU3mJnE3NelGxW3hXwSiC8sR61KhZfYWn+7q0Ek+xk8PYdavq4Edz4z
	Dr+oBvTCW3hAK62cKoZBt2fMDFZCkdzXALUJVBdzVTguH0bij6XD/RiWzVXYdWGpOdrh1RQ5Wb/
	f1Bp2dWeET9ggV0jNcnLhoa7vZC6q5YYUvj1U2lnOCOhAOt7IDNRHcRircQnajlVASOkLGjk74K
	ijR6FvIqP1d7riLSyz5tKdvjCF0fu8Bv/RvfAp4pwLyDnzjazYpK5iwIJwq0Q2BR3YoXME8HT4m
	ieGoVPbOEQJYPlYGfiRA1IkZbSMLYhmaipK0bCnv23pqx+gpZr1hJ/eK0WB8GJJw7pcKMqZf8DC
	WHkG8iXF+cigAtSLfEGZnkJJ1z69xHWpdkT0DgPLkWBFFKR36l9V5RiY99l2gTuCPPBUklw==
X-Google-Smtp-Source: AGHT+IFFI1nVKh3TXpSain7AJSZScP4b/DUZhsQwUigDH80JzYs9/NMUVphw1MbluWBa8LjhQzlNzQ==
X-Received: by 2002:a05:600c:3acf:b0:475:dd05:93f with SMTP id 5b1f17b1804b1-475dd050a09mr43010405e9.36.1761511155098;
        Sun, 26 Oct 2025 13:39:15 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e41sm96824815e9.12.2025.10.26.13.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:14 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 07/10] bpf: add kfuncs and helpers support for file dynptrs
Date: Sun, 26 Oct 2025 20:38:50 +0000
Message-ID: <20251026203853.135105-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add support for file dynptr.

Introduce struct bpf_dynptr_file_impl to hold internal state for file
dynptrs, with 64-bit size and offset support.

Introduce lifecycle management kfuncs:
  - bpf_dynptr_from_file() for initialization
  - bpf_dynptr_file_discard() for destruction

Extend existing helpers to support file dynptrs in:
  - bpf_dynptr_read()
  - bpf_dynptr_slice()

Write helpers (bpf_dynptr_write() and bpf_dynptr_data()) are not
modified, as file dynptr is read-only.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c | 92 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bf65b7fb761f..99a7def0b978 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/verification.h>
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
+#include <linux/buildid.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1656,6 +1657,13 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 	.arg2_btf_id  = BPF_PTR_POISON,
 };
 
+struct bpf_dynptr_file_impl {
+	struct freader freader;
+	/* 64 bit offset and size overriding 32 bit ones in bpf_dynptr_kern */
+	u64 offset;
+	u64 size;
+};
+
 /* Since the upper 8 bits of dynptr->size is reserved, the
  * maximum supported size is 2^24 - 1.
  */
@@ -1686,13 +1694,36 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *pt
 
 u64 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
 {
+	if (bpf_dynptr_get_type(ptr) == BPF_DYNPTR_TYPE_FILE) {
+		struct bpf_dynptr_file_impl *df = ptr->data;
+
+		return df->size;
+	}
+
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
 
+static void bpf_dynptr_advance_offset(struct bpf_dynptr_kern *ptr, u64 off)
+{
+	if (bpf_dynptr_get_type(ptr) == BPF_DYNPTR_TYPE_FILE) {
+		struct bpf_dynptr_file_impl *df = ptr->data;
+
+		df->offset += off;
+		return;
+	}
+	ptr->offset += off;
+}
+
 static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u64 new_size)
 {
 	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
 
+	if (bpf_dynptr_get_type(ptr) == BPF_DYNPTR_TYPE_FILE) {
+		struct bpf_dynptr_file_impl *df = ptr->data;
+
+		df->size = new_size;
+		return;
+	}
 	ptr->size = (u32)new_size | metadata;
 }
 
@@ -1701,6 +1732,25 @@ int bpf_dynptr_check_size(u64 size)
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
 }
 
+static int bpf_file_fetch_bytes(struct bpf_dynptr_file_impl *df, u64 offset, void *buf, u64 len)
+{
+	const void *ptr;
+
+	if (!buf)
+		return -EINVAL;
+
+	df->freader.buf = buf;
+	df->freader.buf_sz = len;
+	ptr = freader_fetch(&df->freader, offset + df->offset, len);
+	if (!ptr)
+		return df->freader.err;
+
+	if (ptr != buf) /* Force copying into the buffer */
+		memcpy(buf, ptr, len);
+
+	return 0;
+}
+
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size)
 {
@@ -1781,6 +1831,8 @@ static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_SKB_META:
 		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
 		return 0;
+	case BPF_DYNPTR_TYPE_FILE:
+		return bpf_file_fetch_bytes(src->data, offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2719,6 +2771,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
+	case BPF_DYNPTR_TYPE_FILE:
+		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__opt, buffer__szk);
+		return err ? NULL : buffer__opt;
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
@@ -2813,7 +2868,7 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end
 	if (start > size || end > size)
 		return -ERANGE;
 
-	ptr->offset += start;
+	bpf_dynptr_advance_offset(ptr, start);
 	bpf_dynptr_set_size(ptr, end - start);
 
 	return 0;
@@ -4252,13 +4307,46 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
 }
 
-__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
+static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
+			    struct bpf_dynptr_kern *ptr)
 {
+	struct bpf_dynptr_file_impl *state;
+
+	/* flags is currently unsupported */
+	if (flags) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
+	if (!state) {
+		bpf_dynptr_set_null(ptr);
+		return -ENOMEM;
+	}
+	state->offset = 0;
+	state->size = U64_MAX; /* Don't restrict size, as file may change anyways */
+	freader_init_from_file(&state->freader, NULL, 0, file, may_sleep);
+	bpf_dynptr_init(ptr, state, BPF_DYNPTR_TYPE_FILE, 0, 0);
+	bpf_dynptr_set_rdonly(ptr);
 	return 0;
 }
 
+__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
+{
+	return make_file_dynptr(file, flags, false, (struct bpf_dynptr_kern *)ptr__uninit);
+}
+
 __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
+	struct bpf_dynptr_file_impl *df = ptr->data;
+
+	if (!df)
+		return 0;
+
+	freader_cleanup(&df->freader);
+	bpf_mem_free(&bpf_global_ma, df);
+	bpf_dynptr_set_null(ptr);
 	return 0;
 }
 
-- 
2.51.0


