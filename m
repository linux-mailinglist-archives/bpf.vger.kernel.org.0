Return-Path: <bpf+bounces-40326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F29986933
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 00:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8831C23CA9
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B3175D50;
	Wed, 25 Sep 2024 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZsDwet5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1F1714B3;
	Wed, 25 Sep 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303427; cv=none; b=aIyKPrEYNVCEW4U0iSR8cnY0nvOE0LcMvKhAGRE95PhaJz0NHaiwsu7J+Y6W/UcS9uEE47wrMFqJoHW89bk6KgH5r7iDvIGCHjQ1W8MWYxY3nbRZOXHoplcsxJoB0O3FV7fT6/22oL4rIwdCiS9LX50rYw3Y6WwsBQleZHK1wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303427; c=relaxed/simple;
	bh=F0K+S6VZ06qBNMDXblIhDt1PDc7u3rtDzvje3N0WCyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYbKoc79Q9rmq5OqEGFpgLxKseTqraawGivIKvcfpbZoE658ANUFlYF63sheyV1NVa4N+ai/2kl+qOOXA/W6q95RxLsnPxpImDv7jdQDuvHwbvfccBDWqKoK1zBgu2I/4gB6gMB7ICsD8YfRILlNk1i0qzEw5+IMc5pDXEQ1ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZsDwet5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B17C4CECD;
	Wed, 25 Sep 2024 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727303427;
	bh=F0K+S6VZ06qBNMDXblIhDt1PDc7u3rtDzvje3N0WCyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZsDwet5lz1zxqaEpGuxsFM2AJIGYVu0wR8Fx4aoPVtBDiXpyXhUR9ER1ai+Q1eGs
	 5kmLrSdWia5+BA/FXlCLaefbVT0KDVM4BPenIWg8jIGrp1Vs0j3lVqq7iX51Dwp4Yp
	 Q+UBtdYTE7BOYfrB1xbAhHSuFnO8CTo9FPkJP+1ZjACDAHNr6VS6wcOlGN5vzibLWo
	 kq68VeU/qIDJWg3GeM+5xE9HlOK2yPd7QWWXkT31X2QG/WBzTLEEBuRa2YS+7N3Pk0
	 4nIxGd/JqIn0aypxOPksiiahT/XXzdveSurDU8E1egdGUN+lI8yzg0lbIq0J6qcHOE
	 1vr7YVNJkG2nw==
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
	linux-mm@kvack.org
Subject: [RFC/PATCH bpf-next 3/3] selftests/bpf: Add a test for slab_iter
Date: Wed, 25 Sep 2024 15:30:23 -0700
Message-ID: <20240925223023.735947-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925223023.735947-1-namhyung@kernel.org>
References: <20240925223023.735947-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test traverses all slab caches using the slab_iter and check if
current task's pointer is from "task_struct" slab cache.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../selftests/bpf/prog_tests/slab_iter.c      | 64 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |  7 ++
 tools/testing/selftests/bpf/progs/slab_iter.c | 62 ++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/slab_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/slab_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/slab_iter.c b/tools/testing/selftests/bpf/prog_tests/slab_iter.c
new file mode 100644
index 0000000000000000..e461f6e703d67dc8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/slab_iter.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "slab_iter.skel.h"
+
+static void test_slab_iter_check_task(struct slab_iter *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+	int prog_fd = bpf_program__fd(skel->progs.check_task_struct);
+
+	/* get task_struct and check it if's from a slab cache */
+	bpf_prog_test_run_opts(prog_fd, &opts);
+
+	/* the BPF program should set 'found' variable */
+	ASSERT_EQ(skel->bss->found, 1, "found task_struct");
+}
+
+void test_slab_iter(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	struct slab_iter *skel = NULL;
+	union bpf_iter_link_info linfo = {};
+	struct bpf_link *link;
+	char buf[1024];
+	int iter_fd;
+
+	skel = slab_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "slab_iter__open_and_load"))
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
+		/* read out all contents */
+		printf("%s", buf);
+	}
+
+	/* next reads should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	test_slab_iter_check_task(skel);
+
+	close(iter_fd);
+
+free_link:
+	bpf_link__destroy(link);
+destroy:
+	slab_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
index c41ee80533ca219a..33ea7181e1f03560 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter.h
+++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
@@ -24,6 +24,7 @@
 #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
 #define BTF_F_ZERO BTF_F_ZERO___not_used
 #define bpf_iter__ksym bpf_iter__ksym___not_used
+#define bpf_iter__slab bpf_iter__slab___not_used
 #include "vmlinux.h"
 #undef bpf_iter_meta
 #undef bpf_iter__bpf_map
@@ -48,6 +49,7 @@
 #undef BTF_F_PTR_RAW
 #undef BTF_F_ZERO
 #undef bpf_iter__ksym
+#undef bpf_iter__slab
 
 struct bpf_iter_meta {
 	struct seq_file *seq;
@@ -165,3 +167,8 @@ struct bpf_iter__ksym {
 	struct bpf_iter_meta *meta;
 	struct kallsym_iter *ksym;
 };
+
+struct bpf_iter__slab {
+	struct bpf_iter_meta *meta;
+	struct kmem_cache *s;
+} __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/slab_iter.c b/tools/testing/selftests/bpf/progs/slab_iter.c
new file mode 100644
index 0000000000000000..f806365506851774
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/slab_iter.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google */
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define SLAB_NAME_MAX  256
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(void *));
+	__uint(value_size, SLAB_NAME_MAX);
+	__uint(max_entries, 1024);
+} slab_hash SEC(".maps");
+
+extern struct kmem_cache *bpf_get_slab_cache(__u64 addr) __ksym;
+
+/* result, will be checked by userspace */
+int found;
+
+SEC("iter/slab")
+int slab_info_collector(struct bpf_iter__slab *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct kmem_cache *s = ctx->s;
+
+	if (s) {
+		char name[SLAB_NAME_MAX];
+
+		/*
+		 * To make sure if the slab_iter implements the seq interface
+		 * properly and it's also useful for debugging.
+		 */
+		BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->object_size);
+
+		bpf_probe_read_kernel_str(name, sizeof(name), s->name);
+		bpf_map_update_elem(&slab_hash, &s, name, BPF_NOEXIST);
+	}
+
+	return 0;
+}
+
+SEC("raw_tp/bpf_test_finish")
+int BPF_PROG(check_task_struct)
+{
+	__u64 curr = bpf_get_current_task();
+	struct kmem_cache *s;
+	char *name;
+
+	s = bpf_get_slab_cache(curr);
+	if (s == NULL)
+		return 0;
+
+	name = bpf_map_lookup_elem(&slab_hash, &s);
+	if (name && !bpf_strncmp(name, 11, "task_struct"))
+		found = 1;
+
+	return 0;
+}
-- 
2.46.0.792.g87dc391469-goog


