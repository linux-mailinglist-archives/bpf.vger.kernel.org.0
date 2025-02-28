Return-Path: <bpf+bounces-52886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF7A4A0ED
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF40189A7A9
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312E27426C;
	Fri, 28 Feb 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFMXFP7j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6D27127A
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765189; cv=none; b=JWMUsOsQWjzp7HwSA8n+KAvwvMl9GYIddf99U1v0kmL2JeUiNV8UgB1YuDDacLMKXW82m5tYknqWmvQ2J+zPTHjQWiCJLPU6KVsSl4Jwrxue/4tMWXfqKzStGLlg7RRiPhkL4nbZBAqQec00ocHvibK4Lt8b9yrvkBZvFVfHKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765189; c=relaxed/simple;
	bh=5GBOo3r62X/N9yzGkYPhUoSYkiTGhWgxkwe8JrQbfAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6dbhk/LynoEKrIYwWHz11bi7jCf2pc1NmqCA+P6Qoqz5ZpBF2mCvXnNk0ctACJqDkVbmiU4Nc3CAXXnnjiUeblNPjD4qGiUFCLD9yVPnxXkVKXjf10AmCnYxwFFdcjk3ZbFw0yJ62AVntgBB2gxDEtzIfs7K1xya3fCNDJbC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFMXFP7j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so23239595e9.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740765185; x=1741369985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p4whArfH9IPn6ptyYPuMDThnFelGkYZfeRUPHSq5NE=;
        b=UFMXFP7jAZ7O0ZUnU3nXb/WXER0aRd+tEpW9RZ8NUR3NEuEzw2nv80FpXbowQmQb1x
         /+FMvy/soHxTWCtQHvZR2hysEroXF5zDqHNvmGrVJm2PZt1Wxex2J46Be3jcvaw+4AXY
         e8Cii2pSo0V94AtogI8RbtsGeX8cdMQpu4Kqj5sVrEgFc42nA7Lmx4BYgvJHsmGL6szV
         J09DpZgtp9HZ1mAEcsmPAAf3bLy8PysGfM1vI97PEg/7ZyW84pkFxrnu5xKI962iF7If
         xQKyHTlI7+Wig4PbUEeEDZWTpv+rr81R8O7dmbplC9tYZVWjeHgj1bh6TlDkGnPsQ6BK
         nObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765185; x=1741369985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p4whArfH9IPn6ptyYPuMDThnFelGkYZfeRUPHSq5NE=;
        b=TZso+qRgVfztIizIiRzGBKz9wdrmW43Pa2qddQCHUnorUORiTlNfKkhSDmUyM6sTdd
         s0GmCj6gCcJG5rdDb924jQpKTT3g0C0GS0Xjm+27gf6822SeJFrLGE+ydiwOGng79osH
         enYyAzVfUaJYqU59J9smwy8sz46C1s46oM/ohx43HX/mev743qaYvE++Av5UDR994PyV
         bKgR+g123CMDqHkqZb4w6GpEMlL5T9s8MPulbiYu9Fz613CeSF+86nLhTHdCR+bUCFJu
         vt9814rLwSDHJe1RKnlfT+FsTbfPaKWdifnOIOQItGJ3d6+7w9+gJo4m2LzzUnGRu+EE
         R3GA==
X-Gm-Message-State: AOJu0Yyvnpl31Ic6LCF5q8D8lVCp8qsZxDNVNOpYpp9q2PAJbrCkAl7C
	iX2pIfsrLflPchjSqklpet2pgUxAPX+SMlBEk8RVGFLd/xpF4eKHdvf/bQ==
