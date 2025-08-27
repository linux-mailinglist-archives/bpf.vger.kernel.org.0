Return-Path: <bpf+bounces-66660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA6B38369
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AC87B4A3F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0635082E;
	Wed, 27 Aug 2025 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ld3RBMJe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239BF192B84
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299949; cv=none; b=nG6uIXIaUH6S6bMMOcDq3okEkNPXUTjDl7Na+5pXlbGUoKSuH8HmhNle45DOu3KZEYaChtzRuO0zhYwe2mBujfFzAzRtpA7QlRgHBPnp5GptEslx4snKCMom2aaz4WzjtcKzr6LYvjnlXJqrAaPEurMI26ATvuPd3HqzEKBlQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299949; c=relaxed/simple;
	bh=HVkGxg0Al1fNBzIpC0xXT4gGmM2+YH+sS9a/0FDtZLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y55gDfZr4tCXJF6HzfKbDSxCFJ1l99v1fQnIboiRgFIX0cWtNL3dMXq39i1XIEMDzThE0oWoPSvYuM23gY2zsksi3MMHn/JIBZxuDcewbgk1h+S+l0/mxkXtSnkYVXPuUXi378cM6mAG7VyBpUXb0FLdwcRV6OWZztzLlYjUAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ld3RBMJe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R12HfN008960;
	Wed, 27 Aug 2025 13:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1U1O/2px4ay3BW8ag4Gt7NqJjhzvAiX+98M7ko7ne
	UI=; b=Ld3RBMJe3D4YNxsa3Pda016r+7mfH4cXyRuHIsxvvll2w+7jWJMQ6BR1t
	UIAxJvsiIYzSZfIhO/eksgMdv9mm2JO3h+v5Gc/jOUJcoDMzPcCKRbN6n06YIKIe
	CAp9gH5OYWF1M8lSiqAt/HSQgDBAm+c9BaHtDi9BjDSkNK/qqRlaNofjvkQsMv7v
	6Yqx4L3Zw0MDx83HVToHU5K+L5rEjw3Z6nwK5EMVYTiXg/cioBuCNCx4WkiHEbo/
	+bTI7V3Ow/9lN9HKsnxVN/BaY7Tyt0WuDR2f/kat7OFfqydZE+uQcA2qNYriY6Wo
	ENDt5TkpnvMTsMco6IrU87z80wjTQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5584741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:05:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RD57PC002571;
	Wed, 27 Aug 2025 13:05:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mfu83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 13:05:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RD5Ml041812430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 13:05:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E345D20043;
	Wed, 27 Aug 2025 13:05:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7665120040;
	Wed, 27 Aug 2025 13:05:21 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 13:05:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Fix "expression result unused" warnings with icecc
Date: Wed, 27 Aug 2025 14:56:20 +0200
Message-ID: <20250827130519.411700-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 64HWlw7DLNt2CYXae9rgnLaYdMjXHsLS
X-Proofpoint-ORIG-GUID: 64HWlw7DLNt2CYXae9rgnLaYdMjXHsLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXxcsz+HitCptD
 yWmwiXI7YwDmxVD3S20Gg74+sQysuE6PJzSodR28Lr1HMVw4o9pyrfOHJuShCzcbRnM01yEbGuF
 u+AA1zCc/qpJnZSKu0rNXcHjhvJPuKUoLJDc6/PmwDjtSMrHoa0iJW/gRB9Lz6LM4pwR1whNfMS
 MECe7qoDXhLZVWKWxQ3nPZcCnx4Dp7b3ab/Vkl+JIz4VqSCKiKoAxSthk0XNuPjR/fOuiu47ySI
 o32teKbutNxEo18680HyDdcK6HUxpgQlTKPzbZDgfpP08Gn++Lqmf9JIW6OIINVLSOwjbwWnFUP
 AOn2SJ7/OMA7Fv0f2NNd8V1gqfUlmwK00q3LgaE4srvBapho6tk318pXpKnj7wDq09DjNivYs/K
 4nb6jx0E
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68af0296 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zgJPvcc40EOmiIEGL7EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

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

 tools/lib/bpf/bpf_helpers.h                             | 4 ++++
 tools/testing/selftests/bpf/bpf_experimental.h          | 2 +-
 tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/linked_list_fail.c    | 8 ++++----
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.50.1


