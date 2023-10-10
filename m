Return-Path: <bpf+bounces-11838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687777C414E
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C6E1C20CDD
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C89315B2;
	Tue, 10 Oct 2023 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M2h94TKC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C7315B0
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:35:34 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A790793
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:35:33 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKRUHh016209;
	Tue, 10 Oct 2023 20:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y8fqxrRquuzrQqMFPS0EPciwMft4QFlkluACoyC/LEw=;
 b=M2h94TKCg2KUN2Ynup+uQ0eWhJIxIGwqR5QZr9ATamy2rsOXHgvCDYIBHShWNCRDKd9J
 /QIZx23AerrccyGtKb3w/OKCnorGftI/X2IpvRAGzzlYhiaP/m9G8efkHXGvX1ZZNcn2
 dp5UfPdgx3Y4b2PzmnEsbBl6xNV/1+qBFB0COn36DaUMrkFNSBbBeAbyI/yfSm1Xxlbb
 bffSgdm0x1zOlg3Bltmy3ZxBMb4tdk3+ENLMqgO44iRfRKtakumgEyLOA64FSF71MaEg
 7L3ZiM3OzBRd/i+g5qyly64z5kLc7h9ke29L570E15i0sO7TDorig/T0EnSXGo9dtmJ0 TQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndnmge55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:35:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJW817025901;
	Tue, 10 Oct 2023 20:35:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnaxbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:35:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKZG2716056954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Oct 2023 20:35:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46EC52004B;
	Tue, 10 Oct 2023 20:35:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EC0820040;
	Tue, 10 Oct 2023 20:35:15 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.0.76])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Oct 2023 20:35:15 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, Song Liu <song@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf 1/2] s390/bpf: Fix clobbering the caller's backchain in the trampoline
Date: Tue, 10 Oct 2023 22:20:09 +0200
Message-ID: <20231010203512.385819-2-iii@linux.ibm.com>
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
X-Proofpoint-GUID: gmI3gWmA12796oAxaa2gAYIsnCQXzzaZ
X-Proofpoint-ORIG-GUID: gmI3gWmA12796oAxaa2gAYIsnCQXzzaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310100159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

One of the first things that s390x kernel functions do is storing the
the caller's frame address (backchain) on stack. This makes unwinding
possible. The backchain is always stored at frame offset 152, which is
inside the 160-byte stack area, that the functions allocate for their
callees. The callees must preserve the backchain; the remaining 152
bytes they may use as they please.

Currently the trampoline uses all 160 bytes, clobbering the backchain.
This causes kernel panics when using __builtin_return_address() in
functions called by the trampoline.

Fix by reducing the usage of the caller-reserved stack area by 8 bytes
in the trampoline.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Reported-by: Song Liu <song@kernel.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9ed0a13865ca..8955bc80270a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2399,8 +2399,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->run_ctx_off = alloc_stack(tjit,
 					sizeof(struct bpf_tramp_run_ctx));
 	tjit->tccnt_off = alloc_stack(tjit, sizeof(u64));
-	/* The caller has already reserved STACK_FRAME_OVERHEAD bytes. */
-	tjit->stack_size -= STACK_FRAME_OVERHEAD;
+	/*
+	 * In accordance with the s390x ABI, the caller has allocated
+	 * STACK_FRAME_OVERHEAD bytes for us. 8 of them contain the caller's
+	 * backchain, and the rest we can use.
+	 */
+	tjit->stack_size -= STACK_FRAME_OVERHEAD - sizeof(u64);
 	tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
 
 	/* aghi %r15,-stack_size */
-- 
2.41.0


