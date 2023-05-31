Return-Path: <bpf+bounces-1545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AACB718B0E
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DA61C20EF3
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225C13D394;
	Wed, 31 May 2023 20:21:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04C34CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:53 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2A12B
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKIbkN027633;
	Wed, 31 May 2023 20:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=POZhLgUN4v2xQ8Y/91UX4zUm4qP5fd4fwxdWTQ7FbOo=;
 b=PhhwHh+EL/hGNPChSoKhn0+hY9Mx8D/reMXNJSvuH/bYfaJDw7T7mzYTnSKbI9XxHXp7
 jEgvBdm5XuPCV+8Qf8Asca8HUlZNa9LMTWVEtbfjwvcEfkuv+7tQk4fzTFhs1ajSFP0O
 oGUjiyAuZWNKxoDrx3U5zQnZTMCg8osx6OzyLVGd5zJIy3FvUPLHV0PiE2kfWQ7JS8ix
 ISx1YPBWd1SeRc1PAzda2O9/sJgCtA+drJRDM6tqM47OqSv48oNM1MBjKQjgCkKG3N63
 KX3+SifArGqmYl7vvlvp5nxVwzRi6nIS3YOm5qVj1gfnGvd9bQjB1GecQPawrTnhmQKi TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwweud9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJqq7i019887;
	Wed, 31 May 2023 20:21:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6dk6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:21:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEd000653;
	Wed, 31 May 2023 20:21:14 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-10;
	Wed, 31 May 2023 20:21:14 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves] dwarves: encode BTF metadata if --btf_gen_meta is set
Date: Wed, 31 May 2023 21:19:36 +0100
Message-Id: <20230531201936.1992188-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531201936.1992188-1-alan.maguire@oracle.com>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-ORIG-GUID: B-dsbrsuh6plO1tAwpqq6fERA7XYDdKs
X-Proofpoint-GUID: B-dsbrsuh6plO1tAwpqq6fERA7XYDdKs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 13 +++++++++++--
 btf_encoder.h |  2 +-
 lib/bpf       |  2 +-
 pahole.c      | 12 +++++++++++-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..d3d6c67 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1625,17 +1625,26 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool gen_meta, bool verbose)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
 	if (encoder) {
+		LIBBPF_OPTS(btf_new_opts, opts);
+		char description[128];
+
+		snprintf(description, sizeof(description), "generated by dwarves v%u.%u",
+			 DWARVES_MAJOR_VERSION, DWARVES_MINOR_VERSION);
+		opts.base_btf = base_btf;
+		opts.add_meta = gen_meta;
+		opts.description = description;
+
 		encoder->raw_output = detached_filename != NULL;
 		encoder->filename = strdup(encoder->raw_output ? detached_filename : cu->filename);
 		if (encoder->filename == NULL)
 			goto out_delete;
 
-		encoder->btf = btf__new_empty_split(base_btf);
+		encoder->btf = btf__new_empty_opts(&opts);
 		if (encoder->btf == NULL)
 			goto out_delete;
 
diff --git a/btf_encoder.h b/btf_encoder.h
index 34516bb..0c8ea1a 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,7 @@ struct btf;
 struct cu;
 struct list_head;
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool gen_meta, bool verbose);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/lib/bpf b/lib/bpf
index 6597330..3f591a6 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 6597330c45d185381900037f0130712cd326ae59
+Subproject commit d40a48fbfa2a357a6245c59e7bb811f72b5fc94d
diff --git a/pahole.c b/pahole.c
index 6fc4ed6..78fa778 100644
--- a/pahole.c
+++ b/pahole.c
@@ -40,6 +40,7 @@ static bool first_obj_only;
 static bool skip_encoding_btf_vars;
 static bool btf_encode_force;
 static const char *base_btf_file;
+static bool btf_gen_meta;
 
 static const char *prettify_input_filename;
 static FILE *prettify_input;
@@ -1232,6 +1233,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
+#define ARGP_btf_gen_meta          341
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1654,6 +1656,11 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_skip_encoding_btf_inconsistent_proto,
 		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
 	},
+	{
+		.name = "btf_gen_meta",
+		.key  = ARGP_btf_gen_meta,
+		.doc  = "Generate BTF metadata including kinds available."
+	},
 	{
 		.name = NULL,
 	}
@@ -1829,6 +1836,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_btf_gen_meta:
+		btf_gen_meta = true;			break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -3064,7 +3073,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * create it.
 			 */
 			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
-						       btf_encode_force, btf_gen_floats, global_verbose);
+						       btf_encode_force, btf_gen_floats, btf_gen_meta, global_verbose);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
 
@@ -3096,6 +3105,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 							 skip_encoding_btf_vars,
 							 btf_encode_force,
 							 btf_gen_floats,
+							 btf_gen_meta,
 							 global_verbose);
 				thread->btf = btf_encoder__btf(thread->encoder);
 			}
-- 
2.31.1


