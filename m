Return-Path: <bpf+bounces-65119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D21B1C51E
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C1561F20
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 11:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589828C017;
	Wed,  6 Aug 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KUJtUYt/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586628AAE9;
	Wed,  6 Aug 2025 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480570; cv=none; b=MFkfa3awBoLcAXxfPVkL3HtYqI0cWpiLBeYilWOqDRvW/c1+HwHJGC+l2dQLVQ5wUvS4cLOlkXEMesHWdTPxnYsMCmTPj5BpUVHRL0eYAfZ3fhckbHggdC4kXAVZ3lIaVCRhSue0Bi2roYRfn3JHgM6QkH+MNgqyqzHmVPpEWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480570; c=relaxed/simple;
	bh=DmlWK5XP3VTxgWXBVY5e2iY/5JchBSJpmtZ02GwEt8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWKQJoYZgf0VSIV9crFh9RvomP7QZx+G69ZByT8PwePUFEKm0Z6QRePBLVWVQePcwnkxc+uL5oZ+7Uc5fieu82a76E/pdL6NRBmlL5DIt05gS+W9TWf+CWtqAQYDP5w/girJFgyof5V3RV69gIUrZkmUAySM9tJAkBP9LCHczno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KUJtUYt/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5767nXHO028370;
	Wed, 6 Aug 2025 11:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iJDTnPTBjgGUX1kzI3i6BqQ9bjChyy+Bctj8juao3
	d8=; b=KUJtUYt/7dffa0PtjdXiPePkYfoWvmQah3JzDeaU9t3JJdEq5fuDO5Y/h
	d7Jb90BQYf2NzmweH3yK/s1pG6otCZQdsfOdej2RxPxaB2ZIkI/pjh4zdFdP4lk5
	pMwK9cebDCKMow6frqgfxPkoSPTF7OybULtvm9ASSSLiPn6nMS2VTtLMp5b3kq9b
	Jm2jK0sQCcYQuCi9Tv00bM5CJNg1GS47zdFYZTTM9dhmnNM8r1DG/2rCQ/mUacaH
	9umcRURbALRBjnQN8KYwfAaTuVwWhx7959+eIsE0sGYsoEXMSGDeQqYiq4A//HbL
	N0N5Gqqo/d0NDE9+aJQ4Ac2is3hcw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60uwpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576BgZhZ014007;
	Wed, 6 Aug 2025 11:42:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60uwpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5767sg3C007970;
	Wed, 6 Aug 2025 11:42:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwmucth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 11:42:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576BgVXt50397508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 11:42:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F3E20043;
	Wed,  6 Aug 2025 11:42:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D4D20040;
	Wed,  6 Aug 2025 11:42:30 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.29.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 11:42:30 +0000 (GMT)
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
Subject: [PATCH v4 0/2] perf/s390: Regression: Move uid filtering to BPF filters
Date: Wed,  6 Aug 2025 13:40:33 +0200
Message-ID: <20250806114227.14617-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p9Pd6M3I1pDpc5uSAjDg9e_j1r7F3RlZ
X-Proofpoint-ORIG-GUID: lqdZYBVbBVV5kYSC6eSA7D3qN5LX-CnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA3MSBTYWx0ZWRfX9mSmrUNfSAMr
 F+1yfFkrXJUJud2nOwOSK/zOtm+BowMYweM6tL53gpzUHd9QSYKmop61NhTN0mJuFB7faj2FeZ0
 olSZKkI+hqLY2VpKT5k184QNbnjPAL9PmD8lcxp/MaON/QC2vW8F8nCZ+CTQoNOtUdyDgAIfwO8
 EPTyYUAV4eKAYXCX+olk+nD572rebm/zqtGve1aae6iEmutEc5SIm3bS/Tz1EYV1RwsMJfSCSzT
 vbLe+ilSUolIeYrEAM401x9DRuSwwEOaRYd9EbqoRklKhcm8/CwobJR8vAAKjOeZx42nain+NLq
 JFz3F1Pl6zsDKMbCnkYVQ6aIagzHZppH8vAvAJnsLvceDc0j49h0G/lqHqH0X1XxaCCFlfaKyds
 ni0IrV3aA6fnpoQvj8cNJ+PDqQNRwF21dcVAj4uv8UssbCwsolp92B0XAQOeVSyqh+ig1TOm
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=68933fac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8VANnnlgz3Se4JOSuVMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060071

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


