Return-Path: <bpf+bounces-1858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463A27230A8
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A93281302
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B7261C2;
	Mon,  5 Jun 2023 20:05:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A67DDC0
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:05:24 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6798;
	Mon,  5 Jun 2023 13:05:23 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-3f9aeba6cc4so1358231cf.2;
        Mon, 05 Jun 2023 13:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685995522; x=1688587522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D72YnjZDedFXVKdKEyBmiBE+/IO/0eCEyvcyGBPY8yw=;
        b=SGHzllnPbQUz+D7zY4y9y5iI5Gyukx9kyU6nCbsmCoE2WBM0y/iTVvfKxStKm3U++A
         bII1BbhEhmseOC8NMeZZN69A3GHnYtRXBbExJ8X7LmMLHfUj15PVf/2sEk/lLEvDZe25
         Mdqihg5aG6/3KahX58Ud4tiYHAvduIJgw3/YJBEjP9Zi4LaPVDEpY6GAa2SSFTGoLFYR
         ik5hdT3gBPxHFxFS7LVlQ/jrOXayc8XqiPE7Dh+MWciv8APxforlbVf7cITc7MUxWYFh
         BOIytil+vQ0ZBkTGq+ly8AWXOj9aJCJE3KfRG4YxPffiaAjjRh1aSmUiWW1FEmjEhj99
         wn4w==
X-Gm-Message-State: AC+VfDwO3vyM0SF+WdDr4rNR0hI8kxK6YXc4Dc+ciw2OdEy4J49+jfBe
	KHG89CJ1drSZK6ZSYhaJsCAM931kk08ta39C
X-Google-Smtp-Source: ACHHUZ5n0B1IIit5i6w1TW6+SI+9GnMGc+66wIeoETAfNHfyx6J+1YI/8aEDFoz1iKDMJbAmctXG6g==
X-Received: by 2002:a05:622a:282:b0:3f3:8b8a:75a6 with SMTP id z2-20020a05622a028200b003f38b8a75a6mr9184668qtw.23.1685995521777;
        Mon, 05 Jun 2023 13:05:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:7447])
        by smtp.gmail.com with ESMTPSA id i6-20020ac87646000000b003f6b0562ad7sm5000210qtr.16.2023.06.05.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 13:05:21 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	davemarchevsky@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_for_each_map_elem on BPF_MAP_TYPE_HASH_OF_MAPS
Date: Mon,  5 Jun 2023 15:05:08 -0500
Message-Id: <20230605200508.1888874-2-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605200508.1888874-1-void@manifault.com>
References: <20230605200508.1888874-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that we support using the bpf_for_each_map_elem() on the
BPF_MAP_TYPE_HASH_OF_MAPS map type, we should add selftests that
verify expected behavior.

This patch addds those selftests. Included in this is a new
test_btf_map_in_map_failure.c BPF prog that can be used to verify
expected map-in-map failures in the verifier.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/btf_map_in_map.c | 44 +++++++++++
 .../selftests/bpf/progs/test_btf_map_in_map.c | 73 ++++++++++++++++++-
 .../bpf/progs/test_btf_map_in_map_failure.c   | 39 ++++++++++
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_map_in_map_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
index a8b53b8736f0..257b5b5a08ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_in_map.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 
 #include "test_btf_map_in_map.skel.h"
+#include "test_btf_map_in_map_failure.skel.h"
 
 static int duration;
 
@@ -154,6 +155,43 @@ static void test_diff_size(void)
 	test_btf_map_in_map__destroy(skel);
 }
 
