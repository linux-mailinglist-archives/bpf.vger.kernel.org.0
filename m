Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D83125C2F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 08:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfLSHpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 02:45:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfLSHpc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 02:45:32 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ7erYJ031433
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hQ8LgI/qevMPegWu+lByhiE+LxGK8iLpvfnHRprwu3Q=;
 b=OKI/9tztqzEIasyapX58lcPfymhKWyS2TM0rxWOAJozr7tN2E+zKZ3bZxzC4JCY3EbBI
 ByutG6xa4BgxSLm4zTO3fAmEDyKD8OD3TzC5H1yWvi6lVnW29C3XWnT8RNA3DjrKeHyK
 At9DznMUOm8cYe7aCy+qQlFOXT+ZFEsu8ZE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wykmqmtww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 23:45:27 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 18 Dec 2019 23:45:26 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id E4F1237138B6; Wed, 18 Dec 2019 23:45:23 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v4 bpf-next 5/6] selftests/bpf: Convert test_cgroup_attach to prog_tests
Date:   Wed, 18 Dec 2019 23:44:37 -0800
Message-ID: <0ff19cc64d2dc5cf404349f07131119480e10e32.1576741281.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576741281.git.rdna@fb.com>
References: <cover.1576741281.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=38 priorityscore=1501 malwarescore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190065
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert test_cgroup_attach to prog_tests.

This change does a lot of things but in many cases it's pretty expensive
to separate them, so they go in one commit. Nevertheless the logic is
ketp as is and changes made are just moving things around, simplifying
them (w/o changing the meaning of the tests) and making prog_tests
compatible:

* split the 3 tests in the file into 3 separate files in prog_tests/;

* rename the test functions to test_<file_base_name>;

* remove unused includes, constants, variables and functions from every
  test;

* replace `if`-s with or `if (CHECK())` where additional context should
  be logged and with `if (CHECK_FAIL())` where line number is enough;

* switch from `log_err()` to logging via `CHECK()`;

* replace `assert`-s with `CHECK_FAIL()` to avoid crashing the whole
  test_progs if one assertion fails;

* replace cgroup_helpers with test__join_cgroup() in
  cgroup_attach_override only, other tests need more fine-grained
  control for cgroup creation/deletion so cgroup_helpers are still used
  there;

* simplify cgroup_attach_autodetach by switching to easiest possible
  program since this test doesn't really need such a complicated program
  as cgroup_attach_multi does;

* remove test_cgroup_attach.c itself.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../bpf/prog_tests/cgroup_attach_autodetach.c | 111 ++++
 .../bpf/prog_tests/cgroup_attach_multi.c      | 238 ++++++++
 .../bpf/prog_tests/cgroup_attach_override.c   | 148 +++++
 .../selftests/bpf/test_cgroup_attach.c        | 571 ------------------
 6 files changed, 498 insertions(+), 574 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
 delete mode 100644 tools/testing/selftests/bpf/test_cgroup_attach.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index ce5af95ede42..b139b3d75ebb 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -21,7 +21,6 @@ test_lirc_mode2_user
 get_cgroup_id_user
 test_skb_cgroup_id_user
 test_socket_cookie
-test_cgroup_attach
 test_cgroup_storage
 test_select_reuseport
 test_flow_dissector
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c652bd84ef0e..866fc1cadd7c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -32,7 +32,7 @@ TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl test_hashmap \
-	test_cgroup_attach test_progs-no_alu32
+	test_progs-no_alu32
 
 # Also test bpf-gcc, if present
 ifneq ($(BPF_GCC),)
@@ -136,7 +136,6 @@ $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
 $(OUTPUT)/test_netcnt: cgroup_helpers.c
 $(OUTPUT)/test_sock_fields: cgroup_helpers.c
 $(OUTPUT)/test_sysctl: cgroup_helpers.c
