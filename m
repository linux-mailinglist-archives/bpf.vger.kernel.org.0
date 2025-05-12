Return-Path: <bpf+bounces-58062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20873AB4732
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E736F7A943D
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3929A30E;
	Mon, 12 May 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/OaLXwv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE9298C0C
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088379; cv=none; b=MT0hl0jbbKiiNBkw4FXRflza19M58aku6/2R69ql26yrj4JXRXEL7nCPX/nx/cIIUdR+857OEdzdnXvlFiRHtp5q5HFyYyj+foTK0CTrJ5PCTlP9z3uEdoMdncyXZxVpjO/p+y9wHwJyU6xoWytWt8rIhJAVzpcE/GuSV5HSmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088379; c=relaxed/simple;
	bh=YdO2St/z1J+IR2h+JTp1zU6f5+L7xAAHeiXCPNPcV4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9+8u8JvCll9MNrgFB2GvK3jxIVv0ocouS3pXUA7YAWYzMUeVQWHvQ7KgIfFuhnKZfMygqq79bVBtMs8zM7dt0zKGhghGQQzRfLqDj16My9/BQD+1fWDHHwmmmfNyzKlDZOsyJbriKLAe8Uv9M4q4MkeS6RO1ZRA5GKGM5UEE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F/OaLXwv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CIsYEN019177;
	Mon, 12 May 2025 22:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wXq0vo/FusxeEDKvW
	ss2Bd3+2eG4PnkPedCwnOuaLXc=; b=F/OaLXwvSD5lXZ7Noh9pycys5vK/+tXfy
	8dD0EswXicZ40z54M6sr8PS6nAJEaBavj3HYhsnwFRBaNpIWQiVebVrtS2NF6Whz
	97cbCszwLHd7nAyNQNU30dk/b9u/a/5W3DTk4BodSEtT65bw3JRARXloBzijPaOn
	8uCBRrjdJ/HfB0lb52t7nncQvJmiE9zfy2n6uDnltvoi3fC4yUubYaSbUpi1YPug
	SvB7LKlLeKevrohC/V48meNVkLMf0JisGnFP/qeSRH6gnJf2QMn82Zwh/XoP6y3a
	Vtgir7EUhcjnn76UVkZKOHy51F7apjkZXV7BEpWdv+IG3qvB/jjxQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kpp78se2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:19:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CKPtpE016337;
	Mon, 12 May 2025 22:19:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jh4tgbd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 22:19:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CMJEQh7209402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 22:19:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C1FE20043;
	Mon, 12 May 2025 22:19:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F2920040;
	Mon, 12 May 2025 22:19:14 +0000 (GMT)
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
Subject: [PATCH bpf-next 2/2] s390/bpf: Remove the orig_call NULL check
Date: Mon, 12 May 2025 22:57:31 +0200
Message-ID: <20250512221911.61314-3-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NnPPGhq6D-_xqFa6mup4tcPhio5Ucp76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDIyOCBTYWx0ZWRfX8f9dGN3aSail HKPj1krGeplvcOOyUBzQDLby7tg69xbiwlVCtwFsiOMjjn85kAZJciOakRwKmTF11f2CqsNeWTz nMtE2SKZgZWTOLUVKXhVQqPnphxUXd34pKA16c1hD2mxDhyNFAhAhQd4Q4W38Fd9/p26rfb7fQy
 or91x6H8fVilGPQ9hgUdGSTJ//gY1TiiKuYF96kUiVwIDHKlbnxZBgBBpDOQTFLh40NR9poLs65 xLPUuU5nbeTCxAcrbxDLpv6JQHd8PpERv/nlkULcMTRA+cxzw/gFAkuoiQdtauLLUlQrov3Fnaj rFElparXQg9ZLHxNYFeGKROkSzBQm9XHU7GVN+kadWYL5J5FTRcpPOpSBRk0meyk38wlpP3EfXL
 INlLfEatJrrbMBO3u8ZagqCgTf4ElIQYgXAPujytkN/YHpB6Yt8tb+ZWdZ7eaWaRUnPoCOG3
X-Authority-Analysis: v=2.4 cv=ZY8dNtVA c=1 sm=1 tr=0 ts=682273e6 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=rzlaT6kWT-O21Dmo5HAA:9
X-Proofpoint-GUID: NnPPGhq6D-_xqFa6mup4tcPhio5Ucp76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120228

Now that orig_call can never be NULL, remove the respective check.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0776dfde2dba..4618f706067d 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2585,9 +2585,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (nr_stack_args > MAX_NR_STACK_ARGS)
 		return -ENOTSUPP;
 
-	/* Return to %r14, since func_addr and %r0 are not available. */
-	if ((!func_addr && !(flags & BPF_TRAMP_F_ORIG_STACK)) ||
-	    (flags & BPF_TRAMP_F_INDIRECT))
+	/* Return to %r14 in the struct_ops case. */
+	if (flags & BPF_TRAMP_F_INDIRECT)
 		flags |= BPF_TRAMP_F_SKIP_FRAME;
 
 	/*
-- 
2.49.0


