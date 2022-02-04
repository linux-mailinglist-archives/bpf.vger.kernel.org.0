Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5804A92FC
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiBDEUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55496 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356925AbiBDEUa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21436O4X017326;
        Fri, 4 Feb 2022 04:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UmNP3qCGoC+YUEQLAXP1k5C0+R8+ZzfMDoEUna51Cqw=;
 b=K/8I4RHUxEg8RXl9C4JCuGgVD48PPgi9hG4uudORwQXfS3qcG//YPej7zQt9Q4YXOGVa
 OGGpXpMl/gIxKcs9ZJlbjUYMzY8Ye4qTy3fislRXf6NMpKP66/2Vt8Hhw+5Mia2wyrlG
 bNOrq8y9Zq2a7WUVpjAzshTvsIkiQa0YKntaQ5x533D9SolhhcCDfEdoSbiO2CWm0f8c
 hD380sx1hVDhrJ8ADyphoAu/rVFmt+q8rZuwjAnmvrSEIhkTwiURUj++Zj1Jj0Erbcpw
 smYUD1/FF9pIsz6aylY10qTv2L4bsmQ7XCXP30otn87/NJBsb3FAaz8xIhAuwS1PMMPY tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx8vrd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:05 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2144G3eB012116;
        Fri, 4 Feb 2022 04:20:05 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0qx8vrcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:05 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144DTQV021513;
        Fri, 4 Feb 2022 04:20:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3e0r0y92pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144K0AZ42402300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:20:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04B2BA404D;
        Fri,  4 Feb 2022 04:20:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ADEBA405D;
        Fri,  4 Feb 2022 04:19:59 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:19:59 +0000 (GMT)
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
Subject: [PATCH bpf-next v2 02/10] s390/bpf: Add orig_gpr2 to user_pt_regs
Date:   Fri,  4 Feb 2022 05:19:47 +0100
Message-Id: <20220204041955.1958263-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y6V4Vq2EQ8o4NBQTATmW4Mtgu6buTBAl
X-Proofpoint-ORIG-GUID: yE6abGUx2by8wwfJCodrPKdlbooNN1Fp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=944
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

user_pt_regs is used by eBPF in order to access userspace registers -
see commit 466698e654e8 ("s390/bpf: correct broken uapi for
BPF_PROG_TYPE_PERF_EVENT program type"). In order to access the first
syscall argument from eBPF programs, we need to export orig_gpr2.

args member is not in use since commit 56e62a737028 ("s390: convert to
generic entry"), so move orig_gpr2 in its place.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h      | 3 +--
 arch/s390/include/uapi/asm/ptrace.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 4ffa8e7f0ed3..0278bacd61be 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -80,12 +80,11 @@ struct pt_regs {
 	union {
 		user_pt_regs user_regs;
 		struct {
-			unsigned long args[1];
+			unsigned long orig_gpr2;
 			psw_t psw;
 			unsigned long gprs[NUM_GPRS];
 		};
 	};
-	unsigned long orig_gpr2;
 	union {
 		struct {
 			unsigned int int_code;
diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index ad64d673b5e6..d0cc737b8151 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -292,7 +292,7 @@ typedef struct {
  * the in-kernel pt_regs structure to user space.
  */
 typedef struct {
-	unsigned long args[1];
+	unsigned long orig_gpr2;
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
 } user_pt_regs;
-- 
2.34.1

