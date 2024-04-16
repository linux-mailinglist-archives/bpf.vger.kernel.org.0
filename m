Return-Path: <bpf+bounces-26977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A68A6E85
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 16:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1005B1C20363
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A912D203;
	Tue, 16 Apr 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HgLLvV9k"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CE3B78D;
	Tue, 16 Apr 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278255; cv=none; b=c6HO9zYHDIaN+Eu87OeFEXemzZNwrBYhvccSdtCJq8Eotdi0+zs5pBDtXrjS9fxydKaz8V4pS3f6+MWFnPWDrCFvq6VJ9asSk3Ux2847mRiXKpjaPWWLWYU9eUV/Mu6b2WrFESUpTLc7qs0eN9ZhJN7ig/m7JWe28rVohJuOBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278255; c=relaxed/simple;
	bh=/J3FmCK0rgHy8ybrr1I6D1P3XG2Sc9Qx2HMYTGkJUpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZ3F0ZvQ4zKW+g1PUjdqjxXtg+sl6TwO5FH50sNE3rQ7i1Beo228R5U9OQdunhfcHUpjB4XH4H8inso9oR1brZEph7rfJKqH4NSKg/eNkJJmG0Fts6jsRypg13Gge2P4tQTcYW8EALaEjzU82YUztHaLcRqIUGrPdlpBIZfanDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HgLLvV9k; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEPMD8025111;
	Tue, 16 Apr 2024 14:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=SXm+sgYR3oh/NqyZEk8C2yicgyKUlGU4WPY/VEMWVbE=;
 b=HgLLvV9k0R37n8mxODvvCvh/DOaAvBcjdQsYP+mhb5Lvlnp2BRhYuYN2YC3lMWGXyYwb
 ad4M/1XsDrI0LzdzREsDpmwk78uKPsKubWmXwHtA9Bd9HOzk2q504wUXBuB3YJ5Kz8Ml
 J5Rt24k4FKAhZBzvi056o3khBUs9v04t8VKKym1PFUb1f4zzbT/YE6tc/5s6JudN04vu
 alAmfCZY9AmL/yB/xqvv9KpOYkTMoE52goeJNFq4hY3ydv2q9wDLJuOWlPdUy/pk/SZ+
 D8dgHaKiRxPIZuIlR7IuX2uMmS5ZuaxXFdLX4x+y3XVFFcC0IRQVOJ7xCRxlBnY7V/k6 QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbnb62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEQhau029216;
	Tue, 16 Apr 2024 14:37:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg7an68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:37:25 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GEbMeq029885;
	Tue, 16 Apr 2024 14:37:24 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-210-77.vpn.oracle.com [10.175.210.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xfgg7an1y-2;
	Tue, 16 Apr 2024 14:37:24 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, williams@redhat.com,
        kcarcia@redhat.com, bpf@vger.kernel.org, kuifeng@fb.com,
        linux@weissschuh.net, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/3] pahole: allow --btf_features to not participate in "all"
Date: Tue, 16 Apr 2024 15:37:16 +0100
Message-Id: <20240416143718.2857981-2-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: j3KX_LqGoGmcjXYHvHlEiernDMu6SJIW
X-Proofpoint-GUID: j3KX_LqGoGmcjXYHvHlEiernDMu6SJIW

Specifying --btf_features=all enables all supported BTF features.
However there are some features that are non-standard, so we should
support a way to use them in --btf_features but not participate in
the set of features enabled by "--btf_features=all".  As part of this,
also support all used in a list of --btf_features, i.e.

--btf_features=all,nonstandard_feature

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 |  2 +-
 pahole.c           | 36 +++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 2be165d..2c08e97 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
 
 .TP
 .B \-\-btf_features=FEATURE_LIST
-Encode BTF using the specified feature list, or specify 'all' for all features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported features are
+Encode BTF using the specified feature list, or specify 'all' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
 
 .nf
 	encode_force       Ignore invalid symbols when encoding BTF; for example
diff --git a/pahole.c b/pahole.c
index 77772bb..890ef81 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1266,23 +1266,26 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
  * BTF encoding apply; we encode type/decl tags, do not encode
  * floats, etc.  This ensures backwards compatibility.
  */
-#define BTF_FEATURE(name, alias, default_value)			\
-	{ #name, #alias, &conf_load.alias, default_value }
+#define BTF_FEATURE(name, alias, default_value, enable_for_all)		\
+	{ #name, #alias, &conf_load.alias, default_value, enable_for_all }
 
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
 	bool		*conf_value;
 	bool		default_value;
+	bool		enable_for_all;	/* some nonstandard features may not
+					 * be enabled for --btf_features=all
+					 */
 } btf_features[] = {
-	BTF_FEATURE(encode_force, btf_encode_force, false),
-	BTF_FEATURE(var, skip_encoding_btf_vars, true),
-	BTF_FEATURE(float, btf_gen_floats, false),
-	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
-	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
-	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
-	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
-	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_FEATURE(encode_force, btf_encode_force, false, true),
+	BTF_FEATURE(var, skip_encoding_btf_vars, true, true),
+	BTF_FEATURE(float, btf_gen_floats, false, true),
+	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true, true),
+	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true, true),
+	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
+	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
+	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1350,8 +1353,10 @@ static void parse_btf_features(const char *features, bool strict)
 	if (strcmp(features, "all") == 0) {
 		int i;
 
-		for (i = 0; i < ARRAY_SIZE(btf_features); i++)
-			enable_btf_feature(&btf_features[i]);
+		for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+			if (btf_features[i].enable_for_all)
+				enable_btf_feature(&btf_features[i]);
+		}
 		return;
 	}
 
@@ -1361,7 +1366,12 @@ static void parse_btf_features(const char *features, bool strict)
 		struct btf_feature *feature = find_btf_feature(feature_name);
 
 		if (!feature) {
-			if (strict) {
+			/* --btf_features=all,nonstandard_feature should be
+			 * allowed.
+			 */
+			if (strcmp(feature_name, "all") == 0) {
+				parse_btf_features(feature_name, strict);
+			} else if (strict) {
 				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
 					feature_name, features);
 				show_supported_btf_features(stderr);
-- 
2.39.3


