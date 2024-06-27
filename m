Return-Path: <bpf+bounces-33242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D964591A243
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BF528322F
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995F1386A7;
	Thu, 27 Jun 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3LjyQoX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6E137757
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479404; cv=none; b=rEvS7vkWWFiqSSNZjfXPXu74ni08EEeZthedz/X8B3nKcagZZpGHcrAGA9//d6e5pIMEj92K7P9r4xOLrY5kRen+pPD+/+beFY8MU2JLKTmQB1CIOuYB3sY/SBEsBW33miY2xNcLZ7ZBgNGe+Dvjgl+0kPRvacCD9aDdWJh2wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479404; c=relaxed/simple;
	bh=BKZBBqFysG+LIB9ZgMfMuJW4xSZtHessNP3KzI58zNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gN6v4eBcErV5mMXHe3cWbuXkZVemVhnKfFt3tHY61tM2LvtDEJQIVhK8PJJtllR9si4EfizgvElbsvGAUhhqPemJDws6fITuxec/WyUldns3bHY9Uc7VbXftib/tJPzCLuJtW2P1iR/gW27ucRQkqbQwmNnfii/1WZNmgLR/93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p3LjyQoX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8Sb4S006646;
	Thu, 27 Jun 2024 09:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=c/u3Rn8vfc1Lh4MRA6OM/YxpLY
	jfUeqd7VeA+YFwi30=; b=p3LjyQoXpT8YPAStK4UXPGg/N4886OdF8+l0MgMH6d
	wqJNELQUA4bl8WKpU0vupR56siHxkEQCtOR8JnHVGVPEsWSpXpxqHmqklxJFAAYB
	kJy1op6ZkdyehiGNoI0d+jaXjWKVjF4FI5BRyW04xRzZzqF+kxI6Jhu6ZbwcU8hv
	8I6Gkv3sMZTeOiOIcajB5AFKjAiu01rtAcZYY5pduKloTizYAEVSKaqqCqYb6QbA
	R27heV28SSbzZmVF7Co3zvFiztWgVnpkXjG/EG8tt/UpjvQytEeDxxK/iANK0QN1
	bE9TtjZnhOYU9OA9R5PRawFMrW7IL3UxtnQZ+Ok90pdQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4014kmg3en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8oeLA019800;
	Thu, 27 Jun 2024 09:09:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5msn3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R99iP435127628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD182005A;
	Thu, 27 Jun 2024 09:09:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBC5220040;
	Thu, 27 Jun 2024 09:09:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] libbpf: Make btf_name_info.needs_size unsigned
Date: Thu, 27 Jun 2024 11:09:32 +0200
Message-ID: <20240627090942.20127-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tD-KjJTeKMrsCQpWHPmsPApsBZYyFhlk
X-Proofpoint-GUID: tD-KjJTeKMrsCQpWHPmsPApsBZYyFhlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=865 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

Clang build of libbpf fails with:

tools/lib/bpf/btf_relocate.c:206:23: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  206 |                 info[id].needs_size = true;
      |                                     ^ ~~~~

Resolve the issue by making needs_size unsigned.

Fixes: 19e00c897d50 ("libbpf: Split BTF relocation")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf_relocate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index 2281dbbafa11..d2551d7f33c8 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -58,7 +58,7 @@ struct btf_relocate {
 struct btf_name_info {
 	const char *name;
 	/* set when search requires a size match */
-	int needs_size:1,
+	unsigned needs_size:1,
 	    size:31;
 	__u32 id;
 };
-- 
2.45.2


