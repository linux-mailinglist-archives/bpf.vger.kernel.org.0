Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB7767F2A8
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjA1AH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjA1AH2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399038662D
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:26 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNBjaH024085;
        Sat, 28 Jan 2023 00:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6euuwhZe4+Sh9jqPQI8o7GWMBwweE2x1chxGCNrT4qY=;
 b=ACm7IVIAdrMakySpxnZb0+RLjRFs8/MlQkfU8uQsdd1OohKtWu1jOvIA8ZMbDDjvwRTJ
 g96F9HuFC1ZdchxuXyNYnOf7F3SWxL4+yvxOgrK0DiRzSEId5zBuJ6oI9IwfWwYbvsWO
 DetuZPuV5RlVDt3eUeyPVgrYXNRz7pPYtpUSHZKkvjDdF9IbuEFJax3mroYNR0Icj5Z/
 C4OpSXQXFHOGt5ZHW58YmDNYDkut9L83zcBrexDj7/3QK/Th3si8CjPco5eifEBGzhS/
 zR5QhlGrJPkO9Y9H7tv7bGbP0pk5QrC5tJMgs6tDyZrHrK8zroD14jDapGrJMGfUKkwg KQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncr2nrxgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKr81P010329;
        Sat, 28 Jan 2023 00:07:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6r4dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S076In52888002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7042D20043;
        Sat, 28 Jan 2023 00:07:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7B5420040;
        Sat, 28 Jan 2023 00:07:05 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:05 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 08/31] selftests/bpf: Fix decap_sanity_ns cleanup
Date:   Sat, 28 Jan 2023 01:06:27 +0100
Message-Id: <20230128000650.1516334-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BIu6jikGi_IZ4bXqSjXmFNJvE2oVf6e1
X-Proofpoint-ORIG-GUID: BIu6jikGi_IZ4bXqSjXmFNJvE2oVf6e1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

decap_sanity prints the following on the 1st run:

    decap_sanity: sh: 1: Syntax error: Bad fd number

and the following on the 2nd run:

    Cannot create namespace file "/run/netns/decap_sanity_ns": File exists

The problem is that the cleanup command has a typo and does nothing.
Fix the typo.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/decap_sanity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
index 0b2f73b88c53..2853883b7cbb 100644
--- a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
@@ -80,6 +80,6 @@ void test_decap_sanity(void)
 		bpf_tc_hook_destroy(&qdisc_hook);
 		close_netns(nstoken);
 	}
-	system("ip netns del " NS_TEST " >& /dev/null");
+	system("ip netns del " NS_TEST " &> /dev/null");
 	decap_sanity__destroy(skel);
 }
-- 
2.39.1

