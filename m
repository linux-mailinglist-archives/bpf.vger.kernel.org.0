Return-Path: <bpf+bounces-27566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD588AF367
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D565281D55
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4713CA99;
	Tue, 23 Apr 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WuULfw59"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC511350F2;
	Tue, 23 Apr 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888140; cv=none; b=V6aNTCl2PZ0YHffzWSrqSR2BtoJ7mzkOzpihfYRnfwoycRbI5U1nDeOBamGI9Cz2f4155PpWciGJ2TJByij2YSLtziXibdWAoWg2YoAzmvb6dCxHAh3B+moHPX0epLghIo127lvGPIwAO2EjjPX48Iuc64fd667fGWSKRxtqPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888140; c=relaxed/simple;
	bh=wV+GInQVJdArBKcwZcCFiyEp6aqVRtdsZ+V7u3EA16I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQentojRnKIBRCcuB5SHNel75sYW2E6ruZ9+94hk5XItWANzS6BFExKw2JAoCsUdMs+4xtvRuF2GxJW2h38oJ89r6vtT7lP9QC1rQ3cerwfALlZAoOe9+zN6Gw+iK3vsxk4A98jUtz6WsXVzZMCOKaUEyQvSfo6U7VXeJ1kTEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WuULfw59; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUNi4006531;
	Tue, 23 Apr 2024 16:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=/ydHjayxrGQ6jjAr/59LfwFyEZqQK12WzmWUxE/icXs=;
 b=WuULfw590j757yOd+UpuXrRfUFlhEFGvXjzp1rSMldabwdRVE++b+PF3FUafZHEl1CFf
 4wh59lJqxILlC9+ybnIpYGJauXdCDtRmyFtRtEVR7x28smrIKA0wLpmBVKMTLhn4qH0d
 Vpksp+zfdMJf6/77ubfe75vXwwhwgc0TmsKpKA+Dy/tt773tb9JNuSJ2vESRk49yoPXm
 kCQNGA/1xHcge/R4cWIJYas/WvIfe4dMxShoSNewqS0waBZeZfIdz0pj65vDMeLYRq0V
 mqnGQCO9uMgRlAVvIff19rKeRVey0saigeOZfe8q6i9tqEDWEgPBkvJjEYE7gxgSduJu 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md6dky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:02:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFIjB9019661;
	Tue, 23 Apr 2024 16:02:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf3e6u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:02:05 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NG24nT038435;
	Tue, 23 Apr 2024 16:02:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-44.vpn.oracle.com [10.175.173.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xpbf3e6pt-1;
	Tue, 23 Apr 2024 16:02:03 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dxu@dxuuu.xyz, dwarves@vger.kernel.org, andrii.nakryiko@gmail.com,
        jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
        bpf@vger.kernel.org, eddyz87@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] replace --btf_features="all" with "default"
Date: Tue, 23 Apr 2024 17:01:58 +0100
Message-Id: <20240423160200.3139270-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=552
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230037
X-Proofpoint-ORIG-GUID: ZtGLsMu8k5Y_zeFVXHRKHMgFUb_JkKEr
X-Proofpoint-GUID: ZtGLsMu8k5Y_zeFVXHRKHMgFUb_JkKEr

Use of "all" in --btf_features is confusing; use the "default" keyword
to request default set of BTF features for encoding instead.  Then
non-standard features can be added in a more natural way; i.e.

--btf_features=default,reproducible_build

Patch 1 makes this change in pahole.c and documentation.
Patch 2 adjusts the reproducible build selftest to use "default"
instead of "all".

This series is applicable on the "next" branch.

Alan Maguire (2):
  pahole: replace use of "all" with "default" for --btf_features
  tests: update reproducible_build test to use "default"

 man-pages/pahole.1          |  4 +-
 pahole.c                    | 75 +++++++++++++++++++------------------
 tests/reproducible_build.sh |  4 +-
 3 files changed, 43 insertions(+), 40 deletions(-)

-- 
2.39.3


