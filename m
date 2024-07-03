Return-Path: <bpf+bounces-33714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D1C924CDD
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBE11C22306
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D651854;
	Wed,  3 Jul 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d3apqjxt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59A39B
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967872; cv=none; b=qbtet2W4rOp6eY+HvX4QJVmofAFkvT8FsU40Lqg2ko5BihGPF5icLZiKxzPG7D98VX3i5YbaRcGCmbqIy6GTcZFkYMnaJDxkKmz8xge9IagC+Wvc9EzaKkrKcxVxj4b0+7+LwYQOODfOM0zne2d75eua6JtLvHkxc230AnyvvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967872; c=relaxed/simple;
	bh=QuNUmlhSwZWMe5GvVtSCMq2ec5hlGETMDTjRxcxN2Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4Zgmz37zMrTqjqY4muCMVeqOZMrVaSTgaoQO8X1RmxVht4sceygN79esZ2b/S8JiI+jdKPWdJFEV5Iqyt3e3PYdRgMEr3N3lI+hnIw5MXI7CBFdft++M6B6glnJrZb7TQqVTIKyToLjd6O5KFbWJ6Ao160QUYIILlWXnEKECeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d3apqjxt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4630QuVM023739;
	Wed, 3 Jul 2024 00:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=BH+gd4AtnBytrr0SzufSw6/1Sv
	hIe6gmpvrxeRpEpCY=; b=d3apqjxtrnJwWMSNUKPHSx65/AuOTvNE/H0N7foupW
	HyjqKOMvgcIjsiuk+CeseolVJIFCZoPCsVf9ZFwRCLKWS+WTX+AWRnmE158RqqKL
	Z6nJ3TrmAiYTVgHUbLCezRv6ITWzOjRzJfXoxtD4tAO2SMaLNlvyS6CCaoAIrrcd
	9f4O94mC+BPwwzwR67HF924VZHSen8dOBJIGvDqgeccFf/rHJM3aBfZh4z43JuEN
	CaWKaUzWgveJM27iq+orfqKscMzSDWTXZKUzxjPPJYf0NeP8U/Ppi8+4MR4aMX4/
	nkDI1yKKpAAl3a5EQmgiJdHS/nflUbOA8sy6hG9IGwAg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404ttfr6hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 462KxRSG026465;
	Wed, 3 Jul 2024 00:50:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpytu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 00:50:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4630onnF51642860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 00:50:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0607C20043;
	Wed,  3 Jul 2024 00:50:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A60620040;
	Wed,  3 Jul 2024 00:50:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.78.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jul 2024 00:50:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] s390/bpf: Implement exceptions
Date: Wed,  3 Jul 2024 02:48:46 +0200
Message-ID: <20240703005047.40915-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v63WOLk4f05es-kntokZW00yPPuWe8lO
X-Proofpoint-ORIG-GUID: v63WOLk4f05es-kntokZW00yPPuWe8lO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_17,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=495 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030001

Hi,

this series implements exceptions in the s390x JIT. Patch 1 is a small
refactoring, patch 2 is the implementation, and patch 3 enables the
tests in the CI.

Best regards,
Ilya

Ilya Leoshkevich (3):
  s390/bpf: Change seen_reg to a mask
  s390/bpf: Implement exceptions
  selftests/bpf: Remove exceptions tests from DENYLIST.s390x

 arch/s390/net/bpf_jit_comp.c               | 85 +++++++++++++++++-----
 tools/testing/selftests/bpf/DENYLIST.s390x |  1 -
 2 files changed, 68 insertions(+), 18 deletions(-)

-- 
2.45.2


