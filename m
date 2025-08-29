Return-Path: <bpf+bounces-66924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267FCB3B144
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3001C28496
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50231DFE26;
	Fri, 29 Aug 2025 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WL4RfoVd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7055D515
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436440; cv=none; b=VzQNGNSwH/DTy/FYuaXCTpOZ6OIyOZxiCVBOTyTN4hfQVubk9ylZT8pzhyNwv+IbLn+jhgcTlO6ogWDDAm5Ag8J3BB+uO/EtujJS/XiF1/OEdZ57mRwj4P52LcZTBzJGPmqOHhptxvNk8P/PQHZyJxAEtYq5f/IkJ09bCGXbRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436440; c=relaxed/simple;
	bh=c1Dm2r/FSoYUyA2l/2IED9cjnFJkElUGqcqjvGa+q6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJ36xocLQGPO2xa8uD0KDkAAhdGzfpMCAdErMm7oqv23M3OJiRyuuYW5rmOc2d/SaQJz1jdosfAyBIOt7c41FbDNc2BTJbIQDRVZD0jp3GvOYPFDtYcuPtO31eMlXz6Mj4XBGAYcTobkdJhb6oxiQN7J+sVOUuI/dYohlnUGOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WL4RfoVd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SMcwBB025123;
	Fri, 29 Aug 2025 03:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J5B2SqMIJh1nuKfAliwr/pHrUrsnSL4/Yjzp7qrX4
	MI=; b=WL4RfoVda4Fl81k+F4KOsenHhTiz9WTlGJKB9qaMlJW+7KUO8KGlj/EyB
	iEeZal9L7nIP1+UkgkfyOt5NKPzAcUSD94eZn/yESh/7isDUP3Mgo61FT8tgDbOT
	5p99oU8w5XHEBVVuDhMg65FbubNeQohnDkmC3Ib6DNPMn/MFNjbEo2GENHBTq9L2
	3A4R4PQfsTlimxWZJd0mEYyvjv5g7t/DIVl+wPQi0GTpJgziHc722X0Qk+Tpas8B
	7+NkAIZ4/zxyecAOPNWoeolIseoJY7H33kGaU5QacVlvCE0++GfrUGK7CYLi4mvS
	kATBRm5QaarmtHFBHrfk+pBPRJaEA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hqd2xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 03:00:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SMsIpV018021;
	Fri, 29 Aug 2025 03:00:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3qkkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 03:00:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57T30KFg53412130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 03:00:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C922004B;
	Fri, 29 Aug 2025 03:00:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D4620049;
	Fri, 29 Aug 2025 03:00:19 +0000 (GMT)
Received: from heavy.t-mobile.de (unknown [9.111.84.82])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Aug 2025 03:00:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 0/1] selftests/bpf: Fix "expression result unused" warnings with icecc
Date: Fri, 29 Aug 2025 04:53:56 +0200
Message-ID: <20250829030017.102615-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+r10h7kBjvtJ
 gt7ruYcBVmiytNNnpf1ZTEDpXaGd0e3hyORE+o43cs92Mk+5WbDftwx37bkvn0aFc5B3n8qy393
 ePaywuVuun5yW1nJe6k5BxdEgSYomTOWKlB+Xapk362Ag/PjEJMd301s1AjtjVf5YW8Tuf2RlrJ
 V7xiMUblxKvgW3Dlo0KW+H8Tg28vNoVhHEe5KwaxQTSKJlMds/HwvvBhuodqcxe5xJty5HpLYCg
 PkME/4iOTs+FDou5MDRuFLCtgqhAFZSZKE008/wd44dw9xA10mTjkHoR4aGv3/zasxJ0i0m0kqk
 2rRAGm7x16QjJFcV2FFWBLYQ2rQiOUYFqhAdaiWbGNMDnIWjSx1Ip2Mt+AuHbF98EOk/jHCvXsp
 yWPl8YrR
X-Proofpoint-ORIG-GUID: I-vobxfSsxeCMlpdbKw4Em-n7zPRKyLd
X-Proofpoint-GUID: I-vobxfSsxeCMlpdbKw4Em-n7zPRKyLd
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68b117c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=zgJPvcc40EOmiIEGL7EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

v3: https://lore.kernel.org/bpf/20250827194929.416969-1-iii@linux.ibm.com/
v3 -> v4: Go back to the original solution (Yonghong, Alexei).

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

The solution is to add a few awkward (void) casts. I've added a
detailed explanation of why they are helpful to the commit message.

Best regards,
Ilya

Ilya Leoshkevich (1):
  selftests/bpf: Fix "expression result unused" warnings with icecc

 tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/linked_list_fail.c    | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.51.0


