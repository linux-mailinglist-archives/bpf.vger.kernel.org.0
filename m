Return-Path: <bpf+bounces-57777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB063AB0136
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BA91BA6BC2
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA5A286D66;
	Thu,  8 May 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXex9BQ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CFC286D49
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724713; cv=none; b=pvNeGfLEHZ77HbQQYi71DPVm32Q6pENNd1oi7P4ET7+nwacjbH1MRLFt05HaVEJ8ZdPtsO1Q4nf8zmSmmK+r4MePgkLcu6Ldoln2hxJHziFcUV/p1c0xwyl/T2Zk4+ATY90d+0crYwnkR0wixUw5a9ZZbXdpgNUb97CYu/nH8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724713; c=relaxed/simple;
	bh=/3XJYizm22SAbcZOL332av2zS4xQFQ433g0QoyORo9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5vPWeJhnbh9E1cNd7M0TUzSVqsvrOlFkNnEAbSETz/lOqJuR4KL9MjMfVwepeUpiB7FakHVVG/ADfK3sn/Qp5luLiROamTh426h32hw4VWGW1mL/9TnDjjGLabkBxKKX+WOYPR4RO50GMmjWplDVjF/MdfYvvy6MqufYg2fIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXex9BQ6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so12840575e9.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746724710; x=1747329510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovyX4q5Rl2sa4GKsVOpcX88XMnWtkeLCFxsv8GjpyIA=;
        b=FXex9BQ6tAUggkkVrnZ3Iq/u3Vg341ysBtfgUpm0GL36qZGcnHjXqgC8Z62ZD2wOiR
         FURvom2kqF4fz4vmOfBE8CQon19UlwN1DAYQO7/HmW4QYW638HM5UCD6CZNY9GrGhy1d
         pNMtPcXYTT0Sf9HG3ZfWNKSYgnd58L5lQlgqYvEWpIbbLJWc0MrZVWPQJsFH53hQe/ta
         L/iRYibHwkOdiR9nmHlAx7qFA2cbumu215poKJFo/zV4PBNIgYXuYKMw3hX38UxrwLWv
         lqIgkFefrP+ENiHkbG7s9CWbFacOB4AggI8fGwMgEGIB3GUenOE1Ftl2jQ/meFfvV8c1
         pccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746724710; x=1747329510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovyX4q5Rl2sa4GKsVOpcX88XMnWtkeLCFxsv8GjpyIA=;
        b=fEcyatpeSHUJXWMAf13odRmR5OCltNZ00xuhxIcwanFXoy7DRxbqLK1/bjHy+3VVrU
         hWvfmXEA15Mtc3UZD8WPqBfMM/8hBIu/vXSIGw/pFmNMqMAzuxQa+1gFtqUXNuly0MVe
         4xMXjtIq1AAtkdVllkVMqSWgPIlpKqO5nVrLdBYd5UrpfTs/xIcch5KhlC/z4q3PkjLn
         qLX5BBlilLmr+MqlaKoXLiBrShWA3JoR1vKnGpP+ilYnHsIrYVYeKcmTEDPzVI+nif/9
         Hp9FSPD3N8mdcxexQFqb2OmmPWmlbhNxSX8WsfgtM7j6mYpiY5ckiNefzduh5komeo3t
         rTLg==
X-Gm-Message-State: AOJu0YzrfjiXK2JPU6zh4cS5xtP/rkUZznt1c+WWa1XvN2H/wwmbjfys
	gIaFSn5mowAASYvBs55G3+z33WEoBt9WAqhRzjWnAI03QkKrNR8ITtL9WQ==
X-Gm-Gg: ASbGncuuya7syE1n6eO48u7Nu/8XN/sjJw1kgikicjGMDS8E7bYVa2zQI/XMchZzd2t
	ufWyORyF3QnYGI7m02Zp50M+5myH9zRhoOadNPAGHryhKhHWjb9qZvQvAZIT/z6/8yFJjsBXcv/
	flUmyJnOM972BHcweDSWITDhqwBO9ipKbgFehkoGnDf2zKTuVrKuvTMIDLJQS4SP1bYPZ/CojqB
	PHukHdlZLfpOHpDnSyUBcQcbLTkn+AueR2QEEoLVKTx8gKUaCi8K8A+TqY1aSWU9aXzQRre1YTp
	ZIU7Jf1vIM2pBVQTR2nrnKRE4Y/PDezzKmKEGGax044Qv2g9KjDLN07cpUQ=
X-Google-Smtp-Source: AGHT+IEup1BYNTVkcLzbz+3u1FRTBJySOrsj/WSeJzAG1xIOLcCWwYjJ5370Qnkh715MV+SdEu98qw==
X-Received: by 2002:a05:6000:40db:b0:3a1:a96c:9b90 with SMTP id ffacd0b85a97d-3a1f6488444mr364659f8f.46.1746724709608;
        Thu, 08 May 2025 10:18:29 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2d3sm528261f8f.63.2025.05.08.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:18:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: introduce tests for dynptr copy kfuncs
Date: Thu,  8 May 2025 18:18:22 +0100
Message-ID: <20250508171822.152266-4-mykyta.yatsenko5@gmail.com>
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

Introduce selftests verifying newly-added dynptr copy kfuncs.
Covering contiguous and non-contiguous memory backed dynptrs.

Disable test_probe_read_user_str_dynptr that triggers bug in
strncpy_from_user_nofault. Patch to fix the issue [1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
 .../selftests/bpf/progs/dynptr_success.c      | 218 ++++++++++++++++++
 3 files changed, 232 insertions(+)

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
index e1fba28e4a86..818942c64cf3 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -680,3 +680,221 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
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


