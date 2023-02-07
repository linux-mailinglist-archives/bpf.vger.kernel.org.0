Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E391568DEBD
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjBGRRG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjBGRQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130733E0B3
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:16:00 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317GngII011637;
        Tue, 7 Feb 2023 17:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=oJ3zrJonM5mqloIWdd9NeNC28YbJ8Odj+uUsC7TSJ84=;
 b=onjBkjz+fo5jNmeyGD4CQHszgZZeuvzhTg05oxEXd9hBylJrWsGHrZH4uPxUbchoIibE
 WQSm+6bDMhGWpSXxHNy8EXgj9iSXNsFDTbo9saDZ3PQkV28DnnQ9xpYGuAyu8OJiQXIJ
 cQmAAjS+klyhxRQHFBAtfLF++Nb9IUQXd8beGdJbs9hR66W2lm9x4vVkS7BbtsHL23N7
 jdV5kw58g9ZcnxYi1Ta9fxZ5usAnEhazgbY5Atn+hB3rucg6ypHargQocQVtPzzfLnD0
 ApkioGK+B16ALHi3GSOl20SBLaWZ7T1JeYF4WfY/o4Z9ULI5KfsTrfmDXLAxuJWYxXGQ vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9ne3yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GYiLD007804;
        Tue, 7 Feb 2023 17:15:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e8an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gY007936;
        Tue, 7 Feb 2023 17:15:30 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-7;
        Tue, 07 Feb 2023 17:15:30 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 6/8] btf_encoder: support delaying function addition to check for function prototype inconsistencies
Date:   Tue,  7 Feb 2023 17:15:00 +0000
Message-Id: <1675790102-23037-7-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070153
X-Proofpoint-ORIG-GUID: 7XQZftLQ989meQM2Fv0duV3MvLhn7cV1
X-Proofpoint-GUID: 7XQZftLQ989meQM2Fv0duV3MvLhn7cV1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are multiple sources of inconsistency that can result in functions
of the same name having multiple prototypes:

- multiple static functions in different CUs share the same name
- static and external functions share the same name

In addition a function may have optimized-out parameters in some
CUs but not others.

Here we attempt to catch such cases by finding inconsistencies across
CUs using the save/compare/merge mechanisms that were previously
introduced to handle optimized-out parameters.

For two instances of a function to be considered consistent:

- number of parameters must match
- parameter names must match

The latter is a less strong method than a full type comparison but
suffices to match functions.

To enable inconsistency checking, the --skip_encoding_btf_inconsistent_proto
option is introduced.

With it, and the --btf_gen_optimized options in place:

- 285 functions are omitted due to inconsistent function prototypes
- 2495 functions are omitted due to optimized-out parameters, of these
  803 are functions with optimization-related suffixes ".isra", etc,
  leaving 1692 other functions without such suffixes.

Below performance effects and variability in encoded BTF are detailed.
It can be seen that due to the approach used - where functions are
marked "generated" on a per-encoder basis, we see quite variable
numbers of multiply-defined functions in the baseline case, some
with inconsistent prototypes.  With --skip_encoding_btf_inconsistent_proto
specified, this variability disappears, at the cost of a longer time
to carry out encoding due to the need to compare representations across
encoders at thread collection time.

Baseline:

Single-threaded:

$ time LLVM_OBJCOPY=objcopy pahole -J vmlinux

real    0m17.534s
user    0m17.019s
sys     0m0.514s
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |wc -l
51529
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |uniq|wc -l
51529

2 threads:

$ time LLVM_OBJCOPY=objcopy pahole -J -j2 vmlinux

real    0m10.942s
user    0m17.309s
sys     0m0.592s
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |wc -l
51798
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |uniq|wc -l
51529

4 threads:

$ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux

real    0m7.890s
user    0m18.067s
sys     0m0.661s
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |wc -l
52028
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |uniq|wc -l
51529

Test:

Single-threaded:

$ time LLVM_OBJCOPY=objcopy pahole -J --skip_encoding_btf_inconsistent_proto --btf_gen_optimized vmlinux

