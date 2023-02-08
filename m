Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6FC68F92C
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBHU51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjBHU5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A658C45F76
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:13 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KGtQE023954;
        Wed, 8 Feb 2023 20:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vHLdFymp+xBv/LSQNIkwLPPo+mgbleHjXU7IYXaIH90=;
 b=bSKgM3EGDZWVzLFgAP0nO9QBSFcvLw4Alp1FQfIBtAPq23CIL1qdP0VCOkAf14ghn8k8
 mvAAIxUqnLl1Ww5yRVKzctZAE0O6PfpX7IDn30Dr34xrePxG+hi+nNEzC50qlpiK4+4Z
 z0aBXDhnRXtju7Rub+LmCxOI1U6sUZ2t3EzPb8sh3eolBUvUl+Syzb+hQswSicWc78oW
 5Up4Rt4j7107zjcErGql9HRGnvfuvpJ69z/Gob9oDf9AnXGHXOJBJcKsLyH1JVM4A0NT
 4tZ6Yoo/kshdnF4b0eENY5PZr2eyM43OHE7cmSdTcwIwXdarSCDAWiTQNlYCuHK9kX4H Aw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmjmvru1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:59 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318ETqBO006266;
        Wed, 8 Feb 2023 20:56:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nhf06kt2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318KurIv22217296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C89720043;
        Wed,  8 Feb 2023 20:56:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 814BE20040;
        Wed,  8 Feb 2023 20:56:52 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 5/9] selftests/bpf: Attach to fopen()/fclose() in uprobe_autoattach
Date:   Wed,  8 Feb 2023 21:56:38 +0100
Message-Id: <20230208205642.270567-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208205642.270567-1-iii@linux.ibm.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xkJ4A2oNcfW2YFwGr8rrVyNdENPCnUwC
X-Proofpoint-ORIG-GUID: xkJ4A2oNcfW2YFwGr8rrVyNdENPCnUwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxlogscore=941 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

malloc() and free() may be completely replaced by sanitizers, use
fopen() and fclose() instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/uprobe_autoattach.c     | 12 ++++++------
 .../selftests/bpf/progs/test_uprobe_autoattach.c     | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index 82807def0d24..b862948f95a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
@@ -16,10 +16,10 @@ static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
 
 void test_uprobe_autoattach(void)
 {
+	const char *devnull_str = "/dev/null";
 	struct test_uprobe_autoattach *skel;
 	int trigger_ret;
-	size_t malloc_sz = 1;
-	char *mem;
+	FILE *devnull;
 
 	skel = test_uprobe_autoattach__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -36,16 +36,16 @@ void test_uprobe_autoattach(void)
 	skel->bss->test_pid = getpid();
 
 	/* trigger & validate shared library u[ret]probes attached by name */
-	mem = malloc(malloc_sz);
+	devnull = fopen(devnull_str, "r");
 
 	ASSERT_EQ(skel->bss->uprobe_byname_parm1, 1, "check_uprobe_byname_parm1");
 	ASSERT_EQ(skel->bss->uprobe_byname_ran, 1, "check_uprobe_byname_ran");
 	ASSERT_EQ(skel->bss->uretprobe_byname_rc, trigger_ret, "check_uretprobe_byname_rc");
 	ASSERT_EQ(skel->bss->uretprobe_byname_ret, trigger_ret, "check_uretprobe_byname_ret");
 	ASSERT_EQ(skel->bss->uretprobe_byname_ran, 2, "check_uretprobe_byname_ran");
-	ASSERT_EQ(skel->bss->uprobe_byname2_parm1, malloc_sz, "check_uprobe_byname2_parm1");
+	ASSERT_EQ(skel->bss->uprobe_byname2_parm1, devnull_str, "check_uprobe_byname2_parm1");
 	ASSERT_EQ(skel->bss->uprobe_byname2_ran, 3, "check_uprobe_byname2_ran");
-	ASSERT_EQ(skel->bss->uretprobe_byname2_rc, mem, "check_uretprobe_byname2_rc");
+	ASSERT_EQ(skel->bss->uretprobe_byname2_rc, (void *)devnull, "check_uretprobe_byname2_rc");
 	ASSERT_EQ(skel->bss->uretprobe_byname2_ran, 4, "check_uretprobe_byname2_ran");
 
 	ASSERT_EQ(skel->bss->a[0], 1, "arg1");
@@ -67,7 +67,7 @@ void test_uprobe_autoattach(void)
 	ASSERT_EQ(skel->bss->a[7], 8, "arg8");
 #endif
 
-	free(mem);
+	fclose(devnull);
 cleanup:
 	test_uprobe_autoattach__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
index 774ddeb45898..72f5e7a82c58 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
@@ -13,9 +13,9 @@ int uprobe_byname_ran = 0;
 int uretprobe_byname_rc = 0;
 int uretprobe_byname_ret = 0;
 int uretprobe_byname_ran = 0;
-size_t uprobe_byname2_parm1 = 0;
+void *uprobe_byname2_parm1 = NULL;
 int uprobe_byname2_ran = 0;
-char *uretprobe_byname2_rc = NULL;
+void *uretprobe_byname2_rc = NULL;
 int uretprobe_byname2_ran = 0;
 
 int test_pid;
@@ -88,7 +88,7 @@ int BPF_URETPROBE(handle_uretprobe_byname, int ret)
 }
 
 
-SEC("uprobe/libc.so.6:malloc")
+SEC("uprobe/libc.so.6:fopen")
 int handle_uprobe_byname2(struct pt_regs *ctx)
 {
 	int pid = bpf_get_current_pid_tgid() >> 32;
@@ -96,12 +96,12 @@ int handle_uprobe_byname2(struct pt_regs *ctx)
 	/* ignore irrelevant invocations */
 	if (test_pid != pid)
 		return 0;
-	uprobe_byname2_parm1 = PT_REGS_PARM1_CORE(ctx);
+	uprobe_byname2_parm1 = (void *)(long)PT_REGS_PARM1_CORE(ctx);
 	uprobe_byname2_ran = 3;
 	return 0;
 }
 
-SEC("uretprobe/libc.so.6:malloc")
+SEC("uretprobe/libc.so.6:fopen")
 int handle_uretprobe_byname2(struct pt_regs *ctx)
 {
 	int pid = bpf_get_current_pid_tgid() >> 32;
-- 
2.39.1

