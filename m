Return-Path: <bpf+bounces-793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27152706DFD
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1E11C20F69
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC381E534;
	Wed, 17 May 2023 16:20:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA9111A1
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 16:20:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270EAD06
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:19:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4fOI014562;
	Wed, 17 May 2023 16:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Ok/jTZ28bJIDEBmPGvuLW6lTF3q+W0lit58wvIROumw=;
 b=moQM+jEeCKKZNwb1tBpZsbBsEo4o8adkvO6r/NuPyqYJZy2h/jbVg0n3k9m5l72hmYhx
 EnQJyCCjiPrG8FBDjEBwjYNLqMFBTPyAhf/z7fshgC3vd50S27cxkLHntAN5XcZaEIm7
 pJkexkyadIieDaAr5oMih84kdi5a3kc2SBv+AT+wJLydc4x3bGaX5m6qbi/kDjdjFP+Q
 EIswZ0172v4fXg1U3v7lMo2xKsPrU/eIx6OVj7XWRG6kBeSH7XxpVf4lMyd8pJ+pC/Wq
 TLI8IjxiXN4jMhhEUnXZa09FWLHRN0uayMy2R2nWGYxYQhoOyU90Qm9ozY3zGTgbgxTk yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j0pve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:19:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFJdGT004207;
	Wed, 17 May 2023 16:19:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bx0v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:19:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdXF034295;
	Wed, 17 May 2023 16:19:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-5;
	Wed, 17 May 2023 16:19:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 4/6] btf_encoder: add "addr=0x<addr>" function declaration tag if --btf_gen_func_addr specified
Date: Wed, 17 May 2023 17:16:46 +0100
Message-Id: <20230517161648.17582-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230517161648.17582-1-alan.maguire@oracle.com>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170133
X-Proofpoint-GUID: ir9bFULzs6p7pj5Yvc5qfd46s1ehVO7I
X-Proofpoint-ORIG-GUID: ir9bFULzs6p7pj5Yvc5qfd46s1ehVO7I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that we have address information, use BTF declaration tag
of form

[105031] DECL_TAG 'address=0xffffffff81777410' type_id=105030 component_idx=-1

...which points at the function in question.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 34 +++++++++++++++++++++++++---------
 btf_encoder.h |  4 ++--
 dwarves.h     |  1 +
 pahole.c      | 12 ++++++++++--
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index edf72e6..3bd0fe0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -99,7 +99,7 @@ struct btf_encoder {
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
-static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder, struct conf_load *conf_load);
 
 /* mutex only needed for add/delete, as this can happen in multiple encoding
  * threads.  Traversal of the list is currently confined to thread collection.
@@ -710,7 +710,7 @@ static int32_t btf_encoder__add_var_secinfo(struct btf_encoder *encoder, uint32_
 	return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
 }
 
-int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other)
+int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other, struct conf_load *conf_load)
 {
 	struct gobuffer *var_secinfo_buf = &other->percpu_secinfo;
 	size_t sz = gobuffer__size(var_secinfo_buf);
@@ -723,7 +723,7 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder
 	if (encoder == other)
 		return 0;
 
-	btf_encoder__add_saved_funcs(other);
+	btf_encoder__add_saved_funcs(other, conf_load);
 
 	for (i = 0; i < nr_var_secinfo; i++) {
 		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
@@ -881,7 +881,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	return 0;
 }
 
-static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
+static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct conf_load *conf_load)
 {
 	int btf_fnproto_id, btf_fn_id, tag_type_id;
 	struct llvm_annotation *annot;
@@ -903,10 +903,26 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 			return -1;
 		}
 	}
+	if (conf_load->btf_gen_func_addr) {
+		if (fn->low_pc) {
+			char addr_tag[64];
+
+			snprintf(addr_tag, sizeof(addr_tag), "address=0x%lx", fn->low_pc);
+			tag_type_id = btf_encoder__add_decl_tag(encoder, addr_tag, btf_fn_id, -1);
+			if (tag_type_id < 0) {
+				fprintf(stderr, "error: failed to encode tag '%s' to func %s\n",
+					addr_tag, name);
+				return -1;
+			}
+		} else {
+			if (encoder->verbose)
+				printf("no addr info for func '%s'\n", name);
+		}
+	}
 	return 0;
 }
 
-static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder, struct conf_load *conf_load)
 {
 	int i;
 
@@ -956,7 +972,7 @@ static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 			}
 		} else {
 			encoder->type_id_off = func->state.type_id_off;
-			btf_encoder__add_func(encoder, fn);
+			btf_encoder__add_func(encoder, fn, conf_load);
 		}
 		fn->proto.processed = 1;
 	}
@@ -1356,12 +1372,12 @@ out:
 	return err;
 }
 
-int btf_encoder__encode(struct btf_encoder *encoder)
+int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf_load)
 {
 	int err;
 
 	/* for single-threaded case, saved funcs are added here */
