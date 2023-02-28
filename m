Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1806A55E5
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 10:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjB1JeE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 04:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjB1Jd4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 04:33:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8867EFA;
        Tue, 28 Feb 2023 01:33:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D51461027;
        Tue, 28 Feb 2023 09:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F41C433EF;
        Tue, 28 Feb 2023 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576823;
        bh=PZiYSLYNU3C00rnNdy4zAar6CH7S8yCd0XJ4879uTP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efKNf3cQII98zFg4PhMr3l6nnP2Bi11i36Q8YZqlckFjvNF1u4nCZsZcwgao3hbXN
         7keyPZK//616wp/cQBf2S67TLQk0VpSmxcTpWJqeHyCrlmVdTHrrWZSLIDh8Q2rm/3
         Kw1FIcKTlTQ6yITPXO8YWISaeo3UK1z1axRxdcjyfgsbEGNlt9iLFMD71tjRTi8yCr
         2UpDjk4+IjvYaoxHiW6xiHarbvTqYOSG2Xx8uYymD6VYYd12YIJSRLk/PovVSxZgnC
         0+NwwZeaFF9Y8AVkN4d4ALReFAuvgzhYmEFgOVKW1Ob+W3uOyHKt4FOCyWmKyD2H4V
         wbq4k2glM0x+w==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 7/9] selftests/bpf: Replace extract_build_id with read_build_id
Date:   Tue, 28 Feb 2023 10:32:04 +0100
Message-Id: <20230228093206.821563-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replacing extract_build_id with read_build_id that parses out
build id directly from elf without using readelf tool.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/stacktrace_build_id.c      | 19 ++++++--------
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 17 +++++--------
 tools/testing/selftests/bpf/test_progs.c      | 25 -------------------
 tools/testing/selftests/bpf/test_progs.h      |  1 -
 4 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
index 9ad09a6c538a..9e4b76ee356f 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
@@ -7,13 +7,12 @@ void test_stacktrace_build_id(void)
 
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	struct test_stacktrace_build_id *skel;
-	int err, stack_trace_len;
+	int err, stack_trace_len, build_id_size;
 	__u32 key, prev_key, val, duration = 0;
-	char buf[256];
-	int i, j;
+	char buf[BPF_BUILD_ID_SIZE];
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
 	int build_id_matches = 0;
-	int retry = 1;
+	int i, retry = 1;
 
 retry:
 	skel = test_stacktrace_build_id__open_and_load();
@@ -52,9 +51,10 @@ void test_stacktrace_build_id(void)
 		  "err %d errno %d\n", err, errno))
 		goto cleanup;
 
-	err = extract_build_id(buf, 256);
+	build_id_size = read_build_id("./urandom_read", buf);
+	err = build_id_size < 0 ? build_id_size : 0;
 
-	if (CHECK(err, "get build_id with readelf",
+	if (CHECK(err, "read_build_id",
 		  "err %d errno %d\n", err, errno))
 		goto cleanup;
 
@@ -64,8 +64,6 @@ void test_stacktrace_build_id(void)
 		goto cleanup;
 
 	do {
-		char build_id[64];
-
 		err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
 		if (CHECK(err, "lookup_elem from stackmap",
 			  "err %d, errno %d\n", err, errno))
@@ -73,10 +71,7 @@ void test_stacktrace_build_id(void)
 		for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
 			if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
 			    id_offs[i].offset != 0) {
-				for (j = 0; j < 20; ++j)
-					sprintf(build_id + 2 * j, "%02x",
-						id_offs[i].build_id[j] & 0xff);
-				if (strstr(buf, build_id) != NULL)
+				if (memcmp(buf, id_offs[i].build_id, build_id_size) == 0)
 					build_id_matches = 1;
 			}
 		prev_key = key;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index f4ea1a215ce4..8d84149ebcc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -28,11 +28,10 @@ void test_stacktrace_build_id_nmi(void)
 		.config = PERF_COUNT_HW_CPU_CYCLES,
 	};
 	__u32 key, prev_key, val, duration = 0;
-	char buf[256];
-	int i, j;
+	char buf[BPF_BUILD_ID_SIZE];
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
-	int build_id_matches = 0;
-	int retry = 1;
+	int build_id_matches = 0, build_id_size;
+	int i, retry = 1;
 
 	attr.sample_freq = read_perf_max_sample_freq();
 
@@ -94,7 +93,8 @@ void test_stacktrace_build_id_nmi(void)
 		  "err %d errno %d\n", err, errno))
 		goto cleanup;
 
-	err = extract_build_id(buf, 256);
+	build_id_size = read_build_id("./urandom_read", buf);
+	err = build_id_size < 0 ? build_id_size : 0;
 
 	if (CHECK(err, "get build_id with readelf",
 		  "err %d errno %d\n", err, errno))
@@ -106,8 +106,6 @@ void test_stacktrace_build_id_nmi(void)
 		goto cleanup;
 
 	do {
-		char build_id[64];
-
 		err = bpf_map__lookup_elem(skel->maps.stackmap, &key, sizeof(key),
 					   id_offs, sizeof(id_offs), 0);
 		if (CHECK(err, "lookup_elem from stackmap",
@@ -116,10 +114,7 @@ void test_stacktrace_build_id_nmi(void)
 		for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
 			if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
 			    id_offs[i].offset != 0) {
-				for (j = 0; j < 20; ++j)
-					sprintf(build_id + 2 * j, "%02x",
-						id_offs[i].build_id[j] & 0xff);
-				if (strstr(buf, build_id) != NULL)
+				if (memcmp(buf, id_offs[i].build_id, build_id_size) == 0)
 					build_id_matches = 1;
 			}
 		prev_key = key;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6d5e3022c75f..9813d53c4878 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -591,31 +591,6 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 	return err;
 }
 
-int extract_build_id(char *build_id, size_t size)
-{
-	FILE *fp;
-	char *line = NULL;
-	size_t len = 0;
-
-	fp = popen("readelf -n ./urandom_read | grep 'Build ID'", "r");
-	if (fp == NULL)
-		return -1;
-
-	if (getline(&line, &len, fp) == -1)
-		goto err;
-	pclose(fp);
-
-	if (len > size)
-		len = size;
-	memcpy(build_id, line, len);
-	build_id[len] = '\0';
-	free(line);
-	return 0;
-err:
-	pclose(fp);
-	return -1;
-}
-
 static int finit_module(int fd, const char *param_values, int flags)
 {
 	return syscall(__NR_finit_module, fd, param_values, flags);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 9fbdc57c5b57..3825c2797a4b 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -404,7 +404,6 @@ static inline void *u64_to_ptr(__u64 ptr)
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
-int extract_build_id(char *build_id, size_t size);
 int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
-- 
2.39.2

