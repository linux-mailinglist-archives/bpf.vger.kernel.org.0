Return-Path: <bpf+bounces-12566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A87CDBA3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CC8281DC7
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA30347BF;
	Wed, 18 Oct 2023 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B6sQrmRZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758A1F5E7
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 12:29:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A710E
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 05:29:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBJHc2017152;
	Wed, 18 Oct 2023 12:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=SKD49PR8Hh1+coXYMJPSB7PdXAsJ12tr9iz9sC7xzYE=;
 b=B6sQrmRZITbOKnJMmJlsnOahTSKhiEASdmW2N6UYblWYLMKsKOciQr/cljkCbS2LLB4+
 CoHB9CXf6ojC/lqHw5CNJeyn5bhJ65HNY24Ngl2XgGM/yrd5xOsuu/K9wYXFRPhuMv8w
 fo/2DhMZVLUQTWwv8wKNkaxqRmtelkWwomlSOCgO7dylBMh9W3bJR2xPlsGK2Xsrtsig
 U8n30PDgMHjv1UQPvfv7QZncQn/fazOVEf1LtefT6jnYTMyZBg2U5c8o7glvJbWtt27z
 q2dI4w0JozuxcydVkwzaVLcZieuOXpNZhQVPC8lAPXEnekNHxvV31ThRLp+VSSjdrqJU ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1fbxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBowNp040586;
	Wed, 18 Oct 2023 12:29:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfynp8g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 12:29:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ICTUEU034930;
	Wed, 18 Oct 2023 12:29:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-178-90.vpn.oracle.com [10.175.178.90])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trfynp8bs-2;
	Wed, 18 Oct 2023 12:29:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 dwarves 1/5] btf_encoder, pahole: move btf encoding options into conf_load
Date: Wed, 18 Oct 2023 13:29:22 +0100
Message-Id: <20231018122926.735416-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: G-JAyiwB0QR_loybkzETBJM2ot6WtDL5
X-Proofpoint-ORIG-GUID: G-JAyiwB0QR_loybkzETBJM2ot6WtDL5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

...rather than passing them to btf_encoder__new(); this tidies
up the encoder API and also allows us to use generalized methods
to translate from a BTF feature (forthcoming) to a conf_load
value.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_encoder.c |  8 ++++----
 btf_encoder.h |  2 +-
 dwarves.h     |  3 +++
 pahole.c      | 21 ++++++++-------------
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..fd04008 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1625,7 +1625,7 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
@@ -1639,9 +1639,9 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		if (encoder->btf == NULL)
 			goto out_delete;
 
-		encoder->force		 = force;
-		encoder->gen_floats	 = gen_floats;
-		encoder->skip_encoding_vars = skip_encoding_vars;
+		encoder->force		 = conf_load->btf_encode_force;
+		encoder->gen_floats	 = conf_load->btf_gen_floats;
+		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/btf_encoder.h b/btf_encoder.h
index 34516bb..f54c95a 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,7 @@ struct btf;
 struct cu;
 struct list_head;
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool verbose, struct conf_load *conf_load);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/dwarves.h b/dwarves.h
index eb1a6df..db68161 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -68,6 +68,9 @@ struct conf_load {
 	bool			skip_encoding_btf_enum64;
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
+	bool			skip_encoding_btf_vars;
+	bool			btf_gen_floats;
+	bool			btf_encode_force;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index e843999..7a41dc3 100644
--- a/pahole.c
+++ b/pahole.c
@@ -32,13 +32,10 @@
 static struct btf_encoder *btf_encoder;
 static char *detached_btf_filename;
 static bool btf_encode;
-static bool btf_gen_floats;
 static bool ctf_encode;
 static bool sort_output;
 static bool need_resort;
 static bool first_obj_only;
-static bool skip_encoding_btf_vars;
-static bool btf_encode_force;
 static const char *base_btf_file;
 
 static const char *prettify_input_filename;
@@ -1786,9 +1783,9 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_header_type:
 		conf.header_type = arg;			break;
 	case ARGP_skip_encoding_btf_vars:
-		skip_encoding_btf_vars = true;		break;
+		conf_load.skip_encoding_btf_vars = true;	break;
 	case ARGP_btf_encode_force:
-		btf_encode_force = true;		break;
+		conf_load.btf_encode_force = true;	break;
 	case ARGP_btf_base:
 		base_btf_file = arg;			break;
 	case ARGP_kabi_prefix:
@@ -1797,9 +1794,9 @@ static error_t pahole__options_parser(int key, char *arg,
 	case ARGP_numeric_version:
 		print_numeric_version = true;		break;
 	case ARGP_btf_gen_floats:
-		btf_gen_floats = true;			break;
+		conf_load.btf_gen_floats = true;	break;
 	case ARGP_btf_gen_all:
-		btf_gen_floats = true;			break;
+		conf_load.btf_gen_floats = true;	break;
 	case ARGP_with_flexible_array:
 		show_with_flexible_array = true;	break;
 	case ARGP_prettify_input_filename:
@@ -3063,8 +3060,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * And, it is used by the thread
 			 * create it.
 			 */
-			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
-						       btf_encode_force, btf_gen_floats, global_verbose);
+			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf,
+						       global_verbose, conf_load);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
 
@@ -3093,10 +3090,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 				thread->encoder =
 					btf_encoder__new(cu, detached_btf_filename,
 							 NULL,
-							 skip_encoding_btf_vars,
-							 btf_encode_force,
-							 btf_gen_floats,
-							 global_verbose);
+							 global_verbose,
+							 conf_load);
 				thread->btf = btf_encoder__btf(thread->encoder);
 			}
 			encoder = thread->encoder;
-- 
2.31.1


