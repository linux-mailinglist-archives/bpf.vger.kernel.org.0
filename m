Return-Path: <bpf+bounces-30023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D58C9A30
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 11:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300EC1F21B05
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA11CFBD;
	Mon, 20 May 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TOfxlPKx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF071C6B7
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196486; cv=none; b=r26mOFL6OikDu/unTv6yp4ln72uKFjO/MCMPvAKlaPbZcs96zDmEXp0PvQ4nl9zOymJgGAcz4iJzi9yULNp3EMiQ99LdZMu8wAISQ5S1FXFtsESyip2Y+/812Y1RYmyJU1TTRA+RDG2+lps9qMbdU/YFakEik8S62CPDI3EumpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196486; c=relaxed/simple;
	bh=cs1RbC6IvMaqIy/X+tiw47UbU1V5ro7RrA6h+2yzU7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxN9ZV+9WDbqdilkuwC4puaH3LqXovChHafSOhMewzJYs/qDkSC/jx9Ka0traCaG45oHwdPb52R1JfuGWJ7WUn5MmaUh+WjzMWoBD1v4VWpRWnBPHUSM7fIWs9X19CczuzWyQwFfK4TBB0Ro+TGLLLGU5j803EpPihK9Z+rmIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TOfxlPKx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K4KNnF003187
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=WotpMEArL0j0HF7NgXM8Ih6AN+DeYoTyCV24dTOV4SA=;
 b=TOfxlPKxSadZqP/NOdjInmWG/zJsXCH8W0nSnxp1HN61N7dDfRp78mRChUFdp73yYTW3
 X7WmUY8xp105I2GwaYjZj5rZuur1ykoAXSoab1kd4tZKv2KrYWlHSSQmm4DWB2HAiEo1
 mMN8cHVy3udLSv1qncGb4OlvMC9lqTQoadFPm0t/GcEyVbLePAwB7rHn/oka8R/ch/Ga
 ssg7+JBrQDd9P4Cum4iVl0qaGqtWUdTOJtLxrxSs18XG4Jcb8Ib39EMMwqLjUrYeo3kv
 RmAO0+pAuwHlyVMjG9nX+pyNqZ/6Ur+/PLp85S9tG/gzT0/EDS8c5vyevPzq6BU3q2uB 6Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y7yd28vj8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 02:14:44 -0700
Received: from twshared0252.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 May 2024 09:14:43 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id 223711349D7F; Mon, 20 May 2024 02:14:35 -0700 (PDT)
From: Raman Shukhau <ramasha@meta.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Raman Shukhau <ramasha@meta.com>
Subject: [PATCH v2 bpf-next 0/3] Fix and improvement for bpf_sysctl_set_new_value
Date: Mon, 20 May 2024 02:14:21 -0700
Message-ID: <20240520091424.2427762-1-ramasha@meta.com>
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
X-Proofpoint-ORIG-GUID: 7ceYhXo7VPJ1m0AH-zqi69W0sFSH1bIv
X-Proofpoint-GUID: 7ceYhXo7VPJ1m0AH-zqi69W0sFSH1bIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02

Changes v1 =3D> v2:
1. corrected copyright comments
2. unsigned int for sysctl name to prevent build test error:
   "R2 min value is negative, either use unsigned or 'var &=3D const'"

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
 .../selftests/bpf/prog_tests/cgrp_sysctl.c    | 103 ++++++++++++++++++
 .../testing/selftests/bpf/progs/cgrp_sysctl.c |  51 +++++++++
 3 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgrp_sysctl.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgrp_sysctl.c

--=20
2.43.0


