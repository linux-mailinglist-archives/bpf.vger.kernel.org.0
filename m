Return-Path: <bpf+bounces-72276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059FC0B374
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740C33B6ED4
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B342DC320;
	Sun, 26 Oct 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfZLjroj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098FC201004
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511150; cv=none; b=nl4fLu+YDaRlBc+s+ySLGATyvh4k3yDIPETa3ta0ZWoMXf6EYxIzWtf4bjo5Mj5FmPP4GYe3BiMvZ4QDoAQwwlNebyScvQsY6Hfz146xYP2pxTQTKj5nxT9goCXv0Ip/7Fh6PqhKRYjHmsc1prvGq3U5YzYSoH0+yvxiFC2tNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511150; c=relaxed/simple;
	bh=Y8soCphwJDEwgSA6VLFPZYspScJGsrIMjiGcqMs4sIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZSnsTivhTetfmt8XiWW+cDglikkYG2y9gzW22RM4SBW2cKCM0ZCIQlUXOH53jloWa58HwqlA6RkHLeWEsCZhT9VdZD6+uUjvOzmUIOt4dts4Xbr6B7fq4N0JlJTW3TxcJYvHNtOETZK8vENfKoqFRnzq/UfVZBPKTM56s7yhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfZLjroj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso9574735e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511146; x=1762115946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEi/OWfd9s1CIZ18TPHDTQc7gddqR5BRn5QsBYHqUs0=;
        b=nfZLjrojl8vT0E4TCrl307MPnVM6XxJf+SQhU0BSXyCl364KkpOgVumfX7ePUm3kWw
         dHT3EYguRLhlL0tQFO4GT6/VxkUvQH+CWKsKByvYQBeF/FQpZrnvv/ef/uQtfdZhlu9E
         HLtV9u3SRAlkzljz/xCxgWww93YR4cCkKyj4lQfdicSZWzAwHXd0EeQSm30dWTuRTfX3
         IuyRJnPiKK4G4yb1VN1Iy77IkuJQL8QGUbSyhjNYcsiJPiOt8YLwfbutlVJZa076J1I2
         OooIbWrHBJiYlEPxHvjCyADD3pMSNqA9ktmGGjx2SI85yr8m8iRfqVC3Y8E1iZBqqfXQ
         SZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511146; x=1762115946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEi/OWfd9s1CIZ18TPHDTQc7gddqR5BRn5QsBYHqUs0=;
        b=g3nWrlV3lEjDbI2YTBwD1RZAX2QXjcMDV9rOm7ASJAoABqPj8b3yh/ITp4k8vxp1x3
         0esL7tHOfkBF2pSmToo9X7ZcQmdl+9/h7SYFUyR65EfglgMGfQ0Gwuy0TiBTNqrMHAuL
         bX0enPjcUGSR865ZmDTuQoLDXYsL+XWAPU5EzFC7obgryZnKP7DK+OUMDSXXDRYtt37h
         m/7uGGlLpvqyBHp+Uyb/cfkLZePKbYsm52dlFoDOfQ6y0zTOsKICwhTnBq7889MfDomh
         aXcGlrzYlhVpQkCAHETJgycncJC0lXJJeGK03x0qKiRBz1Gch0OEzA69ml9nhNtJygd5
         +xzQ==
X-Gm-Message-State: AOJu0Ywpf4KLAiEwvchf1BkDhHNbnqAYnsnAn9l7SKA6rZGqgSvYO6Z7
	7JxiJIPPIXiDc3mzEHOguhGcgFh2H63HQHf8U2KX5A8VsRpnFv/Uvq0C0T2Igg==
