Return-Path: <bpf+bounces-11877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F57C4E5A
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912C41C20DBC
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110DF1B284;
	Wed, 11 Oct 2023 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aLG43kGt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D11A73C
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:18:12 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C449D91
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 02:18:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7mejX022735;
	Wed, 11 Oct 2023 09:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=eajcGv3Q0nZMWbEn/Kim6ne4hnfKLFcuDVWKEyoO2iM=;
 b=aLG43kGtpTNfQabWf+bsy7HuOulpxAxbcPwXx5a8eL6XIKFQ9SngvT5KhRr/JRbPvGPC
 EKz/ZP1QADGvNRQdz7tEzxVEXPGLYieiKFlhLWldd4h4+ARNxyacR00qlAsdvIccslTW
 R32rY0Jzdek+VuPbJoP80dyo15cTfbf4kqscEz74dCaOKubyU+Nm9AugaVIv9v4HfHnp
 GAFjs1496zYbFNDkwEfwIU7K9UuFrh0lIDXhbzw8Lh/Cy1T69scHET0pJm7yXyvGA6u0
 7YU0wSPN3pL/H8jGfDY4E7LrH5z1BZdnwKJIsn3P9/nN4OkWekIqsBl8mUIVM62RHhtI BA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43qc6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B8eHjf015032;
	Wed, 11 Oct 2023 09:17:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8d16q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B9Hbxo020344;
	Wed, 11 Oct 2023 09:17:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-173.vpn.oracle.com [10.175.183.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws8d0tb-4;
	Wed, 11 Oct 2023 09:17:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [RFC dwarves 3/4] pahole: add --btf_features=feature1[,feature2...] support
Date: Wed, 11 Oct 2023 10:17:31 +0100
Message-Id: <20231011091732.93254-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231011091732.93254-1-alan.maguire@oracle.com>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110081
X-Proofpoint-ORIG-GUID: 3AiKEQbUb6pG1NK3ZYsnWXq9tcS55vNL
X-Proofpoint-GUID: 3AiKEQbUb6pG1NK3ZYsnWXq9tcS55vNL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This allows consumers to specify an opt-in set of features
they want to use in BTF encoding.

Supported features are

	encode_force  Ignore invalid symbols when encoding BTF.
	var           Encode variables using BTF_KIND_VAR in BTF.
	float         Encode floating-point types in BTF.
	decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
	type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
	enum64        Encode enum64 values with BTF_KIND_ENUM64.
	optimized     Encode representations of optimized functions
	              with suffixes like ".isra.0" etc
	consistent    Avoid encoding inconsistent static functions.
	              These occur when a parameter is optimized out
	              in some CUs and not others, or when the same
	              function name has inconsistent BTF descriptions
	              in different CUs.

Specifying "--btf_features=all" is the equivalent to setting
all of the above.  If pahole does not know about a feature
it silently ignores it.  These properties allow us to use
the --btf_features option in the kernel pahole_flags.sh
script to specify the desired set of features.  If a new
feature is not present in pahole but requested, pahole
BTF encoding will not complain (but will not encode the
feature).

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 20 +++++++++++
 pahole.c           | 87 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index c1b48de..7c072dc 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -273,6 +273,26 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
 .B \-\-btf_gen_all
 Allow using all the BTF features supported by pahole.
 
+.TP
+.B \-\-btf_features=FEATURE_LIST
+Encode BTF using the specified feature list, or specify 'all' for all features supported.  This single parameter value can be used as an alternative to unsing multiple BTF-related options. Supported features are
+
+.nf
+	encode_force  Ignore invalid symbols when encoding BTF.
+	var           Encode variables using BTF_KIND_VAR in BTF.
+	float         Encode floating-point types in BTF.
+	decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
+	type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
+	enum64        Encode enum64 values with BTF_KIND_ENUM64.
+	optimized     Encode representations of optimized functions
+	              with suffixes like ".isra.0" etc
+	consistent    Avoid encoding inconsistent static functions.
+	              These occur when a parameter is optimized out
+	              in some CUs and not others, or when the same
+	              function name has inconsistent BTF descriptions
+	              in different CUs.
+.fi
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index 7a41dc3..4f00b08 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1229,6 +1229,83 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
+#define ARGP_btf_features	341
+
+/* --btf_features=feature1[,feature2,..] option allows us to specify
+ * opt-in features (or "all"); these are translated into conf_load
+ * values by specifying the associated bool offset and whether it
+ * is a skip option or not; btf_features is for opting _into_ features
+ * so for skip options we have to reverse the logic.  For example
+ * "--skip_encoding_btf_type_tag --btf_gen_floats" translate to
+ * "--btf_features=type_tag,float"
+ */
+#define BTF_FEATURE(name, alias, skip)				\
+	{ #name, #alias, offsetof(struct conf_load, alias), skip }
+
+struct btf_feature {
+	const char      *name;
+	const char      *option_alias;
+	size_t          conf_load_offset;
+	bool		skip;
+} btf_features[] = {
+	BTF_FEATURE(encode_force, btf_encode_force, false),
+	BTF_FEATURE(var, skip_encoding_btf_vars, true),
+	BTF_FEATURE(float, btf_gen_floats, false),
+	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
+	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
+	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
+	BTF_FEATURE(optimized, btf_gen_optimized, false),
+	/* the "skip" in skip_encoding_btf_inconsistent_proto is misleading
+	 * here; this is a positive feature to ensure consistency of
+	 * representation rather than a negative option which we want
+	 * to invert.  So as a result, "skip" is false here.
+	 */
+	BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, false),
+};
+
+#define BTF_MAX_FEATURES	32
+#define BTF_MAX_FEATURE_STR	256
+
+/* Translate --btf_features=feature1[,feature2] into conf_load values.
+ * Explicitly ignores unrecognized features to allow future specification
+ * of new opt-in features.
+ */
+static void parse_btf_features(const char *features, struct conf_load *conf_load)
+{
+	char *feature_list[BTF_MAX_FEATURES] = {};
+	char f[BTF_MAX_FEATURE_STR];
+	bool encode_all = false;
+	int i, j, n = 0;
+
+	strncpy(f, features, sizeof(f));
+
+	if (strcmp(features, "all") == 0) {
+		encode_all = true;
+	} else {
+		char *saveptr = NULL, *s = f, *t;
+
+		while ((t = strtok_r(s, ",", &saveptr)) != NULL) {
+			s = NULL;
+			feature_list[n++] = t;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);
+		bool match = encode_all;
+
+		if (!match) {
+			for (j = 0; j < n; j++) {
+				if (strcmp(feature_list[j], btf_features[i].name) == 0) {
+					match = true;
+					break;
+				}
+			}
+		}
+		if (match)
+			*bval = btf_features[i].skip ? false : true;
+	}
+}
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_skip_encoding_btf_inconsistent_proto,
 		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
 	},
+	{
+		.name = "btf_features",
+		.key = ARGP_btf_features,
+		.arg = "FEATURE_LIST",
+		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
+	},
 	{
 		.name = NULL,
 	}
@@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_btf_gen_floats:
 		conf_load.btf_gen_floats = true;	break;
 	case ARGP_btf_gen_all:
-		conf_load.btf_gen_floats = true;	break;
+		parse_btf_features("all", &conf_load);	break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_btf_features:
+		parse_btf_features(arg, &conf_load);	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


