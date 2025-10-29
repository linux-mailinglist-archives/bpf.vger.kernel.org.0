Return-Path: <bpf+bounces-72708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCDC197AB
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 10:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637AD3B8118
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7792E172D;
	Wed, 29 Oct 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LbOMpoEi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6620C48A
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731233; cv=none; b=WhNp68LMg3gebbrh/ZQvk/uQwXvYypjZixKbK8dPJUwYCLQKY3xAlvsV1RzzvE6VSaoRRz+fzSYDivLJ+dLRKE8BUErsFKJHl3DtDNNG5vWZqySIearCGax+pYhPBGjBQ7RotMWtP0IErZn6nSpLGoPS5L3U7HZrCAjplqmKPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731233; c=relaxed/simple;
	bh=MkpK3xdZsDzi7yjVGDfMMeRCvw0bKCJAeHg8HOHfAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phkh/bzp2ChD3Ys4ycMfOo+ml0NBhjKsnzFrl9i0GoXIXQJQp/YbId/VkJgm5rNzNeuwn2TDaFUsWQADmAZPJcBuwyyPPIT2XnRvhZeo0jQld+9DWJaMYzFkyXPo3WH20rD3XiBq6YFrge4CQcXN56XMLY5P4D69O+1/fGL8vnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LbOMpoEi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gSGw010100;
	Wed, 29 Oct 2025 09:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=af6LsKFSrfeu9aQRZz/f3oNQflQRe
	t2ryFFVts3kWRA=; b=LbOMpoEirY7G4lrjE6NL9sh4W0llcVpJw97IcRZC9et/Y
	WQIdXlJmJWBnW2jGTf+Ge/ijMamDzGVl0BM/kZOOHbm0WDLAMsLTj2fYeGQ23NpY
	u4s5XDOnh8xAi7i5uYWS1opvINcAaD4GB9P6mThNC0yN5c3nQx5C2O9W7nKXZzYp
	i/WhAG9d0iz7df97LJpOIw2hFLPe8xXGvR4MUlITA91asafgv79ql0RbJ8OEgN0q
	/85ChbSFsZc6hKcIIfSDDSetYIY+p7sfVbkfp7hVT69KKLZx5i+vzk2kImZ06XSQ
	sZwxMRE+CxvpnZq7s18hyzn49NVH7PVSpTbhYiMow==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3b4w0jxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:46:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T8f2v1007865;
	Wed, 29 Oct 2025 09:46:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wk0ccj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 09:46:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59T9kbKY030346;
	Wed, 29 Oct 2025 09:46:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-155.vpn.oracle.com [10.154.55.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33wk0cah-1;
	Wed, 29 Oct 2025 09:46:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, terrelln@fb.com,
        dsterba@suse.com, acme@redhat.com, irogers@google.com, leo.yan@arm.com,
        namhyung@kernel.org, tglozar@redhat.com, blakejones@google.com,
        yuzhuo@google.com, charlie@rivosinc.com, ebiggers@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 0/2] bpftool signing feature check
Date: Wed, 29 Oct 2025 09:46:29 +0000
Message-ID: <20251029094631.1387011-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=778 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290072
X-Authority-Analysis: v=2.4 cv=R9YO2NRX c=1 sm=1 tr=0 ts=6901e27f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=wZMlxinwef_JoundXOsA:9
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNiBTYWx0ZWRfX0IctL2fGMvoO
 D3Cw+GWAsKMHqFJaeR2GCIy/AiSZcCTVUN1S6Cb6r59PTthSsObiaLQkfbml/VEn6g9WaBpoTGw
 fxRCJsiGtbJw1tktXyEcM4W/EUX8XWZTix+Pux7397WfO+4TIT3RDLOh/f1dW8NkN3vrDiEimsk
 yphXk90r65qV6Sqtd6PhN7SG7rKY9BeOpyg/vke9qfbMhKm+1OnRO8JeyjvV+Kzc1kCiTu92uYx
 JtRJKPcwAOvSSl8QhHVTYqj+sdNS29PWzLjF+bmjEj5yNZXAT9sUvMTmn5vmpWQpG2N639ISXA6
 0yPFJz13jD8mkWcjG9IFY+0USBOqZNny8tfA6dfZ9+Ut6d1QpBlU5YwWfk+v/C+IgsKxVIZXQS7
 FdDD2cG9uC6ZZiXv6nEQbWMJ9FXDAQ==
X-Proofpoint-ORIG-GUID: 635xA6_X71e8I6Vcdmqb4FVw2Whrgjhj
X-Proofpoint-GUID: 635xA6_X71e8I6Vcdmqb4FVw2Whrgjhj

Add feature check for libcrypto >= 3 needed for bpftool signing and
use that feature test in bpftool compilation.

Patch 1 implements the feature check using a libcrypto function
present in v3.0 and later; patch 2 uses that feature to conditionally
compile signing code.

Alan Maguire (2):
  tools-build: Add feature test for openssl3
  bpftool: Use libcrypto feature test to optionally support signing

 tools/bpf/bpftool/Makefile           | 17 ++++++++++++++---
 tools/bpf/bpftool/gen.c              | 17 ++++++++++++-----
 tools/bpf/bpftool/prog.c             | 12 +++++++-----
 tools/bpf/bpftool/sign.c             |  2 ++
 tools/build/feature/Makefile         |  6 +++++-
 tools/build/feature/test-libcrypto.c | 12 ++++++++++++
 6 files changed, 52 insertions(+), 14 deletions(-)
 create mode 100644 tools/build/feature/test-libcrypto.c

-- 
2.39.3


