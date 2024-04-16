Return-Path: <bpf+bounces-26978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78A8A6E86
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC391F21424
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43012DDBF;
	Tue, 16 Apr 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CLOVs4qC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D112D768;
	Tue, 16 Apr 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278257; cv=none; b=Av31qAkPjofPhbZv1uIiIYKR81Od8zcr1lsmFw7rNRGfkTAjlrUtSx/elKyJ6seet2Va4gs9jbkJfk1zXz+yQC+i04ynqzmrLPfuE/Sg92XVFf92K6df4m3RVQ3Re+WdDad9up6rBM122pE2eAlH2TuUcJHu5wfkklwp/q3StEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278257; c=relaxed/simple;
	bh=nLFf9KT/hQszCfxuTBbAMFRiUzdemuhxoIOcYnmgHSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4+DLt4tplZCUfI43AaH2ChF9C/rJnbk2PlN1lIZ+Frb71MDjK+HR4YsPNcxN02UpxBpDulDKuLiJrquZCiGjAamSi7qFCSYMZs5xxH4kAqGPB6r1fV0TJKveRjQ0FwdBDZsiRF4FEVs/9Y5cUeIMjikhAniPEcTSHIsMJ74lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CLOVs4qC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEOffq001638;
	Tue, 16 Apr 2024 14:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=mnZ3CFAeuKSJew2hYMiBvieITYlxHl5qetrTrTnw7ak=;
 b=CLOVs4qCEs+ocrSSyxWw7UkW7wFgGI9eIkJ1mhEzlaFGExHKVh/VKlc+FxikC21jdHtx
 dGDp94AwxLQCQ+04T0MeKkEb3L3lqI4QhwqTEam2s0sfgtDr3V/jkZeVBuMwXnQvOo9s
 upLyuU13fPfVXUXpZSQCqAPWPepzVdo4whc6U+qJfhrm6Omh6SmVk9WF19GEG4/pt6of
 hA2Pl8vw0DkItM/2FBWXq2L6H83KXqDzIckoCfo5/ieWSXlmQ+RneMuYu+Q0FHccPILF
 867F4YOJRmjvpdozjxQfWCU1ay2kGQEVsS9LfVs7GFS6Ii4IsVbABwbD1rJcg52SoNdD iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv5ce9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GDp5wU029289;
	Tue, 16 Apr 2024 14:37:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7an7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GEbMes029885;
	Tue, 16 Apr 2024 14:37:27 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-210-77.vpn.oracle.com [10.175.210.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xfgg7an1y-3;
	Tue, 16 Apr 2024 14:37:27 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
        kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com,
        linux@weissschuh.net, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/3] pahole: add reproducible_build to --btf_features
Date: Tue, 16 Apr 2024 15:37:17 +0100
Message-Id: <20240416143718.2857981-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240416143718.2857981-1-alan.maguire@oracle.com>
References: <20240416143718.2857981-1-alan.maguire@oracle.com>
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
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160089
X-Proofpoint-ORIG-GUID: s8jkmTnSUjlSmy9uajEBsAtS15Uz2sYF
X-Proofpoint-GUID: s8jkmTnSUjlSmy9uajEBsAtS15Uz2sYF

...as a non-standard feature, so it will not be enabled for
"--btf_features=all"

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 8 ++++++++
 pahole.c           | 1 +
 2 files changed, 9 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 2c08e97..64de343 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -310,6 +310,14 @@ Encode BTF using the specified feature list, or specify 'all' for all standard f
 	                   in different CUs.
 .fi
 
+Supported non-standard features (not enabled for 'all')
+
+.nf
+	reproducible_build Ensure generated BTF is consistent every time;
+	                   without this parallel BTF encoding can result in
+	                   inconsistent BTF ids.
+.fi
+
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
 
 .TP
diff --git a/pahole.c b/pahole.c
index 890ef81..38cc636 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1286,6 +1286,7 @@ struct btf_feature {
 	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
 	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
 	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
+	BTF_FEATURE(reproducible_build, reproducible_build, false, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.39.3


