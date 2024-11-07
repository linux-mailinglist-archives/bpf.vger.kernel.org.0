Return-Path: <bpf+bounces-44283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11229C0D4C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D4A1C22131
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68E212D2F;
	Thu,  7 Nov 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekxWioa8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00C216A05
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001885; cv=none; b=bMPOyJWixuEJITbJq7Yn+d+hDvAq+vIk0yhlb8Ec1KQRO6DFKM/+3rhNVaKvcQNiIGv28lCyJ7jQL41CSjGRCrMbAwR4HndV7/J+saVlS37KWpz8Cb+R20194pVjYiZpEnulITohhknxUzpYkCHr8hUArJTzySG7GNGibluv07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001885; c=relaxed/simple;
	bh=oW91gCnVMwg9DIRtLp0k1CHM7PF1ieKhVgMIclNINR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3VcWnpwwKmzTqfZgFCzfKfctP8o5EQYiI6fxYbUcLi+m5ikzSPuC/5vIIvCV16niUMZ3xEZ9+wBJWkiFzxSMj47tG2UrpLKnv/zZJGHJ9NKGcIBmgwlCXxMuq/5iEcYzzcDl4NQ7KCAn+iNla6/NaCqeft8E+ldsrDCArfva00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekxWioa8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-723db2798caso1388750b3a.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001882; x=1731606682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEwRw6+SXFlRIzrlzuQPxNceZftpdi9RGljhRNon29g=;
        b=ekxWioa8WBEv7ksQ+jQiGR+mJ0KgGUttvZA1s1icKFam7txG1Vm9p03PxW0Pnu9kmw
         HAy34SwJBNMU8p0cQBgzayiowPtMvuJMn095xlQeN/Zwgpa3DjtrDIR5p4RvBxvzYlAG
         7DJbQd1wwng8t1Kt0I3H3UUvGuDJIeljxzNpDbY2PaHOBvzYHYIgGG6NjewRBaPOnsd7
         JS+s3AD7jEZij3U4AyjOQghuI38j46aLSVEANi/SYr/vkJBogiYr63DRxYh0nGYCcWXj
         9iCstcmrSSPJNXSHmoqkVZyzq24+lXJddl6G8OWm3peGan1wzp6WsJkir2urep+FD3oe
         Mfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001882; x=1731606682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEwRw6+SXFlRIzrlzuQPxNceZftpdi9RGljhRNon29g=;
        b=VTuWTDPvaI1dDGvmhJuozw4iFY28uTJYUht4XCO1Kn562BlZ3d4XKySLULVi1fL3IJ
         o1dzA9Fqaim/J3R5cTX0dikWigO6DHVvNFRlZAE7DSUd7F5mM+mGm3M1LzH6DTXt4fWf
         ydVONqO/sZagOh8tP/BZRp5AgQX1b0sN9SlbcyJHJBUzys5G4ykXFkCa8ZF6nzJNmwWE
         KGavMhR/qwe6fA8Vj52oJ63T3hE6alSePrn8KmMArWjVGob3TXNI4TMMx//lFtiZtn49
         q9NfVuTCjlDktdM+12raxm6LpecokSoU4Zwm8SsNU85iuUyUoTmRlfHEa1//+ZnidH1k
         1W1A==
X-Gm-Message-State: AOJu0Yxj7/MQOFevXRJNk8yDU8yjC9+9Ds+PAgLCDftA3X33EBic7/B8
	kLGf0mYq/7L/2IJ3ovb3EA1fnvvzTdqf/GZhHbpRNF6up0DbTKhx7KltIjZD
X-Google-Smtp-Source: AGHT+IGaFRiMFprdIUhapaOilECBb3k8QGpcxhXmxkXOBXim9dLPhAqgh4ow8+FuaMS2UhiFg98Yfw==
X-Received: by 2002:a17:90b:3c01:b0:2e0:cac6:15f7 with SMTP id 98e67ed59e1d1-2e9b147340bmr129272a91.0.1731001882267;
        Thu, 07 Nov 2024 09:51:22 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:21 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 09/11] bpf: move selected dynptr kfuncs to inlinable_kfuncs.c
Date: Thu,  7 Nov 2024 09:50:38 -0800
Message-ID: <20241107175040.1659341-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Namely, move the following kfuncs:
- bpf_dynptr_is_null
- bpf_dynptr_is_rdonly
- bpf_dynptr_size
- bpf_dynptr_slice

Thus allowing verifier to inline these functions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h           |  36 +++++++++-
 kernel/bpf/Makefile           |   1 +
 kernel/bpf/helpers.c          | 130 +---------------------------------
 kernel/bpf/inlinable_kfuncs.c | 112 +++++++++++++++++++++++++++++
 4 files changed, 148 insertions(+), 131 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 75f57f791cd3..7ca53e165ab0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1319,11 +1319,43 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_XDP,
 };
 
