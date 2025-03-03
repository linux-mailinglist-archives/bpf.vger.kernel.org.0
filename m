Return-Path: <bpf+bounces-53065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E7A4C29D
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119D818956FE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C511F3BAF;
	Mon,  3 Mar 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Cin/Ey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD6212FB3
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010285; cv=none; b=WqD/6Ov/ocVkeGOy7XKTsx4/uTvaYlPqHyrWJ2eOB1Dr1UKVda7yeub8rXuWL/IzyHizxak8yu0/JPmvJSCngX3+oNpv1g5adomM8sDtaR+NoP5IBvxcWkLKKEjUfdyr51s3oj8AE1IuUYWdE0qr9QBG6sumf2qoCudmClfDkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010285; c=relaxed/simple;
	bh=5GBOo3r62X/N9yzGkYPhUoSYkiTGhWgxkwe8JrQbfAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzfSCG/CH+8cAVp7ngOeU9U6S27jwl/z1YH7xJsKjQ8N9rij2GMoTAWg1yB8RynP6ao6w8qJacB2rQ8xFMm6q36uUv6UcFJ+I//hDY2Rb2lyha4wDoGuIkJC13DkCGDMJrvrmf+Di9BDWBJU9SFRfEgwFmcxcgchVGS2pawHz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Cin/Ey; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf4d756135so347455766b.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 05:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010282; x=1741615082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p4whArfH9IPn6ptyYPuMDThnFelGkYZfeRUPHSq5NE=;
        b=R2Cin/Ey2HULD4cJSMSuL7OR7OyxkC9i6qiVgBMn5IIhWabxUNL6m9UzWLvPXsKfhe
         46Ywc6li8Bg31oOq1XwUaC9TtWUpjzCK1Xe/aaphM1teBwGRMldJIQ8mFkvjYRG1q3HJ
         82Ru3AzhsZDez5l7uIWy71ukzTq1rTTe7iSpKXsg2MrZCfHL0rAqFMGIxmsgtaxe/U/N
         84ghPmSynXfhHSJhVpyu+Qg0oTqT9L6VfKf4fj9C5zgbH3sh+7/7fFs3VRNI4Gi1vn5x
         /NmDxIo+uO78D50Bvc6E9MqFvfDVVMakXXSCoQhD2SwHON+nNljLLZyIdW9qYMSZNPPW
         NVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010282; x=1741615082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2p4whArfH9IPn6ptyYPuMDThnFelGkYZfeRUPHSq5NE=;
        b=qKcVOtLJEoX6rOUBEUM92lR1a6DBxFj5SzIsxmdSt6oQnfnfS/vUNrwio65RSDQ15D
         Y+WNf6mAhchUZ8N7AL3eYHmIXwrDNPMxfDX6VHl/HtSe+npT2Q/EezNLH9bsQsxrMTB3
         tLPWbGdXyMip+7KCbECt/6zAC9kA45E77LIMTAUz5250zgiG9L1mMbWqTOGhmCIk88y+
         vSQnd2kcpgGSrVnzn1CC45ZBcvEivhTWqqF0klvsm7ZP3Y+uYDz3N6PjYf4xBU86k0Sv
         rvziFnWIteOHE6H1JAxwDyKmHKgW9PMnAg9RgoTAIR0rUMGRhwjZ8ZZGL3lWeu2wMgqW
         rG5w==
X-Gm-Message-State: AOJu0YwU7y1H7oivFuSZyig7cHBM2fIBSaNKCJ+TKYYj9N3J1S/Yy0C/
	DHJYwLc9Px9Y2ewCH2d5vRDYcrXjRVFCmbhbKERRhAHXTyvX1YGRV3RqIg==
X-Gm-Gg: ASbGnct9nCCz7bsEHY+LxfP7Tvgj3n0I/crW4dn9JvlPjrmr873WpiUqAGg+FaqDK4M
	+lVJ4NoWuyIU+f/uMWv5afngha8ro5UcD91UPNlPPeQ0tugXWJ9qExaRvvukMGc4wFVXpxa/x/I
	MQNmknHptcdL3KDYo5gqr+xk9bXGDGaOhJBqL0bgbdBklHDF4aXSHd6hpIkDvlw9cGSGL776CQ0
	6uQP5hwdTDE1BOXr5LRibeITA0WPk8sMGNFcarqPoMTWTrl18HQNsDBS53Ji9Cx0oB0A8ns6IQh
	KltDUrsCTcznemgehHadoYRDh0Vpp2jxtfk1w80FlzvIsu9xeIKaZ2jc66Q=
X-Google-Smtp-Source: AGHT+IERwLCtWdP+51e5ob+JxnTfMdUwQguN9EAlPA0BaFti5nIwnY1jez4d0ZDMR720FyBweturgA==
X-Received: by 2002:a17:906:f5aa:b0:abf:733f:5c42 with SMTP id a640c23a62f3a-abf733f5e0fmr425669266b.8.1741010282012;
        Mon, 03 Mar 2025 05:58:02 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:7e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfd7sm817975366b.148.2025.03.03.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:58:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: add tests for bpf_object__prepare
Date: Mon,  3 Mar 2025 13:57:52 +0000
Message-ID: <20250303135752.158343-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
References: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
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


