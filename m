Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C367F2AF
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjA1AHm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjA1AHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5B8CA97
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:30 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RMpe5F011719;
        Sat, 28 Jan 2023 00:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L7d7cUlTda7DuNCISC3TpwMyvRXd1xEVm0Vc3CZh+Pw=;
 b=F+NBx/hBm5PHwdjZtq93ZQ4afD/qzTbeR0CQy0ZF5ZiqZPwgtCD3K4n4rdZC9Jf5gJTb
 bmpeUevudjER+O/+6GxE0/Ka3W+qLY7WIFFOsgJAntxPEtRcIRqZVUDdvuy0Zo9itxD7
 6qo69OxYZAD04XAiULt0rxPhzwMiBKKlsgT1viz61gUqt9q5tQqXRa22BHd6BfukO3jx
 JTV3qdAicrxar1kKXrZw83pvtiV9VCAcBhpqJlYaOFB71vIVGR9AZ09GJcncpWfl1H8B
 WZMFHKVJ6uK42orl/sbnDhv3bc0VQbdm5MObZC1aQIPENuJ6M9IPf9NDSa/PvIwAk4Ee /Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncqsdha2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RLr3WX014903;
        Sat, 28 Jan 2023 00:07:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afg592-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07AdU15925664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A192E20043;
        Sat, 28 Jan 2023 00:07:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F24720040;
        Sat, 28 Jan 2023 00:07:10 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 12/31] selftests/bpf: Check stack_mprotect() return value
Date:   Sat, 28 Jan 2023 01:06:31 +0100
Message-Id: <20230128000650.1516334-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lFkL6yTljKw69gtszNCfuPbXn-_sK0aO
X-Proofpoint-ORIG-GUID: lFkL6yTljKw69gtszNCfuPbXn-_sK0aO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270216
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If stack_mprotect() succeeds, errno is not changed. This can produce
misleading error messages, that show stale errno.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 6 ++++--
 tools/testing/selftests/bpf/prog_tests/test_lsm.c   | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 2be2d61954bc..26b2d1bffdfd 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -472,6 +472,7 @@ static void lsm_subtest(struct test_bpf_cookie *skel)
 	int prog_fd;
 	int lsm_fd = -1;
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	int err;
 
 	skel->bss->lsm_res = 0;
 
@@ -482,8 +483,9 @@ static void lsm_subtest(struct test_bpf_cookie *skel)
 	if (!ASSERT_GE(lsm_fd, 0, "lsm.link_create"))
 		goto cleanup;
 
-	stack_mprotect();
-	if (!ASSERT_EQ(errno, EPERM, "stack_mprotect"))
+	err = stack_mprotect();
+	if (!ASSERT_EQ(err, -1, "stack_mprotect") ||
+	    !ASSERT_EQ(errno, EPERM, "stack_mprotect"))
 		goto cleanup;
 
 	usleep(1);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index 244c01125126..16175d579bc7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -75,7 +75,8 @@ static int test_lsm(struct lsm *skel)
 	skel->bss->monitored_pid = getpid();
 
 	err = stack_mprotect();
-	if (!ASSERT_EQ(errno, EPERM, "stack_mprotect"))
+	if (!ASSERT_EQ(err, -1, "stack_mprotect") ||
+	    !ASSERT_EQ(errno, EPERM, "stack_mprotect"))
 		return err;
 
 	ASSERT_EQ(skel->bss->mprotect_count, 1, "mprotect_count");
-- 
2.39.1

