Return-Path: <bpf+bounces-44941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1807F9CDD8E
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DA02816D9
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C71B6CF4;
	Fri, 15 Nov 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7XKslwC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60A18FC84;
	Fri, 15 Nov 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670599; cv=none; b=BPsi5DEJb2Iuby8hnJn+VLvXUufPMT5KsBHBt97kcY2yHSbpdtLyGcrrzVRdtrWh8pHtNs23llPaxX66QTNb4JiXUI7ddCjz8kbYbKSjXsFyN+POyozjxG90NgB11UMXlc13waHk61LQNCNX/KFosYYewfJXLffVj2kWIzOr09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670599; c=relaxed/simple;
	bh=Qr+Pzo+6ixiG9UmcoTqd0IUAJDKFScvwt5NMX9rCdzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyukMZ1TTXPODfxaJKN0s2ytsjRPfDaIU9gSQAPjyuHnJ6t8wLnFKC35l5qYCEidKBaEdYXwtukAQH9/i1FxeqzDRR1P0gF6DQ+iGR41pfSb6LltiRWfts5QVvaAs5psyu3NoucCepXfB+6UIIJZ+FMLTEnIrfqqgvrs9GMlHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y7XKslwC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHHVL021506;
	Fri, 15 Nov 2024 11:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=F6lWJPZG9iq0xd6xykUJ4TxSwOtzI
	Xr2bNLi6Yr0YTI=; b=Y7XKslwCMbCNJUUwZ0w8egnBUsK/kKdH3KaDVe0F7yB2z
	WLkijnyAjB/aBnpS3nOnW9XAdUev7lXjAU5ngI3WFO0pCN3Yqs+259ZP4ISNFgq7
	yRfBWZcJRaZsqL308NUrjekZOO9somPfBftmhPY1tMYlP4jiDohhPjb7iUUI+EYi
	ac0kZDxd48XtiozXALGJW+78QLFuiYBMKLSIEkkQIr4dDa///HjW6Pq/WBxQbwro
	IpkLMb93xhdvAiRBc5wOn3poMl1sINylpd0cooFx5xcvo3vANdYnC2j3074UPj8X
	k1JqSYMUzlvXgV9LI7OhSZxeA3XChCdxAPt+GlMKQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4mxeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:36:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAaaYl035933;
	Fri, 15 Nov 2024 11:36:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c38a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:36:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AFBa9PF010008;
	Fri, 15 Nov 2024 11:36:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-214-128.vpn.oracle.com [10.175.214.128])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42sx6c388q-1;
	Fri, 15 Nov 2024 11:36:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/2] Check DW_OP_[GNU_]entry_value for possible parameter matching
Date: Fri, 15 Nov 2024 11:36:03 +0000
Message-ID: <20241115113605.1504796-1-alan.maguire@oracle.com>
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
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150099
X-Proofpoint-ORIG-GUID: 3Z-gptsem9APIg7lmHxAoHs9C9mLZVXS
X-Proofpoint-GUID: 3Z-gptsem9APIg7lmHxAoHs9C9mLZVXS

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

Alan Maguire (1):
  dwarf_loader: use libdw__lock for dwarf_getlocation(s)

Eduard Zingerman (1):
  dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
    matching

 dwarf_loader.c | 123 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 98 insertions(+), 25 deletions(-)

-- 
2.31.1


