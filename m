Return-Path: <bpf+bounces-65550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7184B254DE
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F068F58427F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FAB303C81;
	Wed, 13 Aug 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQO9pAay"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A92FE597;
	Wed, 13 Aug 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118543; cv=none; b=BcYY1f/CZgavt6dWchbV2hQMa4A7gJ+A2ChMGr7sucbaq4on+al1FS7OUZSHqwG7wdCfG8bvdyxz6Gyq8gPM66BpOKF840/rwvN94ilvvVKke7bYcReHQycuD98OJT/Gn7yaMduEgXRjAl50OEzMypslhtF0pjJeAq8kr97WZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118543; c=relaxed/simple;
	bh=Jlz2qIJe1GtUM9B38XMo3nuVrZvRmVevuwmM1rYKHSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTAU3eeLqfEV0RZw6JSdFebCE2bLNSzUeT4MCdASP2rj2VP8BB24zU5ajyU5TLMIgRsbGr6pIObL51FCatYoImkKsCFFLIez4Y+ujrktvreNvluDdTZ6o5cDLDzIGbVL0Gv6E7srrBJg30cF5dvzUyEYFvx4yAzoPCaDRPABL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQO9pAay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E00EC4CEFA;
	Wed, 13 Aug 2025 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118543;
	bh=Jlz2qIJe1GtUM9B38XMo3nuVrZvRmVevuwmM1rYKHSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQO9pAay4/2rUE53dsOMtDYDDFR42M1+z73c6TWQz5+CRj5HiTlyjVQkr9dGPn8n2
	 y5p+zynKVBgmafXUSY414QBIwR4PNiIN8dD89BcOH7Xebvthp1SFsNlCjG0EHyXMUo
	 kXmji5n7ZMZ4xHZ432/pfDfJr7zBojc8nRV8D/iNpaumrSf9FqANAdmrpI+ud9SFT4
	 gwFM3N77TpfhJvvNC+7Y0FwtRFBBpgIwOh5GQqrPvVPM7LkLNFgzypzCAU5UJLJEpL
	 jEiYh59HzdVvZ4i1fp7RRRuCJrFy9lVNjrXf5+PSUPiSudYRTbcTmU4zLP89BtcKVg
	 VuGCAUn7bfnpg==
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
Subject: [PATCH v3 05/12] selftests/bpf: Add tests for exclusive maps
Date: Wed, 13 Aug 2025 22:55:19 +0200
Message-ID: <20250813205526.2992911-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813205526.2992911-1-kpsingh@kernel.org>
References: <20250813205526.2992911-1-kpsingh@kernel.org>
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