X-Gm-Gg: ASbGnctlBbPeZbWrxZL+14Kh7pVP1I695nz7QEBYSFeWGTUDADUFMOoKvPu4oKBE+GZ
	boH+XOCrkaoJPBblONPgXRmdbsaiZZZ1yDBe4pup907dkfqS57a8hIsuZG7sT7fbt2+VEdvyoFq
	G6CmJ/jUTK9UJiqH/wxgLmI1u4Ak0hyeIk0sArssQzMgfV42b7YMJkFHVJ6DUfSK7phdf4vI21C
	7Rnaq06Hu2poG4l15YIK7/eWLNV+DgBok6f1cLTdKzAEKwXf5Ix28IdKKPQ4Yrf5hsVABwQHqFV
	feVzKsXMCOS9YRUYWdYdm10NzseoshWRMDAzyrQRHOiRtdr5DDkbefY4ZcCwcWG28y7A7kumuUo
	WN0okNqYaJht3c3BTkCPi9p+csFjISoU=
X-Google-Smtp-Source: AGHT+IHYLvP2tDKFA2jGzJ2JfOWtNtw/kSHH62jefQTwxh3S9dAUVFJv2ZbSZE1RB5IM5yOmqBsPAA==
X-Received: by 2002:a05:600c:4444:b0:439:92ca:f01b with SMTP id 5b1f17b1804b1-43ba6708bd2mr38879455e9.13.1740765185305;
        Fri, 28 Feb 2025 09:53:05 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm5861664f8f.40.2025.02.28.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:53:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add tests for bpf_object__prepare
Date: Fri, 28 Feb 2025 17:52:55 +0000
Message-ID: <20250228175255.254009-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add selftests, checking that running bpf_object__prepare successfully
creates maps before load step.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/prepare.c        | 99 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/prepare.c   | 28 ++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prepare.c
 create mode 100644 tools/testing/selftests/bpf/progs/prepare.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prepare.c b/tools/testing/selftests/bpf/prog_tests/prepare.c
new file mode 100644
index 000000000000..fb5cdad97116
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prepare.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "prepare.skel.h"
+
+static bool check_prepared(struct bpf_object *obj)
+{
+	bool is_prepared = true;
+	const struct bpf_map *map;
+
+	bpf_object__for_each_map(map, obj) {
+		if (bpf_map__fd(map) < 0)
+			is_prepared = false;
+	}
+
+	return is_prepared;
+}
+
+static void test_prepare_no_load(void)
+{
+	struct prepare *skel;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+	);
+
+	skel = prepare__open();
+	if (!ASSERT_OK_PTR(skel, "prepare__open"))
+		return;
+
+	if (!ASSERT_FALSE(check_prepared(skel->obj), "not check_prepared"))
+		goto cleanup;
+
+	err = bpf_object__prepare(skel->obj);
+
+	if (!ASSERT_TRUE(check_prepared(skel->obj), "check_prepared"))
+		goto cleanup;
+
+	if (!ASSERT_OK(err, "bpf_object__prepare"))
+		goto cleanup;
+
+cleanup:
+	prepare__destroy(skel);
+}
+
+static void test_prepare_load(void)
+{
+	struct prepare *skel;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+	);
+
+	skel = prepare__open();
+	if (!ASSERT_OK_PTR(skel, "prepare__open"))
+		return;
+
+	if (!ASSERT_FALSE(check_prepared(skel->obj), "not check_prepared"))
+		goto cleanup;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "bpf_object__prepare"))
+		goto cleanup;
+
+	err = prepare__load(skel);
+	if (!ASSERT_OK(err, "prepare__load"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(check_prepared(skel->obj), "check_prepared"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.program);
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto cleanup;
+
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->err, 0, "err");
+
+cleanup:
+	prepare__destroy(skel);
+}
+
+void test_prepare(void)
+{
+	if (test__start_subtest("prepare_load"))
+		test_prepare_load();
+	if (test__start_subtest("prepare_no_load"))
+		test_prepare_no_load();
+}
diff --git a/tools/testing/selftests/bpf/progs/prepare.c b/tools/testing/selftests/bpf/progs/prepare.c
new file mode 100644
index 000000000000..1f1dd547e4ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/prepare.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+//#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int err;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} array_map SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int program(struct __sk_buff *skb)
+{
+	err = 0;
+	return 0;
+}
-- 
2.48.1


