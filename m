Return-Path: <bpf+bounces-12150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32B57C88BF
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011D71C20B05
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85021BDCE;
	Fri, 13 Oct 2023 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rR0RjyjF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145C1B299
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:34:53 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF01BB
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 08:34:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE0qgo015820;
	Fri, 13 Oct 2023 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=HjnJW6IsbJP8dfbTwjZt6dG0Sq0qcul1jNikCohHRl4=;
 b=rR0RjyjF64nuonidhDFCFHUYMcGQdj9575TrI4kYCaTBeAlAxnsPvc8pOHiwMlT8z/eI
 6GLajZiL4PgqKPfQrZubWUNEExSBppsF/QnnrcT6sSfh/EFf89gDvik3W5xkcnI1g58U
 EH3XY7RFADcE7zYfTsgsx89ywqv/tJPgHhbNnstUf04W8P0jXDpP+1S1PShAFnRDiuhn
 JoJV9LfhgMSCJUQBKhmb+M5E2aWMtYdZtZDsKA0nqJjSJM1yVQQrZ6l4mbwjNTR9EbWD
 eryFrJqB47n8IvAH0kAVsAXT7tBMZB9jlJy8q9Ak3H6ZMThHPbIIdxFqPDUrP/LhiNDU 4A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cnbx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 15:34:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEjebv039741;
	Fri, 13 Oct 2023 15:34:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0u1xq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 15:34:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DFY4GX030819;
	Fri, 13 Oct 2023 15:34:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-179.vpn.oracle.com [10.175.183.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tpt0u1x9h-5;
	Fri, 13 Oct 2023 15:34:20 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 4/5] pahole: add --supported_btf_features
Date: Fri, 13 Oct 2023 16:33:58 +0100
Message-Id: <20231013153359.88274-5-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: kjvQlwSYB8BwRE2G7sIRzJFy32INtHkz
X-Proofpoint-GUID: kjvQlwSYB8BwRE2G7sIRzJFy32INtHkz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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
 encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index a09885f..6148915 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -297,6 +297,10 @@ Encode BTF using the specified feature list, or specify 'all' for all features s
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
 
+.TP
+.B \-\-supported_btf_features
+Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
+
 .TP
 .B \-l, \-\-show_first_biggest_size_base_type_member
 Show first biggest size base_type member.
diff --git a/pahole.c b/pahole.c
index 0d0f6c6..816525a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1230,6 +1230,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
+#define ARGP_supported_btf_features 342
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1334,6 +1335,18 @@ static void parse_btf_features(const char *features)
 	set_btf_features_defaults = true;
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
+}
+
 static const struct argp_option pahole__options[] = {
 	{
 		.name = "bit_holes",
@@ -1761,6 +1774,11 @@ static const struct argp_option pahole__options[] = {
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
@@ -1938,6 +1956,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	case ARGP_btf_features:
 		parse_btf_features(arg);		break;
+	case ARGP_supported_btf_features:
+		show_supported_btf_features();		exit(0);
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


