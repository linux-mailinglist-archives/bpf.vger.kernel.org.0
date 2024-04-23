Return-Path: <bpf+bounces-27565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE668AF366
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B501F25D76
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6413CA89;
	Tue, 23 Apr 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5q/fSP3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2BC13CA80;
	Tue, 23 Apr 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888140; cv=none; b=bRGHlGqqSeL4n/UZAHrQbwPR4PuXB6kCepNGGQQI9sOWQUnHKkiPMoZmbWVgeDocW+SS6vJwac6Y7cc8DZxM95vl1aHQ9gByEr/DhhVFjrDQbtmYH9keRdEGFw7E9nJRt8Eg5sq2Zcc9qfqmj5JjNHhy5r4+OxZfhXplvcmZ/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888140; c=relaxed/simple;
	bh=8Pm6NKfvoYmQpG1YvzbH3rOdRyzi2MHcqI/xIrGbviw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQqDFgWFTQuQ8TUlVTQ4TQXU+mjZU5Q0s5cDqQObI2q5LaTuCcwFJ24xUkt8xL/t7BtPvLxzCsinTALC89RemyjAZIYt3+wEmSHi8p2zPSoauQuJtt3rrRqVQbEheLrW99y3otvdf1YVy9sDmTGv0UDowEb+72BeKn1UUJUcbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5q/fSP3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFUc6r008187;
	Tue, 23 Apr 2024 16:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=mL/PC2PjiG6JB1/KepJt+0C8rOjahRZABcdOMjzDD7k=;
 b=m5q/fSP34ry3suOJn5j1qc/TOGGDlcKjajLqLKAT/fC8UIQTAZY/E7Ldr+sgNj/mfL1M
 xh5oVUqz4h452a90cJ+yJN1Es3wGfG41l3B5qQgX4ssv1QbqF+DM74dMqHoMAxKq68qg
 Hee3A8appeZHU+YaIDzfbDlFmJYVCq7upLgFKRZw+URu//Y2hidfcCr51Sdqywev17zb
 H5UHF/JHmdqDu5vUBUrJih1sZM8XoXjAdzP+zC+gwBogProd2kqcFq6e/hGQPu9KZuy0
 l1LaN2hrbRb1CCZNC9gXVCe8X1qY11JKLqL3N9CzqJAVfXqUX+nyAI0+S/lVKeN7cCMG 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbpaps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:02:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFMBDv019834;
	Tue, 23 Apr 2024 16:02:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf3e6xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:02:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NG24nV038435;
	Tue, 23 Apr 2024 16:02:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-44.vpn.oracle.com [10.175.173.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xpbf3e6pt-2;
	Tue, 23 Apr 2024 16:02:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dxu@dxuuu.xyz, dwarves@vger.kernel.org, andrii.nakryiko@gmail.com,
        jolsa@kernel.org, williams@redhat.com, kcarcia@redhat.com,
        bpf@vger.kernel.org, eddyz87@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] pahole: replace use of "all" with "default" for --btf_features
Date: Tue, 23 Apr 2024 17:01:59 +0100
Message-Id: <20240423160200.3139270-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240423160200.3139270-1-alan.maguire@oracle.com>
References: <20240423160200.3139270-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230037
X-Proofpoint-GUID: 5hYXP-I0bOJ5tiPLEP1e3sjBrUU3ftF4
X-Proofpoint-ORIG-GUID: 5hYXP-I0bOJ5tiPLEP1e3sjBrUU3ftF4

It is confusing that --btf_features allows specification of "all"
features and additional non-standard features like "reproducible_build"
so rename "all" to "default".  To make the code clearer, avoid other
references to default values of --btf_features values, replacing these
with references to the initial value.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 |  4 +--
 pahole.c           | 75 ++++++++++++++++++++++++----------------------
 2 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 64de343..92ebf8f 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
 
 .TP
 .B \-\-btf_features=FEATURE_LIST
-Encode BTF using the specified feature list, or specify 'all' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
+Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
 
 .nf
 	encode_force       Ignore invalid symbols when encoding BTF; for example
@@ -310,7 +310,7 @@ Encode BTF using the specified feature list, or specify 'all' for all standard f
 	                   in different CUs.
 .fi
 
-Supported non-standard features (not enabled for 'all')
+Supported non-standard features (not enabled for 'default')
 
 .nf
 	reproducible_build Ensure generated BTF is consistent every time;
diff --git a/pahole.c b/pahole.c
index 38cc636..8458475 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1239,11 +1239,11 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_reproducible_build 345
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
- * a list of requested BTF features or "all" to enable all features.
- * These are translated into the appropriate conf_load values via a
- * struct btf_feature which specifies the associated conf_load
- * boolean field and whether its default (representing the feature being
- * off) is false or true.
+ * a list of requested BTF features or "default" to enable all default
+ * features. These are translated into the appropriate conf_load values
+ * via a struct btf_feature which specifies the associated conf_load
+ * boolean field and whether its initial value (representing the feature
+ * being off) is false or true.
  *
  * btf_features is for opting _into_ features so for a case like
  * conf_load->btf_gen_floats, the translation is simple; the presence
@@ -1262,51 +1262,54 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
  * --btf_features are enabled, and if a feature is not specified,
  * it is disabled.
  *
