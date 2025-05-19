Return-Path: <bpf+bounces-58511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89243ABCB06
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 00:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156FF8C3C26
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6B21D3D2;
	Mon, 19 May 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UkIB1jUg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688D21ABA3
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694232; cv=none; b=Xr1yv7Y1AKyJoj3q3Rq+RiIypAJ8jAlCUgRiscne7OB9/Et5gR3UtQ3iCuUm/aki8aKcRD88724NyGjgbnjKmlqhk30a1pr27n/KtuLh+XUZ+7hk+/Z8drHuhNDTo6MdIVvY7bJTW0kn+fk0kPfxza2CokJwfcCPn0L+S4GUaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694232; c=relaxed/simple;
	bh=30YUrKaV5PXc1GLMxxG1S8+f6t0YZsgfdVY6ftfxFbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5L3WagEukvY+MA8pF1vjjPzmIc95ZYGBzPhwKknvd6aJQ23QM0iBODhamGfFS6CIQT9f9tjfUIYgLj/Uy+0SpqrteCS+HUpTXy5vD7eqXeUUbpckx7lL/gjSspKyyXTjWhcHgl4O1H0eQsoH3VbzCHXv/PaCs4cx4GgI6m352Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UkIB1jUg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFQAGC032665;
	Mon, 19 May 2025 22:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qZzrsWZKCKZkeLzYQ
	dBBrKQE5wiWW7ZYD2Vd3SGEyRE=; b=UkIB1jUgCIoB7Xg2rMaJT/cAaQm1EbAOR
	lwhXZOlzRyj97gKWu2BOv8/35ufCMXQjmEz0xMmi/6J0EOJqYn1ED94CSf2Ys82M
	vHhr89PK9a2h1MdoEwwj+bwilekgQFULrdG3ImfGs3pGZcVsL4d1Ex2upQBwu9HX
	xxk4ns9G+6Osv/m/P2h9MtfZeHviQeDXgUtNUjkjq9gpjjnfHe/+NScqOoHKKTyO
	k1eixmSemSC0NkuqPSkNWcknf+Lb66BysD9L7S7KfGm+3NJ723L1rcSbRqFirKKD
	vi6ZIcUQv0I2sBrZ7OLXFGpwpDCIlSi4z44tZWm8DcRcbWwiJnThQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46r2qhu8jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JLwvVe028860;
	Mon, 19 May 2025 22:36:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55ys1n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JMaoaN55509418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 22:36:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E962012D;
	Mon, 19 May 2025 22:36:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B535C2012B;
	Mon, 19 May 2025 22:36:49 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.111.59.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 22:36:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] s390/bpf: Add macros for calling external functions
Date: Mon, 19 May 2025 23:30:05 +0100
Message-ID: <20250519223646.66382-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519223646.66382-1-iii@linux.ibm.com>
References: <20250519223646.66382-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDIxMSBTYWx0ZWRfXxOdwzDn6eByB F5wwPhdCsmpavCypAvBjmoW1sZOKmMqNVR7uwvMmPBN4CXwGcz6TJfAHK48Nexo9PKCZl8M7x28 tMzKQpJjzb3v/2lfKivpUb1ENSA4MRdrKafFhqJdaNa1Nx3zhg8thJCByVNkyH0KAdrt5ENwoRW
 PaoTH/3yK+c9ZpmtAZf1RscpQJ5/gj4H1VEmjN7X1X6SYeytm1kJNtAprEQsDAFQ4A++JyyGhWg x2yDVP8Ge7b0QejP1oGw+elJSlDxn5jG0frYj5NeZew6PRLle9G+0C2y/+1LdWcvppS+I5X/cSC vxzc8YR55hYeBTn6T2DAxn97yLWCrxc227pZHw04XxmuXgil5fqWKg1pTigDI3GRv+Ad+6/+Y8X
 v3rj/hHKk4oUcQvDZAf+wpSiZ7BqRHPOQbDJyrPO7qHIeNN8e7tEEBfRSz2QmrMxFACjpQ8C
X-Proofpoint-ORIG-GUID: hodNBuD6tR8eIQOXA0IewQvlH7NHJM2M
X-Proofpoint-GUID: hodNBuD6tR8eIQOXA0IewQvlH7NHJM2M
X-Authority-Analysis: v=2.4 cv=P406hjAu c=1 sm=1 tr=0 ts=682bb287 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=C2wOGMEbqDEBmCrE-IQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=906 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190211

