Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273DD2240D7
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGQQzk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 12:55:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgGQQzk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Jul 2020 12:55:40 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HGZgiJ060100;
        Fri, 17 Jul 2020 12:55:27 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792yeph9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 12:55:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HGntZm010477;
        Fri, 17 Jul 2020 16:55:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 327527kh09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 16:55:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HGtLG331523320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 16:55:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0BDA405B;
        Fri, 17 Jul 2020 16:55:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68A54A405F;
        Fri, 17 Jul 2020 16:55:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.6.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 16:55:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 2/5] s390/bpf: fix sign extension in branch_ku
Date:   Fri, 17 Jul 2020 18:53:23 +0200
Message-Id: <20200717165326.6786-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200717165326.6786-1-iii@linux.ibm.com>
References: <20200717165326.6786-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_08:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170117
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both signed and unsigned variants of BPF_JMP | BPF_K require
sign-extending the immediate. JIT emits cgfi for the signed case,
which is correct, and clgfi for the unsigned case, which is not
correct: clgfi zero-extends the immediate.

s390 does not provide an instruction that does sign-extension and
unsigned comparison at the same time. Therefore, fix by first loading
the sign-extended immediate into work register REG_1 and proceeding
as if it's BPF_X.

Fixes: 4e9b4a6883dd ("s390/bpf: Use relative long branches")
Reported-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8fe7bdfc8d15..67608f6092f8 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1507,21 +1507,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		}
 		break;
 branch_ku:
-		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-		/* clfi or clgfi %dst,imm */
-		EMIT6_IMM(is_jmp32 ? 0xc20f0000 : 0xc20e0000,
-			  dst_reg, imm);
-		if (!is_first_pass(jit) &&
-		    can_use_rel(jit, addrs[i + off + 1])) {
-			/* brc mask,off */
-			EMIT4_PCREL_RIC(0xa7040000,
-					mask >> 12, addrs[i + off + 1]);
-		} else {
-			/* brcl mask,off */
-			EMIT6_PCREL_RILC(0xc0040000,
-					 mask >> 12, addrs[i + off + 1]);
-		}
-		break;
+		/* lgfi %w1,imm (load sign extend imm) */
+		src_reg = REG_1;
+		EMIT6_IMM(0xc0010000, src_reg, imm);
+		goto branch_xu;
 branch_xs:
 		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 		if (!is_first_pass(jit) &&
-- 
2.25.4

