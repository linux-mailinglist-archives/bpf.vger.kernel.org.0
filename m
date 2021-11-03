Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59E2444AB4
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhKCWLw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 18:11:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59776 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhKCWLv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 18:11:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3KAdjk008204
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 15:09:13 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3veb36sr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 15:09:13 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 15:09:09 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 287BE7D65E68; Wed,  3 Nov 2021 15:09:08 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 10/12] selftests/bpf: merge test_stub.c into testing_helpers.c
Date:   Wed, 3 Nov 2021 15:08:43 -0700
Message-ID: <20211103220845.2676888-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103220845.2676888-1-andrii@kernel.org>
References: <20211103220845.2676888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: mOj3Y7dwLXv6mrUCLbr1cRObYvK9SyVC
X-Proofpoint-GUID: mOj3Y7dwLXv6mrUCLbr1cRObYvK9SyVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move testing prog and object load wrappers (bpf_prog_test_load and
bpf_test_load_program) into testing_helpers.{c,h} and get rid of
otherwise useless test_stub.c. Make testing_helpers.c available to
non-test_progs binaries as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          | 33 +++++------
 tools/testing/selftests/bpf/test_stub.c       | 44 ---------------
 tools/testing/selftests/bpf/testing_helpers.c | 55 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  6 ++
 4 files changed, 78 insertions(+), 60 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/test_stub.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c4497a4af3fe..5588c622d266 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -178,10 +178,6 @@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_tes
 	$(Q)$(MAKE) $(submake_extras) -C bpf_testmod
 	$(Q)cp bpf_testmod/bpf_testmod.ko $@
 
-$(OUTPUT)/test_stub.o: test_stub.c $(BPFOBJ)
-	$(call msg,CC,,$@)
-	$(Q)$(CC) -c $(CFLAGS) -o $@ $<
-
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 
 $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
@@ -194,18 +190,23 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 
 TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
 
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BPFOBJ)
-
-$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c
-$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c
-$(OUTPUT)/test_sock: cgroup_helpers.c
-$(OUTPUT)/test_sock_addr: cgroup_helpers.c
-$(OUTPUT)/test_sockmap: cgroup_helpers.c
-$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c
-$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
-$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
-$(OUTPUT)/test_sock_fields: cgroup_helpers.c
-$(OUTPUT)/test_sysctl: cgroup_helpers.c
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
+
+$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_sock: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_sock_addr: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_sockmap: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c testing_helpers.o
+$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_sock_fields: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_sysctl: cgroup_helpers.c testing_helpers.o
+$(OUTPUT)/test_tag: testing_helpers.o
+$(OUTPUT)/test_lirc_mode2_user: testing_helpers.o
+$(OUTPUT)/xdping: testing_helpers.o
+$(OUTPUT)/flow_dissector_load: testing_helpers.o
+$(OUTPUT)/test_maps: testing_helpers.o
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
diff --git a/tools/testing/selftests/bpf/test_stub.c b/tools/testing/selftests/bpf/test_stub.c
deleted file mode 100644
index 47e132726203..000000000000
--- a/tools/testing/selftests/bpf/test_stub.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-/* Copyright (C) 2019 Netronome Systems, Inc. */
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include <string.h>
-
-int extra_prog_load_log_flags = 0;
-
-int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
-		       struct bpf_object **pobj, int *prog_fd)
-{
-	struct bpf_prog_load_attr attr;
-
-	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
-	attr.file = file;
-	attr.prog_type = type;
-	attr.expected_attach_type = 0;
-	attr.prog_flags = BPF_F_TEST_RND_HI32;
-	attr.log_level = extra_prog_load_log_flags;
-
-	return bpf_prog_load_xattr(&attr, pobj, prog_fd);
-}
-
-int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
-			  size_t insns_cnt, const char *license,
-			  __u32 kern_version, char *log_buf,
-		     size_t log_buf_sz)
-{
-	struct bpf_load_program_attr load_attr;
-
-	memset(&load_attr, 0, sizeof(struct bpf_load_program_attr));
-	load_attr.prog_type = type;
-	load_attr.expected_attach_type = 0;
-	load_attr.name = NULL;
-	load_attr.insns = insns;
-	load_attr.insns_cnt = insns_cnt;
-	load_attr.license = license;
-	load_attr.kern_version = kern_version;
-	load_attr.prog_flags = BPF_F_TEST_RND_HI32;
-	load_attr.log_level = extra_prog_load_log_flags;
-
-	return bpf_load_program_xattr(&load_attr, log_buf, log_buf_sz);
-}
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 800d503e5cb4..ef61d43adfe4 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (C) 2019 Netronome Systems, Inc. */
 /* Copyright (C) 2020 Facebook, Inc. */
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 #include "testing_helpers.h"
 
 int parse_num_list(const char *s, bool **num_set, int *num_set_len)
@@ -78,3 +82,54 @@ __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
 	}
 	return info->prog_id;
 }
+
+int extra_prog_load_log_flags = 0;
+
+int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
+		       struct bpf_object **pobj, int *prog_fd)
+{
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	int err;
+
+	obj = bpf_object__open(file);
+	if (!obj)
+		return -errno;
+
+	prog = bpf_object__next_program(obj, NULL);
+	if (!prog) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	if (type != BPF_PROG_TYPE_UNSPEC)
+		bpf_program__set_type(prog, type);
+
+	err = bpf_object__load(obj);
+	if (err)
+		goto err_out;
+
+	*pobj = obj;
+	*prog_fd = bpf_program__fd(prog);
+
+	return 0;
+err_out:
+	bpf_object__close(obj);
+	return err;
+}
+
+int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
+			  size_t insns_cnt, const char *license,
+			  __u32 kern_version, char *log_buf,
+			  size_t log_buf_sz)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.kern_version = kern_version,
+		.prog_flags = BPF_F_TEST_RND_HI32,
+		.log_level = extra_prog_load_log_flags,
+		.log_buf = log_buf,
+		.log_size = log_buf_sz,
+	);
+
+	return bpf_prog_load(type, NULL, license, insns, insns_cnt, &opts);
+}
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d4f8e749611b..f46ebc476ee8 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -6,3 +6,9 @@
 
 int parse_num_list(const char *s, bool **set, int *set_len);
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info);
+int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
+		       struct bpf_object **pobj, int *prog_fd);
+int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
+			  size_t insns_cnt, const char *license,
+			  __u32 kern_version, char *log_buf,
+			  size_t log_buf_sz);
-- 
2.30.2

