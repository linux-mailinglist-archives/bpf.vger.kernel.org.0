Return-Path: <bpf+bounces-59970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5208AD0A47
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FDA1892A9F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3023F40A;
	Fri,  6 Jun 2025 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4MKBDYw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0523E34F;
	Fri,  6 Jun 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252574; cv=none; b=UNdUNeDE+IX2YHjCwjIQJuSps/kBL1ZNz+//hNXLwK5s2GP48bV9Xf4pPw8bcQEtZj5VpQReJ0wPAJJojrFbN8EpJrvoGt2ztPw44Buxi4rTkJe9kiJwJ29U30wcByFyGfOqnJrpmYn/z/oqmmratglkTQl1LZVfkCczrFeo2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252574; c=relaxed/simple;
	bh=2khBpmSfehxgg81AbSOn0K1n9kjaXaa/9LyUcVzuxbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaalLyoJGgxNeT6b2XRfQEu5diTC/bmYRxsHDbGX+kQQQAG6wljmWw9KI+7t41bgndUvlf37BvxBBtteeYpWWtPur8N4Ln6BULQd6dOPNlbYYDnz+oMVXkuKrPbucKE3Vk0XKN594jtW8pHtcdHk5n1Aa16F0cK4ZnPF3taAtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4MKBDYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3755C4CEF2;
	Fri,  6 Jun 2025 23:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252573;
	bh=2khBpmSfehxgg81AbSOn0K1n9kjaXaa/9LyUcVzuxbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4MKBDYwQdSOTufG+1eS3cZ48YxumCihFJ26ek+VEJE2u3DXKObQ9JhCKVA4bz0LI
	 XXIZi1TTC02uxgFTVErTNykpKfiaFF/tsmziFMkITEUX0xyroxhD6PZOXhgGiIXVN2
	 IhOl7EGe8E5DUFP+npShXXkKW0RWfQzqVNM7znSnx95Ibqxq9lWrS/nh9Bx2bYM0He
	 zGJMRcbnqjP1rLjMWuuBWEZdvbP8+tEUB9YiD2jIU3PrLgUwvkHygZyfoRNncDumIh
	 5MERAfSKU7S1wVgcPh9i/t4arDvkR2J6wFpcU20WHxjVvem9xQeYNj4bw+SCxw883V
	 mZ37KjCtN1dpA==
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
Subject: [PATCH 06/12] selftests/bpf: Add tests for exclusive maps
Date: Sat,  7 Jun 2025 01:29:08 +0200
Message-ID: <20250606232914.317094-7-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* maps of maps are currently cannot be exclusive.
* inner maps cannot be exclusive
* Check if access is denied to another program for an exclusive map.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 .../selftests/bpf/prog_tests/map_excl.c       | 130 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_excl.c  |  65 +++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_excl.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_excl.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_excl.c b/tools/testing/selftests/bpf/prog_tests/map_excl.c
new file mode 100644
index 000000000000..2f6f81ef7ae2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_excl.c
@@ -0,0 +1,130 @@
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
+static void test_map_exclusive_inner(void)
+{
+	struct map_excl *skel;
+	int err;
+
+	skel = map_excl__open();
+	if (!ASSERT_OK_PTR(skel, "map_excl open"))
+		return;
+
+	err = bpf_map__make_exclusive(skel->maps.inner_map,
+				      skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__make_exclusive"))
+		goto out;
+
+	err = map_excl__load(skel);
+	ASSERT_EQ(err, -EOPNOTSUPP, "map_excl__load");
+
+out:
+	map_excl__destroy(skel);
+}
+
+static void test_map_exclusive_outer_array(void)
+{
+	struct map_excl *skel;
+	int err;
+
+	skel = map_excl__open();
+	if (!ASSERT_OK_PTR(skel, "map_excl open"))
+		return;
+
+	err = bpf_map__make_exclusive(skel->maps.outer_array_map,
+				      skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__make_exclusive"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.should_have_access, true);
+	bpf_program__set_autoload(skel->progs.should_not_have_access, false);
+
+	err = map_excl__load(skel);
+	ASSERT_EQ(err, -EOPNOTSUPP, "exclusive maps of maps are not supported\n");
+out:
+	map_excl__destroy(skel);
+}
+
+static void test_map_exclusive_outer_htab(void)
+{
+	struct map_excl *skel;
+	int err;
+
+	skel = map_excl__open();
+	if (!ASSERT_OK_PTR(skel, "map_excl open"))
+		return;
+
+	err = bpf_map__make_exclusive(skel->maps.outer_htab_map,
+				      skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__make_exclusive"))
+		goto out;
+
+	bpf_program__set_autoload(skel->progs.should_have_access, true);
+	bpf_program__set_autoload(skel->progs.should_not_have_access, false);
+
+	err = map_excl__load(skel);
+	ASSERT_EQ(err, -EOPNOTSUPP, "exclusive maps of maps are not supported\n");
+
+out:
+	map_excl__destroy(skel);
+}
+
+static void test_map_excl_allowed(void)
+{
+	struct map_excl *skel = map_excl__open();
+	int err;
+
+	err = bpf_map__make_exclusive(skel->maps.excl_map, skel->progs.should_have_access);
+	if (!ASSERT_OK(err, "bpf_map__make_exclusive"))
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
+	err = bpf_map__make_exclusive(skel->maps.excl_map, skel->progs.should_have_access);
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
+	if (test__start_subtest("map_exclusive_outer_array"))
+		test_map_exclusive_outer_array();
+	if (test__start_subtest("map_exclusive_outer_htab"))
+		test_map_exclusive_outer_htab();
+	if (test__start_subtest("map_exclusive_inner"))
+		test_map_exclusive_inner();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_excl.c b/tools/testing/selftests/bpf/progs/map_excl.c
new file mode 100644
index 000000000000..9543aa3ab484
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_excl.c
@@ -0,0 +1,65 @@
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
+struct inner_map_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	__uint(max_entries, 1);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct inner_map_type);
+} outer_array_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1);
+	__array(values, struct inner_map_type);
+} outer_htab_map SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
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


