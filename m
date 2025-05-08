Return-Path: <bpf+bounces-57806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC3AB05CD
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36504E8009
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97622759C;
	Thu,  8 May 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCfbN3Rm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC962222BA
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741998; cv=none; b=l9ou8LyPxvjXZ/iuMFN0O5/tObYdjYKcUZVlSM/EOauNGXWSVoJhp10NN0p0U2U6Q3a5CowDF/4Aa0kcWFyo4M3dSDRvLAvyF8hBAw+YZnm0JD671iExfkwPQuNHMdD9CLqtspa5Z7N1W8FUlTghokqovGpH4T8BB/74zmEGfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741998; c=relaxed/simple;
	bh=WX3jVcLDtacZ3kMmlS/QEkWe9BmHyb/iVgJqNnevyfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTQsYzAtkQUGH9kTwtT/4VkaCEF0SA6hU8s8ZgkUf5FBFTlO9u/6G4zdMbKVEgRYZT5qOFOB3R3nNORCTt/5D+aYwz7EOieIc34vUOz7QlGnRID6KujkG+RdVqGw0xTaKrpUdt46NG7uGPC09pnMxUS9t4i3FmX7ZtvrKjBbHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCfbN3Rm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so455755f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746741994; x=1747346794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO7mmoPhGXz2YO+pRnLX/qH5fAFIk4xJS5tXJwbD0Wo=;
        b=bCfbN3RmoBvC9uwfvbqXT2tNxf0urHj5YJkT/1/JbLGVXsyDZicb8vTNnMXWGJVvgJ
         HdclJzqQzPO6tgNvE3rttlmRb153ZY9BabqWoBQajxn6ueDXjR+u4SHJrO4DtevRgL/W
         +OwzI3cyFQSGz/nEQDHOICuw7CfA9dVmZeskPzpNrEq5EmM8Ej87lI2lPHbRQZZTyqlG
         XnRBkn6WEY5dNTqz0RWKdxOQ6wSETVuOP7nVaGZ6aVpo5cmk2jaNH7xdQU+e5Ig3YN3I
         RgLZCgNJgqPjbjcbm1hFNoggPaZwBF9AjhCLynIHCRlxgkumwg6r39yMo/v1g5/pekG2
         OYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741994; x=1747346794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO7mmoPhGXz2YO+pRnLX/qH5fAFIk4xJS5tXJwbD0Wo=;
        b=eEojDlmoOQzg2VtXkz2G2rEYq6I6yJtKsGXVN5mvD8uA3yr9BqQ36/2X0T59/AzcsL
         ZqLReg1MhWRC0y1MjzHBJqoWgKtQ21hBB9teJb6ZX+C+PF2GeK2ky13NeKjb+p6QKdiU
         LFyr4Z4AoAh1JQ+dqTRZPJDXXqZEaDkXwDvix3wIcJ84SQP6LPJ9ZZ8jc2GcEug31Iyx
         6PtGqrIEu9YcDeio9LwbxICzu54pGfAI9NVFm+AqkBabC+i8rqI107/X2vgyPkTJJ2Dd
         kVXQHjJ1Q2+WZp0lLuU7CO+hGQ5HwvU0PUS/Bf7D/176OwTDX8zMUQhPYV1wuHJree+o
         tGmA==
X-Gm-Message-State: AOJu0YwQeyYbyq6fZ80rs7Pcn/bLGGHjN3j2KFSSEk7zTJbOWapJJBuA
	Q29u2hLecl94m+TAPvbRS+F6vUjrzIn25uoHBFTUwtEH2pBQ3G/mqklw4Q==
X-Gm-Gg: ASbGncsncNMf2FRIU/ZwsmS494oknsnBOQUdvM4wl99lbUTFjcn9GVXcrmR+4cgPXmo
	rsTE1FXZqH53RhlNu1GrMEfN7t/oxup2xhjvdOP0GDaPMpJWMzv2Axw4ng7TieA6ijX7W6QEQF+
	oecYaEUOGERM+HjBVDQh38Xtr7qRjmVEdfrjZQeNMSEcsgpxo3aJxd/khirvRb4xYHvyyzYSA2V
	+OV2fQkLIdsLMIRnRt1YhmiATWuC1OvnG2vQUHK91VS2sLxQWK78s6V7ZLvRb4IH3z0lXd6wWjp
	IcmYNc1qpipCOZn3Dv3DJcCx+bwgEvyfiEQ1dlU9kPKu6nVOCSiaJdpe0aM=
X-Google-Smtp-Source: AGHT+IE7/KCURjRNxIuxQKcpeFayyV5eItp1pdAAf4mm7brnwE6Ei49ga8UelBtpxtYe7E6Uh5ivKA==
X-Received: by 2002:a05:6000:430d:b0:3a0:b1ff:8542 with SMTP id ffacd0b85a97d-3a1f6422563mr798983f8f.8.1746741994451;
        Thu, 08 May 2025 15:06:34 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ed0a5sm1168830f8f.21.2025.05.08.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:06:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: introduce tests for dynptr copy kfuncs
Date: Thu,  8 May 2025 23:06:24 +0100
Message-ID: <20250508220624.255537-4-mykyta.yatsenko5@gmail.com>
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


