Return-Path: <bpf+bounces-12571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E55047CDBAA
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 14:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C51C20D95
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C479347CC;
	Wed, 18 Oct 2023 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I+ySdB65"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9034CCD
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 12:30:20 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2498
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 05:30:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBJHpH030415;
	Wed, 18 Oct 2023 12:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Fgp8FVLcr6ducD3BzssdFVzNaLK1BC5/7A5wZzBUNtQ=;
 b=I+ySdB65VwN/S89TQGdCxpa91kSBQ/gCTmbOTEgww+Oi3UmuMupQ8PF0alOk6U9Ms45B
 MBDsuyhbcyK7rvn+1D3RK6qbLAxVbs4Dhvc5SLr5LXZCCaqWMGzq8Q7D6TG5U9U44wz4
 GCjEVJL6hXEWhzhFuIQIDmYDPw4Ce0tC8vE8DLg9BhqE79sLQ71kujX9+0DmngxyyitO
 rhGrxDDAE15xAZoxWZl2K+4V9Mc4WHR62EyidxDf7mXBu90Y+U31FVQ+ZaX06LW7h481
 TDE9v/dzFVrSQItMrZmo74zDoJOo9VtMSJ9YjXCS4WP4rzC2Ww+Cy1GHtNQWe/9LNgAh HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu7e78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBalQl040437;
	Wed, 18 Oct 2023 12:29:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfynp8p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ICTUEa034930;
	Wed, 18 Oct 2023 12:29:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-178-90.vpn.oracle.com [10.175.178.90])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trfynp8bs-5;
	Wed, 18 Oct 2023 12:29:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 dwarves 4/5] pahole: add --supported_btf_features
Date: Wed, 18 Oct 2023 13:29:25 +0100
Message-Id: <20231018122926.735416-5-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: OFQQUXEHrc1_-ioSnhMVECb6YMKZXv0O
X-Proofpoint-ORIG-GUID: OFQQUXEHrc1_-ioSnhMVECb6YMKZXv0O
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
index 0e889cf..b5790be 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1230,6 +1230,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
+#define ARGP_supported_btf_features 342
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1318,6 +1319,18 @@ static void enable_btf_feature(struct btf_feature *feature)
 	*feature->conf_value = !feature->default_value;
 }
 
+static void show_supported_btf_features(FILE *output)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		if (i > 0)
+			fprintf(output, ",");
+		fprintf(output, "%s", btf_features[i].name);
+	}
+	fprintf(output, "\n");
+}
+
 /* Translate --btf_features=feature1[,feature2] into conf_load values.
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
@@ -1784,6 +1797,11 @@ static const struct argp_option pahole__options[] = {
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
@@ -1961,6 +1979,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	case ARGP_btf_features:
 		parse_btf_features(arg);		break;
+	case ARGP_supported_btf_features:
+		show_supported_btf_features(stdout);	exit(0);
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1


