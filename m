Return-Path: <bpf+bounces-44847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B49C8EFB
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDED1F25C33
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED276133987;
	Thu, 14 Nov 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LAngA3nz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6713CFA8;
	Thu, 14 Nov 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599938; cv=none; b=GODH9QKbpDreXmfrmNn52pXSKzxl0LazIPrhlgGRcNUsYwxBeLaP4c0riZzxy2iyZHdKxW6dlKQGUpJAJAVy/eERzvUS4c0ZWvN/X1oEaDEUQ1vj8XzCYzbyFbrdGEbmOhQCne2d7Z3zt/Md7EyuxDw6qubZIKADHhpk2imch3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599938; c=relaxed/simple;
	bh=akknOPtDEzMhCx0k8DD17IpqdLwjF7dEdYPts6lasj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKbDeYyeTurXEq9Yv2Y6kAYl/MfPWYFoQtl/31VAaEAYWjXbRor2AAzF2GeMOMKcHoCuto4ejv62ohRiamLQtsfVSYhy51P2uGUUsFyuRcflZ+hZzBaCN2qYiQFXYUo2sBNICGqSDbBfUsTljSRKScBm32X6Jfw9fQydZgGqdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LAngA3nz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED5lBQ002835;
	Thu, 14 Nov 2024 15:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=HoBr6ldOLBmkanIY8jw/Q51pEcvLN
	IwWCdWLLCet/bs=; b=LAngA3nzaucgVSq2gCbhjEly+s9Gz+Vpd6eX+yvk6j9E3
	pxMJMYjhMS+gW1AUw+irDK3oaIVwERyWIwG7hSRKK6pyXz2UcgmlXGGlXHnYt3HH
	Z/UxnGIuOaZbLL3Msvwvj7q+eZzzb7amap3vCKl+Gn+kMppVBcIoXtlCmTBN5jrX
	YFKKYh8sBus9pTwOxBsabVQolSmAZ0mlO6AshTGNhTUmY1HhF1JavQGaelY9I/fB
	vqppVJ7BMlzCdI2m4BkXuoufRUMqc18xPXgwaT58VHqAlU7IX8pqc0i2C1ETfcSp
	RdDDgZ/S/2LUxb+MXQnp1ELXBb3641qiDq3mEag9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5heh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEF9iEP000402;
	Thu, 14 Nov 2024 15:58:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpad7cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:58:31 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFwUgg002439;
	Thu, 14 Nov 2024 15:58:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-214-128.vpn.oracle.com [10.175.214.128])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42tbpad778-1;
	Thu, 14 Nov 2024 15:58:30 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/2] Check DW_OP_[GNU_]entry_value for possible parameter matching
Date: Thu, 14 Nov 2024 15:58:20 +0000
Message-ID: <20241114155822.898466-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140125
X-Proofpoint-ORIG-GUID: U1MOKkqcPPs-69-lgkzhizGGWo0twAIq
X-Proofpoint-GUID: U1MOKkqcPPs-69-lgkzhizGGWo0twAIq

Currently, pahole relies on DWARF to find whether a particular func
has its parameter mismatched with standard or optimized away.
In both these cases, the func will not be put in BTF and this
will prevent fentry/fexit tracing for these functions.

The current parameter checking focuses on the first location/expression
to match intended parameter register. But in some cases, the first
location/expression does not have expected matching information,
but further location like DW_OP_[GNU_]entry_value can provide
information which matches the expected parameter register.

Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
as it is unsafe in a multithreaded environment.

Run ~4000 times without observing a segmentation fault (as compared
to without patch 2, where a segmentation fault is observed approximately
every 200 invokations).

Changes since v1:

- used Eduard's approach of using a __dwarf_getlocations()
  internal wrapper (Eduard, patch 1).
- renamed function to parameter__reg(); did not rename
  __dwarf_getlocations() since its functionality is based around
  retrieving DWARF location info rather than parameter register
  indices (Yonghong, patch 2)
- added locking around dwarf_getlocation*() usage in dwarf_loader
  to avoid segmentation faults reported by Eduard (Jiri, Arnaldo,
  patch 2)

Alan Maguire (1):
  dwarf_loader: use libdw__lock for dwarf_getlocation(s)

Eduard Zingerman (1):
  dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
    matching

 dwarf_loader.c | 121 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 25 deletions(-)

-- 
2.31.1


