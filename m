Return-Path: <bpf+bounces-12996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFB7D2F4B
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FEAB20F06
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011114008;
	Mon, 23 Oct 2023 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="czy1XQHW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00513AE8
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:58:43 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4701BC2
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:58:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6kNoK031080;
	Mon, 23 Oct 2023 09:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=CKAc975VH4SNdzKGqXFmts/x7DS5CY8Im0FpTv/76Vs=;
 b=czy1XQHWNSZb1+nOqE3A4kL00yIG/ABlxwe5HsXVdREoEhujGbLPJsYEIgzUQbNQ7dkk
 SHSD/6wpeWMOvJUGjEwla/2h/prM3ZoUKwlOADaAYFnuIt1dL0n25b1UohkPgVrR94x7
 LZok3n0e0wCPsIg5qrr7dWQBiXzR3dPP5Mwc3PGItvOFBFxIva8dLDzSQCf4tQUqHT/I
 wFAEcQCe/MXuxk5kgn5I9dt/1IkC7AuAutt+mjIJyInWCS675As9gkuFCcuFhbRFBuon
 bTeJGOMNJsqe1Dte2PGO9+mZIJ4DGPWc+/YDNm4vIleB4dJHKvSjPAH6YBtumUb18CHz 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tar13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:58:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7O37f001754;
	Mon, 23 Oct 2023 09:58:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53a81cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:58:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39N9t2cV039213;
	Mon, 23 Oct 2023 09:58:22 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-206-92.vpn.oracle.com [10.175.206.92])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv53a80w0-6;
	Mon, 23 Oct 2023 09:58:22 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 dwarves 5/5] pahole: add --btf_features_strict to reject unknown BTF features
Date: Mon, 23 Oct 2023 10:57:26 +0100
Message-Id: <20231023095726.1179529-6-alan.maguire@oracle.com>
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
 definitions=2023-10-23_08,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230086
X-Proofpoint-ORIG-GUID: qkUT3bN8QQcwzKZGtWhP_7EvOeZHTt4Y
X-Proofpoint-GUID: qkUT3bN8QQcwzKZGtWhP_7EvOeZHTt4Y

--btf_features is used to specify the list of requested features
for BTF encoding.  However, it is not strict in rejecting requests
with unknown features; this allows us to use the same parameters
regardless of pahole version.  --btf_features_strict carries out
the same encoding with the same feature set, but will fail if an
unrecognized feature is specified.

So

  pahole -J --btf_features=enum64,foo

will succeed, while

  pahole -J --btf_features_strict=enum64,foo

will not.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 21 ++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 6148915..ea9045c 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -297,6 +297,10 @@ Encode BTF using the specified feature list, or specify 'all' for all features s
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
 
+.TP
+.B \-\-btf_features_strict
+Identical to \-\-btf_features above, but pahole will exit if it encounters an unrecognized feature.
+
 .TP
 .B \-\-supported_btf_features
 Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
diff --git a/pahole.c b/pahole.c
index 37fd2a4..768a2fe 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1231,6 +1231,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
 #define ARGP_supported_btf_features 342
+#define ARGP_btf_features_strict 343
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1334,7 +1335,7 @@ static void show_supported_btf_features(FILE *output)
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
  */
-static void parse_btf_features(const char *features)
+static void parse_btf_features(const char *features, bool strict)
 {
 	char *saveptr = NULL, *s, *feature_name;
 	char f[BTF_MAX_FEATURE_STR];
@@ -1355,6 +1356,12 @@ static void parse_btf_features(const char *features)
 		struct btf_feature *feature = find_btf_feature(feature_name);
 
 		if (!feature) {
+			if (strict) {
+				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
+					feature_name, features);
+				show_supported_btf_features(stderr);
+				exit(EXIT_FAILURE);
+			}
 			if (global_verbose)
 				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
 					feature_name);
@@ -1797,6 +1804,12 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_supported_btf_features,
 		.doc = "Show list of btf_features supported by pahole and exit."
 	},
+	{
+		.name = "btf_features_strict",
+		.key = ARGP_btf_features_strict,
+		.arg = "FEATURE_LIST_STRICT",
+		.doc = "Specify supported BTF features in FEATURE_LIST_STRICT or 'all' for all supported features.  Unlike --btf_features, unrecognized features will trigger an error."
+	},
 	{
 		.name = NULL,
 	}
@@ -1942,7 +1955,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_btf_gen_floats:
 		conf_load.btf_gen_floats = true;	break;
 	case ARGP_btf_gen_all:
-		parse_btf_features("all");		break;
+		parse_btf_features("all", false);	break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -1973,9 +1986,11 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	case ARGP_btf_features:
-		parse_btf_features(arg);		break;
+		parse_btf_features(arg, false);		break;
 	case ARGP_supported_btf_features:
 		show_supported_btf_features(stdout);	exit(0);
+	case ARGP_btf_features_strict:
+		parse_btf_features(arg, true);		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


