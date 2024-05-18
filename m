Return-Path: <bpf+bounces-29984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B38C8EE6
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 02:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F08282210
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948023BF;
	Sat, 18 May 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KjvoK6I6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468034A21
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992224; cv=none; b=spChmjoajbfd743cAuITcHoGmgPVIvsN1LCpvLjvOgfIbo4tmCHJ0LBotgEGLjId0oWxViwE5sUIDL8PbdTYq5IIo5LoMn6YrZd0CkNtavKrA3fZUueFWAZiwRtxGBOVnsB4HVYtimTAYJjrR/qCStH0xpfrwb7t4WPKVtQGxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992224; c=relaxed/simple;
	bh=thGlg4mCHRM1coLLitlAFgdF+n5B19E7JAEs/sqdO40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKcI2YxoPsLOjtyPcCM8C2bk5yKWHB45miAcEfGSuTWQ6OSLPxK4VBJae+uhuGkSfqJuc2wh42QYvfESiXRInNcnIQWJlkLdL4aqJoqY8yoEBXYn3ONX9vxBCS+af8zJw4fVNikiZGwjxJ0ePBC3kAO7xOsBSbK3gsYru1rlxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KjvoK6I6; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HLeJQM000814
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=dxwCNCyftDJ78/x7TJrV61BkmO7whgWmoF29Mm/4CzE=;
 b=KjvoK6I6hb3vla9Og9XhZKchunH2GWtCMwvE1nsQBYAsSIgm1SCyPQI8EvJAfFzUw7PB
 1yItDYQVXUck6ZVKSID3itM+GknVmVG6qVxdWfhzZhORs35lyHZJGwi9bEvYRW4xxSal
 A1RNkgsRxYa3TzwHQefPBF13FZP9enVtEy58I+0vSHxlVkvzdFJEyXoKzwAeNRdHAF5D
 qCkctztoCg7/0rfckdpM8WTcUtMafcDf5Y3hgjHwYx+aOcRYAeVT/pwWP/JAtfhueS2y
 N762ZfKJoPRF9u/z+z5n7EJ1oCl3QGZbxqq4tHpZXzU+i1zV3Pp7Rpd5QgCWnFAaUkSp HA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y61xswd5k-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 17:30:22 -0700
Received: from twshared11717.35.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 18 May 2024 00:30:16 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id E47EE1196E80; Fri, 17 May 2024 17:30:02 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH bpf-next 0/3] Fix and improvement for bpf_sysctl_set_new_value
Date: Fri, 17 May 2024 17:29:39 -0700
Message-ID: <20240518002942.3692677-1-ramasha@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v77xBs16l9qxVlnRojh1mknJW5zY-16z
X-Proofpoint-GUID: v77xBs16l9qxVlnRojh1mknJW5zY-16z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_11,2024-05-17_03,2023-05-22_02

Fix and improvement for bpf_sysctl_set_new_value

This patch set is doing several changes around bpf_sysctl_set_new_value
(1 fix, 1 improvement, 1 test):
1. Fix is for return value check, when sysctl value is updated from BPF
   handler with call to bpf_sysctl_set_new_value.
2. Improvement for bpf_sysctl_set_new_value to match behavior with
   sysctl write call. Result value shouldn't include "\0", otherwise
   proc_sys_call_handler rejects value.
3. New cgrp_sysctl test suite is added. It has single test to check
   behavior of bpf_sysctl_set_new_value and is called from BPF
   test_progs test suite.

Raman Shukhau (3):
  net: Fix for bpf_sysctl_set_new_value
  net: Improvement for bpf_sysctl_set_new_value
  net: new cgrp_sysctl test suite

 kernel/bpf/cgroup.c                           |   7 +-
 .../selftests/bpf/prog_tests/cgrp_sysctl.c    | 106 ++++++++++++++++++
 .../testing/selftests/bpf/progs/cgrp_sysctl.c |  51 +++++++++
 3 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_sysctl.c

--=20
2.43.0


