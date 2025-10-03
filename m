Return-Path: <bpf+bounces-70306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FECBB770C
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC6D3A72F2
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453F2BDC04;
	Fri,  3 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlt8Z/PT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E729E0E5
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507479; cv=none; b=b3o9B1LHJQxtpKqRErkyO4QGt0TB/BpyaiDiwP6B7uuYTvqcLPQshP7uWlkO2L5SvFlzIYGnLdjJ1UKkVG4Gm2Wa5c3uzUgH0oq9+f/Nc1FYlbfgQ450JBQuMLtNXM23m4DLYUYJfFsm0Frq6oI9SIY31rWqFYxyWhV4IQiGdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507479; c=relaxed/simple;
	bh=btUSt/cngixXdthhcexR4QhQSuFfB1VjrYgXFyjlgYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uswdu485PJM8OzZn+gtVToLeStjACWF/xMyRNreF33oj8Xaf8Q7w+5rupdcLsQw/bmjOQNlaZ1tQwcjUMPyGOoJzxPadC4hmbPx3mejFhZlhAE2Dg75B4eVP1UOxo4pVAfgcT9eKVRZ4kAwYsZnQ23WHEibzN0CF2mREd/TcZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlt8Z/PT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4256866958bso548072f8f.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507475; x=1760112275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VvpdZaygYVQa/rZq5RM6qHl65uolUjUjiWfwCt9zvY=;
        b=Tlt8Z/PTaWN1JrabeRwUgK7A2tW7+ecOq7C9W3U1b8QtNq3Ejo38tGTL9ezpFbIbEg
         MS0BTGwRiyusbzxSgEsxj5hFD3d2hMeZNRkTAzkKCDCR5NhmCWEYnrX2E00bwxA5Rzaq
         yYOQ0hpq+hBZ1hZFm7O/xpELRIgLmvF5150uyKrwYHw/3VzozRLjPsbOUebIG4oXstNl
         diHl6BTjloBx7V9aQx5+Bfe0p7e5uL3wzaZEan+/K5ZCtlemBpuF011uO5OKFeSyx/8X
         GMmWmY5EZLW/XrEmGsMk5T++wvmnJ5ss6H+ZJC0qMOyNRLAUhnvOj6NztBBeA7IQCOdz
         liAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507475; x=1760112275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VvpdZaygYVQa/rZq5RM6qHl65uolUjUjiWfwCt9zvY=;
        b=A5aMboCzNeEr6MZUUQ6vj6lmviTtLwFoqtJfaZXwbFgzh031lzgljrO2WtBhqs4rGd
         iPUIvNtKfjadh4uojQQ5Va23iMxlNjsnyviegbGSn9FGFofT5HbaTUVhTkBIo8tVvqXa
         NAFWrgcDqIy/Bjip//qVIBbp8TVZtigCHZ61OivqTTdwSw3MJA59k56ZR8dTQFZoFvDf
         g+eGRLA/SrPvfc3xTic1P5SkOA32RE1LImiDfgb1OqUqulJmYjXMAWklAoJduhbjAFd3
         vbUtqKZyS95uZ9fqg4EPYY21bIWpn9Tb/ab+ZbRXwlG1uUrNk2ES1xw+nKPX2DIOHgT7
         Q2hw==
X-Gm-Message-State: AOJu0YzpfIPjN7AxGBsB8Mr4j2Tj27yxTk5GSshrv4oYMCQ64DI8VN/s
	rJnelZnf1I4puk5pSqPavGgWaZN+lbjCv5QVXamDsi3z7EX8p4X6WRrcADMDqQ==
X-Gm-Gg: ASbGncsqV7ySetySOrj/9+hF6pc5+UwkoMyOA4Zyn/ffQw3fgMZpNHWLAtPrM/WB5M2
	nSgK4A7utU/HAVxfK6aoNemd6vavmGPoaNjb0sx5Uju1DmnW3U2I/ahqchGB/KwYhMbmZn2FaUj
	q8S6q0ZgzMorxQ8A1id9HigZI1WlEJqqLLxK0cZg33UXF6zWzTgFsm11wTtkQTykycvYPVMxhY4
	TpPoxzyJKfC9fbT57PPN0n8gJG3lFD2ICg+GzeaAr88DwdGpfn1DPXRu01NBmTiVPptvxsU1qc/
	zfRIYxbZlW/N/V9dWyaNFLA0BTD6v6k1Ec7mlsKDsv51wjhs9xE47A2E/Vy1BDWQglm6VAFNwNc
	beUd5J4rsvOmPUvAaX9Lyc0GF7wm7vRs0qu5r
