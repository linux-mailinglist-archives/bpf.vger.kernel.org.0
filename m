Return-Path: <bpf+bounces-55091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B21A780E1
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564F33A813A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B420DD5C;
	Tue,  1 Apr 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOixcVvG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7A20D517
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526469; cv=none; b=VnhtRGfy1nNpE/h+Yv7HaBhkImwlIyXDu8tuLaj7jyQ/PkRVyKgGtFnTQ3ee9hAAwbUIkI+64mMjvsu5GNSpOybeVmkG9msgk93pDP1ZCFQBOR7Ge7Ybs3HsfcjgQzVsJiWAKWY9bo8gQlUD/7P/wfk/rgCgUMzfZWShzCZnUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526469; c=relaxed/simple;
	bh=rKbNtV4bprcIu+3GaX2HKmJxlle8CjeVPheOuwR85bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSlTaXsvBwRYroIg4lbM24O+xuJi+Q5dgnUbbI93HJuFlK/+eaa7OEPdhumJtUXcWNB7VqkgjiFdneXqOWLeYFr09x8g9ghZg2yxnExjJzGnkjA5VqiLG5H1okesJWUu7rltppnbIRYMOVzFEII4Z2zZI0k1Rg8fpFuTRIB0LjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOixcVvG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so30878865e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526466; x=1744131266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojALwK1S+wEOV139aLxoflByFcNtM/5VELMW7+vehr0=;
        b=FOixcVvGZxLxrLrfoX44cEkKSWfvDjdwcqQZ2R5xUTHYkXYXh7qGw+yM/M07hIQuv5
         X1scmeURd851wE59D9jBsH8vRsgWA5NbqZC2QoLs3FNP1EBVGvJEYe2IrxVthtfQ0WXY
         7tWWQ2PlsaOib9HOL1MBimRvcXx7SnSeEWiUDse69HTYmLLwqKZOhc7UnzZ+MHmgX+92
         1WD/6ojpyYzwhmUIVr3io9iPz9D2jBrj8Cd2187eYGOM7YM+dfWddDyN2IcMSlz0fWm+
         RPpDtWMguEM9IrtXuwN/NIECPbJf+NCXEZgWpNiZy4hULUA6eYiudWAR38Gt+bhQdCYm
         VIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526466; x=1744131266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojALwK1S+wEOV139aLxoflByFcNtM/5VELMW7+vehr0=;
        b=sAEoFijh/bTP+4FmoCdnYkmDRx3BftXOzgiIb0mq8q3Q5ZTKvfhCisq2st906kIDo8
         jE7LTy61L2rtlLxCNGD4B0ZSX4dcDxcu4s50E5ioIaTXvfhLFBsIHBHP4T+J4DciO/IP
         tFn+3x2ZW2FAxVkl9bmRCZ/yhpkuUoL137XGXVt0CsLzdXvVTWIYczc9p7hsOWFsCWQw
         oYTTa2mxWnEkdDKiKuk1gDwLjON5jeXtj2ZTFVVqgDt4zTWj1BDfN0077qRtEslQoMjD
         T47YSU0WVGOkYoeCjMxeeU8MKVSccBmCqdKqm4AfDbBXMBUpON+ztSPV6XVBZjTpcqow
         v3ng==
X-Gm-Message-State: AOJu0Yyv4+/YsTimoop3EotXYs88dkHml5n5dedGzo0YYE3bypLuNkqC
	lJClgyUgVkqtprf8s7mUP1C2GeV1FIO8WjgDSrdOifZH+dLmD9sdx/o9FA==
X-Gm-Gg: ASbGncvIK4SG49M/MYtb6BWudVvqADdyIMC/3E33e0PcR7nMx7xVV/CvuqI3rvw1XME
	gSWKKglt70d51gg0M7+C1JyRBmzJoqYpnllygVVz0p6zZpt4McL4WKVu73P8tUViZ6w/+PT9HZ3
	h9XjDGCOOeey2pAoVCmUqbbtzFBIw2VJatoQs8JzG7gdEkatum0d4Ww9CGw6v4TkBNJ3jstP0zc
	DB+sl6nuC7yhRo0eFgb29X3g96Xrhsms/x3N0MeDFP28nkpR4NtNcZlRmfnAMdAxjwFOLahsXEV
	EtU90rSGCAhLoPGK4xDD8qamSpONKmqjp74YHRNI6IxCuzjjpjz+9gqLtdfsIj6AmYnNUarLtg=
	=
X-Google-Smtp-Source: AGHT+IGbLD8FLv2/6Y23zd+qMiuzXYImcT88eRHiRoV0o3tBzytGgdZTy+LVHoN9EvANgL8f0hTUfA==
X-Received: by 2002:a05:600c:229a:b0:43d:fa58:8377 with SMTP id 5b1f17b1804b1-43dfa588414mr82112715e9.32.1743526466019;
        Tue, 01 Apr 2025 09:54:26 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d84632ffcsm201397215e9.31.2025.04.01.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:54:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add .BTF.ext line/func info getter tests
