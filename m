Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37E67F2AE
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjA1AHl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjA1AHj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5C8BBBA
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:29 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RM880N037327;
        Sat, 28 Jan 2023 00:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9QO2kgJPDXTBG02++KmJ7OJrpP6gPSNuoZ28LW6gv7U=;
 b=JDosrVtgfULSOC6zYE1yrGSZzszGw6DJoUKpXGped+N4No8uVYF6Esnz2NkDwJv6RPLM
 axj5IBGir+Dk00O0zAMx3CPZSEAoxHgS5I0eMz0GpNPjqslHC4YIZERVtCUYNg2nWojc
 PuILe7Y3bxcqNFteFBPiQkhdsMlg9pvvne+jr+G2bGs4/NlCalYttYa27BxZdMnDQy2Q
 meI0h4n/R2guiZPrGoM0Bohh5qT8vjkMxOlkgH6rNk92Pwt4Xki2Ow4Nx9T2YtvvT05v
 uvUMIK1SZJjMzuftsQP1+Lu0EVSqtn8FbjF3MDt/eJGMS5eKl0m/yYAgy2k7Jsv9axRp kA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncm3tec7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:14 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNEgFS007800;
        Sat, 28 Jan 2023 00:07:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dtkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S0783t43450738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D8A320043;
        Sat, 28 Jan 2023 00:07:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 106CA2004B;
        Sat, 28 Jan 2023 00:07:08 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:07 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 10/31] selftests/bpf: Fix xdp_do_redirect on s390x
Date:   Sat, 28 Jan 2023 01:06:29 +0100
Message-Id: <20230128000650.1516334-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X9wwA8kynGnvLxchcstxPPcSl3KeycRZ
X-Proofpoint-ORIG-GUID: X9wwA8kynGnvLxchcstxPPcSl3KeycRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
on a much larger boundary than for x86. This makes the maximum packet
size smaller.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index a50971c6cf4a..ac70e871d62f 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -65,7 +65,11 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int fd)
 /* The maximum permissible size is: PAGE_SIZE - sizeof(struct xdp_page_head) -
  * sizeof(struct skb_shared_info) - XDP_PACKET_HEADROOM = 3368 bytes
  */
+#if defined(__s390x__)
+#define MAX_PKT_SIZE 3176
+#else
 #define MAX_PKT_SIZE 3368
+#endif
 static void test_max_pkt_size(int fd)
 {
 	char data[MAX_PKT_SIZE + 1] = {};
-- 
2.39.1

