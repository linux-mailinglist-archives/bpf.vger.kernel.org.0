Return-Path: <bpf+bounces-1143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D115970EA6D
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBB11C20A3F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE3315AD;
	Wed, 24 May 2023 00:45:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACE15A9
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:45:52 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244BC2
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:45:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae875bf125so2308895ad.1
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684889149; x=1687481149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkB7NMn7+G6/Bx7vVcPjh+4kdCysWSTZ0CvFjJTTf7M=;
        b=jw6nE5EWqrtv7ZLvnRjLghUmeXmxBZo5F9ThpUcnkQbYG8fCm2Fgm5vuTLIb+XXjf0
         VSCA6mr5FBGNGPsKT9hA449fdBuC1Ym3XLBpCsC3V4YuwJmYIqzhZ439gC+NbEg/IHew
         VMRB67SI7vQOP3MDu2CIH9lYTQP3XNX8iYXrAMllvUknNvAee3sX1Vb8tSTu9XMoZrW3
         pjBvm8UxgPfwNztF89v6dwUMr/LoVsp+QaskLmJyg1VBV1eL4J5zf6vV+9BH4uvrqZRU
         kQQ1dp9Sw1PDWbcD3hlG9bRSTmnvPD9KVAJ6zMiYFmDbpFc9uKd5ageH91paRezcz6/4
         ZdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684889149; x=1687481149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkB7NMn7+G6/Bx7vVcPjh+4kdCysWSTZ0CvFjJTTf7M=;
        b=Y2AMEL6f/hndWIndCwPooYAN+wa/+5fvdzmdiKasmjBkqSqVs8dVTf10pekryoWmbY
         +ib54R+oAGtc+KYC2cX3alg0L25XUjC1Xo62xsxMuVY1uoI4RVKp9WEyjRDrpucAjJjk
         muH6/iPGwSDphlR18+v1KBq9oyikPWil+qcCLzgXdN5OdCVwRAPzh8dKefFbkAI3PWJt
         v5FAkV0bAH80ZxVrcMfO7LIjIUlLhXI6xd7eoeQ78VBMqKzJlD/grDxZebTLTmweUrwb
         Jz6CZo97v7+ElZAdoR5of+YOSPEFXUUnKO0SFkrUOsbpRU+GW/t80SCc/WydPZAKuH+C
         GAxQ==
X-Gm-Message-State: AC+VfDyVM6vzU7ANz2nsXjgaCFGp3ff7Y8iYk6U3DutiPQDedHHRGfq/
	S2YfIg8MHF7itIdXU3d1n4ZPzi3GLg+EnA==
X-Google-Smtp-Source: ACHHUZ5GmcXAdX3LWeFBhvLiHACZSjGnWXD79urw/Z60l2Fs/3Rc6WPvVHK/th5xEjgybpshv3yrjw==
X-Received: by 2002:a17:902:d504:b0:1af:d19a:a67b with SMTP id b4-20020a170902d50400b001afd19aa67bmr2742314plg.33.1684889149425;
        Tue, 23 May 2023 17:45:49 -0700 (PDT)
Received: from toolbox.. ([98.42.24.125])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001a673210cf4sm7399292plg.74.2023.05.23.17.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:45:48 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com,
	inwardvessel@gmail.com,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 2/2] libbpf: selftests for resizing datasec maps
Date: Tue, 23 May 2023 17:45:37 -0700
Message-Id: <20230524004537.18614-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524004537.18614-1-inwardvessel@gmail.com>
References: <20230524004537.18614-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds test coverage for resizing datasec maps. The first two
subtests resize the bss and custom data sections. In both cases, an
initial array (of length one) has its element set to one. After resizing
the rest of the array is filled with ones as well. A BPF program is then
run to sum the respective arrays and back on the userspace side the sum
is checked to be equal to the number of elements.
The third subtest attempts to perform resizing under conditions that
will result in either the resize failing or the BTF info being cleared.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/global_map_resize.c        | 236 ++++++++++++++++++
 .../bpf/progs/test_global_map_resize.c        |  58 +++++
 2 files changed, 294 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
