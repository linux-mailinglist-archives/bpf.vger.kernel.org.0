Return-Path: <bpf+bounces-2744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4934733756
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2FF2817FF
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B31D2D7;
	Fri, 16 Jun 2023 17:18:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB143182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:18:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C21FF7
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:18:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCiiP0026829;
	Fri, 16 Jun 2023 17:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=hc1b2mZG7alMAj0spSdUoocxJB5EQ8UiktfxWe70MLY=;
 b=rG45IN+wwgNII3SDkqgvG5kP8BVTNlGcJ1JuISIOxbANHKmMXPEPDTuUEJa0hXSPGx/0
 XPJNsX7wXCfzVm9HRs+wJ4F5UpNCYH4l8dc5EOGH3sF+gqYiqwUCzRhV/BchXyrSRHj2
 pXyng5GeQj8JiLBpx9Mrzip70AOc4agVXHT9ERyIgosnFlmI71vikIo1Xla++Um+N3/R
 GUXevWJeSspKoXz1XNphHW+dTT2T38wbPZok4u8Eux8WiZrH5RxCXTDAjVo0y5H8cP5G
 YgPreUM3LTjFR94CRyxPiNpZhqK5VMyQ/SVEjDuJL7bG7KIwv3xZUiZow4Qclx0Ii+0c pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2avm6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:18:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GFu7tV012588;
	Fri, 16 Jun 2023 17:18:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmeru5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:18:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPq007608;
	Fri, 16 Jun 2023 17:18:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-11;
	Fri, 16 Jun 2023 17:18:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] dwarves: encode BTF kind layout, crcs
Date: Fri, 16 Jun 2023 18:17:28 +0100
Message-Id: <20230616171728.530116-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160156
X-Proofpoint-ORIG-GUID: oLukDNVtyZZ4vh6KndzhvBEl0RZhBWei
X-Proofpoint-GUID: oLukDNVtyZZ4vh6KndzhvBEl0RZhBWei
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Encode kind layout at time of BTF encoding via --btf_gen_kind_layout
and set CRC if --btf_gen_crc is set.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 10 ++++++++--
 btf_encoder.h |  2 +-
 dwarves.h     |  2 ++
 lib/bpf       |  2 +-
 pahole.c      | 19 ++++++++++++++++++-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..19cf003 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1625,17 +1625,23 @@ out:
 	return err;
 }
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose)
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, struct conf_load *conf_load, bool verbose)
 {
 	struct btf_encoder *encoder = zalloc(sizeof(*encoder));
 
 	if (encoder) {
+		LIBBPF_OPTS(btf_new_opts, opts);
+
+		opts.base_btf = base_btf;
+		opts.add_kind_layout = conf_load->btf_gen_kind_layout;
+		opts.add_crc = conf_load->btf_gen_crc;
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
index 34516bb..fbbf564 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -16,7 +16,7 @@ struct btf;
 struct cu;
 struct list_head;
 
-struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
+struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, struct conf_load *conf_load, bool verbose);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
 int btf_encoder__encode(struct btf_encoder *encoder);
diff --git a/dwarves.h b/dwarves.h
index eb1a6df..0360807 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -68,6 +68,8 @@ struct conf_load {
 	bool			skip_encoding_btf_enum64;
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
+	bool			btf_gen_kind_layout;
+	bool			btf_gen_crc;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/lib/bpf b/lib/bpf
index 6597330..3f591a6 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 6597330c45d185381900037f0130712cd326ae59
+Subproject commit 3f591a66103d49b311956618d440a84cf4d30715
diff --git a/pahole.c b/pahole.c
index 6fc4ed6..e7268a3 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1232,6 +1232,8 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
+#define ARGP_btf_gen_kind_layout   341
+#define ARGP_btf_gen_crc           342
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1654,6 +1656,16 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_skip_encoding_btf_inconsistent_proto,
 		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
 	},
+	{
+		.name = "btf_gen_kind_layout",
+		.key  = ARGP_btf_gen_kind_layout,
+		.doc  = "Generate BTF kind layout information about kinds available."
+	},
+	{
+		.name = "btf_gen_crc",
+		.key  = ARGP_btf_gen_crc,
+		.doc  = "Generate CRC in BTF header."
+	},
 	{
 		.name = NULL,
 	}
@@ -1829,6 +1841,10 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_btf_gen_kind_layout:
+		conf_load.btf_gen_kind_layout = true;		break;
+	case ARGP_btf_gen_crc:
+		conf_load.btf_gen_crc = true;			break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -3064,7 +3080,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			 * create it.
 			 */
 			btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
-						       btf_encode_force, btf_gen_floats, global_verbose);
+						       btf_encode_force, btf_gen_floats, conf_load, global_verbose);
 			if (btf_encoder && thr_data) {
 				struct thread_data *thread = thr_data;
 
@@ -3096,6 +3112,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 							 skip_encoding_btf_vars,
 							 btf_encode_force,
 							 btf_gen_floats,
+							 conf_load,
 							 global_verbose);
 				thread->btf = btf_encoder__btf(thread->encoder);
 			}
-- 
2.31.1


