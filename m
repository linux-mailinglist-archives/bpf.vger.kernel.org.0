Return-Path: <bpf+bounces-43607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704D29B6FD9
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934F11C20E23
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B55E21745A;
	Wed, 30 Oct 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcl9FquJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620E2144D3;
	Wed, 30 Oct 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730327303; cv=none; b=oMiYZl06GiOJgoZd5T+wW23axAYDWGMuttbeuNBpZEoanrnOGXCgNHKhrlpuZDNgK//4TwBBC/tFZf4o7XRLS1+Xq6GI3COv4vina3hyb/hq0Pn4sVkbYavntvBmNcXb8/7fZAd4wBCVq2/0/83Pg81OV8VDSKafp9Uz97RWcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730327303; c=relaxed/simple;
	bh=A/2av0Pr/WuyCSRAw3QjLR+gEsZ3d3mzZRpBnlCCgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfEcf6ReXfifv095X2dwPZHaqEEoAlpJYCi1oVaxPEvTfRD2yiZafv+j9R/DCZuQAUEdJ4v5I2HLGh4cKrbXAezkHMYBsx8ujDWgtfaqPP1lYdteCwza41r96iRoYcfu8nYcCiCsm6/gvrKwVPWxgbBnhkQmqTDBxIdgVDB/9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcl9FquJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC595C4CED3;
	Wed, 30 Oct 2024 22:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730327302;
	bh=A/2av0Pr/WuyCSRAw3QjLR+gEsZ3d3mzZRpBnlCCgnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcl9FquJW+B+A0O6lhbUfkrFUnBcfaGcZsOa+a3qThQP6avACEPtVFwAKyuoEX2lL
	 fgRzX9u8TK8WufNXi2dIHksZS+vRKEqsH0YV21T+MKqCU9eFtAqWg1o/qCGkJspBzP
	 8MGl0UMdvAHjtbiKUPH7Amm9QGHWJ30bcYyROBiI218afaJyT/FmTkF7rbjUrNqTeZ
	 tjnxK9qa/Q4/JKihMiB+kSAZLHCbRA99Xw5ZJOQ7FWttFquXkuvojcf9RBxCYLf6E0
	 Epy+H3Vvhri6PdstdTSIMkkVqPTnI4gcasjzDmTwflammKEu3ApQBZO3KU3yYNC1qj
	 kgKG6kf4H58yA==
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
	Kees Cook <kees@kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add a test for open coded kmem_cache iter
Date: Wed, 30 Oct 2024 15:28:19 -0700
Message-ID: <20241030222819.1800667-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030222819.1800667-1-namhyung@kernel.org>
References: <20241030222819.1800667-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new subtest runs with bpf_prog_test_run_opts() as a syscall prog.
It iterates the kmem_cache using bpf_for_each loop and count the number
of entries.  Finally it checks it with the number of entries from the
regular iterator.

  $ ./vmtest.sh -- ./test_progs -t kmem_cache_iter
  ...
  #130/1   kmem_cache_iter/check_task_struct:OK
  #130/2   kmem_cache_iter/check_slabinfo:OK
  #130/3   kmem_cache_iter/open_coded_iter:OK
  #130     kmem_cache_iter:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Also simplify the code by using attach routine of the skeleton.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v3)
 * use syscall prog type and bpf_prog_test_run_opts()  (Alexei)
 * increase open_coded_seen count after checking size  (Alexei)

v2)
 * remove unnecessary detach  (Martin)
 * check pid in syncfs to prevent surprise  (Martin)
 * remove unnecessary local variable  (Andrii)

 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++
 .../bpf/prog_tests/kmem_cache_iter.c          | 35 ++++++++++++-------
 .../selftests/bpf/progs/kmem_cache_iter.c     | 22 ++++++++++++
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index b0668f29f7b394eb..cd8ecd39c3f3c68d 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -582,4 +582,10 @@ extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 		unsigned int flags__k, void *aux__ign) __ksym;
 #define bpf_wq_set_callback(timer, cb, flags) \
 	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
+
+struct bpf_iter_kmem_cache;
+extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym;
+extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_cache *it) __weak __ksym;
+extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __weak __ksym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
index 848d8fc9171fae45..8e13a3416a21d2e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -68,12 +68,27 @@ static void subtest_kmem_cache_iter_check_slabinfo(struct kmem_cache_iter *skel)
 	fclose(fp);
 }
 
+static void subtest_kmem_cache_iter_open_coded(struct kmem_cache_iter *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, fd;
+
+	/* No need to attach it, just run it directly */
+	fd = bpf_program__fd(skel->progs.open_coded_iter);
+
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	/* It should be same as we've seen from the explicit iterator */
+	ASSERT_EQ(skel->bss->open_coded_seen, skel->bss->kmem_cache_seen, "open_code_seen_eq");
+}
+
 void test_kmem_cache_iter(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	struct kmem_cache_iter *skel = NULL;
-	union bpf_iter_link_info linfo = {};
-	struct bpf_link *link;
 	char buf[256];
 	int iter_fd;
 
@@ -81,16 +96,12 @@ void test_kmem_cache_iter(void)
 	if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
 		return;
 
-	opts.link_info = &linfo;
-	opts.link_info_len = sizeof(linfo);
-
-	link = bpf_program__attach_iter(skel->progs.slab_info_collector, &opts);
-	if (!ASSERT_OK_PTR(link, "attach_iter"))
+	if (!ASSERT_OK(kmem_cache_iter__attach(skel), "skel_attach"))
 		goto destroy;
 
-	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.slab_info_collector));
 	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
-		goto free_link;
+		goto destroy;
 
 	memset(buf, 0, sizeof(buf));
 	while (read(iter_fd, buf, sizeof(buf) > 0)) {
@@ -105,11 +116,11 @@ void test_kmem_cache_iter(void)
 		subtest_kmem_cache_iter_check_task_struct(skel);
 	if (test__start_subtest("check_slabinfo"))
 		subtest_kmem_cache_iter_check_slabinfo(skel);
+	if (test__start_subtest("open_coded_iter"))
+		subtest_kmem_cache_iter_open_coded(skel);
 
 	close(iter_fd);
 
-free_link:
-	bpf_link__destroy(link);
 destroy:
 	kmem_cache_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
index e775d5cd99fca579..b9c8f94574922099 100644
--- a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -32,6 +33,7 @@ extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
 /* Result, will be checked by userspace */
 int task_struct_found;
 int kmem_cache_seen;
+int open_coded_seen;
 
 SEC("iter/kmem_cache")
 int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
@@ -84,3 +86,23 @@ int BPF_PROG(check_task_struct)
 		task_struct_found = -2;
 	return 0;
 }
+
+SEC("syscall")
+int open_coded_iter(const void *ctx)
+{
+	struct kmem_cache *s;
+
+	bpf_for_each(kmem_cache, s) {
+		struct kmem_cache_result *r;
+
+		r = bpf_map_lookup_elem(&slab_result, &open_coded_seen);
+		if (!r)
+			break;
+
+		if (r->obj_size != s->size)
+			break;
+
+		open_coded_seen++;
+	}
+	return 0;
+}
-- 
2.47.0.163.g1226f6d8fa-goog


