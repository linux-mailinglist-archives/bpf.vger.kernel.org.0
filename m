Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB02F2D7A
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfKGLcm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 06:32:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727437AbfKGLcm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 06:32:42 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7BTRAJ062152
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 06:32:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w4j1192nx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 06:32:38 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 7 Nov 2019 11:32:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 11:32:14 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7BWDj536372602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 11:32:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06A7442042;
        Thu,  7 Nov 2019 11:32:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B61774204B;
        Thu,  7 Nov 2019 11:32:12 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.204])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 11:32:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: wrap JIT macro parameter usages in parentheses
Date:   Thu,  7 Nov 2019 12:32:11 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110711-4275-0000-0000-0000037B9EF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110711-4276-0000-0000-0000388EEFFF
Message-Id: <20191107113211.90105-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070116
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change does not alter JIT behavior; it only makes it possible to
safely invoke JIT macros with complex arguments in the future.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 62 ++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ce88211b9c6c..027e6b80dcc4 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -131,13 +131,13 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define _EMIT2(op)						\
 ({								\
 	if (jit->prg_buf)					\
-		*(u16 *) (jit->prg_buf + jit->prg) = op;	\
+		*(u16 *) (jit->prg_buf + jit->prg) = (op);	\
 	jit->prg += 2;						\
 })
 
 #define EMIT2(op, b1, b2)					\
 ({								\
-	_EMIT2(op | reg(b1, b2));				\
+	_EMIT2((op) | reg(b1, b2));				\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
@@ -145,20 +145,20 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define _EMIT4(op)						\
 ({								\
 	if (jit->prg_buf)					\
-		*(u32 *) (jit->prg_buf + jit->prg) = op;	\
+		*(u32 *) (jit->prg_buf + jit->prg) = (op);	\
 	jit->prg += 4;						\
 })
 
 #define EMIT4(op, b1, b2)					\
 ({								\
-	_EMIT4(op | reg(b1, b2));				\
+	_EMIT4((op) | reg(b1, b2));				\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
 
 #define EMIT4_RRF(op, b1, b2, b3)				\
 ({								\
-	_EMIT4(op | reg_high(b3) << 8 | reg(b1, b2));		\
+	_EMIT4((op) | reg_high(b3) << 8 | reg(b1, b2));		\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 	REG_SET_SEEN(b3);					\
@@ -167,13 +167,13 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define _EMIT4_DISP(op, disp)					\
 ({								\
 	unsigned int __disp = (disp) & 0xfff;			\
-	_EMIT4(op | __disp);					\
+	_EMIT4((op) | __disp);					\
 })
 
 #define EMIT4_DISP(op, b1, b2, disp)				\
 ({								\
-	_EMIT4_DISP(op | reg_high(b1) << 16 |			\
-		    reg_high(b2) << 8, disp);			\
+	_EMIT4_DISP((op) | reg_high(b1) << 16 |			\
+		    reg_high(b2) << 8, (disp));			\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
@@ -181,21 +181,21 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define EMIT4_IMM(op, b1, imm)					\
 ({								\
 	unsigned int __imm = (imm) & 0xffff;			\
-	_EMIT4(op | reg_high(b1) << 16 | __imm);		\
+	_EMIT4((op) | reg_high(b1) << 16 | __imm);		\
 	REG_SET_SEEN(b1);					\
 })
 
 #define EMIT4_PCREL(op, pcrel)					\
 ({								\
 	long __pcrel = ((pcrel) >> 1) & 0xffff;			\
-	_EMIT4(op | __pcrel);					\
+	_EMIT4((op) | __pcrel);					\
 })
 
 #define _EMIT6(op1, op2)					\
 ({								\
 	if (jit->prg_buf) {					\
-		*(u32 *) (jit->prg_buf + jit->prg) = op1;	\
-		*(u16 *) (jit->prg_buf + jit->prg + 4) = op2;	\
+		*(u32 *) (jit->prg_buf + jit->prg) = (op1);	\
+		*(u16 *) (jit->prg_buf + jit->prg + 4) = (op2);	\
 	}							\
 	jit->prg += 6;						\
 })
@@ -203,20 +203,20 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define _EMIT6_DISP(op1, op2, disp)				\
 ({								\
 	unsigned int __disp = (disp) & 0xfff;			\
-	_EMIT6(op1 | __disp, op2);				\
+	_EMIT6((op1) | __disp, op2);				\
 })
 
 #define _EMIT6_DISP_LH(op1, op2, disp)				\
 ({								\
-	u32 _disp = (u32) disp;					\
+	u32 _disp = (u32) (disp);				\
 	unsigned int __disp_h = _disp & 0xff000;		\
 	unsigned int __disp_l = _disp & 0x00fff;		\
-	_EMIT6(op1 | __disp_l, op2 | __disp_h >> 4);		\
+	_EMIT6((op1) | __disp_l, (op2) | __disp_h >> 4);	\
 })
 
 #define EMIT6_DISP_LH(op1, op2, b1, b2, b3, disp)		\
 ({								\
-	_EMIT6_DISP_LH(op1 | reg(b1, b2) << 16 |		\
+	_EMIT6_DISP_LH((op1) | reg(b1, b2) << 16 |		\
 		       reg_high(b3) << 8, op2, disp);		\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
@@ -226,8 +226,8 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define EMIT6_PCREL_LABEL(op1, op2, b1, b2, label, mask)	\
 ({								\
 	int rel = (jit->labels[label] - jit->prg) >> 1;		\
-	_EMIT6(op1 | reg(b1, b2) << 16 | (rel & 0xffff),	\
-	       op2 | mask << 12);				\
+	_EMIT6((op1) | reg(b1, b2) << 16 | (rel & 0xffff),	\
+	       (op2) | (mask) << 12);				\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
@@ -235,43 +235,43 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define EMIT6_PCREL_IMM_LABEL(op1, op2, b1, imm, label, mask)	\
 ({								\
 	int rel = (jit->labels[label] - jit->prg) >> 1;		\
-	_EMIT6(op1 | (reg_high(b1) | mask) << 16 |		\
-		(rel & 0xffff), op2 | (imm & 0xff) << 8);	\
+	_EMIT6((op1) | (reg_high(b1) | (mask)) << 16 |		\
+		(rel & 0xffff), (op2) | ((imm) & 0xff) << 8);	\
 	REG_SET_SEEN(b1);					\
-	BUILD_BUG_ON(((unsigned long) imm) > 0xff);		\
+	BUILD_BUG_ON(((unsigned long) (imm)) > 0xff);		\
 })
 
 #define EMIT6_PCREL(op1, op2, b1, b2, i, off, mask)		\
 ({								\
 	/* Branch instruction needs 6 bytes */			\
-	int rel = (addrs[i + off + 1] - (addrs[i + 1] - 6)) / 2;\
-	_EMIT6(op1 | reg(b1, b2) << 16 | (rel & 0xffff), op2 | mask);	\
+	int rel = (addrs[(i) + (off) + 1] - (addrs[(i) + 1] - 6)) / 2;\
+	_EMIT6((op1) | reg(b1, b2) << 16 | (rel & 0xffff), (op2) | (mask));\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
 
 #define EMIT6_PCREL_RILB(op, b, target)				\
 ({								\
-	int rel = (target - jit->prg) / 2;			\
-	_EMIT6(op | reg_high(b) << 16 | rel >> 16, rel & 0xffff);	\
+	int rel = ((target) - jit->prg) / 2;			\
+	_EMIT6((op) | reg_high(b) << 16 | rel >> 16, rel & 0xffff);\
 	REG_SET_SEEN(b);					\
 })
 
 #define EMIT6_PCREL_RIL(op, target)				\
 ({								\
-	int rel = (target - jit->prg) / 2;			\
-	_EMIT6(op | rel >> 16, rel & 0xffff);			\
+	int rel = ((target) - jit->prg) / 2;			\
+	_EMIT6((op) | rel >> 16, rel & 0xffff);			\
 })
 
 #define _EMIT6_IMM(op, imm)					\
 ({								\
 	unsigned int __imm = (imm);				\
-	_EMIT6(op | (__imm >> 16), __imm & 0xffff);		\
+	_EMIT6((op) | (__imm >> 16), __imm & 0xffff);		\
 })
 
 #define EMIT6_IMM(op, b1, imm)					\
 ({								\
-	_EMIT6_IMM(op | reg_high(b1) << 16, imm);		\
+	_EMIT6_IMM((op) | reg_high(b1) << 16, imm);		\
 	REG_SET_SEEN(b1);					\
 })
 
@@ -281,7 +281,7 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	ret = jit->lit - jit->base_ip;				\
 	jit->seen |= SEEN_LITERAL;				\
 	if (jit->prg_buf)					\
-		*(u32 *) (jit->prg_buf + jit->lit) = (u32) val;	\
+		*(u32 *) (jit->prg_buf + jit->lit) = (u32) (val);\
 	jit->lit += 4;						\
 	ret;							\
 })
@@ -292,7 +292,7 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	ret = jit->lit - jit->base_ip;				\
 	jit->seen |= SEEN_LITERAL;				\
 	if (jit->prg_buf)					\
-		*(u64 *) (jit->prg_buf + jit->lit) = (u64) val;	\
+		*(u64 *) (jit->prg_buf + jit->lit) = (u64) (val);\
 	jit->lit += 8;						\
 	ret;							\
 })
-- 
2.23.0

