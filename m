Return-Path: <bpf+bounces-53492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE912A55237
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5381645CE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D62580E4;
	Thu,  6 Mar 2025 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D5PBRmlK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBF2144BF;
	Thu,  6 Mar 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280709; cv=none; b=HMwIYgVQ17M2/wd6gIPzkCDUqDjFtaNYZszi8bg+CDEW5KY9ZjbVkyUJpcl1gTlckgko4CWHP/YAXj5jc/JbNjbX05MWyUc5TsqNtyRGIZwS/J4+twVQBTHOEe/GhROlKTvI7R8fpkY82QL6DuzDrdRmX7JC9bNF12uw6948NIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280709; c=relaxed/simple;
	bh=10s7p+7Lkow+FLm6b7ToTeZiyuu/MYh+NHjU3TerQzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/2gP9aQfpYZG72KZuVsIpv2H3T1i0Pu/kBocrM0a8FuPjEl4yPLSf6B9goW3NP6UI+F7CwAn3fl84qhqEc6xMiADKodXwcRMo2ox8Oyg6VxDzQ10UyhupfPnfg/p7C1PRPAjGuof1LXM6NNvHjdgIx23WZDNQz2NIjhu3Mxe3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D5PBRmlK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi6UJ005540;
	Thu, 6 Mar 2025 17:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=nlFYnQDvtkjfhXkyfuje8yji8AlSF
	CHiZ1FVo+9Co8s=; b=D5PBRmlKGYQh5v4RyZYjbrLXV4D7YUJPTMHfMQmVwYiFX
	mwoDONvS9MBMB0k4DHQlFXvBvGrWPYY3He6bfJJ455Usa7P42hFPLKu/Ev1RD0Ce
	7kWz4Vs4HLKUyZRn726thJPiaaQmeTghdyIjrZ7oRXDOEZNpjR7MXwX6j1qovD0d
	zCpaRZ5G9iP+1Os+GpER1O0UrKTXhPq8Az+YlHa+KeDBVBozPy2eb+SsPITzMEVY
	jaTDZjA9YslWErlohevB47d4ZWGKp8CUiKAVwmkg1or+II+WVUyEKsRGNlk+nyFl
	xn2NoD7svZlCIHRiBaDVjzQutSaZrYq6HqmfBYhMA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub7an2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:05:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526FhktB010885;
	Thu, 6 Mar 2025 17:04:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe0etg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:04:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 526H1Exe022155;
	Thu, 6 Mar 2025 17:04:58 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-26.vpn.oracle.com [10.154.58.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rpe0eqr-1;
	Thu, 06 Mar 2025 17:04:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, song@kernel.org,
        eddyz87@gmail.com, olsajiri@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] dwarves: Introduce github actions for CI
Date: Thu,  6 Mar 2025 17:04:53 +0000
Message-ID: <20250306170455.2957229-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060130
X-Proofpoint-GUID: Rv4y9qDnLu6CUyDDdI9zxj1KLW7SD0dR
X-Proofpoint-ORIG-GUID: Rv4y9qDnLu6CUyDDdI9zxj1KLW7SD0dR

libbpf and bpf kernel patch infrastructure have made great use
of github actions to provide continuous integration (CI) testing.
Here the libbpf CI is adapted to build pahole and run the associated
selftests.  Examples of what the action workflows look like are
at [1] and [2].

Details about the workflows can be found in patch 1.

Patch 2 fixes an issue exposed by the dwarves-build workflow -
a compilation error when building dwarves with clang.


[1] https://github.com/alan-maguire/dwarves/actions/runs/13588880188
[2] https://github.com/alan-maguire/dwarves/actions/runs/13588880200

Alan Maguire (2):
  dwarves: Add github actions to build, test
  dwarves: Fix clang warning about unused variable

 .github/actions/debian/action.yml | 16 ++++++
 .github/actions/setup/action.yml  | 23 ++++++++
 .github/workflows/build.yml       | 37 ++++++++++++
 .github/workflows/codeql.yml      | 53 +++++++++++++++++
 .github/workflows/coverity.yml    | 33 +++++++++++
 .github/workflows/lint.yml        | 20 +++++++
 .github/workflows/ondemand.yml    | 31 ++++++++++
 .github/workflows/test.yml        | 36 ++++++++++++
 .github/workflows/vmtest.yml      | 94 +++++++++++++++++++++++++++++++
 ci/managers/debian.sh             | 88 +++++++++++++++++++++++++++++
 ci/managers/travis_wait.bash      | 61 ++++++++++++++++++++
 dwarves_fprintf.c                 |  2 +-
 12 files changed, 493 insertions(+), 1 deletion(-)
 create mode 100644 .github/actions/debian/action.yml
 create mode 100644 .github/actions/setup/action.yml
 create mode 100644 .github/workflows/build.yml
 create mode 100644 .github/workflows/codeql.yml
 create mode 100644 .github/workflows/coverity.yml
 create mode 100644 .github/workflows/lint.yml
 create mode 100644 .github/workflows/ondemand.yml
 create mode 100644 .github/workflows/test.yml
 create mode 100644 .github/workflows/vmtest.yml
 create mode 100755 ci/managers/debian.sh
 create mode 100644 ci/managers/travis_wait.bash

-- 
2.43.5


