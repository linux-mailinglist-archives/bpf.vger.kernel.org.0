Return-Path: <bpf+bounces-71026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C588DBDF976
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F017357BDF
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A53375D3;
	Wed, 15 Oct 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLII8OTY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF63375A4
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544729; cv=none; b=KexKbI0U18kh+ODCI1rKmqKf3y3QvuU0sEdzIqGwrK4alQ6MSpy/IJg0o/oHu7Yl65rIqLdBDrejKI/3z8x94FV5j6pmG71HVNy3C9R4/xHHCVdQ3kZT1+/qNiUTh3yMeXGI5OO9U3OJIZZc1oHHh9Ahw/3zyCXdpEZ1Ji/UfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544729; c=relaxed/simple;
	bh=z3L6c7oUK/jC5QoNaKCA7Yog/JOfSOfnwE2DZmpYkMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZu6mn1Tp334E86clauiUT4f8ClfClppL3AognZOhboM+8X8JMogMO3L6iCrqvuWiuUBz77tNb55RqgTppB2FAkc6PnvEy3IXag6lVsWYAr+Cw+bA/GpGgzGWGGJ6G6edBD9Fz9Ywm/L14MKQug971Gcb3s0a+dHjt96+NyI+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLII8OTY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so69066965e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544726; x=1761149526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWBMl4py+dYHMRlIrDJ2osZ8L7GNvUnFJGBQWQpS6K0=;
        b=JLII8OTYvTlWK+bNlrQBygo0dth3/ZaCVG2M6GFgX6cRJeKn56W+C9c4GxfwxL208V
         pMKC+9BY5zLxDMvcoJ82rE7v61CS4BHN92cIgpwLjobBRa8cZATd4kDa+rvbpGQ96LVH
         AVTmaWxBWnJBvhaqhkrSXzQQPGKoySUl4j2rCN7U3vRMrtuimCentI9ierYo6Oekk+Sv
         QsfWPa57ZXEc+aBEpW1Ihlinbu8W/q0yYsfyrocRjt2wWCBfdzYUcakfqlxc0M3ZcG9t
         z4N17W1ia9Q3sdkUI/QbeLhLnw+Wneq2aZopG53L3UNhXv3foYegYadb/QF3VZBQTlob
         bfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544726; x=1761149526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWBMl4py+dYHMRlIrDJ2osZ8L7GNvUnFJGBQWQpS6K0=;
        b=fYzuG8BebEL25d5T6qQmyEj49ZMO4Bvr6lxR4ytUvZVK600c8DKUuPBsS9vNdkKVtJ
         1VaaIOmA3p9vKd64hCo/b3oYW8wePw2LN4lJRcIFSsvNOoHQlP8dxCbazxCcvRRKgxjK
         d6/J6lJ6KR0Pj1OLiapZRWwDz5CbCPR4lSMXO3kM6fs3Os1pGA7nFMlq5qj6hZss9M9Q
         4y/GBmJ0TnTspjRU568UNNSsPr1nFSJzwp4o+tLtTRHGK0KXVrXTGWD2Y0CcjkkPuz4l
         ikAjU9hM6EKORZBhHys2Dt4O7MQILOpSDsepVeeWjQahiTPfvG8mZGnRHt5UQurmH42H
         kE+w==
X-Gm-Message-State: AOJu0Yz6/FdqRfR/XkC4Tjo7P8nRUxggk9bn3ATHJII8x/4Q9395gsfC
	qv+bwkYRM8BanZOQhIUML3hLfjJmwE/lEW1F2X+kz6mCfjyCsuW/PO5BpOB6Xw==
X-Gm-Gg: ASbGncuHbvhH1HotkLRo3lbpYApMKLmX+/mwp02HduE7ZxlKOBzBoZU1WancCaaE4hG
	u5F7lcE3T0dTV2kOQkHhQECekpCY30QtDesC1Jxy0yLNbctXdWj2nm4q9UU62sJQg0325u/vtp6
	W0zGYZhdNK24MW261KB53KKC/4QpNNG06B4GCis5FiVo+vc7qzLgWznuDSQc+/zMPdf8l/cWkme
	gkqgELP9BiR+LvDmDewx5UorQ8oZkK3rGEqu9YzgwO4V1D5zLEh/lG0gtoZVXm/t26gcKvsvQrg
	z3re4BNRgSfeAKBkZkYsppHwoE4xZZ/18eA1mNufJvUuV4Zovre4fCefJdotZzZlJmVd08yMKtl
	1lotQkcIwBcrHd/4jagg8vNroOf3lgMtOkAU0dbpbvspS
X-Google-Smtp-Source: AGHT+IHyVWKcfKPY1XhAfIZFKWmjKPSx+iiK7GvZQLlFJp3HAsRqWLhw0wmDYDRjFzq1700gpDS07w==
X-Received: by 2002:a05:600c:138a:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46fa9b171f2mr205949925e9.36.1760544725456;
        Wed, 15 Oct 2025 09:12:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb55ac08dsm299195715e9.13.2025.10.15.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:05 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v2 08/11] bpf: add kfuncs and helpers support for file dynptrs
Date: Wed, 15 Oct 2025 17:11:52 +0100
Message-ID: <20251015161155.120148-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3841c1c51b06..da83298bf916 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/verification.h>
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
+#include <linux/buildid.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1657,6 +1658,13 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
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
@@ -1687,13 +1695,36 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *pt
 
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
 
@@ -1702,6 +1733,25 @@ int bpf_dynptr_check_size(u64 size)
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
@@ -1782,6 +1832,8 @@ static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_SKB_META:
 		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
 		return 0;
+	case BPF_DYNPTR_TYPE_FILE:
+		return bpf_file_fetch_bytes(src->data, offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2720,6 +2772,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
+	case BPF_DYNPTR_TYPE_FILE:
+		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__opt, buffer__szk);
+		return err ? NULL : buffer__opt;
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
@@ -2814,7 +2869,7 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end
 	if (start > size || end > size)
 		return -ERANGE;
 
-	ptr->offset += start;
+	bpf_dynptr_advance_offset(ptr, start);
 	bpf_dynptr_set_size(ptr, end - start);
 
 	return 0;
@@ -4253,13 +4308,45 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
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
 	return 0;
 }
 
-- 
2.51.0


