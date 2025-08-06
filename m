Return-Path: <bpf+bounces-65137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A1B1C9B4
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D9818A5D10
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C09299A84;
	Wed,  6 Aug 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="smbY9THg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D772741CF;
	Wed,  6 Aug 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497479; cv=none; b=BFJSySD+U9cxOCPc3BFlmCQSEJax1cn7B10GOLQyTCGYXpUYzCEKUO+9AzEFwn8mEDnNUl/GuduqKa+rAwJk9ulOMCafobQWiHGe/a3gTkUkmIiBeB0kvl6PcBXcNjOBy7vZnWa49K5Hd3Q9LzLOofkQ2zfAn3jX+OvjSD/dNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497479; c=relaxed/simple;
	bh=AP2Ia1QvnPnstmkZUDa8DCSy5xHsNlXuY+MMLuSwDXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfty1wL3OZ5rbweOVoyLiqFhso37q3y0G5j36gPTN+a6XcI0oriTz+bf3D/rd4WnvHZMp1ageHPGgttqb2ldjsm4eV/AiBGGHk4ac3D4nJBfosJX0sKZUnpdOW4wxPxO1E39XLXQdRqvizAVx8VlCjXJ0N5mI6EGDHEmx61+ePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=smbY9THg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5767VHLk017890;
	Wed, 6 Aug 2025 16:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sZ20RMRuenOb5MXg07UCIcog3W3SZY9Dl5b0y+03H
	oI=; b=smbY9THgeRQacD2hbPxWhJhqbn9T3kYO1P14ys3/msMOa4dcmF5psaK2i
	sAye+MfoJos6+TH4BkdKwU31/+pk8rJ56gMgjFQGDMDHloieIXKP/+ud0HRwEzbN
	LdcelZSdp5jTBeihXF5Y9i29BjOkPwx7VOAXU/X9aRyUB4keIzj26YG/20e7tbEs
	ntK0J5u+23zp1AY7FKH5pG3UmnreVZsbrinZ7UqzLx/r4P3OhfKQVHzkvXePnfts
	VAPMOGu0Ri1EysEz45pxPUfzFIZGDFX0JBXyDGohE2n0ICWN/7mG834mulbqueky
	bsSM3anxqWrnfBQjPfxOV5FVuyx/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63584p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576GLgh6012078;
	Wed, 6 Aug 2025 16:24:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63584n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576GEpGl026002;
	Wed, 6 Aug 2025 16:24:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn4eq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 16:24:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576GOJJf48890260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 16:24:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 696AD20043;
	Wed,  6 Aug 2025 16:24:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A76920040;
	Wed,  6 Aug 2025 16:24:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.82.230])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 16:24:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 0/2] perf/s390: Regression: Move uid filtering to BPF filters
Date: Wed,  6 Aug 2025 18:22:40 +0200
Message-ID: <20250806162417.19666-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEwNCBTYWx0ZWRfX/k0IbKn9j/wD
 qZBqDX4+/tq9uXgx2FzBCVuz523IUWod85WsGQFrjG1t2/wOml7BDQXd7lhs1/6nZkSX9ZkiW6M
 7QN0tAu7d6qIS6E3hra2N1DPbpZ8ic8pf3IVaITsHyU/3yz+7dKrIG6/mVrEmEHq4gD1p1e9GzR
 V1hjMxswqKZoyXa5U/Xv42z3JnO9i55IgHQ8OojY9gqra7vmmA1dkNpAc92jVPObPeCWjZ8LMSR
 Vttp0LVQSAyEdNmiGUn0uXojUY8VPBH6JgZJrTueSGMxcN8VBUAGZLX61US89pbZsY9SUOJ7nH2
 CvaixLhJjnpBv86eYobhNXAhOTzEbr4jcBnAgxtvERE6T+VvfssePp1GEUFPg6gEQWFjHWN9DM7
 O4Gl6XN5oY0EeT6C1afKTEDo9XenC35M7LmXb6fE/M9tI550asMSDFQeXOiPXTMrGaZSK+uE
X-Proofpoint-GUID: 4G9exy8KKtgu0BY02NzsWlKlcQsidU4l
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=689381b8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8VANnnlgz3Se4JOSuVMA:9
X-Proofpoint-ORIG-GUID: U2AdA2G4uZd4Aqdo5xfDFwkCmY9UGlIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060104

v4: https://lore.kernel.org/bpf/20250806114227.14617-1-iii@linux.ibm.com/
v4 -> v5: Fix a typo in the commit message (Yonghong).

v3: https://lore.kernel.org/bpf/20250805130346.1225535-1-iii@linux.ibm.com/
v3 -> v4: Rename the new field to dont_enable (Alexei, Eduard).
          Switch the Fixes: tag in patch 2 (Alexander, Thomas).
          Fix typos in the cover letter (Thomas).

v2: https://lore.kernel.org/bpf/20250728144340.711196-1-tmricht@linux.ibm.com/
v2 -> v3: Use no_ioctl_enable in perf.

v1: https://lore.kernel.org/bpf/20250725093405.3629253-1-tmricht@linux.ibm.com/
v1 -> v2: Introduce no_ioctl_enable (Jiri).

Hi,

This series fixes a regression caused by moving UID filtering to BPF.
The regression affects all events that support auxiliary data, most
notably, "cycles" events on s390, but also PT events on Intel. The
symptom is missing events when UID filtering is enabled.

Patch 1 introduces a new option for the
bpf_program__attach_perf_event_opts() function.
Patch 2 makes use of it in perf, and also contains a lot of technical
details of why exactly the problem is occurring.

Thanks to Thomas Richter for the investigation and the initial version
of this fix, and to Jiri Olsa for suggestions.

Best regards,
Ilya


Ilya Leoshkevich (2):
  libbpf: Add the ability to suppress perf event enablement
  perf bpf-filter: Enable events manually

 tools/lib/bpf/libbpf.c       | 13 ++++++++-----
 tools/lib/bpf/libbpf.h       |  4 +++-
 tools/perf/util/bpf-filter.c |  5 ++++-
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.50.1


