Return-Path: <bpf+bounces-65430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CEDB22A64
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2186E09F8
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F6A2EB5D1;
	Tue, 12 Aug 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UucGAeJx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58C2EBB8E
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007968; cv=none; b=gDUtQWYOUUv8RSwSp2LiWtwhbsWO79s+nVA3lGT590oDeSZojzt/I0GYFao0obzZgZdunJDuOR9ILHBQ+uUdJoGL6g0/gC4g+vY/UzBTrHyWNH8d+xBQw6KbetQSqgdc/U7wwA2RbBjAhUoWjUSxXK1R+rgdzBaUHEao9yhnaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007968; c=relaxed/simple;
	bh=Q7glc/bF+g/8MxlddUsGf1ih5oFwPHUBOqbsi95Ouak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvP25gcIH4oNJvvkz8xLRA0PNMXeoBk00LyQuewAHxyjs96ls2K9hlEVJDlZIn+JZPDROf/xQClIm9YDHoMgC1Wgj++tSKKZkg6MIo9e1XuGIGo2wRo6RGtyr6L/gmahynykMbJBW1TlNjWC9aX4+xR7Kk2ifg9bzvCAa3q3rYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UucGAeJx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDUfZu027683;
	Tue, 12 Aug 2025 14:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WkKT5XPQDiVonhwOh
	+ZGqaipvIJGRg4OR3taZbZ0KaE=; b=UucGAeJxUeS2BFip9gziA/LtK2NZfSEM6
	RF9NgKlIIKNdNxJBTKs5A/OqisUmn0EUs1LAPw53Ae+2NQC7tg59/wDmnkHpEAvt
	nEa0vpT5Igm4sqV5/rpbyoQip2jscGXnvOWvBqcHaOFMNpivmOtWMLXi/Q8qRcpZ
	FpZqKIaRaUyrMhoD+2uM5srpQiQ+pfI0qCq6I6fwRzbSN7oHHvxkagQ6r35eUcDi
	+tksyRJFoVh6awK5DSUerzV147Oo3JJ78e3xLcv+M6g9Q5Osn/gTaTYx30dntyOX
	G9PLwRcOgJK3OOsoDx36+JLEWK3pQI51LlEy/9XPGQQ5te1xlm74w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru6tt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:12:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CBLMZL017612;
	Tue, 12 Aug 2025 14:12:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3jbpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:12:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CECKn648234760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 14:12:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728CD2004E;
	Tue, 12 Aug 2025 14:12:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 057C82004D;
	Tue, 12 Aug 2025 14:12:20 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 14:12:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/2] s390/bpf: Write back the tail call counter for BPF_TRAMP_F_CALL_ORIG
Date: Tue, 12 Aug 2025 16:07:52 +0200
Message-ID: <20250812141217.144551-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812141217.144551-1-iii@linux.ibm.com>
References: <20250812141217.144551-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lJjix4RPNIn76XMdaUWPtxz9BwBRMCUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzMyBTYWx0ZWRfX4WwlLjLMayva
 MdoNsXPwYrE10kLyDIOLOLPrs/ymh95WSa8XNNpekkm6DbmIMQgKL2YCzrbd0gyvC8+kRi/kntm
 +mb+JAR+p8nTCDjPaYgdlp4w1pMQxkLFmsahJxj0fcFgMQglrx6g9+ZP/6R90iXobmDIt/v1m2/
 koRMM+roEPPRKFKDSnAa0W+PfaOz508oSKZO7ujJ33VDPs2czw67cF3apGg/NKOTCQ3RG9qqjYg
 rMbIquc9Lhbs2AwTbSl3STio3U/57kBuxLs3hTBIJ+6p7c+9D4xIgqb0X83TkApH5MUkN8F/A3i
 UawgYzaEgV6dSdu8aixDc4OVnUNUZj5d9qexjanSuUswuwNUpRdGyMHxzEnGw6QrwTm4/pAIhVt
 KXicPWf7qtBYTrW5r3ISPsa8qwWsj0G8d5ZaOsL4SbIVPQLwtm7v0qrnl3BO8yFmwAMNQ3dj
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689b4bc8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=DNBvyAJy8adCTgxFzIEA:9
X-Proofpoint-ORIG-GUID: lJjix4RPNIn76XMdaUWPtxz9BwBRMCUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120133

The tailcall_bpf2bpf_hierarchy_fentry test hangs on s390. Its call
graph is as follows:

  entry()
    subprog_tail()
      trampoline()
        fentry()
        the rest of subprog_tail()  # via BPF_TRAMP_F_CALL_ORIG
        return to entry()

The problem is that the rest of subprog_tail() increments the tail call
counter, but the trampoline discards the incremented value. This
results in an astronomically large number of tail calls.

Fix by making the trampoline write the incremented tail call counter
back.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 85695576df6c..b05ddab135e0 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2828,6 +2828,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* stg %r2,retval_off(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
+		/* mvc tccnt_off(%r15),tail_call_cnt(4,%r15) */
+		_EMIT6(0xd203f000 | tjit->tccnt_off,
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 
 		im->ip_after_call = jit->prg_buf + jit->prg;
 
-- 
2.50.1


