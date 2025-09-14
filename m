Return-Path: <bpf+bounces-68350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92449B56CB1
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF06A1746B2
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA562E7BDB;
	Sun, 14 Sep 2025 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4nacPUd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860AF2E6CA9;
	Sun, 14 Sep 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886724; cv=none; b=Bn2i4Dr7Enm/mUFeEkhTBmkkQ8Fuy+QwUtFTYZ3iuTNzXKspI6nNLfC7+y0VEQNBg4y1OjPYkxJa2+VL1cBh3DwzsnvqELBk6eVEzMaIfrLUyZHz3ftk/yj2NFffuEP/qmonsFFOI4mExijDg4Mk1MMVhYnn3F1dqWgB4wX0rZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886724; c=relaxed/simple;
	bh=0y+UJa/JPWyRIrLzDd6oJLvZcJqjApQ21JC1cX8b5fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAAZyWUiQxftzE6+c8G5md7HdKHxRO0h209ytYRUzhDSgUkXFfg45l/5zS9qYwPiemowrFk6qfz2HBioZfvaGtca3XMZajYpZ5acLhrAo80bAQQhIK4En7jGxwbCrHNT2+XnxpuVhM4RgGt74yak8QHgXJVmz81CoyawFTOse5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4nacPUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDE6C4CEFC;
	Sun, 14 Sep 2025 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886724;
	bh=0y+UJa/JPWyRIrLzDd6oJLvZcJqjApQ21JC1cX8b5fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4nacPUdWnfT2pbimJxiu+I0hNSzgpc/khnK0gISkrry4wFO6iE5McyqWGU5DYI0z
	 GWEYkmZqr5+eEp1vmQqbOp1R/ScGLKsiYc6Oli3FdSnF9bxH6rB9sWQ/wgYZf+/r7V
	 FAUgxRgoO8eqOdyGs+Q+rnOlVRd00E/wnaI0bi7gjEIwlmbaJJZnNXiX+f4xdWDQOL
	 la17CkenHSTkG0dy9wK1j4xCrH9Nd+BLomICnPWKWypyIATRyNbn8Wb1cM/YUK6fDL
	 QHW38qEBoUKxbjOQvnbdF7KPrYoshU/9Y6gc+lhAJTPqLJtNlrVoEiqlwSlQk+hu78
	 f/UxjAr+3LYkQ==
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
Subject: [PATCH v4 05/12] selftests/bpf: Add tests for exclusive maps
Date: Sun, 14 Sep 2025 23:51:34 +0200
Message-ID: <20250914215141.15144-6-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914215141.15144-1-kpsingh@kernel.org>
References: <20250914215141.15144-1-kpsingh@kernel.org>
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
 .../selftests/bpf/prog_tests/map_excl.c       | 54 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_excl.c  | 34 ++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_excl.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_excl.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
new file mode 100644
index 000000000000..6bdc6d6de0da
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Google LLC. */
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
+	ASSERT_EQ(err, -EACCES, "exclusive map access not denied\n");
+out:
+	map_excl__destroy(skel);
+
+}
+
+void test_map_excl(void)
+{
+	if (test__start_subtest("map_excl_allowed"))
+		test_map_excl_allowed();
+	if (test__start_subtest("map_excl_denied"))
+		test_map_excl_denied();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_excl.c b/tools/testing/selftests/bpf/progs/map_excl.c
new file mode 100644
index 000000000000..d461684728e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_excl.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Google LLC. */
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


