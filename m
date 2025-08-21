Return-Path: <bpf+bounces-66180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46078B2F568
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435E73AA6CD
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022D30506F;
	Thu, 21 Aug 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VgkvAxla"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CF30505C
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772400; cv=none; b=qNcBYOwLMAryttgHmWxnB4lR0wY6Jrl+EX3EsD0pCe7GHZTTawepz6pFkprXWCpjjkhmOK3LeGpE5tZO36BwdkE5Oxmcz6Sj+Ww4oTeTs4qqup9MBDPSB0ktMU+kgfFIPa9FJf/ZNZT5FWE998AnDxvXysHXjjkKaXjbsAJPOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772400; c=relaxed/simple;
	bh=nO4e/V8UoYqpDBy3mJgmu2gIFTb+5gtsvb8Eay5OXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdTiCBiLSo5GL3sWEDSzKAO6ZOND3F6WcPIWUhMChB4m0EbBXY1pUkwAQ4TmUPzSc3RLIINDeN/+LjHLHSOjZ+UeFBFhS3Xf+U+1XzrIVg8BX+DFSGg0IZohEAHvBs1cZYpRBL5ECiqpmPX9BgPWtu7OnAoeKCPwwxu9q2P4GRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VgkvAxla; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9oUmd011916;
	Thu, 21 Aug 2025 10:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rqFuGx/0ZH3rXpGfl
	yTMAyrq2Z0nX9dxJzh9a3XFoQc=; b=VgkvAxlaTmRu4SGEndt7UggFOh8cC58yX
	xA/wEwnYeetJIu0VlXrGWhGPg0fFValPDUah9rHuJ4Yi02oSRPlvqct2YiRE+rzZ
	k+wDRXn9liTSEKLgjFwKydlRuxnQKGUCIiOof4tFTmNrofcN/hOs5I0ELr4XS+7Z
	3BYEgSEfLajwTX03SXBfAXdZXrxBslHQEJnbCSgDnk9/2LkGcrtSabX/Ff8mPS2k
	wwaE3eFHFfPQ6FmFM1EMuCwWcsygC0k60Qzxk+8JTqZ57+dq9SQhJRmiFmgDkWWy
	4b671Xj0YeTY6236b7MnaZTaMV5uVFVo9zKUNOv/gFXWwmR+aY+xw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vqym6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6hRWQ026652;
	Thu, 21 Aug 2025 10:33:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w7vqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAX06F19923362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 642F320040;
	Thu, 21 Aug 2025 10:33:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECF762004B;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: Add a missing newline to the "bad arch spec" message
Date: Thu, 21 Aug 2025 12:23:38 +0200
Message-ID: <20250821103256.291412-3-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX1EOq7L7vx9rN
 LTIIcfJoGIfvYz5bR2AfC7CV+pIVdJmhIaLYUBuPqMXSjCJ9IQx9wcUPYeSOHm/ukBHJmYOaHLO
 EpSE7JtUz8pwUzDZQObVKyJHGstjkWVSaRi+wuAUtrF3iMGHA0Z78tyKUweNPimVxas7RaBlci9
 5ZfhuJZSzlauoblIYCksw5GAJZMv2FPOvPXO4FTYOA8A1kHj02Un+2t4ODo4ba4AnC2lnTDFW7d
 AAZW7BytSFvIURi+1yNZbPO5lh9wlolB5FJV1sLeiRAR1Vowo61ww+me1WzCXFt4Ze1LJ1eLcu3
 s0JvO6oweWh8z84HtY8xYLwO1wlBAbmEMj5Ip/qLRxWGtCPBLO1H25tMYzcpcJlEmVHbC8WS2uw
 5R75f77IQuOR/Vf2qi5YdnaRJmbwQQ==
X-Proofpoint-ORIG-GUID: 5-QYN79skwiU-bOfhsVbIyPpfcpwP6B4
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a6f5e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=BanrIxYR2-2DRMV5ylIA:9
X-Proofpoint-GUID: 5-QYN79skwiU-bOfhsVbIyPpfcpwP6B4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

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