+static void test_hash_iter(const char *prog_name)
+{
+	struct test_btf_map_in_map *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link = NULL;
+	int err, child_pid, status;
+
+	skel = test_btf_map_in_map__open();
+	if (!ASSERT_OK_PTR(skel, "test_btf_map_in_map__open\n"))
+		return;
+
+	skel->bss->pid = getpid();
+	err = test_btf_map_in_map__load(skel);
+	if (!ASSERT_OK(err, "test_btf_map_in_map__load"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	child_pid = fork();
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup;
+	if (child_pid == 0)
+		_exit(0);
+	waitpid(child_pid, &status, 0);
+	ASSERT_OK(skel->bss->err, "post_wait_err");
+
+cleanup:
+	bpf_link__destroy(link);
+	test_btf_map_in_map__destroy(skel);
+}
+
 void test_btf_map_in_map(void)
 {
 	if (test__start_subtest("lookup_update"))
@@ -161,4 +199,10 @@ void test_btf_map_in_map(void)
 
 	if (test__start_subtest("diff_size"))
 		test_diff_size();
+
+	if (test__start_subtest("hash_iter"))
+		test_hash_iter("test_iter_hash_of_maps");
+
+	RUN_TESTS(test_btf_map_in_map);
+	RUN_TESTS(test_btf_map_in_map_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c b/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
index c218cf8989a9..905392de6a3b 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_map_in_map.c
@@ -1,7 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2020 Facebook */
-#include <linux/bpf.h>
+#include <linux/types.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <vmlinux.h>
+
+#include "bpf_misc.h"
+
+int err, pid;
 
 struct inner_map {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -120,6 +126,13 @@ struct outer_sockarr_sz1 {
 
 int input = 0;
 
+static bool is_test_task(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return pid == cur_pid;
+}
+
 SEC("raw_tp/sys_enter")
 int handle__sys_enter(void *ctx)
 {
@@ -147,4 +160,62 @@ int handle__sys_enter(void *ctx)
 	return 0;
 }
 
+struct callback_ctx {
+	bool invoked;
+	bool failed;
+};
+
+static __u64 set_invoked(struct bpf_map *map, __u64 *key, __u64 *val, struct callback_ctx *ctx)
+{
+	struct bpf_map *inner_map;
+
+	ctx->invoked = true;
+	inner_map = bpf_map_lookup_elem(map, key);
+	if (!inner_map) {
+		ctx->failed = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_iter_hash_of_maps, struct task_struct *task, u64 clone_flags)
+{
+	long ret;
+	struct callback_ctx callback_ctx = {
+		.invoked = false,
+		.failed = false,
+	};
+
+	if (!is_test_task())
+		return 0;
+
+	ret = bpf_for_each_map_elem(&outer_hash, set_invoked, &callback_ctx, 0);
+	if (ret < 1)
+		err = 1;
+
+	if (!callback_ctx.invoked)
+		err = 2;
+
+	if (callback_ctx.failed)
+		err = 3;
+
+	return 0;
+}
+
+static __u64 empty_cb(struct bpf_map *map, __u64 *key, __u64 *val, void *ctx)
+{
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_iter_hash_of_maps_no_ctx, struct task_struct *task, u64 clone_flags)
+{
+	/* Should be able to iterate with no context as well. */
+	bpf_for_each_map_elem(&outer_hash, empty_cb, NULL, 0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_btf_map_in_map_failure.c b/tools/testing/selftests/bpf/progs/test_btf_map_in_map_failure.c
new file mode 100644
index 000000000000..6b7a94fe15c7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_btf_map_in_map_failure.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <vmlinux.h>
+
+#include "bpf_misc.h"
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} inner_map1 SEC(".maps"),
+  inner_map2 SEC(".maps");
+
+struct outer_hash {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__array(values, struct inner_map);
+} outer_hash SEC(".maps") = {
+	.values = {
+		[0] = &inner_map2,
+		[1] = &inner_map1,
+	},
+};
+
+SEC("tp_btf/task_newtask")
+__failure
+__msg("R2 type=scalar expected=func")
+int BPF_PROG(test_iter_hash_of_maps_null_cb, struct task_struct *task, u64 clone_flags)
+{
+	/* Can't iterate over a NULL callback. */
+	bpf_for_each_map_elem(&outer_hash, NULL, NULL, 0);
+	return 0;
+}
-- 
2.40.1


