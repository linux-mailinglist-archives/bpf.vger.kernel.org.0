Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966C681352
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjA3OcZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjA3OcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:32:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C73A5A3
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 06:30:34 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UASrXY018801;
        Mon, 30 Jan 2023 14:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=P+ygTO2FqWzljYCYc8fzL/YTDuRDhr7O02s8w8XC5BM=;
 b=nJ1jOc5kilpnwQM5Wm/Gf6TbxOd1Az4USnOVi87f99LZ+92VCVouoP4maHzjCKFUKuSU
 G3Mad9xHeFY0muD1tj4wzLMOWO2AoDvgsoccA0hEJnydkGRghhLA67vlOm8pgZ4rVY7d
 JDH+d5A/VUTehFF4xjIpEFZxf5xngFuprGcmS77vdoYdkqLQaxqtd1y6ngdQjtDcO46x
 rgbT93g6Xd0pw7ZbSbnGTBMjGq1yHXnF0guaePcZQf+U8EI+NocpShcmepFqhexuM4mC
 LThwWHK4zhEIgcMla4rsAD2eaGVdEvuq4mNLruLxMsL5kmdqfdi6FsCD67WCKH/nyIns 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwu0jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:30:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UE6GjR000661;
        Mon, 30 Jan 2023 14:30:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5463cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:30:15 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UETrJ1020648;
        Mon, 30 Jan 2023 14:30:14 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-214-73.vpn.oracle.com [10.175.214.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5462kh-6;
        Mon, 30 Jan 2023 14:30:14 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 5/5] btf_encoder: delay function addition to check for function prototype inconsistencies
Date:   Mon, 30 Jan 2023 14:29:45 +0000
Message-Id: <1675088985-20300-6-git-send-email-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: 7bLuTm07zFQ5BKfV_RPTrqgYrIRt7B6I
X-Proofpoint-GUID: 7bLuTm07zFQ5BKfV_RPTrqgYrIRt7B6I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are multiple sources of inconsistency that can result in
functions of the same name having multiple prototypes:

- multiple static functions in different CUs share the same name
- static and external functions share the same name

Here we attempt to catch such cases by finding inconsistencies
across CUs using the save/compare/merge mechanisms that were
previously introduced to handle optimized-out parameters,
using it for all functions.

For two instances of a function to be considered consistent:

- number of parameters must match
- parameter names must match

The latter is a less strong method than a full type
comparison but suffices to match functions.

With these changes, we see 278 functions removed due to
protoype inconsistency.  For example, wakeup_show()
has two distinct prototypes:

static ssize_t wakeup_show(struct kobject *kobj,
                           struct kobj_attribute *attr, char *buf)
(from kernel/irq/irqdesc.c)

static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
                           char *buf)
(from drivers/base/power/sysfs.c)

In some other cases, the parameter comparisons weed out additional
inconsistencies in "."-suffixed functions across CUs.

We also see a large number of functions eliminated due to
optimized-out parameters; 2542 functions are eliminated for this
reason, both "."-suffixed (1007) and otherwise (1535).

Because the save/compare/merge process occurs for all functions
it is important to assess performance effects.  In addition,
prior to these changes the number of functions ultimately
represented in BTF was non-deterministic when pahole was
run with multiple threads.  This was due to the fact that
functions were marked as generated on a per-encoder basis
when first added, and as such the same function could
be added multiple times for different encoders, and if they
encountered inconsistent function prototypes, deduplication
could leave multiple entries in place for the same name.
When run in a single thread, the "generated" state associated
with the name would prevent this.

Here we assess both BTF encoding performance and determinism
of the function representation in baseline compared to with
these changes.  Determinism is assessed by counting the
number of functions in BTF.  Comparisons are done for 1,
4 and 8 threads.

Baseline

$ time LLVM_OBJCOPY=objcopy pahole -J vmlinux

real	0m18.160s
user	0m17.179s
sys	0m0.757s

$ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
51150
$ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
51150

$ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux

real	0m8.078s
user	0m17.978s
sys	0m0.732s

$ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
51592
$ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
51150

$ time LLVM_OBJCOPY=objcopy pahole -J -j8 vmlinux

real	0m7.075s
user	0m19.010s
sys	0m0.587s

$ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
51683
$ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
51150

Test:

$ time LLVM_OBJCOPY=objcopy pahole -J  vmlinux

