Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111D8100B13
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKRSEG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:04:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfKRSEG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:04:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2chc008484
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2way67kea9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:04 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:04:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:03:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII3wmb55050242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:03:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1035BAE051;
        Mon, 18 Nov 2019 18:03:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAFA5AE045;
        Mon, 18 Nov 2019 18:03:57 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:03:57 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/6] s390/bpf: align literal pool entries
Date:   Mon, 18 Nov 2019 19:03:36 +0100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
References: <20191118180340.68373-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-0028-0000-0000-000003BA4E32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-0029-0000-0000-0000247D6856
Message-Id: <20191118180340.68373-3-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=2
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When literal pool size exceeds 512k, it's no longer possible to
reference all the entries in it using a single base register and long
displacement. Therefore, PC-relative lgfrl and lgrl instructions need to
be used.

Unfortunately, they require their arguments to be aligned to 4- and
8-byte boundaries respectively. This generates certain overhead due to
necessary padding bytes. Grouping 4- and 8-byte entries together reduces
the maximum overhead to 6 bytes (2 for aligning 4-byte entries and 4 for
aligning 8-byte entries).

While in theory it is possible to detect whether or not alignment is
needed by comparing the literal pool size with 512k, in practice this
leads to having two ways of emitting constants, making the code more
complicated.

Prefer code simplicity over trivial size saving, and always group and
align literal pool entries.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 5ee1ebc6e448..bb0215d290f4 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/bpf.h>
 #include <linux/mm.h>
+#include <linux/kernel.h>
 #include <asm/cacheflush.h>
 #include <asm/dis.h>
 #include <asm/facility.h>
@@ -39,8 +40,10 @@ struct bpf_jit {
 	int size;		/* Size of program and literal pool */
 	int size_prg;		/* Size of program */
 	int prg;		/* Current position in program */
-	int lit_start;		/* Start of literal pool */
-	int lit;		/* Current position in literal pool */
+	int lit32_start;	/* Start of 32-bit literal pool */
+	int lit32;		/* Current position in 32-bit literal pool */
+	int lit64_start;	/* Start of 64-bit literal pool */
+	int lit64;		/* Current position in 64-bit literal pool */
 	int base_ip;		/* Base address for literal pool */
 	int exit_ip;		/* Address of exit */
 	int r1_thunk_ip;	/* Address of expoline thunk for 'br %r1' */
@@ -287,22 +290,22 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 #define EMIT_CONST_U32(val)					\
 ({								\
 	unsigned int ret;					\
-	ret = jit->lit - jit->base_ip;				\
+	ret = jit->lit32 - jit->base_ip;			\
 	jit->seen |= SEEN_LITERAL;				\
 	if (jit->prg_buf)					\
-		*(u32 *) (jit->prg_buf + jit->lit) = (u32) (val);\
-	jit->lit += 4;						\
+		*(u32 *)(jit->prg_buf + jit->lit32) = (u32)(val);\
+	jit->lit32 += 4;					\
 	ret;							\
 })
 
 #define EMIT_CONST_U64(val)					\
 ({								\
 	unsigned int ret;					\
-	ret = jit->lit - jit->base_ip;				\
+	ret = jit->lit64 - jit->base_ip;			\
 	jit->seen |= SEEN_LITERAL;				\
 	if (jit->prg_buf)					\
-		*(u64 *) (jit->prg_buf + jit->lit) = (u64) (val);\
-	jit->lit += 8;						\
+		*(u64 *)(jit->prg_buf + jit->lit64) = (u64)(val);\
+	jit->lit64 += 8;					\
 	ret;							\
 })
 
@@ -1430,9 +1433,10 @@ static int bpf_set_addr(struct bpf_jit *jit, int i)
 static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 			bool extra_pass)
 {
-	int i, insn_count;
+	int i, insn_count, lit32_size, lit64_size;
 
-	jit->lit = jit->lit_start;
+	jit->lit32 = jit->lit32_start;
+	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 
 	bpf_jit_prologue(jit, fp->aux->stack_depth);
@@ -1448,8 +1452,15 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	}
 	bpf_jit_epilogue(jit, fp->aux->stack_depth);
 
-	jit->lit_start = jit->prg;
-	jit->size = jit->lit;
+	lit32_size = jit->lit32 - jit->lit32_start;
+	lit64_size = jit->lit64 - jit->lit64_start;
+	jit->lit32_start = jit->prg;
+	if (lit32_size)
+		jit->lit32_start = ALIGN(jit->lit32_start, 4);
+	jit->lit64_start = jit->lit32_start + lit32_size;
+	if (lit64_size)
+		jit->lit64_start = ALIGN(jit->lit64_start, 8);
+	jit->size = jit->lit64_start + lit64_size;
 	jit->size_prg = jit->prg;
 	return 0;
 }
@@ -1535,7 +1546,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto free_addrs;
 	}
 
-	header = bpf_jit_binary_alloc(jit.size, &jit.prg_buf, 2, jit_fill_hole);
+	header = bpf_jit_binary_alloc(jit.size, &jit.prg_buf, 8, jit_fill_hole);
 	if (!header) {
 		fp = orig_fp;
 		goto free_addrs;
-- 
2.23.0

