Return-Path: <bpf+bounces-10378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F37A5F47
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF841C20C35
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914133989;
	Tue, 19 Sep 2023 10:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165473FB34
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:29 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A21AC
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:14:05 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JA8abu005620;
	Tue, 19 Sep 2023 10:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SWudXKpO6AYlqFR+5edL211VyDcI+BRjyumnbFu1H98=;
 b=IJ3mXBLpWt6zvcAyYkzcl2YPYK3WhTgMjRwFFqGwb2/AGbhehhjgOdmpRb//q/pt4q58
 B+vd03kEwCsjPxJgpN61COlhEd4Ezg9OD/UQEOQlKTJBRsL/c0vjq4jy1NMPhYcwh23N
 a4Ka/7zyHiilpWZTgcXXEliStKtM6qk9Q7QjojyTSgV5Lgmnlbhglu279CKb7bPH5zti
 NjTs9sq9YFBzoQoVqcKHcXjsKYR/FQW00Mi1m0KqDp2KRmR19ZI7v7K1vQTpYv5L+2In
 MTGiUtV6rz1ziXGmhnujtS2TC/ZX4s7LaC0oX9QuobfUvlegDqxZQZ+rBXm09YyENKpu +Q== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t78k59gtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9L4fT010371;
	Tue, 19 Sep 2023 10:13:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwk2uah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADkec41615942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 396C52004F;
	Tue, 19 Sep 2023 10:13:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5EB120067;
	Tue, 19 Sep 2023 10:13:45 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 04/10] s390/bpf: Implement BPF_MOV | BPF_X with sign-extension
Date: Tue, 19 Sep 2023 12:09:06 +0200
Message-ID: <20230919101336.2223655-5-iii@linux.ibm.com>
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
X-Proofpoint-GUID: 0Rnv_RY4T6oc072IvhVh-rXMQymPbaI4
X-Proofpoint-ORIG-GUID: 0Rnv_RY4T6oc072IvhVh-rXMQymPbaI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=991
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the cpuv4 register-to-register move with sign extension. It
is distinguished from the normal moves by non-zero values in
insn->off, which determine the source size. s390x has instructions to
deal with all of them: lbr, lhr, lgbr, lghr and lgfr.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 48 ++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index e6a643f63ebf..fc8bbddf6533 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -795,15 +795,47 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_MOV
 	 */
-	case BPF_ALU | BPF_MOV | BPF_X: /* dst = (u32) src */
-		/* llgfr %dst,%src */
-		EMIT4(0xb9160000, dst_reg, src_reg);
-		if (insn_is_zext(&insn[1]))
-			insn_count = 2;
+	case BPF_ALU | BPF_MOV | BPF_X:
+		switch (insn->off) {
+		case 0: /* DST = (u32) SRC */
+			/* llgfr %dst,%src */
+			EMIT4(0xb9160000, dst_reg, src_reg);
+			if (insn_is_zext(&insn[1]))
+				insn_count = 2;
+			break;
+		case 8: /* DST = (u32)(s8) SRC */
+			/* lbr %dst,%src */
+			EMIT4(0xb9260000, dst_reg, src_reg);
+			/* llgfr %dst,%dst */
+			EMIT4(0xb9160000, dst_reg, dst_reg);
+			break;
+		case 16: /* DST = (u32)(s16) SRC */
+			/* lhr %dst,%src */
+			EMIT4(0xb9270000, dst_reg, src_reg);
+			/* llgfr %dst,%dst */
+			EMIT4(0xb9160000, dst_reg, dst_reg);
+			break;
+		}
 		break;
-	case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
-		/* lgr %dst,%src */
-		EMIT4(0xb9040000, dst_reg, src_reg);
+	case BPF_ALU64 | BPF_MOV | BPF_X:
+		switch (insn->off) {
+		case 0: /* DST = SRC */
+			/* lgr %dst,%src */
+			EMIT4(0xb9040000, dst_reg, src_reg);
+			break;
+		case 8: /* DST = (s8) SRC */
+			/* lgbr %dst,%src */
+			EMIT4(0xb9060000, dst_reg, src_reg);
+			break;
+		case 16: /* DST = (s16) SRC */
+			/* lghr %dst,%src */
+			EMIT4(0xb9070000, dst_reg, src_reg);
+			break;
+		case 32: /* DST = (s32) SRC */
+			/* lgfr %dst,%src */
+			EMIT4(0xb9140000, dst_reg, src_reg);
+			break;
+		}
 		break;
 	case BPF_ALU | BPF_MOV | BPF_K: /* dst = (u32) imm */
 		/* llilf %dst,imm */
-- 
2.41.0


