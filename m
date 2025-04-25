Return-Path: <bpf+bounces-56691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D2A9C9BB
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BE617077A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5206252294;
	Fri, 25 Apr 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpresSEe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467C251781
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585973; cv=none; b=ByBXHhP3Vo6iiU8Lcd6u6YFRaG6x0nTW+Om3wfY/zNG1VAiptNCKzcwBjH3ooU1jOW9hi17LFoEFrrSJYv1uZ2AXSeebrGQFqcOp/zuvKFyPinX9U9+ZIp5mCvHvmr48RZMzdToCcQM5csI1Y3qjzFnXfv2GSNepF9MXKMVZ4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585973; c=relaxed/simple;
	bh=9DHsFaO2wMy3TChTFULqEpNmFdypvO0xO8Z/XLms588=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD90BFIZNIIVTfLDxCS91xsdY5FJgQsZijUcY90QIazTos0t1cZnPGhmiDOc2EkLSSqG5qbhn5TxmfFMMT+DogKk0ZWUTrzRo8XeNrTJsMZU4j4Lf5pJeXAWefS/jqrWVDuY2WQZ5WiTsTsseKwYuj3dCWgxAcGsJBxqlG+j1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpresSEe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so3315807a12.3
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585969; x=1746190769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxKQlCRbFsLzA+XG0XW17xFYagJOLHftSwXsaY5Los4=;
        b=jpresSEeLjm73L1an1QRFPFal2l3b2XZ75hqSj6oPkQYFECKDfjjtRpuozMq0hDWpx
         b/CLKGT2xWBPqoJi7Vqjr+FSLijf/LLLK7QSZMK7jfbn+NZtCchuEgNO/F1gPt7z+gUk
         hrc05p+ANXU9QZsJkQhaaMJr4MoVOzuMfd7MAMW8kUOv4e4CX8XQ1jIYHhvG5clJgSCb
         9EsCTlaPtz8mCPs16Dr1X0OnPfqvPHRH8tfTiwzRYqWFoVzIGbeErKmznQqkgJGJk/DS
         J87VSXN8Vs6se3sGthHnXEsYncu2ZupFKEcj9Q6Gq6exr8F2gjgfwkI8z03fdU6GqCal
         GT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585969; x=1746190769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxKQlCRbFsLzA+XG0XW17xFYagJOLHftSwXsaY5Los4=;
        b=nzfe7X8zOyxt1FrlyW/57ycAfPxqTIf/8BCsU5ms8m3ntlT9wUe51uuKjdscmLQCtA
         92+3ZmYerH59yabBV6QurbZ0+PSjLDmJJQW3xRu6zCGo4YreRFxnij+sVeVhs6gWjBiS
         rxVelQeD/BsvDbgjwgAUWtxcqfPUsi02NQMZACM4B/WbQTrJ+X65C5XDoUHR0HbMroGM
         2QRBIDvA1rTNZ0Dxo87bzCZV2eqsdYqiCjJ+qP1OnmkHqfgbeNqc/8oEO3ONSKqjECOU
         pY4Mw4cFdCixuhrkxiJSfehVZRLH8jgvJ/B4WcJivYLiD06DBPtSURGO8Ws5xKmYHWUQ
         57/Q==
X-Gm-Message-State: AOJu0YzITud/aE9eM1CpJJNhdAq46Tn64pB9DjbNGi+QCmD++jyFcj1m
	oFtJ1FWHoAvOI1ceGtDDrac73SWvaQR4FPpcISF4XCuHamn5+wGRJ44fXQ==
X-Gm-Gg: ASbGncvLtw6DDna6o/ySVf265WqLrfMLsPWsBwAP8D6UYGeP9ReJBLZXpMXdM4TNHDF
	V7/GDY0OfPKpx8uIqJXrXXGYFijbjroR1ZgWQ5+agZkegfYTCoAhTom5f7+d2Rpf6EgLgXiqo4U
	kz+Kl0TyGJ/1yLmOTRzlT0CDcjrFfG+lC1315h4n+I7YZ8JP6NfMrKLfocjs6G7uBdlcjf8nVZJ
	ocZEOJ7Iop1lef6wFd36eW1eyJMULd1m5zpKR4aP/yUBUEeItMuNM3Ht7VpbXuY/PixDvUduXnJ
	xb1j6WAbz6Bn6YIt0imWnVV42k4Oqm7aR+sxiA2CmWdxVQWELdkE
X-Google-Smtp-Source: AGHT+IEP9WXXIcM6w1udq06kvChvHnbIF0AHv/H9iv9KXXqKSjV37T9xMeFP6mHb7v9a/b1D5NtWgQ==
X-Received: by 2002:a05:6402:2747:b0:5ed:2a1b:fd7d with SMTP id 4fb4d7f45d1cf-5f722b6d283mr1856670a12.19.1745585969358;
        Fri, 25 Apr 2025 05:59:29 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:eb6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f701106bcbsm1224669a12.10.2025.04.25.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:59:28 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 2/4] bpf: implement dynptr copy kfuncs
Date: Fri, 25 Apr 2025 13:58:37 +0100
Message-ID: <20250425125839.71346-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
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
space. Notably, these indirect calls are typically inlined.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c     |   8 ++
 kernel/trace/bpf_trace.c | 199 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2aad7c57425b..7d72d3e87324 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3294,6 +3294,14 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52c432a44aeb..c455137c108c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3499,6 +3499,147 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
 
+typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
+
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
+	if (WARN_ON_ONCE(tsk))
+		return -EFAULT;
+
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
+	if (WARN_ON_ONCE(tsk))
+		return -EFAULT;
+
+	return copy_from_kernel_nofault(dst, unsafe_src, size);
+}
+
+static __always_inline int copy_user_data_str_nofault(void *dst, const void __user *unsafe_src,
+						      u32 size, struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk))
+		return -EFAULT;
+
+	return strncpy_from_user_nofault(dst, unsafe_src, size);
+}
+
+static __always_inline int copy_user_data_str_sleepable(void *dst, const void __user *unsafe_src,
+							u32 size, struct task_struct *tsk)
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
+static __always_inline int copy_kernel_data_str_nofault(void *dst, const void *unsafe_src,
+							u32 size, struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk))
+		return -EFAULT;
+
+	return strncpy_from_kernel_nofault(dst, unsafe_src, size);
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid_type type,
@@ -3510,4 +3651,62 @@ __bpf_kfunc int bpf_send_signal_task(struct task_struct *task, int sig, enum pid
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
+				     copy_user_data_str_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+						 u32 size, const void  *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
+				     copy_kernel_data_str_nofault, NULL);
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
+				     copy_user_data_str_sleepable, NULL);
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
+				     copy_user_data_str_sleepable, tsk);
+}
+
 __bpf_kfunc_end_defs();
-- 
2.49.0


