Return-Path: <bpf+bounces-12992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CA7D2F41
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90ECB20EC7
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2602E14011;
	Mon, 23 Oct 2023 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWjkSriD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5713AE8
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:58:16 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B110C6
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:58:09 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6jxD7005447;
	Mon, 23 Oct 2023 09:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ARCRmRxammHldcsV9SzQM9FIPwy+t3ssksLZSriQi14=;
 b=KWjkSriDeUVgl06zKCh5jJUas/MPIX55jJ+eSztDolv8xY+HQFLQDS6pSaRLKbWh5nRj
 Xpwqq/RHucQOWz7ChDeEQf5T/CZjgSZOwlECTTEjQIsy50yvGXLn1Tigb1llv4c8nr0Y
 Jmhk4lbVyjehkZJHt9ZeiRy8yDLjxq2NE2TlSdhWpH+N0DBJHr9BilYcen4MzZUm47W5
 G2KFDoqwjEQs4ChSeAi3GqASYI7gGZDaQoDnIg4TBnuGuzfYrjiPwZoRtkwlKGuwTQwn
 hMt9ulvMD9TMYmb40sLXzK8IdHuIpWWvAp3/Shb4kCoJ7wo87gvMTdrgt1Wlul4PyZg0 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pctq8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:57:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39N8skvl001564;
	Mon, 23 Oct 2023 09:57:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53a8144-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:57:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39N9t2cR039213;
	Mon, 23 Oct 2023 09:57:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-206-92.vpn.oracle.com [10.175.206.92])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv53a80w0-4;
	Mon, 23 Oct 2023 09:57:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 dwarves 3/5] pahole: add --btf_features support
Date: Mon, 23 Oct 2023 10:57:24 +0100
Message-Id: <20231023095726.1179529-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231023095726.1179529-1-alan.maguire@oracle.com>
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230085
X-Proofpoint-GUID: C-v4VYtJ4pCNcS8utsAX5AFEVAPVPN5z
X-Proofpoint-ORIG-GUID: C-v4VYtJ4pCNcS8utsAX5AFEVAPVPN5z

This allows consumers to specify an opt-in set of features
they want to use in BTF encoding.

Supported features are a comma-separated combination of

	encode_force    Ignore invalid symbols when encoding BTF.
	var             Encode variables using BTF_KIND_VAR in BTF.
	float           Encode floating-point types in BTF.
	decl_tag        Encode declaration tags using BTF_KIND_DECL_TAG.
	type_tag        Encode type tags using BTF_KIND_TYPE_TAG.
	enum64          Encode enum64 values with BTF_KIND_ENUM64.
	optimized_func  Encode representations of optimized functions
	                with suffixes like ".isra.0" etc
	consistent_func Avoid encoding inconsistent static functions.
	                These occur when a parameter is optimized out
	                in some CUs and not others, or when the same
	                function name has inconsistent BTF descriptions
	                in different CUs.

Specifying "--btf_features=all" is the equivalent to setting
all of the above.  If pahole does not know about a feature
specified in --btf_features it silently ignores it.

The --btf_features can either be specified via a single comma-separated
list
	--btf_features=enum64,float

...or via multiple --btf_features values

	--btf_features=enum64 --btf_features=float

These properties allow us to use the --btf_features option in
the kernel scripts/pahole_flags.sh script to specify the desired
set of BTF features.

If a feature named in --btf_features is not present in the version
of pahole used, BTF encoding will not complain.  This is desired
because it means we no longer have to tie new features to a specific
pahole version.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 man-pages/pahole.1 |  24 +++++++++
 pahole.c           | 132 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index c1b48de..a09885f 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -273,6 +273,30 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
 .B \-\-btf_gen_all
 Allow using all the BTF features supported by pahole.
 