X-Google-Smtp-Source: AGHT+IF4X0vIlODItkMtH2X0uBB9VjXyhzkOHXcp2HSW2TD+8uHd3e34t/Itj886YQLMuLOY79btvA==
X-Received: by 2002:a05:6000:240f:b0:3dc:1a8c:e878 with SMTP id ffacd0b85a97d-4256714c954mr2056405f8f.18.1759507475163;
        Fri, 03 Oct 2025 09:04:35 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe9bsm8524128f8f.22.2025.10.03.09.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:34 -0700 (PDT)
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
Subject: [RFC PATCH v1 02/10] bpf: widen dynptr size/offset to 64 bit
Date: Fri,  3 Oct 2025 17:04:08 +0100
Message-ID: <20251003160416.585080-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Dynptr currently caps size and offset at 24 bits, which isn’t sufficient
for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
helpers/kfuncs to use 64-bit size and offset, ensuring consistency
across the APIs.

This change does not affect internals of xdp, skb or other dynptrs,
which continue to behave as before.

The widening enables large-file access support via dynptr, implemented
in the next patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h                           | 20 +++----
 kernel/bpf/helpers.c                          | 58 +++++++++----------
 kernel/trace/bpf_trace.c                      | 46 +++++++--------
 tools/testing/selftests/bpf/bpf_kfuncs.h      | 12 ++--
 .../selftests/bpf/progs/dynptr_success.c      | 12 ++--
 5 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ea2ed6771cc6..9ab38eaa6af9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1380,19 +1380,19 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_SKB_META,
 };
 
-int bpf_dynptr_check_size(u32 size);
-u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
-const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
-void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
+int bpf_dynptr_check_size(u64 size);
+u64 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u64 len);
+void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u64 len);
 bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
-int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset,
-		       void *src, u32 len, u64 flags);
-void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
-			    void *buffer__opt, u32 buffer__szk);
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset,
+		       void *src, u64 len, u64 flags);
+void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
+			    void *buffer__opt, u64 buffer__szk);
 
-static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u64 offset, u64 len)
 {
-	u32 size = __bpf_dynptr_size(ptr);
+	u64 size = __bpf_dynptr_size(ptr);
 
 	if (len > size || offset > size - len)
 		return -E2BIG;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..44f4a561f845 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1685,19 +1685,19 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *pt
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
 
-u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
+u64 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
 
-static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
+static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u64 new_size)
 {
 	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
 
-	ptr->size = new_size | metadata;
+	ptr->size = (u32)new_size | metadata;
 }
 
-int bpf_dynptr_check_size(u32 size)
+int bpf_dynptr_check_size(u64 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
 }
@@ -1751,8 +1751,8 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
-static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *src,
-			     u32 offset, u64 flags)
+static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr_kern *src,
+			     u64 offset, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1788,8 +1788,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	}
 }
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
-	   u32, offset, u64, flags)
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u64, len, const struct bpf_dynptr_kern *, src,
+	   u64, offset, u64, flags)
 {
 	return __bpf_dynptr_read(dst, len, src, offset, flags);
 }
@@ -1805,8 +1805,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
-		       u32 len, u64 flags)
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset, void *src,
+		       u64 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -2681,12 +2681,12 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
  */
-__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
-				   void *buffer__opt, u32 buffer__szk)
+__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
+				   void *buffer__opt, u64 buffer__szk)
 {
 	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 	enum bpf_dynptr_type type;
-	u32 len = buffer__szk;
+	u64 len = buffer__szk;
 	int err;
 
 	if (!ptr->data)
@@ -2768,8 +2768,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
  */
-__bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
-					void *buffer__opt, u32 buffer__szk)
+__bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
+					void *buffer__opt, u64 buffer__szk)
 {
 	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
@@ -2801,10 +2801,10 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
 	return bpf_dynptr_slice(p, offset, buffer__opt, buffer__szk);
 }
 
-__bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u32 start, u32 end)
+__bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u64 start, u64 end)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
-	u32 size;
+	u64 size;
 
 	if (!ptr->data || start > end)
 		return -EINVAL;
@@ -2837,7 +2837,7 @@ __bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
 	return __bpf_dynptr_is_rdonly(ptr);
 }
 
