Return-Path: <bpf+bounces-28834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B668BE4F1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380621F21D07
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391815FD04;
	Tue,  7 May 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HuocmY+T"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579815E811
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090147; cv=none; b=WZeqnyxzA6kTppCP9Ue/1eyZoQGEjWrEdKwba5JQQN16rW8Q3aLDmMOYcawPzokrtiXQI/WBVuX0JEOZZHzKYuhV5aJE1qU620vJDqM1KOZu9aBjWa2RzSZ3gutwvrNvFRsLMQcaikzmn+xO1A4CynQnUb1e70HciOnMa5xZJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090147; c=relaxed/simple;
	bh=U8ElifmH5aFcxo0w1sGpqzRlbDJ0c5/TvacITQ69yuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDAW0cRI2hKnZUt/qGYO7db0NWQ10I2+s28zw9yzOBuoZ3hxN5bvzYkkKZwImh5RKIPYArY3NYP2EbPm0PQx02AL3DT5lp1ARQeUmJMAGbxC5LM0BWpkNQniqp/3ATezilkUZJTsoZB/9J17n0F30oChjObu1r9x6xD7j4ZkyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HuocmY+T; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44793vWv020787;
	Tue, 7 May 2024 13:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=YRjjAfky7n2W5UBCzIn+vWuJfK9ASEBQhvfr/7Q8bm4=;
 b=HuocmY+T35T2fHCHgByrK+uSmrbS9CJfzjXugiMSiHKwQHLgFlz8d24GRSIKVjAI2c/G
 DFdfBq/eDMut9D9p2xAoIrnt8juBomDp+0jp8GvFQEdzwz/iBIRxAy3SzOv+XnEQ1iWn
 mw2MMIkcNYf8wKd6erZt6GcB+wRgvutPssxZbH7BW7X5CdmZK87Vg2dr2ZS6aPaBYshy
 WMYKaXt/5dtlX7SmCJG7Fntk670Vm5mfJgEHtKZWOhyMBHP+mKibZ4WljVZ2fHMV1E/Q
 qnevTUe3QANBa5JjOE6awDya1lwwq4vxAyEcVYrFYgpTBO39qVFv3AII/4ee/HfuHntN pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvd11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 13:55:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447DfIei014066;
	Tue, 7 May 2024 13:55:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7g3gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 13:55:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447DtJmr023689;
	Tue, 7 May 2024 13:55:19 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-215-214.vpn.oracle.com [10.175.215.214])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xwbf7g3c5-1;
	Tue, 07 May 2024 13:55:19 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next] kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
Date: Tue,  7 May 2024 14:55:14 +0100
Message-Id: <20240507135514.490467-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_07,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070096
X-Proofpoint-GUID: KAgVd1KYwTi2U435xThXsFqhOPTbHksf
X-Proofpoint-ORIG-GUID: KAgVd1KYwTi2U435xThXsFqhOPTbHksf

The btf_features list can be used for pahole v1.26 and later -
it is useful because if a feature is not yet implemented it will
not exit with a failure message.  This will allow us to add feature
requests to the pahole options without having to check pahole versions
in future; if the version of pahole supports the feature it will be
added.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 scripts/Makefile.btf | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 82377e470aed..2d6e5ed9081e 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -3,6 +3,8 @@
 pahole-ver := $(CONFIG_PAHOLE_VERSION)
 pahole-flags-y :=
 
+ifeq ($(call test-le, $(pahole-ver), 125),y)
+
 # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
 ifeq ($(call test-le, $(pahole-ver), 121),y)
 pahole-flags-$(call test-ge, $(pahole-ver), 118)	+= --skip_encoding_btf_vars
@@ -12,8 +14,17 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
 pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
 
-pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
+ifeq ($(pahole-ver), 125)
+pahole-flags-y	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
+endif
+
+else
 
-pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
+# Switch to using --btf_features for v1.26 and later.
+pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
+
+endif
+
+pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
-- 
2.39.3


