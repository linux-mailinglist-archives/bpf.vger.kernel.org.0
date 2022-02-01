Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824844A68A9
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 00:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiBAXmX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 18:42:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242928AbiBAXmW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 18:42:22 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211Lxqqm027559;
        Tue, 1 Feb 2022 23:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YSdw4wYhv5oPWZIu89HcEQ+IZ7SqzqDutI5c1xWNqHg=;
 b=DgAwaxIl/kImoa9CS6vQW6pC73OLEbfRAAgOkL2pAIklzIK/Sk/FmQ0P3rA3GDmQUx00
 H20gHRl/+B2R4VyRFywmKZLMJ9cSejLOnQqyB1RKvOfqIjG/DPE/feNDLtDKQsIOKua9
 nV/OEdkwmzjoHcUM1+xCUIRfyM7u/388r9c2NhiuHljCGCewZhSlKX5YmA+HLk+umIJu
 o+wOr49zq6XwFBzyN9Ye/E+51ZFV6ep2jONeoboOjW4ofju7+X+EAhL8uCEt5Zw/LYvQ
 njV38zBDT+JBWD68e8h21QnXELPv4DOsPxhqApLUXijlFdcbJqHBndJFJHaSZylTTN0X kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyd8t1e55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:10 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211NcgkW014883;
        Tue, 1 Feb 2022 23:42:10 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyd8t1e4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211NcNNY017791;
        Tue, 1 Feb 2022 23:42:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3dvw79fdf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211Ng5vd43385232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 23:42:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 732C211C054;
        Tue,  1 Feb 2022 23:42:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F301A11C04C;
        Tue,  1 Feb 2022 23:42:04 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 23:42:04 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 3/3] libbpf: Fix accessing the first syscall argument on s390
Date:   Wed,  2 Feb 2022 00:42:00 +0100
Message-Id: <20220201234200.1836443-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201234200.1836443-1-iii@linux.ibm.com>
References: <20220201234200.1836443-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IKe8p3FMTLBc8KRMCmEdvqucHsMdjZXq
X-Proofpoint-ORIG-GUID: yCBXrWtRqr65plqgiXxixDaNeQGCOzGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010130
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On s390, the first syscall argument should be accessed via orig_gpr2
(see arch/s390/include/asm/syscall.h). Currently gpr[2] is used
instead, leading to bpf_syscall_macro test failure. Fix by adding
__PT_PARM1_REG_SYSCALL macro, similar to the existing
__PT_PARM4_REG_SYSCALL.

Fixes: d084df3b7a4c ("libbpf: Fix the incorrect register read for syscalls on x86_64")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 032ba809f3e5..9d6ff24c7abd 100644
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
@@ -265,7 +266,11 @@ struct pt_regs;
 
 #endif
 
+#ifdef __PT_PARM1_REG_SYSCALL
+#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSCALL)
+#else /* __PT_PARM1_REG_SYSCALL */
 #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#endif
 #define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
 #define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #ifdef __PT_PARM4_REG_SYSCALL
@@ -275,7 +280,11 @@ struct pt_regs;
 #endif
 #define PT_REGS_PARM5_SYSCALL(x) PT_REGS_PARM5(x)
 
+#ifdef __PT_PARM1_REG_SYSCALL
+#define PT_REGS_PARM1_CORE_SYSCALL(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG_SYSCALL)
+#else /* __PT_PARM1_REG_SYSCALL */
 #define PT_REGS_PARM1_CORE_SYSCALL(x) PT_REGS_PARM1_CORE(x)
+#endif
 #define PT_REGS_PARM2_CORE_SYSCALL(x) PT_REGS_PARM2_CORE(x)
 #define PT_REGS_PARM3_CORE_SYSCALL(x) PT_REGS_PARM3_CORE(x)
 #ifdef __PT_PARM4_REG_SYSCALL
-- 
2.34.1

