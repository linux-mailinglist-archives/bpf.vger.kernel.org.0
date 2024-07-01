Return-Path: <bpf+bounces-33486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BC91E0C7
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D39A1C2147F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E6015E5CC;
	Mon,  1 Jul 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eGCf8r9u"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485401CA9C
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840897; cv=none; b=fQMSM01/ivAzfGEVJ+LrIE9SuV3vEE6OWsnr5RLgf3D7CmOTsqwErg/BTGxgfKawxGb+wJxIihO0edKfDXPTqBNnHV8fhjYkMoO5fv9mSFSVIV02TemJ8FhP82BtoZMOoh98JmbMZgigOP5Rp8ys2STl6//MDWFKgK85bGlLIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840897; c=relaxed/simple;
	bh=6gAD6TyfhItxjcVrvH0wKroZc7vLbi3tCJEQ1xxgqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spkfdlUrpXNQQfjnmMGXMo7+Wq1a1ZZX/2Ws+2pOUPo40eC3bt1FHlIPryDOR3+mt3Wx8mQyBivA4M4GlzaYZ2pb93DVU2tluX9s4AQsAmio9F3LU8dcS70gI/0cXepnXyvGg4riMn7tWLz+Z6Ir02M1jmutNz4JLMlHekSOyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eGCf8r9u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461CwtqP032457;
	Mon, 1 Jul 2024 13:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=dXbXIN+5cpGDTEkdtS6YW8ln4u9GGMcJG/+vTPo
	Zo70=; b=eGCf8r9unrHH5ZcNHD6FTLy9SOwuVBUfQBnpmSOyDTGYn3/uFYjlU3N
	T2ROeNDUXuD4563HMPvZNwfoDaw9/GDEIjXCQUu5BSATm3svtUGZ4LObwAVe5dch
	CATthaWI+QIPQsbD4UESyCQ3Nh7XzNBqju3NFInM7v+d4AOujV1SSnnGv5hb3YNl
	HaFnIMgfSeOYc5fOBQBSEitDREqVd8nB5FUjVu94RUGLe/u2xRR3iE7GyK+ghuwu
	1oo7cbXcppycpqOj4yvkH9d+KLS78TGMAH5Ix2fJcnPY5uOt8lGJ8d1UpAoEsVyZ
	eV/ocCmRYw1Z1ZbvNq6olOe6b2lzqlw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403vx6r2wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461CtVV4009529;
	Mon, 1 Jul 2024 13:34:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtmf7ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYYdx17695158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 884D92004B;
	Mon,  1 Jul 2024 13:34:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DCCB20040;
	Mon,  1 Jul 2024 13:34:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:33 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 00/11] s390/bpf: Implement arena
Date: Mon,  1 Jul 2024 15:24:38 +0200
Message-ID: <20240701133432.3883-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PEmBWp4-jCXs9hYAgykkmoRvSZ49WB9Z
X-Proofpoint-ORIG-GUID: PEmBWp4-jCXs9hYAgykkmoRvSZ49WB9Z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=712 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

v1: https://lore.kernel.org/bpf/20240627090900.20017-1-iii@linux.ibm.com/
v1 -> v2: Add a zero-extension fix.
          Fix wrong jump offset in the BPF_XCHG implementation.
          Do not run the UAF test on x86_64 and arm64.

Hi,

This series adds arena support to the s390x JIT.
Patch 1 is a common code fix, patches 2-5 are refactorings, patches 6-9
are the implementation, and patches 10-11 deal with testing.

Best regards,
Ilya

Ilya Leoshkevich (11):
  bpf: Fix atomic probe zero-extension
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

 arch/s390/net/bpf_jit_comp.c                  | 404 ++++++++++++++----
 kernel/bpf/verifier.c                         |   3 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   3 -
 .../selftests/bpf/prog_tests/arena_atomics.c  |  18 +
 .../selftests/bpf/progs/arena_atomics.c       |  76 ++++
 5 files changed, 408 insertions(+), 96 deletions(-)

-- 
2.45.2


