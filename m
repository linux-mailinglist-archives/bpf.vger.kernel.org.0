Return-Path: <bpf+bounces-28391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55D98B8F35
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A541C21397
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01A91386A6;
	Wed,  1 May 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlXAMInP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816858495
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585869; cv=none; b=lxFHOZNmd0fU8PqgTtOhUKGCWrC+OcutofkKUVCJsE7JMSBO9ofm2sTa9dbf80BICLkwfFdg9Kd9ejZ9aV46i7fsClU/nzfkNghXg7xcBzQpANttbfdlqlUvK/BQ3gfjE/NkjwowIsZ71C4Vyieos8uJDoc8XCqGsp09ATYuDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585869; c=relaxed/simple;
	bh=DVTveGaiMH+fq54H87IHnsQ6o/agiJ8AwYiDT7T6U7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDgm2SbaQbwxfHX1FnKXNC62otWGIxjx2BGe0cHk4oBpziCisov3Pow5tpP8/9NeqO4t5VQllbC5+eZwVnVUc9RZbAKCwxQvtEr01pgCdnpFt7+LYEqx5q9XQWnIqHfJnN7HaPmA79JQH4aKkTvWaG0B7DUdugokkIB/C+RUF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VlXAMInP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ASPvJ026168;
	Wed, 1 May 2024 17:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=J/NGHENwfT7zqQDVX6/iQ7/7n7U2feA1F3th/2sf/wI=;
 b=VlXAMInP3K86TC07LVrlrK2w4I8t1KRuYjZGQhoccK3wFdIuqiEFIP2ZhvhsPqvcxImV
 wg3GxJySkR2I67A5fB92V2nO1voNDqC53Oz6xVZvRGK9+4MbbDRfp/IYik6sLiqoLoae
 5GMOP09wt5f7agar7X4tqfxDZEFWDI0SAFVqbiEBhO7gSd18lGR01s8PY/+LzgevUwTL
 2cBT4WDGTOFozCRJ4z4jemwKK/PMVOUbC+mWVD5e692dlautWhC6eevNWMFlO4OYZgTr
 kTpSJ+3FOpTrWsRttDGS3eqdrJsVB9JJEYZDKR6awjZQ4oEtH+Yd3gQQl41qouRshpjq Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54fqm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:50:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441GnBvW008544;
	Wed, 1 May 2024 17:50:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt9ny3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:50:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 441HoedP002856;
	Wed, 1 May 2024 17:50:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-178-151.vpn.oracle.com [10.175.178.151])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xrqt9ny0h-1;
	Wed, 01 May 2024 17:50:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
Date: Wed,  1 May 2024 18:50:35 +0100
Message-Id: <20240501175035.2476830-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010125
X-Proofpoint-ORIG-GUID: 0sOIpQihPrmZmyKFdB75W6QW9NwDZ86n
X-Proofpoint-GUID: 0sOIpQihPrmZmyKFdB75W6QW9NwDZ86n

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
2.39.3