Date: Tue,  1 Apr 2025 17:54:17 +0100
Message-ID: <20250401165417.170632-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401165417.170632-1-mykyta.yatsenko5@gmail.com>
References: <20250401165417.170632-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add selftests checking that line and func info retrieved by newly added
libbpf APIs are the same as returned by kernel via bpf_prog_get_info_by_fd.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/test_btf_ext.c   | 111 ++++++++++++++++++
 .../selftests/bpf/progs/test_btf_ext.c        |  21 ++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
new file mode 100644
index 000000000000..00aeebc8f863
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include <test_progs.h>
+#include "test_btf_ext.skel.h"
+#include "btf_helpers.h"
+
+static void subtest_line_info(void)
+{
+	struct test_btf_ext *skel;
+	struct bpf_prog_info info;
+	struct bpf_line_info line_info[1024], *libbpf_line_info;
+	__u32 info_len = sizeof(info), libbbpf_line_info_cnt;
+	int err, fd, i;
+
+	skel = test_btf_ext__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.global_func, true);
+
+	err = test_btf_ext__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.global_func);
+
+	memset(&info, 0, sizeof(info));
+	info.line_info = ptr_to_u64(&line_info);
+	info.nr_line_info = sizeof(line_info);
+	info.line_info_rec_size = sizeof(*line_info);
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_info"))
+		goto out;
+
+	libbpf_line_info = bpf_program__line_info(skel->progs.global_func);
+	libbbpf_line_info_cnt = bpf_program__line_info_cnt(skel->progs.global_func);
+
+	if (!ASSERT_OK_PTR(libbpf_line_info, "bpf_program__line_info"))
+		goto out;
+	if (!ASSERT_GT(libbbpf_line_info_cnt, 0, "line_info_cnt>0"))
+		goto out;
+	if (!ASSERT_EQ(libbbpf_line_info_cnt, info.nr_line_info, "line_info_cnt"))
+		goto out;
+
+	for (i = 0; i < libbbpf_line_info_cnt; ++i) {
+		int eq = memcmp(libbpf_line_info + i, line_info + i, sizeof(*line_info));
+
+		if (!ASSERT_EQ(eq, 0, "line_info"))
+			goto out;
+	}
+
+out:
+	test_btf_ext__destroy(skel);
+}
+
+static void subtest_func_info(void)
+{
+	struct test_btf_ext *skel;
+	struct bpf_prog_info info;
+	struct bpf_func_info func_info[1024], *libbpf_func_info;
+	__u32 info_len = sizeof(info), libbbpf_func_info_cnt;
+	int err, fd, i;
+
+	skel = test_btf_ext__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.global_func, true);
+
+	err = test_btf_ext__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.global_func);
+
+	memset(&info, 0, sizeof(info));
+	info.func_info = ptr_to_u64(&func_info);
+	info.nr_func_info = sizeof(func_info);
+	info.func_info_rec_size = sizeof(*func_info);
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_info"))
+		goto out;
+
+	libbpf_func_info = bpf_program__func_info(skel->progs.global_func);
+	libbbpf_func_info_cnt = bpf_program__func_info_cnt(skel->progs.global_func);
+
+	if (!ASSERT_OK_PTR(libbpf_func_info, "bpf_program__func_info"))
+		goto out;
+	if (!ASSERT_GT(libbbpf_func_info_cnt, 0, "func_info_cnt>0"))
+		goto out;
+	if (!ASSERT_EQ(libbbpf_func_info_cnt, info.nr_func_info, "func_info_cnt"))
+		goto out;
+
+	for (i = 0; i < libbbpf_func_info_cnt; ++i) {
+		int eq = memcmp(libbpf_func_info + i, func_info + i, sizeof(*func_info));
+
+		if (!ASSERT_EQ(eq, 0, "func_info"))
+			goto out;
+	}
+
+out:
+	test_btf_ext__destroy(skel);
+}
+
+void test_btf_ext(void)
+{
+	if (test__start_subtest("func_info"))
+		subtest_func_info();
+	if (test__start_subtest("line_info"))
+		subtest_line_info();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_btf_ext.c b/tools/testing/selftests/bpf/progs/test_btf_ext.c
new file mode 100644
index 000000000000..be92e445a988
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_btf_ext.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms Inc. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+const volatile int val = 3;
+
+static __attribute__ ((noinline))
+int f0(int var)
+{
+	int retval = var + val;
+
+	return retval;
+}
+
+SEC("tc")
+int global_func(struct __sk_buff *skb)
+{
+	return f0(skb->len);
+}
-- 
2.49.0


