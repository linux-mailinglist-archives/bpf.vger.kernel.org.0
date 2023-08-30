Return-Path: <bpf+bounces-8951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559DD78D198
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A9D1C20A7C
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E515BA;
	Wed, 30 Aug 2023 01:12:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6615B8
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:12:10 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8D83
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:12:09 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0a6H8032700;
	Wed, 30 Aug 2023 01:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EI0TD24gFNozZnsGWiegIkox9ngbM30CHInd3NGvBMQ=;
 b=VdmOIfA9dBjtJOK4v+Bpkr3T1m9am69tRkQICkR5FDk8LFpkpDacF02JkUoVeZkRjDmK
 i8on4d00ZrOdzpplV5/m1e5KF4ssia85tuit8LdGRa54ZLR/o/ryoPlOMtE6fRXFWfjf
 F86zGd6/mQCvaTZAqLnWV20sZDYiPvL0EUUPCcTsYHQdLAHGBLthjNhkh0qo1m4d+3W+
 17n4PcVpDPXgh/keirGuH0BaN9FVhF9FZrPlxPrAMSLVMe/yh5SP4TvETLR7yxlIMs4L
 ziiWeoxexmsbJh1xSraSBTXyj/bgUZew/WbnC/C19aNjDVTJ07N2CU2uEn0aixaOg7s2 ww== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu0xgxtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TN16Hr014100;
	Wed, 30 Aug 2023 01:11:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjyjvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1BrlM63111538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758502004D;
	Wed, 30 Aug 2023 01:11:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 005DE20043;
	Wed, 30 Aug 2023 01:11:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 08/11] s390/bpf: Implement unconditional jump with 32-bit offset
Date: Wed, 30 Aug 2023 03:07:49 +0200
Message-ID: <20230830011128.1415752-9-iii@linux.ibm.com>
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
X-Proofpoint-GUID: wckacn4Ts2sDONf6jdTYdcXyEi6C8ipK
X-Proofpoint-ORIG-GUID: wckacn4Ts2sDONf6jdTYdcXyEi6C8ipK
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

Implement the cpuv4 unconditional jump with 32-bit offset, which is
encoded as BPF_JMP32 | BPF_JA and stores the offset in the imm field.
Reuse the existing BPF_JMP | BPF_JA logic.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 4c4cf8c9fec6..b331ab013cfd 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -779,6 +779,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 				 int i, bool extra_pass, u32 stack_depth)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
+	s16 branch_oc_off = insn->off;
 	u32 dst_reg = insn->dst_reg;
 	u32 src_reg = insn->src_reg;
 	int last, insn_count = 1;
@@ -1625,6 +1626,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 * instruction itself (loop) and for BPF with offset 0 we
 	 * branch to the instruction behind the branch.
 	 */
+	case BPF_JMP32 | BPF_JA: /* if (true) */
+		branch_oc_off = imm;
+		fallthrough;
 	case BPF_JMP | BPF_JA: /* if (true) */
 		mask = 0xf000; /* j */
 		goto branch_oc;
@@ -1793,14 +1797,16 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		break;
 branch_oc:
 		if (!is_first_pass(jit) &&
-		    can_use_rel(jit, addrs[i + off + 1])) {
+		    can_use_rel(jit, addrs[i + branch_oc_off + 1])) {
 			/* brc mask,off */
 			EMIT4_PCREL_RIC(0xa7040000,
-					mask >> 12, addrs[i + off + 1]);
+					mask >> 12,
+					addrs[i + branch_oc_off + 1]);
 		} else {
 			/* brcl mask,off */
 			EMIT6_PCREL_RILC(0xc0040000,
-					 mask >> 12, addrs[i + off + 1]);
+					 mask >> 12,
+					 addrs[i + branch_oc_off + 1]);
 		}
 		break;
 	}
-- 
2.41.0


