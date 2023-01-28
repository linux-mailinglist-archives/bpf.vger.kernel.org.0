Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA367F2BE
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjA1AIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjA1AHz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A8126FE
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:39 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNrZGq021400;
        Sat, 28 Jan 2023 00:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yexce1rMvh4CPqKOBgLQJBDqOQEGbfG2pIcR2yFUdQU=;
 b=e3oXOCqbQZ0nylQxGOiQHCdJ2yamuBUAQdHRtLD6956Oao/0bsJHb7G/w9ZaZ9rObwX9
 etCAUo7vLNc/ttJDrlFqBmcOWZteStbOp/LpRW/hodSAtg3N+JOXvUcaUsTASrTq9AeW
 rsjK/jLb0ei3Gjjf1FPd4THNLDbsZIymLdpR1u8eLIeW5AMu6kj/iLhGwvPp9dp2VRBJ
 aRKQGylS6zoAvcqCDS1IBk6Q6vo/ESCay8NSd+9IlzVBmENwgoc76xpShh45vXkEUw/S
 tTAKHiabMaj12MQs9lUbnDF+AESaZF/U5ADt1CdbNW6b4pR/UHaTEA3gnaIaPs9DoLWL 1g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncrpf0a0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:27 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RGRJEk016231;
        Sat, 28 Jan 2023 00:07:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dtcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07JCI23069384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32C5A2004E;
        Sat, 28 Jan 2023 00:07:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9B7520040;
        Sat, 28 Jan 2023 00:07:18 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:18 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 21/31] libbpf: Simplify barrier_var()
Date:   Sat, 28 Jan 2023 01:06:40 +0100
Message-Id: <20230128000650.1516334-22-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vlZ7HWMelBgix1TPO9Gp7YlUkflHNYXS
X-Proofpoint-GUID: vlZ7HWMelBgix1TPO9Gp7YlUkflHNYXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=900 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use a single "+r" constraint instead of the separate "=r" and "0".

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index d37c4fe2849d..5ec1871acb2f 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -109,7 +109,7 @@
  * This is a variable-specific variant of more global barrier().
  */
 #ifndef barrier_var
-#define barrier_var(var) asm volatile("" : "=r"(var) : "0"(var))
+#define barrier_var(var) asm volatile("" : "+r"(var))
 #endif
 
 /*
-- 
2.39.1

