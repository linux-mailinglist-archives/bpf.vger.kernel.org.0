Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF264679B4D
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjAXOP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjAXOP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:15:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85313DE9
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:15:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODI9Hd004727;
        Tue, 24 Jan 2023 13:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=pMVf2tP5Fw49a4oKAbfRtxdvm3bsSHLaXhAm1lkbaHI=;
 b=SyWih7bXIR+8hszMdqQRsOTtq03nfBEsmJBS8sS7KtPC5VrZtB//YlLK9ThE8d3UvJSt
 M9wpxmY0QgLoIGG3gRk+SmL65CYd69L6JH/5D5nHTvFSLnDbk48dhDRKRBr+LSZU45x2
 kcitdcdB6nkGvPQtsO0dt0BcPawOG/qV3zQ8piXHZ4vRgSwFo1Qd8c2ofdXE8Qi8n//W
 P0gpAMS9QvX+1XVPxqiNW2d9wU0R7uIXu2rV90DGFy4BGki6yoVBt9udI8zMrHZRFUiq
 Pb9BC2pDUBV991Egzg9Pp56qoXns8B9DM0THTi/r4S0g4KhGH9u4wRVH9wD4D4nWniT/ zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcdd3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OBmnFu021150;
        Tue, 24 Jan 2023 13:45:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbr5rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ODjZ3x037951;
        Tue, 24 Jan 2023 13:45:51 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-161-98.vpn.oracle.com [10.175.161.98])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gbr5fj-5;
        Tue, 24 Jan 2023 13:45:50 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 4/5] btf_encoder: represent "."-suffixed optimized functions (".isra.0") in BTF
Date:   Tue, 24 Jan 2023 13:45:30 +0000
Message-Id: <1674567931-26458-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240125
X-Proofpoint-GUID: gW763peLxbNowvdakkkhePAJ66zOK_GW
X-Proofpoint-ORIG-GUID: gW763peLxbNowvdakkkhePAJ66zOK_GW
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

The only workable solution I could find without disrupting
BTF generation parallelism is to create a shared representation
of such "."-suffixed functions in the main BTF encoder.  A
binary tree is used to store function representations.  Instead
of directly adding a static function with a "." suffix, we
postpone their addition until we have processed all CUs.
At that point - since we have merged any observations of
optimized-out parameters for each function - we know if
the candidate function is safe for BTF addition or not.

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 pahole.c      |   4 +-
 2 files changed, 191 insertions(+), 8 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 449439f..a86b099 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -21,6 +21,8 @@
 #include <stdlib.h> /* for qsort() and bsearch() */
 #include <inttypes.h>
 #include <limits.h>
+#include <search.h> /* for tsearch(), tfind() and tdstroy() */
+#include <pthread.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -34,6 +36,7 @@
 struct elf_function {
 	const char	*name;
 	bool		 generated;
+	size_t		prefixlen;
 };
 
 #define MAX_PERCPU_VAR_CNT 4096
@@ -57,6 +60,9 @@ struct btf_encoder {
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
 	uint32_t	  unspecified_type;
+	void		  *saved_func_tree;
+	int		  saved_func_cnt;
+	pthread_mutex_t	  saved_func_lock;
 	bool		  has_index_type,
 			  need_index_type,
 			  skip_encoding_vars,
@@ -77,9 +83,12 @@ struct btf_encoder {
 		struct elf_function *entries;
 		int		    allocated;
 		int		    cnt;
+		int		    suffix_cnt; /* number of .isra, .part etc */
 	} functions;
 };
 
+static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+
 void btf_encoders__add(struct list_head *encoders, struct btf_encoder *encoder)
 {
 	list_add_tail(&encoder->node, encoders);
@@ -698,6 +707,11 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder
 			return id;
 	}
 
+	/* for multi-threaded case, saved functions are added to each encoder's
+	 * BTF, prior to it being merged with the parent encoder.
+	 */
+	btf_encoder__add_saved_funcs(encoder);
+
 	return btf__add_btf(encoder->btf, other->btf);
 }
 
