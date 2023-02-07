Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7168DEBC
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjBGRRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBGRQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B773E63E
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:15:52 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317GmZst017968;
        Tue, 7 Feb 2023 17:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=LVyqRp8Rgn/Zh85+qQJetBJ6wiFtj/VXa4tB3l1YOWI=;
 b=GIy8hEFoLNJHtdiAD21QA+0yebakBTWU+71BfK309nEs4tW4xiV8LVSAXv1lnfPf3wer
 82gmLFQP1FTPa6mbTrvzsRnNK1nb4R5oTxTvR5ujbICnm4gFDQIeutrGszUtukqKdxRg
 6xRXMSBBc6GcOj5jx6xq51qOoq7ZCygbnTRXBOJkhhXC3pleee7iUw7YCc63L90RkXV1
 qELvfqRo29mFc3hqAuh2Gu0WuWkI0MeoVVodfFUdxLzKDmBaqzmqzQz0siV1sYGEQLWA
 4RG3Or8VnDbVsm8j4nndutS4/OzjebCfcaG/ss6R4un3mc+wp9FHS5TZDwLZ0C+ZSRHM /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdce5kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GV69d007878;
        Tue, 7 Feb 2023 17:15:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e87y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:27 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gW007936;
        Tue, 7 Feb 2023 17:15:26 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-6;
        Tue, 07 Feb 2023 17:15:26 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 5/8] btf_encoder: Represent "."-suffixed functions (".isra.0") in BTF
Date:   Tue,  7 Feb 2023 17:14:59 +0000
Message-Id: <1675790102-23037-6-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: xOtZe07ZAs0OmhAJCEojDgDScTu1xJwe
X-Proofpoint-ORIG-GUID: xOtZe07ZAs0OmhAJCEojDgDScTu1xJwe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At gcc optimization level O2 or higher, many function optimizations
occur such as

- constant propagation (.constprop.0);
- interprocedural scalar replacement of aggregates, removal of
  unused parameters and replacement of parameters passed by
  reference by parameters passed by value (.isra.0)

See [1] for details.

Currently BTF encoding does not handle such optimized functions that get
renamed with a "." suffix such as ".isra.0", ".constprop.0".  This is
safer because such suffixes can often indicate parameters have been
optimized out.  Since we can now spot this, support matching to a "."
suffix and represent the function in BTF if it does not have
optimized-out parameters.  First an attempt to match by exact name is
made; if that fails we fall back to checking for a "."-suffixed name.
The BTF representation will use the original function name "foo" not
"foo.isra.0" for consistency with DWARF representation.

There is a complication however, and this arises because we process each
CU separately and merge BTF when complete.  Different CUs may optimize
differently, so in one CU, a function may have optimized-out parameters
- and thus be ineligible for BTF - while in another it does not have
  optimized-out parameters - making it eligible for BTF.  The NF_HOOK
function is an example of this.

To avoid disrupting BTF generation parallelism, the approach taken is to
save pointers to the function representations in the ELF function table;
it is per-encoder, but the same representation is used across encoders,
so we can use the same array index to find the same function when
merging for efficiency.  Using the ELF function is ideal also as we
already have to carry out a name lookup for matching from DWARF to
ELF.

At thread collection time, observations about optimizations are
merged across encoders and we know whether it is safe to add a
"."-suffixed function or not.

The result of this is we add 1180 "."-suffixed functions to the BTF
representation.

Encoding of "."-suffixed functions is done only if the
"--btf_gen_optimized" function is specified.

Because we need to ensure consistency across encoders, there is
a performance cost to the save/merge/apply approach. Comparing
baseline to test times:

$ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux

real	0m7.788s
user	0m17.629s
sys	0m0.652s

$ time LLVM_OBJCOPY=objcopy pahole -J -j4 --btf_gen_optimized vmlinux

real	0m10.839s
user	0m19.473s
sys	0m5.932s

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

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
 btf_encoder.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++---
 dwarves.h     |   3 +
 pahole.c      |  22 +++++---
 3 files changed, 159 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 74ab61b..cb50401 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -30,11 +30,20 @@
 
 #include <errno.h>
 #include <stdint.h>
+#include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
 
+/* state used to do later encoding of saved functions */
+struct btf_encoder_state {
+	uint32_t type_id_off;
+};
+
 struct elf_function {
 	const char	*name;
 	bool		 generated;
+	size_t		prefixlen;
+	struct function	*function;
+	struct btf_encoder_state state;
 };
 
 #define MAX_PERCPU_VAR_CNT 4096
@@ -57,6 +66,7 @@ struct btf_encoder {
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
 	uint32_t	  unspecified_type;
+	int		  saved_func_cnt;
 	bool		  has_index_type,
 			  need_index_type,
 			  skip_encoding_vars,
@@ -77,12 +87,15 @@ struct btf_encoder {
 		struct elf_function *entries;
 		int		    allocated;
 		int		    cnt;
+		int		    suffix_cnt; /* number of .isra, .part etc */
 	} functions;
 };
 
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
+static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+
 /* mutex only needed for add/delete, as this can happen in multiple encoding
  * threads.  Traversal of the list is currently confined to thread collection.
  */
