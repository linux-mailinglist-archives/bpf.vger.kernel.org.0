Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B5440791
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhJ3FCp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20772 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231635AbhJ3FCp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:45 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U4jhPA019970
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0ya801dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:15 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 22:00:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1B44C78305B0; Fri, 29 Oct 2021 22:00:12 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 14/14] selftests/bpf: use explicit bpf_test_load_program() helper calls
Date:   Fri, 29 Oct 2021 21:59:41 -0700
Message-ID: <20211030045941.3514948-15-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: EIUuZC5jx1S5ETF-hm761uWQqgqhYXnI
X-Proofpoint-ORIG-GUID: EIUuZC5jx1S5ETF-hm761uWQqgqhYXnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the second part of prog loading testing helper re-definition:

  -Dbpf_load_program=bpf_test_load_program

This completes the clean up of deprecated libbpf program loading APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                          | 3 +--
 .../selftests/bpf/prog_tests/cgroup_attach_autodetach.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c  | 2 +-
 .../testing/selftests/bpf/prog_tests/cgroup_attach_override.c | 2 +-
 .../selftests/bpf/prog_tests/flow_dissector_load_bytes.c      | 2 +-
 .../selftests/bpf/prog_tests/flow_dissector_reattach.c        | 4 ++--
 tools/testing/selftests/bpf/prog_tests/signal_pending.c       | 2 +-
 tools/testing/selftests/bpf/test_cgroup_storage.c             | 3 ++-
 tools/testing/selftests/bpf/test_tag.c                        | 3 ++-
 9 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 84958884eeac..cd9dbc1fa592 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -23,8 +23,7 @@ BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
 CFLAGS += -g -O0 -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)		\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
-	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)			\
-	  -Dbpf_load_program=bpf_test_load_program
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
 LDLIBS += -lcap -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
index 5de485c7370f..858916d11e2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
@@ -16,7 +16,7 @@ static int prog_load(void)
 	};
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
 
-	return bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+	return bpf_test_load_program(BPF_PROG_TYPE_CGROUP_SKB,
 			       prog, insns_cnt, "GPL", 0,
 			       bpf_log_buf, BPF_LOG_BUF_SIZE);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index 731bea84d8ed..de9c3e12b0ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -66,7 +66,7 @@ static int prog_load_cnt(int verdict, int val)
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
 	int ret;
 
-	ret = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+	ret = bpf_test_load_program(BPF_PROG_TYPE_CGROUP_SKB,
 			       prog, insns_cnt, "GPL", 0,
 			       bpf_log_buf, BPF_LOG_BUF_SIZE);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
index 10d3c33821a7..356547e849e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
@@ -18,7 +18,7 @@ static int prog_load(int verdict)
 	};
 	size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
 
-	return bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+	return bpf_test_load_program(BPF_PROG_TYPE_CGROUP_SKB,
 			       prog, insns_cnt, "GPL", 0,
 			       bpf_log_buf, BPF_LOG_BUF_SIZE);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
index 6093728497c7..93ac3f28226c 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -30,7 +30,7 @@ void serial_test_flow_dissector_load_bytes(void)
 
 	/* make sure bpf_skb_load_bytes is not allowed from skb-less context
 	 */
-	fd = bpf_load_program(BPF_PROG_TYPE_FLOW_DISSECTOR, prog,
+	fd = bpf_test_load_program(BPF_PROG_TYPE_FLOW_DISSECTOR, prog,
 			      ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
 	CHECK(fd < 0,
 	      "flow_dissector-bpf_skb_load_bytes-load",
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
index f0c6c226aba8..7c79462d2702 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_reattach.c
@@ -47,9 +47,9 @@ static int load_prog(enum bpf_prog_type type)
 	};
 	int fd;
 
-	fd = bpf_load_program(type, prog, ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
+	fd = bpf_test_load_program(type, prog, ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
 	if (CHECK_FAIL(fd < 0))
-		perror("bpf_load_program");
+		perror("bpf_test_load_program");
 
 	return fd;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
index fdfdcff6cbef..aecfe662c070 100644
--- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -22,7 +22,7 @@ static void test_signal_pending_by_type(enum bpf_prog_type prog_type)
 		prog[i] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
 	prog[ARRAY_SIZE(prog) - 1] = BPF_EXIT_INSN();
 
-	prog_fd = bpf_load_program(prog_type, prog, ARRAY_SIZE(prog),
+	prog_fd = bpf_test_load_program(prog_type, prog, ARRAY_SIZE(prog),
 				   "GPL", 0, NULL, 0);
 	CHECK(prog_fd < 0, "test-run", "errno %d\n", errno);
 
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index 0cda61da5d39..a63787e7bb1a 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -8,6 +8,7 @@
 
 #include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
+#include "testing_helpers.h"
 
 char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
@@ -66,7 +67,7 @@ int main(int argc, char **argv)
 
 	prog[0].imm = percpu_map_fd;
 	prog[7].imm = map_fd;
-	prog_fd = bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
+	prog_fd = bpf_test_load_program(BPF_PROG_TYPE_CGROUP_SKB,
 				   prog, insns_cnt, "GPL", 0,
 				   bpf_log_buf, BPF_LOG_BUF_SIZE);
 	if (prog_fd < 0) {
diff --git a/tools/testing/selftests/bpf/test_tag.c b/tools/testing/selftests/bpf/test_tag.c
index 6272c784ca2a..5c7bea525626 100644
--- a/tools/testing/selftests/bpf/test_tag.c
+++ b/tools/testing/selftests/bpf/test_tag.c
@@ -21,6 +21,7 @@
 
 #include "../../../include/linux/filter.h"
 #include "bpf_rlimit.h"
+#include "testing_helpers.h"
 
 static struct bpf_insn prog[BPF_MAXINSNS];
 
@@ -57,7 +58,7 @@ static int bpf_try_load_prog(int insns, int fd_map,
 	int fd_prog;
 
 	bpf_filler(insns, fd_map);
-	fd_prog = bpf_load_program(BPF_PROG_TYPE_SCHED_CLS, prog, insns, "", 0,
+	fd_prog = bpf_test_load_program(BPF_PROG_TYPE_SCHED_CLS, prog, insns, "", 0,
 				   NULL, 0);
 	assert(fd_prog > 0);
 	if (fd_map > 0)
-- 
2.30.2

