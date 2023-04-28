Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FCC6F20CA
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjD1W2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbjD1W2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 18:28:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042462137
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 15:28:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52867360efcso229546a12.2
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682720891; x=1685312891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhIr1P69QSyWe27YC0q38BmAGGLs2hivsqE/0X9WQSU=;
        b=ikhxAzd/oJU4L3CU9ynZFJsGjFsJLogXw3S1JLGpat/zYYSSNSMC+ZKdCkEGWXPaIY
         E5gUVSK8FxDPJ9fSYiUwIyDRomuWxt3N3JEe+9wRMUvRTYiz66uXoFckQdbsvsEpFMkf
         jEGKxjgSykLf+U28NvJO9wglOZSGvTfRQEVE4FZq1EKVtVZ4sALdXwu185rFa86dag7l
         1qCGwsRhd6jTYjjCY3YRDdgesUTKOtXLwOph3IWcLpRR7AlixiUX3GeIWudDEREPrg2L
         TYTM/zCs6aTRDrUworwewSR5nuH2NnKARTkdo1Pezd6eDB9jVq9TJ3UkDf8ABvfuG0Un
         xWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720891; x=1685312891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhIr1P69QSyWe27YC0q38BmAGGLs2hivsqE/0X9WQSU=;
        b=jaLjHjbkkVMVIjVLGxikH/LFgRnvw5tB6MtA6dg2RWz1x8b1pGG0Lhe/18l8bwJeRn
         kodPdvTwyn/SV08r698j0/C3mSk5qCJL3zdthI8dTTc4np9nPCzeJ+3biDoQnlsqBGMS
         4Ia4xnAPJ3caLifm71Y19Z8PJdoEjiOcrTAsnQJKfIG/hyk1uX8opnfxUitpUNM6QoiE
         ug6hwJeG+FApNZ55CMcgVZYzGAdyWn01m7G/xs8GUxwyv8AC4IOYHLao0O8y1Jo2+IJb
         17nRVz90eZxaQJw5bacffdXphxltXHteQ+u510NNmCibr5XLxzU1DaRrnZAKD93gra2B
         INJw==
X-Gm-Message-State: AC+VfDxoZBFfJIcY39bD902BY4jPhefykk64l2AB1LO5sFXD/JV+CNEK
        pPfj0WmkEl++UppsWw4yoEN/jgzpnhg=
X-Google-Smtp-Source: ACHHUZ47AULuUh4auLUNcKA+VTmDj9kYEQ9noIEdLupc5Uu4boXBkks2A6Bba1LdRh2fXA1Md0aftQ==
X-Received: by 2002:a17:902:f68b:b0:1aa:ce4d:c776 with SMTP id l11-20020a170902f68b00b001aace4dc776mr1406159plg.41.1682720891484;
        Fri, 28 Apr 2023 15:28:11 -0700 (PDT)
Received: from toolbox.. ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id ba11-20020a170902720b00b001a63ba28052sm10465738plb.69.2023.04.28.15.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:28:10 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com
Subject: [PATCH bpf-next 2/2] libbpf: selftests for resizing datasec maps
Date:   Fri, 28 Apr 2023 15:27:54 -0700
Message-Id: <20230428222754.183432-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428222754.183432-1-inwardvessel@gmail.com>
References: <20230428222754.183432-1-inwardvessel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds test coverage for resizing datasec maps. There are two
tests which run a bpf program that sums the elements in the datasec array.
After the datasec array is resized, each elements is assigned a value of 1
so that the sum will be equal to the length of the array. Assertions are
done to verify this. The first test attempts to resize to an aligned
length while the second attempts to resize to a mis-aligned length where
rounding up is expected to occur. The third test attempts to resize maps
that do not meet the necessary criteria and assertions are done to confirm
error codes are returned.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 .../bpf/prog_tests/global_map_resize.c        | 187 ++++++++++++++++++
 .../bpf/progs/test_global_map_resize.c        |  33 ++++
 2 files changed, 220 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
