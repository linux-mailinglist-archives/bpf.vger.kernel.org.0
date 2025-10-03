Return-Path: <bpf+bounces-70311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD5BB7712
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33587189B4DD
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E542BE62B;
	Fri,  3 Oct 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWYS2Zj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3CD2BE03D
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507485; cv=none; b=RGwlBiK4HrYLkRnUORh7jIxiSUg6fbewA7cazQFTYptlA/ySEQX0cVT8Kq403OzmA8HQcXOySHOeGxP00wDSt7oswBtMi2cUWebC8Q+r5uotbr89ZeeIzG8uajYb4vchVGfxIBoaB2TbUWvrbVHC6LUXokZ6UjQeq5gwQlaeY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507485; c=relaxed/simple;
	bh=6AUDyUHpIcGhkAFaUBkGF+USBVpBotC5/CoD7zIDGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vaw3XIyaeHKiOiTYs2+ilK8oH5zMXSQOQXzceIecESPIFU2U/HE+zB3Xswe4qYNrJM13DokKZfCHtTa0hMLVyY/jHNaUJ9lh31268mSJ03B1W0DssWs1Uwf2OypgO+dXkkp10nauM7FFoDkTzoAUdrlj+qxn4ktdKwLMRl06HUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWYS2Zj6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so25203425e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507482; x=1760112282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeOxX8d3zrk5xE402MnMtzUeih07Q8gmFmYall8k4+w=;
        b=IWYS2Zj6X6H0fZe9/fpCpcTDwCPov6HtHwoaV47Ss69Xdd2FkmmdeP4WkrB9/lCtX9
         4dOhyIIxG7gp0jV1tdCccg1h6osQx/kZRWmJf0MET947+ApMeHeHvUDBKcRfnhgLW6di
         HASSIPrmk2QvMbEOvo2xXiTgkksHqfS6Afy+g8p19/cJCLtgwN4X2JuIZ3x0FmPxVZdX
         AP4fhrl0dvaECWMNN3h4v6ACUd+TLzk6gAuBfhe/iyD71tFhzNqcT1kbah7xa4flaGTW
         khvs3cgLI9qCJT9bvAzmsrOgxkvtq05vk1EeiWQJFY3MMQdaQfHNPB7ntNsXkSsn5oFn
         GadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507482; x=1760112282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeOxX8d3zrk5xE402MnMtzUeih07Q8gmFmYall8k4+w=;
        b=CsUU0fkXdIBqRgchbYK1Vp6QltdyRI/EMN4Ai8HznXpHUfBqP87ToizOZtjgsTtw65
         FYvOuhDrl+TNnRtb+0tOgJD3NaiUw9/YJXuOJeVjNlS7cjDtFaJJl+kwPDD6IfSv29fV
         4BYXY/ZZ3oahWRNYEuT+b8aWjiiBuKFLCg87gRtLYxkT6gElvheCnsj2MJCiZawMQyBm
         4m0qsN820rZ2qnXeff17svj25mXgEHkMp/VL65A+aqB/Z++Kl2wuuB90Xw7zq12CQrMk
         aqZkyUKJBbgKjUvw8CgFhYM0KkcUz8DJnadNMiFAff/YBUmCay/zrAld4oIXidGMceq4
         Lebw==
X-Gm-Message-State: AOJu0YxeUfZz1CA9b1KDnBMAwZY35EqgFBMT5iJejQVIqMgjB33+fvwD
	VpiMkb13KSx9dPtND9yFwJ/H50Xkol3JVwOvUTLuT/7E6H+vqU0sVPTROsimPQ==
X-Gm-Gg: ASbGncvEBpoRErj9HuVwLiKteA5M8CAKRknwXY25TTGb+QZmrwTdfMfMz3aF1yQycfm
	JGa2NzAkisGmrm/CTOOVDFCOVng9xJ6hQnM8533RsUEEYBXD9CmnVhU8TAjABDv/HWE/jqMdR2p
	pOSBBYMMIMDkTwlvOLHHsgu7svsnCprQ/X32t79C6hgjVuGopvIr0dCm7QssljEJUjck1B/Cmc1
	dTTplfc13EQ9F9g4iicm2zIZcIiAxqKSMYJyVX8eHsHnMxWKAKadj3xIQyrk1oznqc/EJG7f35R
	xiWeYeUPWGwC/z6E0AOGJHoizmoypnHWE0y5+NK8D9PCkCsj8th4MGcx9nO4InvaxXmL5kDiH3o
	ak7/QTkGUujFLlJ2DBRn3sN0fU9iIzMOR0ywT
X-Google-Smtp-Source: AGHT+IEFkH88/ZMzmTH+OC+VJNgO+1xDTtkStDKOCPqcr8Lv29tlw8xicmyXenlKM/OrciX0bPB1XA==
X-Received: by 2002:a05:600c:45d0:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46e7115cde4mr24480125e9.34.1759507481847;
        Fri, 03 Oct 2025 09:04:41 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5e4922sm79480815e9.1.2025.10.03.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:41 -0700 (PDT)
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
Subject: [RFC PATCH v1 07/10] bpf: add kfuncs and helpers support for file dynptrs
Date: Fri,  3 Oct 2025 17:04:13 +0100
Message-ID: <20251003160416.585080-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/helpers.c | 97 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6f6aba03dda8..4bba516599c7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/verification.h>
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
+#include <linux/freader.h>
 
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
+	if (!buf || len == 0)
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
@@ -2177,6 +2229,35 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 	}
 }
 
+enum bpf_is_sleepable {
+	MAY_SLEEP,
+	MAY_NOT_SLEEP,
+};
+
+static int make_file_dynptr(struct file *file, u32 flags, enum bpf_is_sleepable sleepable,
+			    struct bpf_dynptr_kern *ptr)
+{
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
+	freader_init_from_file(&state->freader, NULL, 0, file, sleepable == MAY_SLEEP);
+	bpf_dynptr_init(ptr, state, BPF_DYNPTR_TYPE_FILE, 0, 0);
+	bpf_dynptr_set_rdonly(ptr);
+	return 0;
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
@@ -2720,6 +2801,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
 		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
+	case BPF_DYNPTR_TYPE_FILE:
+		err = bpf_file_fetch_bytes(ptr->data, offset, buffer__opt, buffer__szk);
+		return err ? NULL : buffer__opt;
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
@@ -2814,7 +2898,7 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end
 	if (start > size || end > size)
 		return -ERANGE;
 
-	ptr->offset += start;
+	bpf_dynptr_advance_offset(ptr, start);
 	bpf_dynptr_set_size(ptr, end - start);
 
 	return 0;
@@ -4201,11 +4285,20 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
 
 __bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, struct bpf_dynptr *ptr__uninit)
 {
-	return 0;
+	return make_file_dynptr(file, flags, MAY_NOT_SLEEP, (struct bpf_dynptr_kern *)ptr__uninit);
 }
 
 __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 {
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)dynptr;
+	struct bpf_dynptr_file_impl *df;
+
+	if (bpf_dynptr_get_type(ptr) == BPF_DYNPTR_TYPE_INVALID)
+		return 0;
+
+	df = ptr->data;
+	freader_cleanup(&df->freader);
+	bpf_mem_free(&bpf_global_ma, df);
 	return 0;
 }
 
-- 
2.51.0


