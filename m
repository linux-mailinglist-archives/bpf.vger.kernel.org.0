Return-Path: <bpf+bounces-55057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C5A777A2
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE0D3ABB4A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946D1EE7BC;
	Tue,  1 Apr 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMM1EiQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5791E8329;
	Tue,  1 Apr 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499505; cv=none; b=ODt2oYQB5Uq6dtKmNqaQbCN3W1jwIstXkKdFGeCITAMF7gLMbpoo7vO2NVn10fjq7+aJxsWPQIOY5tm+0ueejBQrtRpmAOkAGRRsVLea82Z8ifpErzjvuUid/Mo45FqMEW0RzjrIUoVwqwWLx9g5kSiyzZv1kpBkZp64tC3Gy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499505; c=relaxed/simple;
	bh=4AH2YO5oVWLBbBoSHvHEUse5FdDeyHUrveWUBkvkj+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7FryWgcNAkbW1Qd+vvj7mP5tzPTtSVbfHJxHOGbPsu6jW/iS+G6nth7hIe+yyG2nQTJYM4lkSzp0+RCSvaF6Snntv+sItIUAzVZX4TbT4s0G4yaipuEhZCJFl1aZQ5Qz29S4068CBl7SZYmiEi/AkNkEnC61wZLCaR8DUTt+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jMM1EiQ0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318BqbG008288;
	Tue, 1 Apr 2025 09:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=DVwGlT5WY/4XAUczNTFvOTUmE9g61
	RnaHQs2hlFNG0M=; b=jMM1EiQ0P/QCNEHyFvgfKc7ZBONI78rmT8ygTprATaP9x
	/IIKsiWBa272bFdgy5iMuJeDAoc5VCEAso3Zxz/bBcv35FoRyy9NIzzyldnAnNXo
	AT2S2GU1+GgaOAvU4lyRpQ4xOsjhVa2jBHXaIxm1jXAcPxdNkHjpU7/DEr3fNI7t
	2zbB8esnV7ioamQUpUZlTT5nH8yiyFxa12MAXfsQGQlQNUXu82+qbmNM+58mn03z
	GjmfKRvc/rRfVshoJ+6hcqJO9ttBnH8ltFZofL0UVHHg+75J/h6IH3Qd3/IYxeXt
	wxTKJNM7WiLBVT0rke71DuESX1gZhTSzVsLgXMgAw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79c6ga7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 09:24:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5318VDKf032750;
	Tue, 1 Apr 2025 09:24:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a93626-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 09:24:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5319OcHb008831;
	Tue, 1 Apr 2025 09:24:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-231.vpn.oracle.com [10.154.53.231])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45p7a93603-1;
	Tue, 01 Apr 2025 09:24:38 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, dwarves@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/2] dwarves: Introduce github actions for CI
Date: Tue,  1 Apr 2025 10:24:33 +0100
Message-ID: <20250401092435.1619617-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504010061
X-Proofpoint-GUID: cPZs0L-y7xV0L0q2jfNKc8TLKM5RIsLX
X-Proofpoint-ORIG-GUID: cPZs0L-y7xV0L0q2jfNKc8TLKM5RIsLX

libbpf and bpf kernel patch infrastructure have made great use
of github actions to provide continuous integration (CI) testing.
Here the libbpf CI is adapted to build pahole and run the associated
selftests.  Examples of what the action workflows look like are
at [1] and [2].

Details about the workflows can be found in patch 1.

Patch 2 fixes an issue exposed by the dwarves-build workflow -
a compilation error when building dwarves with clang.

Changes since v1:

- rework to be locally executable as bash scripts as well as via
  GitHub actions (Ihor, patch 1)
- add note to README about various ways of running tests via
  GitHub actions, local scripts (Arnaldo, patch 1)

[1] https://github.com/alan-maguire/dwarves/actions/runs/14191907449
[2] https://github.com/alan-maguire/dwarves/actions/runs/14191907451

Alan Maguire (2):
  dwarves: Add github actions to build, test
  dwarves: Fix clang warning about unused variable

 .github/scripts/build-debian.sh  | 92 ++++++++++++++++++++++++++++++++
 .github/scripts/build-kernel.sh  | 35 ++++++++++++
 .github/scripts/build-pahole.sh  | 17 ++++++
 .github/scripts/run-selftests.sh | 15 ++++++
 .github/scripts/travis_wait.bash | 61 +++++++++++++++++++++
 .github/workflows/build.yml      | 34 ++++++++++++
 .github/workflows/codeql.yml     | 53 ++++++++++++++++++
 .github/workflows/coverity.yml   | 33 ++++++++++++
 .github/workflows/lint.yml       | 20 +++++++
 .github/workflows/ondemand.yml   | 31 +++++++++++
 .github/workflows/test.yml       | 36 +++++++++++++
 .github/workflows/vmtest.yml     | 62 +++++++++++++++++++++
 README                           | 18 +++++++
 dwarves_fprintf.c                |  2 +-
 14 files changed, 508 insertions(+), 1 deletion(-)
 create mode 100755 .github/scripts/build-debian.sh
 create mode 100755 .github/scripts/build-kernel.sh
 create mode 100755 .github/scripts/build-pahole.sh
 create mode 100755 .github/scripts/run-selftests.sh
 create mode 100755 .github/scripts/travis_wait.bash
 create mode 100644 .github/workflows/build.yml
 create mode 100644 .github/workflows/codeql.yml
 create mode 100644 .github/workflows/coverity.yml
 create mode 100644 .github/workflows/lint.yml
 create mode 100644 .github/workflows/ondemand.yml
 create mode 100644 .github/workflows/test.yml
 create mode 100644 .github/workflows/vmtest.yml

-- 
2.43.5


