Return-Path: <bpf+bounces-66186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8304B2F6DF
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300BB3B3886
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86230F543;
	Thu, 21 Aug 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pD5mwCwv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C92EE61D
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776041; cv=none; b=ECzPUUS36m/3mEC1rCl8vo+4J9nHPrwZnMwKrBlBeg5CMLCmD+Y+TajPOBYvWZbZMIlI7h9ATqSBDHvtiUT7adH3nRANtSkjDolbZzNW/mbQc41Nq850uBrx5zTdp9Cg1/kodAhAmkGfM5318RFG0GpyVUbiiXCTcueY8+962xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776041; c=relaxed/simple;
	bh=X+hmIAK0nxAcsRtOONpOD4JwlXX69So70oZeyv2+PYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvGQFepBFc6M42l+NKCh1dhUabM6qBUZPBWepHovB///70dGgQkt4IZemsnwEHtp9wPh9Lkxz80gtzsdfFxLNg2TZ+MuwPQBpgmY3w7vehMHT4W5i+gbiXPYrFgL/qv2/XMf/VEv/roH38AJ4s9Spkmq6cbLLT67XhddzLccZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pD5mwCwv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L96XZ3012122;
	Thu, 21 Aug 2025 11:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D4moxWQaBGhtsw9MD9QuQP0ILa7PXZg0QBC/796pO
	Xw=; b=pD5mwCwvyXm+WPPu5+xejzyZtW5b7aN+nEWPEWNcdulhOFhAZd3MPRHQs
	LrLXegkDKXFAEuXGHLuWE0UA45a+2mvjnvYaQTrX6pBbeGBGZsLUSVYvTj+NKzrA
	cGTzz+bA2cvfdNMp4mZgKapBmNm1SY/s9L2tfPk9gchGQWYWcpRW/NxJTe8y3IZ4
	hba0etKI2d+9Co7wh6k1CW4nAGvh7uvzEhEWs+FcYesMAEGdbNytmvjZ3n7dU2il
	62tsDmY/ixShYOYhGLrLvCkKcDe8s49nhpp0NsOQEnildRDhdGgF9hbRfS3MxlZV
	AV2khkmOimveQttTxbJQXQ+ZG9X6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgbt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAeYvf008354;
	Thu, 21 Aug 2025 11:33:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my428222-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LBXfP560621178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:33:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B59B620043;
	Thu, 21 Aug 2025 11:33:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44B0420040;
	Thu, 21 Aug 2025 11:33:41 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:33:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/5] s390/bpf: Add s390 JIT support for timed may_goto
Date: Thu, 21 Aug 2025 13:25:54 +0200
Message-ID: <20250821113339.292434-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OMELbOkCpku42facm1VIffyBMeoCdUpE
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a7041b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NseZoinHWYN4bXiSKgIA:9
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX9EZFbHhD1qs3
 rUaPvV53zeHhDhuG8Ay2qWlaXZ9aQo8ev6N7Z/B3uvNb8Q6/bqur+XT+PV40Dj2K+PPsE1RhFM1
 u4ua/OETxSjhy8+J9t4YQ7yA+MvGx7O0+aHcG3EW0gq0JEPlHOGVP2Fz0oCUDHMFMvlS4cRlF4y
 DUnc3eAaaUAqkj87JarVMAzORjTjzuw51/rBIHsFu0XoKfqGUU7sAzB6jVpGAwiw0tJ/Jr7u5C/
 4UY3IM6okTr1w7nNPgMBupM9uFYryLPX4ApsLHvCl/KABI8IElQ/IgGlVtWop4BWha3/QenyHOK
 0EDsbSITl3DY5wldUjTyNeKUa0xZynh0/yR8i4PoEbXcBa6FIdsUpLUCpop+CdQtEAEqTRq6e4O
 w2koE7hiHABNcM5TvZAGB8mK0pGzaA==
X-Proofpoint-ORIG-GUID: OMELbOkCpku42facm1VIffyBMeoCdUpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

v1: https://lore.kernel.org/bpf/20250821103256.291412-1-iii@linux.ibm.com/
v1 -> v2: Fix test_stream_errors (caught by CI).

Hi,

This series adds timed may_goto implementation to the s390x JIT.
Patch 1 is the implementation itself, patches 2-5 are the associated
test changes.

Best regards,
Ilya

Ilya Leoshkevich (5):
  s390/bpf: Add s390 JIT support for timed may_goto
  selftests/bpf: Add a missing newline to the "bad arch spec" message
  selftests/bpf: Add __arch_s390x macro
  selftests/bpf: Enable timed may_goto verifier tests on s390x
  selftests/bpf: Remove may_goto tests from DENYLIST.s390x

 arch/s390/net/Makefile                        |  2 +-
 arch/s390/net/bpf_jit_comp.c                  | 25 +++++++++--
 arch/s390/net/bpf_timed_may_goto.S            | 45 +++++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 -
 .../testing/selftests/bpf/prog_tests/stream.c |  2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 .../selftests/bpf/progs/verifier_may_goto_1.c |  8 +++-
 tools/testing/selftests/bpf/test_loader.c     |  7 ++-
 8 files changed, 81 insertions(+), 10 deletions(-)
 create mode 100644 arch/s390/net/bpf_timed_may_goto.S

-- 
2.50.1


