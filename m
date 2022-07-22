Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAEF57E56F
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiGVRXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiGVRXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:23:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDAB9DECE
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:23:11 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGSF6sBDz67fK4;
        Sat, 23 Jul 2022 01:21:17 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:23:08 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 15/15] selftests/bpf: Add map access tests
Date:   Fri, 22 Jul 2022 19:18:36 +0200
Message-ID: <20220722171836.2852247-16-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722171836.2852247-1-roberto.sassu@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check the correctness of permission requests on two maps, one with
read-only access, and one with read-write access. Accesses are enforced
with a small eBPF program implementing the bpf_map security hook.

Ensure that read-like operations can be still executed on a read-only map,
unlike before where they were denied due to the requestor unnecessarily
specifying read-write permissions.

Also ensure that the read-write map can be still accessed when requesting
a write-like operation, unlike before where the search would stop at the
read-only map due to not having sufficient permissions.

Do the tests programmatically, with the new functions added to libbpf
accepting the opts parameter, and with the bpftool binary.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../bpf/prog_tests/map_check_access.c         | 186 ++++++++++++++++++
 .../bpf/progs/test_map_check_access.c         | 112 +++++++++++
 3 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_check_access.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_check_access.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d59ec7f4c2d..a4f0b6f5c9f1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -501,6 +501,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
+	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bpftool $(if $2,$2/)bpftool_nobootstrap
 
 endef
 
@@ -595,7 +596,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-	feature bpftool							\
+	feature bpftool bpftool_nobootstrap				\
 	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 bpf_gcc bpf_testmod.ko		\
 			       liburandom_read.so)
