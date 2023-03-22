Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4536C552C
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 20:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCVTsc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVTsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 15:48:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42460BDFF
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:48:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso1980633pjf.0
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679514510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZIvAQvoR+RY6Ti1m9EXcC2+ThyK6MEhYspESh4v2vA=;
        b=JukbywFW0R4SWrlD6LSICnl/Td0hzKXbqOA0XHHusuEgaB0FgmEbpE3a3mPgogoePV
         JB0NadPD6y6P5wWEw/kQ+BV/3a1OtWkag0xanloSvTHxz6coOjFKDqbvg2hhmAgasvYr
         3sRM+iZMp5DPaAV+Wk/e1wf3DdyHFeW/3BSsdKN15tCjMkJG17Rp9bABfsXtS7t3Nkqr
         64jHW5qbbgdjjrdhP0E4FdokTvFoBn//CbC48pMpC41dfNV2edFkgzQug6OVYDmYwZOw
         VQ/x7ebeiehppUn1F5k5mKE6EAtVAziExXFW561KsqPZ6zZaXFNcBc+sz8NkvI9NrgNO
         3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZIvAQvoR+RY6Ti1m9EXcC2+ThyK6MEhYspESh4v2vA=;
        b=qs9HZjQsyo9KrFfgcUiizEAYFlDV8G4JLNFLFxjWOET/ZgLbY0scpZOTav8bUaDGbY
         A3bODfyNMQWphdY1rskn3ACtav2KcNPsQE6lkfOCP1Q0yn3IQ2jSNQI1tP5aFahI7kXY
         tZsODXZqYLA8HuFO6Mmue1fOEiRIdFvwU4cM6GUI3J0cY/HzIfJyMGLzBs2PRBiPKesB
         JnI57B8Wl7Dk3AVuqvifbVIlWIoEloyBWSAyXnBsTwXhJE6EOAoRufHPwFloQtJeVsA0
         SY87qOseq2tPnGgR6BkMSpEyoM49AGiRUtjqjTvdGVEhWyAEzS8M2WzJcsIoPyITGYoN
         7BVg==
X-Gm-Message-State: AO0yUKUkK9fnLGWNTPMtGxPuy4NMY0kjY4EeCDamzCbVxNAQVKIsL7c/
        9skz8vtbnztGSfXQ+AuPotko0eLDYMk=
X-Google-Smtp-Source: AK7set8FnlWMcSa/6Na56GktLrgN9IX1yUKflTv11cxIDd/x7MfPNv0ZVNG/jFM9kca90lgIxAukNA==
X-Received: by 2002:a17:902:fb47:b0:1a1:e112:4607 with SMTP id lf7-20020a170902fb4700b001a1e1124607mr3249629plb.50.1679514509719;
        Wed, 22 Mar 2023 12:48:29 -0700 (PDT)
Received: from localhost.localdomain ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b0019c93ee6902sm10939946plh.109.2023.03.22.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:48:29 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 1/2] bpf/selftests: coverage for bpf_map_ops errors
Date:   Wed, 22 Mar 2023 12:47:53 -0700
Message-Id: <20230322194754.185781-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322194754.185781-1-inwardvessel@gmail.com>
References: <20230322194754.185781-1-inwardvessel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These tests expose the issue of being unable to properly check for errors
returned from inlined bpf map helpers that make calls to the bpf_map_ops
functions. At best, a check for zero or non-zero can be done but these
tests show it is not possible to check for a negative value or for a
specific error value.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/map_ops.c        | 162 ++++++++++++++++++
 .../selftests/bpf/progs/test_map_ops.c        | 138 +++++++++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_ops.c b/tools/testing/selftests/bpf/prog_tests/map_ops.c
