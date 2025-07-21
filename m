Return-Path: <bpf+bounces-63949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C36B0CC67
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840CB7B0331
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCEF24292E;
	Mon, 21 Jul 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRpLq9Lu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765B23F294;
	Mon, 21 Jul 2025 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132816; cv=none; b=gnn5DrU+pdJCdHfeu+SUvtu/RXlc0r5qap9PXUMt81QSpjYDM31Q6elbQdNnY6PSOzm61MqMQ8BDfE8GOW6c9vKivi/19TtwFxIq/v2MHNn1IYPg+vD/5yUh0JZRS+nFCh1QU36o2nzfApTmDM6JMBKFj+Nj7/9oQafPdRE/JQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132816; c=relaxed/simple;
	bh=Jlz2qIJe1GtUM9B38XMo3nuVrZvRmVevuwmM1rYKHSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hnp0RrsPWJ6BGMopOnscUiCx0VcijDyxifmW/RS4QEZnKRN237Xt4qzynpE5QhFliH/DRJY11ss5bEbV5yk137HIK/kuY5wVQz29NsKj4mHDQb7Mo6hSMuUjv5sUVnbp0uxaculgRrhSfL5J/DkW9c3v29gsu4ZQpVwV4rljw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRpLq9Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B4BC4CEF5;
	Mon, 21 Jul 2025 21:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132816;
	bh=Jlz2qIJe1GtUM9B38XMo3nuVrZvRmVevuwmM1rYKHSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRpLq9LuQnK4KYh+Ql6QBh5deKhVery+I0PHdYXY6MrYGbvfhMyXBW+TWFb6bgINR
	 wI626QE0AXu7S/yynrZ/IP9Yl/KF4UIsWGWtxWaUAlL/FIBiBq1x2I/ovxqsKh5x2X
	 W/oBvAonCejcpoHw1xfJwQDjY/Cl1K1+Hz/R842h3x+A7WdZR5+2zw9On7XQJRJnIy
	 BmDXc3ENBbX02kqy2OmHRHrG0tBpk+Kg6dsu55wDDsQCPmNOKFuTx7ow3F2mJeyMgT
	 DvcaOyP0T0QD4GmtY3sKpRL8Z0bzrvPVOQVrd2bZO/rYzDyetVXK/YHtnGb6cu3B6E
	 eI3nxpNMIcHKg==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 05/13] selftests/bpf: Add tests for exclusive maps
Date: Mon, 21 Jul 2025 23:19:50 +0200
Message-ID: <20250721211958.1881379-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721211958.1881379-1-kpsingh@kernel.org>
References: <20250721211958.1881379-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if access is denied to another program for an exclusive map

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 56 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_excl.c  | 34 +++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_excl.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_excl.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
new file mode 100644
index 000000000000..7a49917c691a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#include "map_excl.skel.h"
+
+static void test_map_excl_allowed(void)
+{
+	struct map_excl *skel = map_excl__open();
+	int err;
+
+	err = bpf_map__set_exclusive_program(skel->maps.excl_map, skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__set_exclusive_program"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.should_have_access, true);
+	bpf_program__set_autoload(skel->progs.should_not_have_access, false);
+
+	err = map_excl__load(skel);
+	ASSERT_OK(err, "map_excl__load");
+out:
+	map_excl__destroy(skel);
+}
+
+static void test_map_excl_denied(void)
+{
+	struct map_excl *skel = map_excl__open();
+	int err;
+
+	err = bpf_map__set_exclusive_program(skel->maps.excl_map, skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__make_exclusive"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.should_have_access, false);
+	bpf_program__set_autoload(skel->progs.should_not_have_access, true);
+
+	err = map_excl__load(skel);
+	ASSERT_EQ(err, -EACCES, "exclusive map Paccess not denied\n");
+out:
+	map_excl__destroy(skel);
+
+}
+
+void test_map_excl(void)
+{
+	start_libbpf_log_capture();
+	if (test__start_subtest("map_excl_allowed"))
+		test_map_excl_allowed();
+	stop_libbpf_log_capture();
+	if (test__start_subtest("map_excl_denied"))
+		test_map_excl_denied();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_excl.c b/tools/testing/selftests/bpf/progs/map_excl.c
new file mode 100644
index 000000000000..26c32b4f2ce0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_excl.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <linux/bpf.h>
+#include <time.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} excl_map SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int should_have_access(void *ctx)
+{
+	int key = 0, value = 0xdeadbeef;
+
+	bpf_map_update_elem(&excl_map, &key, &value, 0);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+int should_not_have_access(void *ctx)
+{
+	int key = 0, value = 0xdeadbeef;
+
+	bpf_map_update_elem(&excl_map, &key, &value, 0);
+	return 0;
+}
-- 
2.43.0


