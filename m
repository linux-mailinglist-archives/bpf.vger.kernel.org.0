Return-Path: <bpf+bounces-65511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C87B24939
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717055679F8
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05DD2FF163;
	Wed, 13 Aug 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CACP6h1v"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0122F5323
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087039; cv=none; b=YTstJFMzW7eYEYQb9qesR3uLe22X+t7IiV3yLhmVfdkgStoY99hLXKOK7zC501MfqgM5qK1zaLhYjQihGkG7wIJebhBxuXPW6NhUm8SQnzfZ+/j9ZFqQQdO0X5nt+y5R/p3AeI21WYPYcKaQ4dpVK96uzC97fL4lzZV7BrB6vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087039; c=relaxed/simple;
	bh=8/vePP8hb45pjNOtvc9+z0ICE2peTaTS9WdzCbpmIw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL6uXVfARmdIv30gZI2uvkLNqTYzrkZ6BJpcx3k0tKXt+eppbrl3DjNo4FJRgNO87Ug6Gmg6Jf0RHGGWVTHgVjbNJToEZ1tTu/cpRNAHQd9XisvuaYn8ZoltGu1IKCowHF35AEsyuGUiwoN4EKMexlBuCxxiyYf/JTtY6qYgwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CACP6h1v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQEfx025035;
	Wed, 13 Aug 2025 12:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OSCrZRFhuZ5x76Vtt
	MPDnEOKnmNkEXHPkF6kNM3T+3M=; b=CACP6h1vNQhRQjypkEn2KMrKh+5X87tpS
	A+BYI6szStH28WtWIz8r9y5yF0OVxxYs5yHLM8Str0Ds+MG04ZFvUGHNHIAwhcZV
	rG9PJikHiKlot2uq4YtTCqORdgkx1TlvQCH9PLw98otWI3upyUwD6ocodyn1pnXQ
	CzFW5kjgDMlBB+HsKkU+2uculeGlCD7thf25YXvWopvvxpJOuMRN+2f0mjX7uQlZ
	9r5RMj3OLhCkX9NUJWgctUuvZErU+dykTCbVQzfQO8NrMT8Ox1l1mGOZORUm1DD4
	aX0W0MZKVDfgZ6KaFpIjnEZVn1vNIqEQt3Qzig6euSnYDDess5ekw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaa8gux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAp7A8026345;
	Wed, 13 Aug 2025 12:10:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh2179v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DCAJDp62521776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:10:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D683220040;
	Wed, 13 Aug 2025 12:10:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C9BA20043;
	Wed, 13 Aug 2025 12:10:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 12:10:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/4] s390/bpf: Do not write tail call counter into helper and kfunc frames
Date: Wed, 13 Aug 2025 14:06:28 +0200
Message-ID: <20250813121016.163375-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813121016.163375-1-iii@linux.ibm.com>
References: <20250813121016.163375-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689c80b0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=quX-GgwO4XCz-k-UChYA:9
X-Proofpoint-ORIG-GUID: pe-taQ-itbW3oAaDy1__5Yyf0ul5TAEW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX3/nBMEKOoPft
 4D6zmuNyaE06VRFrjpqIuHZvJe3O09h5rZ+4/NcIbzW23ZrzlpTCltxvc17YCAEtKP/rM6ML2y2
 vT96FcVbdNyIGV0M4LDBeH18OIj5t44+gN7JCM/ZHI2TezEjk6JEk8bMlTFq9BYhP5F17qS9eA6
 nS67gVqXkws55lwcML/oWp55zsOndo4bwQMoaP/WIcX81WfeeRvI4xJrp+3E84qaDgqhQ8Abj+l
 lM08ugdA+gM1xCODnJMm/7Azjc8alnwjx7D6nrc0h6SupOMFI4TdcFo56Xmkc6xU40GvRhT183S
 eM36O9eHYZ5kqr0HSEgcuDKFP7gQZCNvCdLmHb+LKBNvEDlstz9v31XYpUy4JXFAIvArfxX//zG
 2mVDUigd
X-Proofpoint-GUID: pe-taQ-itbW3oAaDy1__5Yyf0ul5TAEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

Only BPF functions make use of the tail call counter; helpers and
kfuncs ignore and most likely also clobber it. Writing it into these
functions' frames is pointless and misleading, so do not do it.

Fixes: dd691e847d28 ("s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index bb17efe29d65..bfac1ddf3447 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1790,6 +1790,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 
 		REG_SET_SEEN(BPF_REG_5);
 		jit->seen |= SEEN_FUNC;
+
 		/*
 		 * Copy the tail call counter to where the callee expects it.
 		 *
@@ -1800,10 +1801,17 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 * Note 2: We assume that the verifier does not let us call the
 		 * main program, which clears the tail call counter on entry.
 		 */
-		/* mvc tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
-		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
-		       0xf000 | (jit->frame_off +
-				 offsetof(struct prog_frame, tail_call_cnt)));
+
+		if (insn->src_reg == BPF_PSEUDO_CALL)
+			/*
+			 * mvc tail_call_cnt(4,%r15),
+			 *     frame_off+tail_call_cnt(%r15)
+			 */
+			_EMIT6(0xd203f000 | offsetof(struct prog_frame,
+						     tail_call_cnt),
+			       0xf000 | (jit->frame_off +
+					 offsetof(struct prog_frame,
+						  tail_call_cnt)));
 
 		/* Sign-extend the kfunc arguments. */
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-- 
2.50.1


