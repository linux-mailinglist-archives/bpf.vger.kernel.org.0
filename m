Return-Path: <bpf+bounces-33565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4D91EB7B
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC335B214A6
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57BA1741C0;
	Mon,  1 Jul 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GDywiObQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166F173320
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877416; cv=none; b=nsH0ERrbYkR7VfLXE1mWrAMncKS4FfmEu8BlZt3B+UrMEk8VKmCAwHU1NdSdaikPdft9uAe+19yBRk2SEDPebfwRPw7LFLIwGIyRtCFTAuOzJptPEIhN0EbKGaB34oDkBj8DAPSmcChdiHOUIN3jiSie6/1hHNaMd/uVm82E2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877416; c=relaxed/simple;
	bh=UTfsQZ0r+lrhbtn09sI/eJdUThOcWuH4PH3zAaDttjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQOmY9OClI99C0ZBECDL0k2lsruYEXgq5oDFmxNeCP2yb3QzlWcLUIBLbQ4nkbzorYgZIkZHKgoNTup05BE6pBVhTAV+MbQq312pxbAiurXKG8Gmwp8sRe8Ul9ukRUBOW0P4KBonP3nbv/LgSoNJBtKI6bZFL5m5kE3SIVdhcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GDywiObQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NSfGE016642;
	Mon, 1 Jul 2024 23:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=orB9JIUNn0Nsj1OfJ0v1+jMD5e/g5f+EW9hiQlO
	f/vc=; b=GDywiObQsrhgG/NeYiFY53I8xb1LmqWCCRxY1QCnqmG52l4Z8/tq/b2
	OZ0/tPGihPNkdL02yQYF+2SkC0+oaXBf5gq2rgMgE5ATaIicxTcY8ouI3eq4F9k1
	dLUUVy7ykVLnAPQEp4UST02E46y6ENqdAqAZdqFyaKAAo1lCveLBF9YKR+l6nn59
	QHOu/2nIKgoNG+C22CchS86SQDiiaMVCew/97bhehGpquqYjvCDCe9Aw/KLfMGuV
	1GaCuJnUrztCxFueGp1Q5jJh3dsqL5BGO2dC4zP6rKHSlWo9ltXvv3OVxkc/i1sR
	SaMBLfMDjCDMDEflrlBStbAHsIR8RNg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40465g00sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461N1ZOY026393;
	Mon, 1 Jul 2024 23:43:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpsumu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461Nh7Jv49676728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B92020043;
	Mon,  1 Jul 2024 23:43:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFC5720040;
	Mon,  1 Jul 2024 23:43:06 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:06 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 00/12] s390/bpf: Implement arena
Date: Tue,  2 Jul 2024 01:40:18 +0200
Message-ID: <20240701234304.14336-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zL_NqIYkIwvXnxDfgZCZFY9m6EwD02nm
X-Proofpoint-ORIG-GUID: zL_NqIYkIwvXnxDfgZCZFY9m6EwD02nm
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
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=805 malwarescore=0 impostorscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010174

v2: https://lore.kernel.org/bpf/20240701133432.3883-1-iii@linux.ibm.com/
v2 -> v3: Fix bpf-gcc build issue.

v1: https://lore.kernel.org/bpf/20240627090900.20017-1-iii@linux.ibm.com/
v1 -> v2: Add a zero-extension fix.
          Fix wrong jump offset in the BPF_XCHG implementation.
          Do not run the UAF test on x86_64 and arm64.

Hi,

This series adds arena support to the s390x JIT.
Patch 1 is a common code fix, patches 2-5 are refactorings, patches 6-9
are the implementation, and patches 10-12 deal with testing.

Best regards,
Ilya

Ilya Leoshkevich (12):
  bpf: Fix atomic probe zero-extension
  s390/bpf: Factor out emitting probe nops
  s390/bpf: Get rid of get_probe_mem_regno()
  s390/bpf: Introduce pre- and post- probe functions
  s390/bpf: Land on the next JITed instruction after exception
  s390/bpf: Support BPF_PROBE_MEM32
  s390/bpf: Support address space cast instruction
  s390/bpf: Enable arena
  s390/bpf: Support arena atomics
  selftests/bpf: Introduce __arena_global
  selftests/bpf: Add UAF tests for arena atomics
  selftests/bpf: Remove arena tests from DENYLIST.s390x

 arch/s390/net/bpf_jit_comp.c                  | 404 ++++++++++++++----
 kernel/bpf/verifier.c                         |   3 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |   3 -
 .../testing/selftests/bpf/bpf_arena_common.h  |   2 +
 .../selftests/bpf/prog_tests/arena_atomics.c  |  18 +
 .../selftests/bpf/progs/arena_atomics.c       | 143 +++++--
 6 files changed, 440 insertions(+), 133 deletions(-)

-- 
2.45.2


