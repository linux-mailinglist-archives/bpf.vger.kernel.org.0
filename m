Return-Path: <bpf+bounces-63479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDEB07E5B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 21:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94227BA480
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46028C2BB;
	Wed, 16 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tse7rt1E"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A505274B2E
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695146; cv=none; b=pIJudYSrif/Ann/POPHAn97AWx9pf5+NGiYxa2DWr3mSb1x2n2mhJ0Y6oAWG8M/LtJkw/MIauzWMMVGsRkVUgkwHQ/GDqz4c+SYREaGQlF0kfntofsBw4wl0N3rXqErJlsLP2AwfVQH5cYWoshdBpKLiztshqVbgNWONdR6dmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695146; c=relaxed/simple;
	bh=Pjl9jWBs7ns5YW9VTZSf5jeopFg/Jxvla4BymLPJYuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsKnWdMJkcVQsZt3vvJ9WIz89EeaXgJKYkWOTW4ZbV8yevr5C2d7gqe+L3y8WeTpBQSFf9SMasL9UItjmxBxZIO4bwwHCLj4ALLVxtnADC2MNgP5t7uRTF4EdRd0eC7WV8apFhh3hlzgdHwa6GIPKj94GzgPwB/8RZLPhpfnZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tse7rt1E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHNb0a016012;
	Wed, 16 Jul 2025 19:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uZqAIk9UhGOS6hVzdibaRnE0+2XwZyeQz1DnB2nRS
	YA=; b=tse7rt1E0uiNXWTGcz/G2cN87epwhwkCMgphBg4AspgJDKNdnhrbtihbn
	W8LfSB4ps9QmkihQ7AkK9rRR/noEAaT/xsdVheKmoE/8oqK4G0hfzva2MzZT4jiJ
	D9MyqXWERwo1e1ie/SG9wecYahEO5mFio8LejdGYtf8UqAVmPiU2K3/RIP4AWhhD
	UZIVyxfmdcV2ff1B9k3T7vyWj8tDastt4b2PaGzDT7HtTeUMsf4Dq0C47KeQB4qz
	AZdOdh8MkpPXVuXTVK0Vh00soUh4rdYd5wfNcir68y0++Nd7aTscDjdYG8cfSob/
	jKDNbSy0yD8gO8QkprPEGihMnQQmw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4u738s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:45:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GIVVEO008957;
	Wed, 16 Jul 2025 19:45:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmrx4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 19:45:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GJjQEa53739928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:45:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5111A20043;
	Wed, 16 Jul 2025 19:45:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFDFD20040;
	Wed, 16 Jul 2025 19:45:25 +0000 (GMT)
Received: from heavy.lan (unknown [9.87.137.252])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 19:45:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again
Date: Wed, 16 Jul 2025 21:35:05 +0200
Message-ID: <20250716194524.48109-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6878015b cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=R_vsQ2yZ_576QZPR0DYA:9
X-Proofpoint-GUID: 5WIYRSd9QwArMUjt8XQi2oENjNkMf0Vl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3NCBTYWx0ZWRfX9GLAx6oogCt9 I0BOY3XOMIX3wllMD3pAQevfBCy3LVedPR48FsCBT0sY0AADJhjgxB05JrO5uJCjE4rqO4zjUh3 LwjISc4k7ubuDyhiG12cx2fvwoFy/jAAzF6MlBiKqnVDqdsCBR+gZ7+X23bjuScrkubiJNuvOB3
 CJYtbMBqDSOmPjdNi9rcGCcjc1gvA8sdKYTbH/MZoaY7W4I3ODAMk4e1Sdqe4y6QN8COpJrtf2/ qXjxuJtX1x02pKoSfn+3c8WCO/z92/M5maTbhfX0dDprsLXS4JxxMgeqVrm9ZM8FyUw4K0GE80M exp5GgWZ/ot7ZhqZB6vfxYXOnGQkLQIoivTzDYdUgV8HJpZIdtOb7scIWNtRX9WxUi8tPOCKkj5
 pdrFEmc5deGXjY7YB6O1pSQn95PDE09gsIAybkm3rbLx+thpI3FFxz2rUrhUOVSOeN79vDNs
X-Proofpoint-ORIG-GUID: 5WIYRSd9QwArMUjt8XQi2oENjNkMf0Vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=804
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160174

Hi,

This series fixes a regression causing perf on s390 to trigger a kernel
panic.

Patch 1 fixes the issue, patch 2 adds a test to make sure this doesn't
happen again.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again
  selftests/bpf: Stress test attaching a BPF prog to another BPF prog

 arch/s390/net/bpf_jit_comp.c                  | 10 ++-
 .../bpf/prog_tests/recursive_attach.c         | 67 +++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.50.1


