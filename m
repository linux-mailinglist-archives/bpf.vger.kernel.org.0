Return-Path: <bpf+bounces-52680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55AA469D4
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F311883759
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3265235341;
	Wed, 26 Feb 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khTMT7w/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7F23496B
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594740; cv=none; b=FMGyiInQL29I7GpQ5reyTKNHT59+GbsOH/1Da/Lf+/9v3HSg11lxYu2YhhTZMWEA7igJFMK7LD3S//GK8qwmT26UcEbaSM84pt6z9eNeN2ZM2+HgdmuhSuAvwwdKzulI/lHpbmVKp+bYuH7X5tqdiW+TZWIyqYMe+SkPpT5TjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594740; c=relaxed/simple;
	bh=HzEUYH7qb1iWXRnDyo68KhiI31qeyT99Mz7m3Iyjw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2491s02hT0VYMY/YLBQJE0+cFomNptlkvbmv4hmQDXck+ZlKOy000emweZyuDP5E64LvpgpIU9ypgumc4DskZzlZ234Bt2SmqVv9lpSfoYGxpxVX5J1qlFkOTWb9Z6stf2AMCcCuT82J7CuDUvoHYR+zOxQDsVdS5FaxXucAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khTMT7w/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so1088725e9.0
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594735; x=1741199535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EofGUMdmxWitNR/1EFa3t6bpHugE1KAAwnzD29BQtG4=;
        b=khTMT7w//+ZqYglYBpfV6zp7oLO3+7LegPTq02U7La6m8o8UwtcEOZ8lJ/tX9c/3/a
         bWvwXIrQXKTKCTxVMxt19DE/JWY3aiTAuKDxSmxR4GiB4xusphLKiZSk6AbTjH4VS9xr
         TvBGwFMB+w23zKodsMhnhL7uS6HWLux0m6Gm/QdWLL9vXv4Wcheah2pPN6KHzgZGhwCN
         tJxYh8PRBN+HTvX2pk330HzNQHzavrC4fFvPwhAX1i8qeKZXDiXYL82LfKg6K2vEwXal
         7smn8LpIdgh0Jf+ZOAqlxSW0ax5Qoh94FKm/MDyk2T4Wd/FbexWY5pxxSC6pzNG0iH+t
         OeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594735; x=1741199535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EofGUMdmxWitNR/1EFa3t6bpHugE1KAAwnzD29BQtG4=;
        b=bxe22ssQKOYOAspTpftfHtGoJHsesMV6zXdnc+3LgOTqD+VauOxBeaC+UPcrxlI35q
         jvL2G7prE3NSLX51ANM7CtlignKtjwuZxt06QX70UwYGBq+t3rMO7ssXGkISwY459OwH
         l2j6nnvX/Ghllr/RM08G6On9BCLw6HkeGV4cuoyyhzAkW1b9IB1w6Lb4SdSZ7uguZVRZ
         nuYOMiMwLnh1qWvnghaPkFKy8Tu525VCuurDJrU4B6y6WtRJCooU13u8PCFDcoDeUVX8
         OKMVLEhjtgiAtKwbyAgPsSawnBX6apHAIHxyQqETwClY36pk3xjto4gCdrjnFZt4HvcQ
         80Iw==
X-Gm-Message-State: AOJu0Yx6efW0Cj+IbB0ajB2q4sQGD0WHVpfOzJicRO1hZJ8pUm+DaZCV
	QjaqGtcmBEs3UOJg16ItjHdvL2Efbrqf9UHlDllMgBNGmy6ezer6uDugOg==
X-Gm-Gg: ASbGnct7Cd1+vxxoGstS5wtZSwQTcammdKAWbPx7BnZZD58NJ8tF6fndFLteJZ/D72g
	q72h959l+7W8MzV+93t9IhS/puIIWq3tB14zXZXIKAo2VPBotCO2sSaHcFfFx6F0NGq1TorW1v5
	LJNUdhGrYeIXgkZjvKFOYvMpdddN0w6Qg2zttb7UtEhqAj6EBh8aFgpioixFZ3P0jMNnqR1iIuv
	C5dw8N7/00mI0juFdeDRcDkkmSpap1mSqbYmCyCKISUunkD8h2mAM52a1ylE7X27vdZ2svzQmAz
	5rhCoba+RrNtiUZvN1YOWBSA6lCCUvNkbYftqdpO/cpqjkB/1hB5TS3YrHxO7hIfFY/XZs4A6ON
	C6Mz51iHIhAYwGI1S6irNtWMKlvaMyk0=
X-Google-Smtp-Source: AGHT+IF5bHtAtR0nSrNNlQn7nlN55v/RWnyp96JBTG9S5k3vznqRUzmDlJLSG6HggG8oUcvL447upA==
X-Received: by 2002:a5d:59a7:0:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-38f7082b185mr23949448f8f.38.1740594735539;
        Wed, 26 Feb 2025 10:32:15 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866afesm6520531f8f.18.2025.02.26.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:32:15 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: add tests for bpf_dynptr_copy
