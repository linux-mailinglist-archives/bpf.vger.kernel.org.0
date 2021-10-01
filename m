Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6A41F6BC
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJAVRo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Oct 2021 17:17:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230112AbhJAVRn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 Oct 2021 17:17:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191KgFqL007707;
        Fri, 1 Oct 2021 17:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HWrt4y2qJpJrMLmbdMZJ2Kkz13DqlfFI4GTWXyOtxWg=;
 b=tYdHKLSWmyXwcNyDjvOqOSJHanFH4yPXJwShJNxWBJPak5xxCmaeNukSlEmYJkOfPEyI
 mb0NKdRbpmscuU4/VQCOEsh+XonNavJP5qz+0PNLwMIVI26GdSFyRJR7t6EZiSXbU3zm
 VXCZDYnjWEVxXrQVJBzrZWHWvwQeBIcfmruAUAcmOfmj1nyKfbi69Z1bA66C/SUDDVer
 Eh/6vv0gx0/UBAH9lgJTmBlGToY92VRHuNE11l566aQ9ZsqoP5xVEmiSSKg/mDSFFo19
 igt6cZ5VWYOmMsvwAMqSFpLnf9h9Up8c7JCVwZeQx5Z6u55nHmANeY+wpBLyTQTLumK3 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3be9kj0n2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:41 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 191Kuril001413;
        Fri, 1 Oct 2021 17:15:41 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3be9kj0n24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 17:15:41 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 191L6K0m021679;
        Fri, 1 Oct 2021 21:15:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3b9u1kx99u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Oct 2021 21:15:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 191LFaJg42664212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Oct 2021 21:15:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C7A14C04E;
        Fri,  1 Oct 2021 21:15:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B87944C05E;
        Fri,  1 Oct 2021 21:15:33 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.54.98])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Oct 2021 21:15:33 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/9] powerpc/bpf: Fix BPF_MOD when imm == 1
Date:   Sat,  2 Oct 2021 02:44:51 +0530
Message-Id: <8cb6a1725cf3c38ca90ed7f195f78a5b5a83bb25.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H86TEXKI0PtTRURQJQWSGitL1I7AOOM1
X-Proofpoint-GUID: 9pOu5ko0XZbILzffZuv1Fj8JAnbitEXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-01_05,2021-10-01_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110010147
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only ignore the operation if dividing by 1.

Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 3351a866ef6207..ffb7a2877a8469 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -391,8 +391,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
 			if (imm == 0)
 				return -EINVAL;
-			else if (imm == 1)
-				goto bpf_alu32_trunc;
+			if (imm == 1) {
+				if (BPF_OP(code) == BPF_DIV) {
+					goto bpf_alu32_trunc;
+				} else {
+					EMIT(PPC_RAW_LI(dst_reg, 0));
+					break;
+				}
+			}
 
 			PPC_LI32(b2p[TMP_REG_1], imm);
 			switch (BPF_CLASS(code)) {
-- 
2.33.0

