Return-Path: <bpf+bounces-53494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A3A5523A
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DE37A97DD
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463BF25C71F;
	Thu,  6 Mar 2025 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H37aCao+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018425C705;
	Thu,  6 Mar 2025 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280721; cv=none; b=DS7kILvxjm4mbeqbzOzj0iI4bDNPdECjcs7U7A8CWCL2Q7EONVstQp2cGlYrDQs9h/gB92gnPMX6YTZIUceaZMmThfcnSw/NFDhYGJnzJgNuuAtCRpScwJieo5FGq/oGFOCIYRC9iRQx2cF4F7FM+p5VJa1v75N0L7VuikfI1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280721; c=relaxed/simple;
	bh=fTAEJEbO2PJgbNWz/6DAQhBnCvPAz5QThgI1y/sJTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzkGH5Nily7EJknmQ+m5fpJK2TudSDaJ4P0zFN0lKKq3YvDPVhDrrgWXxRQSn5OqtGnRvr+aaJh4R1+3cTQd/y/O/d4UNDMTJTmrqX4Qbl3088kZof/iZbE+K4Her9QQjNMQ5kyGhWJKqQ2H0d3wOoCgJY5TuMakhYp0BrkQCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H37aCao+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi6CH005531;
	Thu, 6 Mar 2025 17:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ju3++
	dysrLcOWN9Ums1Wr/vPkP7krJZ1niGX5/GNCvc=; b=H37aCao+Ic2bjGT50QG0U
	e1W72khVkL6nKQnffp909iIBZYl3t9brTTeFSlgn9i18zH0EdEXe4CZDk3pMRo9p
	eDqHimhAvEOOp/6b1AMgMOJt+stoRnSBxeJuJPHnlPUayhHxiNzZzd7zM8rIgrIX
	012CM6V70QUEKtx065rgVyt9fp72XgD6++MXppM+sPSJxVwWFAfvQ98GFBApVjEL
	ihqy9br1GNAmqOU4avsbFk7HVBSL6LPOKVccsiTKqpCuRvRjRHpUymGDDzCaT+qh
	A+TxkgdLfKstlSAAxxUPz8lolhEaCCoeUJlcDgpIbrvN09QWI2RnPLJllLdqpfHB
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub7an2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:05:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526GOqkX010963;
	Thu, 6 Mar 2025 17:05:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe0exy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 17:05:02 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 526H1Exi022155;
	Thu, 6 Mar 2025 17:05:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-26.vpn.oracle.com [10.154.58.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 453rpe0eqr-3;
	Thu, 06 Mar 2025 17:05:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, song@kernel.org,
        eddyz87@gmail.com, olsajiri@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] dwarves: Fix clang warning about unused variable
Date: Thu,  6 Mar 2025 17:04:55 +0000
Message-ID: <20250306170455.2957229-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250306170455.2957229-1-alan.maguire@oracle.com>
References: <20250306170455.2957229-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060130
X-Proofpoint-GUID: cKV9ZM0pPGJ1bF6T8KrtnXkMWf7Is0S3
X-Proofpoint-ORIG-GUID: cKV9ZM0pPGJ1bF6T8KrtnXkMWf7Is0S3

With dwarves CI, clang builds give a legit warning:

/build/dwarves_fprintf.c:2102:9: error: variable 'printed' set but not used [-Werror,-Wunused-but-set-variable]
 2102 |         size_t printed = fprintf(fp, "namespace %s {\n", namespace__name(space));
      |                ^
1 error generated.

And in fact we accumulate values in printed but never use it
for the return value.  Add the printed count to the final fprintf().

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarves_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index c3e7f3c..4407fd1 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -2110,7 +2110,7 @@ static size_t namespace__fprintf(const struct tag *tag, const struct cu *cu,
 		printed += fprintf(fp, "\n\n");
 	}
 
-	return fprintf(fp, "%.*s}", conf->indent, tabs);
+	return printed + fprintf(fp, "%.*s}", conf->indent, tabs);
 }
 
 size_t tag__fprintf(struct tag *tag, const struct cu *cu,
-- 
2.43.5