new file mode 100644
index 000000000000..f38df37664a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "test_global_map_resize.skel.h"
+#include "test_progs.h"
+
+static void run_program(void)
+{
+	(void)syscall(__NR_getpid);
+}
+
+static int setup(struct test_global_map_resize **skel)
+{
+	if (!skel)
+		return -1;
+
+	*skel = test_global_map_resize__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
+		return -1;
+
+	(*skel)->rodata->pid = getpid();
+
+	return 0;
+}
+
+static void teardown(struct test_global_map_resize **skel)
+{
+	if (skel && *skel)
+		test_global_map_resize__destroy(*skel);
+}
+
+static int resize_test(struct test_global_map_resize *skel,
+		__u32 element_sz, __u32 desired_sz)
+{
+	int ret = 0;
+	struct bpf_map *map;
+	__u32 initial_sz, actual_sz;
+	size_t nr_elements;
+	int *initial_val;
+	size_t initial_val_sz;
+
+	map = skel->maps.data_my_array;
+
+	initial_sz = bpf_map__value_size(map);
+	ASSERT_EQ(initial_sz, element_sz, "initial size");
+
+	/* round up desired size to align with element size */
+	desired_sz = roundup(desired_sz, element_sz);
+	ret = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_OK(ret, "bpf_map__set_value_size"))
+		return ret;
+
+	/* refresh map pointer to avoid invalidation issues */
+	map = skel->maps.data_my_array;
+
+	actual_sz = bpf_map__value_size(map);
+	ASSERT_EQ(actual_sz, desired_sz, "resize");
+
+	/* set the expected number of elements based on the resized array */
+	nr_elements = roundup(actual_sz, element_sz) / element_sz;
+	skel->rodata->n = nr_elements;
+
+	/* create array for initial map value */
+	initial_val_sz = element_sz * nr_elements;
+	initial_val = malloc(initial_val_sz);
+	if (!ASSERT_OK_PTR(initial_val, "malloc initial_val")) {
+		ret = -ENOMEM;
+
+		goto cleanup;
+	}
+
+	/* fill array with ones */
+	for (int i = 0; i < nr_elements; ++i)
+		initial_val[i] = 1;
+
+	/* set initial value */
+	ASSERT_EQ(initial_val_sz, actual_sz, "initial value size");
+
+	ret = bpf_map__set_initial_value(map, initial_val, initial_val_sz);
+	if (!ASSERT_OK(ret, "bpf_map__set_initial_val"))
+		goto cleanup;
+
+	ret = test_global_map_resize__load(skel);
+	if (!ASSERT_OK(ret, "test_global_map_resize__load"))
+		goto cleanup;
+
+	ret = test_global_map_resize__attach(skel);
+	if (!ASSERT_OK(ret, "test_global_map_resize__attach"))
+		goto cleanup;
+
+	/* run the bpf program which will sum the contents of the array */
+	run_program();
+
+	if (!ASSERT_EQ(skel->bss->sum, nr_elements, "sum"))
+		goto cleanup;
+
+cleanup:
+	if (initial_val)
+		free(initial_val);
+
+	return ret;
+}
+
+static void global_map_resize_aligned_subtest(void)
+{
+	struct test_global_map_resize *skel;
+	const __u32 element_sz = (__u32)sizeof(int);
+	const __u32 desired_sz = (__u32)sysconf(_SC_PAGE_SIZE) * 2;
+
+	/* preliminary check that desired_sz aligns with element_sz */
+	if (!ASSERT_EQ(desired_sz % element_sz, 0, "alignment"))
+		return;
+
+	if (setup(&skel))
+		goto teardown;
+
+	if (resize_test(skel, element_sz, desired_sz))
+		goto teardown;
+
+teardown:
+	teardown(&skel);
+}
+
+static void global_map_resize_roundup_subtest(void)
+{
+	struct test_global_map_resize *skel;
+	const __u32 element_sz = (__u32)sizeof(int);
+	/* set desired size a fraction of element size beyond an aligned size */
+	const __u32 desired_sz = (__u32)sysconf(_SC_PAGE_SIZE) * 2 + element_sz / 2;
+
+	/* preliminary check that desired_sz does NOT align with element_sz */
+	if (!ASSERT_NEQ(desired_sz % element_sz, 0, "alignment"))
+		return;
+
+	if (setup(&skel))
+		goto teardown;
+
+	if (resize_test(skel, element_sz, desired_sz))
+		goto teardown;
+
+teardown:
+	teardown(&skel);
+}
+
+static void global_map_resize_invalid_subtest(void)
+{
+	int err;
+	struct test_global_map_resize *skel;
+	struct bpf_map *map;
+	const __u32 desired_sz = 8192;
+
+	if (setup(&skel))
+		goto teardown;
+
+	/* attempt to resize a global datasec map which is an array
+	 * BUT is with a var in same datasec
+	 */
+	map = skel->maps.data_my_array_and_var;
+	err = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__set_value_size"))
+		goto teardown;
+
+	/* attempt to resize a global datasec map which is NOT an array */
+	map = skel->maps.data_my_non_array;
+	err = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__set_value_size"))
+		goto teardown;
+
+teardown:
+	teardown(&skel);
+}
+
+void test_global_map_resize(void)
+{
+	if (test__start_subtest("global_map_resize_aligned"))
+		global_map_resize_aligned_subtest();
+
+	if (test__start_subtest("global_map_resize_roundup"))
+		global_map_resize_roundup_subtest();
+
+	if (test__start_subtest("global_map_resize_invalid"))
+		global_map_resize_invalid_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
new file mode 100644
index 000000000000..cffbba1b6020
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile pid_t pid;
+const volatile size_t n;
+
+int my_array[1] SEC(".data.my_array");
+
+int my_array_with_neighbor[1] SEC(".data.my_array_and_var");
+int my_var_with_neighbor SEC(".data.my_array_and_var");
+
+int my_non_array SEC(".data.my_non_array");
+
+int sum = 0;
+
+SEC("tp/syscalls/sys_enter_getpid")
+int array_sum(void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	sum = 0;
+
+	for (size_t i = 0; i < n; ++i)
+		sum += my_array[i];
+
+	return 0;
+}
-- 
2.40.0

