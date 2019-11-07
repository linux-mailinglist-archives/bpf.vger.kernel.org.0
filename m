Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A10F2D97
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 12:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbfKGLkn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 06:40:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbfKGLkn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 06:40:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7BbiIE134114
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 06:40:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4gtdd1mt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 06:40:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 7 Nov 2019 11:40:39 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 11:40:36 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7BdxVU24772936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 11:39:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA2D142042;
        Thu,  7 Nov 2019 11:40:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 841014203F;
        Thu,  7 Nov 2019 11:40:34 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.204])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 11:40:34 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: remove unused SEEN_RET0, SEEN_REG_AX and ret0_ip
Date:   Thu,  7 Nov 2019 12:40:33 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110711-0020-0000-0000-000003836392
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110711-0021-0000-0000-000021D9975E
Message-Id: <20191107114033.90505-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070119
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We don't need them since commit e1cf4befa297 ("bpf, s390x: remove
ld_abs/ld_ind") and commit a3212b8f15d8 ("bpf, s390x: remove obsolete
exception handling from div/mod").

Also, use BIT(n) instead of 1 << n, because checkpatch says so.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ce88211b9c6c..1727c5ae8084 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -41,7 +41,6 @@ struct bpf_jit {
 	int lit_start;		/* Start of literal pool */
 	int lit;		/* Current position in literal pool */
 	int base_ip;		/* Base address for literal pool */
-	int ret0_ip;		/* Address of return 0 */
 	int exit_ip;		/* Address of exit */
 	int r1_thunk_ip;	/* Address of expoline thunk for 'br %r1' */
 	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
@@ -51,12 +50,10 @@ struct bpf_jit {
 
 #define BPF_SIZE_MAX	0xffff	/* Max size for program (16 bit branches) */
 
-#define SEEN_MEM	(1 << 0)	/* use mem[] for temporary storage */
-#define SEEN_RET0	(1 << 1)	/* ret0_ip points to a valid return 0 */
-#define SEEN_LITERAL	(1 << 2)	/* code uses literals */
-#define SEEN_FUNC	(1 << 3)	/* calls C functions */
-#define SEEN_TAIL_CALL	(1 << 4)	/* code uses tail calls */
-#define SEEN_REG_AX	(1 << 5)	/* code uses constant blinding */
+#define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
+#define SEEN_LITERAL	BIT(1)		/* code uses literals */
+#define SEEN_FUNC	BIT(2)		/* calls C functions */
+#define SEEN_TAIL_CALL	BIT(3)		/* code uses tail calls */
 #define SEEN_STACK	(SEEN_FUNC | SEEN_MEM)
 
 /*
@@ -446,12 +443,6 @@ static void bpf_jit_prologue(struct bpf_jit *jit, u32 stack_depth)
  */
 static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 {
-	/* Return 0 */
-	if (jit->seen & SEEN_RET0) {
-		jit->ret0_ip = jit->prg;
-		/* lghi %b0,0 */
-		EMIT4_IMM(0xa7090000, BPF_REG_0, 0);
-	}
 	jit->exit_ip = jit->prg;
 	/* Load exit code: lgr %r2,%b0 */
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
@@ -514,8 +505,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	s16 off = insn->off;
 	unsigned int mask;
 
-	if (dst_reg == BPF_REG_AX || src_reg == BPF_REG_AX)
-		jit->seen |= SEEN_REG_AX;
 	switch (insn->code) {
 	/*
 	 * BPF_MOV
@@ -1110,7 +1099,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		break;
 	case BPF_JMP | BPF_EXIT: /* return b0 */
 		last = (i == fp->len - 1) ? 1 : 0;
-		if (last && !(jit->seen & SEEN_RET0))
+		if (last)
 			break;
 		/* j <exit> */
 		EMIT4_PCREL(0xa7f40000, jit->exit_ip - jit->prg);
-- 
2.23.0

