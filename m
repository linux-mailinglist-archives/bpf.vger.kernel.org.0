Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC98326B9B
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 06:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhB0FS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Feb 2021 00:18:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhB0FS1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Feb 2021 00:18:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11R564q1084631;
        Sat, 27 Feb 2021 00:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qKW0DP58ozh4MFOvayswp6SHIjdBPjO1L3BzBOGOCrk=;
 b=tPwI5YU5d5HPoPYNW0Pn0D6OSxZzhFaH0PZgCf6CV4BxIBTYSQbsnHhG6FWxbpbnBBqx
 G1XTCTnp/tlVLiND2SCfHMN3fnwjOhM3Jh4hz88Kz+5hDyYYmPQOPg2+09QXNJ1CDaaG
 3RwPyMXGLigI/RafvSH2MEJfrvtu5UaWGwgr8xWXZUWXH23e2Xd7PuaJYY7NiOF6mCPn
 QSk/uiy2HCaNVopTElpMZhDLi4bhQisgeM7gflQnqip75XY6DjnAb3LviP7CFNsxaXeV
 Exq3sxfQNSa/hKPcp9ctHNOk5S3uKscnipvs5uUZcbSvHBo+sGR5EX/byXSDzf8g7oQQ XQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xphvg6y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Feb 2021 00:17:34 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11R5CX4T029355;
        Sat, 27 Feb 2021 05:17:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 36ydbgr2j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Feb 2021 05:17:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11R5HFL935455244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Feb 2021 05:17:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ED424C04E;
        Sat, 27 Feb 2021 05:17:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC41F4C044;
        Sat, 27 Feb 2021 05:17:28 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 27 Feb 2021 05:17:28 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     bpf@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 bpf-next] selftests/bpf: Use the last page in test_snprintf_btf on s390
Date:   Sat, 27 Feb 2021 06:17:26 +0100
Message-Id: <20210227051726.121256-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-27_03:2021-02-26,2021-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102270034
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_snprintf_btf fails on s390, because NULL points to a readable
struct lowcore there. Fix by using the last page instead.

Error message example:

    printing fffffffffffff000 should generate error, got (361)

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---


v1: https://lore.kernel.org/bpf/20210226135923.114211-1-iii@linux.ibm.com/
v1 -> v2: Yonghong suggested to add the pointer value to the error
          message.
          I've noticed that I've been passing BADPTR as flags, therefore
          the fix worked only by accident. Put it into p.ptr where it
          belongs.

v2: https://lore.kernel.org/bpf/20210226182014.115347-1-iii@linux.ibm.com/
v2 -> v3: Heiko mentioned that using _REGION1_SIZE is not future-proof.
          We had a private discussion and came to the conclusion that
          the the last page is good enough.

v3: https://lore.kernel.org/bpf/20210226190908.115706-1-iii@linux.ibm.com/
v3 -> v4: Yonghong suggested to print the non-hashed pointer value.

 .../testing/selftests/bpf/progs/netif_receive_skb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 6b670039ea67..1d8918dfbd3f 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -16,6 +16,13 @@ bool skip = false;
 #define STRSIZE			2048
 #define EXPECTED_STRSIZE	256
 
+#if defined(bpf_target_s390)
+/* NULL points to a readable struct lowcore on s390, so take the last page */
+#define BADPTR			((void *)0xFFFFFFFFFFFFF000ULL)
+#else
+#define BADPTR			0
+#endif
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #endif
@@ -113,11 +120,11 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	}
 
 	/* Check invalid ptr value */
-	p.ptr = 0;
+	p.ptr = BADPTR;
 	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
 	if (__ret >= 0) {
-		bpf_printk("printing NULL should generate error, got (%d)",
-			   __ret);
+		bpf_printk("printing %llx should generate error, got (%d)",
+			   (unsigned long long)BADPTR, __ret);
 		ret = -ERANGE;
 	}
 
-- 
2.29.2

