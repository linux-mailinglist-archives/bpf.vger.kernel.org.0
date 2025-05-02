Return-Path: <bpf+bounces-57272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C7AA7A05
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9D73B4C2F
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516CB1F130B;
	Fri,  2 May 2025 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ3LZUgF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804D1EFFBE
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212790; cv=none; b=hu933JGUDFlkG0NBTmi7vWn5FvSQ5AgW6OjdH5UybRoVy8LkDo03ww/ODA9I6btwkAbXDe2JH7iozTcT9Oz5NLQHCbGO09z/NZX5n/EZOrHweq9h/Ks/lIl8EZlmHvN3PM0REByBdWC0VjBaWyicghfOn1nf984gHiMQ3TzmEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212790; c=relaxed/simple;
	bh=OyTd7e1z6LsypnhSJyl7qDBO2tQetf5/QjX1nleo4/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwQ9wBl4s68qXVPyKVNZEMwtAjx0LJyo46cZdqnq5QEzHNnKYl6483ZbyC01Ue3lmAIuR0OisMxEK1J89mB5WxhNydZZj3sWGjvjx/qZ3XUSS0VCn0YiwHQ8oOtYS6T2jnJAlfl3+mQbFlFc98cWVq/3F1QF5pRIiBK6gVMSbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ3LZUgF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so42391135ad.0
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746212788; x=1746817588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz1+Tlx/bEPPRIqriZcxRTrWsuE1Oqzte/Mk5bnR7Uw=;
        b=dQ3LZUgFvAKWBh/ZCHfDkNn/ldlF7Uh1s8PRCvF2DSdWghQSppNwTgNk/ow8pD6Jk9
         TKXlIVtbLkqNoSakEH3//mzFOKe4IF4ZXH0oJyuXD+Ci2iDUmOpaZiepCN15teFF0BRm
         ga6Vo/7IcO1RvVA+G+X6oli0f29Hcrqb2yjacYEdMyTdFxsdAcDlFGGj4PrE/18dd/jC
         CpAKUoc8I+e0ht9y4EcJKneDqReZW4JUgeJ4rDsUSc3HS1igWhOysxhApF8Vm64dk+jE
         78+EXfTGHD23gW9ypCRStck3VOjaLKmuIh92jJb2k2Pbp+7LWaU5s+U+qrYJLVQ9HUoF
         EApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746212788; x=1746817588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz1+Tlx/bEPPRIqriZcxRTrWsuE1Oqzte/Mk5bnR7Uw=;
        b=BNeGWpeJoxEsOocn9HqsdYu/IT44PxsU1DpIN0himymlitaBLXzo/2HghRjI0wfCCd
         hBneTOOdtvQrqkHHaWXTcyjBvoVntCgMoJKmaKo2XNyOckesz0QhxaPgt/xyRVjA/xD8
         G7dvzyB+WOkRnYdWwd9c/w3KifUCWPNmvDhZqzSU7/eNqzjnpQHAUXw+kekHQPhqoM1i
         /Bcee5BxVyPYCSh9gIHgDc1UfIM8aZQ61QiJbV1+Nq4onHNeL/7bNazN9wyqkdbgK+E2
         ZRJkuIwxSKNrQh8y5DeymH7RXgVcBIUWVGox8dr4VrK6JZvhm3QqHctS2u1w4Dzon/59
         YDIw==
X-Gm-Message-State: AOJu0Yw5YcraDIUoicRaLIL/Ycm6US9COtIvSlyA82G5juAcB/Xy7J5F
	R5gByRHf4Vf2pTe34R21AYTRo2CwlJuivP/4n18bah7NF2zDcabXAEM1zQ==
X-Gm-Gg: ASbGnctC1KVNHWdpPEy8UcN2J++Yp7KfNIOxpzRp1Epy7igkrPOKVFgBjfJZt8k3x9e
	XhFtESYNml2zSvvaJ3xXy6VDiAt8/4pq3pw6Objrp2mePAk8P1vaohNhzCOd8RvFh+DvpTgyZ4j
	Zn2sFxsP2UbFiXW91w0lxQCl8XpeYGZOEw8S2utcDAiaB+Mo8EZgrKzKnQ77WrL9bmKOnoTyb0A
	vmQv7aIOvl50B8Q7fO6l/MCmghG3U59g6B44KbhbL8uH4QqWKA/QjE2v+VKJl6J7kTb90eBL3iS
	dGWOKyZpUJMVx1qtnzLcxURcedJ+zqC4JnkW8HxNp5s+sPyKhU/YzbQ=
X-Google-Smtp-Source: AGHT+IGDwkzxST5VfocF2UgkGKdX8bjeruRoziM6QbG4qkrRUERQgbQiM149OMGe39G41dVSva4D6w==
X-Received: by 2002:a17:903:320a:b0:220:c164:6ee1 with SMTP id d9443c01a7336-22e18c0d71amr3251345ad.32.1746212788338;
        Fri, 02 May 2025 12:06:28 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c090:500::6:9b40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150ebfb1sm11426265ad.11.2025.05.02.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 12:06:27 -0700 (PDT)
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
Date: Fri,  2 May 2025 20:06:20 +0100
Message-ID: <20250502190621.41549-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
References: <20250502190621.41549-1-mykyta.yatsenko5@gmail.com>
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

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
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
index 52c432a44aeb..52926d572006 100644
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
+static __always_inline int copy_user_str_nofault(void *dst, const void __user *unsafe_src,
+						 u32 size, struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk))
+		return -EFAULT;
+
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