-$(OUTPUT)/test_cgroup_attach: cgroup_helpers.c
 
 .PHONY: force
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
new file mode 100644
index 000000000000..5b13f2c6c402
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "cgroup_helpers.h"
+
+#define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+static int prog_load(void)
+{
+	struct bpf_insn prog[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 1), /* r0 = 1 */
+		BPF_EXIT_INSN(),
+	};
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+
+	return bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+			       prog, insns_cnt, "GPL", 0,
+			       bpf_log_buf, BPF_LOG_BUF_SIZE);
+}
+
+void test_cgroup_attach_autodetach(void)
+{
+	__u32 duration = 0, prog_cnt = 4, attach_flags;
+	int allow_prog[2] = {-1};
+	__u32 prog_ids[2] = {0};
+	void *ptr = NULL;
+	int cg = 0, i;
+	int attempts;
+
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
+		allow_prog[i] = prog_load();
+		if (CHECK(allow_prog[i] < 0, "prog_load",
+			  "verifier output:\n%s\n-------\n", bpf_log_buf))
+			goto err;
+	}
+
+	if (CHECK_FAIL(setup_cgroup_environment()))
+		goto err;
+
+	/* create a cgroup, attach two programs and remember their ids */
+	cg = create_and_get_cgroup("/cg_autodetach");
+	if (CHECK_FAIL(cg < 0))
+		goto err;
+
+	if (CHECK_FAIL(join_cgroup("/cg_autodetach")))
+		goto err;
+
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++)
+		if (CHECK(bpf_prog_attach(allow_prog[i], cg,
+					  BPF_CGROUP_INET_EGRESS,
+					  BPF_F_ALLOW_MULTI),
+			  "prog_attach", "prog[%d], errno=%d\n", i, errno))
+			goto err;
+
+	/* make sure that programs are attached and run some traffic */
+	if (CHECK(bpf_prog_query(cg, BPF_CGROUP_INET_EGRESS, 0, &attach_flags,
+				 prog_ids, &prog_cnt),
+		  "prog_query", "errno=%d\n", errno))
+		goto err;
+	if (CHECK_FAIL(system(PING_CMD)))
+		goto err;
+
+	/* allocate some memory (4Mb) to pin the original cgroup */
+	ptr = malloc(4 * (1 << 20));
+	if (CHECK_FAIL(!ptr))
+		goto err;
+
+	/* close programs and cgroup fd */
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
+		close(allow_prog[i]);
+		allow_prog[i] = -1;
+	}
+
+	close(cg);
+	cg = 0;
+
+	/* leave the cgroup and remove it. don't detach programs */
+	cleanup_cgroup_environment();
+
+	/* wait for the asynchronous auto-detachment.
+	 * wait for no more than 5 sec and give up.
+	 */
+	for (i = 0; i < ARRAY_SIZE(prog_ids); i++) {
+		for (attempts = 5; attempts >= 0; attempts--) {
+			int fd = bpf_prog_get_fd_by_id(prog_ids[i]);
+
+			if (fd < 0)
+				break;
+
+			/* don't leave the fd open */
+			close(fd);
+
+			if (CHECK_FAIL(!attempts))
+				goto err;
+
+			sleep(1);
+		}
+	}
+
+err:
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++)
+		if (allow_prog[i] >= 0)
+			close(allow_prog[i]);
+	if (cg)
+		close(cg);
+	free(ptr);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
new file mode 100644
index 000000000000..4eaab7435044
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "cgroup_helpers.h"
+
+#define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+static int map_fd = -1;
+
+static int prog_load_cnt(int verdict, int val)
+{
+	int cgroup_storage_fd, percpu_cgroup_storage_fd;
+
+	if (map_fd < 0)
+		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
+	if (map_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
+	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
+	percpu_cgroup_storage_fd = bpf_create_map(
+		BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+		sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (percpu_cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
+	struct bpf_insn prog[] = {
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+
+		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, val),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
+
+		BPF_LD_MAP_FD(BPF_REG_1, percpu_cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
+		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
+
+		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
+		BPF_EXIT_INSN(),
+	};
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+	int ret;
+
+	ret = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+			       prog, insns_cnt, "GPL", 0,
+			       bpf_log_buf, BPF_LOG_BUF_SIZE);
+
+	close(cgroup_storage_fd);
+	return ret;
+}
+
+void test_cgroup_attach_multi(void)
+{
+	__u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
+	int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
+	int allow_prog[6] = {-1};
+	unsigned long long value;
+	__u32 duration = 0;
+	int i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
+		allow_prog[i] = prog_load_cnt(1, 1 << i);
+		if (CHECK(allow_prog[i] < 0, "prog_load",
+			  "verifier output:\n%s\n-------\n", bpf_log_buf))
+			goto err;
+	}
+
+	if (CHECK_FAIL(setup_cgroup_environment()))
+		goto err;
+
+	cg1 = create_and_get_cgroup("/cg1");
+	if (CHECK_FAIL(cg1 < 0))
+		goto err;
+	cg2 = create_and_get_cgroup("/cg1/cg2");
+	if (CHECK_FAIL(cg2 < 0))
+		goto err;
+	cg3 = create_and_get_cgroup("/cg1/cg2/cg3");
+	if (CHECK_FAIL(cg3 < 0))
+		goto err;
+	cg4 = create_and_get_cgroup("/cg1/cg2/cg3/cg4");
+	if (CHECK_FAIL(cg4 < 0))
+		goto err;
+	cg5 = create_and_get_cgroup("/cg1/cg2/cg3/cg4/cg5");
+	if (CHECK_FAIL(cg5 < 0))
+		goto err;
+
+	if (CHECK_FAIL(join_cgroup("/cg1/cg2/cg3/cg4/cg5")))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_MULTI),
+		  "prog0_attach_to_cg1_multi", "errno=%d\n", errno))
+		goto err;
+
+	if (CHECK(!bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
+				   BPF_F_ALLOW_MULTI),
+		  "fail_same_prog_attach_to_cg1", "unexpected success\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog[1], cg1, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_MULTI),
+		  "prog1_attach_to_cg1_multi", "errno=%d\n", errno))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog[2], cg2, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_OVERRIDE),
+		  "prog2_attach_to_cg2_override", "errno=%d\n", errno))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog[3], cg3, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_MULTI),
+		  "prog3_attach_to_cg3_multi", "errno=%d\n", errno))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog[4], cg4, BPF_CGROUP_INET_EGRESS,
+			    BPF_F_ALLOW_OVERRIDE),
+		  "prog4_attach_to_cg4_override", "errno=%d\n", errno))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog[5], cg5, BPF_CGROUP_INET_EGRESS, 0),
+		  "prog5_attach_to_cg5_none", "errno=%d\n", errno))
+		goto err;
+
+	CHECK_FAIL(system(PING_CMD));
+	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
+	CHECK_FAIL(value != 1 + 2 + 8 + 32);
+
+	/* query the number of effective progs in cg5 */
+	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_QUERY_EFFECTIVE, NULL, NULL, &prog_cnt));
+	CHECK_FAIL(prog_cnt != 4);
+	/* retrieve prog_ids of effective progs in cg5 */
+	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_QUERY_EFFECTIVE, &attach_flags,
+				  prog_ids, &prog_cnt));
+	CHECK_FAIL(prog_cnt != 4);
+	CHECK_FAIL(attach_flags != 0);
+	saved_prog_id = prog_ids[0];
+	/* check enospc handling */
+	prog_ids[0] = 0;
+	prog_cnt = 2;
+	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_QUERY_EFFECTIVE, &attach_flags,
+				  prog_ids, &prog_cnt) != -1);
+	CHECK_FAIL(errno != ENOSPC);
+	CHECK_FAIL(prog_cnt != 4);
+	/* check that prog_ids are returned even when buffer is too small */
+	CHECK_FAIL(prog_ids[0] != saved_prog_id);
+	/* retrieve prog_id of single attached prog in cg5 */
+	prog_ids[0] = 0;
+	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, 0, NULL,
+				  prog_ids, &prog_cnt));
+	CHECK_FAIL(prog_cnt != 1);
+	CHECK_FAIL(prog_ids[0] != saved_prog_id);
+
+	/* detach bottom program and ping again */
+	if (CHECK(bpf_prog_detach2(-1, cg5, BPF_CGROUP_INET_EGRESS),
+		  "prog_detach_from_cg5", "errno=%d\n", errno))
+		goto err;
+
+	value = 0;
+	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
+	CHECK_FAIL(system(PING_CMD));
+	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
+	CHECK_FAIL(value != 1 + 2 + 8 + 16);
+
+	/* detach 3rd from bottom program and ping again */
+	if (CHECK(!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS),
+		  "fail_prog_detach_from_cg3", "unexpected success\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_detach2(allow_prog[3], cg3, BPF_CGROUP_INET_EGRESS),
+		  "prog3_detach_from_cg3", "errno=%d\n", errno))
+		goto err;
+
+	value = 0;
+	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
+	CHECK_FAIL(system(PING_CMD));
+	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
+	CHECK_FAIL(value != 1 + 2 + 16);
+
+	/* detach 2nd from bottom program and ping again */
+	if (CHECK(bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS),
+		  "prog_detach_from_cg4", "errno=%d\n", errno))
+		goto err;
+
+	value = 0;
+	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
+	CHECK_FAIL(system(PING_CMD));
+	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
+	CHECK_FAIL(value != 1 + 2 + 4);
+
+	prog_cnt = 4;
+	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_QUERY_EFFECTIVE, &attach_flags,
+				  prog_ids, &prog_cnt));
+	CHECK_FAIL(prog_cnt != 3);
+	CHECK_FAIL(attach_flags != 0);
+	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, 0, NULL,
+				  prog_ids, &prog_cnt));
+	CHECK_FAIL(prog_cnt != 0);
+
+err:
+	for (i = 0; i < ARRAY_SIZE(allow_prog); i++)
+		if (allow_prog[i] >= 0)
+			close(allow_prog[i]);
+	close(cg1);
+	close(cg2);
+	close(cg3);
+	close(cg4);
+	close(cg5);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
new file mode 100644
index 000000000000..9d8cb48b99de
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "cgroup_helpers.h"
+
+#define FOO		"/foo"
+#define BAR		"/foo/bar/"
+#define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
+
+char bpf_log_buf[BPF_LOG_BUF_SIZE];
+
+static int prog_load(int verdict)
+{
+	struct bpf_insn prog[] = {
+		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
+		BPF_EXIT_INSN(),
+	};
+	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+
+	return bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+			       prog, insns_cnt, "GPL", 0,
+			       bpf_log_buf, BPF_LOG_BUF_SIZE);
+}
+
+void test_cgroup_attach_override(void)
+{
+	int drop_prog = -1, allow_prog = -1, foo = -1, bar = -1;
+	__u32 duration = 0;
+
+	allow_prog = prog_load(1);
+	if (CHECK(allow_prog < 0, "prog_load_allow",
+		  "verifier output:\n%s\n-------\n", bpf_log_buf))
+		goto err;
+
+	drop_prog = prog_load(0);
+	if (CHECK(drop_prog < 0, "prog_load_drop",
+		  "verifier output:\n%s\n-------\n", bpf_log_buf))
+		goto err;
+
+	foo = test__join_cgroup(FOO);
+	if (CHECK(foo < 0, "cgroup_join_foo", "cgroup setup failed\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(drop_prog, foo, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_OVERRIDE),
+		  "prog_attach_drop_foo_override",
+		  "attach prog to %s failed, errno=%d\n", FOO, errno))
+		goto err;
+
+	if (CHECK(!system(PING_CMD), "ping_fail",
+		  "ping unexpectedly succeeded\n"))
+		goto err;
+
+	bar = test__join_cgroup(BAR);
+	if (CHECK(bar < 0, "cgroup_join_bar", "cgroup setup failed\n"))
+		goto err;
+
+	if (CHECK(!system(PING_CMD), "ping_fail",
+		  "ping unexpectedly succeeded\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_OVERRIDE),
+		  "prog_attach_allow_bar_override",
+		  "attach prog to %s failed, errno=%d\n", BAR, errno))
+		goto err;
+
+	if (CHECK(system(PING_CMD), "ping_ok", "ping failed\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_detach(bar, BPF_CGROUP_INET_EGRESS),
+		  "prog_detach_bar",
+		  "detach prog from %s failed, errno=%d\n", BAR, errno))
+		goto err;
+
+	if (CHECK(!system(PING_CMD), "ping_fail",
+		  "ping unexpectedly succeeded\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_OVERRIDE),
+		  "prog_attach_allow_bar_override",
+		  "attach prog to %s failed, errno=%d\n", BAR, errno))
+		goto err;
+
+	if (CHECK(bpf_prog_detach(foo, BPF_CGROUP_INET_EGRESS),
+		  "prog_detach_foo",
+		  "detach prog from %s failed, errno=%d\n", FOO, errno))
+		goto err;
+
+	if (CHECK(system(PING_CMD), "ping_ok", "ping failed\n"))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
+				  BPF_F_ALLOW_OVERRIDE),
+		  "prog_attach_allow_bar_override",
+		  "attach prog to %s failed, errno=%d\n", BAR, errno))
+		goto err;
+
+	if (CHECK(!bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS, 0),
+		  "fail_prog_attach_allow_bar_none",
+		  "attach prog to %s unexpectedly succeeded\n", BAR))
+		goto err;
+
+	if (CHECK(bpf_prog_detach(bar, BPF_CGROUP_INET_EGRESS),
+		  "prog_detach_bar",
+		  "detach prog from %s failed, errno=%d\n", BAR, errno))
+		goto err;
+
+	if (CHECK(!bpf_prog_detach(foo, BPF_CGROUP_INET_EGRESS),
+		  "fail_prog_detach_foo",
+		  "double detach from %s unexpectedly succeeded\n", FOO))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(allow_prog, foo, BPF_CGROUP_INET_EGRESS, 0),
+		  "prog_attach_allow_foo_none",
+		  "attach prog to %s failed, errno=%d\n", FOO, errno))
+		goto err;
+
+	if (CHECK(!bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS, 0),
+		  "fail_prog_attach_allow_bar_none",
+		  "attach prog to %s unexpectedly succeeded\n", BAR))
+		goto err;
+
+	if (CHECK(!bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
+				   BPF_F_ALLOW_OVERRIDE),
+		  "fail_prog_attach_allow_bar_override",
+		  "attach prog to %s unexpectedly succeeded\n", BAR))
+		goto err;
+
+	if (CHECK(!bpf_prog_attach(allow_prog, foo, BPF_CGROUP_INET_EGRESS,
+				   BPF_F_ALLOW_OVERRIDE),
+		  "fail_prog_attach_allow_foo_override",
+		  "attach prog to %s unexpectedly succeeded\n", FOO))
+		goto err;
+
+	if (CHECK(bpf_prog_attach(drop_prog, foo, BPF_CGROUP_INET_EGRESS, 0),
+		  "prog_attach_drop_foo_none",
+		  "attach prog to %s failed, errno=%d\n", FOO, errno))
+		goto err;
+
+err:
+	close(foo);
+	close(bar);
+	close(allow_prog);
+	close(drop_prog);
+}
diff --git a/tools/testing/selftests/bpf/test_cgroup_attach.c b/tools/testing/selftests/bpf/test_cgroup_attach.c
deleted file mode 100644
index 7671909ee1cb..000000000000
--- a/tools/testing/selftests/bpf/test_cgroup_attach.c
+++ /dev/null
@@ -1,571 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/* eBPF example program:
- *
- * - Creates arraymap in kernel with 4 bytes keys and 8 byte values
- *
- * - Loads eBPF program
- *
- *   The eBPF program accesses the map passed in to store two pieces of
- *   information. The number of invocations of the program, which maps
- *   to the number of packets received, is stored to key 0. Key 1 is
- *   incremented on each iteration by the number of bytes stored in
- *   the skb. The program also stores the number of received bytes
- *   in the cgroup storage.
- *
- * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
- *
- * - Every second, reads map[0] and map[1] to see how many bytes and
- *   packets were seen on any socket of tasks in the given cgroup.
- */
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <assert.h>
-#include <sys/resource.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <linux/filter.h>
-
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-
-#include "bpf_util.h"
-#include "bpf_rlimit.h"
-#include "cgroup_helpers.h"
-
-#define FOO		"/foo"
-#define BAR		"/foo/bar/"
-#define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
-#ifdef DEBUG
-#define debug(args...) printf(args)
-#else
-#define debug(args...)
-#endif
-
-static int prog_load(int verdict)
-{
-	int ret;
-	struct bpf_insn prog[] = {
-		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
-		BPF_EXIT_INSN(),
-	};
-	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
-
-	ret = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
-			       prog, insns_cnt, "GPL", 0,
-			       bpf_log_buf, BPF_LOG_BUF_SIZE);
-
-	if (ret < 0) {
-		log_err("Loading program");
-		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
-		return 0;
-	}
-	return ret;
-}
-
-static int test_foo_bar(void)
-{
-	int drop_prog, allow_prog, foo = 0, bar = 0, rc = 0;
-
-	allow_prog = prog_load(1);
-	if (!allow_prog)
-		goto err;
-
-	drop_prog = prog_load(0);
-	if (!drop_prog)
-		goto err;
-
-	if (setup_cgroup_environment())
-		goto err;
-
-	/* Create cgroup /foo, get fd, and join it */
-	foo = create_and_get_cgroup(FOO);
-	if (foo < 0)
-		goto err;
-
-	if (join_cgroup(FOO))
-		goto err;
-
-	if (bpf_prog_attach(drop_prog, foo, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_OVERRIDE)) {
-		log_err("Attaching prog to /foo");
-		goto err;
-	}
-
-	debug("Attached DROP prog. This ping in cgroup /foo should fail...\n");
-	assert(system(PING_CMD) != 0);
-
-	/* Create cgroup /foo/bar, get fd, and join it */
-	bar = create_and_get_cgroup(BAR);
-	if (bar < 0)
-		goto err;
-
-	if (join_cgroup(BAR))
-		goto err;
-
-	debug("Attached DROP prog. This ping in cgroup /foo/bar should fail...\n");
-	assert(system(PING_CMD) != 0);
-
-	if (bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_OVERRIDE)) {
-		log_err("Attaching prog to /foo/bar");
-		goto err;
-	}
-
-	debug("Attached PASS prog. This ping in cgroup /foo/bar should pass...\n");
-	assert(system(PING_CMD) == 0);
-
-	if (bpf_prog_detach(bar, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Detaching program from /foo/bar");
-		goto err;
-	}
-
-	debug("Detached PASS from /foo/bar while DROP is attached to /foo.\n"
-	       "This ping in cgroup /foo/bar should fail...\n");
-	assert(system(PING_CMD) != 0);
-
-	if (bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_OVERRIDE)) {
-		log_err("Attaching prog to /foo/bar");
-		goto err;
-	}
-
-	if (bpf_prog_detach(foo, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Detaching program from /foo");
-		goto err;
-	}
-
-	debug("Attached PASS from /foo/bar and detached DROP from /foo.\n"
-	       "This ping in cgroup /foo/bar should pass...\n");
-	assert(system(PING_CMD) == 0);
-
-	if (bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_OVERRIDE)) {
-		log_err("Attaching prog to /foo/bar");
-		goto err;
-	}
-
-	if (!bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS, 0)) {
-		errno = 0;
-		log_err("Unexpected success attaching prog to /foo/bar");
-		goto err;
-	}
-
-	if (bpf_prog_detach(bar, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Detaching program from /foo/bar");
-		goto err;
-	}
-
-	if (!bpf_prog_detach(foo, BPF_CGROUP_INET_EGRESS)) {
-		errno = 0;
-		log_err("Unexpected success in double detach from /foo");
-		goto err;
-	}
-
-	if (bpf_prog_attach(allow_prog, foo, BPF_CGROUP_INET_EGRESS, 0)) {
-		log_err("Attaching non-overridable prog to /foo");
-		goto err;
-	}
-
-	if (!bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS, 0)) {
-		errno = 0;
-		log_err("Unexpected success attaching non-overridable prog to /foo/bar");
-		goto err;
-	}
-
-	if (!bpf_prog_attach(allow_prog, bar, BPF_CGROUP_INET_EGRESS,
-			     BPF_F_ALLOW_OVERRIDE)) {
-		errno = 0;
-		log_err("Unexpected success attaching overridable prog to /foo/bar");
-		goto err;
-	}
-
-	if (!bpf_prog_attach(allow_prog, foo, BPF_CGROUP_INET_EGRESS,
-			     BPF_F_ALLOW_OVERRIDE)) {
-		errno = 0;
-		log_err("Unexpected success attaching overridable prog to /foo");
-		goto err;
-	}
-
-	if (bpf_prog_attach(drop_prog, foo, BPF_CGROUP_INET_EGRESS, 0)) {
-		log_err("Attaching different non-overridable prog to /foo");
-		goto err;
-	}
-
-	goto out;
-
-err:
-	rc = 1;
-
-out:
-	close(foo);
-	close(bar);
-	cleanup_cgroup_environment();
-	if (!rc)
-		printf("#override:PASS\n");
-	else
-		printf("#override:FAIL\n");
-	return rc;
-}
-
-static int map_fd = -1;
-
-static int prog_load_cnt(int verdict, int val)
-{
-	int cgroup_storage_fd, percpu_cgroup_storage_fd;
-
-	if (map_fd < 0)
-		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
-	if (map_fd < 0) {
-		printf("failed to create map '%s'\n", strerror(errno));
-		return -1;
-	}
-
-	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
-				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
-	if (cgroup_storage_fd < 0) {
-		printf("failed to create map '%s'\n", strerror(errno));
-		return -1;
-	}
-
-	percpu_cgroup_storage_fd = bpf_create_map(
-		BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
-		sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
-	if (percpu_cgroup_storage_fd < 0) {
-		printf("failed to create map '%s'\n", strerror(errno));
-		return -1;
-	}
-
-	struct bpf_insn prog[] = {
-		BPF_MOV32_IMM(BPF_REG_0, 0),
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
-		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
-
-		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
-		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-		BPF_MOV64_IMM(BPF_REG_1, val),
-		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
-
-		BPF_LD_MAP_FD(BPF_REG_1, percpu_cgroup_storage_fd),
-		BPF_MOV64_IMM(BPF_REG_2, 0),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
-		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
-
-		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
-		BPF_EXIT_INSN(),
-	};
-	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
-	int ret;
-
-	ret = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
-			       prog, insns_cnt, "GPL", 0,
-			       bpf_log_buf, BPF_LOG_BUF_SIZE);
-
-	if (ret < 0) {
-		log_err("Loading program");
-		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
-		return 0;
-	}
-	close(cgroup_storage_fd);
-	return ret;
-}
-
-
-static int test_multiprog(void)
-{
-	__u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
-	int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
-	int drop_prog, allow_prog[6] = {}, rc = 0;
-	unsigned long long value;
-	int i = 0;
-
-	for (i = 0; i < 6; i++) {
-		allow_prog[i] = prog_load_cnt(1, 1 << i);
-		if (!allow_prog[i])
-			goto err;
-	}
-	drop_prog = prog_load_cnt(0, 1);
-	if (!drop_prog)
-		goto err;
-
-	if (setup_cgroup_environment())
-		goto err;
-
-	cg1 = create_and_get_cgroup("/cg1");
-	if (cg1 < 0)
-		goto err;
-	cg2 = create_and_get_cgroup("/cg1/cg2");
-	if (cg2 < 0)
-		goto err;
-	cg3 = create_and_get_cgroup("/cg1/cg2/cg3");
-	if (cg3 < 0)
-		goto err;
-	cg4 = create_and_get_cgroup("/cg1/cg2/cg3/cg4");
-	if (cg4 < 0)
-		goto err;
-	cg5 = create_and_get_cgroup("/cg1/cg2/cg3/cg4/cg5");
-	if (cg5 < 0)
-		goto err;
-
-	if (join_cgroup("/cg1/cg2/cg3/cg4/cg5"))
-		goto err;
-
-	if (bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_MULTI)) {
-		log_err("Attaching prog to cg1");
-		goto err;
-	}
-	if (!bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
-			     BPF_F_ALLOW_MULTI)) {
-		log_err("Unexpected success attaching the same prog to cg1");
-		goto err;
-	}
-	if (bpf_prog_attach(allow_prog[1], cg1, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_MULTI)) {
-		log_err("Attaching prog2 to cg1");
-		goto err;
-	}
-	if (bpf_prog_attach(allow_prog[2], cg2, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_OVERRIDE)) {
-		log_err("Attaching prog to cg2");
-		goto err;
-	}
-	if (bpf_prog_attach(allow_prog[3], cg3, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_MULTI)) {
-		log_err("Attaching prog to cg3");
-		goto err;
-	}
-	if (bpf_prog_attach(allow_prog[4], cg4, BPF_CGROUP_INET_EGRESS,
-			    BPF_F_ALLOW_OVERRIDE)) {
-		log_err("Attaching prog to cg4");
-		goto err;
-	}
-	if (bpf_prog_attach(allow_prog[5], cg5, BPF_CGROUP_INET_EGRESS, 0)) {
-		log_err("Attaching prog to cg5");
-		goto err;
-	}
-	assert(system(PING_CMD) == 0);
-	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
-	assert(value == 1 + 2 + 8 + 32);
-
-	/* query the number of effective progs in cg5 */
-	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, BPF_F_QUERY_EFFECTIVE,
-			      NULL, NULL, &prog_cnt) == 0);
-	assert(prog_cnt == 4);
-	/* retrieve prog_ids of effective progs in cg5 */
-	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, BPF_F_QUERY_EFFECTIVE,
-			      &attach_flags, prog_ids, &prog_cnt) == 0);
-	assert(prog_cnt == 4);
-	assert(attach_flags == 0);
-	saved_prog_id = prog_ids[0];
-	/* check enospc handling */
-	prog_ids[0] = 0;
-	prog_cnt = 2;
-	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, BPF_F_QUERY_EFFECTIVE,
-			      &attach_flags, prog_ids, &prog_cnt) == -1 &&
-	       errno == ENOSPC);
-	assert(prog_cnt == 4);
-	/* check that prog_ids are returned even when buffer is too small */
-	assert(prog_ids[0] == saved_prog_id);
-	/* retrieve prog_id of single attached prog in cg5 */
-	prog_ids[0] = 0;
-	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, 0,
-			      NULL, prog_ids, &prog_cnt) == 0);
-	assert(prog_cnt == 1);
-	assert(prog_ids[0] == saved_prog_id);
-
-	/* detach bottom program and ping again */
-	if (bpf_prog_detach2(-1, cg5, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Detaching prog from cg5");
-		goto err;
-	}
-	value = 0;
-	assert(bpf_map_update_elem(map_fd, &key, &value, 0) == 0);
-	assert(system(PING_CMD) == 0);
-	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
-	assert(value == 1 + 2 + 8 + 16);
-
-	/* detach 3rd from bottom program and ping again */
-	errno = 0;
-	if (!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Unexpected success on detach from cg3");
-		goto err;
-	}
-	if (bpf_prog_detach2(allow_prog[3], cg3, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Detaching from cg3");
-		goto err;
-	}
-	value = 0;
-	assert(bpf_map_update_elem(map_fd, &key, &value, 0) == 0);
-	assert(system(PING_CMD) == 0);
-	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
-	assert(value == 1 + 2 + 16);
-
-	/* detach 2nd from bottom program and ping again */
-	if (bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS)) {
-		log_err("Detaching prog from cg4");
-		goto err;
-	}
-	value = 0;
-	assert(bpf_map_update_elem(map_fd, &key, &value, 0) == 0);
-	assert(system(PING_CMD) == 0);
-	assert(bpf_map_lookup_elem(map_fd, &key, &value) == 0);
-	assert(value == 1 + 2 + 4);
-
-	prog_cnt = 4;
-	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, BPF_F_QUERY_EFFECTIVE,
-			      &attach_flags, prog_ids, &prog_cnt) == 0);
-	assert(prog_cnt == 3);
-	assert(attach_flags == 0);
-	assert(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS, 0,
-			      NULL, prog_ids, &prog_cnt) == 0);
-	assert(prog_cnt == 0);
-	goto out;
-err:
-	rc = 1;
-
-out:
-	for (i = 0; i < 6; i++)
-		if (allow_prog[i] > 0)
-			close(allow_prog[i]);
-	close(cg1);
-	close(cg2);
-	close(cg3);
-	close(cg4);
-	close(cg5);
-	cleanup_cgroup_environment();
-	if (!rc)
-		printf("#multi:PASS\n");
-	else
-		printf("#multi:FAIL\n");
-	return rc;
-}
-
-static int test_autodetach(void)
-{
-	__u32 prog_cnt = 4, attach_flags;
-	int allow_prog[2] = {0};
-	__u32 prog_ids[2] = {0};
-	int cg = 0, i, rc = -1;
-	void *ptr = NULL;
-	int attempts;
-
-	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
-		allow_prog[i] = prog_load_cnt(1, 1 << i);
-		if (!allow_prog[i])
-			goto err;
-	}
-
-	if (setup_cgroup_environment())
-		goto err;
-
-	/* create a cgroup, attach two programs and remember their ids */
-	cg = create_and_get_cgroup("/cg_autodetach");
-	if (cg < 0)
-		goto err;
-
-	if (join_cgroup("/cg_autodetach"))
-		goto err;
-
-	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
-		if (bpf_prog_attach(allow_prog[i], cg, BPF_CGROUP_INET_EGRESS,
-				    BPF_F_ALLOW_MULTI)) {
-			log_err("Attaching prog[%d] to cg:egress", i);
-			goto err;
-		}
-	}
-
-	/* make sure that programs are attached and run some traffic */
-	assert(bpf_prog_query(cg, BPF_CGROUP_INET_EGRESS, 0, &attach_flags,
-			      prog_ids, &prog_cnt) == 0);
-	assert(system(PING_CMD) == 0);
-
-	/* allocate some memory (4Mb) to pin the original cgroup */
-	ptr = malloc(4 * (1 << 20));
-	if (!ptr)
-		goto err;
-
-	/* close programs and cgroup fd */
-	for (i = 0; i < ARRAY_SIZE(allow_prog); i++) {
-		close(allow_prog[i]);
-		allow_prog[i] = 0;
-	}
-
-	close(cg);
-	cg = 0;
-
-	/* leave the cgroup and remove it. don't detach programs */
-	cleanup_cgroup_environment();
-
-	/* wait for the asynchronous auto-detachment.
-	 * wait for no more than 5 sec and give up.
-	 */
-	for (i = 0; i < ARRAY_SIZE(prog_ids); i++) {
-		for (attempts = 5; attempts >= 0; attempts--) {
-			int fd = bpf_prog_get_fd_by_id(prog_ids[i]);
-
-			if (fd < 0)
-				break;
-
-			/* don't leave the fd open */
-			close(fd);
-
-			if (!attempts)
-				goto err;
-
-			sleep(1);
-		}
-	}
-
-	rc = 0;
-err:
-	for (i = 0; i < ARRAY_SIZE(allow_prog); i++)
-		if (allow_prog[i] > 0)
-			close(allow_prog[i]);
-	if (cg)
-		close(cg);
-	free(ptr);
-	cleanup_cgroup_environment();
-	if (!rc)
-		printf("#autodetach:PASS\n");
-	else
-		printf("#autodetach:FAIL\n");
-	return rc;
-}
-
-int main(void)
-{
-	int (*tests[])(void) = {
-		test_foo_bar,
-		test_multiprog,
-		test_autodetach,
-	};
-	int errors = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++)
-		if (tests[i]())
-			errors++;
-
-	if (errors)
-		printf("test_cgroup_attach:FAIL\n");
-	else
-		printf("test_cgroup_attach:PASS\n");
-
-	return errors ? EXIT_FAILURE : EXIT_SUCCESS;
-}
-- 
2.17.1