+/* Since the upper 8 bits of dynptr->size is reserved, the
+ * maximum supported size is 2^24 - 1.
+ */
+#define DYNPTR_MAX_SIZE	((1UL << 24) - 1)
+#define DYNPTR_TYPE_SHIFT	28
+#define DYNPTR_SIZE_MASK	0xFFFFFF
+#define DYNPTR_RDONLY_BIT	BIT(31)
+
 int bpf_dynptr_check_size(u32 size);
-u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+
+static inline u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
+{
+	return ptr->size & DYNPTR_SIZE_MASK;
+}
+
 const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
 void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
-bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
+
+static inline bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
+{
+	return ptr->size & DYNPTR_RDONLY_BIT;
+}
+
+static inline enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
+{
+	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
+}
+
+static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+{
+	u32 size = __bpf_dynptr_size(ptr);
+
+	if (len > size || offset > size - len)
+		return -E2BIG;
+
+	return 0;
+}
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3d7ee81c8e2e..e806b2ea5d81 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -63,6 +63,7 @@ LLC ?= $(LLVM_PREFIX)llc$(LLVM_SUFFIX)
 # -fpatchable-function-entry=16,16 is $(PADDING_CFLAGS)
 CFLAGS_REMOVE_inlinable_kfuncs.bpf.bc.o += $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_inlinable_kfuncs.bpf.bc.o += $(PADDING_CFLAGS)
+CFLAGS_inlinable_kfuncs.bpf.bc.o += -D__FOR_BPF
 $(obj)/inlinable_kfuncs.bpf.bc.o: $(src)/inlinable_kfuncs.c
 	$(Q)$(CLANG) $(c_flags) -emit-llvm -c $< -o $@
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 395221e53832..75dae5d3f05e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1641,19 +1641,6 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 	.arg2_btf_id  = BPF_PTR_POISON,
 };
 
-/* Since the upper 8 bits of dynptr->size is reserved, the
- * maximum supported size is 2^24 - 1.
- */
-#define DYNPTR_MAX_SIZE	((1UL << 24) - 1)
-#define DYNPTR_TYPE_SHIFT	28
-#define DYNPTR_SIZE_MASK	0xFFFFFF
-#define DYNPTR_RDONLY_BIT	BIT(31)
-
-bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
-{
-	return ptr->size & DYNPTR_RDONLY_BIT;
-}
-
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
 {
 	ptr->size |= DYNPTR_RDONLY_BIT;
@@ -1664,16 +1651,6 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
-{
-	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
-}
-
-u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr)
-{
-	return ptr->size & DYNPTR_SIZE_MASK;
-}
-
 static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
 {
 	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
@@ -1700,16 +1677,6 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
-{
-	u32 size = __bpf_dynptr_size(ptr);
-
-	if (len > size || offset > size - len)
-		return -E2BIG;
-
-	return 0;
-}
-
 BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, size, u64, flags, struct bpf_dynptr_kern *, ptr)
 {
 	int err;
@@ -2540,76 +2507,8 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
 	return p;
 }
 
-/**
- * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
- * @p: The dynptr whose data slice to retrieve
- * @offset: Offset into the dynptr
- * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
- * @buffer__szk: Size (in bytes) of the buffer if present. This is the
- *               length of the requested slice. This must be a constant.
- *
- * For non-skb and non-xdp type dynptrs, there is no difference between
- * bpf_dynptr_slice and bpf_dynptr_data.
- *
- *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
- *
- * If the intention is to write to the data slice, please use
- * bpf_dynptr_slice_rdwr.
- *
- * The user must check that the returned pointer is not null before using it.
- *
- * Please note that in the case of skb and xdp dynptrs, bpf_dynptr_slice
- * does not change the underlying packet data pointers, so a call to
- * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers in
- * the bpf program.
- *
- * Return: NULL if the call failed (eg invalid dynptr), pointer to a read-only
- * data slice (can be either direct pointer to the data or a pointer to the user
- * provided buffer, with its contents containing the data, if unable to obtain
- * direct pointer)
- */
 __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