X-Gm-Gg: ASbGncvaRrsnSd9fZc8Yh3gfb9ldKWJ6oGr8Radp7gWgjmlcINxQonR0w4yi0stAqLL
	4Xe8ITJ4nVUSHVuHuHlNdO2561JWiRz/cUdIiyildVY9TxBgRUKtFvbYHUoGok9ayJbL7k8HteH
	c8zI+DJbPSXiObanoAsJQ1os8qBmYb64Hp4UkA2wQvQAoNWiqgiPxob6pwPF5i6FEjxSzxBFhS8
	vo3ZmV5kqRAt3yI+l0a+uFFL8MEmW9oF0CLZpNh3yc84J5QCIxs8RYGJYgjqebhbbApvYL9q8mX
	Yt15n/J53sh4yBuTlo43RK0PunlqP7JXghZuXYdKcBWQlie0/wx1jQ2NtwE1r9L1NrknefG4lSd
	Q7BDap3GMSw4XxoKJOJuZBX77Za0Hiz+DumLMkimo8bKPNfTRLSajUEawhVZPyzYlHAm8P3PxtX
	OaBteC
X-Google-Smtp-Source: AGHT+IFJPHmyUXMB5SX9Eih0T9au1AKmVZn4Kkv2BpADK89G2y+KedENYzQbiqu+AfJLZDCChV0vfQ==
X-Received: by 2002:a05:600c:4e56:b0:477:58:7d04 with SMTP id 5b1f17b1804b1-47700587e58mr30697135e9.9.1761511146006;
        Sun, 26 Oct 2025 13:39:06 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddd52079sm46342005e9.6.2025.10.26.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:04 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 02/10] bpf: widen dynptr size/offset to 64 bit
Date: Sun, 26 Oct 2025 20:38:45 +0000
Message-ID: <20251026203853.135105-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
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
which continue to behave as before. Also it does not break binary
compatibility.

The widening enables large-file access support via dynptr, implemented
in the next patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h                           | 20 +++---
 include/uapi/linux/bpf.h                      |  8 +--
 kernel/bpf/helpers.c                          | 66 +++++++++----------
 kernel/trace/bpf_trace.c                      | 46 ++++++-------
 tools/include/uapi/linux/bpf.h                |  8 +--
 tools/testing/selftests/bpf/bpf_kfuncs.h      | 12 ++--
 .../selftests/bpf/progs/dynptr_success.c      | 12 ++--
 7 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e53cda0aabb6..907c69295293 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1387,19 +1387,19 @@ enum bpf_dynptr_type {
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
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6829936d33f5..77edd0253989 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5618,7 +5618,7 @@ union bpf_attr {
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
  *
- * long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynptr *ptr)
+ * long bpf_dynptr_from_mem(void *data, u64 size, u64 flags, struct bpf_dynptr *ptr)
  *	Description
  *		Get a dynptr to local memory *data*.
  *
@@ -5661,7 +5661,7 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
+ * long bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr *src, u64 offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
@@ -5671,7 +5671,7 @@ union bpf_attr {
  *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
  *		*flags* is not 0.
  *
- * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
+ * long bpf_dynptr_write(const struct bpf_dynptr *dst, u64 offset, void *src, u64 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
@@ -5692,7 +5692,7 @@ union bpf_attr {
  *		is a read-only dynptr or if *flags* is not correct. For skb-type dynptrs,
  *		other errors correspond to errors returned by **bpf_skb_store_bytes**\ ().
  *
- * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
+ * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u64 offset, u64 len)
  *	Description
  *		Get a pointer to the underlying dynptr data.
  *
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b9ec6ee21c94..a2ce17ea5edb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1684,19 +1684,19 @@ static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *pt
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
@@ -1715,7 +1715,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, size, u64, flags, struct bpf_dynptr_kern *, ptr)
+BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u64, size, u64, flags, struct bpf_dynptr_kern *, ptr)
 {
 	int err;
 
@@ -1750,8 +1750,8 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
-static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *src,
-			     u32 offset, u64 flags)
+static int __bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr_kern *src,
+			     u64 offset, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1787,8 +1787,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	}
 }
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
-	   u32, offset, u64, flags)
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u64, len, const struct bpf_dynptr_kern *, src,
+	   u64, offset, u64, flags)
 {
 	return __bpf_dynptr_read(dst, len, src, offset, flags);
 }
