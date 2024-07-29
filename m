Return-Path: <bpf+bounces-35879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A8593F3C0
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B461E1F22378
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F9145B15;
	Mon, 29 Jul 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BBr9rlJU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4DC145B03;
	Mon, 29 Jul 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251633; cv=none; b=KK+KlRFvYRBM9y73jlZPYaYoSu5g+RzX3nSfQwJ5OuLMvFYPT/LIvTTI7vd0XTQQtnxW7ARcsUV0BCuwZo7AqFC60AAQRW0+fdKsHI1jHlIbCwGMtNTfYhnsXoPs1vpzqFcvVwGlYBgwIkzntB3u+71UbaA+YGn22vvtmjEK+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251633; c=relaxed/simple;
	bh=F3qjt3974aTSvMedgM8l4Op9J2bfZXvb3ImIf3UYJng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKWaece5iHC59btP/BoxIK3VTw4USd7h0gwQjaedNeGI3yPt5XymSl77NBqSPYhpMWUAoHr/NT/6iq5MT7hoy+VciIleb4ZeDFB4+7RzsXy3Mft/bXm8LHDDK4L+esAWM5IWaXv8RYidCEn+tn4M8kNFjDLzYivyYzJGGn72mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BBr9rlJU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MYnB029196;
	Mon, 29 Jul 2024 11:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=j
	ulnBWiqPlFBpUB8tU+lI1g8W8zW/EqyWYUhI9RoQu8=; b=BBr9rlJUoVouUbL5t
	xZtWl9SMXnnNxNUrnr1IZtGusYWaJ9iJfQsMn8AgFF1G12gXP30cCqy0w6abumYX
	G9ELsxCQAC1PwtTPHnoiEk5M6eZLs8zqEJ+zwGVSwIhxjzCIg2/N0wgTsLDC6pls
	j7eyZ7k8VydwN2hHuCjHS+rqQw8CrfusNJlEIsLohaAc9fxNY+CCnWHLGrAiG44V
	Ux2rmpyCYn+D7PYE/5UTVbS5oCPikncN0t2sTyrTj4IbQX0MyCmXB2igR0vfX8e3
	/agc4ivAIUJPyUYtxyJku1/Z/dyb06EdDu2bc58OH4/9/BGk/L03jGqI6aK7/xoV
	DMMfw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxbta2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:13:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46T9ZIOK003809;
	Mon, 29 Jul 2024 11:13:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxjwbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:13:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46TBAAdU008724;
	Mon, 29 Jul 2024 11:13:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-161-42.vpn.oracle.com [10.175.161.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40p4bxjw3w-2;
	Mon, 29 Jul 2024 11:13:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: jolsa@kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] pahole: Sync with libbpf-1.5
Date: Mon, 29 Jul 2024 12:13:16 +0100
Message-ID: <20240729111317.140816-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240729111317.140816-1-alan.maguire@oracle.com>
References: <20240729111317.140816-1-alan.maguire@oracle.com>
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
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=901
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290076
X-Proofpoint-GUID: G_z6gggFlVhZCedfPbRRslb9GA3u_iUK
X-Proofpoint-ORIG-GUID: G_z6gggFlVhZCedfPbRRslb9GA3u_iUK

This will pull in BTF support for distilled base BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 6597330..686f600 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 6597330c45d185381900037f0130712cd326ae59
+Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
-- 
2.43.5