@@ -765,6 +779,76 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
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
+/*
+ * static functions with suffixes are not added yet - we need to
+ * observe across all CUs to see if the static function has
+ * optimized parameters in any CU, since in such a case it should
+ * not be included in the final BTF.  NF_HOOK.constprop.0() is
+ * a case in point - it has optimized-out parameters in some CUs
+ * but not others.  In order to have consistency (since we do not
+ * know which instance the BTF-specified function signature will
+ * apply to), we simply skip adding functions which have optimized
+ * out parameters anywhere.
+ */
+static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
+{
+	struct btf_encoder *parent = encoder->parent ? encoder->parent : encoder;
+	const char *name = function__name(fn);
+	struct function **nodep;
+	int ret = 0;
+
+	pthread_mutex_lock(&parent->saved_func_lock);
+	nodep = tsearch(fn, &parent->saved_func_tree, function__compare);
+	if (nodep == NULL) {
+		fprintf(stderr, "error: out of memory adding local function '%s'\n",
+			name);
+		ret = -1;
+		goto out;
+	}
+	/* If we find an existing entry, we want to merge observations
+	 * across both functions, checking that the "seen optimized-out
+	 * parameters" status is reflected in our tree entry.
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
+			ret = -1;
+			goto out;
+		}
+		state->encoder = encoder;
+		state->type_id_off = encoder->type_id_off;
+		fn->priv = state;
+		encoder->saved_func_cnt++;
+		if (encoder->verbose)
+			printf("added local function '%s'%s\n", name,
+			       fn->proto.optimized_parms ?
+			       ", optimized-out params" : "");
+	}
+out:
+	pthread_mutex_unlock(&parent->saved_func_lock);
+	return ret;
+}
+
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
 {
 	int btf_fnproto_id, btf_fn_id, tag_type_id;
@@ -789,6 +873,55 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 	return 0;
 }
 
+/* visit each node once, adding associated function */
+static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
+					const int depth __maybe_unused)
+{
+	struct btf_encoder_state *state;
+	struct btf_encoder *encoder;
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
+	if (!fn || !fn->priv)
+		return;
+	state = (struct btf_encoder_state *)fn->priv;
+	encoder = state->encoder;
+	encoder->type_id_off = state->type_id_off;
+	/* we can safely free encoder state since we visit each node once */
+	free(fn->priv);
+	fn->priv = NULL;
+	if (fn->proto.optimized_parms) {
+		if (encoder->verbose)
+			printf("skipping addition of '%s' due to optimized-out parameters\n",
+			       function__name(fn));
+	} else {
+		btf_encoder__add_func(encoder, fn);
+	}
+}
+
+void saved_func__free(void *nodep __maybe_unused)
+{
+	/* nothing to do, functions are freed when the cu is. */
+}
+
+static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+{
+	if (!encoder->parent && encoder->saved_func_tree) {
+		encoder->type_id_off = 0;
+		twalk(encoder->saved_func_tree, btf_encoder__add_saved_func);
+		tdestroy(encoder->saved_func_tree, saved_func__free);
+		encoder->saved_func_tree = NULL;
+	}
+}
+
 /*
  * This corresponds to the same macro defined in
  * include/linux/kallsyms.h
@@ -800,6 +933,12 @@ static int functions_cmp(const void *_a, const void *_b)
 	const struct elf_function *a = _a;
 	const struct elf_function *b = _b;
 
+	/* if search key allows prefix match, verify target has matching
+	 * prefix len and prefix matches.
+	 */
+	if (a->prefixlen && a->prefixlen == b->prefixlen)
+		return strncmp(a->name, b->name, b->prefixlen);
+
 	return strcmp(a->name, b->name);
 }
 
@@ -832,14 +971,21 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
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
+static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name,
+						       size_t prefixlen)
 {
-	struct elf_function key = { .name = name };
+	struct elf_function key = { .name = name, .prefixlen = prefixlen };
 
 	return bsearch(&key, encoder->functions.entries, encoder->functions.cnt, sizeof(key), functions_cmp);
 }
@@ -1171,6 +1317,9 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 	if (gobuffer__size(&encoder->percpu_secinfo) != 0)
 		btf_encoder__add_datasec(encoder, PERCPU_SECTION);
 
+	/* for single-threaded case, saved functions are added here */
+	btf_encoder__add_saved_funcs(encoder);
+
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
@@ -1456,6 +1605,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
 		encoder->array_index_id  = 0;
+		pthread_mutex_init(&encoder->saved_func_lock, NULL);
 
 		GElf_Ehdr ehdr;
 
@@ -1614,6 +1764,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
+		bool save = false;
 
 		/*
 		 * Skip functions that:
@@ -1634,22 +1785,54 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			if (!name)
 				continue;
 
-			func = btf_encoder__find_function(encoder, name);
-			if (!func || func->generated)
+			/* prefer exact name function match... */
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
+	/* It is only safe to delete this CU if we have not stashed any local
+	 * functions for later addition.
+	 */
+	if (!err)
+		err = encoder->saved_func_cnt > 0 ? LSK__KEEPIT : LSK__DELETE;
 out:
 	encoder->cu = NULL;
 	return err;
diff --git a/pahole.c b/pahole.c
index 844d502..62d54ec 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3078,11 +3078,11 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
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

