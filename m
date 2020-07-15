Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F70221871
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGOXeF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 19:34:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbgGOXeF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 19:34:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FNWUku159043;
        Wed, 15 Jul 2020 19:33:52 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329apy4dtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:33:52 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FNLKcD007574;
        Wed, 15 Jul 2020 23:33:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 327527vymq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 23:33:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FNXllR24641956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 23:33:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D82A4054;
        Wed, 15 Jul 2020 23:33:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4863DA4060;
        Wed, 15 Jul 2020 23:33:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.186.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 23:33:47 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/4] s390/kernel: unify EX_TABLE* implementations
Date:   Thu, 16 Jul 2020 01:32:58 +0200
Message-Id: <20200715233301.933201-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200715233301.933201-1-iii@linux.ibm.com>
References: <20200715233301.933201-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150171
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace three implementations with one using using __stringify_in_c
macro conveniently "borrowed" from powerpc and microblaze.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/asm-const.h | 12 +++++++++++
 arch/s390/include/asm/linkage.h   | 34 ++++++++++---------------------
 2 files changed, 23 insertions(+), 23 deletions(-)
 create mode 100644 arch/s390/include/asm/asm-const.h

diff --git a/arch/s390/include/asm/asm-const.h b/arch/s390/include/asm/asm-const.h
new file mode 100644
index 000000000000..11f615eb0066
--- /dev/null
+++ b/arch/s390/include/asm/asm-const.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_ASM_CONST_H
+#define _ASM_S390_ASM_CONST_H
+
+#ifdef __ASSEMBLY__
+#  define stringify_in_c(...)	__VA_ARGS__
+#else
+/* This version of stringify will deal with commas... */
+#  define __stringify_in_c(...)	#__VA_ARGS__
+#  define stringify_in_c(...)	__stringify_in_c(__VA_ARGS__) " "
+#endif
+#endif /* _ASM_S390_ASM_CONST_H */
diff --git a/arch/s390/include/asm/linkage.h b/arch/s390/include/asm/linkage.h
index 7f22262b0e46..1b52c07b5642 100644
--- a/arch/s390/include/asm/linkage.h
+++ b/arch/s390/include/asm/linkage.h
@@ -2,38 +2,26 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
+#include <asm/asm-const.h>
 #include <linux/stringify.h>
 
 #define __ALIGN .align 4, 0x07
 #define __ALIGN_STR __stringify(__ALIGN)
 
-#ifndef __ASSEMBLY__
-
 /*
  * Helper macro for exception table entries
  */
-#define EX_TABLE(_fault, _target)	\
-	".section __ex_table,\"a\"\n"	\
-	".align	4\n"			\
-	".long	(" #_fault ") - .\n"	\
-	".long	(" #_target ") - .\n"	\
-	".previous\n"
-
-#else /* __ASSEMBLY__ */
 
-#define EX_TABLE(_fault, _target)	\
-	.section __ex_table,"a"	;	\
-	.align	4 ;			\
-	.long	(_fault) - . ;		\
-	.long	(_target) - . ;		\
-	.previous
+#define __EX_TABLE(_section, _fault, _target)				\
+	stringify_in_c(.section	_section,"a";)				\
+	stringify_in_c(.align	4;)					\
+	stringify_in_c(.long	(_fault) - .;)				\
+	stringify_in_c(.long	(_target) - .;)				\
+	stringify_in_c(.previous)
 
-#define EX_TABLE_DMA(_fault, _target)	\
-	.section .dma.ex_table, "a" ;	\
-	.align	4 ;			\
-	.long	(_fault) - . ;		\
-	.long	(_target) - . ;		\
-	.previous
+#define EX_TABLE(_fault, _target)					\
+	__EX_TABLE(__ex_table, _fault, _target)
+#define EX_TABLE_DMA(_fault, _target)					\
+	__EX_TABLE(.dma.ex_table, _fault, _target)
 
-#endif /* __ASSEMBLY__ */
 #endif
-- 
2.25.4

