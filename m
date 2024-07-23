Return-Path: <bpf+bounces-35344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B055D93991F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 07:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD8C1C21A58
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 05:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1E13BAFE;
	Tue, 23 Jul 2024 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUxqT2Zy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A718D
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721711728; cv=none; b=GluzEE10/UNyNWA59iVLdP9jCZkUuFLwI0gUzYyK6WIjd19mOR4nGoy7Al4Gec8y5j8Dl1GkhYJKnlWiMX/ZMK7L2HNgI4VTiBiqoWVuQbPSwpbxOWtnpStpDbrQszdVXgEQMjvgTbeB7I0HaR6cF69KNj0pvLOF6Tizd7JX/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721711728; c=relaxed/simple;
	bh=qongxs3Cg31ginS50mBJ1KazckHoBhiYnW03F/8cWog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbC6bUMwyLuciZr031e1ahoekjIAqB9RNUIKotjryvjG/VU5kN2mJxBM8d/N7fChyJ1t2ViMILEEkh3K/rPRHp/0oX3LghtDzZFYKAek31eGcLx06xd9PkPUOtSSpV/LbP93SjKajERG+rTIFrd4tU+vXaoD0rlGsulvT8hGY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUxqT2Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF15C4AF09;
	Tue, 23 Jul 2024 05:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721711727;
	bh=qongxs3Cg31ginS50mBJ1KazckHoBhiYnW03F/8cWog=;
	h=From:To:Cc:Subject:Date:From;
	b=gUxqT2Zyap8WDz/7XY9YouSMZNI7872q9XrRVOPCsUjEN3oC+DcLLEcouGxerIkmL
	 CsTlhQ69ObvWLZ0iuDiuQkNzn5uyk0xfOGJIpw+BByXjxxKNYy65cHxam1mN9B25GI
	 hxfhoC7k1w2pDfggeQf07kkvsrXJLh/WBT8QoIkTJidMcPJad8Yx52yvL90eUgV7ae
	 zQaVzfqrONBrAZkox/TXqZ5ssmxQengvwD+dpj6yBYwEhb+RH3RvZC6+qSkYtC9ar6
	 rbjGsr4mU6YdmhG/vMk/TpxeU/8Fagx7HsZ54tvsIACfJlWEfEiZwk/lzGvw2Vgudc
	 QiccLV0LdfPkQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Add a test for mmap-able map in map
Date: Mon, 22 Jul 2024 22:14:55 -0700
Message-ID: <20240723051455.1589192-1-song@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regular BPF hash map is not mmap-able from user space. However, map-in-map
with outer map of type BPF_MAP_TYPE_HASH_OF_MAPS and mmap-able array as
inner map can perform similar operations as a mmap-able hash map. This
can be used by applications that benefit from fast accesses to some local
data.

Add a selftest to show this use case.

Signed-off-by: Song Liu <song@kernel.org>
---
 .../bpf/prog_tests/test_mmap_inner_array.c    | 57 ++++++++++++++++++
 .../selftests/bpf/progs/mmap_inner_array.c    | 59 +++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_mmap_inner_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/mmap_inner_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_mmap_inner_array.c b/tools/testing/selftests/bpf/prog_tests/test_mmap_inner_array.c
new file mode 100644
index 000000000000..ce745776ed18
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_mmap_inner_array.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include "mmap_inner_array.skel.h"
+
+void test_mmap_inner_array(void)
+{
+	const long page_size = sysconf(_SC_PAGE_SIZE);
+	struct mmap_inner_array *skel;
+	int inner_array_fd, err;
+	void *tmp;
+	__u64 *val;
+
+	skel = mmap_inner_array__open_and_load();
+
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	inner_array_fd = bpf_map__fd(skel->maps.inner_array);
+	tmp = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, inner_array_fd, 0);
+	if (!ASSERT_OK_PTR(tmp, "inner array mmap"))
+		goto out;
+	val = (void *)tmp;
+
+	err = mmap_inner_array__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out_unmap;
+
+	skel->bss->pid = getpid();
+	usleep(1);
+
+	/* pid is set, pid_match == true and outer_map_match == false */
+	ASSERT_TRUE(skel->bss->pid_match, "pid match 1");
+	ASSERT_FALSE(skel->bss->outer_map_match, "outer map match 1");
+	ASSERT_FALSE(skel->bss->done, "done 1");
+	ASSERT_EQ(*val, 0, "value match 1");
+
+	err = bpf_map__update_elem(skel->maps.outer_map,
+				   &skel->bss->pid, sizeof(skel->bss->pid),
+				   &inner_array_fd, sizeof(inner_array_fd),
+				   BPF_ANY);
+	if (!ASSERT_OK(err, "update elem"))
+		goto out_unmap;
+	usleep(1);
+
+	/* outer map key is set, outer_map_match == true */
+	ASSERT_TRUE(skel->bss->pid_match, "pid match 2");
+	ASSERT_TRUE(skel->bss->outer_map_match, "outer map match 2");
+	ASSERT_TRUE(skel->bss->done, "done 2");
+	ASSERT_EQ(*val, skel->data->match_value, "value match 2");
+
+out_unmap:
+	munmap(tmp, page_size);
+out:
+	mmap_inner_array__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/mmap_inner_array.c b/tools/testing/selftests/bpf/progs/mmap_inner_array.c
new file mode 100644
index 000000000000..db8ca2aa4347
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mmap_inner_array.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct inner_array_type {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__type(key, __u32);
+	__type(value, __u64);
+	__uint(max_entries, 1);
+} inner_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(key_size, 4);
+	__uint(value_size, 4);
+	__uint(max_entries, 1);
+	__array(values, struct inner_array_type);
+} outer_map SEC(".maps");
+
+int pid = 0;
+__u64 match_value = 0x13572468;
+bool done = false;
+bool pid_match = false;
+bool outer_map_match = false;
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int add_to_list_in_inner_array(void *ctx)
+{
+	__u32 curr_pid, zero = 0;
+	struct bpf_map *map;
+	__u64 *value;
+
+	curr_pid = (u32)bpf_get_current_pid_tgid();
+	if (done || curr_pid != pid)
+		return 0;
+
+	pid_match = true;
+	map = bpf_map_lookup_elem(&outer_map, &curr_pid);
+	if (!map)
+		return 0;
+
+	outer_map_match = true;
+	value = bpf_map_lookup_elem(map, &zero);
+	if (!value)
+		return 0;
+
+	*value = match_value;
+	done = true;
+	return 0;
+}
-- 
2.43.0


