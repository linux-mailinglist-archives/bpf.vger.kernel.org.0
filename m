Return-Path: <bpf+bounces-9917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A857879EB0E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BBB281DF0
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190F1F19B;
	Wed, 13 Sep 2023 14:27:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C419A1A713
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 14:27:31 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1751E9B
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:27:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCIc1c013522;
	Wed, 13 Sep 2023 14:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=3KihomYapQcqP+Th12kI6NGQkN3e3Afww//lf/Pd2o0=;
 b=hwozCNhqB5LaP8xudsbyhrWtPE8FeJ9Kv1tMimdFmMZ3TOal2KOml/phjZ3raK1C4Jhl
 S7SQrs3XNOG8ST//2CD91G04EaNUFIELhaCCyJonZIe6r8OlsiOkf55nCcN26PZ7gFqi
 VhUicghAR9TKJVvwZEribt+b3aiyssH0f+iWfMz9eTtkeaqjcUOb9q/FkRosGh05WZM3
 ia+9LbOcdkKSvdwGxAKpIyhpo3Oxi5GxXoBFZ0QUpjP5eNjgceTtJ14KegYdeDRCL+AE
 /W06/BjqYrkyfiou5uGt4DKvsWihLpkTPRgcgqvv+B6cMSgr+3628ecoTybUIMZC8GxP wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kj5qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:27:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDOxDU014631;
	Wed, 13 Sep 2023 14:27:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dkhp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:27:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DENxAM005305;
	Wed, 13 Sep 2023 14:27:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-149.vpn.oracle.com [10.175.188.149])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0f5dkhdj-3;
	Wed, 13 Sep 2023 14:27:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH dwarves 2/3] pahole: add --skip_autodetect_btf_kind_max to disable kind autodetect
Date: Wed, 13 Sep 2023 15:26:45 +0100
Message-Id: <20230913142646.190047-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230913142646.190047-1-alan.maguire@oracle.com>
References: <20230913142646.190047-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130118
X-Proofpoint-GUID: 0cGs_kyOqREHENQRyiSF9GcBMEVIa7Od
X-Proofpoint-ORIG-GUID: 0cGs_kyOqREHENQRyiSF9GcBMEVIa7Od

Autodetection of BTF kinds supported may not be wanted or may be
broken at some point; it is prudent to provide a way to switch it
off.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c      | 3 ++-
 dwarves.h          | 1 +
 man-pages/pahole.1 | 4 ++++
 pahole.c           | 8 ++++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 98c7529..ad0158f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1892,7 +1892,8 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)
 
 void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
 {
-	if (btf_kind_max < 0 || btf_kind_max >= BTF_KIND_MAX)
+	if (conf_load->skip_autodetect_btf_kind_max ||
+	    btf_kind_max < 0 || btf_kind_max >= BTF_KIND_MAX)
 		return;
 	if (btf_kind_max < BTF_KIND_DECL_TAG)
 		conf_load->skip_encoding_btf_decl_tag = true;
diff --git a/dwarves.h b/dwarves.h
index f4d9347..04a4c29 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -68,6 +68,7 @@ struct conf_load {
 	bool			skip_encoding_btf_enum64;
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
+	bool			skip_autodetect_btf_kind_max;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index c1b48de..523d4fd 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -233,6 +233,10 @@ Do not encode type tags in BTF.
 .B \-\-skip_encoding_btf_inconsistent_proto
 Do not encode functions with multiple inconsistent prototypes or unexpected register use for their parameters, where the registers used do not match calling conventions.
 
+.TP
+.B \-\-skip_autodetect_btf_kind_max
+Do not scan DWARF to find out which BTF kinds are supported by the underlying object.
+
 .TP
 .B \-j, \-\-jobs=N
 Run N jobs in parallel. Defaults to number of online processors + 10% (like
diff --git a/pahole.c b/pahole.c
index e843999..aca2704 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1232,6 +1232,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
+#define ARGP_skip_autodetect_btf_kind_max 341
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1654,6 +1655,11 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_skip_encoding_btf_inconsistent_proto,
 		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
 	},
+	{
+		.name = "skip_autodetect_btf_kind_max",
+		.key = ARGP_skip_autodetect_btf_kind_max,
+		.doc = "Skip auto-detection of maximum BTF kind supported."
+	},
 	{
 		.name = NULL,
 	}
@@ -1829,6 +1835,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_skip_autodetect_btf_kind_max:
+		conf_load.skip_autodetect_btf_kind_max = true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.39.3


