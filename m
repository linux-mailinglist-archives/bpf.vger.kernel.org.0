Return-Path: <bpf+bounces-65056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA685B1B3FD
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E72116C9E7
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E751272E51;
	Tue,  5 Aug 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f0jQvNhZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC32737E7;
	Tue,  5 Aug 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399049; cv=none; b=NZ3LRHbKJzki5JPAO7HtaGUgPxijOQv0f8C88Ih+rNb+7fHpFZt6zM48RCnk5ahzmVoM+gJTsDpn8WYGfYLoQEJy1BXAGKUFkJiHi1PU6SKSwts/pVcnYY72cBaK942xHbVutH1Uh5mHLzDy/lamQRT6PKmoE/eRAnyWKdi5gB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399049; c=relaxed/simple;
	bh=o1XepMpyogQfSoTQm9QKCMjXr80RrejZrBmXnY8NDX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbdyM+CCZn2aU/2jLbkHu5oBj20ibT64rR3fRfSBQLSmdrTv36P5WW/ltWXYoASs3BDclJfJfVTLKSFVvy5aDws5E2V3OC3jsZ2jQ6rDbpzL1Sgjl29o0Mfsd+PIg0W9XvhYUn3hShprPxSULTGcOrIDKLtLMeUWZp75AISe9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f0jQvNhZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CcOeH030686;
	Tue, 5 Aug 2025 13:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mlJ8gkaoGvE1ae2pjhWy96oh2Hf4Vt92yf/l2NZZr
	8Q=; b=f0jQvNhZZ9VdbFdPWtKmZEg3L067ZYJpc0WMN9nQyZgUJHWy7dUZTZ4wl
	wEPwt6I8J+TwI+NmYpFROBuMFdKTUfsL/+f7NDHy6W/6turyr0UCkaTPvAhjPMkA
	PtnBx4tjyWSFtyyv/BklEci5EBn/fFlTLl+oPxsM43sXerUVOn6r2aH2W4zWyDj8
	B0wrqVViOr951pegDtTgA8kc8h+ft0Jjk90bgFrzwxYfCmiF8LvXdg3utnZvzEKG
	HAbZCn7A40LCvBriBx7JeALjH8hNL5+oihdPXa/A6v+Jusn+11yn62draHwGFkfe
	CwzfBsguBeIdcMpGQdxOxj2pmnJrw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48b6keb0rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575Cv8jV024521;
	Tue, 5 Aug 2025 13:03:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48b6keb0ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5759ekir001936;
	Tue, 5 Aug 2025 13:03:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7kta5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 13:03:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575D3nrY27263498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 13:03:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09BB820043;
	Tue,  5 Aug 2025 13:03:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E10720040;
	Tue,  5 Aug 2025 13:03:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.141.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 13:03:47 +0000 (GMT)
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
Subject: [PATCH v3 0/2] perf/s390: Regression: Move uid filtering to BPF filters
Date: Tue,  5 Aug 2025 14:54:03 +0200
Message-ID: <20250805130346.1225535-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2mhPOHiNl0xHmJCmIob5vO2gaWJfSdIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5NCBTYWx0ZWRfX8C6eF2tklVQF
 9gHAjV6Si+3gX+LU0ziFB5jlUBCDnnW5sckOTEeTBPbcMf78GmGQp5EunxNKANBmYTbrJ7d+AzT
 nEVVuj3IEcNbg1U1lBUJLcm2hDyOqX4dEXuz/mB1fL7CfRNIChPZgIPLIIhIYgeOIXh49BL1diO
 ck+da6iucFJ4Vjjxp24g9H3yM+4HKoN3ya/psH9yTdJ6MyiWcU3MHGK4O8eNuccBiktnXRFORI3
 J3uhWJ7dqDBj/zABAUdp24VX9d6evZxLQcD476yPLzHcmBFoIUNoGLmZR6sDeqCz9CuJhS/KlXh
 uVqXYPrHa8Qm7rnPRmnVUlgGVBgv+1uGStTDmIEGlXbNHjoqnAe6dghDO4cOXXXQzbdWeZDzYJF
 Yh23HS+r4ceFZQ0vPMjpVyPcF3QF8Fsez0vayl34PDIiDvIXn2pAjTHWO5rxo7bMVQHxWBx0
X-Authority-Analysis: v=2.4 cv=eLATjGp1 c=1 sm=1 tr=0 ts=6892013a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8VANnnlgz3Se4JOSuVMA:9
X-Proofpoint-GUID: 8jYFBiaxUjIsYo2y0NaV6kDomtwC0ZIL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050094

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
Ppatch 2 makes use of it in perf, and also contains a lot of technical
details of why exactly the prolblem is occurring.

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


