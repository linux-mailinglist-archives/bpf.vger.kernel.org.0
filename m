Return-Path: <bpf+bounces-65203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371CB1DA18
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA2217C893
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87255264FB2;
	Thu,  7 Aug 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9Y28cUy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CA263C90;
	Thu,  7 Aug 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577742; cv=none; b=DOnzUa1TsGjQ57Skb3NMR267BXMMDRZsWL8kqn+XII425E2ss+mna5iNNDnDvLYnQfdV6ktGfpAtOEsmIl+Wxf2N9lNgXRcDByAy2JEhpVoRFcnexzi5Z1ebrHjEQl6MCBddn74HSGFxWS0OFZz9q8/zX2d63xi7AgtnmPM9Nf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577742; c=relaxed/simple;
	bh=ijKB1Ky666q7aR3Knn6PFo74lcFALU/SmYO5lb/ZiRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNJi/NlrKC13SZoQjQbSYK1o5leeZ0G78rVVr2dHyhQtqMEmX5WXrGPcMMpauo2MtptAfc7gM3BWIwsvkzZB+Btz9BdTziVMXUtegI9nzVfyXlVGPs6E/nMUKeZAyuhEI1oRbC7W73UDj/UWfZyRYSSPxQ61BAed38J9QpuXzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9Y28cUy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5777MuFZ028222;
	Thu, 7 Aug 2025 14:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5oSIu
	bgx/rgb7cmAPaN7nYMKOXUeSs7BVMrk9up3+5U=; b=g9Y28cUyif/LM+zW3/6Vr
	Lr3BvD1WW2HAbyH9pFN8d12oh0SMO8cqrYP0HWeSelpkD3X6U2vuHDVVF0Q1IS4I
	EGt2PwEhlZUxs4hTxsmkh9Px6vJXQjOaCSo5oxQk7hMHNjMlfjswU09ncmOmCFhw
	C2XLMzYZYjE/7sKVB6aXbkFmTw+J9vYDqTT2dCTBnWhjFDGCYhhkqeE9Ol0+PnXo
	aTX9BBZhWXvwXzRmkcEf0GJVe8TWTa1S9gkmNnVIn9UVQqyAHGe2fUhQXyjtUs/w
	mxPOhvTcUTDfZSUBDLU/9Hv6We0LDID9qWm50b2a1t7jGio4vNz4a/3XX+J/yPzZ
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh47yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577DLxnN005799;
	Thu, 7 Aug 2025 14:42:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyhvw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 14:42:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 577EgAIn014830;
	Thu, 7 Aug 2025 14:42:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-8.vpn.oracle.com [10.154.53.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48bpwyhvt5-3;
	Thu, 07 Aug 2025 14:42:12 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 2/6] pfunct: Fix up function display with updated prototype representation
Date: Thu,  7 Aug 2025 15:42:05 +0100
Message-ID: <20250807144209.1845760-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250807144209.1845760-1-alan.maguire@oracle.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExOSBTYWx0ZWRfXw3OlN4JADa7G
 nLFRwtLHj5aJod9/Z+EHZZ0Cf76uALbV6JUfsV3VJvTQC3zRHLWISv9fdu7q8mIcX1sHZ4xGYj9
 7fb6Adw9UCf7DoKsOI0ZhppGiWPji+U/aW/EB89g/G0oHpfj4BfgHRy7+oVK4xeCGSJk439B0ny
 6kGqVG9TZcQhBNsz3uY7gCkmOpK7zA6mw/znSiwvm9+GQikfJ0VTuceIZPzU77/jLX1mnRtgJ01
 C2mhukIznvOikCxUCznqrwX8TZoMoZN0zPP5det0bSXQfJv4lCb/AvGDN2uppOzqrWH7vigGQV4
 zMsBHcjW81brKP+3HfWctJDA3CMV97p+d1bZN6a6e2hBqf/Q6iBXHNX1JdafVXMhLvNNi+b53y8
 IZsrLUlev4WJXPFxr9MhaGttdrLfWRjfy+UANb0m7xTt4uzamSQZP2K0lnyoSAZ4TPFq0Zjs
X-Proofpoint-ORIG-GUID: y9pBjj-SwcDUuJrYeiIKIGvM6OoRBAZN
X-Proofpoint-GUID: y9pBjj-SwcDUuJrYeiIKIGvM6OoRBAZN
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894bb46 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=aRT4OfQelZJyg_GMs3UA:9 cc=ntf
 awl=host:12069

Now that the function prototype representation has been updated
in the BTF-derived ftype, no special handling is needed for printing
BTF functions.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves_fprintf.c | 2 +-
 pfunct.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 1ec478c..557fe7a 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1402,7 +1402,7 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
 				const struct conf_fprintf *conf, FILE *fp)
 {
 	struct function *func = tag__function(tag);
-	struct ftype *ftype = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
+	struct ftype *ftype = &func->proto;
 	size_t printed = 0;
 	bool inlined = !conf->strip_inline && function__declared_inline(func);
 	int i;
diff --git a/pfunct.c b/pfunct.c
index 5a6dd59..61cefd5 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -326,7 +326,7 @@ static int function__emit_type_definitions(struct function *func,
 					   struct cu *cu, FILE *fp)
 {
 	struct parameter *pos;
-	struct ftype *proto = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
+	struct ftype *proto = &func->proto;
 	struct tag *type = cu__type(cu, proto->tag.type);
 
 retry_return_type:
-- 
2.43.5