- * If --btf_features is not used, the usual pahole defaults for
+ * If --btf_features is not used, the usual pahole values for
  * BTF encoding apply; we encode type/decl tags, do not encode
  * floats, etc.  This ensures backwards compatibility.
  */
-#define BTF_FEATURE(name, alias, default_value, enable_for_all)		\
-	{ #name, #alias, &conf_load.alias, default_value, enable_for_all }
+#define BTF_DEFAULT_FEATURE(name, alias, initial_value)		\
+	{ #name, #alias, &conf_load.alias, initial_value, true }
+
+#define BTF_NON_DEFAULT_FEATURE(name, alias, initial_value)	\
+	{ #name, #alias, &conf_load.alias, initial_value, false }
 
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
 	bool		*conf_value;
-	bool		default_value;
-	bool		enable_for_all;	/* some nonstandard features may not
-					 * be enabled for --btf_features=all
-					 */
+	bool		initial_value;
+	bool		default_enabled;	/* some nonstandard features may not
+						 * be enabled for --btf_features=default
+						 */
 } btf_features[] = {
-	BTF_FEATURE(encode_force, btf_encode_force, false, true),
-	BTF_FEATURE(var, skip_encoding_btf_vars, true, true),
-	BTF_FEATURE(float, btf_gen_floats, false, true),
-	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true, true),
-	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true, true),
-	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true, true),
-	BTF_FEATURE(optimized_func, btf_gen_optimized, false, true),
-	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false, true),
-	BTF_FEATURE(reproducible_build, reproducible_build, false, false),
+	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
+	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
+	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
+	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
+	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
+	BTF_DEFAULT_FEATURE(enum64, skip_encoding_btf_enum64, true),
+	BTF_DEFAULT_FEATURE(optimized_func, btf_gen_optimized, false),
+	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
 
-bool set_btf_features_defaults;
+bool set_btf_features_initial;
 
 static void init_btf_features(void)
 {
 	int i;
 
-	/* Only set default values once, as multiple --btf_features=
-	 * may be specified on command-line, and setting defaults
+	/* Only set initial values once, as multiple --btf_features=
+	 * may be specified on command-line, and setting values
 	 * again could clobber values.   The aim is to enable
 	 * all features set across all --btf_features options.
 	 */
-	if (set_btf_features_defaults)
+	if (set_btf_features_initial)
 		return;
 	for (i = 0; i < ARRAY_SIZE(btf_features); i++)
-		*btf_features[i].conf_value = btf_features[i].default_value;
-	set_btf_features_defaults = true;
+		*btf_features[i].conf_value = btf_features[i].initial_value;
+	set_btf_features_initial = true;
 }
 
 static struct btf_feature *find_btf_feature(char *name)
@@ -1322,10 +1325,10 @@ static struct btf_feature *find_btf_feature(char *name)
 
 static void enable_btf_feature(struct btf_feature *feature)
 {
-	/* switch "default-off" features on, and "default-on" features
-	 * off; i.e. negate the default value.
+	/* switch "initial-off" features on, and "initial-on" features
+	 * off; i.e. negate the initial value.
 	 */
-	*feature->conf_value = !feature->default_value;
+	*feature->conf_value = !feature->initial_value;
 }
 
 static void show_supported_btf_features(FILE *output)
@@ -1351,11 +1354,11 @@ static void parse_btf_features(const char *features, bool strict)
 
 	init_btf_features();
 
-	if (strcmp(features, "all") == 0) {
+	if (strcmp(features, "default") == 0) {
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
-			if (btf_features[i].enable_for_all)
+			if (btf_features[i].default_enabled)
 				enable_btf_feature(&btf_features[i]);
 		}
 		return;
@@ -1367,10 +1370,10 @@ static void parse_btf_features(const char *features, bool strict)
 		struct btf_feature *feature = find_btf_feature(feature_name);
 
 		if (!feature) {
-			/* --btf_features=all,nonstandard_feature should be
+			/* --btf_features=default,nonstandard_feature should be
 			 * allowed.
 			 */
-			if (strcmp(feature_name, "all") == 0) {
+			if (strcmp(feature_name, "default") == 0) {
 				parse_btf_features(feature_name, strict);
 			} else if (strict) {
 				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
@@ -1819,7 +1822,7 @@ static const struct argp_option pahole__options[] = {
 		.name = "btf_features",
 		.key = ARGP_btf_features,
 		.arg = "FEATURE_LIST",
-		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
+		.doc = "Specify supported BTF features in FEATURE_LIST or 'default' for default set of supported features. See the pahole manual page for the list of supported, default features."
 	},
 	{
 		.name = "supported_btf_features",
@@ -1830,7 +1833,7 @@ static const struct argp_option pahole__options[] = {
 		.name = "btf_features_strict",
 		.key = ARGP_btf_features_strict,
 		.arg = "FEATURE_LIST_STRICT",
-		.doc = "Specify supported BTF features in FEATURE_LIST_STRICT or 'all' for all supported features.  Unlike --btf_features, unrecognized features will trigger an error."
+		.doc = "Specify supported BTF features in FEATURE_LIST_STRICT or 'default' for default set of supported features.  Unlike --btf_features, unrecognized features will trigger an error."
 	},
 	{
 		.name = "reproducible_build",
-- 
2.39.3


