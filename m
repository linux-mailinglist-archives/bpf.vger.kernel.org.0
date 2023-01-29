Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0D68011C
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjA2TFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 14:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjA2TFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 14:05:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFCB12878
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 11:05:31 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TE2afV004650;
        Sun, 29 Jan 2023 19:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4IWxc2gzp49EmU6pXCqj6iZ1aCQGCvwhWLiZFpAU/uc=;
 b=gdIDlS8kwvwAhEK9gHHtqci0dRLVgXx9sGlX1Fzaf3U9ENjG18IKwoXWWPT+J6uGB9py
 vxL5jZZBt1XvQEyiEdKy3RlNtzeJsMuNtUsq3UKg3Knx7HwGnPLC/t50A/FD0+WZSa1U
 e3Wk0kTjrndjdRNaV/v+jcmxFaPkWofvYQbWSlzvuElYZHUsVDp/QjT6kSUze+V+PE61
 5VDr5x9d4M64cmaj3Bz9mZIm+4gAtWY6RkMbSL/0VE0//9VxTf2Ay10xo8ypoOvzNg4W
 3MdfzLSvGpXM5Nlr+ptorCZbdEYuYugfMv5CN9tjhF3ch20g26TFUwO+28D1FXZ/PY5v dw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nddfc5eet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:11 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30SDeepE012041;
        Sun, 29 Jan 2023 19:05:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3ncvuqs0rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 19:05:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30TJ559L45089122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 19:05:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A63DC20040;
        Sun, 29 Jan 2023 19:05:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15CC020043;
        Sun, 29 Jan 2023 19:05:05 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 29 Jan 2023 19:05:04 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Fix sk_assign on s390x
Date:   Sun, 29 Jan 2023 20:04:54 +0100
Message-Id: <20230129190501.1624747-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
References: <20230129190501.1624747-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bm6OFRjqnUP8wUm2NRL3mpEbE9Oq4P3l
X-Proofpoint-GUID: Bm6OFRjqnUP8wUm2NRL3mpEbE9Oq4P3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sk_assign is failing on an s390x machine running Debian "bookworm" for
2 reasons: legacy server_map definition and uninitialized addrlen in
recvfrom() call.

Fix by adding a new-style server_map definition and dropping addrlen
(recvfrom() allows NULL values for src_addr and addrlen).

Since the test should support tc built without libbpf, build the prog
twice: with the old-style definition and with the new-style definition,
then select the right one at runtime. This could be done at compile
time too, but this would not be cross-compilation friendly.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 25 ++++++++++++++-----
 .../selftests/bpf/progs/test_sk_assign.c      | 11 ++++++++
 .../bpf/progs/test_sk_assign_libbpf.c         |  3 +++
 3 files changed, 33 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 3e190ed63976..1374b626a985 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -29,7 +29,23 @@ static int stop, duration;
 static bool
 configure_stack(void)
 {
+	char tc_version[128];
 	char tc_cmd[BUFSIZ];
+	char *prog;
+	FILE *tc;
+
+	/* Check whether tc is built with libbpf. */
+	tc = popen("tc -V", "r");
+	if (CHECK_FAIL(!tc))
+		return false;
+	if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
+		return false;
+	if (strstr(tc_version, ", libbpf "))
+		prog = "test_sk_assign_libbpf.bpf.o";
+	else
+		prog = "test_sk_assign.bpf.o";
+	if (CHECK_FAIL(pclose(tc)))
+		return false;
 
 	/* Move to a new networking namespace */
 	if (CHECK_FAIL(unshare(CLONE_NEWNET)))
@@ -46,8 +62,8 @@ configure_stack(void)
 	/* Load qdisc, BPF program */
 	if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
 		return false;
-	sprintf(tc_cmd, "%s %s %s %s", "tc filter add dev lo ingress bpf",
-		       "direct-action object-file ./test_sk_assign.bpf.o",
+	sprintf(tc_cmd, "%s %s %s %s %s", "tc filter add dev lo ingress bpf",
+		       "direct-action object-file", prog,
 		       "section tc",
 		       (env.verbosity < VERBOSE_VERY) ? " 2>/dev/null" : "verbose");
 	if (CHECK(system(tc_cmd), "BPF load failed;",
@@ -129,15 +145,12 @@ get_port(int fd)
 static ssize_t
 rcv_msg(int srv_client, int type)
 {
-	struct sockaddr_storage ss;
 	char buf[BUFSIZ];
-	socklen_t slen;
 
 	if (type == SOCK_STREAM)
 		return read(srv_client, &buf, sizeof(buf));
 	else
-		return recvfrom(srv_client, &buf, sizeof(buf), 0,
-				(struct sockaddr *)&ss, &slen);
+		return recvfrom(srv_client, &buf, sizeof(buf), 0, NULL, NULL);
 }
 
 static int
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 98c6493d9b91..21b19b758c4e 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -16,6 +16,16 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#if defined(IPROUTE2_HAVE_LIBBPF)
+/* Use a new-style map definition. */
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__type(key, int);
+	__type(value, __u64);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+	__uint(max_entries, 1);
+} server_map SEC(".maps");
+#else
 /* Pin map under /sys/fs/bpf/tc/globals/<map name> */
 #define PIN_GLOBAL_NS 2
 
@@ -35,6 +45,7 @@ struct {
 	.max_elem = 1,
 	.pinning = PIN_GLOBAL_NS,
 };
+#endif
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c b/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
new file mode 100644
index 000000000000..dcf46adfda04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#define IPROUTE2_HAVE_LIBBPF
+#include "test_sk_assign.c"
-- 
2.39.1

