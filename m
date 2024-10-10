Return-Path: <bpf+bounces-41667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757D69995BD
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 01:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1311F2458F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B91E9091;
	Thu, 10 Oct 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHpcbVx7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF11E9069;
	Thu, 10 Oct 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728602710; cv=none; b=f2bSkRayiZzz2md4yOhiPEwqAYRTICJME/GQjUg0RjvH1lTlkQRexpNJwEgC97SauPw4ywnIK0rUzTe0WeyYGf1LmBUdkXAefbwCULhEjuz8lpllutmVjsMtpItSzNnFnN/wzJOkRf1UmfQiU8Khuh7koxX6ZskiJRziyL/E3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728602710; c=relaxed/simple;
	bh=7yJR3lSy+PJG3f5Th9Zl71ZDLgIU1wQOEfOZlZTpl6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otFP7U+UVmHYPbNBsCxndbGz43UFj/bEh9Go+8vX0P523+lHLG05+srt1icydITTUEA61UuiPB9oIPRZhFZIICHpdvb8tJX2LVJjZrE5W0mogWAf5lEimnX90bPme5bCYNZz+wO4DN0fKzWo3gP1W5qOcR++MPt+zT1d5Fl7qSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHpcbVx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FDEC4CECD;
	Thu, 10 Oct 2024 23:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728602710;
	bh=7yJR3lSy+PJG3f5Th9Zl71ZDLgIU1wQOEfOZlZTpl6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHpcbVx7KlyHyNWV8tvabSN0gHqEVUyi1DUCy8I3uD0ebc++xqJTwF2xkjqB9RKeR
	 bC2Gnrp/Wk4moBDDnqhiWejPrMC9uspwRv/0qVXbX/j7KJP7b5Z6IFWlRD49quVJV4
	 TiAFnjE/6U3aEOmpjUUPf0Ksy54llXg0N/So/YsDcRFh9MlMVaGx+XE08ynsMihBvg
	 h3TToYrEr757LszZ/2Zg2KOehFRRJaLJ9AxSCg+cPJqUWy3Sied2tka2i0QAWSB2ql
	 zNQNa5ncObsz5PPvtWF9Pgwx/ANuamQZB4ZW+GLnCHROCY/LlvLEIodS5SNwNl4N0u
	 xVRdxRzRlpdqw==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v5 bpf-next 3/3] selftests/bpf: Add a test for kmem_cache_iter
Date: Thu, 10 Oct 2024 16:25:05 -0700
Message-ID: <20241010232505.1339892-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241010232505.1339892-1-namhyung@kernel.org>
References: <20241010232505.1339892-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test traverses all slab caches using the kmem_cache_iter and save
the data into slab_result array map.  And check if current task's
pointer is from "task_struct" slab cache using bpf_get_kmem_cache().

Also compare the result array with /proc/slabinfo if available (when
CONFIG_SLUB_DEBUG is on).  Note that many of the fields in the slabinfo
are transient, so it only compares the name and objsize fields.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../bpf/prog_tests/kmem_cache_iter.c          | 115 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 ++
 .../selftests/bpf/progs/kmem_cache_iter.c     |  95 +++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
