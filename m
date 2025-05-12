Return-Path: <bpf+bounces-58052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC9AB45B6
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775E2461A70
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35543299925;
	Mon, 12 May 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3KNSxZR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090E299957
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083240; cv=none; b=GC5I7Mc78xnNDEeDwaVn/fLmzbmMM4LcQkVEUqgm+c0Uz7Hn7zuYtvIlhUyRFdwYI5dicvENSMIEO6RYZDuGhsbzma45GTAI8YQBEyc6OC7jj3Pvn6OnuNNVoLl6B/oj2pvyNatTaDdAnhF3NflmYfwnZ9HBj5MKSkgyEgKKFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083240; c=relaxed/simple;
	bh=WX3jVcLDtacZ3kMmlS/QEkWe9BmHyb/iVgJqNnevyfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDmPP2EQkNx7SHEdUI9pj/jf9xV1yKHmaGUeo5OF1dh3EihVdE4dHy5vqh8aT8LJv/I1gZJ61LQCJKLL043itfcWNYwQDiZMDFAcUI+OCd0QQ5DcQAQ2wEJI9HqrBgkmVV+HycnsTbc+bvX5ccJ5h3lUhvxnexVkiHJqu9zHqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3KNSxZR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so36590095e9.2
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747083237; x=1747688037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO7mmoPhGXz2YO+pRnLX/qH5fAFIk4xJS5tXJwbD0Wo=;
        b=T3KNSxZRkO+2d0YMBbgrq7P9NqaxKiRx+Ad3j28mtniuZmIGAQgsYcPUqefKjUQu44
         ebbyPxe1LyZwUeWu8YM82p8EfTV//U2KXRI+sY4EpmLqtH+HZelDWOf6w7/5uVsBZgAb
         kq/J1g3PfeP4Y4bej52PM4gds1DM26ao8Qj1ea/uDzgzTLDKTFLfMQEcXafiwaZrZGrp
         sG1P9szhqtyyIK0ARB3wtAAy+xFpNXC+HtMNmxZCttjFISbOcOD5gXjxx8MSfsMIWOkv
         t9gmlL94g/1k/O0LOPuRHujuLj8aE3qXMuv4K/wsfk0D8Vg0L0wgookvB0NoVTLi+nlM
         5GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083237; x=1747688037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO7mmoPhGXz2YO+pRnLX/qH5fAFIk4xJS5tXJwbD0Wo=;
        b=R2gHsXB9XBAyOg9wRRqHLZAkQ9JznjUXXXIruPT+SSat2TB8pPM3pCnBp1GsmAJ99N
         KLxox1dt9Sv7CkA3wTCRtjyqfqJ5tsBIgVjlHglvFQIzHZSJQCYozTKEgZH0ExfFF1U+
         Uwp/NwAHob1gIT9NJCmm1Yl/Ua3UZpqPq8Uh18CUWydxqv0CMF7WIi+mS7WKACGC1Nqe
         umNAnk5ZzUztHkft4m+w1zAstcrojqaGac6F4llW8HrE9s9VwSlLI8rlREo1HaAjzw5C
         /t9wxYiHVLW0DMnPGcG9red5CUQPZn+jcgqlfMUrTLAxyWMCR0DuTt6TIAvPeF/WiTy6
         zzWA==
X-Gm-Message-State: AOJu0YwdxQ4hppd3cnll+aIKJMNtuHgwK5Y75GlCcimjn9blMAr2oJ4+
	k14N97Y53Jf8bQxbxp8wpvAuLDBRBV9jzDjm4oQHnfJ/yDBe7Iz1zOuX0w==
X-Gm-Gg: ASbGncsRY19/LBvqmDWIIPs9imgULApD1icaQpI6BIMqQD4y8iQ6kalkuYylxUC4tdW
	I6CImPMcNIJfc8haDtQKLZq759nC1yrk1tCpnrYv+7GsDuOQm0dKXIJHZbAS0bxFCua7V2tdUgl
	6TxZMks3doK0xHz8j+W+QuBrvoMcLnd2rmqyoFQeJRATEhzlEKZFZr8lQBP7DTo51iC6MqvRp7I
	zsuC9t1FaBAbTP/9yvYTdoHRQSPcQmSL/wwhetKk4psYz6c8rSOCjeAzTxp4xXeLMkD/gHNFwiW
	Mem+PMDLad1ZTIZ8eMANNPUwIt662VTwgN2u295V+7tV9yLR1YaS2E6iKJkaFCBkkJEjcw==
