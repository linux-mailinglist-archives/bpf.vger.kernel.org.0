Return-Path: <bpf+bounces-71471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB9BF3E42
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1293B0464
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853C2F1FEC;
	Mon, 20 Oct 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKhN36lK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD622F2603
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999157; cv=none; b=BL7Dn7ioK/UbmXG3Zg+P9Dnpm5npmRHO9LKnOGK6e6Tep2J3A34uDJ1fJ9hixItywWt0/eaw/t4DQrZR8cFdfPnJIszfUJ/dqw/H93VvCwEiBPe9qiSWrVkc8QkSZLr2bcSgZW6ScDA+JIV5Ox+sP7XkoDQFkcP7jr7+nsAIF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999157; c=relaxed/simple;
	bh=d3c2nGxKz5OLJYBsC5PcKa/U8asgaWVte4munPGoJqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6tnF7Lxlf3RPdYlvUtdmQSP4xdpZECbAw7/om7tO5/v7WCwhRYAt0E87Fa/+mNw9ntWY7WhX9AzVpbuUBZWtR2XznkgtaazkQqovsMawxgQHZpuf0bqY5W0re9z9R0rbQYUS3QvT2Rx7mA815R0BEc6YzYC/Ip6YbiG0auLznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKhN36lK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f7469so38563195e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999154; x=1761603954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtdTbqnODdTS1P81MBgfCWHvijLW2Y8nHLFCptYJH9Y=;
        b=JKhN36lKqwSx5WlKmM7+qTogG5TZATgQx6gpPrkCIhzK28/SZu+qctCuseAFxHUO1V
         04uBVNJVX+vGEaVp+MRfzr5IGXZzJXOroacdU38rj0Y7MzRW6Mqci4JAf73NM9qOMEYn
         RUf2t6bgH5F7qvdSSwQqVIUxjdhf1g6jfxiiokC5vKLFzqY+XsvEr/iJMOuovmst3Afw
         jefcjP7gfX23tZtraoeL5xBYIvdW2JvLqUim4WcGhwIQLnY+sOBkmbr7mpZjIOx0lxx1
         5WSYa/PlYg/YEHj08MeZifo67SbAZm2+2LOKwIpRJ0pLZLBoINWg/UMLv1AebKJXUcsQ
         BPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999154; x=1761603954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtdTbqnODdTS1P81MBgfCWHvijLW2Y8nHLFCptYJH9Y=;
        b=KEho7ss1gLRsAji0SCzrtp4bm7+TVE22rLbB2dBdjF9XzyVgcr+gv5/vb5YRaIUcKo
         9e6VFmQZ4E3JSiLnKvAeCPazA+GqELgRBSy5AY6sg2aBX/FfenyL+gHM3bznmhJ3wQQF
         7j0+7gLsiadvyeSUK8BL7hXPe1zeBFf4Je4r+43fLQJqRO8ahGLdwEvmvL0S6Oceb7Jb
         mJnLlN/2CHfaDgskSpgYxH/Qp41F5RuzHVoaly+J+gWPuPwzqnsCreYlcmqcVv3wYllG
         v3hMH189BoaxJxgholZvli2UpMSGgGH+MFdBCwKKCPxqOdeitkfQz0A6KMg3C07gCFIg
         g4LQ==
X-Gm-Message-State: AOJu0YzLZCnXM8NDq3+4is4udwthk7wckDR434M3yapBKmbT6b4bNtit
	mQBY6zAP/bkBqjTgBBD+9YkUSaWw+tBFRyayJl7SLqQgPOjUrth6ncMbX62q/Q==
X-Gm-Gg: ASbGnct42it0M2xdVQaZ5wcFUGZ8IB/VlyComNMdWi5WATKA8JBAv72dMKfC4TwQkJ3
	qFSGh65x+Y0fbgu+ZSAuVM3l+cEesBptqmMf3jF6bMUnkSW7OJAVcmClXV8pbIZc+4zR7PsS3kq
	BMUqEflU+0PlDhzlCnOu+RUsHDmmOwSHSAE9QSn6/pydJqlpa05eMzFoDm4FUIZEvB85AsmrYh4
	igcbrRy8ajtGOt9TNvsLjpHFOrGZJK4Q34KW1srYW1uPrw1jAUBz78WW+qeT6WOX998wAn9roBr
	tIEHBIQTTzUBiyJwStzg52IXXTqNCq2gvWkF/qwKqzXzf/1eL2gOSe5+28nd1EUoy54IbAYl9QJ
	J4Hake2xHXQbr7exfronOgsmMkZEjlJ0iEJwXC0EPxLKU/O05tdx3n1TmPyg=
X-Google-Smtp-Source: AGHT+IFivMS/dkkmz6Y8HwxDFFTv1xeXhDg3nt4iegtadTeWje2pwUSef7EzDiMmPjmznF4JdrRrqg==
X-Received: by 2002:a05:600c:3b03:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-47117874978mr106710965e9.3.1760999153689;
        Mon, 20 Oct 2025 15:25:53 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9f71sm17298246f8f.37.2025.10.20.15.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 07/10] bpf: add kfuncs and helpers support for file dynptrs
Date: Mon, 20 Oct 2025 23:25:35 +0100
Message-ID: <20251020222538.932915-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/helpers.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bf65b7fb761f..e4c0f39e9210 100644
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
@@ -4252,13 +4307,45 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct b
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


