Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7667BEB7
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbjAYVjU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbjAYVjR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131542ED42
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:15 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PLZvg7018097;
        Wed, 25 Jan 2023 21:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JgIEWoyBWGUIamSO+OGnIn9df5u+4LBwbEsOm0z9q5s=;
 b=m7iyEPCGox29mSi836rQofuJor5w7f0R53e96qiE/h5x/dohScnKLvyWwc/1+1Yrv3+5
 CW2b8RyPT23zyU2uW0AWzSQYfXZpB0JwsoeQGhg1OIFfRjiwojDWNd5Y3EFkVTqzepp5
 u+mfl3HD33/VWtP0QGQWfBtpHAwWc8dH9bYUve4RbqFEKIMoJ6FYFeD8nQrfKuKd5vJ1
 8Ubb3F14qd4hdB1sK0bG11eIDizIDdfidUSJO8x+98L6oBJDzESlTHBCBxAhh82UZ6kF
 stD85EC1yN/u8QaB+U4K44a7rZ4GqexTCcxKeu5xgBhwohJ1pc66+xGBXWz6Pqj6hf5U aA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6na2v7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGrUfn014903;
        Wed, 25 Jan 2023 21:38:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afdkwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:38:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLcu5j52232496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:38:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 278732004B;
        Wed, 25 Jan 2023 21:38:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEAE920043;
        Wed, 25 Jan 2023 21:38:55 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:38:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 03/24] selftests/bpf: Fix fexit_stress on s390x
Date:   Wed, 25 Jan 2023 22:37:56 +0100
Message-Id: <20230125213817.1424447-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MKhCuZr_G2kIemg24r_uaDN4G8fj9n_n
X-Proofpoint-ORIG-GUID: MKhCuZr_G2kIemg24r_uaDN4G8fj9n_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=864 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250193
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF_MAX_TRAMP_LINKS is smaller on s390x than on x86.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 5a7e6011f6bf..329950f572cc 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -2,8 +2,12 @@
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
 
-/* that's kernel internal BPF_MAX_TRAMP_PROGS define */
+/* that's kernel internal BPF_MAX_TRAMP_LINKS define */
+#if defined(__s390x__)
+#define CNT 27
+#else
 #define CNT 38
+#endif
 
 void serial_test_fexit_stress(void)
 {
-- 
2.39.1