real	0m19.039s
user	0m17.617s
sys	0m1.419s
$ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
49871
$ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
49871

$ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux

real	0m8.482s
user	0m18.233s
sys	0m2.412s
$ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
49871
$ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
49871

$ time LLVM_OBJCOPY=objcopy pahole -J -j8 vmlinux

real	0m7.614s
user	0m19.384s
sys	0m3.739s
$ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
49871
$ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l

So there is a small cost in performance, but we improve determinism
and the consistency of representation.

Future work could support maintaining multiple inconsistent
prototypes; having a way to associate the function BTF representation
with the function site would be needed however, and the BPF
infrastructure would need to ensure that an fentry program was
attached to the right site with the right prototype for example.
BTF declaration tags with specifying the function address(es)
a prototype referred to could help here, but edge cases like
KASLR (where addresses change dynamically at boot-time) would
have to be considered to make this work well.

Similarly, future work could potentially accommodate function
prototypes with optimized-out parameters, similarly using
tagging to identify them.  Again the kernel would have to
be aware of such tagging and handle it.

For now it is better to have an incomplete representation
that more accurately reflects the actual function parameters
used, removing inconsistencies that could otherwise do harm.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++------------
 dwarves.h     |   1 +
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index f36150e..44739a9 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -35,7 +35,6 @@
 
 struct elf_function {
 	const char	*name;
-	bool		 generated;
 	size_t		prefixlen;
 };
 
@@ -708,6 +707,9 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encoder
 	int32_t i, id;
 	struct btf_var_secinfo *vsi;
 
+	/* saved functions are added to each encoder's BTF prior to it
+	 * being merged with the parent encoder.
+	 */
 	btf_encoder__add_saved_funcs(other);
 	if (encoder == other)
 		return 0;
@@ -795,11 +797,72 @@ static int function__compare(const void *a, const void *b)
 	return strcmp(function__name(fa), function__name(fb));
 }
 
+#define BTF_ENCODER_MAX_PARAMETERS	12
+
 struct btf_encoder_state {
 	struct btf_encoder *encoder;
 	uint32_t type_id_off;
+	bool got_parameter_names;
+	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
 };
 