X-Google-Smtp-Source: AGHT+IFgy5nmuGXRI7HtdhctERNPBbfgXKcyQ7t/Hvciqgi3sGvZmm2JwNEfs4k8wXGGhRGZR9Q6sQ==
X-Received: by 2002:a05:600c:1382:b0:441:d438:505c with SMTP id 5b1f17b1804b1-442d6dd515dmr114481935e9.32.1747083236681;
        Mon, 12 May 2025 13:53:56 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3285c7sm182800915e9.3.2025.05.12.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 13:53:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: introduce tests for dynptr copy kfuncs
Date: Mon, 12 May 2025 21:53:48 +0100
Message-ID: <20250512205348.191079-4-mykyta.yatsenko5@gmail.com>
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

Introduce selftests verifying newly-added dynptr copy kfuncs.
Covering contiguous and non-contiguous memory backed dynptrs.

Disable test_probe_read_user_str_dynptr that triggers bug in
strncpy_from_user_nofault. Patch to fix the issue [1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 +
 .../selftests/bpf/progs/dynptr_success.c      | 230 ++++++++++++++++++
 3 files changed, 244 insertions(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftests/bpf/DENYLIST
index f748f2c33b22..1789a61d0a9b 100644
--- a/tools/testing/selftests/bpf/DENYLIST
+++ b/tools/testing/selftests/bpf/DENYLIST
@@ -1,5 +1,6 @@
 # TEMPORARY
 # Alphabetical order
+dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/ makes it into the bpf-next
 get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-next merge
 stacktrace_build_id
 stacktrace_build_id_nmi
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index e29cc16124c2..62e7ec775f24 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -33,10 +33,19 @@ static struct {
 	{"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
 	{"test_dynptr_skb_strcmp", SETUP_SKB_PROG},
 	{"test_dynptr_skb_tp_btf", SETUP_SKB_PROG_TP},
+	{"test_probe_read_user_dynptr", SETUP_XDP_PROG},
+	{"test_probe_read_kernel_dynptr", SETUP_XDP_PROG},
+	{"test_probe_read_user_str_dynptr", SETUP_XDP_PROG},
+	{"test_probe_read_kernel_str_dynptr", SETUP_XDP_PROG},
+	{"test_copy_from_user_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_copy_from_user_str_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_copy_from_user_task_dynptr", SETUP_SYSCALL_SLEEP},
+	{"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
 };
 
 static void verify_success(const char *prog_name, enum test_setup_type setup_type)
 {
+	char user_data[384] = {[0 ... 382] = 'a', '\0'};
 	struct dynptr_success *skel;
 	struct bpf_program *prog;
 	struct bpf_link *link;
@@ -58,6 +67,10 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 	if (!ASSERT_OK(err, "dynptr_success__load"))
 		goto cleanup;
 
+	skel->bss->user_ptr = user_data;
+	skel->data->test_len[0] = sizeof(user_data);
+	memcpy(skel->bss->expected_str, user_data, sizeof(user_data));
+
 	switch (setup_type) {
 	case SETUP_SYSCALL_SLEEP:
 		link = bpf_program__attach(prog);
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e1fba28e4a86..a0391f9da2d4 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -680,3 +680,233 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
 	return XDP_DROP;
 }
+
+void *user_ptr;
+/* Contains the copy of the data pointed by user_ptr.
+ * Size 384 to make it not fit into a single kernel chunk when copying
+ * but less than the maximum bpf stack size (512).
+ */
+char expected_str[384];
+__u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
+
+typedef int (*bpf_read_dynptr_fn_t)(struct bpf_dynptr *dptr, u32 off,
+				    u32 size, const void *unsafe_ptr);
+
+/* Returns the offset just before the end of the maximum sized xdp fragment.
+ * Any write larger than 32 bytes will be split between 2 fragments.
+ */
+__u32 xdp_near_frag_end_offset(void)
+{
+	const __u32 headroom = 256;
+	const __u32 max_frag_size =  __PAGE_SIZE - headroom - sizeof(struct skb_shared_info);
+
+	/* 32 bytes before the approximate end of the fragment */
+	return max_frag_size - 32;
+}
+
+/* Use __always_inline on test_dynptr_probe[_str][_xdp]() and callbacks
+ * of type bpf_read_dynptr_fn_t to prevent compiler from generating
+ * indirect calls that make program fail to load with "unknown opcode" error.
+ */
+static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	char buf[sizeof(expected_str)];
+	struct bpf_dynptr ptr_buf;
+	int i;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	err = bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		err = err ?: bpf_read_dynptr_fn(&ptr_buf, 0, test_len[i], ptr);
+		if (len > sizeof(buf))
+			break;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
+
+		if (err || bpf_memcmp(expected_str, buf, len))
+			err = 1;
+
+		/* Reset buffer and dynptr */
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_write(&ptr_buf, 0, buf, len, 0);
+	}
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+}
+
+static __always_inline void test_dynptr_probe_str(void *ptr,
+						  bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	char buf[sizeof(expected_str)];
+	struct bpf_dynptr ptr_buf;
+	__u32 cnt, i;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(buf), 0, &ptr_buf);
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		cnt = bpf_read_dynptr_fn(&ptr_buf, 0, len, ptr);
+		if (cnt != len)
+			err = 1;
+
+		if (len > sizeof(buf))
+			continue;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
+		if (!len)
+			continue;
+		if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
+			err = 1;
+	}
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+}
+
+static __always_inline void test_dynptr_probe_xdp(struct xdp_md *xdp, void *ptr,
+						  bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	struct bpf_dynptr ptr_xdp;
+	char buf[sizeof(expected_str)];
+	__u32 off, i;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	off = xdp_near_frag_end_offset();
+	err = bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		err = err ?: bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
+		if (len > sizeof(buf))
+			continue;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, off, 0);
+		if (err || bpf_memcmp(expected_str, buf, len))
+			err = 1;
+		/* Reset buffer and dynptr */
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_write(&ptr_xdp, off, buf, len, 0);
+	}
+}
+
+static __always_inline void test_dynptr_probe_str_xdp(struct xdp_md *xdp, void *ptr,
+						      bpf_read_dynptr_fn_t bpf_read_dynptr_fn)
+{
+	struct bpf_dynptr ptr_xdp;
+	char buf[sizeof(expected_str)];
+	__u32 cnt, off, i;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	off = xdp_near_frag_end_offset();
+	err = bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	if (err)
+		return;
+
+	bpf_for(i, 0, ARRAY_SIZE(test_len)) {
+		__u32 len = test_len[i];
+
+		cnt = bpf_read_dynptr_fn(&ptr_xdp, off, len, ptr);
+		if (cnt != len)
+			err = 1;
+
+		if (len > sizeof(buf))
+			continue;
+		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, off, 0);
+
+		if (!len)
+			continue;
+		if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
+			err = 1;
+
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = err ?: bpf_dynptr_write(&ptr_xdp, off, buf, len, 0);
+	}
+}
+
+SEC("xdp")
+int test_probe_read_user_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe(user_ptr, bpf_probe_read_user_dynptr);
+	if (!err)
+		test_dynptr_probe_xdp(xdp, user_ptr, bpf_probe_read_user_dynptr);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int test_probe_read_kernel_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe(expected_str, bpf_probe_read_kernel_dynptr);
+	if (!err)
+		test_dynptr_probe_xdp(xdp, expected_str, bpf_probe_read_kernel_dynptr);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int test_probe_read_user_str_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe_str(user_ptr, bpf_probe_read_user_str_dynptr);
+	if (!err)
+		test_dynptr_probe_str_xdp(xdp, user_ptr, bpf_probe_read_user_str_dynptr);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int test_probe_read_kernel_str_dynptr(struct xdp_md *xdp)
+{
+	test_dynptr_probe_str(expected_str, bpf_probe_read_kernel_str_dynptr);
+	if (!err)
+		test_dynptr_probe_str_xdp(xdp, expected_str, bpf_probe_read_kernel_str_dynptr);
+	return XDP_PASS;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_dynptr(void *ctx)
+{
+	test_dynptr_probe(user_ptr, bpf_copy_from_user_dynptr);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_str_dynptr(void *ctx)
+{
+	test_dynptr_probe_str(user_ptr, bpf_copy_from_user_str_dynptr);
+	return 0;
+}
+
+static int bpf_copy_data_from_user_task(struct bpf_dynptr *dptr, u32 off,
+					u32 size, const void *unsafe_ptr)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return bpf_copy_from_user_task_dynptr(dptr, off, size, unsafe_ptr, task);
+}
+
+static int bpf_copy_data_from_user_task_str(struct bpf_dynptr *dptr, u32 off,
+					    u32 size, const void *unsafe_ptr)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return bpf_copy_from_user_task_str_dynptr(dptr, off, size, unsafe_ptr, task);
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_task_dynptr(void *ctx)
+{
+	test_dynptr_probe(user_ptr, bpf_copy_data_from_user_task);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+int test_copy_from_user_task_str_dynptr(void *ctx)
+{
+	test_dynptr_probe_str(user_ptr, bpf_copy_data_from_user_task_str);
+	return 0;
+}
-- 
2.49.0


