Return-Path: <bpf+bounces-33523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE59A91E6B0
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 19:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89ECD283AE2
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4ED16EB51;
	Mon,  1 Jul 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aYRXVvfT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D246434;
	Mon,  1 Jul 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855134; cv=none; b=EoPHwn/QcSAN3W60BGG3bD3IUu17zEQcWF+SLJKvWbckERdJz3jYJgWp7iUXEg7ylNACN03VpQ0AyYeCb+GnLLWSB1pgNS2ETlyvN1WvIGrHq2NC5XgJPY72P8jpfxa9xbsZBu62t4FlJuy4gGfLFuKqXzER/KgHUDmKxZHoTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855134; c=relaxed/simple;
	bh=Ta4/O6jp/Ik5gd1fqIOXX0+0TyVPkOIlQoHKUynzbiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNrui2JYPbUMjDNUYYC8+HxyI4T0Omq3DCO/ftb7vaGGwuEUWBHant3gskruW4+VaTXfSfw8SmIShDGAOCbNWXV9ZPHysAgYLeTE/icsvNY/XkgeGlDXq2L9x2JoVHRKJ8QfT9vXs3BYDauSy57RxCSbc2lVR/WDycfV749uMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aYRXVvfT; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461FtZrp018753;
	Mon, 1 Jul 2024 17:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=jL3l3gblgDjBiF
	A/Z2NVE3ketLIXiV2ADWuPwAzKh34=; b=aYRXVvfTI40i56cLH3QeW7PSy6kKOF
	xwK60g2ACAgcGlkcgG9uDRypwlJZRxt9mwNrM7OYoOEa1B/+d++e+hRJ38xeoo40
	gEDo9gSSAPsKtZrnVi7GhzorWNdKIsbmXE4kWUf4DNarsKHHVI8IYhRZ3d/sVTaG
	KCQ0bPQBbhR28PCuVRgSvAs8hKzFoMDAi5R/ZGNNg4b/b1PjZHQCWbHii2Yuo5dz
	0mBEMTnl6yRZij1Bj5EAeUaUMUKV8cZVpNgA2o5ykqG2rNDUmL3RuMxMgdrPAGyI
	cuR6E8KgZemvRrWlgBd4f2A5pZzfdVgLLMnEjEeWR8uCDfqDTMrrus/w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922v50k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 17:31:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461GKfYY017652;
	Mon, 1 Jul 2024 17:31:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 403x3a0mcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 17:31:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 461HSL3V023683;
	Mon, 1 Jul 2024 17:31:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-222-14.vpn.oracle.com [10.175.222.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 403x3a0mas-1;
	Mon, 01 Jul 2024 17:31:38 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: masahiroy@kernel.org, daniel@iogearbox.net, nathan@kernel.org,
        nicolas@fjasle.eu, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        asmadeus@codewreck.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when KBUILD_BUILD_TIMESTAMP set
Date: Mon,  1 Jul 2024 18:31:33 +0100
Message-ID: <20240701173133.3283312-1-alan.maguire@oracle.com>
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
 definitions=2024-07-01_17,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010132
X-Proofpoint-GUID: mm6-sG-qZSttfu5-q6N7tSYqM8wEoSZK
X-Proofpoint-ORIG-GUID: mm6-sG-qZSttfu5-q6N7tSYqM8wEoSZK

Reproducible builds [1] require that the same source code with
the same set of tools can build identical objects each time,
but pahole in parallel mode was non-deterministic in
BTF generation prior to

dba7b5e ("pahole: Encode BTF serially in a reproducible build")

This was a problem since said BTF is baked into kernels and modules in
.BTF sections, so parallel pahole was causing non-reproducible binary
generation.  Now with the above commit we have support for parallel
reproducible BTF generation in pahole.

KBUILD_BUILD_TIMESTAMP is set for reproducible builds, so if it
is set, add reproducible_build to --btf_features.

[1] Documentation/kbuild/reproducible-builds.rst

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index b75f09f3f424..40bb72662967 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -21,6 +21,10 @@ else
 # Switch to using --btf_features for v1.26 and later.
 pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs
 
+ifneq ($(KBUILD_BUILD_TIMESTAMP),)
+pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=reproducible_build
+endif
+
 ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
 endif
-- 
2.31.1


