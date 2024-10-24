Return-Path: <bpf+bounces-43024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6F9ADE25
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EB6B203CA
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7A1ABECD;
	Thu, 24 Oct 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA6rk5G3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C31ADFE3;
	Thu, 24 Oct 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756098; cv=none; b=AIHOsHock13f729EjkPWBCWQmuRDMbSQJ4ybHeh9Cf/7T01pFidtkR040/4Zwhw1ECszm9Ah+NYWABZoVvhZ3i2d7eboRSq3gXGlX/omEDtRtcK+of4sfW3F848DzD0EUI+hFAEF/j7AMLiGyuSCrRXHnlgLd7MwqFOTAZRLuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756098; c=relaxed/simple;
	bh=KdTfSCDjkkqD9bhaV9lSbcv8lSsiidIcVwYLU1/0JAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gba65mVjCbe+b45iGWcmJ69wqeprVv0q6MqIfHpg65aFvRoti20fvykwwlViPaladp+21KWtYW24DQA+cVA4+geIXxH+jCbZpsKdYEFkIdY7fwrwjAt1FQ973wGxhXBVdOwt+37VHp2vlAfzE/mgSplB5gW4QKmbTk3nyXxqibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA6rk5G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0E6C4AF11;
	Thu, 24 Oct 2024 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729756098;
	bh=KdTfSCDjkkqD9bhaV9lSbcv8lSsiidIcVwYLU1/0JAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mA6rk5G3BGxp468AygJtj6VOjozKki9/lKuCqmUT91hD8jmQD8QvPqfluHvvGz4dV
	 zLCIMhwYXsTgxeWQeb4bKbxOOn2DFu2BcEMkg3T4VDDPup3/UapJeX8li+Kd0Ac3kl
	 EnCYJ2XNHaYUBwQ8FAf5HthmVf59uCYX/qelabnWho6I+6qroQjPsSgJwDz/p0tMZ+
	 sUJ7SuBGuoUSZXwIPXBn7Rx5FAFoLCXiLC57Md2STUL0ZCyL6Rh/63iICV3Y7/Utuv
	 9o4uMc1+xbCsaML7WJi0srwZXiLhfloZqnX8YByDhKOBeab1IoYlEucCeew/Y41bUo
	 3I3lNoFUrnC6Q==
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
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add a test for open coded kmem_cache iter
Date: Thu, 24 Oct 2024 00:48:15 -0700
Message-ID: <20241024074815.1255066-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241024074815.1255066-1-namhyung@kernel.org>
References: <20241024074815.1255066-1-namhyung@kernel.org>
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
v2)
 * remove unnecessary detach  (Martin)
 * check pid in syncfs to prevent surprise  (Martin)
 * remove unnecessary local variable  (Andrii)

 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++
 .../bpf/prog_tests/kmem_cache_iter.c          | 28 +++++++++++--------
 .../selftests/bpf/progs/kmem_cache_iter.c     | 28 +++++++++++++++++++
 3 files changed, 50 insertions(+), 12 deletions(-)

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
index 848d8fc9171fae45..778b55bc1f912b98 100644
--- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
@@ -68,12 +68,20 @@ static void subtest_kmem_cache_iter_check_slabinfo(struct kmem_cache_iter *skel)
 	fclose(fp);
 }
 
+static void subtest_kmem_cache_iter_open_coded(struct kmem_cache_iter *skel)
+{
+	skel->bss->tgid = getpid();
+
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
 
@@ -81,16 +89,12 @@ void test_kmem_cache_iter(void)
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
@@ -105,11 +109,11 @@ void test_kmem_cache_iter(void)
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
index 72c9dafecd98406b..e62807caa7593604 100644
--- a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
+++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2024 Google */
 
 #include "bpf_iter.h"
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -30,9 +32,12 @@ struct {
 
 extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
 
+unsigned int tgid;
+
 /* Result, will be checked by userspace */
 int task_struct_found;
 int kmem_cache_seen;
+int open_coded_seen;
 
 SEC("iter/kmem_cache")
 int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
@@ -85,3 +90,26 @@ int BPF_PROG(check_task_struct)
 		task_struct_found = -2;
 	return 0;
 }
+
+SEC("fentry.s/" SYS_PREFIX "sys_syncfs")
+int open_coded_iter(const void *ctx)
+{
+	struct kmem_cache *s;
+
+	if (tgid != bpf_get_current_pid_tgid() >> 32)
+		return 0;
+
+	bpf_for_each(kmem_cache, s) {
+		struct kmem_cache_result *r;
+
+		r = bpf_map_lookup_elem(&slab_result, &open_coded_seen);
+		if (!r)
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
2.47.0.105.g07ac214952-goog


