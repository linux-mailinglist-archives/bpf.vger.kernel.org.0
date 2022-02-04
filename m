Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3134A9302
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356927AbiBDEUh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356925AbiBDEUg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:36 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2143OKjR010594;
        Fri, 4 Feb 2022 04:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=egM1L1sH7Nic6f1M2/NzF/5uEkXzgIz7BNjGTk0Ehvo=;
 b=nUciH+h3/yIR2sKMBR6MBx7wmee+8QopU6LXYSdZZat6T7U9yjHe1XRPqlO32NyqC/ry
 vu4eJBlqdaW5A3afkrZU06XHRdcmGqdsyGJl5GLB+JSR9D2fHmgCvnB7QA1kpzecP+fN
 HAc5fndjd5fWZDShp1+xD0xZhNNnATVnwVH+ei23Zkdi80tGC8khDvN2ZbgDODt1vhfr
 VYiwVtLvu+vudBG+I2UUrUOHNkuj287ChnzkGeCtfEHgnJ5XzQLWKGNkN7WTsVDla7Jr
 FJ11UPI26mMBc2iS5r+w8pIfZNYmxHO/PSMRh2J8NaKQv71ykkuA19XtHruYWLheGzWy Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0r1a4p86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:08 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2144J29p027405;
        Fri, 4 Feb 2022 04:20:08 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0r1a4p7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:07 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144D9ri014359;
        Fri, 4 Feb 2022 04:20:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3e0r0u13by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144K2bN38863172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:20:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18107A4040;
        Fri,  4 Feb 2022 04:20:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71161A404D;
        Fri,  4 Feb 2022 04:20:01 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:20:01 +0000 (GMT)
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
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 04/10] libbpf: Add __PT_PARM1_REG_SYSCALL macro
Date:   Fri,  4 Feb 2022 05:19:49 +0100
Message-Id: <20220204041955.1958263-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4sEgNPO0JdbzCP3OuMlkHswz1Eq5_5bs
X-Proofpoint-ORIG-GUID: WOxiVD20uDuc-VWnMFSBWQqFv6uXZ6_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some architectures have a special way to access the first syscall
argument. There already exists __PT_PARM4_REG_SYSCALL for the
fourth argument, so define a similar macro for the first one.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 032ba809f3e5..30f0964f8c9e 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -265,7 +265,11 @@ struct pt_regs;
 
 #endif
 
+#ifdef __PT_PARM1_REG_SYSCALL
+#define PT_REGS_PARM1_SYSCALL(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG_SYSCALL)
+#else /* __PT_PARM1_REG_SYSCALL */
 #define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1(x)
+#endif
 #define PT_REGS_PARM2_SYSCALL(x) PT_REGS_PARM2(x)
 #define PT_REGS_PARM3_SYSCALL(x) PT_REGS_PARM3(x)
 #ifdef __PT_PARM4_REG_SYSCALL
@@ -275,7 +279,11 @@ struct pt_regs;
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

