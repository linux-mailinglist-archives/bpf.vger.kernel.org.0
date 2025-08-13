Return-Path: <bpf+bounces-65510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B752CB24938
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 14:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FB8687844
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2192FF152;
	Wed, 13 Aug 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rHMti/Fs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145C2F747A
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087038; cv=none; b=YDQJIqcwwJmv0Im1g78g1lubX5w9BvGpNmwxePFGGS2t6eG960s9oWIndEzZoNaKXrbmEFEpo/i0Otw/H9+Mz+rODS4sHidq68iOsu37HC8v/MCZT69Tp1SnpikZRQxbirkqdvJvAmRAKNV2/XIYFg9Uc0ykq5R6vwLEeexJswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087038; c=relaxed/simple;
	bh=2G4eNsKftdBjQoIL3H6liZgqqBJCMeswI4O4v5KnXls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCW3VE83jgtRmJ/d8Ou//XZvJp252Fu/hVNjpbOFZHBXZTzCekFI/Btulxy5Oxi50b6TuEDzyZDVePCDXK2946yQ9qCo5X/wxQuhDNcOq33gJXGye9lpQF4lHJwuEcE9k7VGJ39t+CALkPSEqQX0YuR3LPoc0vnyj2OiA+TVteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rHMti/Fs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQPth030340;
	Wed, 13 Aug 2025 12:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AEyS5XC6g1OKciHBuctqRzAKliqFvF8czUkZBD0Vt
	1w=; b=rHMti/FsDvsJhmZ85F3g/PYReQKyqbvp99sr2LU2uCvxmOEcobZ0m1Til
	jDHBoco+hA8SJHBYz/VgC6EOraLzmKZh45a2/vVRqld5stInq+ckGt4LwBl7L9Y8
	3FScy+69CJRjRMs3gfPGGmqmURzPfzpd+1CemiYdXPdlA2Youbl1uQ/+2NR0ZUCl
	8y/WDBFSJjxkvOtTteKkb8h6MGyV0zRvw+gc28+aKg0ez7Fe86rgZu4tFmnrCZf1
	PaV2DyWPChly6a5EZ70oODYwyuTTrxrRN38GpwgBX4ak03/+3p1fJsxN7ta+1pgU
	NEXquyd7mD28DL4sf6i9g/Zwb2QjQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dwudcav3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D8TYM4025667;
	Wed, 13 Aug 2025 12:10:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmex8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:10:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DCAJpL32112964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:10:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5884020040;
	Wed, 13 Aug 2025 12:10:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10EF20043;
	Wed, 13 Aug 2025 12:10:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 12:10:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/4] s390/bpf: Write back tail call counter
Date: Wed, 13 Aug 2025 14:06:27 +0200
Message-ID: <20250813121016.163375-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXw7JoZbq3p9OW
 WAN9R0gFcfORVVHYzA/Fdk1H3GJI2RKdcTsjxG6lDf8MTHd9Tp2OTxq990piWCAI0WIToP2lJtF
 thHYXTS0oXn+vevr0+qNgG8ZZObXTz2774P7DM1yPIfK4rb+hqjCvYu+1AlFAt+umcVz0P/lBJb
 kYPpDbtBp2elNEB0r8SmFjZImAyDneJlvWMRe/k3UKnrlvn6cHIB0jgiFCm8gWxfIj+KbJ+3sfV
 MMzFpEsfq5W30UlW+pGygvm+qzHZjyVmQ1A4rGwfWinFCgif5oPQpYoOd2RY1Qsrv+EjiV3SoG2
 K7G3vmqRPdvVWKPI/osTRjCEUUuI+oSLUgdJGNQX8vTcddvgDRgg9W9ze2A5f3ye3WGJZ6Kquh6
 //thZuIv
X-Authority-Analysis: v=2.4 cv=d/31yQjE c=1 sm=1 tr=0 ts=689c80af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Zb6n0JFsNxPVDS_NIqsA:9
X-Proofpoint-GUID: pWlp2zG1ao1ORsOSXqTl9zqrxy4KtQUV
X-Proofpoint-ORIG-GUID: pWlp2zG1ao1ORsOSXqTl9zqrxy4KtQUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

v1: https://lore.kernel.org/bpf/20250812141217.144551-1-iii@linux.ibm.com/
v1 -> v2: Write back tail call counter only for BPF_PSEUDO_CALL

Hi,

This series fixes the tailcall_bpf2bpf_hierarchy test failures on s390.

It takes a simpler approach than x86_64 and aarch64: instead of
introducing a pointer to the tail call counter, it copies the updated
value back from the callee's frame to the caller's frame. This needs to
be done in two locations: after BPF_PSEUDO_CALL and after
BPF_TRAMP_F_CALL_ORIG.

Patch 1 is a cleanup, patches 2 and 3 are the actual fixes, patch 4
improves the hierarchy tests in order to catch issues with accidentally
clobbering the counter.

Best regards,
Ilya

Ilya Leoshkevich (4):
  s390/bpf: Do not write tail call counter into helper and kfunc frames
  s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
  s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG
  selftests/bpf: Clobber a lot of registers in
    tailcall_bpf2bpf_hierarchy tests

 arch/s390/net/bpf_jit_comp.c                  | 42 ++++++++++++++-----
 .../selftests/bpf/progs/bpf_test_utils.h      | 18 ++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  3 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  3 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  3 ++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c |  3 ++
 6 files changed, 61 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_test_utils.h

-- 
2.50.1


