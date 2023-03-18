Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1156BF724
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCRBNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCRBNv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 21:13:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766EA9DDC
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:13:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id y2so7108008pjg.3
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679102029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbP5314Co3gs8IS1E5bDywYgDOM10VnTD9DX1nBYftI=;
        b=DOD233UsHv0oGWYeMxQu1oTzCnBSfPpXYfKW8RhArFUGB2tGf9sf2EytvnculHkUwq
         QWJfsqsVez9orcifqmTMxFWI5L3bxcUezSbeKvuuxmOpjJUaSPLhxynp5/xeU0j7tAci
         U0z5Pw4K6D/STLuGm/foYDw40PV0KPW9ofOtpBWRqnTseHB3KX3r4FFDpcOiccMHQQtp
         ktifSzFsOrWUsvOQKxa0W0fUiO1LwubhJVr95SmfAKlyH0sibQZJI08GU8z0DWCDlW27
         +C4i5MZNjm923xvv9LwqdfxqK1uJ4KvWKZSmO0XeM8P+8LuIKgx0/ks+ac+mkGZtv6v5
         Qgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679102029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbP5314Co3gs8IS1E5bDywYgDOM10VnTD9DX1nBYftI=;
        b=RgFT3lsR4ev4NUO9pRfco/WzsregbDZOG2xTQTNZMz3rzMXk+t4FhxLMMjVqOoA80R
         /qtgDOspnp+Ky93oVqpGtwJw9PwMpoVo10xvxQmTqfkd8ZRZRcH99Z6h2GdESybV+uO3
         bg3Vkg8YFImPkegnwKc4gxwcEEUhYHAmS2rwN++uQEaj4BP87t/Gwia8n6oeO7WKKZTc
         R0G5TtbKOgOD8xllu+jHJoJ/Oy1RP9vsiO0seRes7h9fiNiTBa1gu4EVhj+KE6UUqhv7
         nKYkdVMK82pBpdUCSixXCeZgVV6ndZmR1G0Bk0z+zz6DdjfGbRiUiaS0/Ch8hG5CgmRB
         4f4g==
X-Gm-Message-State: AO0yUKVM00Dasp8t+ivmEXlSZNZfT8nI3FGK3IXWSLSkeKOmsPLBvvL+
        bRgsNR2CGx8m9/Q53Sr14K+d367NwGw=
X-Google-Smtp-Source: AK7set+gLv5V6wvztbnKBnE/Aw5z/rdZqKoQYYGwBqsLL40SMX7ogk8wpXGZHQmSHV6umZBGPkpKqQ==
X-Received: by 2002:a17:90b:3908:b0:237:9cc7:28a6 with SMTP id ob8-20020a17090b390800b002379cc728a6mr10515827pjb.26.1679102029071;
        Fri, 17 Mar 2023 18:13:49 -0700 (PDT)
Received: from localhost.localdomain ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090ad3d500b002309279baf8sm5483549pjw.43.2023.03.17.18.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 18:13:48 -0700 (PDT)
From:   inwardvessel <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH bpf-next 1/2] bpf/selftests: coverage for bpf_map_ops errors
Date:   Fri, 17 Mar 2023 18:13:23 -0700
Message-Id: <20230318011324.203830-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318011324.203830-1-inwardvessel@gmail.com>
References: <20230318011324.203830-1-inwardvessel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: JP Kobryn <inwardvessel@gmail.com>

These tests expose the issue of being unable to properly check for errors
returned from bpf helpers that make inline calls to the bpf_map_ops
functions. At best, a check for zero or non-zero can be done but these
tests show it is not possible to check for a negative value or for a
specific error value.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 .../selftests/bpf/prog_tests/map_ops.c        | 130 ++++++++++++++++++
 .../selftests/bpf/progs/test_map_ops.c        |  90 ++++++++++++
 2 files changed, 220 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_ops.c b/tools/testing/selftests/bpf/prog_tests/map_ops.c
new file mode 100644
index 000000000000..d08759801ad2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_ops.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "test_progs.h"
+#include "test_map_ops.skel.h"
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
+void test_map_ops(void)
+{
+	if (test__start_subtest("map_ops_update_delete"))
+		map_ops_update_delete_subtest();
+
+	if (test__start_subtest("map_ops_push_peek_pop"))
+		map_ops_push_peek_pop_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_ops.c b/tools/testing/selftests/bpf/progs/test_map_ops.c
new file mode 100644
index 000000000000..3b684073ea64
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_ops.c
@@ -0,0 +1,90 @@
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
+const volatile pid_t pid;
+long err = 0;
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
-- 
2.39.2

