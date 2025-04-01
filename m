Return-Path: <bpf+bounces-55058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD1A777A3
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7504218880BA
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2B1EE7DA;
	Tue,  1 Apr 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BMDGJb+I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461E1EE02A;
	Tue,  1 Apr 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499506; cv=none; b=BSrBa0IMnTBdjiswsWLB8bdBaBkGO6FxB19rkoWtlAZrNF4eQCW3f9FmvAQehE1VHIXtwCHDfNInH5yorxBtrs80gkNNdQwS/EjBup+4wRWJBvS8SNiGE3TwjkNiZMVnM4Yt5IYyr5ktlD9kVa+hZdg0BgDSsad6lhDrwxyRAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499506; c=relaxed/simple;
	bh=fTAEJEbO2PJgbNWz/6DAQhBnCvPAz5QThgI1y/sJTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQIP9w2yDCUqhCSAoc95WWeRAPGRiejCemFLd5fpyZOy8E2VhZiRmp3U6Qr6jqYyXFNS2uuGIMBmrmKMyxONKj5sxWhAIJIaNdVBkPX96WFjDvEFT3Fr3aIFYbGMuXpOeH4G0UDacRC/AF3LSzkIQE2aM4bZGNYRd1SjNOoryAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BMDGJb+I; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318BrrS014549;
	Tue, 1 Apr 2025 09:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=ju3++
	dysrLcOWN9Ums1Wr/vPkP7krJZ1niGX5/GNCvc=; b=BMDGJb+IlzE0MAm3mbY54
	EJi5NmzNSGwtT8z0jzj5w2Wl4pf+VwXp0MpSLkDrnC6FNS8Y5RG9tPKYJnXAs8ej
	gM86KPL4/0mTBN9vIKNhLXf1JnN2ZsRXxBpW5dEPZ8DzI/fhzUU7D1pehnCOA8qK
	kJ7z5FIpMd2FUm3Bto0CcCLuD2EhMHmd7YwidJiMLkdyMCwubTU0dHHg1ajxPPnX
	z5ZBYE1tSpcklkgZHcEGMOKQMLxHOgddcyTabuRVqF4CR78jGsiKEq6yXdoXrWOm
	3q83WxeGGlcovbY71X6yLq9AbgFerjv+OCw9qG+sNd1SS8nitzoVFztiyWxL9Jgg
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7sapcrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 09:24:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5318xLn2032747;
	Tue, 1 Apr 2025 09:24:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a93666-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 09:24:46 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5319OcHf008831;
	Tue, 1 Apr 2025 09:24:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-231.vpn.oracle.com [10.154.53.231])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45p7a93603-3;
	Tue, 01 Apr 2025 09:24:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, dwarves@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/2] dwarves: Fix clang warning about unused variable
Date: Tue,  1 Apr 2025 10:24:35 +0100
Message-ID: <20250401092435.1619617-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250401092435.1619617-1-alan.maguire@oracle.com>
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504010061
X-Proofpoint-GUID: wcKSbBHyEn6qeWenq-ip7ho2l7zPhMBM
X-Proofpoint-ORIG-GUID: wcKSbBHyEn6qeWenq-ip7ho2l7zPhMBM

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


