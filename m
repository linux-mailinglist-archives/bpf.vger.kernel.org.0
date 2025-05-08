Return-Path: <bpf+bounces-57776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654AAAB0135
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8463ADCBF
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C828689B;
	Thu,  8 May 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlcHoGZm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138D2857DB
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724712; cv=none; b=A28DTrwByvb9Rk0B+lD1ZptV3ppKegQUDZ4izKO04iN7UcedB2lQlaw0l4Ja4ePM2ICOiGEafdQV3nJYq4NRe1LlPFl9FeIi7JADtq+IoWewA7Fs3K9kHaQfhJWWiI7rCgFxzZ9poAzZ61IX988RMVQd/eEbLh85Emv8mJGUwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724712; c=relaxed/simple;
	bh=F9GqCz5/15dQhYu0Syk2ysLRILfpWMftfoMgqIy6fOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2GMjx7kdre3gTsBNQsdCzwsDbiKUuUfzjzQ8Oz3weMhq/70Xe3TYCyb9sDXLr0acNHTG1uhgfVImgYKhGeQWOsAvcYyrOz9U6mL8GSvKs//HlwtKn0/Ty/NuBISrmYCcuEM/c6NQsJoXl3khUFPrYCbYLF+VbMdQUCuskFlM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlcHoGZm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a1d8c09674so266963f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746724708; x=1747329508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2sv0PYddOklzbMY2R2og6dfJ1JSxpgMx+9gFejBVtQ=;
        b=FlcHoGZman+PE8bsHYG/vilhvbI6YqE68WoRL8il9Dd/C40nxAALdJRBiQckepeUfq
         Ank4/DTr0Wtjw+YUh8VZobcm8GioIwbKTaj7ve181kJVlx8dPqApa+TiWrvGWoz/Dqhh
         YMm2d61+nYMpPAPCHbITx+Z9LyClf72EpzTT2UyPE6KQVHuaUvCGG0kZTkHgt0PjOX0M
         1EepPim1q5LLtCo4o3zESwPfvE49zHPclh/cOXeD/hc7Yq/05/yVdWTHhB43lFKyQFQJ
         flZI7xsqXb/oZB/adT3tx34c1mH4hOuPYOz2MIl9EwxZB6ocgG9m/alUC6VXdiyyWTwi
         P47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746724708; x=1747329508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2sv0PYddOklzbMY2R2og6dfJ1JSxpgMx+9gFejBVtQ=;
        b=pccLayqTc9R53IkvmmyecpRvSaxWOyJ02sqVb660hbj136eqqwGSAZSi9rFh9WALpo
         uJPvz2BRaAj+C5+ZxEKoFQ/CsNi5J9AfbvNXHLBpNvUx/qlrdazG+RxcFvDosCYGFq0d
         IRu0IZXk+FpgUU21+U6SQSfu+WLmAl42/I6uf/LoPrq1r0+ojyE3NyrgjTwsmRVRxyjl
         bdqqJ9JhYV/ssgvCohuCC9OgT44Svjcc4XXHWjYnFb+gZaPwFWAWxsHXDEwUXewgWv97
         WZLyBiSbKBFxOgidHKbB1Z3nTKppposMlksjHHKiVTvaNBBql9ZenD/c8k4S5Uecrlas
         egJQ==
X-Gm-Message-State: AOJu0Yy1OiEbsdxK+0Og3q9DsTcfV1VrA2Oq1drEU1X5ZGhOIB9Yb6ai
	gorBCFsSaMXvX2wXEaCrxMGYF6Eo/pQOdLUysWVL5ueJ/fXiDW2n42Bxbw==
X-Gm-Gg: ASbGnctc2AhqPK9xDZ2DYzhnH45r67sD/mYxOF3DlGk8uzzJgPMm2Y0BHCv1aQEs/B6
	IcrZy0p2PS4CzItv47d7CcUzoTMhimxTAhoH/e+i0CVOOiWdoaYWusYgUTfM68uNEKXACDzzhWp
	Eza7mWLXWCGGBy380WDZVhvrPykohruUC9hoKKDxSH7elUOgAB4WCztnpbObF/4luxv5/mdb0zf
	mv8JbqFKmpDNN8Njqa5+c76pDsGQUxXDr1PkCFAO1RvSk+XDpihqPv6zQmx88sypxDesdk6Jucx
	0prA4R9ND8HBHj043iOTEHQv3kH4n33tmVLhnXw4LA/rkzQnhYUFe4TIiks=
X-Google-Smtp-Source: AGHT+IF5iEh/OD66E1e5y15rmuvjnM/Bzo/oZk3hAlXEte+K7pmgC2GNwvRJjFWcAsnSUFoI2/KKmw==
X-Received: by 2002:a05:6000:40de:b0:3a0:8c4d:6c9c with SMTP id ffacd0b85a97d-3a1f64a94d3mr312623f8f.57.1746724708299;
        Thu, 08 May 2025 10:18:28 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2d3sm528261f8f.63.2025.05.08.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:18:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/3] bpf: implement dynptr copy kfuncs
Date: Thu,  8 May 2025 18:18:21 +0100
Message-ID: <20250508171822.152266-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508171822.152266-1-mykyta.yatsenko5@gmail.com>
References: <20250508171822.152266-1-mykyta.yatsenko5@gmail.com>
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


