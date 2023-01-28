Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8042C67F2B6
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjA1AHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjA1AHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50B8CAB1
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:32 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RMppnr011807;
        Sat, 28 Jan 2023 00:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+W70fm5IgKyTn3jSNI3+x95koEmSjQtlvPeTWsODmIs=;
 b=td/iaLz801MRtK+7rUa5ViszhEgR+cf4O5PfUNsjXedruMtqtFuCfVbGz5EExtfDiHTz
 pDwvVjsE4jxbQl9ZHYQoLEWQeCrFQ7HSGk6QaYvLXD8/yKS+QFIuVKNl79ONbYPOWMi1
 3gwr6hV0hLGy3NlldjBTg+017YkEYmWqDcK1I2oZrgFVThLc5/IeqeF85IlCg0wEPrTj
 T4qivn0PR0aErA2rV9xyAGclLOpRWTbA5r8w1/ICZBysRDrs5F6beQ+8n+/BIsodg2rP
 3fM31Lcdr2QCtpAlW80K2+meX0WCK2fiAe5hvGBLEx8o0womsLFvBYZIZNHMeOgZY35d mA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncqsdha3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKO0jL026714;
        Sat, 28 Jan 2023 00:07:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6g5jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07EQr50004352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67B8D20040;
        Sat, 28 Jan 2023 00:07:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E58A920043;
        Sat, 28 Jan 2023 00:07:13 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:13 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 16/31] selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
Date:   Sat, 28 Jan 2023 01:06:35 +0100
Message-Id: <20230128000650.1516334-17-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QkLKRuFozP4tfQOCwoWenHR6ducZFv6_
X-Proofpoint-ORIG-GUID: QkLKRuFozP4tfQOCwoWenHR6ducZFv6_
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

s390x cache line size is 256 bytes, so skb_shared_info must be aligned
on a much larger boundary than for x86.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c  | 7 ++++++-
 .../selftests/bpf/progs/test_xdp_adjust_tail_grow.c       | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 39973ea1ce43..f09505f8b038 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -76,10 +76,15 @@ static void test_xdp_adjust_tail_grow2(void)
 {
 	const char *file = "./test_xdp_adjust_tail_grow.bpf.o";
 	char buf[4096]; /* avoid segfault: large buf to hold grow results */
-	int tailroom = 320; /* SKB_DATA_ALIGN(sizeof(struct skb_shared_info))*/;
 	struct bpf_object *obj;
 	int err, cnt, i;
 	int max_grow, prog_fd;
+	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
+#if defined(__s390x__)
+	int tailroom = 512;
+#else
+	int tailroom = 320;
+#endif
 
 	LIBBPF_OPTS(bpf_test_run_opts, tattr,
 		.repeat		= 1,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index 53b64c999450..297c260fc364 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -9,6 +9,12 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 	void *data = (void *)(long)xdp->data;
 	int data_len = bpf_xdp_get_buff_len(xdp);
 	int offset = 0;
+	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
+#if defined(__TARGET_ARCH_s390)
+	int tailroom = 512;
+#else
+	int tailroom = 320;
+#endif
 
 	/* Data length determine test case */
 
@@ -20,7 +26,7 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 		offset = 128;
 	} else if (data_len == 128) {
 		/* Max tail grow 3520 */
-		offset = 4096 - 256 - 320 - data_len;
+		offset = 4096 - 256 - tailroom - data_len;
 	} else if (data_len == 9000) {
 		offset = 10;
 	} else if (data_len == 9001) {
-- 
2.39.1