new file mode 100644
index 000000000000..be5e42a413b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_ops.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "test_map_ops.skel.h"
+#include "test_progs.h"
+
+static void map_update(void)
+{
+	(void)syscall(__NR_getpid);
+}
+
+static void map_delete(void)
+{
+	(void)syscall(__NR_getppid);
+}
+
+static void map_push(void)
+{
+	(void)syscall(__NR_getuid);
+}
+
+static void map_pop(void)
+{
+	(void)syscall(__NR_geteuid);
+}
+
+static void map_peek(void)
+{
+	(void)syscall(__NR_getgid);
+}
+
+static void map_for_each_pass(void)
+{
+	(void)syscall(__NR_gettid);
+}
+
+static void map_for_each_fail(void)
+{
+	(void)syscall(__NR_getpgid);
+}
+
+static int setup(struct test_map_ops **skel)
+{
+	int err = 0;
+
+	if (!skel)
+		return -1;
+
+	*skel = test_map_ops__open();
+	if (!ASSERT_OK_PTR(*skel, "test_map_ops__open"))
+		return -1;
+
+	(*skel)->rodata->pid = getpid();
+
+	err = test_map_ops__load(*skel);
+	if (!ASSERT_OK(err, "test_map_ops__load"))
+		return err;
+
+	err = test_map_ops__attach(*skel);
+	if (!ASSERT_OK(err, "test_map_ops__attach"))
+		return err;
+
+	return err;
+}
+
+static void teardown(struct test_map_ops **skel)
+{
+	if (skel && *skel)
+		test_map_ops__destroy(*skel);
+}
+
+static void map_ops_update_delete_subtest(void)
+{
+	struct test_map_ops *skel;
+
+	if (setup(&skel))
+		goto teardown;
+
+	map_update();
+	ASSERT_OK(skel->bss->err, "map_update_initial");
+
+	map_update();
+	ASSERT_LT(skel->bss->err, 0, "map_update_existing");
+	ASSERT_EQ(skel->bss->err, -EEXIST, "map_update_existing");
+
+	map_delete();
+	ASSERT_OK(skel->bss->err, "map_delete_existing");
+
+	map_delete();
+	ASSERT_LT(skel->bss->err, 0, "map_delete_non_existing");
+	ASSERT_EQ(skel->bss->err, -ENOENT, "map_delete_non_existing");
+
+teardown:
+	teardown(&skel);
+}
+
+static void map_ops_push_peek_pop_subtest(void)
+{
+	struct test_map_ops *skel;
+
+	if (setup(&skel))
+		goto teardown;
+
+	map_push();
+	ASSERT_OK(skel->bss->err, "map_push_initial");
+
+	map_push();
+	ASSERT_LT(skel->bss->err, 0, "map_push_when_full");
+	ASSERT_EQ(skel->bss->err, -E2BIG, "map_push_when_full");
+
+	map_peek();
+	ASSERT_OK(skel->bss->err, "map_peek");
+
+	map_pop();
+	ASSERT_OK(skel->bss->err, "map_pop");
+
+	map_peek();
+	ASSERT_LT(skel->bss->err, 0, "map_peek_when_empty");
+	ASSERT_EQ(skel->bss->err, -ENOENT, "map_peek_when_empty");
+
+	map_pop();
+	ASSERT_LT(skel->bss->err, 0, "map_pop_when_empty");
+	ASSERT_EQ(skel->bss->err, -ENOENT, "map_pop_when_empty");
+
+teardown:
+	teardown(&skel);
+}
+
+static void map_ops_for_each_subtest(void)
+{
+	struct test_map_ops *skel;
+
+	if (setup(&skel))
+		goto teardown;
+
+	map_for_each_pass();
+	/* expect to iterate over 1 element */
+	ASSERT_EQ(skel->bss->err, 1, "map_for_each_no_flags");
+
+	map_for_each_fail();
+	ASSERT_LT(skel->bss->err, 0, "map_for_each_with_flags");
+	ASSERT_EQ(skel->bss->err, -EINVAL, "map_for_each_with_flags");
+
+teardown:
+	teardown(&skel);
+}
+
+void test_map_ops(void)
+{
+	if (test__start_subtest("map_ops_update_delete"))
+		map_ops_update_delete_subtest();
+
+	if (test__start_subtest("map_ops_push_peek_pop"))
+		map_ops_push_peek_pop_subtest();
+
+	if (test__start_subtest("map_ops_for_each"))
+		map_ops_for_each_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_ops.c b/tools/testing/selftests/bpf/progs/test_map_ops.c
new file mode 100644
index 000000000000..b53b46a090c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_ops.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK);
+	__uint(max_entries, 1);
+	__type(value, int);
+} stack_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} array_map SEC(".maps");
+
+const volatile pid_t pid;
+long err = 0;
+
+static u64 callback(u64 map, u64 key, u64 val, u64 ctx, u64 flags)
+{
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpid")
+int map_update(void *ctx)
+{
+	const int key = 0;
+	const int val = 1;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	err = bpf_map_update_elem(&hash_map, &key, &val, BPF_NOEXIST);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getppid")
+int map_delete(void *ctx)
+{
+	const int key = 0;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	err = bpf_map_delete_elem(&hash_map, &key);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getuid")
+int map_push(void *ctx)
+{
+	const int val = 1;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	err = bpf_map_push_elem(&stack_map, &val, 0);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_geteuid")
+int map_pop(void *ctx)
+{
+	int val;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	err = bpf_map_pop_elem(&stack_map, &val);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getgid")
+int map_peek(void *ctx)
+{
+	int val;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	err = bpf_map_peek_elem(&stack_map, &val);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_gettid")
+int map_for_each_pass(void *ctx)
+{
+	const int key = 0;
+	const int val = 1;
+	const u64 flags = 0;
+	int callback_ctx;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	bpf_map_update_elem(&array_map, &key, &val, flags);
+
+	err = bpf_for_each_map_elem(&array_map, callback, &callback_ctx, flags);
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int map_for_each_fail(void *ctx)
+{
+	const int key = 0;
+	const int val = 1;
+	const u64 flags = BPF_NOEXIST;
+	int callback_ctx;
+
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	bpf_map_update_elem(&array_map, &key, &val, flags);
+
+	/* calling for_each with non-zero flags will return error */
+	err = bpf_for_each_map_elem(&array_map, callback, &callback_ctx, flags);
+
+	return 0;
+}
-- 
2.39.2

