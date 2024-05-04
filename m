Return-Path: <bpf+bounces-28570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C771F8BBA82
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 12:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4ED282DD8
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25517C7C;
	Sat,  4 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ayxfn7SK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0FEEB2
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714818287; cv=none; b=C9Zau2EKgXF7H8WGHJkCaUxVv13xzm54nUt3finkjs2xkTJEisClmFtW2m3nwtHRtSxq8D2C0nB0IHGYYD9OCuW2WwFzWzthT5GzW6EGl2zXzICVHYPgL7NGwqOUElqrCU7BD6jOYvRv3oBHXdNyL4168WZubH9frE/T4f3ZB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714818287; c=relaxed/simple;
	bh=a+q0/XxFIDP5uiGee+99fx1hJqAO4zOvwfg1r3Cneuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VqQbaWM2dtpT0cOkDIwIejhDTlizMdcfMOHgaZqkBQ1+/Il0T+k4CBSlXp4Ir+etDrxHfRMIBXkAK88gqzjIsrAyl+K73A4HXpYEc/17cC5c3hKGbbFCsnjIaZigEHYl5JQbElBJVelV3yF8gPjHO05n1Ez2wmrm7VgVSL2bxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=ayxfn7SK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4449rjHH019206
	for <bpf@vger.kernel.org>; Sat, 4 May 2024 03:24:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=CON5dvskw7fqiATF/2Uae62Cppyr4as5Y5KW4S5Dy9U=;
 b=ayxfn7SKdeQXpAWKt1dYha4revHgcm9DuAzTan32wkY/6GCfIyrZtY8fG23cf24pZCKs
 ZAvfKwr3NdintKNv1YBWuyhG8UiJ/E8/f62zJ4pijWS2lvSTIKf0OncAXbKt/wXIb+mT
 pScq8mekHpmgunvH4Ks4dgigUs5MhwAd4fQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xwjs681xn-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 04 May 2024 03:24:44 -0700
Received: from twshared18924.35.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 4 May 2024 10:24:38 +0000
Received: by devbig031.nha1.facebook.com (Postfix, from userid 398628)
	id E0BA0302E1D; Sat,  4 May 2024 03:24:26 -0700 (PDT)
From: Raman Shukhau <ramasha@fb.com>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC: Raman Shukhau <ramasha@fb.com>
Subject: [PATCH bpf-next 0/1] Fix for bpf_sysctl_set_new_value
Date: Sat, 4 May 2024 03:23:11 -0700
Message-ID: <20240504102312.3137741-1-ramasha@fb.com>
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
X-Proofpoint-GUID: Hij-DdxpYig6xR1mFvdCmPs93Qq8vv4j
X-Proofpoint-ORIG-GUID: Hij-DdxpYig6xR1mFvdCmPs93Qq8vv4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_07,2024-05-03_02,2023-05-22_02

Noticed that call to bpf_sysctl_set_new_value doesn't change final value
of the parameter, when called from cgroup/syscall bpf handler. No error=20
thrown in this case, new value is simply ignored and original value, sent
to sysctl, is set. Example (see test added to this change for BPF handler
logic):

sysctl -w net.ipv4.ip_local_reserved_ports =3D 11111
... cgroup/syscal handler call bpf_sysctl_set_new_value	and set 22222
sysctl net.ipv4.ip_local_reserved_ports
... returns 11111

On investigation I found 2 things that needs to be changed:
* return value check
* new_len provided by bpf back to sysctl. proc_sys_call_handler	expects
  this value NOT to include \0 symbol, e.g. if user do

	```
  open("/proc/sys/net/ipv4/ip_local_reserved_ports", ...)
  write(fd, "11111", sizeof("22222"))
  ```

  or `echo -n "11111" > /proc/sys/net/ipv4/ip_local_reserved_ports`

  or `sysctl -w	net.ipv4.ip_local_reserved_ports=3D11111

  proc_sys_call_handler receives count equal to `5`. To make it consisten=
t
  with bpf_sysctl_set_new_value, this change also adjust `new_len` with
  `-1`, if `\0` passed as last character. Alternatively, using
  `sizeof("11111") - 1` in BPF handler should work, but it might not be
  obvious and spark confusion. Note: if incorrect count is used, sysctl
  returns EINVAL to the user.

Raman Shukhau (1):
  Fix for bpf_sysctl_set_new_value

 kernel/bpf/cgroup.c                           |  7 ++-
 .../bpf/progs/test_sysctl_overwrite.c         | 47 +++++++++++++++++++
 tools/testing/selftests/bpf/test_sysctl.c     | 35 +++++++++++++-
 3 files changed, 85 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sysctl_overwri=
te.c

--=20
2.43.0


