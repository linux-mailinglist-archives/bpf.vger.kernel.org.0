Return-Path: <bpf+bounces-58508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB1DABCB03
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6004B8C3CA7
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C321CA1F;
	Mon, 19 May 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ci6cMMVs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104086340
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694230; cv=none; b=cv4ZGup3UgjwTDKM7bTZZDL6/oihEe8GG2icxLICJ2sCB81LIgJgZ6GGeJ34AazYCWHaW3Wv1oyUiIWYBKqbIfy540BnPVe8kjacQeYGG868dglBko5vdzkIpq063VTKFnNdu96oGF++P/B4kt32J0Y4cBYXYimxv3oguHsV6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694230; c=relaxed/simple;
	bh=Ak+dJPBWGZMhPag3H5lEtvGzw5eHP2INXO9pTw5Tkns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOmqc56NLttSVrN3M6bYmvpNp7fcF0rPfaOlkfFfnAhlUyM3AuhRGl31MqiFYVAzaiIlcEL77WkPVdv5PCwDf0Ve5pVS7leHQhCt7sVqr8G94U+hRUR3H011Bsuzm6JOQ8qM9URq+0wsXoluS8X3JiAxhKqTbWz8LJ5eJ3j6ELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ci6cMMVs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFQA9O014353;
	Mon, 19 May 2025 22:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sRokr2xDnL/rrhAqN+8qruacy2ktnoJBUSwIaynSR
	UQ=; b=Ci6cMMVsp2BspP6C7Tj8Jnw5kbd3rld4x1D2O+jJOobonQ2/n8YydrtIw
	HKKL+vAfybyWLg/zQ2+4vP98n5LrO4bS5FRCnfei23S8MbtWLKkL8EAzu/cFF8fM
	ULkH22S1k4D6bwtfeBW1G0uMxRywJc7yg3YAoDfeND4twHUeKwuRT9AXpkwOBzLp
	KlDKiRPOel5TdnscLTDT5k+qTOcZzV3HG0wprusst5ikkta37rkbFDtyxkT1Q+Ml
	A1SxPoVMJ+40CXYq553F0TTApG3NPhlfhJtwwjuf33pFZBlcMkpBPef/4otii2Wv
	aa0rHx8vxKRTDDCvOOdberyRaQKlw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46r5v3a6at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JMOqX8005378;
	Mon, 19 May 2025 22:36:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q69m8ryg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 22:36:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JManic13304080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 22:36:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 032642012D;
	Mon, 19 May 2025 22:36:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 689C62012B;
	Mon, 19 May 2025 22:36:48 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.111.59.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 May 2025 22:36:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] s390/bpf: Use kernel's expoline thunks
Date: Mon, 19 May 2025 23:30:03 +0100
Message-ID: <20250519223646.66382-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDIxMSBTYWx0ZWRfX9ILIby1+c/m/ YNZHSTFE4BwZJXcIb6irZYGnhUflUcfy5AHIkun0mEzd2rw1WeXzeVsUm30UHphqO43DJIBaAHi 7aN0Kttu4loL6eYuslgf9OcEI3IkMa5zJWnnks6IcjHCerO13lnyhqgXabvpJlEkxNfniJ2ehE+
 D/U4VdjoEwwvvJUR9slzIcD/RyQ/5HuLgjox0rGiVkakwF6lYtiOHDURWUHQbxRG/6NLifCB/4y J6Bf5IOopaiaIbjVk6kXMxryk4rdklhlT5XBEpUVZPUTRwk+yJWoR8OUcD51p7mFIiYo7xJ9a0G Y1HU48daVOQIgyQ3PpkBoua6EEgfX6on69/ciicM+LKVOF0+nIXbbjcifKyIvsZdnNVgGLV+h6j
 WCs4s31TOhdUeQTVfW1hgXZ80+1LXy5RbctxPhcMpVDfG4wuWRLl4mC36IcpIOuBv4B+rueM
X-Authority-Analysis: v=2.4 cv=LNFmQIW9 c=1 sm=1 tr=0 ts=682bb285 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=ZujMp2Db-WdQw4ummQMA:9
X-Proofpoint-GUID: C6AKg5OmwXIUWEzxiMOvpyRG7lI0TLMN
X-Proofpoint-ORIG-GUID: C6AKg5OmwXIUWEzxiMOvpyRG7lI0TLMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_09,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=533 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190211

Hi,

This series simplifies the s390 JIT by replacing the generation of
expolines (Spectre mitigation) with using the ones from the kernel
text. This is possible thanks to the V!=R s390 kernel rework.
Patch 1 is a small prerequisite for arch/s390 that I would like to
get in via the BPF tree. It has Heiko's Acked-by.
Patches 2 and 3 are the implementation.

Best regards,
Ilya

Ilya Leoshkevich (3):
  s390: always declare expoline thunks
  s390/bpf: Add macros for calling external functions
  s390/bpf: Use kernel's expoline thunks

 arch/s390/include/asm/nospec-branch.h |   4 -
 arch/s390/net/bpf_jit_comp.c          | 121 +++++++++++++-------------
 2 files changed, 59 insertions(+), 66 deletions(-)

-- 
2.49.0


