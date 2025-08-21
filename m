Return-Path: <bpf+bounces-66181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6CB2F56A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148D63AB402
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1075305076;
	Thu, 21 Aug 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kd/Y1zMd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF2305060
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772401; cv=none; b=UNIvDpsKLuyZj5OwvNsXSlJyjp7odFRlVSPD5BcFEk7GizwuSicTwEvkCoJU9gkeNKe9KYZqobjnfeLsrqzRkjyAIau9HPcTp0vDl70wdZbfUzsIej+6hQpYJ8GRNyYlN/ShzOwle+Qc0BCgtY4ZQJGzoqaMnwHCrCDZkmvkijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772401; c=relaxed/simple;
	bh=406Lj7cHiLwEY3PiBMuiSNAcxZEZo7MLh/CWnkB0yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaD0NYmrM0PFd0rS1XDYEVWtiIwv2N/F9x3bBOoiOPnB7S5jPeWb4apjIe47mpbwm/Ik2s6zKKj8zHAJgYhoCdJuNAjONgKDA1wGvVCDunh3tIskZn5DJHbSnWDCOVEvq82QgVR7LkH9HnTJDeZ7BajFZwARlX28GodYHCJ1Hoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kd/Y1zMd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8sDpJ025278;
	Thu, 21 Aug 2025 10:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZS0QsBMVp55+iGsh3
	RbtrECRJ8pHiKS9Q8hGokbIVAk=; b=kd/Y1zMdGeNMbXY5iD9aBpenrZflOH/nP
	w6zx0sjSladasXEV463yaHS8kcuAbcqYnU1wVqT5j3XRr/ljssSXPpSIJQdXyd/H
	NmcQonDKOWiWGZV+HNTh+54L5+2JV7JrZlOddZX1Obi3+9Z7gPpCLv94CDP1Qwa5
	3r1gfYbDfFsTHZZU/p0n+qFcwSax6VMzSVY/3Is2FRpBjWVL8qFigofwIyVjtyGz
	wqn0TXe6mW8nAR8tEV4U4TgMCMPOCZrzhOKZvoMdwuvzBnEP8UEhkooQcIaWJk9x
	rhT92amui8MCKpwsNJ3ICWsh4RMFHV9Q3dX822Qpqf7uScYeJ1VPQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vg4y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6kOsu024196;
	Thu, 21 Aug 2025 10:33:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43qv0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAX2iD31588744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20C9120040;
	Thu, 21 Aug 2025 10:33:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E7020049;
	Thu, 21 Aug 2025 10:33:01 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 10:33:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Remove may_goto tests from DENYLIST.s390x
Date: Thu, 21 Aug 2025 12:23:41 +0200
Message-ID: <20250821103256.291412-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821103256.291412-1-iii@linux.ibm.com>
References: <20250821103256.291412-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXw/tdp5BzjzcI
 0cAlgeEVHPhU8zuDRBZHhk9JQe6YsF9lpxE5RuZrHb4alh5a2p0LziLSFFXkydqxn/9wMB2ZUId
 m1K/QIj6zEAHJausyf34bSaNxQKOPtcWaNXipXb0dR+DUfdTcyJmFN4Oe0cRlzWokkd3vXMqXfv
 fkMGmd1+CLNwCEq0tsH4sogu/J6Rx4ysJYNKWM5OYj9JOfawARGrm3l8WNzryxFz+XEnqXtHxII
 iQUqkxZFi0nUI3IGJ9U4StOQaYqzDocQu6YwociCnT2Lreg2Gv6tYDQJAeluVQWtsIuvgUamMqV
 8qomcqYUS1XtbytjB+/6QKrdoC0bLLx4TYsTGH965mihf26qD6QzBnhZm7/577LE+X7oYbElWMS
 pqM6FJExbKlWRHjUuKByBLYLtV1ULg==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a6f5e2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=4thOGrNOn7Xglyz1uEYA:9
X-Proofpoint-GUID: _HKi2yohu_wmFS_8K7-ViTrwYNR2xwbZ
X-Proofpoint-ORIG-GUID: _HKi2yohu_wmFS_8K7-ViTrwYNR2xwbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

The may_goto instruction is now fully supported on s390x, including the
timed implementation, so remove the respective test from the denylist.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 3ebd77206f98..a17baf8c6fd7 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -2,4 +2,3 @@
 # Alphabetical order
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
-verifier_iterating_callbacks
-- 
2.50.1


