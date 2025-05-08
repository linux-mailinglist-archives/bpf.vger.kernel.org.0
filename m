Return-Path: <bpf+bounces-57780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D155AB016E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61B8188F92D
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4869F28136E;
	Thu,  8 May 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieF0WqUG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42A2868B0
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725195; cv=none; b=aWKhTwui7k9FVv08h+EmhtxGGD/X0c7lZVX7ycOedkJ42Xj39DeDyVhoTmYY0UYa73kYwboC0IRGdf6YT/vyEDMyISEKHfCDniVjYc0ugHX+noUdRn7j6QPqJTcv0CXoyqlcVbJw7nLkgv1w2dVm3+ZQphiCsdoJkz4h6qP+0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725195; c=relaxed/simple;
	bh=F9GqCz5/15dQhYu0Syk2ysLRILfpWMftfoMgqIy6fOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQWE8Xxbtsd+MLWuABAk4FTTEG3kmMqlyhrj26JOd3eHPOGKy4mtHccCo7FxnTcDgVyB3ASa3590T1VCT9OP/DmI4Qfh8VV4K7gqTSmYnUBE1aQUatb/d/m0xesPagO13X6l5wrGJhS87sORgzLpZ7Ydqq4os52MTXdyW11j9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieF0WqUG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so12503815e9.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746725192; x=1747329992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2sv0PYddOklzbMY2R2og6dfJ1JSxpgMx+9gFejBVtQ=;
        b=ieF0WqUGy8LWBgd2hL9EYrSwfBDQVdUFGTQYjC33TvBQFqMFWEWCZtTjZgBg91GuGJ
         zjPbF+G9ItEv370nx7Y2HOqJ341KTO4w9eXr7jABQ9AhEZLRG/uIE4Xd+P69cfGFNQy4
         ac1pdSnQ++Vk10mENFnPouizMfhCb+FDZLx+qKpTxq8vJEWi0KIAFh7+4s+jHqS/8yg3
         K4hJkTUUBBWjJI65uq78aHJD+Xkzw2glz6krwv0fg7aJS1V2DoaJornBmucEn0aEhRqE
         H2Xm80diI4lwfjdcYBU3LjH7CHYNLC5Qt2hCd9/Xg6+OHooxvH3ot6opoQ55qgDet4E1
         FULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746725192; x=1747329992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2sv0PYddOklzbMY2R2og6dfJ1JSxpgMx+9gFejBVtQ=;
        b=RT16/Fo2acH0jd0M+931Xtfk9xgYOQ50tooYxOKC1O+GPOMWOzeqqkJNBJNRPgwDNV
         XNJ2WyJvkcypz9rO+L+2Wi+R3twfxirJuQA5O1l3PP+vv0Jr0lGvz10Qbc9uvwi7L/5I
         YP69p4DUXB9CRI+d5GwMs/GFtcNtADCoTL9AnTr7jOq10aB4huRP1ap35qj3byAmzRwj
         LUb+FbJnVM5A0/4bZmw1UFS6qb+YcCUNfI6IlRyIfh0UyZYkQYYSGjsPTjC+eKLKMtrZ
         A2ScQglQ935n1SUvE08KOpD0tWZFvDhVPXUDjpgVhLhoBDkT2cKG6vThUEZBmXjDY3iO
         ymwA==
X-Gm-Message-State: AOJu0YxlLPrCVYpoJc1rddP4J0Chh1rvZSk1wotMRPK15xqkvHw1snOA
	FIH8XCNi8stgAmAkV4Wjs013FUNjOkR3d21BxfWizN1XukjFHRJS5nLAwA==
X-Gm-Gg: ASbGncvfela7SxudTcby6WFhJvToRVSR0msK8X8z8fLPygzXriooSFcWeIZFq09kW9j
	kD7dKfF0/GbLsN5KhCuVkuj52JfdvJVJ59/6I/YLAybLrnuRRxOHmDYgeyOtZFy0xAuXdWQ4S6L
	JqA0RJwvnEI5v10CX1jI8wc16e6OjyLX+1BqvKvX+8HzJ8f7C74Q+kGrCSmipGdVc9nY0+H4A/E
	bDEMCWrEoeowCYa8PHMeTZRyPucRZOYnRBTR5xR5tA0UXwpmS+fJmQq4aylbsA3iZpx+RTZv5AD
	lp4bnt3SMcmLye8qg5FAjGOP+4I1cAhKZqq3yoXyZP63t1hYKRxXLZOxsT7m49lT64rcyw==
X-Google-Smtp-Source: AGHT+IENiqmaVHUBY071zV9VZ5+MAkH7u9963k7TeZUcPLms22Dvkyv8qqENSZMQ6eFgQGQUNX1A1g==
X-Received: by 2002:a05:600c:4e0e:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-442d6dd9d54mr1232985e9.24.1746725191629;
        Thu, 08 May 2025 10:26:31 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ed1c9sm1800415e9.21.2025.05.08.10.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:26:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/3] bpf: implement dynptr copy kfuncs
Date: Thu,  8 May 2025 18:26:06 +0100
Message-ID: <20250508172607.158382-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com>
References: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com>
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


