Return-Path: <bpf+bounces-35878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806793F3BF
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B019B21D7A
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B9145B06;
	Mon, 29 Jul 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BRCMMxs2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EB142915;
	Mon, 29 Jul 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251631; cv=none; b=JLLV6cte9ImywhHX/xp9AMZshesSbUGrQx9bzvZvlLW3IQO5Xery9Dy4+A/xSHh5Lp7PdoESaw/zYkUIgYvchk/uCAgkiu5xMjYRFVgWR9Re/+2L+wP6UdDcHJ85And8YGS1pusLzCMkYzmP6Cu4xkYJb1kZtVJnvcInmojYBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251631; c=relaxed/simple;
	bh=Yp/ziIK7TjgdEJ1L/c274k1H3OtrTriWdO8MG8oniHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JACKq0xdDgV/BCBOTiSkJciYR0WU/Ye7IWesg/lGoZo2qz2jcRuQrckGGr79rQZiPhjIRJRp/nE0kE+UCTnYHRs3afs6OCdmUKSiRSc8lFsbzMPsyMqsyb9qgItilMw+Yr+z4y0/laD0JoE613yAtgD1iS++ium0JieDRU3WF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BRCMMxs2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MXNO018370;
	Mon, 29 Jul 2024 11:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=66QX5m9Tcvzjnb
	2vwS0CHBry7TnBf7p7/Pnu0FLoYCU=; b=BRCMMxs2jX/gobHMll1NbHcsnYekIx
	aVZgWZO2b/W3xgfXEurtOBlnlIAKlOg5pvCfUDcGLf2XCvPj0lW2A6xGn9UPmOve
	FIHz7WhL0uXvQo1+7e27Exdd4hvstN225hbAwEaW5mgm1UwuV7c4M9mv70b2+NUJ
	GN+LbvAbOFcEOQJmRTFG5YGao7HNFzgCvO/U+Nj7i1ndPCmJvJ2DpofaYKY8C8IN
	+x3KkEDn0DsBGqa9MWPOTeZorwAABbjAxHtFQiRAIUmzvy+SH8StEwE4b3ze63bO
	3RszMqw3mMFIqA9JsxvwtRqNa0VXjMqyFPD9CIk44f5o9TE3oMlX4E7Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs29kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:13:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46T9LL4u005807;
	Mon, 29 Jul 2024 11:13:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxjwa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:13:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46TBAAdS008724;
	Mon, 29 Jul 2024 11:13:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-42.vpn.oracle.com [10.175.161.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40p4bxjw3w-1;
	Mon, 29 Jul 2024 11:13:31 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: jolsa@kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] add distilled base BTF support to pahole
Date: Mon, 29 Jul 2024 12:13:15 +0100
Message-ID: <20240729111317.140816-1-alan.maguire@oracle.com>
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
 definitions=2024-07-29_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=760
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290076
X-Proofpoint-GUID: 4Y6nuJY9YwQMWNDZiMOohUevrnVPLcGj
X-Proofpoint-ORIG-GUID: 4Y6nuJY9YwQMWNDZiMOohUevrnVPLcGj

Patch 1 updates the libbpf commit to use latest libbpf with
btf__distill_base() support; patch 2 adds support for the
'distilled_base' BTF feature, used to support resilient
split BTF for kernel modules.

Alan Maguire (2):
  pahole: Sync with libbpf-1.5
  btf_encoder: add "distilled_base" BTF feature to split BTF generation

 btf_encoder.c      | 50 ++++++++++++++++++++++++++++++++++------------
 dwarves.h          |  1 +
 lib/bpf            |  2 +-
 man-pages/pahole.1 |  4 ++++
 pahole.c           |  1 +
 5 files changed, 44 insertions(+), 14 deletions(-)

-- 
2.43.5


