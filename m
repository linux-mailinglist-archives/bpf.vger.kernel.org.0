Return-Path: <bpf+bounces-28738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7DA8BD867
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9971C225DC
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95A37C;
	Tue,  7 May 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oltbj1FQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76F17C
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040381; cv=none; b=MGAaczsRNEhrFxrloZFRKUKdD3ACZvaxydIknJK2M+yGZfMaz1R13/T6FmpKOvDOS28sdIb7+1Jy2kiWiLdWlwTvTF66BsZTmbydRRtd8UqsKfjbx4UyCZaP/oGxxuzNcdOYjvvmE3QQKukCyiWeDoECzkXHVIT/8nexMDlpqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040381; c=relaxed/simple;
	bh=Kr2nj4SaNCNXTh+XJVNCAVvd/Yh0jUXmcizNoKLe0HY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnjpHJaxjn0JSE3TJ/gl4/+cemMyvwaff8ayhAk5rDpTScs9qefQN+nUOUxw0gR2n4SbLqOapFVH1lOj49ib7pcZlIdMJUmCTMDpVweul61hLqoD24PCjrvmP5F8dXZzEqAIQQSl9oTst60ZKRhopGTtby/PVISS5NajbJlCINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oltbj1FQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446Nr3ZQ006504;
	Tue, 7 May 2024 00:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=mmQFFseAgRw1+rap78jC9l/smoSFfmc5a2BqKvXDiuY=;
 b=Oltbj1FQEYLviOpXfqZLuqRdcw/kC31XOJ00Pi9qjwKX2/X93olfbh8KR7xxQS9C8nma
 eOTZ2QrKx5mwW4/glVqlI6OrgNpg3LaoCNN7XqEfraUP27ZqAp32ri9lLGkPMYiqBpdb
 g3m2ELejRvxk7NJeQqp2EJH0F4shHS1KHSulPX4CYuAgTgf7CwqRIiWr2yoVrG5BmZ4C
 V2uXMuy4uwuQz5OiGiwevb7eUDXUfDIPhJ5FnJXrheZbqXykOc/vRBzAuRkm36fn5Piz
 LoRjaTI6W+gkTkuxEqQ74RFij5CwZEnKQ2wYkwVw8/KYWzsOT1ZX1q7wuNw6pQoqxURU AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy98y017h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 00:06:06 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4470653X028835;
	Tue, 7 May 2024 00:06:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xy98y017g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 00:06:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 446KWv1T013977;
	Tue, 7 May 2024 00:06:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222th89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 00:06:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44705xDl43450848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 00:06:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 726602004D;
	Tue,  7 May 2024 00:05:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C0020043;
	Tue,  7 May 2024 00:05:58 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.26.101])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 00:05:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v2] s390/bpf: Emit a barrier for BPF_FETCH instructions
Date: Tue,  7 May 2024 02:02:49 +0200
Message-ID: <20240507000557.12048-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b450sHArB4tzFjReQeSt8jVsN2HJyr5y
X-Proofpoint-GUID: rGsXa7030P-oeeQztjIO_pRcWHosXCk7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_17,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=935 clxscore=1015 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060175

BPF_ATOMIC_OP() macro documentation states that "BPF_ADD | BPF_FETCH"
should be the same as atomic_fetch_add(), which is currently not the
case on s390x: the serialization instruction "bcr 14,0" is missing.
This applies to "and", "or" and "xor" variants too.

s390x is allowed to reorder stores with subsequent fetches from
different addresses, so code relying on BPF_FETCH acting as a barrier,
for example:

  stw [%r0], 1
  afadd [%r1], %r2
  ldxw %r3, [%r4]

may be broken. Fix it by emitting "bcr 14,0".

Note that a separate serialization instruction is not needed for
BPF_XCHG and BPF_CMPXCHG, because COMPARE AND SWAP performs
serialization itself.

Fixes: ba3b86b9cef0 ("s390/bpf: Implement new atomic ops")
Reported-by: Puranjay Mohan <puranjay12@gmail.com>
Closes: https://lore.kernel.org/bpf/mb61p34qvq3wf.fsf@kernel.org/
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/bpf/20240506141649.50845-1-iii@linux.ibm.com/
v1 -> v2: Emit a barrier only for BPF_FETCH variants;
          Add an example of the code that may break to the commit
          message (Puranjay).

 arch/s390/net/bpf_jit_comp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index fa2f824e3b06..4be8f5cadd02 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1427,8 +1427,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
 		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
 		      src_reg, dst_reg, off);				\
-	if (is32 && (insn->imm & BPF_FETCH))				\
-		EMIT_ZERO(src_reg);					\
+	if (insn->imm & BPF_FETCH) {					\
+		/* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */	\
+		_EMIT2(0x07e0);						\
+		if (is32)                                               \
+			EMIT_ZERO(src_reg);				\
+	}								\
 } while (0)
 		case BPF_ADD:
 		case BPF_ADD | BPF_FETCH:
-- 
2.45.0


