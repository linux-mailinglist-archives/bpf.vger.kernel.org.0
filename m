Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5BF681351
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjA3OcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbjA3OcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:32:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D838B7B
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 06:30:32 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UASo9O018733;
        Mon, 30 Jan 2023 14:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Z83iENfB4ksF4ROaFPP71YZE8zQGrrdeJWUk99/aWM4=;
 b=AEmgRjuEjSGZhCE2qBsiGHhyVC+AvnaXaSd8MLyU24voQh4GIfwjmcIXAaaI4EyNRizO
 h8OnklfyNj8HoLlsd6tYQCM4Az1RZisURncBkEL0ZQ+yL+0KMuM5Hxs7WYrb5IsPlvti
 te+nPmmoZAIx6jYNedmT0DWl3sIEkVrcHOBfVD4p97ww1+WMQA/BC/XLBjvbw7vDSz5q
 WDI1iTGXWFpU/27BE7O66/MW6D4SZ5bRuvJmh/shA5cQtRTiRH/afrfCypGeNuQ6G7HM
 QnU2YRgb8Hcth/z75vDgqZHsq1ZM1vpsgDP1mowvw3SymhDpj7gz+BdHaHX4c/Ua1Shq aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwu0jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:30:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UDxHdn000723;
        Mon, 30 Jan 2023 14:30:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct54636y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:30:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UETrIx020648;
        Mon, 30 Jan 2023 14:30:10 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-214-73.vpn.oracle.com [10.175.214.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5462kh-5;
        Mon, 30 Jan 2023 14:30:10 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 4/5] btf_encoder: represent "."-suffixed functions (".isra.0") in BTF
Date:   Mon, 30 Jan 2023 14:29:44 +0000
Message-Id: <1675088985-20300-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_13,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300140
X-Proofpoint-ORIG-GUID: 9tyxeauERh4kb_W6NTaA_wCCcIKbheXU
X-Proofpoint-GUID: 9tyxeauERh4kb_W6NTaA_wCCcIKbheXU
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

Currently BTF encoding does not handle such optimized functions
that get renamed with a "." suffix such as ".isra.0", ".constprop.0".
This is safer because such suffixes can often indicate parameters have
been optimized out.  Since we can now spot this, support matching
to a "." suffix and represent the function in BTF if it does not
have optimized-out parameters.  First an attempt to match by
exact name is made; if that fails we fall back to checking
for a "."-suffixed name.  The BTF representation will use the
original function name "foo" not "foo.isra.0" for consistency
with DWARF representation.

There is a complication however, and this arises because we process
each CU separately and merge BTF when complete.  Different CUs
may optimize differently, so in one CU, a function may have
optimized-out parameters - and thus be ineligible for BTF -
while in another it does not have optimized-out parameters -
making it eligible for BTF.  The NF_HOOK function is an
example of this.

To avoid disrupting BTF generation parallelism, the approach
taken is to save such functions in a per-encoder binary tree
for later addition.  That way, at thread collection time,
observations about optimizations can be merged across
encoders and we know whether it is safe to add a "."-suffixed
function or not.

The result of this is we add 602 "."-suffixed functions to
the BTF representation.

However, note that the optimization checks are applied to
both "."-suffixed and normal functions.  They find 1428
of the latter with optimized-out parameters also, and these
are dropped from the BTF representation also.  For example,
bad_inode_permission() is skipped because no location
information is supplied for any of its parameters;
disassembling it we see why this might be:

(gdb) disassemble bad_inode_permission
Dump of assembler code for function bad_inode_permission:
   0xffffffff813ef180 <+0>:	callq  0xffffffff81088c70 <__fentry__>
   0xffffffff813ef185 <+5>:	push   %rbp
   0xffffffff813ef186 <+6>:	mov    $0xfffffffb,%eax
   0xffffffff813ef18b <+11>:	mov    %rsp,%rbp
   0xffffffff813ef18e <+14>:	pop    %rbp
   0xffffffff813ef18f <+15>:	jmpq   0xffffffff81c6e600 <__x86_return_thunk>
