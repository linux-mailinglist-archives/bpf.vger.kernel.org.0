Return-Path: <bpf+bounces-8950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED578D197
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC3D1C20A5E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30015B3;
	Wed, 30 Aug 2023 01:12:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B4136F
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:12:08 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D3583
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:12:07 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0mli5010919;
	Wed, 30 Aug 2023 01:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UTejo2S13yFAR3z5TIjSuSkm6wxQiIH6AkzOHpiL6lM=;
 b=eKlFuS3cwYDsPL2sjG9Qnbw3qNjAdzj9YOJhdM3D4G5vf2sTLCbsWkjv1+hraWrz6naF
 WPGbf9pr1bE1OKEN27TjTbh/0JWaTA3y8b/0Aw+vonlMoBULC82028n8bYh1EA5s5MDp
 YewiIpoEQS1dONfofV2vFYaHk7ZdasxvkpV3+Ug96RFFmPEcwg3eMi+fLRRBqW2FzltY
 PMan1s0aZFOmt/uRNEh/c3CzPqO54bX+8/UPIvmBvhPPIb+zSae4Ph2/rgaU4BHaqVeE
 nLvRv+FAMyQYdZeSSuWNC3mWDfBWSnxqY2YKGXfpjohYyhEO+WT7Zg7gurcb+MZSe+zs PQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu0xgxsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TNcgBG004928;
	Wed, 30 Aug 2023 01:11:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqsraee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1Bnml44826978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9DC020040;
	Wed, 30 Aug 2023 01:11:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67AB52004B;
	Wed, 30 Aug 2023 01:11:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 06/11] s390/bpf: Implement BPF_MEMSX
Date: Wed, 30 Aug 2023 03:07:47 +0200
Message-ID: <20230830011128.1415752-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830011128.1415752-1-iii@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q6JccSn4MhafjhMm8FildKgm-3yABrzo
X-Proofpoint-ORIG-GUID: q6JccSn4MhafjhMm8FildKgm-3yABrzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the cpuv4 load with sign-extension, which is encoded as
BPF_MEMSX (and, for internal uses cases only, BPF_PROBE_MEMSX).

This is the same as BPF_MEM and BPF_PROBE_MEM, but with sign
extension instead of zero extension, and s390x has the necessary
instructions: lgb, lgh and lgf.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index da6fb4669973..841c5f8ead15 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -670,15 +670,18 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 static int get_probe_mem_regno(const u8 *insn)
 {
 	/*
-	 * insn must point to llgc, llgh, llgf or lg, which have destination
-	 * register at the same position.
+	 * insn must point to llgc, llgh, llgf, lg, lgb, lgh or lgf, which have
+	 * destination register at the same position.
 	 */
-	if (insn[0] != 0xe3) /* common llgc, llgh, llgf and lg prefix */
+	if (insn[0] != 0xe3) /* common prefix */
 		return -1;
 	if (insn[5] != 0x90 && /* llgc */
 	    insn[5] != 0x91 && /* llgh */
 	    insn[5] != 0x16 && /* llgf */
-	    insn[5] != 0x04) /* lg */
+	    insn[5] != 0x04 && /* lg */
+	    insn[5] != 0x77 && /* lgb */
+	    insn[5] != 0x15 && /* lgh */
+	    insn[5] != 0x14) /* lgf */
 		return -1;
 	return insn[1] >> 4;
 }
@@ -788,7 +791,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	int err;
 
 	if (BPF_CLASS(insn->code) == BPF_LDX &&
-	    BPF_MODE(insn->code) == BPF_PROBE_MEM)
+	    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+	     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
 		probe_prg = jit->prg;
 
 	switch (insn->code) {
@@ -1406,6 +1410,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
+	case BPF_LDX | BPF_MEMSX | BPF_B: /* dst = *(s8 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
+		/* lgb %dst,0(off,%src) */
+		EMIT6_DISP_LH(0xe3000000, 0x0077, dst_reg, src_reg, REG_0, off);
+		jit->seen |= SEEN_MEM;
+		break;
 	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
 		/* llgh %dst,0(off,%src) */
@@ -1414,6 +1424,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
+	case BPF_LDX | BPF_MEMSX | BPF_H: /* dst = *(s16 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
+		/* lgh %dst,0(off,%src) */
+		EMIT6_DISP_LH(0xe3000000, 0x0015, dst_reg, src_reg, REG_0, off);
+		jit->seen |= SEEN_MEM;
+		break;
 	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
 		/* llgf %dst,off(%src) */
@@ -1422,6 +1438,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
+	case BPF_LDX | BPF_MEMSX | BPF_W: /* dst = *(s32 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
+		/* lgf %dst,off(%src) */
+		jit->seen |= SEEN_MEM;
+		EMIT6_DISP_LH(0xe3000000, 0x0014, dst_reg, src_reg, REG_0, off);
+		break;
 	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 		/* lg %dst,0(off,%src) */
-- 
2.41.0