real    0m19.216s
user    0m17.590s
sys     0m1.624s
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |wc -l
50246
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |uniq|wc -l
50246

2 threads:

$ time LLVM_OBJCOPY=objcopy pahole -J -j2 --skip_encoding_btf_inconsistent_proto --btf_gen_optimized vmlinux

real    0m13.147s
user    0m18.179s
sys     0m3.486s
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |wc -l
50246
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |uniq|wc -l
50246

4 threads:

$ time LLVM_OBJCOPY=objcopy pahole -J -j4 --skip_encoding_btf_inconsistent_proto --btf_gen_optimized vmlinux

real    0m11.090s
user    0m19.613s
sys     0m5.895s
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |wc -l
50246
$ bpftool btf dump file vmlinux|grep " FUNC "| awk '{print $3}'|sort |uniq|wc -l
50246

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Timo Beckers <timo@incline.eu>
Cc: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org
---
 btf_encoder.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-----
 dwarves.h     |  2 ++
 pahole.c      |  8 +++++
 3 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index cb50401..35fb60a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -33,9 +33,13 @@
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
 
+#define BTF_ENCODER_MAX_PARAMETERS	12
+
 /* state used to do later encoding of saved functions */
 struct btf_encoder_state {
 	uint32_t type_id_off;
+	bool got_parameter_names;
+	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
 };
 
 struct elf_function {
@@ -800,6 +804,66 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
+static void parameter_names__get(struct ftype *ftype, size_t nr_parameters,
+				 const char **parameter_names)
+{
+	struct parameter *parameter;
+	int i = 0;
+
+	ftype__for_each_parameter(ftype, parameter) {
+		if (i >= nr_parameters)
+			return;
+		parameter_names[i++] = parameter__name(parameter);
+	}
+}
+
+static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func, struct function *f2)
+{
+	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
+	struct function *f1 = func->function;
+	const char *name;
+	int i;
+
+	if (!f1)
+		return false;
+
+	name = function__name(f1);
+
+	if (f1->proto.nr_parms != f2->proto.nr_parms) {
+		if (encoder->verbose)
+			printf("function mismatch for '%s'(%s): %d params != %d params\n",
+			       name, f1->alias ?: name,
+			       f1->proto.nr_parms, f2->proto.nr_parms);
+		return false;
+	}
+	if (f1->proto.nr_parms == 0)
+		return true;
+
+	if (!func->state.got_parameter_names) {
+		parameter_names__get(&f1->proto, BTF_ENCODER_MAX_PARAMETERS,
+				     func->state.parameter_names);
+		func->state.got_parameter_names = true;
+	}
+	parameter_names__get(&f2->proto, BTF_ENCODER_MAX_PARAMETERS, parameter_names);
+	for (i = 0; i < f1->proto.nr_parms && i < BTF_ENCODER_MAX_PARAMETERS; i++) {
+		if (!func->state.parameter_names[i]) {
+			if (!parameter_names[i])
+				continue;
+		} else if (parameter_names[i]) {
+			if (strcmp(func->state.parameter_names[i], parameter_names[i]) == 0)
+				continue;
+		}
+		if (encoder->verbose) {
+			printf("function mismatch for '%s'(%s): parameter #%d '%s' != '%s'\n",
+			       name, f1->alias ?: name, i,
+			       func->state.parameter_names[i] ?: "<null>",
+			       parameter_names[i] ?: "<null>");
+		}
+		return false;
+	}
+	return true;
+}
+
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
 {
 	if (func->function) {
@@ -807,12 +871,16 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 
 		/* If saving and we find an existing entry, we want to merge
 		 * observations across both functions, checking that the
-		 * "seen optimized parameters" status is reflected in the func
-		 * entry. If the entry is new, record encoder state required
+		 * "seen optimized parameters" and "inconsistent prototype"
+		 * status is reflected in the func entry.
+		 * If the entry is new, record encoder state required
 		 * to add the local function later (encoder + type_id_off)
 		 * such that we can add the function later.
 		 */
 		existing->proto.optimized_parms |= fn->proto.optimized_parms;
+		if (!existing->proto.optimized_parms && !existing->proto.inconsistent_proto &&
+		     !funcs__match(encoder, func, fn))
+			existing->proto.inconsistent_proto = 1;
 	} else {
 		func->state.type_id_off = encoder->type_id_off;
 		func->function = fn;
@@ -851,7 +919,8 @@ static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 	int i;
 
 	for (i = 0; i < encoder->functions.cnt; i++) {
-		struct function *fn = encoder->functions.entries[i].function;
+		struct elf_function *func = &encoder->functions.entries[i];
+		struct function *fn = func->function;
 		struct btf_encoder *other_encoder;
 
 		if (!fn || fn->proto.processed)
@@ -871,18 +940,23 @@ static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 			if (!other_fn)
 				continue;
 			fn->proto.optimized_parms |= other_fn->proto.optimized_parms;
+			if (other_fn->proto.inconsistent_proto)
+				fn->proto.inconsistent_proto = 1;
+			if (!fn->proto.optimized_parms && !fn->proto.inconsistent_proto &&
+			    !funcs__match(encoder, func, other_fn))
+				fn->proto.inconsistent_proto = 1;
 			other_fn->proto.processed = 1;
 		}
-		if (fn->proto.optimized_parms) {
+		if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
 			if (encoder->verbose) {
 				const char *name = function__name(fn);
 
-				printf("skipping addition of '%s'(%s) due to optimized-out parameters\n",
-				       name, fn->alias ?: name);
+				printf("skipping addition of '%s'(%s) due to %s\n",
+				       name, fn->alias ?: name,
+				       fn->proto.optimized_parms ? "optimized-out parameters" :
+								   "multiple inconsistent function prototypes");
 			}
 		} else {
-			struct elf_function *func = &encoder->functions.entries[i];
-
 			encoder->type_id_off = func->state.type_id_off;
 			btf_encoder__add_func(encoder, fn);
 		}
@@ -1759,7 +1833,10 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			if (func) {
 				if (func->generated)
 					continue;
-				func->generated = true;
+				if (conf_load->skip_encoding_btf_inconsistent_proto)
+					save = true;
+				else
+					func->generated = true;
 			} else if (encoder->functions.suffix_cnt &&
 				   conf_load->btf_gen_optimized) {
 				/* falling back to name.isra.0 match if no exact
diff --git a/dwarves.h b/dwarves.h
index bb2c3bb..c9d2bf9 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -67,6 +67,7 @@ struct conf_load {
 	bool			skip_encoding_btf_type_tag;
 	bool			skip_encoding_btf_enum64;
 	bool			btf_gen_optimized;
+	bool			skip_encoding_btf_inconsistent_proto;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
@@ -834,6 +835,7 @@ struct ftype {
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
 	uint8_t		 processed:1;
+	uint8_t		 inconsistent_proto:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
diff --git a/pahole.c b/pahole.c
index f48b66d..2992f43 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1222,6 +1222,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_encoding_btf_enum64 337
 #define ARGP_skip_emitting_atomic_typedefs 338
 #define ARGP_btf_gen_optimized  339
+#define ARGP_skip_encoding_btf_inconsistent_proto 340
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1639,6 +1640,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_btf_gen_optimized,
 		.doc  = "Generate BTF for functions with optimization-related suffixes (.isra, .constprop).  BTF will only be generated if a function does not optimize out parameters."
 	},
+	{
+		.name = "skip_encoding_btf_inconsistent_proto",
+		.key = ARGP_skip_encoding_btf_inconsistent_proto,
+		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or have optimized-out parameters."
+	},
 	{
 		.name = NULL,
 	}
@@ -1810,6 +1816,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf.skip_emitting_atomic_typedefs = true;	break;
 	case ARGP_btf_gen_optimized:
 		conf_load.btf_gen_optimized = true;		break;
+	case ARGP_skip_encoding_btf_inconsistent_proto:
+		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.31.1