+static void parameter_names__get(struct ftype *ftype, size_t nr_parameters,
+		     const char **parameter_names)
+{
+	struct parameter *parameter;
+	int i = 0;
+
+	ftype__for_each_parameter(ftype, parameter) {
+		if (i >= nr_parameters)
+			break;
+		parameter_names[i++] = parameter__name(parameter);
+	}
+}
+
+static bool funcs__match(struct function *f1, struct function *f2)
+{
+
+	const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
+	struct btf_encoder_state *state = f1->priv;
+	const char *name = function__name(f1);
+	int i;
+
+	if (!state)
+		return false;
+
+	if (f1->proto.nr_parms != f2->proto.nr_parms) {
+		if (state->encoder->verbose)
+			printf("function mismatch for '%s'(%s): %d params != %d params\n",
+			       name, f1->alias ?: name,
+			       f1->proto.nr_parms, f2->proto.nr_parms);
+		return false;
+	}
+
+	if (!state->got_parameter_names) {
+		parameter_names__get(&f1->proto, BTF_ENCODER_MAX_PARAMETERS,
+				     state->parameter_names);
+		state->got_parameter_names = true;
+	}
+	parameter_names__get(&f2->proto, BTF_ENCODER_MAX_PARAMETERS, parameter_names);
+	for (i = 0; i < f1->proto.nr_parms && i < BTF_ENCODER_MAX_PARAMETERS; i++) {
+		if (!state->parameter_names[i]) {
+			if (!parameter_names[i])
+				continue;
+		} else if (parameter_names[i]) {
+			if (strcmp(state->parameter_names[i], parameter_names[i]) == 0)
+				continue;
+		}
+		if (state->encoder->verbose)
+			printf("function mismatch for '%s'(%s): parameter #%d '%s' != '%s'\n",
+			       name, f1->alias ?: name, i,
+			       state->parameter_names[i] ?: "<null>",
+			       parameter_names[i] ?: "<null>");
+
+		return false;
+	}
+	return true;
+}
+
 static void btf_encoder__merge_func(struct btf_encoder *encoder, struct function *fn)
 {
 	struct function **nodep;
@@ -812,6 +875,9 @@ static void btf_encoder__merge_func(struct btf_encoder *encoder, struct function
 	 */
 	fn->proto.optimized_parms |= (*nodep)->proto.optimized_parms;
 	(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
+	if ((fn->proto.inconsistent_proto || (*nodep)->proto.inconsistent_proto) ||
+	    !funcs__match(fn, *nodep))
+		(*nodep)->proto.inconsistent_proto = fn->proto.inconsistent_proto = 1;
 	(*nodep)->proto.processed = 1;
 }
 
@@ -822,19 +888,22 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 
 	nodep = tsearch(fn, &encoder->saved_func_tree, function__compare);
 	if (nodep == NULL) {
-		fprintf(stderr, "error: out of memory adding static function '%s'\n",
+		fprintf(stderr, "error: out of memory adding function '%s'\n",
 			name);
 		return -1;
 	}
 	/* If saving and we find an existing entry, we want to merge
 	 * observations across both functions, checking that the
-	 * "seen optimized parameters" status is reflected in our tree entry.
+	 * "seen optimized parameters" and inconsistent prototype
+	 * status is reflected in our tree entry.
 	 * If the entry is new, record encoder state required
 	 * to add the local function later (encoder + type_id_off)
 	 * such that we can add the function later.
 	 */
 	if (*nodep != fn) {
 		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
+		if (!funcs__match(*nodep, fn))
+			(*nodep)->proto.inconsistent_proto = fn->proto.inconsistent_proto = 1;
 	} else {
 		struct btf_encoder_state *state = zalloc(sizeof(*state));
 
@@ -905,12 +974,14 @@ static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
 			btf_encoder__merge_func(other_encoder, fn);
 	}
 
-	if (fn->proto.optimized_parms) {
+	if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
 		if (encoder->verbose) {
 			const char *name = function__name(fn);
 
-			printf("skipping addition of '%s'(%s) due to optimized-out parameters\n",
-			       name, fn->alias ?: name);
+			printf("skipping addition of '%s'(%s) due to %s\n",
+			       name, fn->alias ?: name,
+			       fn->proto.optimized_parms ? "optimized-out parameters" :
+							   "multiple inconsistent function prototypes");
 		}
 	} else {
 		btf_encoder__add_func(encoder, fn);
@@ -991,7 +1062,6 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 		encoder->functions.suffix_cnt++;
 		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
 	}
-	encoder->functions.entries[encoder->functions.cnt].generated = false;
 	encoder->functions.cnt++;
 	return 0;
 }
@@ -1779,8 +1849,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	}
 
 	cu__for_each_function(cu, core_id, fn) {
-		bool save = false;
-
 		/*
 		 * Skip functions that:
 		 *   - are marked as declarations
@@ -1802,11 +1870,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 
 			/* prefer exact function name match... */
 			func = btf_encoder__find_function(encoder, name, 0);
-			if (func) {
-				if (func->generated)
-					continue;
-				func->generated = true;
-			} else if (encoder->functions.suffix_cnt) {
+			if (!func && encoder->functions.suffix_cnt) {
 				/* falling back to name.isra.0 match if no exact
 				 * match is found; only bother if we found any
 				 * .suffix function names.  The function
@@ -1817,7 +1881,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 				func = btf_encoder__find_function(encoder, name,
 								  strlen(name));
 				if (func) {
-					save = true;
+					fn->alias = func->name;
 					if (encoder->verbose)
 						printf("matched function '%s' with '%s'%s\n",
 						       name, func->name,
@@ -1827,16 +1891,12 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			}
 			if (!func)
 				continue;
-			fn->alias = func->name;
 		} else {
 			if (!fn->external)
 				continue;
 		}
 
-		if (save)
-			err = btf_encoder__save_func(encoder, fn);
-		else
-			err = btf_encoder__add_func(encoder, fn);
+		err = btf_encoder__save_func(encoder, fn);
 		if (err)
 			goto out;
 	}
diff --git a/dwarves.h b/dwarves.h
index 64c7c56..ba94573 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -832,6 +832,7 @@ struct ftype {
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
 	uint8_t		 processed:1;
+	uint8_t		 inconsistent_proto:1;
 };
 
 static inline struct ftype *tag__ftype(const struct tag *tag)
-- 
1.8.3.1

