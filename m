Return-Path: <bpf+bounces-11878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BED7C4E5C
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCA32822EB
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9641BDC0;
	Wed, 11 Oct 2023 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D34f4R2N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA61A73C
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:18:17 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E49D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 02:18:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7mndu024527;
	Wed, 11 Oct 2023 09:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=A6/0cVn28UHjX9zhN5PN3/Pe62BjfanR3vk+CHslrSA=;
 b=D34f4R2NCMi5fjQccBYsTk2oxYX+q6xh23puvWGDgN0FxDoULjhZrBjGJnXmS57lMTz6
 wSV/PDQ205QtHJ6tzv+oKt5zlPYZOe6lQg/Bm6mqy60hkJ4X7Rfd4rd228F+P3rSp+j2
 LSsY3MLfyuugko+ZWtaryCHOXnfx+/RC0fYscAXDf0i1jsUFs4Imb+pIsLDcRhvFbAFj
 gVJ6r1Hq/hhomP2mFat1CZQC2Wwv0zn8fMB3d8OGKAfLZ73MiAIMLAa5VVfG+Ua768Tg
 7DDYRyL1mryVOFOHN3Z8h0qVH+vKCfAnVhNIYuZoCcQu0jffoCMjNBXgy1wSSOZrkZbZ pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu7ax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B8ahud014884;
	Wed, 11 Oct 2023 09:17:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8d18w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B9Hbxq020344;
	Wed, 11 Oct 2023 09:17:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-173.vpn.oracle.com [10.175.183.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws8d0tb-5;
	Wed, 11 Oct 2023 09:17:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 4/4] pahole: add --supported_btf_features to display feature support
Date: Wed, 11 Oct 2023 10:17:32 +0100
Message-Id: <20231011091732.93254-5-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: 5GoR8uNTMnFnMzis8WM0SySJHNa9Ze5p
X-Proofpoint-ORIG-GUID: 5GoR8uNTMnFnMzis8WM0SySJHNa9Ze5p
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By design --btf_features=FEATURE1[,FEATURE2,...] will not complain
if an unrecognized feature is specified.  This allows the kernel
build process to specify new features regardless of whether they
are supported by the version of pahole used; in such cases we do
not wish for every invocation of pahole to complain.  However it is
still valuable to have a way of knowing which BTF features pahole
supports; this could be logged as part of the build process for
example.  By specifying --supported_btf_features a comma-separated
list is returned; for example:

 $ pahole --supported_btf_features
 encode_force,var,float,decl_tag,type_tag,enum64,optimized,consistent

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 7c072dc..b094195 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -293,6 +293,10 @@ Encode BTF using the specified feature list, or specify 'all' for all features s
 	              in different CUs.
 .fi
 
+.TP
+.B \-\-supported_btf_features
+Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index 4f00b08..e828961 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1230,6 +1230,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
+#define ARGP_supported_btf_features 342
 
 /* --btf_features=feature1[,feature2,..] option allows us to specify
  * opt-in features (or "all"); these are translated into conf_load
@@ -1307,6 +1308,19 @@ static void parse_btf_features(const char *features, struct conf_load *conf_load
 	}
 }
 
+static void show_supported_btf_features(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		if (i > 0)
+			printf(",");
+		printf("%s", btf_features[i].name);
+	}
+	printf("\n");
+	exit(0);
+}
+
 static const struct argp_option pahole__options[] = {
 	{
 		.name = "bit_holes",
@@ -1734,6 +1748,11 @@ static const struct argp_option pahole__options[] = {
 		.arg = "FEATURE_LIST",
 		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
 	},
+	{
+		.name = "supported_btf_features",
+		.key = ARGP_supported_btf_features,
+		.doc = "Show list of btf_features supported by pahole and exit."
+	},
 	{
 		.name = NULL,
 	}
@@ -1911,6 +1930,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	case ARGP_btf_features:
 		parse_btf_features(arg, &conf_load);	break;
+	case ARGP_supported_btf_features:
+		show_supported_btf_features();		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


