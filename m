Return-Path: <bpf+bounces-9305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629767932FD
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4927B1C20946
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA9C634;
	Wed,  6 Sep 2023 00:45:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4362B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:45:11 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7695CDE
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 17:45:09 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3860dRqd032077;
	Wed, 6 Sep 2023 00:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rbxfZRNrDk+ipEbfZZPYrgSaRMCxZ11tMMSJsse5/xs=;
 b=EFSqq9xHVnDjlfFz5WPsnzHxgEGQDlPwMVw/8TgGTIvDacQTndLr2UnnCquCje4l2PtW
 1QLdZm4OeWvk8ZcJPZ8BmLRBlWfrVus3PpFTFoUQYMhnfQiuJ8zrqnDLN1s52+oPlSGq
 2nHI+8vqrvhyZyrtyg9eo7rcOmeexOc6hRzGOxdPqRw1wylpVhST2J7L+f80KW2Ljwy8
 vr1HlIjUThdpP+58KHGoU34ROijDqeHm2pMzrzyWc8VZVjF8AHisuHElfi/XWKKs0hvW
 NyDRUBFXUaG9H34XkDPpfU56Yb3Xngy1xniAVuYoDBMnk8ApC9aRo+JjKwBDXL/VnO0C pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxev8g7vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 00:44:55 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3860h9c5013724;
	Wed, 6 Sep 2023 00:44:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxev8g7vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 00:44:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385MDSER012257;
	Wed, 6 Sep 2023 00:44:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjxptn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 00:44:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3860ipSD63373594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Sep 2023 00:44:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2675920043;
	Wed,  6 Sep 2023 00:44:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6FF720040;
	Wed,  6 Sep 2023 00:44:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.26.12])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Sep 2023 00:44:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Leon Hwang <hffilwlqm@gmail.com>
Subject: [PATCH bpf] s390/bpf: Pass through tail call counter in trampolines
Date: Wed,  6 Sep 2023 02:44:19 +0200
Message-ID: <20230906004448.111674-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TNvRrnfvVQhj92L-nh8WKj7s8-4k0bbC
X-Proofpoint-GUID: WtMSI93GhTX_SDWTCFu30pYFp9NefHJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

s390x eBPF programs use the following extension to the s390x calling
convention: tail call counter is passed on stack at offset
STK_OFF_TCCNT, which callees otherwise use as scratch space.

Currently trampoline does not respect this and clobbers tail call
counter. This breaks enforcing tail call limits in eBPF programs, which
have trampolines attached to them.

Fix by forwarding a copy of the tail call counter to the original eBPF
program in the trampoline (for fexit), and by restoring it at the end
of the trampoline (for fentry).

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Reported-by: Leon Hwang <hffilwlqm@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cbbb82a63975..c668eb0e59e6 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2227,6 +2227,7 @@ struct bpf_tramp_jit {
 				 */
 	int r14_off;		/* Offset of saved %r14 */
 	int run_ctx_off;	/* Offset of struct bpf_tramp_run_ctx */
+	int tccnt_off;		/* Offset of saved tailcall counter */
 	int do_fexit;		/* do_fexit: label */
 };
 
@@ -2397,12 +2398,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->r14_off = alloc_stack(tjit, sizeof(u64));
 	tjit->run_ctx_off = alloc_stack(tjit,
 					sizeof(struct bpf_tramp_run_ctx));
+	tjit->tccnt_off = alloc_stack(tjit, sizeof(u64));
 	/* The caller has already reserved STACK_FRAME_OVERHEAD bytes. */
 	tjit->stack_size -= STACK_FRAME_OVERHEAD;
 	tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
 
 	/* aghi %r15,-stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, -tjit->stack_size);
+	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
+	_EMIT6(0xd203f000 | tjit->tccnt_off,
+	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
 	/* stmg %r2,%rN,fwd_reg_args_off(%r15) */
 	if (nr_reg_args)
 		EMIT6_DISP_LH(0xeb000000, 0x0024, REG_2,
@@ -2539,6 +2544,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 				       (nr_stack_args * sizeof(u64) - 1) << 16 |
 				       tjit->stack_args_off,
 			       0xf000 | tjit->orig_stack_args_off);
+		/* mvc STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
+		_EMIT6(0xd203f000 | STK_OFF_TCCNT, 0xf000 | tjit->tccnt_off);
 		/* lgr %r1,%r8 */
 		EMIT4(0xb9040000, REG_1, REG_8);
 		/* %r1() */
@@ -2595,6 +2602,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET))
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
+	/* mvc stack_size+STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
+	_EMIT6(0xd203f000 | (tjit->stack_size + STK_OFF_TCCNT),
+	       0xf000 | tjit->tccnt_off);
 	/* aghi %r15,stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
 	/* Emit an expoline for the following indirect jump. */
-- 
2.41.0


