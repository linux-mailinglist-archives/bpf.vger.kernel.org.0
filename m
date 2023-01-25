Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A66967BEC0
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjAYVjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbjAYVju (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE34940D
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:42 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLe0R011032;
        Wed, 25 Jan 2023 21:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L7d7cUlTda7DuNCISC3TpwMyvRXd1xEVm0Vc3CZh+Pw=;
 b=tO4l86n4j5+XFXfZKSzZdUEWOaO0JaKudEbiNyxXit6DiZF2rqbZP2uV1aYRiX24Mpm5
 VGPFFbwG3t7GFr5YMQhHU0H/hEReK4SNFCPR5LSGjC3pft6I564hRT6K0w2Yhd686KnV
 LEOSgrnvUMGP7g7K6yna9TDON8TGtRUIg3x98IO7nMY8823CUWzoS4cadDHtoxqcokRY
 4Xb0B7pAgl9notCMcnXHSowcB7mu79BOr2bbxJmPsBGet3in56A+V09T85Gw3xv+FIAc
 D9m/a+ZrLte456yc/VVZsMxjbtx5paUUtUWvf0P/MKurZA4WYxBYAxKnKyITYdaa0MfY 5w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8n9edx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PHUZkw015740;
        Wed, 25 Jan 2023 21:39:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afdkx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdMsP20578736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 806572004B;
        Wed, 25 Jan 2023 21:39:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 484C720043;
        Wed, 25 Jan 2023 21:39:22 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:22 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 11/24] selftests/bpf: Check stack_mprotect() return value
Date:   Wed, 25 Jan 2023 22:38:04 +0100
Message-Id: <20230125213817.1424447-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S6GDuMz2P12ppEXSlwE8n0vq7GWlwOkd
X-Proofpoint-ORIG-GUID: S6GDuMz2P12ppEXSlwE8n0vq7GWlwOkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