new file mode 100644
index 000000000000..58961789d0b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <errno.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "test_global_map_resize.skel.h"
+#include "test_progs.h"
+
+static void run_prog_bss_array_sum(void)
+{
+	(void)syscall(__NR_getpid);
+}
+
+static void run_prog_data_array_sum(void)
+{
+	(void)syscall(__NR_getuid);
+}
+
+static void global_map_resize_bss_subtest(void)
+{
+	int err;
+	struct test_global_map_resize *skel;
+	struct bpf_map *map;
+	const __u32 desired_sz = sizeof(skel->bss->sum) + (__u32)sysconf(_SC_PAGE_SIZE) * 2;
+	size_t array_len, actual_sz;
+
+	skel = test_global_map_resize__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
+		goto teardown;
+
+	/* set some initial value before resizing.
+	 * it is expected this non-zero value will be preserved
+	 * while resizing.
+	 */
+	skel->bss->array[0] = 1;
+
+	/* resize map value and verify the new size */
+	map = skel->maps.bss;
+	err = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
+		goto teardown;
+	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "resize"))
+		goto teardown;
+
+	/* set the expected number of elements based on the resized array */
+	array_len = (desired_sz - sizeof(skel->bss->sum)) /
+		(__u32)sizeof(skel->bss->array[0]);
+	if (!ASSERT_GT(array_len, 1, "array_len"))
+		goto teardown;
+
+	skel->bss =
+		(struct test_global_map_resize__bss *)bpf_map__initial_value(
+				skel->maps.bss, &actual_sz);
+	if (!ASSERT_OK_PTR(skel->bss, "bpf_map__initial_value (ptr)"))
+		goto teardown;
+	if (!ASSERT_EQ(actual_sz, desired_sz, "bpf_map__initial_value (size)"))
+		goto teardown;
+
+	/* fill the newly resized array with ones,
+	 * skipping the first element which was previously set
+	 */
+	for (int i = 1; i < array_len; i++)
+		skel->bss->array[i] = 1;
+
+	/* set global const values before loading */
+	skel->rodata->pid = getpid();
+	skel->rodata->bss_array_len = array_len;
+	skel->rodata->data_array_len = 1;
+
+	err = test_global_map_resize__load(skel);
+	if (!ASSERT_OK(err, "test_global_map_resize__load"))
+		goto teardown;
+	err = test_global_map_resize__attach(skel);
+	if (!ASSERT_OK(err, "test_global_map_resize__attach"))
+		goto teardown;
+
+	/* run the bpf program which will sum the contents of the array.
+	 * since the array was filled with ones,verify the sum equals array_len
+	 */
+	run_prog_bss_array_sum();
+	if (!ASSERT_EQ(skel->bss->sum, array_len, "sum"))
+		goto teardown;
+
+teardown:
+	test_global_map_resize__destroy(skel);
+}
+
+static void global_map_resize_data_subtest(void)
+{
+	int err;
+	struct test_global_map_resize *skel;
+	struct bpf_map *map;
+	const __u32 desired_sz = (__u32)sysconf(_SC_PAGE_SIZE) * 2;
+	size_t array_len, actual_sz;
+
+	skel = test_global_map_resize__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
+		goto teardown;
+
+	/* set some initial value before resizing.
+	 * it is expected this non-zero value will be preserved
+	 * while resizing.
+	 */
+	skel->data_custom->my_array[0] = 1;
+
+	/* resize map value and verify the new size */
+	map = skel->maps.data_custom;
+	err = bpf_map__set_value_size(map, desired_sz);
+	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
+		goto teardown;
+	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "resize"))
+		goto teardown;
+
+	/* set the expected number of elements based on the resized array */
+	array_len = (desired_sz - sizeof(skel->bss->sum)) /
+		(__u32)sizeof(skel->data_custom->my_array[0]);
+	if (!ASSERT_GT(array_len, 1, "array_len"))
+		goto teardown;
+
+	skel->data_custom =
+		(struct test_global_map_resize__data_custom *)bpf_map__initial_value(
+				skel->maps.data_custom, &actual_sz);
+	if (!ASSERT_OK_PTR(skel->data_custom, "bpf_map__initial_value (ptr)"))
+		goto teardown;
+	if (!ASSERT_EQ(actual_sz, desired_sz, "bpf_map__initial_value (size)"))
+		goto teardown;
+
+	/* fill the newly resized array with ones,
+	 * skipping the first element which was previously set
+	 */
+	for (int i = 1; i < array_len; i++)
+		skel->data_custom->my_array[i] = 1;
+
+	/* set global const values before loading */
+	skel->rodata->pid = getpid();
+	skel->rodata->bss_array_len = 1;
+	skel->rodata->data_array_len = array_len;
+
+	err = test_global_map_resize__load(skel);
+	if (!ASSERT_OK(err, "test_global_map_resize__load"))
+		goto teardown;
+	err = test_global_map_resize__attach(skel);
+	if (!ASSERT_OK(err, "test_global_map_resize__attach"))
+		goto teardown;
+
+	/* run the bpf program which will sum the contents of the array.
+	 * since the array was filled with ones,verify the sum equals array_len
+	 */
+	run_prog_data_array_sum();
+	if (!ASSERT_EQ(skel->bss->sum, array_len, "sum"))
+		goto teardown;
+
+teardown:
+	test_global_map_resize__destroy(skel);
+}
+
+static void global_map_resize_invalid_subtest(void)
+{
+	int err;
+	struct test_global_map_resize *skel;
+	struct bpf_map *map;
+	__u32 element_sz, desired_sz;
+
+	skel = test_global_map_resize__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
+		return;
+
+	 /* attempt to resize a global datasec map to size
+	  * which does NOT align with array
+	  */
+	map = skel->maps.data_custom;
+	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, ".data.custom initial btf"))
+		goto teardown;
+	/* set desired size a fraction of element size beyond an aligned size */
+	element_sz = (__u32)sizeof(skel->data_custom->my_array[0]);
+	desired_sz = element_sz + element_sz / 2;
+	/* confirm desired size does NOT align with array */
+	if (!ASSERT_NEQ(desired_sz % element_sz, 0, "my_array alignment"))
+		goto teardown;
+	err = bpf_map__set_value_size(map, desired_sz);
+	/* confirm resize is OK but BTF info is cleared */
+	if (!ASSERT_OK(err, ".data.custom bpf_map__set_value_size") ||
+		!ASSERT_EQ(bpf_map__btf_key_type_id(map), 0, ".data.custom clear btf key") ||
+		!ASSERT_EQ(bpf_map__btf_value_type_id(map), 0, ".data.custom clear btf val"))
+		goto teardown;
+
+	/* attempt to resize a global datasec map
+	 * whose only var is NOT an array
+	 */
+	map = skel->maps.data_non_array;
+	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, ".data.non_array initial btf"))
+		goto teardown;
+	/* set desired size to arbitrary value */
+	desired_sz = 1024;
+	err = bpf_map__set_value_size(map, desired_sz);
+	/* confirm resize is OK but BTF info is cleared */
+	if (!ASSERT_OK(err, ".data.non_array bpf_map__set_value_size") ||
+		!ASSERT_EQ(bpf_map__btf_key_type_id(map), 0, ".data.non_array clear btf key") ||
+		!ASSERT_EQ(bpf_map__btf_value_type_id(map), 0, ".data.non_array clear btf val"))
+		goto teardown;
+
+	/* attempt to resize a global datasec map
+	 * whose last var is NOT an array
+	 */
+	map = skel->maps.data_array_not_last;
+	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, ".data.array_not_last initial btf"))
+		goto teardown;
+	/* set desired size to a multiple of element size */
+	element_sz = (__u32)sizeof(skel->data_array_not_last->my_array_first[0]);
+	desired_sz = element_sz * 8;
+	/* confirm desired size aligns with array */
+	if (!ASSERT_EQ(desired_sz % element_sz, 0, "my_array_first alignment"))
+		goto teardown;
+	err = bpf_map__set_value_size(map, desired_sz);
+	/* confirm resize is OK but BTF info is cleared */
+	if (!ASSERT_OK(err, ".data.array_not_last bpf_map__set_value_size") ||
+		!ASSERT_EQ(bpf_map__btf_key_type_id(map), 0, ".data.array_not_last clear btf key") ||
+		!ASSERT_EQ(bpf_map__btf_value_type_id(map), 0, ".data.array_not_last clear btf val"))
+		goto teardown;
+
+teardown:
+	test_global_map_resize__destroy(skel);
+}
+
+void test_global_map_resize(void)
+{
+	if (test__start_subtest("global_map_resize_bss"))
+		global_map_resize_bss_subtest();
+
+	if (test__start_subtest("global_map_resize_data"))
+		global_map_resize_data_subtest();
+
+	if (test__start_subtest("global_map_resize_invalid"))
+		global_map_resize_invalid_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
new file mode 100644
index 000000000000..2588f2384246
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* rodata section */
+const volatile pid_t pid;
+const volatile size_t bss_array_len;
+const volatile size_t data_array_len;
+
+/* bss section */
+int sum = 0;
+int array[1];
+
+/* custom data secton */
+int my_array[1] SEC(".data.custom");
+
+/* custom data section which should NOT be resizable,
+ * since it contains a single var which is not an array
+ */
+int my_int SEC(".data.non_array");
+
+/* custom data section which should NOT be resizable,
+ * since its last var is not an array
+ */
+int my_array_first[1] SEC(".data.array_not_last");
+int my_int_last SEC(".data.array_not_last");
+
+SEC("tp/syscalls/sys_enter_getpid")
+int bss_array_sum(void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	sum = 0;
+
+	for (size_t i = 0; i < bss_array_len; ++i)
+		sum += array[i];
+
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getuid")
+int data_array_sum(void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	sum = 0;
+
+	for (size_t i = 0; i < data_array_len; ++i)
+		sum += my_array[i];
+
+	return 0;
+}
-- 
2.40.0


