Return-Path: <bpf+bounces-56626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E18A9B4B7
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195099A7C45
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF742190664;
	Thu, 24 Apr 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZP0KcT2o"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD1197A76
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513747; cv=none; b=KrtAAWO6Jha7Kcsalmv/GsmUiRiiu2CgBh3RWMRpNq3gfLn18UbXKD6NrdRQB8EcM9y2RE8TV67hVz5Yr8a7eataEq2rkB5006ws20MjFqSRLBLeCGz3tKTstsCO/mBDmG2F1Gk6UCXz01frkW4ZV9jI80VFfdpqjkA5fh6/3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513747; c=relaxed/simple;
	bh=x/hucFsWPpybzzXohQOZsRVZKryXdsXRK8qCHV+jHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1S+v2bMKFS5nmPIxxdMQYu9tLMX8vRK5Bb+1fPar8AXdaneXkxaAjIr+KyozGHfXUZatXmSvIXyvRbjidP/O7QwB9VsjIflPe+Vng7l8xE8gutg/i5ol5E7LDU6m7sF+97l9+UC3hh3ua3Fza6jF6pTobOWDZRkzmmphfRsWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZP0KcT2o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OA3nS3029656;
	Thu, 24 Apr 2025 16:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N6vG1HqQgYo2YsWPM
	rB5f98kbPNnKlgCjaL7Sl9+7Zs=; b=ZP0KcT2ojsMlKkP7RYCZND9hHVQyT+lWw
	Sdkj2xfgqjlVkYjy2f32H1HNvKQeXaVCI8iWxC+BuPQaGmDZ+aWm0dfkNVmTNErw
	rrG9wtd9IKqMisLRrp3gTe+7mFMgiKb+9cZA3N+Cudu0hgtx9XwTW9tvbAo10xve
	oWgweXIZzLhPMrdyZ1oDpMx0LM4onZUIMpM92dZevJsPfwRSx5zPnU4oE2l5X8rt
	ARL8majPGELXs/p7P+83Idd0edM0VT1rqlVSZcBJ6vWPnV0uxtxvxqRxwwEKty6i
	TdiqATSyS8XzlOl5/PVH+hjna1o1SPMngQbT6Pgk+Dg+wsjD54P6A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4678aacwj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFU5Gl004062;
	Thu, 24 Apr 2025 16:55:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg015j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:55:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OGtRBb46924060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:55:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C926020040;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99A8C2004B;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.201.197])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 16:55:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] selftests/bpf: Fix arena_spin_lock.c build dependency
Date: Thu, 24 Apr 2025 18:41:25 +0200
Message-ID: <20250424165525.154403-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424165525.154403-1-iii@linux.ibm.com>
References: <20250424165525.154403-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNCBTYWx0ZWRfXzUL9b98fyMsm paMuk1NqzsqtiEBT/aYWSFhQPYeVkEr2BwtUGrMV7jOy/aCiwYRogZ5waOwJAUZc61ibvLPh5/k 9rvpLI6Ce5PV4lrFKnmS+3MaL1vRTCvoUY6YzbuX0k5tMV0upOI2fIGqWhjOuK9yREEK68U3WC1
 ll6NQtBtFzcPwByYgLpI3J86So6iRqOSD7DwixpBE7VEgV4Qpp+OMRcNdmd1fgWA/TRRcQE7TpM 6v9oGXgj6l+UAnBzrn98HkJw3n3lmh2PkPGysTWfdshAV8PybFao3NPi33vwlQ4JLy+t3NU/WlX Ilb6YMpvJAdvQaBMaRsl8zLoC48gwH0dc6TDRu7d0RlXBadUcLFV8Rxi/FudmbED3SUu+d40/vX
 e0TixSOY9gWuUxDqdi4TRJdp24NAP5eSZpQRbId6v6mNGsgfVtftH3KmICEmn7hPnTO/ekRB
X-Proofpoint-ORIG-GUID: kLwzpf8sBRyYq2l97Y-6E04A-QscECJ5
X-Proofpoint-GUID: kLwzpf8sBRyYq2l97Y-6E04A-QscECJ5
X-Authority-Analysis: v=2.4 cv=KejSsRYD c=1 sm=1 tr=0 ts=680a6d04 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=jbgBoJdyyR5h1U3H7FQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=849 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240114

Changing bpf_arena_spin_lock.h does not lead to recompiling
arena_spin_lock.c. By convention, all BPF progs depend on all
header files in progs/, so move this header file there. There
are no other users besides arena_spin_lock.c.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/{ => progs}/bpf_arena_spin_lock.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/bpf_arena_spin_lock.h (100%)

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
similarity index 100%
rename from tools/testing/selftests/bpf/bpf_arena_spin_lock.h
rename to tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
-- 
2.49.0