-__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr *p)
+__bpf_kfunc u64 bpf_dynptr_size(const struct bpf_dynptr *p)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
@@ -2874,14 +2874,14 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
  * Copies data from source dynptr to destination dynptr.
  * Returns 0 on success; negative error, otherwise.
  */
-__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
-				struct bpf_dynptr *src_ptr, u32 src_off, u32 size)
+__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_off,
+				struct bpf_dynptr *src_ptr, u64 src_off, u64 size)
 {
 	struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
 	struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
 	void *src_slice, *dst_slice;
 	char buf[256];
-	u32 off;
+	u64 off;
 
 	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
 	dst_slice = bpf_dynptr_slice_rdwr(dst_ptr, dst_off, NULL, size);
@@ -2903,7 +2903,7 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
 
 	off = 0;
 	while (off < size) {
-		u32 chunk_sz = min_t(u32, sizeof(buf), size - off);
+		u64 chunk_sz = min_t(u64, sizeof(buf), size - off);
 		int err;
 
 		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
@@ -2929,10 +2929,10 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
  * at @offset with the constant byte @val.
  * Returns 0 on success; negative error, otherwise.
  */
- __bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u32 offset, u32 size, u8 val)
- {
+__bpf_kfunc int bpf_dynptr_memset(struct bpf_dynptr *p, u64 offset, u64 size, u8 val)
+{
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
-	u32 chunk_sz, write_off;
+	u64 chunk_sz, write_off;
 	char buf[256];
 	void* slice;
 	int err;
@@ -2951,11 +2951,11 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
 		return err;
 
 	/* Non-linear data under the dynptr, write from a local buffer */
-	chunk_sz = min_t(u32, sizeof(buf), size);
+	chunk_sz = min_t(u64, sizeof(buf), size);
 	memset(buf, val, chunk_sz);
 
 	for (write_off = 0; write_off < size; write_off += chunk_sz) {
-		chunk_sz = min_t(u32, sizeof(buf), size - write_off);
+		chunk_sz = min_t(u64, sizeof(buf), size - write_off);
 		err = __bpf_dynptr_write(ptr, offset + write_off, buf, chunk_sz, 0);
 		if (err)
 			return err;
@@ -4414,7 +4414,7 @@ late_initcall(kfunc_init);
 /* Get a pointer to dynptr data up to len bytes for read only access. If
  * the dynptr doesn't have continuous data up to len bytes, return NULL.
  */
-const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
+const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u64 len)
 {
 	const struct bpf_dynptr *p = (struct bpf_dynptr *)ptr;
 
@@ -4425,7 +4425,7 @@ const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
  * the dynptr doesn't have continuous data up to len bytes, or the dynptr
  * is read only, return NULL.
  */
-void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len)
+void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u64 len)
 {
 	if (__bpf_dynptr_is_rdonly(ptr))
 		return NULL;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8f23f5273bab..7cc4f2e05ed2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3372,13 +3372,13 @@ typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struc
  * direct calls into all the specific callback implementations
  * (copy_user_data_sleepable, copy_user_data_nofault, and so on)
  */
-static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 doff, u32 size,
+static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u64 doff, u64 size,
 						 const void *unsafe_src,
 						 copy_fn_t str_copy_fn,
 						 struct task_struct *tsk)
 {
 	struct bpf_dynptr_kern *dst;
-	u32 chunk_sz, off;
+	u64 chunk_sz, off;
 	void *dst_slice;
 	int cnt, err;
 	char buf[256];
@@ -3392,7 +3392,7 @@ static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 do
 		return -E2BIG;
 
 	for (off = 0; off < size; off += chunk_sz - 1) {
-		chunk_sz = min_t(u32, sizeof(buf), size - off);
+		chunk_sz = min_t(u64, sizeof(buf), size - off);
 		/* Expect str_copy_fn to return count of copied bytes, including
 		 * zero terminator. Next iteration increment off by chunk_sz - 1 to
 		 * overwrite NUL.
@@ -3409,14 +3409,14 @@ static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 do
 	return off;
 }
 
-static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dptr, u32 doff,
-					     u32 size, const void *unsafe_src,
+static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dptr, u64 doff,
+					     u64 size, const void *unsafe_src,
 					     copy_fn_t copy_fn, struct task_struct *tsk)
 {
 	struct bpf_dynptr_kern *dst;
 	void *dst_slice;
 	char buf[256];
-	u32 off, chunk_sz;
+	u64 off, chunk_sz;
 	int err;
 
 	dst_slice = bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
@@ -3428,7 +3428,7 @@ static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dptr, u32
 		return -E2BIG;
 
 	for (off = 0; off < size; off += chunk_sz) {
-		chunk_sz = min_t(u32, sizeof(buf), size - off);
+		chunk_sz = min_t(u64, sizeof(buf), size - off);
 		err = copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
 		if (err)
 			return err;
@@ -3514,58 +3514,58 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
 	return bpf_send_signal_common(sig, type, task, value);
 }
 
-__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u32 off,
-					   u32 size, const void __user *unsafe_ptr__ign)
+__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u64 off,
+					   u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
 				 copy_user_data_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u32 off,
-					     u32 size, const void *unsafe_ptr__ign)
+__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u64 off,
+					     u64 size, const void *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
 				 copy_kernel_data_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u32 off,
-					       u32 size, const void __user *unsafe_ptr__ign)
+__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+					       u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
 				     copy_user_str_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u32 off,
-						 u32 size, const void *unsafe_ptr__ign)
+__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+						 u64 size, const void *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
 				     copy_kernel_str_nofault, NULL);
 }
 
-__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u32 off,
-					  u32 size, const void __user *unsafe_ptr__ign)
+__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u64 off,
+					  u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
 				 copy_user_data_sleepable, NULL);
 }
 
-__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u32 off,
-					      u32 size, const void __user *unsafe_ptr__ign)
+__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+					      u64 size, const void __user *unsafe_ptr__ign)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
 				     copy_user_str_sleepable, NULL);
 }
 
-__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u32 off,
-					       u32 size, const void __user *unsafe_ptr__ign,
+__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u64 off,
+					       u64 size, const void __user *unsafe_ptr__ign,
 					       struct task_struct *tsk)
 {
 	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
 				 copy_user_data_sleepable, tsk);
 }
 
-__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u32 off,
-						   u32 size, const void __user *unsafe_ptr__ign,
+__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u64 off,
+						   u64 size, const void __user *unsafe_ptr__ign,
 						   struct task_struct *tsk)
 {
 	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 794d44d19c88..60405477deb6 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -28,8 +28,8 @@ extern int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, __u64 flags,
  *  Either a direct pointer to the dynptr data or a pointer to the user-provided
  *  buffer if unable to obtain a direct pointer
  */
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
-			      void *buffer, __u32 buffer__szk) __ksym __weak;
+extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u64 offset,
+			      void *buffer, __u64 buffer__szk) __ksym __weak;
 
 /* Description
  *  Obtain a read-write pointer to the dynptr's data
@@ -37,13 +37,13 @@ extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, __u32 offset,
  *  Either a direct pointer to the dynptr data or a pointer to the user-provided
  *  buffer if unable to obtain a direct pointer
  */
-extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u32 offset,
-			      void *buffer, __u32 buffer__szk) __ksym __weak;
+extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u64 offset,
+			      void *buffer, __u64 buffer__szk) __ksym __weak;
 
-extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, __u32 end) __ksym __weak;
+extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u64 start, __u64 end) __ksym __weak;
 extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym __weak;
 extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
-extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
+extern __u64 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym __weak;
 
 /* Description
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 127dea342e5a..e0d672d93adf 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -914,8 +914,8 @@ void *user_ptr;
 char expected_str[384];
 __u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
 
-typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u32 off,
-				    u32 size, const void *unsafe_ptr);
+typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u64 off,
+				    u64 size, const void *unsafe_ptr);
 
 /* Returns the offset just before the end of the maximum sized xdp fragment.
  * Any write larger than 32 bytes will be split between 2 fragments.
@@ -1106,16 +1106,16 @@ int test_copy_from_user_str_dynptr(void *ctx)
 	return 0;
 }
 
-static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u32 off,
-					u32 size, const void *unsafe_ptr)
+static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u64 off,
+					u64 size, const void *unsafe_ptr)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
 
 	return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr, task);
 }
 
-static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u32 off,
-					    u32 size, const void *unsafe_ptr)
+static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u64 off,
+					    u64 size, const void *unsafe_ptr)
 {
 	struct task_struct *task = bpf_get_current_task_btf();
 
-- 
2.51.0


