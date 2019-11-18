Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4863C100B15
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfKRSES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:04:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfKRSER (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:04:17 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2Vro100577
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:16 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wbxnb4du8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:04:14 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:04:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII4AP843385260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:04:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50AC5AE045;
        Mon, 18 Nov 2019 18:04:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 075FFAE04D;
        Mon, 18 Nov 2019 18:04:10 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:04:09 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 4/6] s390/bpf: use lgrl instead of lg where possible
Date:   Mon, 18 Nov 2019 19:03:38 +0100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
References: <20191118180340.68373-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-4275-0000-0000-0000038125ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-4276-0000-0000-000038949703
Message-Id: <20191118180340.68373-5-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

lg and lgrl have the same performance characteristics, but the former
requires a base register and is subject to long displacement range
limits, while the latter does not. Therefore, lgrl is totally superior
to lg and should be used instead whenever possible.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 964a09fd10f1..6b3f85e4c5b0 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -287,28 +287,38 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	REG_SET_SEEN(b1);					\
 })
 
-#define EMIT_CONST_U32(val)					\
+#define _EMIT_CONST_U32(val)					\
 ({								\
 	unsigned int ret;					\
-	ret = jit->lit32 - jit->base_ip;			\
-	jit->seen |= SEEN_LITERAL;				\
+	ret = jit->lit32;					\
 	if (jit->prg_buf)					\
 		*(u32 *)(jit->prg_buf + jit->lit32) = (u32)(val);\
 	jit->lit32 += 4;					\
 	ret;							\
 })
 
-#define EMIT_CONST_U64(val)					\
+#define EMIT_CONST_U32(val)					\
 ({								\
-	unsigned int ret;					\
-	ret = jit->lit64 - jit->base_ip;			\
 	jit->seen |= SEEN_LITERAL;				\
+	_EMIT_CONST_U32(val) - jit->base_ip;			\
+})
+
+#define _EMIT_CONST_U64(val)					\
+({								\
+	unsigned int ret;					\
+	ret = jit->lit64;					\
 	if (jit->prg_buf)					\
 		*(u64 *)(jit->prg_buf + jit->lit64) = (u64)(val);\
 	jit->lit64 += 8;					\
 	ret;							\
 })
 
+#define EMIT_CONST_U64(val)					\
+({								\
+	jit->seen |= SEEN_LITERAL;				\
+	_EMIT_CONST_U64(val) - jit->base_ip;			\
+})
+
 #define EMIT_ZERO(b1)						\
 ({								\
 	if (!fp->aux->verifier_zext) {				\
@@ -612,9 +622,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		u64 imm64;
 
 		imm64 = (u64)(u32) insn[0].imm | ((u64)(u32) insn[1].imm) << 32;
-		/* lg %dst,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, REG_0, REG_L,
-			      EMIT_CONST_U64(imm64));
+		/* lgrl %dst,imm */
+		EMIT6_PCREL_RILB(0xc4080000, dst_reg, _EMIT_CONST_U64(imm64));
 		insn_count = 2;
 		break;
 	}
@@ -1086,9 +1095,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 		REG_SET_SEEN(BPF_REG_5);
 		jit->seen |= SEEN_FUNC;
-		/* lg %w1,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_W1, REG_0, REG_L,
-			      EMIT_CONST_U64(func));
+		/* lgrl %w1,func */
+		EMIT6_PCREL_RILB(0xc4080000, REG_W1, _EMIT_CONST_U64(func));
 		if (__is_defined(CC_USING_EXPOLINE) && !nospec_disable) {
 			/* brasl %r14,__s390_indirect_jump_r1 */
 			EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
-- 
2.23.0

