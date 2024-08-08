Return-Path: <bpf+bounces-36685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309294C08B
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4E1C258CA
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283A18E77D;
	Thu,  8 Aug 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i2c26O2c"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC6F18F2EA
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129593; cv=none; b=Bc3uLGrGqfD4EO4ybdU0rzv+SIfmyfW/bWX+2RLc1xJ1wK7xTIEXFDAagjJKQAEph8qT83n/RdoQ61PnQ0RWGzlUcVhHGlkziD5bQFLp7dJtpX+2khDiehRjIido3BktNUiepckxIXY0GN+9+w3MC4b03iWTp6UCRmQvf6KudH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129593; c=relaxed/simple;
	bh=mAiBM4hbRzB3nXKNqj3Y/jC0lo7k4AVjsfBhdFsgC2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzYG6sv28uY/NmpYI/2x2BdPUqkNwLkk1N0dVuJ56JD4Ku5/Hry7PY0xxN8HJRR5HKG5bVLGq/XQNzRYWAgxinhtqseBecjGULkCEvWQxVl/najVQyE95gNdavjynrcryU+jYDIf+6dAH+H2EpSzG+LVkq4UKt4G42c1lvfSqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i2c26O2c; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMUxM020688;
	Thu, 8 Aug 2024 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=Q7WGt4FFp7sFqW
	wwh+C3o45Qq8II+u+BRtBUbXL3zbE=; b=i2c26O2cU5MXqK9msW/Zg3uLB9CvJB
	YCGyM31g1gz+Nq+8SmcMI0GEzyklWBuiVmsOnTvU1w32xTAriYSGNzqriDpwBHzc
	prQHJDZ1LNVJ6UlWxuc4ZFrYa62x5jhIUCiIdCrkYiYOs+g9xNHxlc57Jt81SCqU
	UsSa1HE7RxkC1KkDlIZHW014Y0nGoSpakUSnf09fcoFczhwDT+DTIfgfB6/VUOwD
	oFnJ7s1sKKqTAoxb2RmJ1BMqyGx52Gtlu4eaAO3jet1dKHSYsXQHgm7/WzquIWil
	Ri8ceMGxotXX6rrSz/95wp1nFFtMbSn9DRcUmw2bjZCZbcZlU9DwbSVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2t1yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:06:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478ESLOc021747;
	Thu, 8 Aug 2024 15:06:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hrjj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:06:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 478F61Ma017870;
	Thu, 8 Aug 2024 15:06:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-177-74.vpn.oracle.com [10.175.177.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40sb0hrjg8-1;
	Thu, 08 Aug 2024 15:06:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/2] add TCP_BPF_SOCK_OPS_CB_FLAGS to bpf_*sockopt()
Date: Thu,  8 Aug 2024 16:05:56 +0100
Message-ID: <20240808150558.1035626-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=745
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080107
X-Proofpoint-GUID: jVcHHoXhiCOkwWNl3imY_7_byKKl9klQ
X-Proofpoint-ORIG-GUID: jVcHHoXhiCOkwWNl3imY_7_byKKl9klQ

As previously discussed here [1], long-lived sockets can miss
a chance to set additional callbacks if a sock ops program
was not attached early in their lifetime.  Adding support
to bpf_setsockopt() to set callback flags (and bpf_getsockopt()
to retrieve them) provides other opportunities to enable callbacks,
either directly via a cgroup/setsockopt intercepted setsockopt()
or via a socket iterator.

Patch 1 adds bpf_[get|set]sockopt() support; patch 2 adds testing
for it via a sockops programs, along with verification via a
cgroup/getsockopt program.

Changes since v1 [2]:

- Removed unneeded READ_ONCE() (Martin, patch 1)
- Reworked sockopt test to leave existing tests undisturbed while adding
  test_nonstandard_opt() test to cover the TCP_BPF_SOCK_OPS_CB_FLAGS
  case; test verifies that value set via bpf_setsockopt() is what we
  expect via a call to getsockopt() which is caught by a
  cgroup/getsockopt program to provide the flags value (Martin, patch 2)
- Removed unneeded iterator test (Martin)

[1] https://lore.kernel.org/bpf/f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com/
[2] https://lore.kernel.org/bpf/20240802152929.2695863-1-alan.maguire@oracle.com/

Alan Maguire (2):
  bpf/bpf_get,set_sockopt: add option to set TCP-BPF sock ops flags
  selftests/bpf: add sockopt tests for TCP_BPF_SOCK_OPS_CB_FLAGS

 include/uapi/linux/bpf.h                      |  3 +-
 net/core/filter.c                             | 15 ++++++
 tools/include/uapi/linux/bpf.h                |  3 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 47 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 24 ++++++++--
 5 files changed, 87 insertions(+), 5 deletions(-)

-- 
2.31.1


