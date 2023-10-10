Return-Path: <bpf+bounces-11839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7177C4150
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B1D1C20E56
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25C4315B2;
	Tue, 10 Oct 2023 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dgTCCo39"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B334208D9
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:35:38 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69BF91
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:35:35 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKU3IA025190;
	Tue, 10 Oct 2023 20:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G/mfDxEp03rPYb6uh3oLP2Pn4fyAG4lWQ5YC8+LNxLo=;
 b=dgTCCo395fACM6h7T6klkICtuQ9wHQ+MFKPXG2Iu8Kd6oPk/x1wsEXylZtJvVxdkCjgh
 tHWqdCIXeWucabnekLvmkSKKbEBjeUIl3rom+cfC21Vtj+NBWY+8m0b/GtBmug106xnu
 ZvHOn1DeLVNGFnN4zNmGZ1U7c4VqaFMbeW4anJEiwZa5QSrEw77F2gXekogEiyEKGd0s
 ZGwpCsAZnoy57mt/05Jeg6fxb7bZP/cX6XCWjkKXJddQEWx6pe5MP0DVKjrOdaJ0vYdM
 xmaHkjuKP7IDQ1Ie9psA3mklZ643C2jAQDimd+UFB+a+y/WSDu7sbN8BWnc4s91e+iAH oQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndq1g85k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:35:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJ8teg028188;
	Tue, 10 Oct 2023 20:35:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1y34x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:35:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKZI4T43319716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Oct 2023 20:35:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FCB42004B;
	Tue, 10 Oct 2023 20:35:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86FA62004E;
	Tue, 10 Oct 2023 20:35:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.0.76])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Oct 2023 20:35:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, Song Liu <song@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 2/2] s390/bpf: Fix unwinding past the trampoline
Date: Tue, 10 Oct 2023 22:20:10 +0200
Message-ID: <20231010203512.385819-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010203512.385819-1-iii@linux.ibm.com>
References: <20231010203512.385819-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yu7UX69sPGUvQy7AcbpOatKFODqtF7Re
X-Proofpoint-GUID: yu7UX69sPGUvQy7AcbpOatKFODqtF7Re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When functions called by the trampoline panic, the backtrace that is
printed stops at the trampoline, because the trampoline does not store
its caller's frame address (backchain) on stack; it also stores the
return address at a wrong location.

Store both the same way as is already done for the regular eBPF
programs.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 8955bc80270a..082b913f214e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2205,6 +2205,7 @@ struct bpf_tramp_jit {
 				 * func_addr's original caller
 				 */
 	int stack_size;		/* Trampoline stack size */
+	int backchain_off;	/* Offset of backchain */
 	int stack_args_off;	/* Offset of stack arguments for calling
 				 * func_addr, has to be at the top
 				 */
@@ -2225,9 +2226,10 @@ struct bpf_tramp_jit {
 				 * for __bpf_prog_enter() return value and
 				 * func_addr respectively
 				 */
-	int r14_off;		/* Offset of saved %r14 */
 	int run_ctx_off;	/* Offset of struct bpf_tramp_run_ctx */
 	int tccnt_off;		/* Offset of saved tailcall counter */
+	int r14_off;		/* Offset of saved %r14, has to be at the
+				 * bottom */
 	int do_fexit;		/* do_fexit: label */
 };
 
@@ -2386,8 +2388,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * Calculate the stack layout.
 	 */
 
-	/* Reserve STACK_FRAME_OVERHEAD bytes for the callees. */
+	/*
+	 * Allocate STACK_FRAME_OVERHEAD bytes for the callees. As the s390x
+	 * ABI requires, put our backchain at the end of the allocated memory.
+	 */
 	tjit->stack_size = STACK_FRAME_OVERHEAD;
+	tjit->backchain_off = tjit->stack_size - sizeof(u64);
 	tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
 	tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
 	tjit->ip_off = alloc_stack(tjit, sizeof(u64));
@@ -2395,10 +2401,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
 	tjit->retval_off = alloc_stack(tjit, sizeof(u64));
 	tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
-	tjit->r14_off = alloc_stack(tjit, sizeof(u64));
 	tjit->run_ctx_off = alloc_stack(tjit,
 					sizeof(struct bpf_tramp_run_ctx));
 	tjit->tccnt_off = alloc_stack(tjit, sizeof(u64));
+	tjit->r14_off = alloc_stack(tjit, sizeof(u64) * 2);
 	/*
 	 * In accordance with the s390x ABI, the caller has allocated
 	 * STACK_FRAME_OVERHEAD bytes for us. 8 of them contain the caller's
@@ -2407,8 +2413,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->stack_size -= STACK_FRAME_OVERHEAD - sizeof(u64);
 	tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
 
+	/* lgr %r1,%r15 */
+	EMIT4(0xb9040000, REG_1, REG_15);
 	/* aghi %r15,-stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, -tjit->stack_size);
+	/* stg %r1,backchain_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_1, REG_0, REG_15,
+		      tjit->backchain_off);
 	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
 	_EMIT6(0xd203f000 | tjit->tccnt_off,
 	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
-- 
2.41.0