@@ -707,6 +720,11 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder
 	int32_t i, id;
 	struct btf_var_secinfo *vsi;
 
+	if (encoder == other)
+		return 0;
+
+	btf_encoder__add_saved_funcs(other);
+
 	for (i = 0; i < nr_var_secinfo; i++) {
 		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
 		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
@@ -782,6 +800,27 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
+static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
+{
+	if (func->function) {
+		struct function *existing = func->function;
+
+		/* If saving and we find an existing entry, we want to merge
+		 * observations across both functions, checking that the
+		 * "seen optimized parameters" status is reflected in the func
+		 * entry. If the entry is new, record encoder state required
+		 * to add the local function later (encoder + type_id_off)
+		 * such that we can add the function later.
+		 */
+		existing->proto.optimized_parms |= fn->proto.optimized_parms;
+	} else {
+		func->state.type_id_off = encoder->type_id_off;
+		func->function = fn;
+		encoder->saved_func_cnt++;
+	}
+	return 0;
+}
+
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
 {
 	int btf_fnproto_id, btf_fn_id, tag_type_id;
@@ -807,6 +846,50 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 	return 0;
 }
 
+static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+{
+	int i;
+
+	for (i = 0; i < encoder->functions.cnt; i++) {
+		struct function *fn = encoder->functions.entries[i].function;
+		struct btf_encoder *other_encoder;
+
+		if (!fn || fn->proto.processed)
+			continue;
+
+		/* merge optimized-out status across encoders; since each
+		 * encoder has the same elf symbol table we can use the
+		 * same index to access the same elf symbol.
+		 */
+		btf_encoders__for_each_encoder(other_encoder) {
+			struct function *other_fn;
+
+			if (other_encoder == encoder)
+				continue;
+
+			other_fn = other_encoder->functions.entries[i].function;
+			if (!other_fn)
+				continue;
+			fn->proto.optimized_parms |= other_fn->proto.optimized_parms;
+			other_fn->proto.processed = 1;
+		}
+		if (fn->proto.optimized_parms) {
+			if (encoder->verbose) {
+				const char *name = function__name(fn);
+
+				printf("skipping addition of '%s'(%s) due to optimized-out parameters\n",
+				       name, fn->alias ?: name);
+			}
+		} else {
+			struct elf_function *func = &encoder->functions.entries[i];
+
+			encoder->type_id_off = func->state.type_id_off;
+			btf_encoder__add_func(encoder, fn);
+		}
+		fn->proto.processed = 1;
+	}
+}
+
 /*
  * This corresponds to the same macro defined in
  * include/linux/kallsyms.h
@@ -818,6 +901,11 @@ static int functions_cmp(const void *_a, const void *_b)
 	const struct elf_function *a = _a;
 	const struct elf_function *b = _b;
 
+	/* if search key allows prefix match, verify target has matching
+	 * prefix len and prefix matches.
+	 */
+	if (a->prefixlen && a->prefixlen == b->prefixlen)
+		return strncmp(a->name, b->name, b->prefixlen);
 	return strcmp(a->name, b->name);
 }
 
@@ -850,14 +938,22 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 	}
 
 	encoder->functions.entries[encoder->functions.cnt].name = name;
+	if (strchr(name, '.')) {
+		const char *suffix = strchr(name, '.');
+
+		encoder->functions.suffix_cnt++;
+		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
+	}
 	encoder->functions.entries[encoder->functions.cnt].generated = false;
+	encoder->functions.entries[encoder->functions.cnt].function = NULL;
 	encoder->functions.cnt++;
 	return 0;
 }
 
-static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
+static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
+						       const char *name, size_t prefixlen)
 {
-	struct elf_function key = { .name = name };
+	struct elf_function key = { .name = name, .prefixlen = prefixlen };
 
 	return bsearch(&key, encoder->functions.entries, encoder->functions.cnt, sizeof(key), functions_cmp);
 }
