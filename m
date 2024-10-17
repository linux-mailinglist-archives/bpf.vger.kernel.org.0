Return-Path: <bpf+bounces-42278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4959A1C99
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 10:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECE8B2491B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E421D7984;
	Thu, 17 Oct 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7b8fumq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04D1D6DBE;
	Thu, 17 Oct 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152367; cv=none; b=MfBrSqz7ORhlmXs4Hu0tOAfQ2Rc3LcWIcDhBe/RgR3ol3DSuYVq1pOs600ntvvorSKmK94BZm6jRatLoTNpmmimAP4YbLyRcJuRH7OaMFNIn84e2jMtCQmU7RodxnyepNik6HE+CMUNPpLBODU3YszNFfAxtQEjJ0bPWAGR8GX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152367; c=relaxed/simple;
	bh=yT8+3HibLytUwdjsKhrLp1hPXDVTvisDL7LIxziLei0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHD0xTk/ChBeHtXjKadZhiN+kccQ9HX9QSsJyNLQJt7sVPeMRMnlYPXmHZrtefYtvOaPtwE4r8uVEjTJxsgTwIp1avWC1Ky8z0cKWioUwpB5VG+9FEQbyEEsO0S4ninp9CigpwzkdTnqyMbB3Q8+jErkepF1uGYWmWYZFyIFLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7b8fumq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B419DC4CECD;
	Thu, 17 Oct 2024 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729152366;
	bh=yT8+3HibLytUwdjsKhrLp1hPXDVTvisDL7LIxziLei0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7b8fumqVoqSkV7fsBqyP+/nbc0CsubJ4ryJu0S1h6SxTMOTt6thxyqZJnMt1bPCl
	 +BGpQsGcCHm5sajQSMrVzZ/UFM/K+IDRS6QMBh4mlB9uIhVSkEFgDxdUtDwRrejHgB
	 ZOpwBdP8TaR7z3tJ9fLZtn+rXMVolW/aSmyQmf2k7O36peSRsB7zBQdXYHx84g5ENh
	 EOWx+hmxShGFDwm6Ougmx8zwVGqXca1yjW4feQC1i+jLmgALSmeA92gXEUKSor8rjH
	 bS+JeVGYvPFMWXWSqPEUaOOqvzo5/SveIa9K8QCEEwS3iPYl1ImIHKlvNIDcR4zdaG
	 hqxIczeyKBw0Q==
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add a test for open coded kmem_cache iter
Date: Thu, 17 Oct 2024 01:06:04 -0700
Message-ID: <20241017080604.541872-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241017080604.541872-1-namhyung@kernel.org>
References: <20241017080604.541872-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new subtest is attached to sleepable fentry of syncfs() syscall.
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
 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++
 .../bpf/prog_tests/kmem_cache_iter.c          | 28 +++++++++++--------
 .../selftests/bpf/progs/kmem_cache_iter.c     | 24 ++++++++++++++++
 3 files changed, 46 insertions(+), 12 deletions(-)

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
index 848d8fc9171fae45..a1fd3bc57c0b21bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -68,12 +68,18 @@ static void subtest_kmem_cache_iter_check_slabinfo(struct kmem_cache_iter *skel)
 	fclose(fp);
 }
 
+static void subtest_kmem_cache_iter_open_coded(struct kmem_cache_iter *skel)
+{
+	/* To trigger the open coded iterator attached to the syscall */
+	syncfs(0);
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
 
@@ -81,16 +87,12 @@ void test_kmem_cache_iter(void)
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
+		goto detach;
 
 	memset(buf, 0, sizeof(buf));
 	while (read(iter_fd, buf, sizeof(buf) > 0)) {
@@ -105,11 +107,13 @@ void test_kmem_cache_iter(void)
 		subtest_kmem_cache_iter_check_task_struct(skel);
 	if (test__start_subtest("check_slabinfo"))
 		subtest_kmem_cache_iter_check_slabinfo(skel);
+	if (test__start_subtest("open_coded_iter"))
+		subtest_kmem_cache_iter_open_coded(skel);
 
 	close(iter_fd);
 
-free_link:
-	bpf_link__destroy(link);
+detach:
+	kmem_cache_iter__detach(skel);
 destroy:
 	kmem_cache_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
index 72c9dafecd98406b..4c44aa279a5328fe 100644
--- a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2024 Google */
 
 #include "bpf_iter.h"
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -33,6 +35,7 @@ extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
 /* Result, will be checked by userspace */
 int task_struct_found;
 int kmem_cache_seen;
+int open_coded_seen;
 
 SEC("iter/kmem_cache")
 int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
@@ -85,3 +88,24 @@ int BPF_PROG(check_task_struct)
 		task_struct_found = -2;
 	return 0;
 }
+
+SEC("fentry.s/" SYS_PREFIX "sys_syncfs")
+int open_coded_iter(const void *ctx)
+{
+	struct kmem_cache *s;
+
+	bpf_for_each(kmem_cache, s) {
+		struct kmem_cache_result *r;
+		int idx = open_coded_seen;
+
+		r = bpf_map_lookup_elem(&slab_result, &idx);
+		if (r == NULL)
+			break;
+
+		open_coded_seen++;
+
+		if (r->obj_size != s->size)
+			break;
+	}
+	return 0;
+}
-- 
2.47.0.rc1.288.g06298d1525-goog


