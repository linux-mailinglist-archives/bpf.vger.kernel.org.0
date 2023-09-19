Return-Path: <bpf+bounces-10377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EDA7A5F45
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 12:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAAD281FC9
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08533983;
	Tue, 19 Sep 2023 10:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF392E655
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 10:14:31 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F591B4
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 03:14:07 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JA7VkM017449;
	Tue, 19 Sep 2023 10:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pUTcEHkId84jNeY9ekkuhIig28/dPN1asx44yj44N4k=;
 b=DTE3RxDv11m2zzhczqqZvx7rq+Ppo8BG5MAk+TCyB5b3AtZza5FUa/sHsi8TZzQCOvZ3
 n+/go6BBKA7BCO98mmMRe2F6fX20f014v7QswHO88fbFUXFvtojwTZDBmZ+Lfzqj+rIP
 mOUC7CsqR+Ls2BZ9lAqHWIJjJ4FUGCSdKCp4hUMy+W8dmQiRgcGeGT1mH8QP4w6bT8oh
 PriklU8XBym6X7rg8L4mFnrrXF2Qe/qWfq93JN+SZzLPIMf4ragv+7ObEst6Nduf8V3w
 XfJQs8LJywPXnwYlhRtY4dZbJ6dM2hug14gXInuMizAn3XP6m8BPSCcXLElbvb70UCOk Gg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t76tkcanq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38J9L4fV010371;
	Tue, 19 Sep 2023 10:13:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwk2ub3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Sep 2023 10:13:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JADoRH18088608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 10:13:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A028320067;
	Tue, 19 Sep 2023 10:13:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 183D82004F;
	Tue, 19 Sep 2023 10:13:50 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.67.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Sep 2023 10:13:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 07/10] s390/bpf: Implement unconditional jump with 32-bit offset
Date: Tue, 19 Sep 2023 12:09:09 +0200
Message-ID: <20230919101336.2223655-8-iii@linux.ibm.com>
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
X-Proofpoint-GUID: aBtJcJR36a2_vvAKT_r1JWzoiCG4sCV6
X-Proofpoint-ORIG-GUID: aBtJcJR36a2_vvAKT_r1JWzoiCG4sCV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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
index ea8ae2163109..55634e4c6815 100644
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


