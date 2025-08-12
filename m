Return-Path: <bpf+bounces-65428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E1B22A50
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEBF685BF6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5ED2EB5D5;
	Tue, 12 Aug 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q0PE4W+F"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7F2D29A9
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007966; cv=none; b=EA7KSve50+sg5lSLAFEoPJMWeUQ17/5Wkwj52ZTomaonVG6DhL9X3ErUJrSKto4b4dcjtt5nbX0LWlg99w5fM4bRWDiX09dThX8cc3hX1LaOyEgJvrmbc++7ggQ6CiQUNAy8vsOeTM/ZTrGl3i45BeIV7v3D2RiRpwEizWU25Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007966; c=relaxed/simple;
	bh=xgwOiCkPi4lEdi2rI4+XEU04zZmo9d+c4QIw/RuQf+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EgVzf2bhxt7nGCRtANYu57BXG/UvH8NopNUOcKjvb3pRXLjI7AR67cOthlF32E3lxUmLsIu3YZGzbn8LJU8uJlIB2hFi6YkcyH/14171ntQBdHQLqru12qiSQ2evYtGDnRhC5CiEy3lvVCcFWerbTeRCI1Rc5txRYiTbh/8WHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q0PE4W+F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C7oDdH024987;
	Tue, 12 Aug 2025 14:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hOnG5YLWqisbEAAAvzw5KIyoP5Mz2feW4bdKRXlBw
	rA=; b=Q0PE4W+Fg+af+PnGBYjSkDRIw73me1DooTGc2l9SpLTSe+4MChM/65Lj4
	84sXQXntMdalK/daWBTnM5/0wVdarbVwzhRGWPN4tAPU/am/58UIog7tx+dKVjSt
	N+cz/OxUshl8Km5xBUQhCEj4oHhxRkU/Jv65QYbt+3r6+TyTsdB2fNrIjmBiVR8c
	cBqqErS2luBRnzR+y7DjjpFCiZ7467lB93YXwFcrhxJIl/0k4jJdrvGzI14RNZLY
	RLWgHIhX4oR5ulgDoezvnavR5YHbmoaNVDae3R/GhltW3FRNYj9vUOVGXWOlxDRG
	v1DxHU+Il26Hp2uXHV8BQgG4OcQDw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnxmmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:12:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C9rLcV020623;
	Tue, 12 Aug 2025 14:12:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnptpc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:12:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CECJsJ51708366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 14:12:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6585D20043;
	Tue, 12 Aug 2025 14:12:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4D712004F;
	Tue, 12 Aug 2025 14:12:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.48.128])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 14:12:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] s390/bpf: Write back the tail call counter
Date: Tue, 12 Aug 2025 16:07:50 +0200
Message-ID: <20250812141217.144551-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzMyBTYWx0ZWRfX2FF4bUy8imn4
 f4SBWnKduWyBmGwQf1zQtMD8CU8BXdm6fiBFsnRHqilWhERRFkTz2aH7DJIha3WyYZTmzAHLEBI
 sZHwr1vzKDtudpLcw0Swomci9JzTHJ1G5sEaYeFixFj/JxX5T/1pfXa0DcIalG2Xq0qIBaA+QyT
 HGvrbEN0lLEtUoaOG1WPdj3Myop8E4bYT8OO5FxzLFun9hydrqo96hYZU0/o21/vm9ay150TVwO
 +sDZa9nPo2qe+Gs0BX57mA/8IuOAr4hMthFMnKfelRXp8IjgtMrQ43PRx6X+1NR1wKGlxh0n41C
 W2DT2dbM9xCWEH+5+kIIy00MNZ18Gemy5DQjqc4gjc+fg+gW/JAyubMtfXkP1yMM/YwxUNc9YMk
 k81zFEVl+6szjDF5nZTV8HJcoAn3jhsshXejnV2FYc1z+ZT20Jh5ifv0zGf9OQZ/0VuWIerA
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689b4bc8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=c4VwZEiHG4szvKHAD0gA:9
X-Proofpoint-GUID: Imc0u9zNIz80kmo4XN7zNbXWlBLUz4Ov
X-Proofpoint-ORIG-GUID: Imc0u9zNIz80kmo4XN7zNbXWlBLUz4Ov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=986
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120133

Hi,

This series fixes the tailcall_bpf2bpf_hierarchy test failures on s390.

It takes a simpler approach than x86_64 and aarch64: instead of
introducing a pointer to the tail call counter, it copies the updated
value back from the callee's frame to the caller's frame. This needs to
be done in two locations: after BPF_CALL and after
BPF_TRAMP_F_CALL_ORIG.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390/bpf: Write back the tail call counter for BPF_CALL
  s390/bpf: Write back the tail call counter for BPF_TRAMP_F_CALL_ORIG

 arch/s390/net/bpf_jit_comp.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.50.1


