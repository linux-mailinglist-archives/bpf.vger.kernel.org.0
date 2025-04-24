Return-Path: <bpf+bounces-56627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540AA9B4B9
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9F1BA69CA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C1289355;
	Thu, 24 Apr 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X7O+iB/E"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFF1F3BAB
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513747; cv=none; b=PEz2bz50iLIdPk6WiYYTAGmLaxuBlFlAYZs2EZe/3botuYlSb57po7m78yL8+XipdiRE2puutHSSIuV9lkMdnQCjoJCD7Rgrp8JpZTU3C+RiOgnst0Dh+LqCAlCD/WWq4j/CApWtSU6WoyxU2Jwtx5Z8UqJFQETaqaOrVXwDtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513747; c=relaxed/simple;
	bh=uDlPN4JXdOoW1+HN3UDnE2WvsvJfZmnRQ5QNUrEJPe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geoUMF5O4UDlPg2vm9KVRROX9qWdq9L7wDWzX8Qbdo9GlJpEmHME5LWha1hH44DT6R6MLg24xjNFe+NiKEts+T0fU/AgskK/9z8sl1NWTn+MIa4WII3X7knKV/9V0uo9kyE7XB7Ty2qqxhWW9n3tne85+ZzW921P8hORpiGohok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X7O+iB/E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAekK7020405;
	Thu, 24 Apr 2025 16:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=grwUh/R83Atl1XMLgCEJRjsjMjCzuBRWIwIkulj/K
	R0=; b=X7O+iB/EGae6mFEmLVANbZ3sjY87H7spgee+ubJD+0NthBRkS19iiOikg
	1uX30vQXsrGsQU+g87/e87iGUrQ7K5yTpcD2gANkWY06feww3Zc10njBdYeB+3Ls
	UdhzqLpzBv/7ZwvqekfmqMEa7h3c8k3um3jZP7kMzVJ4Ozy2lLYGigyEvGniEoOM
	4ep2dShZleN3AUq7wLCXTbJjGnLDrPGGQ9d5CS4dtCm1Dtj5vsaoYfw+ywjtR3Xl
	2lHrPM0lwvLKWjBbXLXJmQmbfHAZetJeOIGyb5343MFtAa0GtWVNgeGZFaPunNGu
	3vTyJ7q6lfB8xyBAGMwJyg4MvR3nw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krssvk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFNlNc001344;
	Thu, 24 Apr 2025 16:55:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy14xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OGtRhk46924058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:55:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9430620043;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63FC920040;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.201.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/3] selftests/bpf: Fix a few issues in arena_spin_lock
Date: Thu, 24 Apr 2025 18:41:24 +0200
Message-ID: <20250424165525.154403-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNCBTYWx0ZWRfX/Z7sGmlYsVNo z2HNhDQFo7Sj1BYugqtZX3GHs2u0BiNWWmJUdI+sr1dJaTcT9bnJlsSoK15Qvf0S1OWW7NifNvd 8oko5coFq+i+mGNOUDvYInt0lfzncPx3J3H8h71DJxHh5jXD3GwcgWtjRxkFZy6lFaKzDvkcx79
 g+bOQMLQ38QZ1JS2NoP6CiPlqzusFPB4UFSmDfgm/gzu3wgiNoW3EYsWaAchP0vpjohI1gRh16l CUDRrLeNua8CIH7Sb9KB/RIOZYJBZOUA/4+1AA/XXyFtIU/qdoXuVjicYHmmC0E1p++gE6IxXie BRHlMdufvJ2ODP4oJn+q7WeJ+ZK5STklgbKqb9o7+PgnwnnEH9Cx2hOEpCGTzUNxSrWiNaOxJ/2
 ougVGsnroUgv3LeUjh7yoXunHantR1CYKDwDrmCsRAcldCsCidowsHf/jhF1FD48/Hh8P91/
X-Proofpoint-GUID: f1xNc-rsVUPReOz2VOmEI0HP6Yd1OuSP
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680a6d04 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=RlltrnpUlQvl6RbA-LAA:9
X-Proofpoint-ORIG-GUID: f1xNc-rsVUPReOz2VOmEI0HP6Yd1OuSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240114

Hi,

I tried running the arena_spin_lock test on s390x and ran into the
following issues:

* Changing the header file does not lead to rebuilding the test.
* The checked for number of CPUs and the actually required number of
  CPUs are different.
* Endianness issue in spinlock definition.

This series fixes all three.

Best regards,
Ilya

Ilya Leoshkevich (3):
  selftests/bpf: Fix arena_spin_lock.c build dependency
  selftests/bpf: Fix arena_spin_lock on systems with less than 16 CPUs
  selftests/bpf: Fix endianness issue in __qspinlock declaration

 .../selftests/bpf/prog_tests/arena_spin_lock.c     | 14 ++++++++------
 .../bpf/{ => progs}/bpf_arena_spin_lock.h          | 12 ++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/bpf_arena_spin_lock.h (98%)

-- 
2.49.0


