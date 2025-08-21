Return-Path: <bpf+bounces-66189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75E0B2F6E1
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B59E3B48BE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B130FF09;
	Thu, 21 Aug 2025 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OUS8eMXE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADA30F53E
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776043; cv=none; b=IJgcCbcA2vtgnGd6mGA7ZgWDB8MjVXYEONuqIZ5DeArn0RnzRMex9WuAl2xVidS23oGTujERe9zcoUA/bd6Dsj6VihedVzJdEFgZB/3799uHdo+kSjfd/nboNeSE/MRgY10jEulnnwk7AlkstNc5yASXe7wKAKHyHJBP2VS0cXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776043; c=relaxed/simple;
	bh=nO4e/V8UoYqpDBy3mJgmu2gIFTb+5gtsvb8Eay5OXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzTcSO9drWcQ3tWoXx5nwxc7oGpJhQk2vUMRWvtePys5avrWvMoDGIAhRmCFnxjk9OCgMptm5TjD5R+mQ+wLqMsfV5trIVIecqS7Qk+sPuADXVk1dcXHeo4vxzAdKs/m6edXNDQ+7TpRtIn/kmc0HR36L2J1Nf0Vdw7XPNDGx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OUS8eMXE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9BXqP026481;
	Thu, 21 Aug 2025 11:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rqFuGx/0ZH3rXpGfl
	yTMAyrq2Z0nX9dxJzh9a3XFoQc=; b=OUS8eMXE2LkO6Dz3D3l7k/vA80n9H2NLV
	ikyb7Zaeq8iWqiFHnyoR5s5v5w0fu/eXjFx1vmlHX5rGmaIbGsSQDCN6HwvNoYjQ
	48xZGGYW2lMbTbXMYOQjRryGhbm8cej6hMsRd5XuMFbMAKaJGdS10Bt3/nHQtLdB
	RTqHhW5/DJak1g1qEYS7SS3zFiMwa0tFtKj3YXzQKRj5ohBA0vAr1Z43+Z/ogbnd
	yTqBlzd8bOxlGxfzIz/M8Xh3O2U7jEAMGiCH5EA3aOSj0a/e6XlrdsBcoftDc2yR
	JAI/DQ7xbmREqYDPwqfkfO+IWhxmH/cCC8Z3EBY8WTRKAyNSdRVqw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgcys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAnoKV031881;
	Thu, 21 Aug 2025 11:33:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y82js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LBXgpu34341182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:33:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A926E2004B;
	Thu, 21 Aug 2025 11:33:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F782004D;
	Thu, 21 Aug 2025 11:33:42 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:33:42 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Add a missing newline to the "bad arch spec" message
Date: Thu, 21 Aug 2025 13:25:56 +0200
Message-ID: <20250821113339.292434-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821113339.292434-1-iii@linux.ibm.com>
References: <20250821113339.292434-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX4RoKSeNuiUPY
 HLOfCQpHHEiqVf+TQ0SXiILzAhbr5gECYxfKqywnFxl05lvn8lcgltqZzfQqEdCi445Xts/3Yzq
 zrJIEVmcX3gqmoWXBHDN/89YUe56wbVqtkTS10WGTLUDiMgfBXIQ/SaUqPo30SHZIBZdLl3n04L
 +LAmGJQP3AQxS7AKG2f/BRxQScGYahJcS+ufePscMtttr+2cKPby/nRsBGChDpPSeEI7dsqy0td
 3+Cf/4O+/81/vYSV4TUeYH36aKkBObZ6H7sbtyb40ukVL5EB53/iFQehCortRIIi6pg5XrRZI/q
 tMkitiaaoZciG4AYBgi+8jCw1wPo5pRMudEuh0Lax44LojuW0IGPt2lWTF6wnT9BxKx6lsgNc1f
 5dA21jXpoEi4xyIG6xDUz00dBdSd4Q==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a7041b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=BanrIxYR2-2DRMV5ylIA:9
X-Proofpoint-GUID: xPhYORTX3w-uwEDFNb_zHVCi4ibOlsGs
X-Proofpoint-ORIG-GUID: xPhYORTX3w-uwEDFNb_zHVCi4ibOlsGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

Fix error messages like this one:

  parse_test_spec:FAIL:569 bad arch spec: 's390x'process_subtest:FAIL:1153 Can't parse test spec for program 'may_goto_simple'

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 78423cf89e01..e1987d1959fd 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -566,7 +566,7 @@ static int parse_test_spec(struct test_loader *tester,
 			} else if (strcmp(val, "RISCV64") == 0) {
 				arch = ARCH_RISCV64;
 			} else {
-				PRINT_FAIL("bad arch spec: '%s'", val);
+				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
 				goto cleanup;
 			}
-- 
2.50.1


