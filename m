Return-Path: <bpf+bounces-58061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0BAB4730
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3462F3A9D58
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963A3299A9E;
	Mon, 12 May 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3IduKzG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2524DFFD
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088379; cv=none; b=kmNRnofWUSZVzyWwa9x4khGZcugefzG3HXzdyWGmdgD8oXM28DEi5YkFpPE+Mup1OmnR7y+T6h5D8Eqwci2iydP/fQzDQ9aJH6nh9PjJkbRgrTWm/uxNTj5N7UXpXKP1hW8oz7F9NvDnq8ktskfMCLTZ/ZextsYuSBcQcR1D3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088379; c=relaxed/simple;
	bh=I2jmmhjO0DE/ylow+uBxfBvzDHpDwAwB0MHjK7+uLcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8QZIxEndgMqzHZNqkqhGcQ6karTKnEXw4DQYaZpJhBydqvnOK7KncQUz9E54Z9RLi+QTnMHAC/N2NUs8Zq308lqzWcZpF8FMOCPo0jL4gYyRCbQw0fD7NQfmsBZlogtXD9mZn/hhfUUiYX4wUVarDL+puZt7txjEV5i8qoin40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3IduKzG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CIsTSt019134;
	Mon, 12 May 2025 22:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dsxWXwLk+sRx3Te+5n95WlqQcLLbofB1d4OM4iKf/
	AU=; b=S3IduKzGXLjPb9hi9utoNXt3bf1gcYddp5l7QCvGlpynnd7H2D7n+fJUK
	jFVeLHqdBAwFW8q3eQNvKN5wFRr0mLbbs3Zrn/SSQdA8VleXieM5aJNxbW64TECm
	VtM/c4cRLtzgeQg+vPBm3ESRxPUMTNtlQ7w8Sq7M253DBtOMoMgbX1SjR45Ld8j8
	6CLjSwtN8d6gksp/7i4vhx/1OjzzzkIpu2VqxDFeN1Q3IfBhfh97sFBm3tc3cGhs
	7BrdTtI1kXBlV4GGRd7XAzavU78/lBGQS1XEtk6e/xVOiN7vPInz9QB7B0c8Oujq
	V+r8saxRd4lCB1xDIjVUJN/ESXnCw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kpp78se1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:19:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CLtdFw003824;
	Mon, 12 May 2025 22:19:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jkbkfx5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:19:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CMJDT144892434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 22:19:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7430820043;
	Mon, 12 May 2025 22:19:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B07920040;
	Mon, 12 May 2025 22:19:13 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.156.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 22:19:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] s390/bpf: Remove the orig_call NULL check
Date: Mon, 12 May 2025 22:57:29 +0200
Message-ID: <20250512221911.61314-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fAYwCSmQG_5eHs4EVJvvtfUa4XaGmPrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDIyOCBTYWx0ZWRfX3Mf8biVsDE3L iHZcNZbpC20o0n9xLjKHEzpxFM/U+FvbBcFrJCIysMZ6eD4TZOtys8Xhj0HIuVqgCvbN5o6QhbU yFqyda0qI/lrLnyzHDXGrsC1ukPVfYB4mhJd+fKGz2qQX1PNBxusy6R8y3KBW8wQsyXB5c/CHFy
 KhwqV8azMsMQU1Ka9cuxmBvPyFE0s/4X6NAl8yYOnqlm98HmCXT4L0kmI0/YMJJxhpxoYV+BqNd Ukl08/0QENDtaWPYFK1FTFexzNXK/yKVHKkn3S8XYj7R+WMyowlSMhRzpRzrruS7DK3bxlwjNCD Tf3fDE9HxucEoxELViaY7CYHwtR2h796hZaKhDh5N4IhM35aYJ/ETa5OKZ54MJ9mK8X0x6CBg4g
 TA2Wdf4hU+WM2gx6Oj8kQFWmLMw/HzKqHvp9uQOAuKrT0RGL6gtHaQSGw3tvoPgDzjPxJ/9m
X-Authority-Analysis: v=2.4 cv=ZY8dNtVA c=1 sm=1 tr=0 ts=682273e6 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=dt9VzEwgFbYA:10 a=fqeYTVjFZOG2rq25rEcA:9
X-Proofpoint-GUID: fAYwCSmQG_5eHs4EVJvvtfUa4XaGmPrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=862 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120228

Hi,

I've been looking at fixing the tailcall_bpf2bpf_hierarchy failures on
s390. One of the challenges is that when a BPF trampoline calls a BPF
prog A, the prologue of A sets the tail call count to 0. Therefore it
would be useful to know whether the trampoline is attached to some
other BPF prog B, in which case A should be called using an offset
equal to tail_call_start, bypassing the tail call count initialization.

The trampoline attachment point is passed to trampoline functions via
the orig_call variable. Unfortunately in the case of calculating the
size of a struct_ops trampoline it's NULL, and I could not think of a
good reason to have it this way. This series makes it always non-NULL.

Best regards,
Ilya

Ilya Leoshkevich (2):
  bpf: Pass the same orig_call value to trampoline functions
  s390/bpf: Remove the orig_call NULL check

 arch/s390/net/bpf_jit_comp.c | 5 ++---
 kernel/bpf/bpf_struct_ops.c  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.49.0


