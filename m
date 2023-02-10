Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1171569152C
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBJAM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjBJAMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:12:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2B5EBCF
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:12:54 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NftYG029645;
        Fri, 10 Feb 2023 00:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nzWCyNVXp/0HKZhUK/uUgD0DtoLiwfG8cE6+xrVw0CI=;
 b=ePubFxtOk57a2tY0zZ27HUcAp4j76GHZDhtWCwDAuK8nYsaREHD4n8SiA0Cd2fF0SOX4
 S2qgBplsZRLBbXTWzOZ1nfCQbwd+gZ8BnSMRQY7bScwJW2dKwf7StZmlxvbu/QJawA8c
 uxNCkjSe5RIN7uhiOmkgxwSCyxMDw83ToQujdNzC8PDDMANLEqj3tKtxyvX39MGu3f8M
 NgLLEkWG0zX0NdZXcgyebebN+vicQ9CFvyhEGW1S0xxlPLL1ksC3EH58LUfblQCnl1Cq
 4/r8iNqG33HbEYTCSOCXqQMUCW6HVfmCG9FxX77R4NLOdCju5X9j627vqi/ZuK8Q4rMy 4w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnaqu0y9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319DN6r1001926;
        Fri, 10 Feb 2023 00:12:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06psdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CZHi24773060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4D632004B;
        Fri, 10 Feb 2023 00:12:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45DCE20040;
        Fri, 10 Feb 2023 00:12:35 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:35 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 06/16] selftests/bpf: Attach to fopen()/fclose() in attach_probe
Date:   Fri, 10 Feb 2023 01:12:00 +0100
Message-Id: <20230210001210.395194-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9BPxsZAwmGfkjT5_dbthuCqNmcTXRqaH
X-Proofpoint-ORIG-GUID: 9BPxsZAwmGfkjT5_dbthuCqNmcTXRqaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090217
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
 tools/testing/selftests/bpf/progs/test_attach_probe.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

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
index a1e45fec8938..3b5dc34d23e9 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -92,18 +92,19 @@ int handle_uretprobe_byname(struct pt_regs *ctx)
 }
 
 SEC("uprobe")
-int handle_uprobe_byname2(struct pt_regs *ctx)
+int BPF_UPROBE(handle_uprobe_byname2, const char *pathname, const char *mode)
 {
-	unsigned int size = PT_REGS_PARM1(ctx);
+	char mode_buf[2] = {};
 
-	/* verify malloc size */
-	if (size == 1)
+	/* verify fopen mode */
+	bpf_probe_read_user(mode_buf, sizeof(mode_buf), mode);
+	if (mode_buf[0] == 'r' && mode_buf[1] == 0)
 		uprobe_byname2_res = 7;
 	return 0;
 }
 
 SEC("uretprobe")
-int handle_uretprobe_byname2(struct pt_regs *ctx)
+int BPF_URETPROBE(handle_uretprobe_byname2, void *ret)
 {
 	uretprobe_byname2_res = 8;
 	return 0;
-- 
2.39.1

