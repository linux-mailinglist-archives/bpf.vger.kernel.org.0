Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C8220CFC
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgGOMd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 08:33:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgGOMd4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 08:33:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FCW0hC057871;
        Wed, 15 Jul 2020 08:33:44 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329dhx2x2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 08:33:44 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FCVHO9025318;
        Wed, 15 Jul 2020 12:33:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pgva2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 12:33:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FCXbK059507186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 12:33:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB4C84C046;
        Wed, 15 Jul 2020 12:33:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A1F34C040;
        Wed, 15 Jul 2020 12:33:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.186.215])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 12:33:37 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/4] selftests/bpf: add exception handling test
Date:   Wed, 15 Jul 2020 14:32:27 +0200
Message-Id: <20200715123227.912866-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715123227.912866-1-iii@linux.ibm.com>
References: <20200715123227.912866-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_10:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150102
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Many tests cover exception table creation, but none, at least on s390,
actually trigger the exception handler. This might be due to s390
allowing NULL dereferences in kernel mode (duh!).

This patch implements a test that follows garbage pointers and triggers
the exception handler on s390.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 17 ++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_exception.c  | 20 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_exception.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index fed42755416d..733e00dabd84 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -15,6 +15,7 @@
 #include "bpf_iter_test_kern2.skel.h"
 #include "bpf_iter_test_kern3.skel.h"
 #include "bpf_iter_test_kern4.skel.h"
+#include "bpf_iter_exception.skel.h"
 
 static int duration;
 
@@ -455,6 +456,20 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 	bpf_iter_test_kern4__destroy(skel);
 }
 
+static void test_exception(void)
+{
+	struct bpf_iter_exception *skel;
+
+	skel = bpf_iter_exception__open_and_load();
+	if (CHECK(!skel, "bpf_iter_exception__open_and_load",
+		  "skeleton open_and_load failed\n"))
+		return;
+
+	do_dummy_read(skel->progs.dump_ipv6_route);
+
+	bpf_iter_exception__destroy(skel);
+}
+
 void test_bpf_iter(void)
 {
 	if (test__start_subtest("btf_id_or_null"))
@@ -491,4 +506,6 @@ void test_bpf_iter(void)
 		test_overflow(true, false);
 	if (test__start_subtest("prog-ret-1"))
 		test_overflow(false, true);
+	if (test__start_subtest("exception"))
+		test_exception();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_exception.c b/tools/testing/selftests/bpf/progs/bpf_iter_exception.c
new file mode 100644
index 000000000000..ee2a08a40d5d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_exception.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf_iter.h"
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/ipv6_route")
+int dump_ipv6_route(struct bpf_iter__ipv6_route *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct fib6_info *rt = ctx->rt;
+
+	if (rt)
+		/* Follow pointers as recklessly as possible. */
+		BPF_SEQ_PRINTF(seq, "%s\n",
+			       &rt->nh->nh_info->fib6_nh.fib_nh_dev->name);
+	return 0;
+}
-- 
2.25.4

