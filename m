Return-Path: <bpf+bounces-66179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35092B2F567
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D596F3AA284
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B730506C;
	Thu, 21 Aug 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qA7El1i7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3952305059
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772400; cv=none; b=syD14HDQqhvf1w9yCDh2eSbAlLAto6rhJWqW/S8l7rk0pGcLD2h8tgzWiyZrqwi1MuyzrRvlxBoSx/ijGLqZCrdg8kxDiFR0LtNkCg+2d30VsV4y2tAH3twg8fY4pg2o4v/0cggGGwdzcj011XAVuy8HlQif1mfS4HPaGu/c3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772400; c=relaxed/simple;
	bh=I9erTaF7M3H52IZpafR12qu46JSar1cuHaNlC0mqsZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMHA9y4WvMQYELtYPlB2xJMozO64qu23ZJH8OXgATsNTFOX6dar/9+HjUji1Tmm4F5GxqAuIigs1lvxt+3Itz8GFNoFpT/N0ZAAKqDOjF5IiXuCVig3SMuIU0EyPGo2TbrYETD492AwdcoVzDfavUI5Pz82+6d58IvqDyAXraJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qA7El1i7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9GJkq012808;
	Thu, 21 Aug 2025 10:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=INZPF+VAxrFrRoJKZO360k2hq7fVTU/9+eYFitwGq
	g4=; b=qA7El1i7+lxdSrLFoFMVvSl06d2ROtbLqvXxDEPk6wLlVMqdeMYpGZ0QW
	QJq3Nf1VDTHTxqoIGiHR1Q0LHXQFSKutfaI5Yvz4/h4OJ/S5FUNgvqanAHFLxnUl
	Mr8jQr7ynHYpUvzQYBqlLcGZppLCBhPx1n1p2kiEgxfYD3HBtHxj30ArydaxQkeB
	ZObxnENnseCwabxymsbnfezsZYg5fRT48yVJvg1n6GLrgcVAa/xb5iKkm4csqmwz
	RD3fLzcU1f1/cRUTtaBunBcx2SHQwT2F6ZCA1FPhV//dTchs1JP5nI/pp1I3LA1E
	s28f+QJgrKrjtbzmQO5zB25ASfMfQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vqyky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6jnYq024245;
	Thu, 21 Aug 2025 10:33:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43qv0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAWxF743844076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:32:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D46420049;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0131320040;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 10:32:58 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/5] s390/bpf: Add s390 JIT support for timed may_goto
Date: Thu, 21 Aug 2025 12:23:36 +0200
Message-ID: <20250821103256.291412-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7+UiY7I6iIPd
 eiUaIHxjkyIyGaVw2GILNF0AFE04Vpa5tMHgUkGqMPbCoDeib8e8EkFTasf2Vjn+arQW5wxC6dG
 fQ75TIzcCCz4Gcq3P1uEGA0SlmKXGxBNKTaait3RtEUGjmm6cAXaO8wFXWktfsYZZZskss4id9h
 g5LPWKjt9ADRAZh09s7BTEcLtNx0MT92AhjF683P5iIXs8M/eHg6PstQClaSy+A8IgPqX4s0Uz5
 4R5TPfHF/UjJVfen1K9oo0oSPxCaKfGTO0h8RnE4v952C/ash8QYjX8z55eQdbauRJ9iDEcdnnH
 7C47DfgSO71phJt8tBri1c1n+UFcwpby9J6MIabZmh5iBKrc4hit+8xNY23mY3SFJiNO1zCW85m
 Bc5pkIqtg8NVD4Kwf+bbPc+j2sy8qg==
X-Proofpoint-ORIG-GUID: SsdXsZsFF0p9lrPjfrZSqQFZa89zNV0D
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a6f5df cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=RWMQ9LYexVNuEeMfCDQA:9 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: SsdXsZsFF0p9lrPjfrZSqQFZa89zNV0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

Hi,

This series adds timed may_goto implementation to the s390x JIT.
Patch 1 is the implementation, patches 2-5 are the associated test
changes.

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


