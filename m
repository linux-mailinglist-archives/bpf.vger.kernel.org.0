Return-Path: <bpf+bounces-71630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D1BF8815
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B61E1353116
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA1325A355;
	Tue, 21 Oct 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ5L4dvP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448C265CDD
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077034; cv=none; b=IsHBV/MNDQx0nKAa/whubl+FjfPtPgSTffK2hJGVLx5ZbzQUwsQLAGlmn96YzFt/FolIPnk5qAtfrr8hu19ek2rffQox77ZXQF5lLFqQiaIEJZvfYLx9qX69f6vxGAXlfADBvNTFGRsf1Khsu3/LN5tOODDJGNTBnQRoQMXiplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077034; c=relaxed/simple;
	bh=LTwgBndDgEP+zoZExfbzSjdxz122PE91/gSx6czbxcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6DfUApSF0M2/EIPFYLw7iCT7wx7Hb0PNmTrJ+qd8IpCK3FxlFt6CklRub74ift7DMmV8E6/se25ABTq3GwcEMXS1WhZV3DxaIYyKzwRCUyARK8UN22iARbMyLkBQRH+0NEzmmjPPEtResgt2qCGk8t9jezARaFx9XJaNlvjSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ5L4dvP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ece1102998so5069913f8f.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077031; x=1761681831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRWe4BWBZ6A/KLjRwJUxbMK24jm00EDTNEyu/N/A2Ug=;
        b=UZ5L4dvPQOG597rygxeYqZRvG5b9g5qO15EhgMd7i1j5CI6bViFghwyRqQexsK6+TN
         i2RR5aseeGPUjkrZl8+eTqUzH7bXgpSvtnFJy1SfExmAM4+JNLRDgZ3YBHRuWJ3TOiBQ
         giQlAOXiivjHRgVqJIl0dRHYe1r0ycKCKOghWYnSmPHRzRPD9nSgBqhJ2+t1VnqYhXeN
         KC0Oa4pa2iS+pr3kFSCJ6ov9Gyvcg1WSwXbehgWzvroGLvs6WSgdrpB2IswPKOXn/Bv9
         q91q+ORWSKKZL7dg7p14GYHBOOXI6Fwz29iCKxmL7JL/oV0jHc4ln1Fhh88pTRS+v9+1
         +v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077031; x=1761681831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRWe4BWBZ6A/KLjRwJUxbMK24jm00EDTNEyu/N/A2Ug=;
        b=e4NkD2fREqYe5d4B0X/j7Zabrw3WCWejpFWBZDljba25JP522ZAAYSHmzBtdPA+0ZM
         YHNaMkJIw3eDV+SpUaJBK4BIkBivbu43dsWEQpTthuyUZaIZrZvR0BrfZIudl5x3qJ3v
         mDBJPBMsjno+LqVot9IS56XzRE7M04nMD8Fa3bORdmLL0hZ2SdoVLUukNPsyztIGLel1
         cw7QX0R93QZSEo3PLesdssRrE3lezNbUpCBH3u7GbqAHV2tjy1FLiyaQY8SCdXspmlRm
         E8KAyMs3WURWdj3Ei8tlVh/hZ9Xuqa33equasCXsRqoQKZte9F4aeOjthfKOcAk80pxi
         pxUw==
X-Gm-Message-State: AOJu0YxQGOyAlvL+e2y0wQJ+KuK3fA848DyUCj1vFjDfPjNJXmEyFEg2
	yqeETfePobLyiWKRR9NkI5dDkrR/7PZaQDFd3z3sHmVgSF4lKrwzkA7/Y11wsw==
X-Gm-Gg: ASbGnctYlbemm5eaVnN96M60g8Fo+j6TOSOy+xTfTDLb/MzAkicFkXziz0DoCzA3MFV
	k9XOZTAjiPin71QBdHQPQ7MfhuZ2k49REmk4LOQ1F19gJJmwyDRXIq1i62a84DWKxLqjjggnvpe
	o+k3IAw6/lnZ3Y6PeOH6StgJoHEVVq0VsD+/PHiiA3zzmu47wzYwi2dOkDx1VS1UV7V6pTxWC6I
	0AKaj0BebHfewYJLiaxj5k3S6YUOOc1He4uI0P4OcSX4XEoyqiHO6H6bZOOh88260Xrfmm+vpBG
	Jof6rz5PCUHkzyPo1mdUo7Ypj5zd1/E9dIXgF3DHKa94XOGaPjNFWVWEbdUvWwpCxc0QZZDidiV
	mOtcjB8RqGEyOfXU9suWgk69L0xz/lCPrmGQUuupfsfQetDdd5bJ9ic2d5Wgt6qDH6zVY9uQ=
X-Google-Smtp-Source: AGHT+IEAvQpgrJTiKwCJvA3bswQwUY0BnWwMXUSWvVKMAFvBRyEdDZ7AzDmXnTgA2hiFZgS+9Guu2g==
X-Received: by 2002:a05:6000:2c0a:b0:3e8:f67:894a with SMTP id ffacd0b85a97d-42704d8357dmr13025014f8f.5.1761077030555;
        Tue, 21 Oct 2025 13:03:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fdfsm21648923f8f.40.2025.10.21.13.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 07/10] bpf: add kfuncs and helpers support for file dynptrs
Date: Tue, 21 Oct 2025 21:03:31 +0100
Message-ID: <20251021200334.220542-8-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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


