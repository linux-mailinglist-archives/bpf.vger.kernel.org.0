Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0867BEC3
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjAYVjz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjAYVjw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:39:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1755B4A238
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:39:46 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKLcxd010746;
        Wed, 25 Jan 2023 21:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+W70fm5IgKyTn3jSNI3+x95koEmSjQtlvPeTWsODmIs=;
 b=igukgCW23KtKXmiJxEsi4S1U4T97d+L8Y4NZefhGOAl1LIsEH18OEBovIbt3pzsE6QhP
 1W/G7cpssSR/fjWNj2mH/BJ0IsFPHy3ZlDzvZlW7mSc0tSPiJslopmph7ZUWotS1qfa+
 8Lkojs4sMRk+QKVO1bBpOMNQnpQ/7UIMkqgPJI1IN92yEZHwGxtYAI+kV18fjgQrqrLH
 GveRz9abPWrMXQK1Je5cHtjyqOiitqBZzQtGgdWDZcP4OzFRldvtYGMadUgtx8PfGEwo
 OwaGVzS/4XsQtPvPnAm7McDY8KmLoJT2fDc7Wvo/hXkjW4TTpTOkA6pkgjXR2RUoUnyC Gw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb8n9ee0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:33 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEg4XU031975;
        Wed, 25 Jan 2023 21:39:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p641ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:39:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PLdRI925887406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 21:39:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA3A2004D;
        Wed, 25 Jan 2023 21:39:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF10120043;
        Wed, 25 Jan 2023 21:39:26 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.149])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 21:39:26 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 15/24] selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
Date:   Wed, 25 Jan 2023 22:38:08 +0100
Message-Id: <20230125213817.1424447-16-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125213817.1424447-1-iii@linux.ibm.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bnbxM7s6C4vJ466mkpAhqClZ5DVr_juM
X-Proofpoint-ORIG-GUID: bnbxM7s6C4vJ466mkpAhqClZ5DVr_juM
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