new file mode 100644
index 0000000000000000..848d8fc9171fae45
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "kmem_cache_iter.skel.h"
+
+#define SLAB_NAME_MAX  32
+
+struct kmem_cache_result {
+	char name[SLAB_NAME_MAX];
+	long obj_size;
+};
+
+static void subtest_kmem_cache_iter_check_task_struct(struct kmem_cache_iter *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.flags = 0,  /* Run it with the current task */
+	);
+	int prog_fd = bpf_program__fd(skel->progs.check_task_struct);
+
+	/* Get task_struct and check it if's from a slab cache */
+	ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts), "prog_test_run");
+
+	/* The BPF program should set 'found' variable */
+	ASSERT_EQ(skel->bss->task_struct_found, 1, "task_struct_found");
+}
+
+static void subtest_kmem_cache_iter_check_slabinfo(struct kmem_cache_iter *skel)
+{
+	FILE *fp;
+	int map_fd;
+	char name[SLAB_NAME_MAX];
+	unsigned long objsize;
+	char rest_of_line[1000];
+	struct kmem_cache_result r;
+	int seen = 0;
+
+	fp = fopen("/proc/slabinfo", "r");
+	if (fp == NULL) {
+		/* CONFIG_SLUB_DEBUG is not enabled */
+		return;
+	}
+
+	map_fd = bpf_map__fd(skel->maps.slab_result);
+
+	/* Ignore first two lines for header */
+	fscanf(fp, "slabinfo - version: %*d.%*d\n");
+	fscanf(fp, "# %*s %*s %*s %*s %*s %*s : %[^\n]\n", rest_of_line);
+
+	/* Compare name and objsize only - others can be changes frequently */
+	while (fscanf(fp, "%s %*u %*u %lu %*u %*u : %[^\n]\n",
+		      name, &objsize, rest_of_line) == 3) {
+		int ret = bpf_map_lookup_elem(map_fd, &seen, &r);
+
+		if (!ASSERT_OK(ret, "kmem_cache_lookup"))
+			break;
+
+		ASSERT_STREQ(r.name, name, "kmem_cache_name");
+		ASSERT_EQ(r.obj_size, objsize, "kmem_cache_objsize");
+
+		seen++;
+	}
+
+	ASSERT_EQ(skel->bss->kmem_cache_seen, seen, "kmem_cache_seen_eq");
+
+	fclose(fp);
+}
+
+void test_kmem_cache_iter(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct kmem_cache_iter *skel = NULL;
+	union bpf_iter_link_info linfo = {};
+	struct bpf_link *link;
+	char buf[256];
+	int iter_fd;
+
+	skel = kmem_cache_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
+		return;
+
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.slab_info_collector, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		goto destroy;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
+		goto free_link;
+
+	memset(buf, 0, sizeof(buf));
+	while (read(iter_fd, buf, sizeof(buf) > 0)) {
+		/* Read out all contents */
+		printf("%s", buf);
+	}
+
+	/* Next reads should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	if (test__start_subtest("check_task_struct"))
+		subtest_kmem_cache_iter_check_task_struct(skel);
+	if (test__start_subtest("check_slabinfo"))
+		subtest_kmem_cache_iter_check_slabinfo(skel);
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+destroy:
+	kmem_cache_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index c41ee80533ca219a..3305dc3a74b32481 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -24,6 +24,7 @@
 #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
 #define BTF_F_ZERO BTF_F_ZERO___not_used
 #define bpf_iter__ksym bpf_iter__ksym___not_used
+#define bpf_iter__kmem_cache bpf_iter__kmem_cache___not_used
 #include "vmlinux.h"
 #undef bpf_iter_meta
 #undef bpf_iter__bpf_map
@@ -48,6 +49,7 @@
 #undef BTF_F_PTR_RAW
 #undef BTF_F_ZERO
 #undef bpf_iter__ksym
+#undef bpf_iter__kmem_cache
 
 struct bpf_iter_meta {
 	struct seq_file *seq;
@@ -165,3 +167,8 @@ struct bpf_iter__ksym {
 	struct bpf_iter_meta *meta;
 	struct kallsym_iter *ksym;
 };
+
+struct bpf_iter__kmem_cache {
+	struct bpf_iter_meta *meta;
+	struct kmem_cache *s;
+} __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
new file mode 100644
index 0000000000000000..1cff8c7772683caf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google */
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define SLAB_NAME_MAX  32
+
+struct kmem_cache_result {
+	char name[SLAB_NAME_MAX];
+	long obj_size;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(void *));
+	__uint(value_size, SLAB_NAME_MAX);
+	__uint(max_entries, 1);
+} slab_hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(struct kmem_cache_result));
+	__uint(max_entries, 1024);
+} slab_result SEC(".maps");
+
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
+
+/* Result, will be checked by userspace */
+int task_struct_found;
+int kmem_cache_seen;
+
+SEC("iter/kmem_cache")
+int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct kmem_cache *s = ctx->s;
+	struct kmem_cache_result *r;
+	int idx;
+
+	if (s) {
+		/* To make sure if the slab_iter implements the seq interface
+		 * properly and it's also useful for debugging.
+		 */
+		BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->size);
+
+		idx = kmem_cache_seen;
+		r = bpf_map_lookup_elem(&slab_result, &idx);
+		if (r == NULL)
+			return 0;
+
+		kmem_cache_seen++;
+
+		/* Save name and size to match /proc/slabinfo */
+		bpf_probe_read_kernel_str(r->name, sizeof(r->name), s->name);
+		r->obj_size = s->size;
+
+		if (!bpf_strncmp(r->name, 11, "task_struct"))
+			bpf_map_update_elem(&slab_hash, &s, r->name, BPF_NOEXIST);
+	}
+
+	return 0;
+}
+
+SEC("raw_tp/bpf_test_finish")
+int BPF_PROG(check_task_struct)
+{
+	u64 curr = bpf_get_current_task();
+	struct kmem_cache *s;
+	char *name;
+
+	bpf_rcu_read_lock();
+
+	s = bpf_get_kmem_cache(curr);
+	if (s == NULL) {
+		task_struct_found = -1;
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+
+	name = bpf_map_lookup_elem(&slab_hash, &s);
+	if (name && !bpf_strncmp(name, 11, "task_struct"))
+		task_struct_found = 1;
+	else
+		task_struct_found = -2;
+
+	bpf_rcu_read_unlock();
+	return 0;
+}
-- 
2.47.0.rc1.288.g06298d1525-goog