After the V!=R rework (commit c98d2ecae08f ("s390/mm: Uncouple physical
vs virtual address spaces")), kernel and BPF programs are allocated
within a 4G region, making it possible to use relative addressing to
directly use kernel functions from BPF code.

Add two new macros for calling kernel functions from BPF code:
EMIT6_PCREL_RILB_PTR() and EMIT6_PCREL_RILC_PTR(). Factor out parts
of the existing macros that are helpful for implementing the new ones.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 60 +++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 6f22b5199c20..70a93e03bfb3 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -127,6 +127,18 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 		jit->seen_regs |= (1 << r1);
 }
 
+static s32 off_to_pcrel(struct bpf_jit *jit, u32 off)
+{
+	return off - jit->prg;
+}
+
+static s64 ptr_to_pcrel(struct bpf_jit *jit, const void *ptr)
+{
+	if (jit->prg_buf)
+		return (const u8 *)ptr - ((const u8 *)jit->prg_buf + jit->prg);
+	return 0;
+}
+
 #define REG_SET_SEEN(b1)					\
 ({								\
 	reg_set_seen(jit, b1);					\
@@ -201,7 +213,7 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT4_PCREL_RIC(op, mask, target)			\
 ({								\
-	int __rel = ((target) - jit->prg) / 2;			\
+	int __rel = off_to_pcrel(jit, target) / 2;		\
 	_EMIT4((op) | (mask) << 20 | (__rel & 0xffff));		\
 })
 
@@ -239,7 +251,7 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT6_PCREL_RIEB(op1, op2, b1, b2, mask, target)	\
 ({								\
-	unsigned int rel = (int)((target) - jit->prg) / 2;	\
+	unsigned int rel = off_to_pcrel(jit, target) / 2;	\
 	_EMIT6((op1) | reg(b1, b2) << 16 | (rel & 0xffff),	\
 	       (op2) | (mask) << 12);				\
 	REG_SET_SEEN(b1);					\
@@ -248,7 +260,7 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT6_PCREL_RIEC(op1, op2, b1, imm, mask, target)	\
 ({								\
-	unsigned int rel = (int)((target) - jit->prg) / 2;	\
+	unsigned int rel = off_to_pcrel(jit, target) / 2;	\
 	_EMIT6((op1) | (reg_high(b1) | (mask)) << 16 |		\
 		(rel & 0xffff), (op2) | ((imm) & 0xff) << 8);	\
 	REG_SET_SEEN(b1);					\
@@ -257,29 +269,41 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT6_PCREL(op1, op2, b1, b2, i, off, mask)		\
 ({								\
-	int rel = (addrs[(i) + (off) + 1] - jit->prg) / 2;	\
+	int rel = off_to_pcrel(jit, addrs[(i) + (off) + 1]) / 2;\
 	_EMIT6((op1) | reg(b1, b2) << 16 | (rel & 0xffff), (op2) | (mask));\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
 
+static void emit6_pcrel_ril(struct bpf_jit *jit, u32 op, s64 pcrel)
+{
+	u32 pc32dbl = (s32)(pcrel / 2);
+
+	_EMIT6(op | pc32dbl >> 16, pc32dbl & 0xffff);
+}
+
+static void emit6_pcrel_rilb(struct bpf_jit *jit, u32 op, u8 b, s64 pcrel)
+{
+	emit6_pcrel_ril(jit, op | reg_high(b) << 16, pcrel);
+	REG_SET_SEEN(b);
+}
+
 #define EMIT6_PCREL_RILB(op, b, target)				\
-({								\
-	unsigned int rel = (int)((target) - jit->prg) / 2;	\
-	_EMIT6((op) | reg_high(b) << 16 | rel >> 16, rel & 0xffff);\
-	REG_SET_SEEN(b);					\
-})
+	emit6_pcrel_rilb(jit, op, b, off_to_pcrel(jit, target))
 
-#define EMIT6_PCREL_RIL(op, target)				\
-({								\
-	unsigned int rel = (int)((target) - jit->prg) / 2;	\
-	_EMIT6((op) | rel >> 16, rel & 0xffff);			\
-})
+#define EMIT6_PCREL_RILB_PTR(op, b, target_ptr)			\
+	emit6_pcrel_rilb(jit, op, b, ptr_to_pcrel(jit, target_ptr))
+
+static void emit6_pcrel_rilc(struct bpf_jit *jit, u32 op, u8 mask, s64 pcrel)
+{
+	emit6_pcrel_ril(jit, op | mask << 20, pcrel);
+}
 
 #define EMIT6_PCREL_RILC(op, mask, target)			\
-({								\
-	EMIT6_PCREL_RIL((op) | (mask) << 20, (target));		\
-})
+	emit6_pcrel_rilc(jit, op, mask, off_to_pcrel(jit, target))
+
+#define EMIT6_PCREL_RILC_PTR(op, mask, target_ptr)		\
+	emit6_pcrel_rilc(jit, op, mask, ptr_to_pcrel(jit, target_ptr))
 
 #define _EMIT6_IMM(op, imm)					\
 ({								\
@@ -503,7 +527,7 @@ static void bpf_skip(struct bpf_jit *jit, int size)
 {
 	if (size >= 6 && !is_valid_rel(size)) {
 		/* brcl 0xf,size */
-		EMIT6_PCREL_RIL(0xc0f4000000, size);
+		EMIT6_PCREL_RILC(0xc0040000, 0xf, size);
 		size -= 6;
 	} else if (size >= 4 && is_valid_rel(size)) {
 		/* brc 0xf,size */
-- 
2.49.0


