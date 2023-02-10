Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF469152B
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBJAMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBJAMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:12:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189155C49F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:12:53 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A0CS3T008282;
        Fri, 10 Feb 2023 00:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lQrk9WRAgN1Mj7LILUpzUrj4GaDiqbBsPLpSP/wkSVk=;
 b=gEiVOmJPiNcIPLwXOzvdDBSbBLPGL0ELvf6yQBkjxjWjC1W23h1xRtcHYKhxQj9wt1TA
 pO0Obre6/kh+6G2IAChjBpwwwJKyyTy9b7H50jxidQ6oEPI9VnbrygryXz4fmwv8jwfJ
 Q3+/nNdvTXDezr9duhg44LC3lnKY2Z9PjJve+L27pjKubgzb8Q84FFKDVBOJkG2RBE7V
 xTFeX8wTyF0TjjnTJtCqj02cGa31lVA5Yp0I5/GdPsrnexnJpIJaR9JMWYqMAthV5kSk
 Li9YRb9uXS2CUb0lGnyMdOhj7BpBS7o4aYP37r04/UDjtcPNbgtIj0r4G1IAyhaZRIjM aw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnb61802v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:40 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319DN6r0001926;
        Fri, 10 Feb 2023 00:12:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06psdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CYLH43843856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 546B62004B;
        Fri, 10 Feb 2023 00:12:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEC1320040;
        Fri, 10 Feb 2023 00:12:33 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:33 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 05/16] selftests/bpf: Attach to fopen()/fclose() in uprobe_autoattach
Date:   Fri, 10 Feb 2023 01:11:59 +0100
Message-Id: <20230210001210.395194-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JGjLn9jfYISEYnyRzLLtsPbThdAPe4_W
X-Proofpoint-ORIG-GUID: JGjLn9jfYISEYnyRzLLtsPbThdAPe4_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=884 malwarescore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
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
 .../selftests/bpf/prog_tests/uprobe_autoattach.c | 14 ++++++++------
 .../selftests/bpf/progs/test_uprobe_autoattach.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index 82807def0d24..6558c857e620 100644
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
@@ -36,16 +36,18 @@ void test_uprobe_autoattach(void)
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
+	ASSERT_EQ(skel->bss->uprobe_byname2_parm1, (__u64)(long)devnull_str,
+		  "check_uprobe_byname2_parm1");
 	ASSERT_EQ(skel->bss->uprobe_byname2_ran, 3, "check_uprobe_byname2_ran");
-	ASSERT_EQ(skel->bss->uretprobe_byname2_rc, mem, "check_uretprobe_byname2_rc");
+	ASSERT_EQ(skel->bss->uretprobe_byname2_rc, (__u64)(long)devnull,
+		  "check_uretprobe_byname2_rc");
 	ASSERT_EQ(skel->bss->uretprobe_byname2_ran, 4, "check_uretprobe_byname2_ran");
 
 	ASSERT_EQ(skel->bss->a[0], 1, "arg1");
@@ -67,7 +69,7 @@ void test_uprobe_autoattach(void)
 	ASSERT_EQ(skel->bss->a[7], 8, "arg8");
 #endif
 
-	free(mem);
+	fclose(devnull);
 cleanup:
 	test_uprobe_autoattach__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
index 774ddeb45898..da4bf89d004c 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
@@ -13,9 +13,9 @@ int uprobe_byname_ran = 0;
 int uretprobe_byname_rc = 0;
 int uretprobe_byname_ret = 0;
 int uretprobe_byname_ran = 0;
-size_t uprobe_byname2_parm1 = 0;
+u64 uprobe_byname2_parm1 = 0;
 int uprobe_byname2_ran = 0;
-char *uretprobe_byname2_rc = NULL;
+u64 uretprobe_byname2_rc = 0;
 int uretprobe_byname2_ran = 0;
 
 int test_pid;
@@ -88,28 +88,28 @@ int BPF_URETPROBE(handle_uretprobe_byname, int ret)
 }
 
 
-SEC("uprobe/libc.so.6:malloc")
-int handle_uprobe_byname2(struct pt_regs *ctx)
+SEC("uprobe/libc.so.6:fopen")
+int BPF_UPROBE(handle_uprobe_byname2, const char *pathname, const char *mode)
 {
 	int pid = bpf_get_current_pid_tgid() >> 32;
 
 	/* ignore irrelevant invocations */
 	if (test_pid != pid)
 		return 0;
-	uprobe_byname2_parm1 = PT_REGS_PARM1_CORE(ctx);
+	uprobe_byname2_parm1 = (u64)(long)pathname;
 	uprobe_byname2_ran = 3;
 	return 0;
 }
 
-SEC("uretprobe/libc.so.6:malloc")
-int handle_uretprobe_byname2(struct pt_regs *ctx)
+SEC("uretprobe/libc.so.6:fopen")
+int BPF_URETPROBE(handle_uretprobe_byname2, void *ret)
 {
 	int pid = bpf_get_current_pid_tgid() >> 32;
 
 	/* ignore irrelevant invocations */
 	if (test_pid != pid)
 		return 0;
-	uretprobe_byname2_rc = (char *)PT_REGS_RC_CORE(ctx);
+	uretprobe_byname2_rc = (u64)(long)ret;
 	uretprobe_byname2_ran = 4;
 	return 0;
 }
-- 
2.39.1

