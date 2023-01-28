Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E267F32E
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjA1Adg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjA1Adf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB61C320
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:33:33 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNuQob009006;
        Sat, 28 Jan 2023 00:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=99dBY6Aa5hLZjVVESF+rPzBBKcaqqgSzJYOryoCA8Zk=;
 b=DqCGTj4MPmPzi/GLy7sAQhwDAMrKycwyPziEmSITuiLXj95ppCy5qLivmjms8r1icfAi
 BM+wtpM2hUKmF6uBf7B9Aw5O0mBz0k39HBEvR3A9vbA+xBkjipOswt3dpduxVDSeJnok
 d0LnKjbdg4+U+CWJik4wCgF3xNJP4r1hC9j8bIPiv68nHpJJcS7ZxYqAYOk/MZ/9pLU1
 rJiT2mnGvFFQXJ03xipHX/m36wCKGvjpcfbJ3xZvieYhf74wbwlRCqzo/nYxJizL7KI1
 J9ARcm2Npl72aE0J2495kUhF6f5GenYCdOKakhM4vq97MVhgP4U4fzQSpV25YX5z0FhC Cw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrqernqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:33:19 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R4DrR1006823;
        Sat, 28 Jan 2023 00:07:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dufy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S074a443385184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 742CB2004B;
        Sat, 28 Jan 2023 00:07:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9F3520040;
        Sat, 28 Jan 2023 00:07:03 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 06/31] selftests/bpf: Fix kfree_skb on s390x
Date:   Sat, 28 Jan 2023 01:06:25 +0100
Message-Id: <20230128000650.1516334-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gtWzE0XmAP407ArJY6LAcO8I2mmlZV9a
X-Proofpoint-GUID: gtWzE0XmAP407ArJY6LAcO8I2mmlZV9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=976 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301280003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

h_proto is big-endian; use htons() in order to make comparison work on
both little- and big-endian machines.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index 73579370bfbd..c07991544a78 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -36,7 +36,7 @@ static void on_sample(void *ctx, int cpu, void *data, __u32 size)
 		  "cb32_0 %x != %x\n",
 		  meta->cb32_0, cb.cb32[0]))
 		return;
-	if (CHECK(pkt_v6->eth.h_proto != 0xdd86, "check_eth",
+	if (CHECK(pkt_v6->eth.h_proto != htons(ETH_P_IPV6), "check_eth",
 		  "h_proto %x\n", pkt_v6->eth.h_proto))
 		return;
 	if (CHECK(pkt_v6->iph.nexthdr != 6, "check_ip",
-- 
2.39.1

