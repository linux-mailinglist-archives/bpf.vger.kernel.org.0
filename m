Return-Path: <bpf+bounces-53844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9143EA5CA6E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717A0188ABA6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE0260395;
	Tue, 11 Mar 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CyMoNZl4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344F25EF88;
	Tue, 11 Mar 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709450; cv=none; b=ZhmEgMaOFj0FQW/nnbJHvugs8YGgErOFuYxz16XNVRIfRF6A0/NnoWRyemy6++v/zesnRNlWJUhjO5nN9S/WwbnPbck301dCPkP0pSH9CE6gdc49sepP8xAJrzIHCysGqGTQBJNolOnQCevSJcav0NymiGLLDHic/MbzC8Uo1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709450; c=relaxed/simple;
	bh=YcwoI0zUlt/QeQ4QZSOpCIb/atIS4MTzip1/NwdLozQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kvhsXbXIpjE0v4AHdH4VsnrmWv0i/UyAE4Uu4rtdja+bF/NyGP4HF95wY90e23guLrfjlnC7IJoPjo34Y67nVhGgXAbPdRXAqd9gxh4jBny2rsZ9brosI1VlUW6qd4tw4tpBgJrCXrvz7UJhJgyCbNhgSVOPI4KMWAwFAQE30oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CyMoNZl4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BFa5UX002558;
	Tue, 11 Mar 2025 16:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+EYvGae0hUZazAuE3CRV9Jcwx3/x
	vzbbDFE9F3IqSqU=; b=CyMoNZl4kNGF9bC1jK90dFGspBsNOpm02YYG3Vs6PBxB
	yiHoIyS0F84z3RXEZqF3YIRUYewDnxtzYB6WfEDNPs+SLAyxItk5JjPfH4e6yJx9
	V0MIZKJQJFGQW9v6EcSgrq8y6YF2JvYH6a2qZD5WTJ5jpqoJwpAt16zCEZNB/DqE
	so250dvgvopiKWJHll8xygNCMRD+0idZrdWXTIc3bIDbG1cz1HD1zSSr50SW5KZZ
	xV2is58p7n3YzgVmJSCqv2ePGdxoO+5rEBEBLU72G7a84vYGZVEc/LsP+gim7ACb
	t6OsaFtSQmRJYxeJuatFV6hPk3IjuPyr3+2Hd6SO5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb3s7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 16:10:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52BGAAti004508;
	Tue, 11 Mar 2025 16:10:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45adjb3s78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 16:10:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BEuDG5014024;
	Tue, 11 Mar 2025 16:10:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1vn1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 16:10:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BGA4Q742467590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 16:10:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5E4B2004B;
	Tue, 11 Mar 2025 16:10:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1410F20040;
	Tue, 11 Mar 2025 16:09:59 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.96.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 16:09:58 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Subject: [PATCH 0/2] bpf: Inline helper in powerpc JIT
Date: Tue, 11 Mar 2025 21:39:53 +0530
Message-ID: <20250311160955.825647-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JWlkCi8MDw4l5HkEgkNu3WyNvcPKmcpC
X-Proofpoint-GUID: 1zIAZMVI6pxa4sSIdY96VTyY4Rg_CK-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=296
 spamscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110101

This series adds the support of internal only per-CPU instructions
and inlines the bpf_get_smp_processor_id() helper call for powerpc
BPF JIT.


Saket Kumar Bhaskar (2):
  powerpc, bpf: Support internal-only MOV instruction to resolve per-CPU
    addrs
  powerpc, bpf: Inline bpf_get_smp_processor_id()

 arch/powerpc/net/bpf_jit_comp.c   | 15 +++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 13 +++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.43.5


