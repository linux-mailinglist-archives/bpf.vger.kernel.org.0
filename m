Return-Path: <bpf+bounces-57805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD78AB05CB
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300C69870EC
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9AA226CF6;
	Thu,  8 May 2025 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuG7g7pX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C491A2390
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741997; cv=none; b=kP+L7Frj2RlQFbPpCNg5N/VqTwCFb3nQZSFVGxFq+TaW7Y6KgbvWdqRwwOAYgxzvYSphSL1z8HBeWj2k2tVfq5OSx17mDK3vPF6f5eoKI4qoZuIaZN64cgChqHguYHIWnuwjchCK5NJa+L8mrLpZaFx8bI226UuWFzYkNiux46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741997; c=relaxed/simple;
	bh=F9GqCz5/15dQhYu0Syk2ysLRILfpWMftfoMgqIy6fOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGjEgDU9ocZgTGRyUqwmQgz2Gc7WlQ6b335wRj8/f3MC/efVsKjXxswm9EVS8h9U03Ut5KJTIXxrq6P7FoK2vPAfqNN6/oo4U+Qzspodv4+xMrbWMuyHlJPa79cJHQb0CTU1gmHftRSPImsXcGGMZCI6CFWhAWWuCJ3i+quqcM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuG7g7pX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0b9c371d8so1161941f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746741993; x=1747346793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2sv0PYddOklzbMY2R2og6dfJ1JSxpgMx+9gFejBVtQ=;
        b=PuG7g7pX+JzrHS0E2c++cmStlQGSxwFnuWKFvdC3jDcq6QdAHOUS2vhrIPNGnvohJf
         EPgQOo53dVeL/iDPaNDdKVQdPcWLHKl+KnIIMQU31wMfJ5trKYLPAsjUiCpPiK2WIVym
         WXC4u37KweS2RyjyOLi9VTBnX7zdjDBN9oBlaHhbXWN+cplSp0IihXMj3gHJF3KonPVC
         cjJ0UN5vhK/fP2zdPNfH5sPL3BTKBPPSeh1Xp80GfizM8KLF4fxs1nOOMoJE0luX6dgi
         zqI9HpOSM9dIz+zSC9UQMofUJaHVUwE69IvH0h2pd/aiSeVm2FcE6xIOnZoVQbcO1Izr
         P68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741993; x=1747346793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2sv0PYddOklzbMY2R2og6dfJ1JSxpgMx+9gFejBVtQ=;
        b=I1vQoEx41rYfn5Cyyi8dhtvE+poFDPrgKpCqjGBural6gq14UooR1Q6PviIg3LYnh6
         Qmh4HeLGGyqIV4V+HGmCspkzFAWHDnRC33fneZJs/S+VM8GBJfZaf2Ek9BMPFHLsnZ2C
         O0QgryYiNP6vW8cId3PeceBQZ5NM5stVre3V6ev0Qlg4KHqDgzjC7i0o+WrMou9sPCg2
         WCTJezyabA28i6bJtuhscv78E0WsCJ0W/zdq3t2o3y0og5byJmHo50zXcmyojTPVVYGC
         ZSR+crOjK6tIfL7AUU3izyC46to3tv3iLwBuHFiuvPKZK4PNzLSj5t8oqMJIMgf1mb5a
         yV0g==
X-Gm-Message-State: AOJu0YybmnbUJtAftThq6+qYyFpOip/Tix6rflQdQtzh0rvpkpcsjk6t
	9yazYAphuqfP1eysNxoEnzIgwZSDsFvZV5b3RsmUVYxZEf3bxnrNKD+qUg==
X-Gm-Gg: ASbGnctRC5EhPELBeIzd9YGNh5vG7f7VzTkWJDtk/jcauhc+bvmDROiIQc7e9aM46Vy
	jou7AduBRF5oNVFGGv+d5Ixhy3RuLU3z4BA2cJSOjjScc+b75LFq1EAYDhSfp+c0E6P57UgcSQL
	kEaCgEQks3hyoAn9CznHrWChMzZmgBrjuEpWWJcyU/3aKh54bca1wcirhadOEOg3/2pBt7qZwhY
	4igs/dOJu2vyM13UNvH/kEIqOOafrQDzid+vCUBSVXFzxdVOX7ekiQFfKajh1hg0GZScvkDAZI3
	m9POdRSY1G+thuymisOaRa2wpWu6pGu7cVOpg2F0/Y8c4y0AzWFF88LNLJI=
