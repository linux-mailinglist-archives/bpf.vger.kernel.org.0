Return-Path: <bpf+bounces-58063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E0AB4733
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4187A95EB
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797329A312;
	Mon, 12 May 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQRqZ10D"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6D25E44B
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088380; cv=none; b=SaqaFGOm7GPop2QEPVnEitdmkp9uy2Mv0IjAIDclbl+oU7w87KfIdXrCSg55gRA3tVOfpj/ZTV1dS5/vLSd738Q+IssTwYN4HqeJLcr1wDKjE4Rtp2+S3UkrOGEV9DQeM7nFWExyMxELBi5BifcUlCYpRyLNiARdOqYmSlwXVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088380; c=relaxed/simple;
	bh=CRKYMMtbvY2s3BAdEd2Q53L0tsbQwMZCwFvO7Fd1kaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpEtO3h+TwUYRnk4SNzrq5SiiGZsmFmfaA6SoIkpdWLwneiG5WgTu1ihJCIbwxe30tqtIqJd7t7C27aF08b6nCvkbbLsYu2Gj85SjIqyyWhUktPASbBu3lGt3z/zdjz8RqfX4WgmmKHHUu+DcWabQl+gVmYwMokD1EcnlNwWJfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQRqZ10D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CDnCVQ001206;
	Mon, 12 May 2025 22:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Bi4M+hs8IwnkyBRxH
	UYnRyAMWDVHvbngu0Z0wOX7a7o=; b=dQRqZ10DYgNVgSEWN9WjR2ZVkAnErTK+X
	JhB1gc1b04TA7xg9cQ5fsPsMD7M9noiDWwR3kwqXnRjIBo/V4yr27Mpk5DwbENyv
	tPDWOKv4UmfsbJJAb8t53g6xriQhlF0gMk+PHpZR29hv9or6gw76inZ893AG/mRw
	59ZgvrzHkkxDmunaWSjEZuTWOS0VYOIad6TfwsdAFHl5r+tRYCoBWh1ALBmAkzlT
	xr7GTxAX41pDe9X9zCRP0+3EHH0br4uUBhEtLhnuqYPeovSVpzh4mS58O6Zu0EZ7
	WeRJCulHQ3qp4SAz8DCA7364XSWqAvo1mVOkEP6dMD5k+CHUWrBBw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kj75a9sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:19:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CLXW79024452;
	Mon, 12 May 2025 22:19:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmm01ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:19:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CMJEc37209400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 22:19:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C0120043;
	Mon, 12 May 2025 22:19:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8591720040;
	Mon, 12 May 2025 22:19:13 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.156.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 22:19:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/2] bpf: Pass the same orig_call value to trampoline functions
Date: Mon, 12 May 2025 22:57:30 +0200
Message-ID: <20250512221911.61314-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512221911.61314-1-iii@linux.ibm.com>
References: <20250512221911.61314-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDIyMyBTYWx0ZWRfX/NJwwcXp4MoB LfR9cjPVN2thugHeBQcAaeL3za1nIrniWGs0KChG0hrcQWJJ1oDOFPERiOkPetU7BVI8+W4b2A1 WqyqJnhH02YXaqGCA4F5GCm4YmrfzHya0c073KLt6sLzy7yiG0bUrSKFYRGzBi3UqnSlSrxLxvw
 2fggyZL2wG8ZJvEXThLOdZ9n28E7+JaXqccJdmc8j/wj9oFWdj//xdZjDjr1JK4tk5H3dSxDf2E 802Hu37XV5sUXF5rmA4rS46+uXR4xiSxMIZq2Ov7asX5SYgpi4Srzn9ETolcu5Po+gXu7xqdkuE 3Wwe3JrAWOA25BLiEREtsRsSYZ/fk6fOfC4HEeedZ6WzMhHEQCR/yMnfV6uJVfF+fAquAN0C3tQ
 X4fEUlGtZY1xOTz5uAj1mNbr3BbuSPGElYJPGH3BiU9egXL4zW+jaAAnRSoM3xpShKF05dm4
X-Authority-Analysis: v=2.4 cv=J4mq7BnS c=1 sm=1 tr=0 ts=682273e6 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=cO9JoV8qSjZ_Ol6FZU0A:9
X-Proofpoint-ORIG-GUID: OO__ztdtiXNmZ8tubgQTUHK7m_gepeK4
X-Proofpoint-GUID: OO__ztdtiXNmZ8tubgQTUHK7m_gepeK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=893 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120223

There is currently some confusion in the s390x JIT regarding whether
orig_call can be NULL and what that means. Originally the NULL value
was used to distinguish the struct_ops case, but this was superseded by
BPF_TRAMP_F_INDIRECT (see commit 0c970ed2f87c ("s390/bpf: Fix indirect
trampoline generation").

The remaining reason to have this check is that NULL can actually be
passed to the arch_bpf_trampoline_size() call - but not to the
respective arch_prepare_bpf_trampoline()! call - by
bpf_struct_ops_prepare_trampoline().

Remove this asymmetry by passing stub_func to both functions, so that
JITs may rely on orig_call never being NULL.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/bpf/bpf_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index db13ee70d94d..96113633e391 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -601,7 +601,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	if (model->ret_size > 0)
 		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
-	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
+	size = arch_bpf_trampoline_size(model, flags, tlinks, stub_func);
 	if (size <= 0)
 		return size ? : -EFAULT;
 
-- 
2.49.0


