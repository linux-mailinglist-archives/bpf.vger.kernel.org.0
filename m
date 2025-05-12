Return-Path: <bpf+bounces-58051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F85AB45B5
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B529A17F611
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 20:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F329992E;
	Mon, 12 May 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHFUbpae"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7C25A32E
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083239; cv=none; b=bKKQVx0igaBrnCIsBl/4IibSUxODyzLCo4QtT7fgY2DEJYnOJK5VOwDZAmbBuHUFEPe0BwLOrbi43oMQhUqJ2/1QxiWyoXgT5wOh2yEvRWKXNhrkEO5g0LeahnHHbZtVhCd5Aswvr3QDhIY6Wqin1rInFY1Ajyf6+UHKzW7SuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083239; c=relaxed/simple;
	bh=XwrcFoE7fdWtvKU1Mx2mEY1b6w7Qky4g7mXYweo8krE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPjVpRtPgqXVI9Uj2KSvjcu+ngNW1T9TFRd7rSSs4XSk3TV5rakA+3S+ocfhfud9Yk7QhXNZ1tpLobgXQK9n7RHUdUslUnnZLdj1iJClIngtJiEzrzTbdLGgkYQkClcNI+lZoZqR1aLBP3jpemXtaLy49RbQzLq8ts47eiY6MmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHFUbpae; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso36501185e9.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747083236; x=1747688036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDLz4JfwhbKy4/gKr/hEZt2KwijSqmSdnImWolzBB48=;
        b=ZHFUbpaelRHhugIFaEYHaiQfvTtvJ3EAbaD+l7+mfuMxb3CNqOqK/BFkqb7sJE+hUO
         BlyCrLZTZGnItTINkzVNeuGjPokQwIDtBVBztj5BhTp55E4IW9ZT9h5rkwNLIjT4/ctz
         rQPPudBvjy32jUvvDaZcX9Ce9yA/FHxS57gMivqCjrVhzfY8T9GYMf3Yzfa6t4bUmdK8
         lj7UTu7UXiwQxxJD2n2dGZ1L95LzKPXo832pr7KiOyaYrcx22YBGXOyP7eICfieBaYBs
         Iq4as0WqTxVgRKk79SQzMZRtj23IRKyndmLvGi27Yyoaa3c3nGF4JGn5W5gjdTuTZmuk
         q4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083236; x=1747688036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDLz4JfwhbKy4/gKr/hEZt2KwijSqmSdnImWolzBB48=;
        b=a45AVuEodX8aOqJ6aiNMRlYkRqHqnogoC5gQeFIdtbXWucwBzD0qQOvxmFe79UDoDj
         VT7dxBNw55zklaKYhT1qIYrzzCS5I9MFt372xY141mqevsif2YU8YgpIcLF83khPy/XM
         fhysXRBxb9cBMM5iM7t8LBfGyXYGYuwInpatvB2O9UJpJ6C3MGBaJsLu4dh0qzxcdjxJ
         k84EHdZyKOrgOeOIaHf9lYjQLu/NjLRTQP50gG5UoHpo+ieZh9/1dKGQF+P1zCAp52xC
         46+m4fWRd3ztOXQYDwxHnifsN6JdJr8WNKkWPlBSpITTfl5Q+7k6UI4+1b1dE6sA7qqo
         Wu9A==
X-Gm-Message-State: AOJu0Yy9YmrpNQicg+/0lHBe+vED3Hzxr6F7nFGcjYvfzCBxQmBzircN
	M6B9AKfBvMMjEg+OX1l7WzgI62xU9G8dbnRTbQItVIotr/A1HFKWCXUdmA==
X-Gm-Gg: ASbGncvFWmIj8Q5QzyS+FEgAVTYGqq5zy9ZiKAH9Es2RQ4XSW7JHNW+t6Jesen2JW4A
	pmODTHJiugSkUFV1yd7keFdRMWWPmKnddMtEoxtGJ38hfTw7avuOai0BbhY4vXN/f67P7O/ycha
	qcR4mANO1c3hRB4iqGYRDKCVsdVgOBfJ96+50LIJ0vfbmqyNYvMYCDlcNlgnfwGgLsJUcjxgdG2
	biiNQB5+2ZY0jPuVg0OuiEerbppI3UwW5DZVoHdDZCCzNXE2IzIrF5c2I87x+0KX2LGcXW/FRMN
	ybthFUbL2GtXNFP8tqYeOA6wRRZagM8kdfzvdnwzfSc/Q1rng+GrePnAE4xQoQeGoWx7uA==
X-Google-Smtp-Source: AGHT+IF7cy/gIqHNQZsxcseAkGFjgP+7SvwmtHK9wwbf09k7LilmZh+iXACYPI2VrTTSm+weBamYXQ==
X-Received: by 2002:a05:600c:3490:b0:441:d4e8:76cd with SMTP id 5b1f17b1804b1-442d6ddec00mr120518685e9.29.1747083235320;
        Mon, 12 May 2025 13:53:55 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3285c7sm182800915e9.3.2025.05.12.13.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 13:53:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 2/3] bpf: implement dynptr copy kfuncs
Date: Mon, 12 May 2025 21:53:47 +0100
Message-ID: <20250512205348.191079-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
References: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
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
index 52c432a44aeb..44c4ab696655 100644
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
+						 const void *unsafe_src,
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
+					     u32 size, const void *unsafe_src,
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
+static __always_inline int copy_user_data_nofault(void *dst, const void *unsafe_src,
+						  u32 size, struct task_struct *tsk)
+{
+	return copy_from_user_nofault(dst, (const void __user *)unsafe_src, size);
+}
+
+static __always_inline int copy_user_data_sleepable(void *dst, const void *unsafe_src,
+						    u32 size, struct task_struct *tsk)
+{
+	int ret;
+
+	if (!tsk) /* Read from the current task */
+		return copy_from_user(dst, (const void __user *)unsafe_src, size);
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
+static __always_inline int copy_user_str_nofault(void *dst, const void *unsafe_src,
+						 u32 size, struct task_struct *tsk)
+{
+	return strncpy_from_user_nofault(dst, (const void __user *)unsafe_src, size);
+}
+
+static __always_inline int copy_user_str_sleepable(void *dst, const void *unsafe_src,
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
+		ret = strncpy_from_user(dst, (const void __user *)unsafe_src, size - 1);
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
+	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
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
+					       u32 size, const void __user *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
+				     copy_user_str_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+						 u32 size, const void *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
+				     copy_kernel_str_nofault, NULL);
+}
+
+__bpf_kfunc int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, u32 off,
+					  u32 size, const void __user *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
+				 copy_user_data_sleepable, NULL);
+}
+
+__bpf_kfunc int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+					      u32 size, const void __user *unsafe_ptr__ign)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
+				     copy_user_str_sleepable, NULL);
+}
+
+__bpf_kfunc int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, u32 off,
+					       u32 size, const void __user *unsafe_ptr__ign,
+					       struct task_struct *tsk)
+{
+	return __bpf_dynptr_copy(dptr, off, size, (const void *)unsafe_ptr__ign,
+				 copy_user_data_sleepable, tsk);
+}
+
+__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, u32 off,
+						   u32 size, const void __user *unsafe_ptr__ign,
+						   struct task_struct *tsk)
+{
+	return __bpf_dynptr_copy_str(dptr, off, size, (const void *)unsafe_ptr__ign,
+				     copy_user_str_sleepable, tsk);
+}
+
 __bpf_kfunc_end_defs();
-- 
2.49.0


