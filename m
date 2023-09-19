Return-Path: <bpf+bounces-10376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A937A5F44
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B34D1C20C5F
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9C3FB2C;
	Tue, 19 Sep 2023 10:14:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59CD2E64C
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:29 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257212F
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:14:04 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JA92c2015377;
	Tue, 19 Sep 2023 10:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bVJQ6nsyjWBVPUpywz32xoXfDVrens1Dd+vrYDNKfPI=;
 b=SFIQspSeIItCotLslYn4yqo5ISJEx296SqEtjyGyyKoUxSWiL0HHLYNtHkgpWLubGJmi
 5ZBams1LclkxhBHzP6I00NLgdwx9t2dHKv1M05x+yS1hs1kwUv1kxNVNxGaTZE/KQulC
 kiPeqZvRlSJKobU6EE10gfNO1ClMAoRU6aTe/lTd1YAjiQaqRSN74dQ42nFG6cF+dDCU
 OSH0NZDiF8RcJ586+jCuFKG3ZdqFW8hvQRroAzHrMpSB3UZoI9W/rKtSJpqfJ5xSG2Nc
 znldg1SrBfhsoaSHOTa4gqrpnx7meVM+OhD6p+h5knvUyzHIdT9Rq+9wsV1zQ9EoDe1w Ag== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7454qtr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8TJFO011656;
	Tue, 19 Sep 2023 10:13:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpnb7r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADl9g63766988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45A362006A;
	Tue, 19 Sep 2023 10:13:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31192004F;
	Tue, 19 Sep 2023 10:13:46 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 05/10] s390/bpf: Implement BPF_MEMSX
Date: Tue, 19 Sep 2023 12:09:07 +0200
Message-ID: <20230919101336.2223655-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919101336.2223655-1-iii@linux.ibm.com>
References: <20230919101336.2223655-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N8b26yzMSCaqlemGeK6Th-1--zXSJKw0
X-Proofpoint-ORIG-GUID: N8b26yzMSCaqlemGeK6Th-1--zXSJKw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190085
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
index fc8bbddf6533..e00e7cda298f 100644
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