+.TP
+.B \-\-btf_features=FEATURE_LIST
+Encode BTF using the specified feature list, or specify 'all' for all features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported features are
+
+.nf
+	encode_force       Ignore invalid symbols when encoding BTF; for example
+	                   if a symbol has an invalid name, it will be ignored
+	                   and BTF encoding will continue.
+	var                Encode variables using BTF_KIND_VAR in BTF.
+	float              Encode floating-point types in BTF.
+	decl_tag           Encode declaration tags using BTF_KIND_DECL_TAG.
+	type_tag           Encode type tags using BTF_KIND_TYPE_TAG.
+	enum64             Encode enum64 values with BTF_KIND_ENUM64.
+	optimized_func     Encode representations of optimized functions
+	                   with suffixes like ".isra.0".
+	consistent_func    Avoid encoding inconsistent static functions.
+	                   These occur when a parameter is optimized out
+	                   in some CUs and not others, or when the same
+	                   function name has inconsistent BTF descriptions
+	                   in different CUs.
+.fi
+
+So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index 7a41dc3..fe1cc6a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1229,6 +1229,128 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
+#define ARGP_btf_features	341
+
+/* --btf_features=feature1[,feature2,..] allows us to specify
+ * a list of requested BTF features or "all" to enable all features.
+ * These are translated into the appropriate conf_load values via a
+ * struct btf_feature which specifies the associated conf_load
+ * boolean field and whether its default (representing the feature being
+ * off) is false or true.
+ *
+ * btf_features is for opting _into_ features so for a case like
+ * conf_load->btf_gen_floats, the translation is simple; the presence
+ * of the "float" feature in --btf_features sets conf_load->btf_gen_floats
+ * to true.
+ *
+ * The more confusing case is for features that are enabled unless
+ * skipping them is specified; for example
+ * conf_load->skip_encoding_btf_type_tag.  By default - to support
+ * the opt-in model of only enabling features the user asks for -
+ * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
+ * type_tags) and it is only set to false if --btf_features contains
+ * the "type_tag" keyword.
+ *
+ * So from the user perspective, all features specified via
+ * --btf_features are enabled, and if a feature is not specified,
+ * it is disabled.
+ *
+ * If --btf_features is not used, the usual pahole defaults for
+ * BTF encoding apply; we encode type/decl tags, do not encode
+ * floats, etc.  This ensures backwards compatibility.
+ */
+#define BTF_FEATURE(name, alias, default_value)			\
+	{ #name, #alias, &conf_load.alias, default_value }
+
+struct btf_feature {
+	const char      *name;
+	const char      *option_alias;
+	bool		*conf_value;
+	bool		default_value;
+} btf_features[] = {
+	BTF_FEATURE(encode_force, btf_encode_force, false),
+	BTF_FEATURE(var, skip_encoding_btf_vars, true),
+	BTF_FEATURE(float, btf_gen_floats, false),
+	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
+	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
+	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
+	BTF_FEATURE(optimized_func, btf_gen_optimized, false),
+	BTF_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
+};
+
+#define BTF_MAX_FEATURE_STR	1024
+
+bool set_btf_features_defaults;
+
+static void init_btf_features(void)
+{
+	int i;
+
+	/* Only set default values once, as multiple --btf_features=
+	 * may be specified on command-line, and setting defaults
+	 * again could clobber values.   The aim is to enable
+	 * all features set across all --btf_features options.
+	 */
+	if (set_btf_features_defaults)
+		return;
+	for (i = 0; i < ARRAY_SIZE(btf_features); i++)
+		*btf_features[i].conf_value = btf_features[i].default_value;
+	set_btf_features_defaults = true;
+}
+
+static struct btf_feature *find_btf_feature(char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		if (strcmp(name, btf_features[i].name) == 0)
+			return &btf_features[i];
+	}
+	return NULL;
+}
+
+static void enable_btf_feature(struct btf_feature *feature)
+{
+	/* switch "default-off" features on, and "default-on" features
+	 * off; i.e. negate the default value.
+	 */
+	*feature->conf_value = !feature->default_value;
+}
+
+/* Translate --btf_features=feature1[,feature2] into conf_load values.
+ * Explicitly ignores unrecognized features to allow future specification
+ * of new opt-in features.
+ */
+static void parse_btf_features(const char *features)
+{
+	char *saveptr = NULL, *s, *feature_name;
+	char f[BTF_MAX_FEATURE_STR];
+
+	init_btf_features();
+
+	if (strcmp(features, "all") == 0) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(btf_features); i++)
+			enable_btf_feature(&btf_features[i]);
+		return;
+	}
+
+	strncpy(f, features, sizeof(f));
+	s = f;
+	while ((feature_name = strtok_r(s, ",", &saveptr)) != NULL) {
+		struct btf_feature *feature = find_btf_feature(feature_name);
+
+		if (!feature) {
+			if (global_verbose)
+				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
+					feature_name);
+		} else {
+			enable_btf_feature(feature);
+		}
+		s = NULL;
+	}
+}
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1651,6 +1773,12 @@ static const struct argp_option pahole__options[] = {
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
@@ -1796,7 +1924,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_btf_gen_floats:
 		conf_load.btf_gen_floats = true;	break;
 	case ARGP_btf_gen_all:
-		conf_load.btf_gen_floats = true;	break;
+		parse_btf_features("all");		break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -1826,6 +1954,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_btf_features:
+		parse_btf_features(arg);		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


