Return-Path: <bpf+bounces-26979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC38A6E87
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504121F22068
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED42812EBC3;
	Tue, 16 Apr 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KPJB9TZA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139839FCE;
	Tue, 16 Apr 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278258; cv=none; b=aVHdpCHr2OFOsEoN0X+1UvwALDGaXqnGhibpVEiF+fio7yrwH+83PAwmzG+Gnt3/BL1R1dpzDz4cMxg8IqUxu8wNPVpnVzJaaQ5YMm96qZF2+SU1jP5hZpy46pa5Q9YL3IocR9rsyV5BwlQPZCUklPrMcAkwK4uTv2WqScZVjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278258; c=relaxed/simple;
	bh=mB0XAoXGQDeb+MpNpqRbG7PQKRN4Ep3AGlsguULyTSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWR9WZsEO2l3fIrDwvQ3r6/JE2alP86iw3M6WXuPmXCWpGpDhW8QFjX3c/z2IZqrtP356mrBIy+0vqKUPhacUA3IgwlMgZvx7hNlctsGIpo6r0oKmNCEPXljf/NiaR96hz6n5evZiAq3fBPckxV1pLQkbsQYx8qY8tCbt7+A6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KPJB9TZA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEOffo001638;
	Tue, 16 Apr 2024 14:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=m5f05M3SGthyZcnofjWLaORzFIiFLXy6Xor8OaIrp6Y=;
 b=KPJB9TZAzxUJlt41/NUUB6doPADakx5wEhmRZGXLOLEPA1PeS4+cTqTXoHt0RMdHc+98
 hdNcniycKND6OFOzUzxBRn5IkbhPWYkWwBlOMJkVK7yHcdWol3628sr428pl0sCcd1Rf
 WkpBEVFaLQVdZyTSa70kWnC3RTYP+tdMLaGmgIK5NXMYRIUjFgpNJA6nrw+bcaQ+C/fM
 SM2TViIqMZH8EhVzkZX3bhMtRISd5eS6p73rJ1HTxCeUEHx+tmQm32wUO2dNj4jGBzJg
 1NdLi50gTi9b9MXxRmgmsTGDV3hghIv5DO4RDgTnb1yD/Ja4i+lSKo8pn2jlniJzGZ0K gQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv5cdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GDheK4029139;
	Tue, 16 Apr 2024 14:37:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7an4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GEbMeo029885;
	Tue, 16 Apr 2024 14:37:22 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-210-77.vpn.oracle.com [10.175.210.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xfgg7an1y-1;
	Tue, 16 Apr 2024 14:37:21 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
        kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com,
        linux@weissschuh.net, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/3] pahole: support nonstandard btf_features
Date: Tue, 16 Apr 2024 15:37:15 +0100
Message-Id: <20240416143718.2857981-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=841 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160089
X-Proofpoint-ORIG-GUID: SMQ9HKFqUCbWZyqL7wZWSmzukHNwyK-p
X-Proofpoint-GUID: SMQ9HKFqUCbWZyqL7wZWSmzukHNwyK-p

This small series allows the user to specify --btf_features=all along
with non-standard features such as --btf_features=reproducible_build .
Features are documented as standard - so participating in "all" -
or non-standard - such as "reproducible_build".

Tests are updated to use --btf_features=all,reproducible_build.

Series is applicable on next/ branch.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Alan Maguire (3):
  pahole: allow --btf_features to not participate in "all"
  pahole: add reproducible_build to --btf_features
  tests/reproducible_build: use --btf_features=all,reproducible_build

 man-pages/pahole.1          | 10 +++++++++-
 pahole.c                    | 37 ++++++++++++++++++++++++-------------
 tests/reproducible_build.sh |  2 +-
 3 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.39.3


