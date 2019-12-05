Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81077113918
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 02:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfLEBGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 20:06:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbfLEBGL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Dec 2019 20:06:11 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB513IKs017880
        for <bpf@vger.kernel.org>; Wed, 4 Dec 2019 17:06:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=WmStbwLDdUX/4KqwpoY680gl8gr+JUcHY40J1/vitpM=;
 b=ZXSVSLH00SpAN214BX97qG8Du2w/biL3es66PWtfphTh3II7Scz16WfDCKeSMTc7MGap
 ON3T6knFBNTu5i1TqGQU40nKljkJ/fEmYK7OkDmYD8eou/PYfM75njEbP97mviqtZ9tD
 RlpkHm+zVBpsNVZnZPpObPQntRodtsSjyn4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wpd7gujc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 17:06:09 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 4 Dec 2019 17:06:08 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D931C3702A5C; Wed,  4 Dec 2019 17:06:07 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 2/2] selftests/bpf: add a fexit/bpf2bpf test with target bpf prog no callees
Date:   Wed, 4 Dec 2019 17:06:07 -0800
Message-ID: <20191205010607.177904-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205010606.177712-1-yhs@fb.com>
References: <20191205010606.177712-1-yhs@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_04:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=590
 suspectscore=38 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050001
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The existing fexit_bpf2bpf test covers the target progrm with callees.
This patch added a test for the target program without callees.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 70 ++++++++++++++-----
 .../bpf/progs/fexit_bpf2bpf_simple.c          | 26 +++++++
 .../selftests/bpf/progs/test_pkt_md_access.c  |  4 +-
 3 files changed, 81 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_bpf2bpf_simple.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 15c7378362dd..5dd37c37b29a 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -2,25 +2,21 @@
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
 
-#define PROG_CNT 3
-
-void test_fexit_bpf2bpf(void)
+static void test_fexit_bpf2bpf_common(const char *obj_file,
+				      const char *target_obj_file,
+				      int prog_cnt,
+				      const char **prog_name)
 {
-	const char *prog_name[PROG_CNT] = {
-		"fexit/test_pkt_access",
-		"fexit/test_pkt_access_subprog1",
-		"fexit/test_pkt_access_subprog2",
-	};
 	struct bpf_object *obj = NULL, *pkt_obj;
 	int err, pkt_fd, i;
-	struct bpf_link *link[PROG_CNT] = {};
-	struct bpf_program *prog[PROG_CNT];
+	struct bpf_link **link = NULL;
+	struct bpf_program **prog = NULL;
 	__u32 duration, retval;
 	struct bpf_map *data_map;
 	const int zero = 0;
-	u64 result[PROG_CNT];
+	u64 *result = NULL;
 
-	err = bpf_prog_load("./test_pkt_access.o", BPF_PROG_TYPE_UNSPEC,
+	err = bpf_prog_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &pkt_obj, &pkt_fd);
 	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
 		return;
@@ -28,7 +24,7 @@ void test_fexit_bpf2bpf(void)
 			    .attach_prog_fd = pkt_fd,
 			   );
 
-	obj = bpf_object__open_file("./fexit_bpf2bpf.o", &opts);
+	obj = bpf_object__open_file(obj_file, &opts);
 	if (CHECK(IS_ERR_OR_NULL(obj), "obj_open",
 		  "failed to open fexit_bpf2bpf: %ld\n",
 		  PTR_ERR(obj)))
@@ -38,7 +34,14 @@ void test_fexit_bpf2bpf(void)
 	if (CHECK(err, "obj_load", "err %d\n", err))
 		goto close_prog;
 
-	for (i = 0; i < PROG_CNT; i++) {
+	link = calloc(sizeof(struct bpf_link *), prog_cnt);
+	prog = calloc(sizeof(struct bpf_program *), prog_cnt);
+	result = malloc(prog_cnt * sizeof(u64));
+	if (CHECK(!link || !prog || !result, "alloc_memory",
+		  "failed to alloc memory"))
+		goto close_prog;
+
+	for (i = 0; i < prog_cnt; i++) {
 		prog[i] = bpf_object__find_program_by_title(obj, prog_name[i]);
 		if (CHECK(!prog[i], "find_prog", "prog %s not found\n", prog_name[i]))
 			goto close_prog;
@@ -56,21 +59,54 @@ void test_fexit_bpf2bpf(void)
 	      "err %d errno %d retval %d duration %d\n",
 	      err, errno, retval, duration);
 
-	err = bpf_map_lookup_elem(bpf_map__fd(data_map), &zero, &result);
+	err = bpf_map_lookup_elem(bpf_map__fd(data_map), &zero, result);
 	if (CHECK(err, "get_result",
 		  "failed to get output data: %d\n", err))
 		goto close_prog;
 
-	for (i = 0; i < PROG_CNT; i++)
+	for (i = 0; i < prog_cnt; i++)
 		if (CHECK(result[i] != 1, "result", "fexit_bpf2bpf failed err %ld\n",
 			  result[i]))
 			goto close_prog;
 
 close_prog:
-	for (i = 0; i < PROG_CNT; i++)
+	for (i = 0; i < prog_cnt; i++)
 		if (!IS_ERR_OR_NULL(link[i]))
 			bpf_link__destroy(link[i]);
 	if (!IS_ERR_OR_NULL(obj))
 		bpf_object__close(obj);
 	bpf_object__close(pkt_obj);
+	free(link);
+	free(prog);
+	free(result);
+}
+
+static void test_target_no_callees(void)
+{
+	const char *prog_name[] = {
+		"fexit/test_pkt_md_access",
+	};
+	test_fexit_bpf2bpf_common("./fexit_bpf2bpf_simple.o",
+				  "./test_pkt_md_access.o",
+				  ARRAY_SIZE(prog_name),
+				  prog_name);
+}
+
+static void test_target_yes_callees(void)
+{
+	const char *prog_name[] = {
+		"fexit/test_pkt_access",
+		"fexit/test_pkt_access_subprog1",
+		"fexit/test_pkt_access_subprog2",
+	};
+	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
+				  "./test_pkt_access.o",
+				  ARRAY_SIZE(prog_name),
+				  prog_name);
+}
+
+void test_fexit_bpf2bpf(void)
+{
+	test_target_no_callees();
+	test_target_yes_callees();
 }
diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf_simple.c b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf_simple.c
new file mode 100644
index 000000000000..ebc0ab7f0f5c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf_simple.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+#include "bpf_trace_helpers.h"
+
+struct sk_buff {
+	unsigned int len;
+};
+
+__u64 test_result = 0;
+BPF_TRACE_2("fexit/test_pkt_md_access", test_main2,
+	    struct sk_buff *, skb, int, ret)
+{
+	int len;
+
+	__builtin_preserve_access_index(({
+		len = skb->len;
+	}));
+	if (len != 74 || ret != 0)
+		return 0;
+
+	test_result = 1;
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
index 3d039e18bf82..1db2623021ad 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
@@ -27,8 +27,8 @@ int _version SEC("version") = 1;
 	}
 #endif
 
-SEC("test1")
-int process(struct __sk_buff *skb)
+SEC("classifier/test_pkt_md_access")
+int test_pkt_md_access(struct __sk_buff *skb)
 {
 	TEST_FIELD(__u8,  len, 0xFF);
 	TEST_FIELD(__u16, len, 0xFFFF);
-- 
2.17.1

