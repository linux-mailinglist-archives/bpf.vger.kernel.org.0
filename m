Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7308E4863DC
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiAFLqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 06:46:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238456AbiAFLqr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 06:46:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2069SwZf003359;
        Thu, 6 Jan 2022 11:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QyrKKqFMlA3HlxTHpdletB1r93pItzhA2z96t5pmqMg=;
 b=CI0dBot1K4+j742vNr6Y8mgHHIS3zg+qd7dD7FWxlVF01az1DnvxWPNbX9vn2gCcJndc
 TcQTPUy/xgx+Xq+fVqb+MFvqzzAsMNt3utIEoBwX0zRr+ewSbA1nK7c0Kh0E4hRcEKJA
 2Zj8rn755yHC02Bh7uf3A1vEn6kXbXat5d/c2bdnWwpeJEsABkSDQSBP1Bk+VVciwQ15
 c9oH9vbCmcADfUbwuoljSqOOWwx/ekxfXgIhvQ3U/lKrhqZXhXA/wObyGVXbzclhnEnP
 DKcn9pSkcopIZXPeybT7aDB2MXrSQdIgDVYMlMRC6N4spONJl4PHiqZwbD+GhBHeARg3 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddtjpdvs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:27 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 206BhHtW023118;
        Thu, 6 Jan 2022 11:46:26 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ddtjpdvrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 206Bg43E026571;
        Thu, 6 Jan 2022 11:46:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ddn4e4mpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jan 2022 11:46:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 206BkLrR43712852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jan 2022 11:46:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8386BA405F;
        Thu,  6 Jan 2022 11:46:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3D3AA4054;
        Thu,  6 Jan 2022 11:46:18 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.91.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jan 2022 11:46:18 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, <bpf@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 08/13] powerpc64/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06
Date:   Thu,  6 Jan 2022 17:15:12 +0530
Message-Id: <d1e51c6fdf572062cf3009a751c3406bda01b832.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ga1TMl7fCY88WkoFC4ZsxLyJ15_l3xC_
X-Proofpoint-ORIG-GUID: -fmEbkVnkt1v0X1BNPKphObdWvwwTIMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_04,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=624
 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2112160000 definitions=main-2201060081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Johan reported the below crash with test_bpf on ppc64 e5500:

  test_bpf: #296 ALU_END_FROM_LE 64: 0x0123456789abcdef -> 0x67452301 jited:1
  Oops: Exception in kernel mode, sig: 4 [#1]
  BE PAGE_SIZE=4K SMP NR_CPUS=24 QEMU e500
  Modules linked in: test_bpf(+)
  CPU: 0 PID: 76 Comm: insmod Not tainted 5.14.0-03771-g98c2059e008a-dirty #1
  NIP:  8000000000061c3c LR: 80000000006dea64 CTR: 8000000000061c18
  REGS: c0000000032d3420 TRAP: 0700   Not tainted (5.14.0-03771-g98c2059e008a-dirty)
  MSR:  0000000080089000 <EE,ME>  CR: 88002822  XER: 20000000 IRQMASK: 0
  <...>
  NIP [8000000000061c3c] 0x8000000000061c3c
  LR [80000000006dea64] .__run_one+0x104/0x17c [test_bpf]
  Call Trace:
   .__run_one+0x60/0x17c [test_bpf] (unreliable)
   .test_bpf_init+0x6a8/0xdc8 [test_bpf]
   .do_one_initcall+0x6c/0x28c
   .do_init_module+0x68/0x28c
   .load_module+0x2460/0x2abc
   .__do_sys_init_module+0x120/0x18c
   .system_call_exception+0x110/0x1b8
   system_call_common+0xf0/0x210
  --- interrupt: c00 at 0x101d0acc
  <...>
  ---[ end trace 47b2bf19090bb3d0 ]---

  Illegal instruction

The illegal instruction turned out to be 'ldbrx' emitted for
BPF_FROM_[L|B]E, which was only introduced in ISA v2.06. Guard use of
the same and implement an alternative approach for older processors.

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Reported-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h |  1 +
 arch/powerpc/net/bpf_jit_comp64.c     | 22 +++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index efad07081cc0e5..9675303b724e93 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -500,6 +500,7 @@
 #define PPC_RAW_LDX(r, base, b)		(0x7c00002a | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_RAW_LHZ(r, base, i)		(0xa0000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LHBRX(r, base, b)	(0x7c00062c | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
+#define PPC_RAW_LWBRX(r, base, b)	(0x7c00042c | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_RAW_LDBRX(r, base, b)	(0x7c000428 | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_RAW_STWCX(s, a, b)		(0x7c00012d | ___PPC_RS(s) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_CMPWI(a, i)		(0x2c000000 | ___PPC_RA(a) | IMM_L(i))
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 48d2ca3fe126dd..7d38b4be26c3a5 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -634,17 +634,21 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_MR(dst_reg, b2p[TMP_REG_1]));
 				break;
 			case 64:
-				/*
-				 * Way easier and faster(?) to store the value
-				 * into stack and then use ldbrx
-				 *
-				 * ctx->seen will be reliable in pass2, but
-				 * the instructions generated will remain the
-				 * same across all passes
-				 */
+				/* Store the value to stack and then use byte-reverse loads */
 				PPC_BPF_STL(dst_reg, 1, bpf_jit_stack_local(ctx));
 				EMIT(PPC_RAW_ADDI(b2p[TMP_REG_1], 1, bpf_jit_stack_local(ctx)));
-				EMIT(PPC_RAW_LDBRX(dst_reg, 0, b2p[TMP_REG_1]));
+				if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+					EMIT(PPC_RAW_LDBRX(dst_reg, 0, b2p[TMP_REG_1]));
+				} else {
+					EMIT(PPC_RAW_LWBRX(dst_reg, 0, b2p[TMP_REG_1]));
+					if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
+						EMIT(PPC_RAW_SLDI(dst_reg, dst_reg, 32));
+					EMIT(PPC_RAW_LI(b2p[TMP_REG_2], 4));
+					EMIT(PPC_RAW_LWBRX(b2p[TMP_REG_2], b2p[TMP_REG_2], b2p[TMP_REG_1]));
+					if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+						EMIT(PPC_RAW_SLDI(b2p[TMP_REG_2], b2p[TMP_REG_2], 32));
+					EMIT(PPC_RAW_OR(dst_reg, dst_reg, b2p[TMP_REG_2]));
+				}
 				break;
 			}
 			break;
-- 
2.34.1