@@ -1187,6 +1283,9 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 {
 	int err;
 
+	/* for single-threaded case, saved funcs are added here */
+	btf_encoder__add_saved_funcs(encoder);
+
 	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
 		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
 
@@ -1634,6 +1733,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
+		struct elf_function *func = NULL;
+		bool save = false;
 
 		/*
 		 * Skip functions that:
@@ -1647,29 +1748,62 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		if (!ftype__has_arg_names(&fn->proto))
 			continue;
 		if (encoder->functions.cnt) {
-			struct elf_function *func;
 			const char *name;
 
 			name = function__name(fn);
 			if (!name)
 				continue;
 
-			func = btf_encoder__find_function(encoder, name);
-			if (!func || func->generated)
+			/* prefer exact function name match... */
+			func = btf_encoder__find_function(encoder, name, 0);
+			if (func) {
+				if (func->generated)
+					continue;
+				func->generated = true;
+			} else if (encoder->functions.suffix_cnt &&
+				   conf_load->btf_gen_optimized) {
+				/* falling back to name.isra.0 match if no exact
+				 * match is found; only bother if we found any
+				 * .suffix function names.  The function
+				 * will be saved and added once we ensure
+				 * it does not have optimized-out parameters
+				 * in any cu.
+				 */
+				func = btf_encoder__find_function(encoder, name,
+								  strlen(name));
+				if (func) {
+					save = true;
+					if (encoder->verbose)
+						printf("matched function '%s' with '%s'%s\n",
+						       name, func->name,
+						       fn->proto.optimized_parms ?
+						       ", has optimized-out parameters" : "");
+					fn->alias = func->name;
+				}
+			}
+			if (!func)
 				continue;
-			func->generated = true;
 		} else {
 			if (!fn->external)
 				continue;
 		}
 
-		err = btf_encoder__add_func(encoder, fn);
+		if (save)
+			err = btf_encoder__save_func(encoder, fn, func);
+		else
+			err = btf_encoder__add_func(encoder, fn);
 		if (err)
 			goto out;
 	}
 
 	if (!encoder->skip_encoding_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
+
+	/* It is only safe to delete this CU if we have not stashed any static
+	 * functions for later addition.
+	 */
+	if (!err)
+		err = encoder->saved_func_cnt > 0 ? LSK__KEEPIT : LSK__DELETE;
 out:
 	encoder->cu = NULL;
 	return err;
diff --git a/dwarves.h b/dwarves.h
index 1cd95f7..bb2c3bb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -66,6 +66,7 @@ struct conf_load {
 	bool			skip_missing;
 	bool			skip_encoding_btf_type_tag;
 	bool			skip_encoding_btf_enum64;
+	bool			btf_gen_optimized;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
@@ -832,6 +833,7 @@ struct ftype {
 	uint16_t	 nr_parms;
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
+	uint8_t		 processed:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
@@ -884,6 +886,7 @@ struct function {
 	struct rb_node	 rb_node;
 	const char	 *name;
 	const char	 *linkage_name;
+	const char	 *alias;	/* name.isra.0 */
 	uint32_t	 cu_total_size_inline_expansions;
 	uint16_t	 cu_total_nr_inline_expansions;
 	uint8_t		 inlined:2;
diff --git a/pahole.c b/pahole.c
index 6f4f87c..f48b66d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1221,6 +1221,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_languages_exclude	   336
 #define ARGP_skip_encoding_btf_enum64 337
 #define ARGP_skip_emitting_atomic_typedefs 338
+#define ARGP_btf_gen_optimized  339
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1633,6 +1634,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_skip_emitting_atomic_typedefs,
 		.doc  = "Do not emit 'typedef _Atomic int atomic_int' & friends."
 	},
+	{
+		.name = "btf_gen_optimized",
+		.key  = ARGP_btf_gen_optimized,
+		.doc  = "Generate BTF for functions with optimization-related suffixes (.isra, .constprop).  BTF will only be generated if a function does not optimize out parameters."
+	},
 	{
 		.name = NULL,
 	}
@@ -1802,6 +1808,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_enum64 = true;	break;
 	case ARGP_skip_emitting_atomic_typedefs:
 		conf.skip_emitting_atomic_typedefs = true;	break;
+	case ARGP_btf_gen_optimized:
+		conf_load.btf_gen_optimized = true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2980,20 +2988,20 @@ static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void *
 		 * Merge content of the btf instances of worker threads to the btf
 		 * instance of the primary btf_encoder.
                 */
-		if (!threads[i]->btf || threads[i]->encoder == btf_encoder)
-			continue; /* The primary btf_encoder */
+		if (!threads[i]->btf)
+			continue;
 		err = btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
 		if (err < 0)
 			goto out;
-		btf_encoder__delete(threads[i]->encoder);
-		threads[i]->encoder = NULL;
 	}
 	err = 0;
 
 out:
 	for (i = 0; i < nr_threads; i++) {
-		if (threads[i]->encoder && threads[i]->encoder != btf_encoder)
+		if (threads[i]->encoder && threads[i]->encoder != btf_encoder) {
 			btf_encoder__delete(threads[i]->encoder);
+			threads[i]->encoder = NULL;
+		}
 	}
 	free(threads[0]);
 
@@ -3077,11 +3085,11 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			encoder = btf_encoder;
 		}
 
-		if (btf_encoder__encode_cu(encoder, cu, conf_load)) {
+		ret = btf_encoder__encode_cu(encoder, cu, conf_load);
+		if (ret < 0) {
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
-		ret = LSK__DELETE;
 out_btf:
 		return ret;
 	}
-- 
2.31.1