End of assembler dump.

...since the function is simply:

static int bad_inode_permission(struct user_namespace *mnt_userns,
				struct inode *inode, int mask)
{
	return -EIO;
}

So these changes lead to a net decrease of 826 functions in
vmlinux BTF.

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 dwarves.h     |   2 +
 pahole.c      |  14 ++---
 3 files changed, 200 insertions(+), 13 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e20b628..f36150e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -30,11 +30,13 @@
 
 #include <errno.h>
 #include <stdint.h>
+#include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
 
 struct elf_function {
 	const char	*name;
 	bool		 generated;
+	size_t		prefixlen;
 };
 
 #define MAX_PERCPU_VAR_CNT 4096
@@ -57,6 +59,8 @@ struct btf_encoder {
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
 	uint32_t	  unspecified_type;
+	void		  *saved_func_tree;
+	int		  saved_func_cnt;
 	bool		  has_index_type,
 			  need_index_type,
 			  skip_encoding_vars,
@@ -77,12 +81,15 @@ struct btf_encoder {
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
@@ -701,6 +708,10 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder
 	int32_t i, id;
 	struct btf_var_secinfo *vsi;
 
+	btf_encoder__add_saved_funcs(other);
+	if (encoder == other)
+		return 0;
+
 	for (i = 0; i < nr_var_secinfo; i++) {
 		vsi = (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
 		type_id = next_type_id + vsi->type - 1; /* Type ID starts from 1 */
@@ -776,6 +787,70 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
+
+static int function__compare(const void *a, const void *b)
+{
+	struct function *fa = (struct function *)a, *fb = (struct function *)b;
+
+	return strcmp(function__name(fa), function__name(fb));
+}
+
+struct btf_encoder_state {
+	struct btf_encoder *encoder;
+	uint32_t type_id_off;
+};
+
+static void btf_encoder__merge_func(struct btf_encoder *encoder, struct function *fn)
+{
+	struct function **nodep;
+
+	nodep = tfind(fn, &encoder->saved_func_tree, function__compare);
+	if (!nodep || !*nodep)
+		return;
+	/* merge characteristics across different encoder representations
+	 * of functions.
+	 */
+	fn->proto.optimized_parms |= (*nodep)->proto.optimized_parms;
+	(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
+	(*nodep)->proto.processed = 1;
+}
+
+static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
+{
+	const char *name = function__name(fn);
+	struct function **nodep;
+
+	nodep = tsearch(fn, &encoder->saved_func_tree, function__compare);
+	if (nodep == NULL) {
+		fprintf(stderr, "error: out of memory adding static function '%s'\n",
+			name);
+		return -1;
+	}
+	/* If saving and we find an existing entry, we want to merge
+	 * observations across both functions, checking that the
+	 * "seen optimized parameters" status is reflected in our tree entry.
+	 * If the entry is new, record encoder state required
+	 * to add the local function later (encoder + type_id_off)
+	 * such that we can add the function later.
+	 */
+	if (*nodep != fn) {
+		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
+	} else {
+		struct btf_encoder_state *state = zalloc(sizeof(*state));
+
+		if (state == NULL) {
+			fprintf(stderr, "error: out of memory adding local function '%s'\n",
+				name);
+			return -1;
+		}
+		state->encoder = encoder;
+		state->type_id_off = encoder->type_id_off;
+		fn->priv = state;
+		encoder->saved_func_cnt++;
+	}
+	return 0;
+}
+
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
 {
 	int btf_fnproto_id, btf_fn_id, tag_type_id;
@@ -801,6 +876,67 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 	return 0;
 }
 
+/* visit each node once, adding associated function. */
+static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
+					const int depth __maybe_unused)
+{
+	struct btf_encoder *encoder, *other_encoder;
+	struct btf_encoder_state *state;
+	struct function *fn = NULL;
+
+	switch (which) {
+	case preorder:
+	case endorder:
+		break;
+	case postorder:
+	case leaf:
+		fn = *((struct function **)nodep);
+		break;
+	}
+	if (!fn || !fn->priv || fn->proto.processed)
+		return;
+	state = (struct btf_encoder_state *)fn->priv;
+	encoder = state->encoder;
+	encoder->type_id_off = state->type_id_off;
+
+	/* merge optimized-out status across encoders */
+	btf_encoders__for_each_encoder(other_encoder) {
+		if (other_encoder != encoder)
+			btf_encoder__merge_func(other_encoder, fn);
+	}
+
+	if (fn->proto.optimized_parms) {
+		if (encoder->verbose) {
+			const char *name = function__name(fn);
+
+			printf("skipping addition of '%s'(%s) due to optimized-out parameters\n",
+			       name, fn->alias ?: name);
+		}
+	} else {
+		btf_encoder__add_func(encoder, fn);
+		fn->proto.processed = 1;
+	}
+}
+
+static void saved_func__free(void *node)
+{
+	struct function *fn = node;
+
+	if (fn->priv)
+		free(fn->priv);
+}
+
+void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+{
+	if (!encoder->saved_func_tree)
+		return;
+
+	encoder->type_id_off = 0;
+	twalk(encoder->saved_func_tree, btf_encoder__add_saved_func);
+	tdestroy(encoder->saved_func_tree, saved_func__free);
+	encoder->saved_func_tree = NULL;
+}
+
 /*
  * This corresponds to the same macro defined in
  * include/linux/kallsyms.h
@@ -812,6 +948,11 @@ static int functions_cmp(const void *_a, const void *_b)
 	const struct elf_function *a = _a;
 	const struct elf_function *b = _b;
 
+	/* if search key allows prefix match, verify target has matching
+	 * prefix len and prefix matches.
+	 */
+	if (a->prefixlen && a->prefixlen == b->prefixlen)
+		return strncmp(a->name, b->name, b->prefixlen);
 	return strcmp(a->name, b->name);
 }
 
@@ -844,14 +985,21 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 	}
 
 	encoder->functions.entries[encoder->functions.cnt].name = name;
+	if (strchr(name, '.')) {
+		const char *suffix = strchr(name, '.');
+
+		encoder->functions.suffix_cnt++;
+		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
+	}
 	encoder->functions.entries[encoder->functions.cnt].generated = false;
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
@@ -1181,6 +1329,9 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 {
 	int err;
 
+	/* for single-threaded case, saved funcs are added here */
+	btf_encoder__add_saved_funcs(encoder);
+
 	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
 		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
 
@@ -1628,6 +1779,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
+		bool save = false;
 
 		/*
 		 * Skip functions that:
@@ -1648,22 +1800,55 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
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
+			} else if (encoder->functions.suffix_cnt) {
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
+				}
+			}
+			if (!func)
 				continue;
-			func->generated = true;
+			fn->alias = func->name;
 		} else {
 			if (!fn->external)
 				continue;
 		}
 
-		err = btf_encoder__add_func(encoder, fn);
+		if (save)
+			err = btf_encoder__save_func(encoder, fn);
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
index 2723466..64c7c56 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -831,6 +831,7 @@ struct ftype {
 	uint16_t	 nr_parms;
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
+	uint8_t		 processed:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
@@ -883,6 +884,7 @@ struct function {
 	struct rb_node	 rb_node;
 	const char	 *name;
 	const char	 *linkage_name;
+	const char	 *alias;	/* name.isra.0 */
 	uint32_t	 cu_total_size_inline_expansions;
 	uint16_t	 cu_total_nr_inline_expansions;
 	uint8_t		 inlined:2;
diff --git a/pahole.c b/pahole.c
index 6f4f87c..bc120cb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2980,20 +2980,20 @@ static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void *
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
 
@@ -3077,11 +3077,11 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
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
1.8.3.1