-				   void *buffer__opt, u32 buffer__szk)
-{
-	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
-	enum bpf_dynptr_type type;
-	u32 len = buffer__szk;
-	int err;
-
-	if (!ptr->data)
-		return NULL;
-
-	err = bpf_dynptr_check_off_len(ptr, offset, len);
-	if (err)
-		return NULL;
-
-	type = bpf_dynptr_get_type(ptr);
-
-	switch (type) {
-	case BPF_DYNPTR_TYPE_LOCAL:
-	case BPF_DYNPTR_TYPE_RINGBUF:
-		return ptr->data + ptr->offset + offset;
-	case BPF_DYNPTR_TYPE_SKB:
-		if (buffer__opt)
-			return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
-		else
-			return skb_pointer_if_linear(ptr->data, ptr->offset + offset, len);
-	case BPF_DYNPTR_TYPE_XDP:
-	{
-		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
-		if (!IS_ERR_OR_NULL(xdp_ptr))
-			return xdp_ptr;
-
-		if (!buffer__opt)
-			return NULL;
-		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
-		return buffer__opt;
-	}
-	default:
-		WARN_ONCE(true, "unknown dynptr type %d\n", type);
-		return NULL;
-	}
-}
+				   void *buffer__opt, u32 buffer__szk);
 
 /**
  * bpf_dynptr_slice_rdwr() - Obtain a writable pointer to the dynptr data.
@@ -2705,33 +2604,6 @@ __bpf_kfunc int bpf_dynptr_adjust(const struct bpf_dynptr *p, u32 start, u32 end
 	return 0;
 }
 
-__bpf_kfunc bool bpf_dynptr_is_null(const struct bpf_dynptr *p)
-{
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
-
-	return !ptr->data;
-}
-
-__bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
-{
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
-
-	if (!ptr->data)
-		return false;
-
-	return __bpf_dynptr_is_rdonly(ptr);
-}
-
-__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr *p)
-{
-	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
-
-	if (!ptr->data)
-		return -EINVAL;
-
-	return __bpf_dynptr_size(ptr);
-}
-
 __bpf_kfunc int bpf_dynptr_clone(const struct bpf_dynptr *p,
 				 struct bpf_dynptr *clone__uninit)
 {
diff --git a/kernel/bpf/inlinable_kfuncs.c b/kernel/bpf/inlinable_kfuncs.c
index 7b7dc05fa1a4..aeb3e3f209f7 100644
--- a/kernel/bpf/inlinable_kfuncs.c
+++ b/kernel/bpf/inlinable_kfuncs.c
@@ -1 +1,113 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/skbuff.h>
+#include <linux/filter.h>
+
+__bpf_kfunc bool bpf_dynptr_is_null(const struct bpf_dynptr *p);
+__bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p);
+__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr *p);
+__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
+				   void *buffer__opt, u32 buffer__szk);
+
+__bpf_kfunc bool bpf_dynptr_is_null(const struct bpf_dynptr *p)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
+	return !ptr->data;
+}
+
+__bpf_kfunc bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
+	if (!ptr->data)
+		return false;
+
+	return __bpf_dynptr_is_rdonly(ptr);
+}
+
+__bpf_kfunc __u32 bpf_dynptr_size(const struct bpf_dynptr *p)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+
+	if (!ptr->data)
+		return -EINVAL;
+
+	return __bpf_dynptr_size(ptr);
+}
+
+/**
+ * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
+ * @p: The dynptr whose data slice to retrieve
+ * @offset: Offset into the dynptr
+ * @buffer__opt: User-provided buffer to copy contents into.  May be NULL
+ * @buffer__szk: Size (in bytes) of the buffer if present. This is the
+ *               length of the requested slice. This must be a constant.
+ *
+ * For non-skb and non-xdp type dynptrs, there is no difference between
+ * bpf_dynptr_slice and bpf_dynptr_data.
+ *
+ *  If buffer__opt is NULL, the call will fail if buffer_opt was needed.
+ *
+ * If the intention is to write to the data slice, please use
+ * bpf_dynptr_slice_rdwr.
+ *
+ * The user must check that the returned pointer is not null before using it.
+ *
+ * Please note that in the case of skb and xdp dynptrs, bpf_dynptr_slice
+ * does not change the underlying packet data pointers, so a call to
+ * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers in
+ * the bpf program.
+ *
+ * Return: NULL if the call failed (eg invalid dynptr), pointer to a read-only
+ * data slice (can be either direct pointer to the data or a pointer to the user
+ * provided buffer, with its contents containing the data, if unable to obtain
+ * direct pointer)
+ */
+__bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
+				   void *buffer__opt, u32 buffer__szk)
+{
+	const struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)p;
+	enum bpf_dynptr_type type;
+	u32 len = buffer__szk;
+	int err;
+
+	if (!ptr->data)
+		return NULL;
+
+	err = bpf_dynptr_check_off_len(ptr, offset, len);
+	if (err)
+		return NULL;
+
+	type = bpf_dynptr_get_type(ptr);
+
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return ptr->data + ptr->offset + offset;
+	case BPF_DYNPTR_TYPE_SKB:
+		if (buffer__opt)
+			return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
+		else
+			return skb_pointer_if_linear(ptr->data, ptr->offset + offset, len);
+	case BPF_DYNPTR_TYPE_XDP:
+	{
+		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
+		if (!IS_ERR_OR_NULL(xdp_ptr))
+			return xdp_ptr;
+
+		if (!buffer__opt)
+			return NULL;
+		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer__opt, len, false);
+		return buffer__opt;
+	}
+	default:
+	// TODO: can't handle inline assembly inside this when compiling to BPF
+#ifndef __FOR_BPF
+		WARN_ONCE(true, "unknown dynptr type %d\n", type);
+#endif
+		return NULL;
+	}
+}
-- 
2.47.0


