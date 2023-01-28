Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B267F2AC
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjA1AHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjA1AHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6898B065
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:28 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30S071Dd026141;
        Sat, 28 Jan 2023 00:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=M9NMAAZfkSo6/gHwRZxtXMS/EpIdA38vnodw1cyzydM=;
 b=Q+40wuvR+HojxkMmxDLqF3cz94wVuN9xMSTt7jgxXtLx3sUqf485WYULH11XQ4xFQQO5
 3pf1EsoNTfIHd+ZX0W3A/iUlKPzmK2IExLuT5Q/WPlsUPtr7R76OeGcducoQTIsb7TnV
 itoy9QR8PHKalxhg7blCYtF1MDQbN1xnq4vv0H168hfJCGzMDHggkYagmXK0kxQgpqdo
 ZAlhpIEpFOJ5Psgxy5dzfF33+D6ctfDTf8SIrPjnBR5MsIehrQOHEJ10HnR/pfFWNQAJ
 R25LIuqc+Ali5ljsPqple7w0qXGiswyr/Aa6jbLLTwapxr+mR3Lw4hbZQmCuPaVqnWPb WA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrvs004b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKtDJ1026670;
        Sat, 28 Jan 2023 00:07:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6g5jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S0799536897036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E68420040;
        Sat, 28 Jan 2023 00:07:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23CCB2004F;
        Sat, 28 Jan 2023 00:07:09 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 11/31] selftests/bpf: Fix cgrp_local_storage on s390x
Date:   Sat, 28 Jan 2023 01:06:30 +0100
Message-Id: <20230128000650.1516334-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EHGAFX5cFxRvVB4BAXOHA78s0freuKdm
X-Proofpoint-GUID: EHGAFX5cFxRvVB4BAXOHA78s0freuKdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync the definition of socket_cookie between the eBPF program and the
test. Currently the test works by accident, since on little-endian it
is sometimes acceptable to access u64 as u32.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
index 33a2776737e7..2cc759956e3b 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
@@ -16,7 +16,7 @@
 
 struct socket_cookie {
 	__u64 cookie_key;
-	__u32 cookie_value;
+	__u64 cookie_value;
 };
 
 static void test_tp_btf(int cgroup_fd)
-- 
2.39.1

