Return-Path: <bpf+bounces-12151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8F87C88C1
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 17:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7262B282680
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A671BDC6;
	Fri, 13 Oct 2023 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cm5Suswz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3C1BDCB
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:34:55 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED10C9
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 08:34:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE104a008364;
	Fri, 13 Oct 2023 15:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=gY94pJSHRagajNxajx9yM1DlQiAHwkeqs/ssayIbW4Y=;
 b=cm5SuswzM6wDNfmu0vtGLq0idHdxPOREhhm+5HHfbNPrG9hLrPTfSwtbtTg0/oR0zUr8
 wlKJWNDy5GO3OW9IfYUhrck4coXzo5oArppX829dfSL6tXfIXNkf4DSKzVw5VodR+pz9
 grBMplhOtwyZ4btSByAWdwtM0haax37EnTEMTXJipCJLkl6Ax7gbpAkLS6TTVnCeTFD+
 nLByQh+dBRt4EhPT9ZOvpeHLYjhhqJ2JjdJvrr0HhuIWFlhkO+9wboZN28NsOBzU15LC
 o2rLxLs1CKXcWIjLYuQ/pRRw0jtpz0AgLBTTLY9w3bw1qjLoEHSUD/6aMDV/QF2qMW0b VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuw8uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 15:34:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DErKnJ039960;
	Fri, 13 Oct 2023 15:34:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0u1xt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 15:34:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DFY4GZ030819;
	Fri, 13 Oct 2023 15:34:25 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-179.vpn.oracle.com [10.175.183.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tpt0u1x9h-6;
	Fri, 13 Oct 2023 15:34:25 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves 5/5] pahole: add --btf_features_strict to reject unknown BTF features
Date: Fri, 13 Oct 2023 16:33:59 +0100
Message-Id: <20231013153359.88274-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231013153359.88274-1-alan.maguire@oracle.com>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130132
X-Proofpoint-ORIG-GUID: o42RKqjcgIi4ZCIq0sAA1hKwwHdgga53
X-Proofpoint-GUID: o42RKqjcgIi4ZCIq0sAA1hKwwHdgga53
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
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

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
index 816525a..e2a2440 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1231,6 +1231,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
 #define ARGP_supported_btf_features 342
+#define ARGP_btf_features_strict 343
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1288,7 +1289,7 @@ bool set_btf_features_defaults;
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
  */
-static void parse_btf_features(const char *features)
+static void parse_btf_features(const char *features, bool strict)
 {
 	char *feature_list[BTF_MAX_FEATURES] = {};
 	char f[BTF_MAX_FEATURE_STR];
@@ -1325,6 +1326,11 @@ static void parse_btf_features(const char *features)
 					break;
 				}
 			}
+			if (strict && !match) {
+				fprintf(stderr, "Feature in '%s' is not supported.  'pahole --supported_btf_features' shows the list of features supported.\n",
+					features);
+				exit(EXIT_FAILURE);
+			}
 		}
 		/* switch "default-off" features on, and "default-on" features
 		 * off; i.e. negate the default value.
@@ -1779,6 +1785,12 @@ static const struct argp_option pahole__options[] = {
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
@@ -1924,7 +1936,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_btf_gen_floats:
 		conf_load.btf_gen_floats = true;	break;
 	case ARGP_btf_gen_all:
-		parse_btf_features("all");		break;
+		parse_btf_features("all", false);	break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -1955,9 +1967,11 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	case ARGP_btf_features:
-		parse_btf_features(arg);		break;
+		parse_btf_features(arg, false);		break;
 	case ARGP_supported_btf_features:
 		show_supported_btf_features();		exit(0);
+	case ARGP_btf_features_strict:
+		parse_btf_features(arg, true);		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


