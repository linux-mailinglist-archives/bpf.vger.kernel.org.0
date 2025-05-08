Return-Path: <bpf+bounces-57781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B4AB0166
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D144E8737
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1162857C6;
	Thu,  8 May 2025 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9Ng4HCh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED26286D50
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725197; cv=none; b=Vs/XTOrjNXfu9tjqj2WP4PZ/VMlRmKdqbGhcAO4KfP56cVCjwz71Gnf6YAC44H0nZjYok+sBZByP+XscyShwnGG/gnGcMSGBB5HzZW/tJb5q9asmWuXgvXlpU18mq2IwmMwH7rnLBg7ll8teRYSikP6jfjaFG/oWMk+2qdI5j+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725197; c=relaxed/simple;
	bh=/3XJYizm22SAbcZOL332av2zS4xQFQ433g0QoyORo9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBFeqQCKoaZ+8/KFqVhnV2dP1lH12ydX1RD28BXYZLVDXPOqoDbYDt4uphiyBlg0vhfi5GgSG8g1MUTsQkeK50VNIq3EbTuWfeYkbbRO4O592eYKMKuI0u92qVNwWVDS2Hfd3PzYZpqHyW9WE3yWc+vm126Fpf2a9IWqisAKO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9Ng4HCh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso136514f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746725193; x=1747329993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovyX4q5Rl2sa4GKsVOpcX88XMnWtkeLCFxsv8GjpyIA=;
        b=G9Ng4HChNImhrShXtSUbYSsKJF1E2beUcVulHivi8m/LakgicRRYceac8wfthMuzak
         L/B+L+jEDwNJ3Z8H7a1RKKAk3njuJIn4Hz9uAb75OTFiFLdBLoEpPpKEBD8dJel6b6QL
         nWRYmB/0rdjJn221iXzlBOojClCmvBTXntJl7QKKzceauJbsXYFHX9UR2iWSgCoJnUgt
         She5gSRTSl8YS+lJVtFejNIVw6uJ8HfveFMQ63chgfdKzHNSNLRmLt8sbyPbPDqmerZi
         uHgmG73l3P5JH1f/z+c3qmYQCvxMB18ahsGBXCATXf+nN6bruZ5NERGmOvre1/0BeQgD
         t9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746725193; x=1747329993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovyX4q5Rl2sa4GKsVOpcX88XMnWtkeLCFxsv8GjpyIA=;
        b=t0BVL/XV1wM/emotVzuWx/5is6pqtl/73KaHYl46D7+flPs1XhuDaUajCun8+UDqwM
         jEX+2tLOPlCEPYFaZP3du6Vhbb8wYEOWN93ag2lb4ezUmkySuhgDgK9R+fQqjhYjCr74
         +u/k7W6qyIEy62TB6ZfYnTy2apYpVEgpxSZCgjbIHJ4pIFb+b3xPIMGuDZQh7XTcuFxG
         hmGHA+/Lg+8JU05t/E7nQXG45xuQxIrBKxiQknBM7gzrApkMk85pfOy4Btn+QI0b6rnJ
         m9hBrwfL/vdVxpoee8af/oHEd4YO+MHaJQo11q2C2WMDNzd8zDG9ky7Mxe+2WE6Naeik
         DZmA==
X-Gm-Message-State: AOJu0YyzBvlcCIJYO3zhPEFSHLDpsljrTjpBBNrD61x1dlAcbyqdJHLl
	CmcVEgMplGDw93l6iZk1uCGyRv4ba1yfTTiFlsACbolGRet3WAK6fqKRjQ==
X-Gm-Gg: ASbGncsMuoZewgMgNCtgmHf7FXwy+dVAlUtZhVVbHj57lWATRh6baujQ7IRvteDzn8m
	D0wJ/fh+f8xBkI/2E7x9tn5Wqz4YbVURFBI8eD5PIgCQ+Bc6LORdJnGegpMrU3ICcoQZRxfS2qH
	rHdIdtlhy+5d4XWd3jzD7JdtWkIehAeC3wIP8/v5iUO6WB98Yda5TbKQUN1+80IHCJx6IKVzdNe
	wqAF9DmHT3794Goa+mozL+a2nUmbo9hea/Zbu2dqR/LPiEzQhxoimuCYZUhJvA4zP4+7dBc7pAe
	uc71hEpGUDm4jcsiAR78VQXzHHNx4Llo2KN+7F/VdHxpZEe8Q/vKDopRQBir1CtBmfn6LQ==
X-Google-Smtp-Source: AGHT+IGKZ0NO+1k3IOoYx7yD4h5odNTieCPGhnLUEU1o/U/Ba5GWg1Fl+hI/gmkYyzdJzjmnyA6oGQ==
X-Received: by 2002:a05:6000:4020:b0:3a0:b55c:cd6e with SMTP id ffacd0b85a97d-3a1f64460b3mr349381f8f.24.1746725193096;
        Thu, 08 May 2025 10:26:33 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ed1c9sm1800415e9.21.2025.05.08.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:26:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: introduce tests for dynptr copy kfuncs
Date: Thu,  8 May 2025 18:26:07 +0100
Message-ID: <20250508172607.158382-4-mykyta.yatsenko5@gmail.com>
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


