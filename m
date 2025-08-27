Return-Path: <bpf+bounces-66705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4FB38A77
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB611C20B15
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5512EF651;
	Wed, 27 Aug 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JAXzFxHx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96A2EDD62
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324192; cv=none; b=qPbsI9+GMk0cHeMVUp/Jpbog41aEvBOQqkbkCEK0Dj7Mq4g74q2/8IH+0aPkVGW20mMkeAW7tCjW/8JS3d2hLjpPJ5xLVl6gcnMkYAtEi1ivPfIYXUHENnGPn4UCHWyJVcjMckZvvuybIRqccBIQEX8DxkCJmWZv/mjEwDmUMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324192; c=relaxed/simple;
	bh=rDjd9jqcqAeBrl4f7a8/tBbJgSdp/zhdF+FK9/5QQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZs1fb3wzobX7mUznOlTuITWzstXrsJtLgt3Abw87mLd0CZFAAkzHSC8IzoTw23/uEKR4qPRuJswLfsILwlSOm/ghMJCLyaMgfef2/mdsam0JxHY2kWB0vvi9jT3DOy6JMOKfQeEVz7NOZvPSPcVk8O2/RZ/waeUMKtLFA8H2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JAXzFxHx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGVgEa009514;
	Wed, 27 Aug 2025 19:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ArfGOY0jyOZANDRPZ3s//E9ad98VbcK8VyVKx2kIn
	dg=; b=JAXzFxHxEb2eECFqcZIn6oeHLxrTlX98E+u7/d8iyw5Vb0MNSH9lwgz8z
	J0HNYSEUHnTr0OqqHRjgrpXrtlX7EdBXI6GtR6OL3eSVpP963CVrcdxcekF4QCIc
	Jcj2traugoJUWc/j7u/e87q/TYVWqxnwPF6ZMozRWudcoMBtRsaxvphIHhGwHotp
	J4vevU/JhfG6i0+5GyOMWZ5wlcRVetZdaOOLABloVQrvOThAtRQsVya2P6kKkqFJ
	nmBlPnfO5mYqLzEps564ptrD5FJWAP/6s3rhG6d0iVn5gSJ8Dx5jXnT/WJ3lSd5G
	z+CC2MCJqhO6DKgnN4z2V+SfYzRYg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42j5xq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 19:49:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RJWj5x020803;
	Wed, 27 Aug 2025 19:49:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrc0spd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 19:49:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RJnVBc42992120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 19:49:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E8AF20043;
	Wed, 27 Aug 2025 19:49:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACDA520040;
	Wed, 27 Aug 2025 19:49:30 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 19:49:30 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 0/2] selftests/bpf: Fix "expression result unused" warnings with icecc
Date: Wed, 27 Aug 2025 21:46:44 +0200
Message-ID: <20250827194929.416969-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX5kbCT3E6OXtt
 rX5GGwoxyX0oEYP7FC7T58FsoAJlH9CQahpsvDPnU4hfmbkhL53WN6FVKXIJ7hDnEnouD+cEEfX
 WXQZujzeDRnlML/Vs/i7rixRYCIUtumiNI7MRroXbWZAKwziUIZmFEsHH7Lz3hWCrUxwZrPbQ/x
 pnd9Qi1FKrP0VnZjDtwFLNAgMzuEm+56Hrq1AMKFpNbeKpgPYoOzBoVJ61WIU7EVNJ3hibOPZfA
 sRKOpxjFFsyVli7e+5grRp0b6UFnLB2+6OsG0KIXR9CN4KM7jal17yrQXzBxpI7mgdxsdAyjc4x
 bdmeTG8jKvtuVSu/xlttIitY1LkuCyFHZoxLHa/gCj8BHtceHw5kvWtbAREZ8rQapla4EIIVcz8
 Zc3/DNUV
X-Proofpoint-ORIG-GUID: tn2OUv8mijvCW97m6wK8S4P6xK4pP9BF
X-Proofpoint-GUID: tn2OUv8mijvCW97m6wK8S4P6xK4pP9BF
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68af6150 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zgJPvcc40EOmiIEGL7EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010

v2: https://lore.kernel.org/bpf/20250827130519.411700-1-iii@linux.ibm.com/
v2 -> v3: Do not touch libbpf, explain how having two function
          declarations works (Andrii).
          Fix bpf-gcc build (CI).

v1: https://lore.kernel.org/bpf/20250508113804.304665-1-iii@linux.ibm.com/
v1 -> v2: Annotate bpf_obj_new_impl() with __must_check (Alexei).
          Add an explanation about icecc.

Hi,

I took another look at the "expression result unused" warnings I've
been seeing, and it turned out that the root cause was the icecc
compiler wrapper and what I consider a clang bug. Back then I've
reported that the problem was reproducible with plain clang, but now
I see that it was clearly a mixup, sorry about that.

In this series I implement Alexei's suggestion to annotate
bpf_obj_new_impl() with __must_check and add (void) casts to the
respective testcase.

There remain two awkward (void) casts and I'm not sure if I can somehow
make them look nicer. But I've added a detailed explanation how they
are helpful to the commit message.

Best regards,
Ilya


Ilya Leoshkevich (2):
  selftests/bpf: Annotate bpf_obj_new_impl() with __must_check
  selftests/bpf: Fix "expression result unused" warnings with icecc

 .../testing/selftests/bpf/bpf_experimental.h  |  6 ++++-
 .../selftests/bpf/progs/bpf_arena_spin_lock.h |  4 ++--
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++----
 3 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.50.1