-	btf_encoder__add_saved_funcs(encoder);
+	btf_encoder__add_saved_funcs(encoder, conf_load);
 
 	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
 		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
@@ -1871,7 +1887,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		if (save)
 			err = btf_encoder__save_func(encoder, fn, func);
 		else
-			err = btf_encoder__add_func(encoder, fn);
+			err = btf_encoder__add_func(encoder, fn, conf_load);
 		if (err)
 			goto out;
 	}
diff --git a/btf_encoder.h b/btf_encoder.h
index 34516bb..b5440cd 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -19,12 +19,12 @@ struct list_head;
 struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filename, struct btf *base_btf, bool skip_encoding_vars, bool force, bool gen_floats, bool verbose);
 void btf_encoder__delete(struct btf_encoder *encoder);
 
-int btf_encoder__encode(struct btf_encoder *encoder);
+int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf_load);
 
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load);
 
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
 
-int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other);
+int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder *other, struct conf_load *conf_load);
 
 #endif /* _BTF_ENCODER_H_ */
diff --git a/dwarves.h b/dwarves.h
index 9cf13dd..8486cfc 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -68,6 +68,7 @@ struct conf_load {
 	bool			skip_encoding_btf_enum64;
 	bool			btf_gen_optimized;
 	bool			skip_encoding_btf_inconsistent_proto;
+	bool			btf_gen_func_addr;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index 6fc4ed6..b799ea6 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1232,6 +1232,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
 #define ARGP_skip_encoding_btf_inconsistent_proto 340
+#define ARGP_btf_gen_func_addr 341
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1654,6 +1655,11 @@ static const struct argp_option pahole__options[] = {
 		.key = ARGP_skip_encoding_btf_inconsistent_proto,
 		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
 	},
+	{
+		.name = "btf_gen_func_addr",
+		.key = ARGP_btf_gen_func_addr,
+		.doc = "Encode function addresses as a BTF declaration tag pointing at the function; this allows easier matching of BTF function descriptions to kernel function addresses."
+	},
 	{
 		.name = NULL,
 	}
@@ -1829,6 +1835,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.btf_gen_optimized = true;		break;
 	case ARGP_skip_encoding_btf_inconsistent_proto:
 		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
+	case ARGP_btf_gen_func_addr:
+		conf_load.btf_gen_func_addr = true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -3009,7 +3017,7 @@ static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void *
                 */
 		if (!threads[i]->btf)
 			continue;
-		err = btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
+		err = btf_encoder__add_encoder(btf_encoder, threads[i]->encoder, conf);
 		if (err < 0)
 			goto out;
 	}
@@ -3567,7 +3575,7 @@ try_sole_arg_as_class_names:
 	header = NULL;
 
 	if (btf_encode && btf_encoder) { // maybe all CUs were filtered out and thus we don't have an encoder?
-		err = btf_encoder__encode(btf_encoder);
+		err = btf_encoder__encode(btf_encoder, &conf_load);
 		if (err) {
 			fputs("Failed to encode BTF\n", stderr);
 			goto out_cus_delete;
-- 
2.31.1


