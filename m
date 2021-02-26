Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95119326396
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 15:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBZOAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 09:00:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhBZOAX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 09:00:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QDX3VA117117;
        Fri, 26 Feb 2021 08:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=R9QhCkKQMEgudW/U7FoZMmgiudsSTW4taF3h8IyBAdU=;
 b=GimqxyvpjYvMZ11mP5xLL0miEVHFuIIaIJai0efDKMyehAXsMOi/tl5OiU5AISPlhAi7
 G8AOCSzSWTw8qg82YqZgqJbGs7zPmtSERPyMG3usNkGWQehLJyVUSerKWz/f++xGyt+/
 EGT9ZW9/eUQU9JfOdswPjPoXpd5s5Xn0DxotHTle/7L4dFmrQRmnjq26cYHEc9vcrhPu
 bRIi6HFv+bga46/STt4gXUSe5Pmf/Ynf72V2lgsviSpNBy8lWgdrpyLUBdLmNWR7LZ4k
 I4dmbKPqXvDVou+iVDfSxiosIs5FXRgFdB2SNom3tcv6Glp3kAtoZX38PGdheNY+CXL3 qQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xn10e1yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 08:59:29 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QDvjRQ003087;
        Fri, 26 Feb 2021 13:59:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 36tsphau79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 13:59:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QDxB1311600268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 13:59:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95B6B11C058;
        Fri, 26 Feb 2021 13:59:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AF4C11C04A;
        Fri, 26 Feb 2021 13:59:24 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 13:59:24 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Use _REGION1_SIZE in test_snprintf_btf on s390
Date:   Fri, 26 Feb 2021 14:59:23 +0100
Message-Id: <20210226135923.114211-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_03:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260104
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_snprintf_btf fails on s390, because NULL points to a readable
struct lowcore there. Fix by using _REGION1_SIZE instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/netif_receive_skb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 6b670039ea67..fa54d2abc41e 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -16,6 +16,13 @@ bool skip = false;
 #define STRSIZE			2048
 #define EXPECTED_STRSIZE	256
 
+#if defined(bpf_target_s390)
+/* NULL points to a readable struct lowcore on s390, so take _REGION1_SIZE */
+#define BADPTR			((void *)(1ULL << 53))
+#else
+#define BADPTR			0
+#endif
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #endif
@@ -114,9 +121,9 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 
 	/* Check invalid ptr value */
 	p.ptr = 0;
-	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
+	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), BADPTR);
 	if (__ret >= 0) {
-		bpf_printk("printing NULL should generate error, got (%d)",
+		bpf_printk("printing BADPTR should generate error, got (%d)",
 			   __ret);
 		ret = -ERANGE;
 	}
-- 
2.29.2

