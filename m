Return-Path: <bpf+bounces-12570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AA7CDBA7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A565C2811D7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C334CC7;
	Wed, 18 Oct 2023 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FL1EtxtO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873234CD3
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 12:30:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0366510E
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 05:30:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBJJA3000459;
	Wed, 18 Oct 2023 12:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=O6yT2s/6stDr9E3FfdiwCAqiH2JkEkduSx+rUMiK6JI=;
 b=FL1EtxtONUsSo4TF21R17yxf6xoEjUwIwDuraQ2o5NRKsBBu+fPvV5ZmM62LFkP2oe/E
 8BRYYxo3OIomkMDXteGLSHBZ5am29ESAMXcPTv8/rH3/6cQDY5afMLwnWIN4uXwMrHU7
 letruPThT+7uY72kS+alRy+X0rOmpmRTe54kwRP8lYYe0lnocP3bDeeiXAiOPt1xxWlV
 +E7jUb/mUGrRsKmDBikq+bVlAMsX/I3jMobJ+TwoSYklg7wCvNr/nNmO/f8hICWWY7oo
 9FeHYhJazhbwa/P8m4vvLyPs27vn2SO5hgSWSQn7AqXM7cPmgQcioW32sR0Y4ClX1mJl Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jqds1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBRB9g040453;
	Wed, 18 Oct 2023 12:29:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfynp8r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ICTUEc034930;
	Wed, 18 Oct 2023 12:29:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-178-90.vpn.oracle.com [10.175.178.90])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trfynp8bs-6;
	Wed, 18 Oct 2023 12:29:53 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 dwarves 5/5] pahole: add --btf_features_strict to reject unknown BTF features
Date: Wed, 18 Oct 2023 13:29:26 +0100
Message-Id: <20231018122926.735416-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018122926.735416-1-alan.maguire@oracle.com>
References: <20231018122926.735416-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_11,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180103
X-Proofpoint-GUID: KodrxNugFLyBxxWRg9XiCxQ03l8WFuPU
X-Proofpoint-ORIG-GUID: KodrxNugFLyBxxWRg9XiCxQ03l8WFuPU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index b5790be..2b6c965 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1231,6 +1231,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
 #define ARGP_supported_btf_features 342
+#define ARGP_btf_features_strict 343
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1335,7 +1336,7 @@ static void show_supported_btf_features(FILE *output)
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
  */
-static void parse_btf_features(const char *features)
+static void parse_btf_features(const char *features, bool strict)
 {
 	char *feature_list[BTF_MAX_FEATURES] = {};
 	char *saveptr = NULL, *s, *t;
@@ -1361,6 +1362,12 @@ static void parse_btf_features(const char *features)
 		struct btf_feature *feature = find_btf_feature(feature_list[i]);
 
 		if (!feature) {
+			if (strict) {
+				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
+					feature_list[i], features);
+				show_supported_btf_features(stderr);
+				exit(EXIT_FAILURE);
+			}
 			if (global_verbose)
 				fprintf(stderr, "Ignoring unsupported feature '%s'\n",
 					feature_list[i]);
@@ -1802,6 +1809,12 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_supported_btf_features,
 		.doc = "Show list of btf_features supported by pahole and exit."
 	},
+	{
+		.name = "btf_features_strict",
+		.key = ARGP_btf_features_strict,
+		.arg = "FEATURE_LIST_STRICT",
+		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features.  Unlike --btf_features, unrecognized features will trigger an error."
+	},
 	{
 		.name = NULL,
 	}
@@ -1947,7 +1960,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_btf_gen_floats:
 		conf_load.btf_gen_floats = true;	break;
 	case ARGP_btf_gen_all:
-		parse_btf_features("all");		break;
+		parse_btf_features("all", false);	break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -1978,9 +1991,11 @@ static error_t pahole__options_parser(int key, char *arg,
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


