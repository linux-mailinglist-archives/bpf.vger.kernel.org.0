Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA44A9B66
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 15:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359320AbiBDOur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 09:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6428 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233343AbiBDOuq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 09:50:46 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214D8DRk022406;
        Fri, 4 Feb 2022 14:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ja3OC2q3TDApsQm4GnQZqFA0Yp1B1OYhdYj+AGkaqKY=;
 b=D1Tdk2M2WiOLb0lbU28+zBhv6UDABslhHzrB9ur8iZCNT4PquxeImw3vE/sNxbnFX7pw
 ZLKDbpHuf9veFjSavNh1g3rcU8e8XZTNtcWKKSJE2kTgKCbyYPfkg2wSuRH9p9J9XkR5
 kLoRF5JlB2Flp9XaLlDAwITNMhIYKviPy5AKqep1jpsuVofbNPRu7TTRp5eNvLt3G5mM
 kBqKOBFrvjb5aXJg+xAxf6sC14J6naEfXdpQcp4kOv0Hoq1+xrH7pmaKjJ+TfC05Kdqv
 M/bS8x5tnCr/2d08zOJHRPpux2dtv6iM+2M0pWfyqP3vSuewQ9HlC099Mp+oO0ks18Su Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0rj5phhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:27 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 214EALI0029509;
        Fri, 4 Feb 2022 14:50:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e0rj5phgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 214EjWYi002486;
        Fri, 4 Feb 2022 14:50:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3e0r10dumx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 14:50:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 214EeQXa46793158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Feb 2022 14:40:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F9C252050;
        Fri,  4 Feb 2022 14:50:22 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A920952051;
        Fri,  4 Feb 2022 14:50:21 +0000 (GMT)
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
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 01/11] arm64/bpf: Add orig_x0 to user_pt_regs
Date:   Fri,  4 Feb 2022 15:50:08 +0100
Message-Id: <20220204145018.1983773-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204145018.1983773-1-iii@linux.ibm.com>
References: <20220204145018.1983773-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kfAQ3JEA7qcMLp0UVATQOBnif_f80CxC
X-Proofpoint-GUID: NXJG3NllExqVt2wX8bgWpCnP03a5Dn16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=998 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040082
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

