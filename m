Return-Path: <bpf+bounces-33564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A614E91EB7A
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4706E1F224E5
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D14172BA6;
	Mon,  1 Jul 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q6rRllfH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B7173323
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877415; cv=none; b=TRv4XKmlkWSgdtqWBCvkgb6RbBm/pD9taQuJ1Xve2HHHaToh85aM3BAhJHw8HDzYuuMMbgOA4adFmDpX3sk0qdGkH4bVkeyu7pOAKih55X+CTxjtoVSm6VC4kQYBfla6lTdC9CAdjVcIq+4jtm7vpJEBlorvUrOUbXUboM/lWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877415; c=relaxed/simple;
	bh=IDwdYmgcPWR3s5soAxD9qGsJ4lExdKHyTUPWBYYcw8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbnaLUoYnLZa+HMNfuRS7oTc7oeo/gAveAINK+Fok9nUi7WpuBraQfkMbNdR5nd+aXl97QFT0WH/mc8vNycp82UBnYBz84r60fX9WwbYv8w96lPzu+AnHYpNGJbw3A5jAPTZ+aN/rS9pK4j/cumP8rUySRu0lMngP6Xr1WDFrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q6rRllfH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NU7Gx015351;
	Mon, 1 Jul 2024 23:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=km3RowtczH2in
	e0nckkJiV8lv/3lCTELZsofM8ofzns=; b=q6rRllfH7SnEAFVUrkyXoD8ENc2ka
	p5Upzqupx3tJnRUaS4qqpJBOsS1vURMheer4TLx9ZqvnoOIcxXxB2xch+gKI2U31
	V60YK7W39ihvOKbNMRDQf+wntocguLPpgV8GNrQq0F46JRcHSBquK6VrUXDg8UEA
	a9iLcFAOoow71Jbn4dJiYOFf2Z2kUSjjahTPXhoQ6nEG2XkLZa6kkwlMK5xknA0h
	Mg3MSTSGqn5u7ze3puJHB7I73B5DqfibN/XNsUAMDAyPQXHh1lvBEha7whkyml+n
	SMfdK5X3qr8nLimlIDdTAr57Ww4j/sGadV0XzBetngpdY+FNO5yXh05pw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40465g80sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461N0STj026448;
	Mon, 1 Jul 2024 23:43:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpsumv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461Nh8ZN56426900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0355A2004B;
	Mon,  1 Jul 2024 23:43:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8074320040;
	Mon,  1 Jul 2024 23:43:07 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 01/12] bpf: Fix atomic probe zero-extension
Date: Tue,  2 Jul 2024 01:40:19 +0200
Message-ID: <20240701234304.14336-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701234304.14336-1-iii@linux.ibm.com>
References: <20240701234304.14336-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RC2r2xkZWwab9PMmVyMUZjmhazXqO8nk
X-Proofpoint-ORIG-GUID: RC2r2xkZWwab9PMmVyMUZjmhazXqO8nk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=961 adultscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010174

Zero-extending results of atomic probe operations fails with:

    verifier bug. zext_dst is set, but no reg is defined

The problem is that insn_def_regno() handles BPF_ATOMICs, but not
BPF_PROBE_ATOMICs. Fix by adding the missing condition.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d3927d819465..e25ad5fb9115 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3217,7 +3217,8 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	case BPF_ST:
 		return -1;
 	case BPF_STX:
-		if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+		if ((BPF_MODE(insn->code) == BPF_ATOMIC ||
+		     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) &&
 		    (insn->imm & BPF_FETCH)) {
 			if (insn->imm == BPF_CMPXCHG)
 				return BPF_REG_0;
-- 
2.45.2


