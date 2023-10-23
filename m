Return-Path: <bpf+bounces-12994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A27D2F47
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56681C208D6
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2414011;
	Mon, 23 Oct 2023 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSwhhNuY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60614295
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:58:27 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D331713
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 02:58:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6jrTg030564;
	Mon, 23 Oct 2023 09:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ri2DGNpIXhyi0bmfjNaeJSqPt7gbZUT11fBM5tpD3uU=;
 b=lSwhhNuYy7ZpRrKOam1XXz/7G86nS3aumpDz9t0jgEz0Yhf7nf2B7TjhXTOGhFqY91lZ
 8ydAJ09tM8FmyB2bFIQfdMp86cbT4xj7Gux1JfWSbkKTqXss/D1EFJffMrkiAYThiGCc
 tR3xp+gv95+NbCrCh+KEre9g58JK3LnxH0ZND+qa6p3TJ0N6/Wo+qkYlrYM2XeiXlwm+
 FWOahpDyygDqWW5KhFBHj2Ur9Pd7WZ4JpDIB74hKv1MJV0UAvvyKt5j0kJYhYvGJqQkv
 BHwDAspZvXg1bD5iTAChIG/UHLIBELAVpIV0SxDgc5RSCsHMI/UNTBkfxl9gBMMb3XeI LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tar0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:57:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7ZY80001475;
	Mon, 23 Oct 2023 09:57:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53a815m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Oct 2023 09:57:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39N9t2cT039213;
	Mon, 23 Oct 2023 09:57:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-206-92.vpn.oracle.com [10.175.206.92])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv53a80w0-5;
	Mon, 23 Oct 2023 09:57:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 dwarves 4/5] pahole: add --supported_btf_features
Date: Mon, 23 Oct 2023 10:57:25 +0100
Message-Id: <20231023095726.1179529-5-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: lr6Qu1DfBci72nRVlbpvbaHEtK8SSTzs
X-Proofpoint-GUID: lr6Qu1DfBci72nRVlbpvbaHEtK8SSTzs

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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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
index fe1cc6a..37fd2a4 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1230,6 +1230,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
 #define ARGP_btf_features	341
+#define ARGP_supported_btf_features 342
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "all" to enable all features.
@@ -1317,6 +1318,18 @@ static void enable_btf_feature(struct btf_feature *feature)
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
@@ -1779,6 +1792,11 @@ static const struct argp_option pahole__options[] = {
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
@@ -1956,6 +1974,8 @@ static error_t pahole__options_parser(int key, char *arg,
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