Date: Wed, 26 Feb 2025 18:32:01 +0000
Message-ID: <20250226183201.332713-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
References: <20250226183201.332713-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add XDP setup type for dynptr tests, enabling testing for
non-contiguous buffer.
Add 2 tests:
 - test_dynptr_copy - verify correctness for the fast (contiguous
 buffer) code path.
 - test_dynptr_copy_xdp - verifies code paths that handle
 non-contiguous buffer.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  21 +++
 .../selftests/bpf/progs/dynptr_success.c      | 123 +++++++++++++++++-
 2 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index b614a5272dfd..e29cc16124c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -10,6 +10,7 @@ enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
 	SETUP_SKB_PROG_TP,
+	SETUP_XDP_PROG,
 };
 
 static struct {
@@ -18,6 +19,8 @@ static struct {
 } success_tests[] = {
 	{"test_read_write", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
@@ -120,6 +123,24 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 
 		break;
 	}
+	case SETUP_XDP_PROG:
+	{
+		char data[5000];
+		int err, prog_fd;
+		LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .repeat = 1,
+		);
+
+		prog_fd = bpf_program__fd(prog);
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+
+		if (!ASSERT_OK(err, "test_run"))
+			goto cleanup;
+
+		break;
+	}
 	}
 
 	ASSERT_EQ(skel->bss->err, 0, "err");
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index bfcc85686cf0..e1fba28e4a86 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -1,20 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Facebook */
 
+#include <vmlinux.h>
 #include <string.h>
 #include <stdbool.h>
-#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "bpf_kfuncs.h"
 #include "errno.h"
 
 char _license[] SEC("license") = "GPL";
 
 int pid, err, val;
 
-struct sample {
+struct ringbuf_sample {
 	int pid;
 	int seq;
 	long value;
@@ -121,7 +120,7 @@ int test_dynptr_data(void *ctx)
 
 static int ringbuf_callback(__u32 index, void *data)
 {
-	struct sample *sample;
+	struct ringbuf_sample *sample;
 
 	struct bpf_dynptr *ptr = (struct bpf_dynptr *)data;
 
@@ -138,7 +137,7 @@ SEC("?tp/syscalls/sys_enter_nanosleep")
 int test_ringbuf(void *ctx)
 {
 	struct bpf_dynptr ptr;
-	struct sample *sample;
+	struct ringbuf_sample *sample;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
@@ -567,3 +566,117 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 
 	return 1;
 }
+
+static inline int bpf_memcmp(const char *a, const char *b, u32 size)
+{
+	int i;
+
+	bpf_for(i, 0, size) {
+		if (a[i] != b[i])
+			return a[i] < b[i] ? -1 : 1;
+	}
+	return 0;
+}
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_copy(void *ctx)
+{
+	char data[] = "hello there, world!!";
+	char buf[32] = {'\0'};
+	__u32 sz = sizeof(data);
+	struct bpf_dynptr src, dst;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &src);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &dst);
+
+	/* Test basic case of copying contiguous memory backed dynptrs */
+	err = bpf_dynptr_write(&src, 0, data, sz, 0);
+	err = err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
+	err = err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
+	err = err ?: bpf_memcmp(data, buf, sz);
+
+	/* Test that offsets are handled correctly */
+	err = err ?: bpf_dynptr_copy(&dst, 3, &src, 5, sz - 5);
+	err = err ?: bpf_dynptr_read(buf, sz - 5, &dst, 3, 0);
+	err = err ?: bpf_memcmp(data + 5, buf, sz - 5);
+
+	bpf_ringbuf_discard_dynptr(&src, 0);
+	bpf_ringbuf_discard_dynptr(&dst, 0);
+	return 0;
+}
+
+SEC("xdp")
+int test_dynptr_copy_xdp(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr_buf, ptr_xdp;
+	char data[] = "qwertyuiopasdfghjkl";
+	char buf[32] = {'\0'};
+	__u32 len = sizeof(data);
+	int i, chunks = 200;
+
+	/* ptr_xdp is backed by non-contiguous memory */
+	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
+
+	/* Destination dynptr is backed by non-contiguous memory */
+	bpf_for(i, 0, chunks) {
+		err = bpf_dynptr_write(&ptr_buf, i * len, data, len, 0);
+		if (err)
+			goto out;
+	}
+
+	err = bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * chunks);
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, chunks) {
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
+		if (err)
+			goto out;
+		if (bpf_memcmp(data, buf, len) != 0)
+			goto out;
+	}
+
+	/* Source dynptr is backed by non-contiguous memory */
+	__builtin_memset(buf, 0, sizeof(buf));
+	bpf_for(i, 0, chunks) {
+		err = bpf_dynptr_write(&ptr_buf, i * len, buf, len, 0);
+		if (err)
+			goto out;
+	}
+
+	err = bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * chunks);
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, chunks) {
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
+		if (err)
+			goto out;
+		if (bpf_memcmp(data, buf, len) != 0)
+			goto out;
+	}
+
+	/* Both source and destination dynptrs are backed by non-contiguous memory */
+	err = bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * (chunks - 1));
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, chunks - 1) {
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len, 0);
+		if (err)
+			goto out;
+		if (bpf_memcmp(data, buf, len) != 0)
+			goto out;
+	}
+
+	if (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) != -E2BIG)
+		err = 1;
+
+out:
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+	return XDP_DROP;
+}
-- 
2.48.1


