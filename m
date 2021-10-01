Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2198041F6BD
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhJAVRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:17:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230112AbhJAVRs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Oct 2021 17:17:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191LCJ5w004051;
        Fri, 1 Oct 2021 17:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z/xggs5OISnNXHx6TTnbq/JZ9Ad2OyICBd+x33e5QcQ=;
 b=am0SyVsD1xPb8Wm8DBlQW3+9IeryL4GQYqL8c4d1h9pridcWbRv84Og1u6DIsK4aRFo5
 CHLSU3MVnYHwXRQEuI3r2PDDquKnUF0WaoCNLrxA5UNoLulsEhbdyzMHW3ljam6+8pv6
 9VQjHtrAbOqyYIdcmwt+hMruJTcWy2tXL+ShlwLcDeTLIjBNslDOvXC8zPJCCiW6JUqz
 6ZdzdYSFJ9nWg1GkJCdzes83fpckxmkcDsGz3TBzev6hGFPS0Ti8+zmIMIGz9yFomuod
 C7UMFxmE/iidcAS8Ys39zTgfUfLmpQOR+ijKEORp1Pe0JhZJStYkIPllbz5TLmh1XWeg Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bea1pr1pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:45 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 191LCS7i004300;
        Fri, 1 Oct 2021 17:15:44 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bea1pr1pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 191L7X5F019345;
        Fri, 1 Oct 2021 21:15:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3bc11fk32v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 21:15:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 191LASpv52822518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 21:10:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3C4A4C040;
        Fri,  1 Oct 2021 21:15:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24F584C058;
        Fri,  1 Oct 2021 21:15:37 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.54.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Oct 2021 21:15:36 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 6/9] powerpc/bpf: Fix BPF_SUB when imm == 0x80000000
Date:   Sat,  2 Oct 2021 02:44:52 +0530
Message-Id: <1912a409447071f46ac6cc957ce8edea0e5232b7.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gpKvQuxrTavz6gtITYkOR3_tmnuKf-wt
X-Proofpoint-ORIG-GUID: iHGg6YGyxyQLgZfikDldsHJvsfE4q2tc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010147
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We aren't handling subtraction involving an immediate value of
0x80000000 properly. Fix the same.

Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index ffb7a2877a8469..4641a50e82d50d 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -333,15 +333,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
 		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
 		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
-			if (BPF_OP(code) == BPF_SUB)
-				imm = -imm;
-			if (imm) {
-				if (imm >= -32768 && imm < 32768)
-					EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
-				else {
-					PPC_LI32(b2p[TMP_REG_1], imm);
+			if (imm > -32768 && imm < 32768) {
+				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg,
+					BPF_OP(code) == BPF_SUB ? IMM_L(-imm) : IMM_L(imm)));
+			} else {
+				PPC_LI32(b2p[TMP_REG_1], imm);
+				if (BPF_OP(code) == BPF_SUB)
+					EMIT(PPC_RAW_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]));
+				else
 					EMIT(PPC_RAW_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]));
-				}
 			}
 			goto bpf_alu32_trunc;
 		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
-- 
2.33.0

