Return-Path: <bpf+bounces-27697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A18B0EFF
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C61F2281B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7B15FA6A;
	Wed, 24 Apr 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K698+oNR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142001422AF
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973754; cv=none; b=eXjO1ysWuPPp/XlaPtpc75UVCPa6oYnEv4vHHeb694z2nE7TbYCGO67pbdCYhJsB6HBdnMRO6rr1qAA6J1xU9U9Ym8mb06rj3VrJS+WrYdW+wg1alJLuVd5NfygZKNRRruFD7785Pn5ro9MrX1j5BHjM3a0BvgU8duZc5KZXQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973754; c=relaxed/simple;
	bh=TO14thCzwXY6q/gOV/R7Vt8NAwvkuhfkNyg1N71U4Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pi0HdesufsqfiQlVZsicofmJeUyFdxxI0d92FLGAOZSICvNe89zJqSiAKC/kwyQ6U/fw5dWSUXcY7pAn17URBupW2ccjgaMg29oC5LzG6FesLAWGXuWHZ8UvzADMvAOpkuo/8TXuxIRFOQHWXaZZGTt4f+lvEtKnIdv690ukP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K698+oNR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFa4Bn009710;
	Wed, 24 Apr 2024 15:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=IrXZwDNwTkREGmLvYeavfzoV9wcq5Yozo3kQ5GRGPKs=;
 b=K698+oNRg4DC8shJ/NVqurIvV3QPQLeNP55EWvM/wSwK/RweS3Lky0pdbYan/7V0I6h3
 V84nMJsmAmnbIiHEryyP+RvEoWkC+2oNVw3BlslyRwDPDFezH4DtzBkqOZjhbujAAZmn
 SYjepg9ILkCsY/pToTlTWkqc9szuvtJTV+RdtF8epkVPS6ul0cPV/ztAf8F76bbqUU/z
 A33UMupYS6dXxg8lyteDU9whgph+EhBzZWLbrxA0YS4r5YW0S673mIWAS8pXq9Du+f8K
 9XbNxwpzI/vXdI9Q2IwrkyLQbY1JWIWfIfT8KLrVdgmBE8NY/4guDdxUtJjZI/TXPUCm XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbs3u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFblxn025235;
	Wed, 24 Apr 2024 15:48:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fayx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoa008769;
	Wed, 24 Apr 2024 15:48:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-7;
	Wed, 24 Apr 2024 15:48:43 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 06/13] kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
Date: Wed, 24 Apr 2024 16:47:59 +0100
Message-Id: <20240424154806.3417662-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-GUID: 8oGCX-aI0byMvPQkObqRWN0SBLzRuGJ5
X-Proofpoint-ORIG-GUID: 8oGCX-aI0byMvPQkObqRWN0SBLzRuGJ5

The btf_features list can be used for pahole v1.26 and later -
it is useful because if a feature is not yet implemented it will
not exit with a failure message.  This will allow us to add feature
requests to the pahole options without having to check pahole versions
in future; if the version of pahole supports the feature it will be
added.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 82377e470aed..8e6a9d4b492e 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
 pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
 
-pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
-
 pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
+# Switch to using --btf_features for v1.26 and later.
+pahole-flags-$(call test-ge, $(pahole-ver), 126)	= -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
+
+pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
-- 
2.31.1