X-Google-Smtp-Source: AGHT+IEtgCJ22hswCKBCM7lHBVkO9C51khB81gdpId1RjR+ObQyNq2YJt7DHKTqjcZVnyjrCP5/aiQ==
X-Received: by 2002:a5d:64ad:0:b0:3a0:b4f1:8bda with SMTP id ffacd0b85a97d-3a1f643ac2fmr813815f8f.1.1746741993014;
        Thu, 08 May 2025 15:06:33 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ed0a5sm1168830f8f.21.2025.05.08.15.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:06:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 2/3] bpf: implement dynptr copy kfuncs
Date: Thu,  8 May 2025 23:06:23 +0100
Message-ID: <20250508220624.255537-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com>
References: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch introduces a new set of kfuncs for working with dynptrs in
BPF programs, enabling reading variable-length user or kernel data
into dynptr directly. To enable memory-safety, verifier allows only
constant-sized reads via existing bpf_probe_read_{user|kernel} etc.
kfuncs, dynptr-based kfuncs allow dynamically-sized reads without memory
safety shortcomings.

The following kfuncs are introduced:
* `bpf_probe_read_kernel_dynptr()`: probes kernel-space data into a dynptr
* `bpf_probe_read_user_dynptr()`: probes user-space data into a dynptr
* `bpf_probe_read_kernel_str_dynptr()`: probes kernel-space string into
a dynptr
* `bpf_probe_read_user_str_dynptr()`: probes user-space string into a
dynptr
* `bpf_copy_from_user_dynptr()`: sleepable, copies user-space data into
a dynptr for the current task
* `bpf_copy_from_user_str_dynptr()`: sleepable, copies user-space string
into a dynptr for the current task
* `bpf_copy_from_user_task_dynptr()`: sleepable, copies user-space data
of the task into a dynptr
* `bpf_copy_from_user_task_str_dynptr()`: sleepable, copies user-space
string of the task into a dynptr

The implementation is built on two generic functions:
 * __bpf_dynptr_copy
 * __bpf_dynptr_copy_str
These functions take function pointers as arguments, enabling the
copying of data from various sources, including both kernel and user
space.
Use __always_inline for generic functions and callbacks to make sure the
compiler doesn't generate indirect calls into callbacks, which is more
expensive, especially on some kernel configurations. Inlining allows
compiler to put direct calls into all the specific callback implementations
(copy_user_data_sleepable, copy_user_data_nofault, and so on).

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c     |   8 ++
 kernel/trace/bpf_trace.c | 193 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 048bd7ac1455..ea41eb016657 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3284,6 +3284,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52c432a44aeb..77111b3d74ac 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3499,6 +3499,141 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
 
+typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
+
+/* The __always_inline is to make sure the compiler doesn't
+ * generate indirect calls into callbacks, which is expensive,
+ * on some kernel configurations. This allows compiler to put
+ * direct calls into all the specific callback implementations
+ *(copy_user_data_sleepable, copy_user_data_nofault, and so on)
+ */
+static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr, u32 doff, u32 size,
+						 const void __user *unsafe_src,
+						 copy_fn_t str_copy_fn,
+						 struct task_struct *tsk)
+{
+	struct bpf_dynptr_kern *dst;
+	u32 chunk_sz, off;
+	void *dst_slice;
+	int cnt, err;
+	char buf[256];
+
+	dst_slice = bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
+	if (likely(dst_slice))
+		return str_copy_fn(dst_slice, unsafe_src, size, tsk);
+
+	dst = (struct bpf_dynptr_kern *)dptr;
+	if (bpf_dynptr_check_off_len(dst, doff, size))
+		return -E2BIG;
+
+	for (off = 0; off < size; off += chunk_sz - 1) {
+		chunk_sz = min_t(u32, sizeof(buf), size - off);
+		/* Expect str_copy_fn to return count of copied bytes, including
+		 * zero terminator. Next iteration increment off by chunk_sz - 1 to
+		 * overwrite NUL.
+		 */
+		cnt = str_copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
+		if (cnt < 0)
+			return cnt;
+		err = __bpf_dynptr_write(dst, doff + off, buf, cnt, 0);
+		if (err)
+			return err;
+		if (cnt < chunk_sz || chunk_sz == 1) /* we are done */
+			return off + cnt;
+	}
+	return off;
+}
+
+static __always_inline int __bpf_dynptr_copy(const struct bpf_dynptr *dptr, u32 doff,
+					     u32 size, const void __user *unsafe_src,
+					     copy_fn_t copy_fn, struct task_struct *tsk)
+{
+	struct bpf_dynptr_kern *dst;
+	void *dst_slice;
+	char buf[256];
+	u32 off, chunk_sz;
+	int err;
+
+	dst_slice = bpf_dynptr_slice_rdwr(dptr, doff, NULL, size);
+	if (likely(dst_slice))
+		return copy_fn(dst_slice, unsafe_src, size, tsk);
+
+	dst = (struct bpf_dynptr_kern *)dptr;
+	if (bpf_dynptr_check_off_len(dst, doff, size))
+		return -E2BIG;
+
+	for (off = 0; off < size; off += chunk_sz) {
+		chunk_sz = min_t(u32, sizeof(buf), size - off);
+		err = copy_fn(buf, unsafe_src + off, chunk_sz, tsk);
+		if (err)
+			return err;
+		err = __bpf_dynptr_write(dst, doff + off, buf, chunk_sz, 0);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static __always_inline int copy_user_data_nofault(void *dst, const void __user *unsafe_src,
+						  u32 size, struct task_struct *tsk)
+{
+	return copy_from_user_nofault(dst, unsafe_src, size);
+}
+
+static __always_inline int copy_user_data_sleepable(void *dst, const void __user *unsafe_src,
+						    u32 size, struct task_struct *tsk)
+{
+	int ret;
+
+	if (!tsk) /* Read from the current task */
+		return copy_from_user(dst, unsafe_src, size);
+
+	ret = access_process_vm(tsk, (unsigned long)unsafe_src, dst, size, 0);
+	if (ret != size)
+		return -EFAULT;
+	return 0;
+}
+
+static __always_inline int copy_kernel_data_nofault(void *dst, const void *unsafe_src,
+						    u32 size, struct task_struct *tsk)
+{
+	return copy_from_kernel_nofault(dst, unsafe_src, size);
+}
+
+static __always_inline int copy_user_str_nofault(void *dst, const void __user *unsafe_src,
+						 u32 size, struct task_struct *tsk)
+{
+	return strncpy_from_user_nofault(dst, unsafe_src, size);
+}
+
+static __always_inline int copy_user_str_sleepable(void *dst, const void __user *unsafe_src,
+						   u32 size, struct task_struct *tsk)
+{
+	int ret;
+
+	if (unlikely(size == 0))
+		return 0;
+
+	if (tsk) {
+		ret = copy_remote_vm_str(tsk, (unsigned long)unsafe_src, dst, size, 0);
+	} else {
+		ret = strncpy_from_user(dst, unsafe_src, size - 1);
+		/* strncpy_from_user does not guarantee NUL termination */
+		if (ret >= 0)
+			((char *)dst)[ret] = '\0';
+	}
+
+	if (ret < 0)
+		return ret;
+	return ret + 1;
+}
+
+static __always_inline int copy_kernel_str_nofault(void *dst, const void *unsafe_src,
+						   u32 size, struct task_struct *tsk)
+{
+	return strncpy_from_kernel_nofault(dst, unsafe_src, size);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid_type type,
@@ -3510,4 +3645,62 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
 	return bpf_send_signal_common(sig, type, task, value);
 }
 
+__bpf_kfunc int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, u32 off,
+					   u32 size, const void __user *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
+				 copy_user_data_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, u32 off,
+					     u32 size, const void *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
+				 copy_kernel_data_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+					       u32 size, const void  *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
+				     copy_user_str_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+						 u32 size, const void  *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
+				     copy_kernel_str_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u32 off,
+					  u32 size, const void __user *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
+				 copy_user_data_sleepable, NULL);
+}
+
+__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+					      u32 size, const void __user *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
+				     copy_user_str_sleepable, NULL);
+}
+
+__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u32 off,
+					       u32 size, const void __user *unsafe_ptr__ign,
+					       struct task_struct *tsk)
+{
+	return __bpf_dynptr_copy(dptr, off, size, unsafe_ptr__ign,
+				 copy_user_data_sleepable, tsk);
+}
+
+__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+						   u32 size, const void *unsafe_ptr__ign,
+						   struct task_struct *tsk)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
+				     copy_user_str_sleepable, tsk);
+}
+
 __bpf_kfunc_end_defs();
-- 
2.49.0


