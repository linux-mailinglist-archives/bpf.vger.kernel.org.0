Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D032673E
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBZTKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:10:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56322 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230142AbhBZTKK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 14:10:10 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QJ4Vfp098886;
        Fri, 26 Feb 2021 14:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VB318XGD5et5tOVSKp/Ke29FOTebmv7PAoa7LCi678M=;
 b=iaG4c2SLcuOAxqz+q7O6JjB9FPJVNwTqkH2z5Z7e+A2yMH0kuRepQ3HSA+11ioeJoggv
 JEII3C08Vpcm6z+LgZbO37U9rK5f2gBs5xjLjm44Mle8fxyJfQRlaqwUHXMWcVIQb7EX
 AB+HUzfeHojoB/srjigWWz6gIaEpdplW2DMf9zYbMvh+um0ovhAJ3tDz2dAXAzisMzz3
 6aBKPWQzCBtS1QKoM88BBU7s+3xEJlBdDrxS7oY05+OUOCEFp4kHHfJG3yyglA84/W6R
 cp++kA+g4CKEWiHu4GwN6lS5PZP7XvzpXsj43kfV/KrPDEno2pgXUCMF3lEoeh1CLg3+ yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y6jkrdwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 14:09:16 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QJ9EeL009658;
        Fri, 26 Feb 2021 19:09:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt285k6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 19:09:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QJ9BrO29098494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 19:09:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 849D4AE05A;
        Fri, 26 Feb 2021 19:09:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11556AE056;
        Fri, 26 Feb 2021 19:09:11 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 19:09:10 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     bpf@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 bpf-next] selftests/bpf: Use the last page in test_snprintf_btf on s390
Date:   Fri, 26 Feb 2021 20:09:08 +0100
Message-Id: <20210226190908.115706-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260138
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_snprintf_btf fails on s390, because NULL points to a readable
struct lowcore there. Fix by using the last page instead.

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

v2: https://lore.kernel.org/bpf/20210226182014.115347-1-iii@linux.ibm.com/
v2 -> v3: Heiko mentioned that using _REGION1_SIZE is not future-proof.
          We had a private discussion and came to the conclusion that
          the the last page is good enough.

 .../testing/selftests/bpf/progs/netif_receive_skb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index 6b670039ea67..c3669967067e 100644
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
+		bpf_printk("printing %p should generate error, got (%d)",
+			   BADPTR, __ret);
 		ret = -ERANGE;
 	}
 
-- 
2.29.2

