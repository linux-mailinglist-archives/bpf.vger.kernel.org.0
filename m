Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1133266D9
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 19:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZSVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 13:21:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47112 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229571AbhBZSVR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 13:21:17 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QI4d7F109047;
        Fri, 26 Feb 2021 13:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=o23eoPHB/4sKTYHM3qarAwF0V0Jcda4+LriyI7LQ9tY=;
 b=l31zw1kKgzk//oLaTTYAqwMyEpWR1xiHeF0leiX1yhkoGj4eXdQiHpTMMFunlk7ElTGh
 rNTY7idBQMbTH1dCtMiSHm+JjjZHEXQpVbO/UarNXvgFKOecGep5EMnZ0vlYe6e0qUCC
 pZBwPzBDhn2HChD/UQjAGKzSU2Qe+qTX4QQb6w1jHGE3UxEfF/aY5zG0h6JZJXqbVmZO
 W2W0i1fK7xlUWEtO1xYWV+qE4zToMcAnzGx4iO+cSaCZl6htWca/YrUmphCvsc7DxG/y
 x9sL+6Iwgal2KEDxaXpC158mKX90tzXtP42QR5o7r6MXfCW50TfLQeRXj6H0sH/NTMAM 3A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y5rv0qw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 13:20:22 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QI86AT002524;
        Fri, 26 Feb 2021 18:20:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 36tt28awkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 18:20:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QIK4bU37945784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 18:20:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 263F052051;
        Fri, 26 Feb 2021 18:20:17 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B31685204E;
        Fri, 26 Feb 2021 18:20:16 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: Use _REGION1_SIZE in test_snprintf_btf on s390
Date:   Fri, 26 Feb 2021 19:20:14 +0100
Message-Id: <20210226182014.115347-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260130
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_snprintf_btf fails on s390, because NULL points to a readable
struct lowcore there. Fix by using _REGION1_SIZE instead.

Error message example:

    printing 0000000000000000 should generate error, got (361)

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/bpf/20210226135923.114211-1-iii@linux.ibm.com/
v1 -> v2: Yonghong suggested to add the pointer value to the error
          message.
          I've noticed that I've been passing BADPTR as flags, therefore
          the fix worked only by accident. Put it into p.ptr where it
          belongs.

 .../testing/selftests/bpf/progs/netif_receive_skb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 6b670039ea67..4d158de73c2d 100644
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
@@ -113,11 +120,11 @@ int BPF_PROG(trace_netif_receive_skb, struct sk_buff *skb)
 	}
 
 	/* Check invalid ptr value */
-	p.ptr = 0;
+	p.ptr = BADPTR;
 	__ret = bpf_snprintf_btf(str, STRSIZE, &p, sizeof(p), 0);
 	if (__ret >= 0) {
-		bpf_printk("printing NULL should generate error, got (%d)",
-			   __ret);
+		bpf_printk("printing %p should generate error, got (%d)",
+			   BADPTR, __ret);
 		ret = -ERANGE;
 	}
 
-- 
2.29.2

