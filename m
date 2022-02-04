Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29814A92FD
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 05:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbiBDEUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 23:20:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232223AbiBDEU3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 23:20:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21441eE9028363;
        Fri, 4 Feb 2022 04:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ja3OC2q3TDApsQm4GnQZqFA0Yp1B1OYhdYj+AGkaqKY=;
 b=KcGJwmiTd6i42o+w0wxSESZ+1y79QgmTiJV0ABLTn0qYQaiTZwWDyVny1K9HcBeVWclf
 E0pfrowaWqGaOCo5jDOL4slHx2+sZyMEQCIxZgej/oXs8BPol4Ei9WLM3RJwA/cPHy3T
 aQ65sxh3oS8/rAbWy9jWUJFVollonrWDiKLnKRXzgzFNAyhKU1fqk/FQq/CcBTP3lFBo
 EikDkwsDLClIcqT95BotkKC+5e23aQREBoU/A8uc/Xd6M22gyeB+MXEH3Xx5/sqc+3j2
 HVHwjj7K1bcPhXa24kKzq/dk0ejkf5/wAJNXWeeJhsy+DT0Tr9EpXgHmDZPpP+JFAPMV 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrrg8v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:06 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2144K6PG029819;
        Fri, 4 Feb 2022 04:20:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e0vrrg8uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2144DbAN019588;
        Fri, 4 Feb 2022 04:20:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3e0r0sh58t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 04:20:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2144A4tc45875546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 04:10:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92F0A4055;
        Fri,  4 Feb 2022 04:19:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54FDCA4040;
        Fri,  4 Feb 2022 04:19:58 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Feb 2022 04:19:58 +0000 (GMT)
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
Subject: [PATCH bpf-next v2 01/10] arm64/bpf: Add orig_x0 to user_pt_regs
Date:   Fri,  4 Feb 2022 05:19:46 +0100
Message-Id: <20220204041955.1958263-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204041955.1958263-1-iii@linux.ibm.com>
References: <20220204041955.1958263-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ldkQRlB6T9oa2nRS7LE-PDHro68mSAzx
X-Proofpoint-ORIG-GUID: Qcp83zqBMww_JgmFTRc5DCIRNFCy2lML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_01,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=978 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040019
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

orig_x0 is needed in order to access the first syscall argument from
eBPF programs.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/arm64/include/asm/ptrace.h      | 2 +-
 arch/arm64/include/uapi/asm/ptrace.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 41b332c054ab..1be22f7870f8 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -183,9 +183,9 @@ struct pt_regs {
 			u64 sp;
 			u64 pc;
 			u64 pstate;
+			u64 orig_x0;
 		};
 	};
-	u64 orig_x0;
 #ifdef __AARCH64EB__
 	u32 unused2;
 	s32 syscallno;
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 758ae984ff97..3c118c5b0893 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -90,6 +90,7 @@ struct user_pt_regs {
 	__u64		sp;
 	__u64		pc;
 	__u64		pstate;
+	__u64		orig_x0;
 };
 
 struct user_fpsimd_state {
-- 
2.34.1