diff --git a/tools/testing/selftests/bpf/prog_tests/map_check_access.c b/tools/testing/selftests/bpf/prog_tests/map_check_access.c
new file mode 100644
index 000000000000..c2d801503a87
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_check_access.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <sys/stat.h>
+#include <test_progs.h>
+
+#include "test_map_check_access.skel.h"
+
+#define PINNED_MAP_PATH "/sys/fs/bpf/test_map_check_access_map"
+#define PINNED_ITER_PATH "/sys/fs/bpf/test_map_check_access_iter"
+#define BPFTOOL_PATH "./bpftool_nobootstrap"
+#define MAX_CMD_SIZE 1024
+
+enum check_types { CHECK_NONE, CHECK_PINNED, CHECK_METADATA, CHECK_PERF };
+
+struct bpftool_command {
+	char str[MAX_CMD_SIZE];
+	enum check_types check;
+	bool failure;
+};
+
+struct bpftool_command bpftool_commands[] = {
+	{ .str = BPFTOOL_PATH " map list" },
+	{ .str = BPFTOOL_PATH " map show name data_input" },
+	{ .str = BPFTOOL_PATH " map -f show pinned " PINNED_MAP_PATH,
+	  .check = CHECK_PINNED },
+	{ .str = "rm -f " PINNED_MAP_PATH },
+	{ .str = BPFTOOL_PATH " map dump name data_input" },
+	{ .str = BPFTOOL_PATH " map lookup name data_input key 0 0 0 0" },
+	{ .str = BPFTOOL_PATH
+	  " map update name data_input key 0 0 0 0 value 0 0 0 0 2> /dev/null",
+	  .failure = true },
+	{ .str = BPFTOOL_PATH
+	  " map update name data_input_mim key 0 0 0 0 value name data_input" },
+	{ .str = BPFTOOL_PATH
+	  " map update name data_input_w key 0 0 0 0 value 0 0 0 0" },
+	{ .str = BPFTOOL_PATH " iter pin test_map_check_access.o "
+		 PINNED_ITER_PATH " map name data_input" },
+	{ .str = "cat " PINNED_ITER_PATH },
+	{ .str = "rm -f " PINNED_ITER_PATH },
+	{ .str = BPFTOOL_PATH " prog show name check_access",
+	  .check = CHECK_METADATA },
+	{ .str = BPFTOOL_PATH " btf show" },
+	{ .str = BPFTOOL_PATH " btf dump map name data_input" },
+	{ .str = BPFTOOL_PATH " map pin name data_input " PINNED_MAP_PATH },
+	{ .str = BPFTOOL_PATH " struct_ops show name dummy_2" },
+	{ .str = BPFTOOL_PATH " struct_ops dump name dummy_2" },
+	{ .str = BPFTOOL_PATH " map event_pipe name data_input_perf",
+	  .check = CHECK_PERF },
+};
+
+static int _run_bpftool(struct bpftool_command *command)
+{
+	char output[1024] = { 0 };
+	FILE *fp;
+	int ret;
+
+	fp = popen(command->str, "r");
+	if (!fp)
+		return -errno;
+
+	fread(output, sizeof(output) - 1, sizeof(*output), fp);
+
+	ret = pclose(fp);
+	if (WEXITSTATUS(ret) && !command->failure)
+		return WEXITSTATUS(ret);
+
+	ret = 0;
+
+	switch (command->check) {
+	case CHECK_PINNED:
+		if (!strstr(output, PINNED_MAP_PATH))
+			ret = -ENOENT;
+		break;
+	case CHECK_METADATA:
+		if (!strstr(output, "test_var"))
+			ret = -ENOENT;
+		break;
+	case CHECK_PERF:
+		if (strncmp(output, "==", 2))
+			ret = -ENOENT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+void test_map_check_access(void)
+{
+	struct test_map_check_access *skel;
+	struct bpf_map_info info_m = { 0 };
+	struct bpf_map *map;
+	__u32 len = sizeof(info_m);
+	int ret, zero = 0, fd, i;
+
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, opts_rdonly,
+		.flags = BPF_F_RDONLY,
+	);
+
+	skel = test_map_check_access__open();
+	if (!ASSERT_OK_PTR(skel, "test_map_check_access__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.dump_bpf_hash_map, false);
+
+	ret = test_map_check_access__load(skel);
+	if (!ASSERT_OK(ret, "test_map_check_access__load"))
+		goto close_prog;
+
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto close_prog;
+
+	ret = test_map_check_access__attach(skel);
+	if (!ASSERT_OK(ret, "test_map_check_access__attach"))
+		goto close_prog;
+
+	map = bpf_object__find_map_by_name(skel->obj, "data_input");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
+		goto close_prog;
+
+	ret = bpf_obj_get_info_by_fd(bpf_map__fd(map), &info_m, &len);
+	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
+		goto close_prog;
+
+	fd = bpf_map_get_fd_by_id(info_m.id);
+	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id"))
+		goto close_prog;
+
+	fd = bpf_map_get_fd_by_id_opts(info_m.id, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id_opts"))
+		goto close_prog;
+
+	fd = bpf_map_get_fd_by_id_opts(info_m.id, &opts_rdonly);
+	if (!ASSERT_GE(fd, 0, "bpf_map_get_fd_by_id_opts"))
+		goto close_prog;
+
+	ret = bpf_map_lookup_elem(fd, &zero, &len);
+	if (!ASSERT_OK(ret, "bpf_map_lookup_elem")) {
+		close(fd);
+		goto close_prog;
+	}
+
+	ret = bpf_map_update_elem(fd, &zero, &len, BPF_ANY);
+
+	close(fd);
+
+	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem"))
+		goto close_prog;
+
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &len, BPF_ANY);
+	if (!ASSERT_OK(ret, "bpf_map_update_elem"))
+		goto close_prog;
+
+	ret = bpf_map__pin(map, PINNED_MAP_PATH);
+	if (!ASSERT_OK(ret, "bpf_map__pin"))
+		goto close_prog;
+
+	fd = bpf_obj_get_opts(PINNED_MAP_PATH, &opts_rdonly);
+	if (!ASSERT_GE(fd, 0, "bpf_obj_get_opts"))
+		goto close_prog;
+
+	close(fd);
+
+	fd = bpf_obj_get_opts(PINNED_MAP_PATH, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_obj_get_opts")) {
+		close(fd);
+		goto close_prog;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bpftool_commands); i++) {
+		ret = _run_bpftool(&bpftool_commands[i]);
+		if (!ASSERT_OK(ret, bpftool_commands[i].str))
+			goto close_prog;
+	}
+
+close_prog:
+	test_map_check_access__destroy(skel);
+	unlink(PINNED_MAP_PATH);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_check_access.c b/tools/testing/selftests/bpf/progs/test_map_check_access.c
new file mode 100644
index 000000000000..6b8f0bf8f77e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_check_access.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2021. Huawei Technologies Co., Ltd
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* From include/linux/mm.h. */
+#define FMODE_WRITE	0x2
+
+const char bpf_metadata_test_var[] SEC(".rodata") = "test_var";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} data_input SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} data_input_w SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__uint(map_flags, 0);
+	__type(key, __u32);
+	__type(value, __u32);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, int);
+		__type(value, int);
+	});
+} data_input_mim SEC(".maps") = {
+	.values = { (void *)&data_input },
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, int);
+} data_input_perf SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_hash_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct bpf_map *map = ctx->map;
+	u32 *key = ctx->key;
+	u32 *val = ctx->value;
+
+	if (key == (void *)0 || val == (void *)0)
+		return 0;
+
+	BPF_SEQ_PRINTF(seq, "%d: (%x) (%llx)\n", map->id, *key, *val);
+	return 0;
+}
+
+SEC("lsm/bpf_map")
+int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
+{
+	if (map != (struct bpf_map *)&data_input)
+		return 0;
+
+	if (fmode & FMODE_WRITE)
+		return -EACCES;
+
+	return 0;
+}
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
+{
+	return 0;
+}
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2, struct bpf_dummy_ops_state *state, int a1,
+	     unsigned short a2, char a3, unsigned long a4)
+{
+	return 0;
+}
+
+SEC(".struct_ops")
+struct bpf_dummy_ops dummy_2 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+};
+
+SEC("tp/raw_syscalls/sys_enter")
+int handle_sys_enter(void *ctx)
+{
+	int cpu = bpf_get_smp_processor_id();
+
+	bpf_perf_event_output(ctx, &data_input_perf, BPF_F_CURRENT_CPU,
+			      &cpu, sizeof(cpu));
+	return 0;
+}
-- 
2.25.1