@@ -1804,8 +1804,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
-		       u32 len, u64 flags)
+int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset, void *src,
+		       u64 len, u64 flags)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -1848,8 +1848,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 	}
 }
 
-BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
-	   u32, len, u64, flags)
+BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u64, offset, void *, src,
+	   u64, len, u64, flags)
 {
 	return __bpf_dynptr_write(dst, offset, src, len, flags);
 }
@@ -1865,7 +1865,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
+BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u64, offset, u64, len)
 {
 	enum bpf_dynptr_type type;
 	int err;
@@ -2680,12 +2680,12 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
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
@@ -2767,8 +2767,8 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
  * provided buffer, with its contents containing the data, if unable to obtain
  * direct pointer)
  */
-__bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
-					void *buffer__opt, u32 buffer__szk)
+__bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u64 offset,
+					void *buffer__opt, u64 buffer__szk)
 {
 	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
@@ -2800,10 +2800,10 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
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
@@ -2836,7 +2836,7 @@ __bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
 	return __bpf_dynptr_is_rdonly(ptr);
 }
 
-__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr *p)
+__bpf_kfunc u64 bpf_dynptr_size(const struct bpf_dynptr *p)
 {
 	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
 
@@ -2873,14 +2873,14 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
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
@@ -2902,7 +2902,7 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
 
 	off = 0;
 	while (off < size) {
-		u32 chunk_sz = min_t(u32, sizeof(buf), size - off);
+		u64 chunk_sz = min_t(u64, sizeof(buf), size - off);
 		int err;
 
 		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
@@ -2928,10 +2928,10 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
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
@@ -2950,11 +2950,11 @@ __bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u32 dst_off,
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
@@ -4469,7 +4469,7 @@ late_initcall(kfunc_init);
 /* Get a pointer to dynptr data up to len bytes for read only access. If
  * the dynptr doesn't have continuous data up to len bytes, return NULL.
  */
-const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
+const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u64 len)
 {
 	const struct bpf_dynptr *p = (struct bpf_dynptr *)ptr;
 
@@ -4480,7 +4480,7 @@ const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)
  * the dynptr doesn't have continuous data up to len bytes, or the dynptr
  * is read only, return NULL.
  */
-void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len)
+void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u64 len)
 {
 	if (__bpf_dynptr_is_rdonly(ptr))
 		return NULL;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..a795f7afbf3d 100644
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f5..77edd0253989 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5618,7 +5618,7 @@ union bpf_attr {
  *	Return
  *		*sk* if casting is valid, or **NULL** otherwise.
  *
- * long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynptr *ptr)
+ * long bpf_dynptr_from_mem(void *data, u64 size, u64 flags, struct bpf_dynptr *ptr)
  *	Description
  *		Get a dynptr to local memory *data*.
  *
@@ -5661,7 +5661,7 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
+ * long bpf_dynptr_read(void *dst, u64 len, const struct bpf_dynptr *src, u64 offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
@@ -5671,7 +5671,7 @@ union bpf_attr {
  *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
  *		*flags* is not 0.
  *
- * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
+ * long bpf_dynptr_write(const struct bpf_dynptr *dst, u64 offset, void *src, u64 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
@@ -5692,7 +5692,7 @@ union bpf_attr {
  *		is a read-only dynptr or if *flags* is not correct. For skb-type dynptrs,
  *		other errors correspond to errors returned by **bpf_skb_store_bytes**\ ().
  *
- * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
+ * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u64 offset, u64 len)
  *	Description
  *		Get a pointer to the underlying dynptr data.
  *
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 794d44d19c88..e0189254bb6e 100644
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
+extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, __u64 offset, void *buffer,
+				   __u64 buffer__szk) __ksym __weak;
 
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


