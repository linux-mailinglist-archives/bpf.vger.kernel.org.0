Return-Path: <bpf+bounces-33231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6847591A236
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BBC1F21A90
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9301139D0C;
	Thu, 27 Jun 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lZxJUBHp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C64D8CF
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479365; cv=none; b=cQm2XZ9Jq6fO67HR9+hGw8aXHbq1tEUFMobxkXA9Bi1t3TTWpLqghvGZg+RhuOyoB1TqcpD/uF7AIo29OzenljOH0GKW5DslPf6iusOBGPm57CpE8MXe+Q8KqRMQ+ji+vYQVkpYRGaOrKCOG/JkkgmrllOFPA/U1t5gx7wA4ae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479365; c=relaxed/simple;
	bh=SIplO42Q9mg3NgqG0trlhO1xe7fJgrXxjGLGBWowCto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJuWT0WN1zQYMicqVnheTV0HNd7gTXasiyyW1XtL1Lh6koROfoyprkMZ+0m+cebC+pA5SWXtqSTY77Gz7FYcW77RMgyFz2y05SGK0msm1/PwcgxGstNrEYv0cJM9NitV4TbQqG3XFSptxbw8E5J0MRaqHkD0E/H6roHAkE+EkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lZxJUBHp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8oBtF002905;
	Thu, 27 Jun 2024 09:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=yoXq1BBPCPhJiZZKQY6zyzO6FP
	6caVTz6PuQpmaPaxA=; b=lZxJUBHpKADm2uv8+AvWrcmPcH+yAA0DuSGBxt1jfT
	6PA1uUEOuAwxMGsCyahwq5iEGtMpxlPU3njKs0uaUt+hbA+vZ21JL3eX7Ogyt+6n
	5gs63PieHoKD0s/yoDVPWOAFV1to2CPPCdPWoRADjBio+mQa77sOTTZF4+mUApds
	4tNdlivCjRzOOXKf7yHfj2VcXtJYWrqdogNRu45yZEiMXbGXaHdarQuYTpCJtV3U
	52G4MphAUHa5jieZGtuC63vefFRijUG02qCYMZvpjUJyFx9Lc0tAVplTDZqVRLSm
	35SWdHXnWlyGtQ/1CXTa6+p1HidHtLp5Ey6USOEOnTmw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400yrygtjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8xj5N020074;
	Thu, 27 Jun 2024 09:09:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5msn03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R9934o52887948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C7520043;
	Thu, 27 Jun 2024 09:09:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE532004D;
	Thu, 27 Jun 2024 09:09:02 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:02 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 00/10] s390/bpf: Implement arena
Date: Thu, 27 Jun 2024 11:07:03 +0200
Message-ID: <20240627090900.20017-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yaOqMpOD6ovA7_chgVW6IZs8diaFk0YC
X-Proofpoint-GUID: yaOqMpOD6ovA7_chgVW6IZs8diaFk0YC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxlogscore=558 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270067

Hi,

This series adds arena support to the s390x JIT.
Patches 1-4 are refactorings, patches 5-8 are the implementation,
and patches 9-10 deal with testing.

Best regards,
Ilya

Ilya Leoshkevich (10):
  s390/bpf: Factor out emitting probe nops
  s390/bpf: Get rid of get_probe_mem_regno()
  s390/bpf: Introduce pre- and post- probe functions
  s390/bpf: Land on the next JITed instruction after exception
  s390/bpf: Support BPF_PROBE_MEM32
  s390/bpf: Support address space cast instruction
  s390/bpf: Enable arena
  s390/bpf: Support arena atomics
  selftests/bpf: Add UAF tests for arena atomics
  selftests/bpf: Remove arena tests from DENYLIST.s390x

 arch/s390/net/bpf_jit_comp.c                  | 400 ++++++++++++++----
 tools/testing/selftests/bpf/DENYLIST.s390x    |   3 -
 .../selftests/bpf/prog_tests/arena_atomics.c  |  16 +
 .../selftests/bpf/progs/arena_atomics.c       |  43 ++
 4 files changed, 368 insertions(+), 94 deletions(-)

-- 
2.45.2


