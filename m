Return-Path: <bpf+bounces-66191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4059B2F6E3
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2062A3B51FE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B280310652;
	Thu, 21 Aug 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D1eumBwp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225E2ECEA6
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776043; cv=none; b=axBUN7ilIWxLGUmpxUbqOQIuo/Sn1cMNic3x+LUzmXcBgFcb4tJHgH4/D3z1JaGw3ouKKc1oyxiP9mRpXjDzJhPe4pxi3dolUbWbfQYei6ZqE1JXJu4smVF+QE/6rY64r04Xwy8QiJALHOteO1SNRbVIHHcj9+sU/VI3x+HKMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776043; c=relaxed/simple;
	bh=406Lj7cHiLwEY3PiBMuiSNAcxZEZo7MLh/CWnkB0yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duR0QatZK9yQeM0tFiVmSEMDuuHUZuKL5gEK1+Mbclf0/MZ/+CpjfcMq9KN0DjKMnApW/7HHjPO+f0hH2RHFLSTVEaIyPJZBOhtZzrnYTpQTN0ilEQgtaL3KDR/wBeRdIAhsDyUWkAR1Gw3KUvEXUCrnhtSL2WoP38EPOOS3u1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D1eumBwp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LACZB3001831;
	Thu, 21 Aug 2025 11:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZS0QsBMVp55+iGsh3
	RbtrECRJ8pHiKS9Q8hGokbIVAk=; b=D1eumBwp7uF2FXsA+S1YwMrLPUMzwwhKM
	UhhlkKgCUlmuvMTM51nflj38qUSoNY1nBYhbFA0YcPZnn74+Hdx34VCB95/l4dCw
	+KHncexPw6ffWZYjFLhHe53QlMCgRtX3qb/HynzLYyw0hfyMpOB6PqBmIvboh6NA
	1YuCTXwJgRJktVMsnwuOY9HO1qdnRZuBYwYIAj1uECo6uSpY7uoBY0ehfUB+vTZC
	7L6xKEzpX/y4JodyUsqioI03UFyy/bKC5fi1p6/OAyUm8fbHpJKeLj/oHYNQlzre
	d/s9txoOp7XdyxBFI6HY5R8cl77jSfFRX5ywRCg0OYQAOrMEUwyeQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w86q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAndnR031845;
	Thu, 21 Aug 2025 11:33:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y82jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LBXijn35324614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:33:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB1C20040;
	Thu, 21 Aug 2025 11:33:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA9F520043;
	Thu, 21 Aug 2025 11:33:43 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:33:43 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Remove may_goto tests from DENYLIST.s390x
Date: Thu, 21 Aug 2025 13:25:59 +0200
Message-ID: <20250821113339.292434-6-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX2xSufh0ljUeU
 6SUr0Y39lR9gRGJyWhKso7On5nXqozNhxkd1E+eNMWJUMh/Sbn2gtsU64NOnUqwiZMyn/fyB7ko
 KbnqBlAtlYMFsN1ZbynwckJ+AAAz82lL0PJw2Jf3vSR3LTVWnd6eue1gBfl8oMvOy6Ctww0p/1l
 M71kolOIasZ+yt997Sx1qQ3lpG7fYHh1HqfwwIrnCJBf6Mh6/+pQHzXmKQhewgCVeTN2u46Pp1e
 iEnzhse/VmuGkYW7O5YSz6w7WJOV008JIdZ8PUNc+rQKuzCWYY49wHWv4hhGG9FD9UBMrxTFw4M
 3Z8oDFKGV7LZWw1cGlPotPizTyFOO6jYjvKrzijhVgwfxqaWSa8sEanyD+EUiazuOPFGZX9TSV0
 Yobb3l6OAWBN3LKbcf73T54lxeQ+ng==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a7041c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=4thOGrNOn7Xglyz1uEYA:9
X-Proofpoint-ORIG-GUID: EuSdCaCJds0Cf-j8zW_To4dCeVEzC2Q-
X-Proofpoint-GUID: EuSdCaCJds0Cf-j8zW_To4dCeVEzC2Q-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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


