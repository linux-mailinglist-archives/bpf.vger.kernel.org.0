Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCC4A9B71
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 15:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiBDOu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 09:50:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238829AbiBDOu4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 09:50:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214CpS7t016579;
        Fri, 4 Feb 2022 14:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fOANTYNjGcu1Z1XO/KfDfJFvphJrALnvU+5juVHSfqY=;
 b=iEEaAfZdnc8fUcvSoPbg3iihfoW0ho3S4jmh0WOI+36TYuA3WdIg2qIb8aupUpcbOPpR
 M2TlGi9LylfwCxmpVh/DVUHOjaRVsNjyizLFnWR/iqTITihornc20Yfgwq8WWMGMAsy9
 FYoxuUBz9TU8mxpUgNs4yAyeCHWb2Xf3uQP2P2YUo9RongHfG6/oy4SC7ueaWAHxMf3D
 lGGZyBPw+xksceQttHRxRdn9y9g0db5cglbvbI8HYpiClumdpgPNehtR4fqmT9qEeQ13
 njcu1s5DBpQlKH/4TESPS/KJC9+cuOEYl4o1zlCQn9Hu4CU7LuTJJLltwMNwk5v071hB 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx382vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:38 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214DGrak028094;
        Fri, 4 Feb 2022 14:50:37 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx382ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214ElQce007240;
        Fri, 4 Feb 2022 14:50:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3e0r0x5j0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214EoVfX41091366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 14:50:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAAD85204E;
        Fri,  4 Feb 2022 14:50:31 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E9E7B52051;
        Fri,  4 Feb 2022 14:50:30 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 11/11] libbpf: Fix accessing the first syscall argument on s390
Date:   Fri,  4 Feb 2022 15:50:18 +0100
Message-Id: <20220204145018.1983773-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204145018.1983773-1-iii@linux.ibm.com>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pE3iUm8dkTtE7kyrMOpO6Fefi_ekhvQn
X-Proofpoint-GUID: qL0bz2KbmbxxHHpO6x1yt9g_tuMbhRcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040082
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On s390, the first syscall argument should be accessed via orig_gpr2
(see arch/s390/include/asm/syscall.h). Currently gpr[2] is used
instead, leading to bpf_syscall_macro test failure.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 169d47aa0a79..cf980e54d331 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -117,6 +117,7 @@
 /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
 #define __PT_PARM1_REG gprs[2]
+#define __PT_PARM1_REG_SYSCALL orig_gpr2
 #define __PT_PARM2_REG gprs[3]
 #define __PT_PARM3_REG gprs[4]
 #define __PT_PARM4_REG gprs[5]
-- 
2.34.1

