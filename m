Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D5868F92B
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjBHU50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjBHU5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE36457C2
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:13 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Jck3d031826;
        Wed, 8 Feb 2023 20:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=J8lgXrkBsTLbY6vE2QXrgiPQfRoCsmNul0wZrp69Mdw=;
 b=Qfe00UkGJ5pB/Tmj7zfNiVaXUZdUcYcBPluhb5JmWW4pCqrem/57OA4g4q4ltNAEkter
 YrpoWuM0XsequLZ1gSVw+U6KLZ1HxMqkBkjf1vfyKjN5KqTOqRGLCz34ecLWqi9BKXj5
 BXbTk2j47pKcKPuEmN8K4dtvfUvtHR7P7WH9yeRc7p/4mtySIlA7jexiSxJ3F43bTCIt
 0t8/3pnYLHC8s+S1QlPfzBe+uWNcAKIr90fHDVGjApYvdSItnuDumDHgocM/J9sg9nP1
 qIeEI7ilIuPG6a1gv6GKr/K3Hm6fyxe9UamZ8s3vBMvb4qW1E0nyqRsYZudajgN5QEc0 Hg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmhnyaaj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:57:00 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3182Ainr016060;
        Wed, 8 Feb 2023 20:56:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3nhf06ksmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:56:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318KusX644564846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2912520049;
        Wed,  8 Feb 2023 20:56:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A066C20040;
        Wed,  8 Feb 2023 20:56:53 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:53 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: Attach to fopen()/fclose() in attach_probe
Date:   Wed,  8 Feb 2023 21:56:39 +0100
Message-Id: <20230208205642.270567-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208205642.270567-1-iii@linux.ibm.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cWBKATJQVQbDRDKQChOy1zsg0QlWQcWC
X-Proofpoint-GUID: cWBKATJQVQbDRDKQChOy1zsg0QlWQcWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 tools/testing/selftests/bpf/prog_tests/attach_probe.c | 10 +++++-----
 tools/testing/selftests/bpf/progs/test_attach_probe.c |  8 +++++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9566d9d2f6ee..56374c8b5436 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -33,8 +33,8 @@ void test_attach_probe(void)
 	struct test_attach_probe* skel;
 	ssize_t uprobe_offset, ref_ctr_offset;
 	struct bpf_link *uprobe_err_link;
+	FILE *devnull;
 	bool legacy;
-	char *mem;
 
 	/* Check if new-style kprobe/uprobe API is supported.
 	 * Kernels that support new FD-based kprobe and uprobe BPF attachment
@@ -147,7 +147,7 @@ void test_attach_probe(void)
 	/* test attach by name for a library function, using the library
 	 * as the binary argument. libc.so.6 will be resolved via dlopen()/dlinfo().
 	 */
-	uprobe_opts.func_name = "malloc";
+	uprobe_opts.func_name = "fopen";
 	uprobe_opts.retprobe = false;
 	skel->links.handle_uprobe_byname2 =
 			bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_byname2,
@@ -157,7 +157,7 @@ void test_attach_probe(void)
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname2, "attach_uprobe_byname2"))
 		goto cleanup;
 
-	uprobe_opts.func_name = "free";
+	uprobe_opts.func_name = "fclose";
 	uprobe_opts.retprobe = true;
 	skel->links.handle_uretprobe_byname2 =
 			bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe_byname2,
@@ -195,8 +195,8 @@ void test_attach_probe(void)
 	usleep(1);
 
 	/* trigger & validate shared library u[ret]probes attached by name */
-	mem = malloc(1);
-	free(mem);
+	devnull = fopen("/dev/null", "r");
+	fclose(devnull);
 
 	/* trigger & validate uprobe & uretprobe */
 	trigger_func();
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index a1e45fec8938..269a184c265c 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -94,10 +94,12 @@ int handle_uretprobe_byname(struct pt_regs *ctx)
 SEC("uprobe")
 int handle_uprobe_byname2(struct pt_regs *ctx)
 {
-	unsigned int size = PT_REGS_PARM1(ctx);
+	void *mode_ptr = (void *)(long)PT_REGS_PARM2(ctx);
+	char mode[2] = {};
 
-	/* verify malloc size */
-	if (size == 1)
+	/* verify fopen mode */
+	bpf_probe_read_user(mode, sizeof(mode), mode_ptr);
+	if (mode[0] == 'r' && mode[1] == 0)
 		uprobe_byname2_res = 7;
 	return 0;
 }
-- 
2.39.1

