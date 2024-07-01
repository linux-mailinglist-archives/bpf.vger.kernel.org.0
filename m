Return-Path: <bpf+bounces-33492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C689691E0D1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E955F1C2152E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D315ECCE;
	Mon,  1 Jul 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NXFNXLPV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3615ECD5
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840900; cv=none; b=Kr6pV4/RH/Qw+oib4fhzEFOQPN2nm3gScU8Bh1kOx3dC1cpvyAgYxIKFZCJfWwgS+3Ry5QG2XvD+bR3pbsC8fGUBbs+CFfNNzyY6baxLPgQwgS4sgnDq5UnzykmFnniCZxFy03vD4iblDq0F3Q5KC5zoSacRhM/I+RKSS2SReVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840900; c=relaxed/simple;
	bh=Hc+rYwYqeRm5bcCCJCprRvdz23umNzVidylKqGV4lXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QY9Yro8mOdr5HjLBZJYgO2TWK2SZnSOy27xe2IdlZGcg/fkPFiDDlvYLRCAGAOgaRTG8FW3vu0M3l9IHFlJoPIrV2M3L+KCQuhLKzXFJX2+vgGSAoF+DNX1KFBiZ/Na7ucV8No7CF/uHyiY1n1BlTOZaXHVKJe2OaKAQ07p0/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NXFNXLPV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461DLqOw015480;
	Mon, 1 Jul 2024 13:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=D22J5DIiU/1Ow
	EsZW6ru2C1R9q/QG+4nTQU9H/YxeSo=; b=NXFNXLPVsDMztVVEK+0BnkZpTkEN/
	lUzKcui+aBPHZ14YYHJznA7JXx+QYJjvnaLkdDXQtJkmRLHwyi2cZBhGNQ3V/ne7
	+MFWlVqbdCbqvLFWLGsPDqItYE/JN1wHrcjXrQSnf+t48I8jJkdBe79/0xw/7OzB
	5375l6IL0R2Q+72I5Rwz6rd8JKrL7QoXUNda+6sWES1pNS7+AAYeX188A13rk3/b
	dcYO+8NQfqceen5PFSGdZYQu/vLO5GUFhOPLbogIzg170Kz3fI7vvLwCX7BR7Jmz
	3gDU2V8tR3feXXGMruhRjME4ypwXLBKbb47xqyrC2Qt+ps0dH2dqPpQuQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403vgag5kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461BrFYh026402;
	Mon, 1 Jul 2024 13:34:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpqerh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:45 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYd7632637610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B642004B;
	Mon,  1 Jul 2024 13:34:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E892720040;
	Mon,  1 Jul 2024 13:34:38 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:38 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 08/11] s390/bpf: Enable arena
Date: Mon,  1 Jul 2024 15:24:46 +0200
Message-ID: <20240701133432.3883-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701133432.3883-1-iii@linux.ibm.com>
References: <20240701133432.3883-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: muxD65s8KFbMAIChlryTLES-m7KcleUF
X-Proofpoint-GUID: muxD65s8KFbMAIChlryTLES-m7KcleUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=835 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

Now that BPF_PROBE_MEM32 and address space cast instructions are
implemented, tell the verifier that the JIT supports arena.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 39c1d9aa7f1e..1dd359c25ada 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2820,3 +2820,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
-- 
2.45.2


