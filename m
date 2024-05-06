Return-Path: <bpf+bounces-28673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F78BCFD8
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2FE1F2254F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E813CF97;
	Mon,  6 May 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ahc5ut2m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD92763E2
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005034; cv=none; b=JhyZKofpaWhGRsznAxocJjWu/9nVQNLTY3/lbgxjpJBKmEVSKIRbFAgvjSVD9v+mezggvFE+qX05eb8D9WAZyapBazHLmMkRXsLqNv68wDECoa0/HAAFvYOkrHpMOTnOkHKfWUIHwySPgGrtl6jeiWLvfsgu7fxAHeSqg22cRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005034; c=relaxed/simple;
	bh=CSU1F3qyqUCh1T7gURD01VPRZFFAJ2InFS0FIylzZKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv4R6ZmaY8aPgJxizanCLDHhghEa4XfvgMOO42TJRQ4OLQSaHOEhrrzJAIfGya9CMog5Y7aKgPTecnOleNmPr7e01gtYYOKPsd1K27QlqkmSf/c+F6GENxbXTUA7d3kPT31jeeHoN8bXEO4auNjKL4AfNSVSeecvjZNfG01BMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ahc5ut2m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446DuS2c028934;
	Mon, 6 May 2024 14:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=6bvx5GdunbQSl4FChw14mRhAECF/y9SGfoW/lNGryFg=;
 b=Ahc5ut2mCRKnMo8foan+hODy5p9o5Ayl6lrj6RuLvWzTf+XNtn2GFzaPUyH3kSrrctun
 jwj3+CtSq/HhN8KckPeU72JEdiuu+zGGwvud04zhYDkAHrlWpYDlHteM0uNe5xxvJ6J4
 3H1k2y+yW6qSuEf0omdBKpw+yy2brLVZOhaFcTRlcWBs8LkTJmFuI/gsEpnTlCT96EKT
 lGZWtwdp/pOOvTX9EAlMN331rb0TY6Onntl8xcT2pNs/DF7ceD6LFXqwnvtOiKBMRd5V
 4AMXNWGvLRgQ6iBbDMRCa8QsLNTNnATg7E1kd2G5CLN3Yy0q0/8p2wP1LMeg61CuU2qU cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy0h182c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:16:58 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 446EGwEh030234;
	Mon, 6 May 2024 14:16:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy0h182c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:16:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446E8hGb022494;
	Mon, 6 May 2024 14:16:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx1jkr0cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:16:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 446EGoZt49348996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 May 2024 14:16:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B447B2004B;
	Mon,  6 May 2024 14:16:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E6920043;
	Mon,  6 May 2024 14:16:50 +0000 (GMT)
Received: from black.. (unknown [9.152.222.101])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2024 14:16:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next] s390/bpf: Fully order atomic "add", "and", "or" and "xor"
Date: Mon,  6 May 2024 16:16:42 +0200
Message-ID: <20240506141649.50845-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hWQZf2QUfTqVzWLYdhf9dKo3WrdihUA_
X-Proofpoint-ORIG-GUID: pSkhdXQtSXxVZz_QWShQKWjbBF60d8GS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=954 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060098

BPF_ATOMIC_OP() macro documentation states that "BPF_ADD | BPF_FETCH"
should be the same as atomic_fetch_add(), which is currently not the
case on s390x: the synchronization instruction "bcr 14,0" is missing.

This should not be a problem in practice, because s390x is allowed to
reorder only stores with subsequent fetches from different addresses.
Still, just to be on the safe side, and also for consistency, emit the
synchronization instruction.

Note that it's not required to do this for BPF_XCHG and BPF_CMPXCHG,
because COMPARE AND SWAP performs serialization itself.

Fixes: ba3b86b9cef0 ("s390/bpf: Implement new atomic ops")
Reported-by: Puranjay Mohan <puranjay12@gmail.com>
Closes: https://lore.kernel.org/bpf/mb61p34qvq3wf.fsf@kernel.org/
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index fa2f824e3b06..a0dfb3f665ab 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1427,6 +1427,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
 		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
 		      src_reg, dst_reg, off);				\
+	/* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */		\
+	_EMIT2(0x07e0);							\
 	if (is32 && (insn->imm & BPF_FETCH))				\
 		EMIT_ZERO(src_reg);					\
 } while (0)
-- 
2.45.0


