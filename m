Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368765755C6
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiGNTVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiGNTVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:21:38 -0400
Received: from sinsgout.his.huawei.com (sinsgout.his.huawei.com [119.8.179.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FC643E42
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:21:37 -0700 (PDT)
Received: from sinmsgout01.his.huawei.com (unknown [172.28.115.139])
        by sinsgout.his.huawei.com (SkyGuard) with ESMTP id 4LkPNH3Cd2z3h0ql
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 03:15:59 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.147])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkPGK4zYQz9ttCk;
        Fri, 15 Jul 2022 03:10:49 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:15:35 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [RFC][PATCH v8 04/12] btf: Introduce __maybe_null suffix for kfunc parameter declaration
Date:   Thu, 14 Jul 2022 21:14:47 +0200
Message-ID: <20220714191455.2101834-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714191455.2101834-1-roberto.sassu@huawei.com>
References: <20220714191455.2101834-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since kfuncs don't have a prototype defined, the BTF code has to infer the
information in a different way. For example, naming a parameter with the
__sz suffix is currently the way to declare such parameter as a memory
size.

Another feature not available without a prototype was flagging an argument
as PTR_MAYBE_NULL, meaning that the function is trusted to correctly handle
a NULL pointer.

Similarly to the __sz suffix, introduce the __maybe_null suffix to have an
equivalent feature of setting the PTR_MAYBE_NULL flag.

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/bpf/btf.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9e94571d1626..80e3098fcb48 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6142,18 +6142,13 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
 	return true;
 }
 
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+static bool btf_param_match_suffix(const struct btf *btf,
+				   const struct btf_param *arg,
+				   const char *suffix)
 {
-	int len, sfx_len = sizeof("__sz") - 1;
-	const struct btf_type *t;
+	int len, sfx_len = strlen(suffix);
 	const char *param_name;
 
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
 	/* In the future, this can be ported to use BTF tagging */
 	param_name = btf_name_by_offset(btf, arg->name_off);
 	if (str_is_empty(param_name))
@@ -6162,12 +6157,25 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	if (len < sfx_len)
 		return false;
 	param_name += len - sfx_len;
-	if (strncmp(param_name, "__sz", sfx_len))
+	if (strncmp(param_name, suffix, sfx_len))
 		return false;
 
 	return true;
 }
 
+static bool is_kfunc_arg_mem_size(const struct btf *btf,
+				  const struct btf_param *arg,
+				  const struct bpf_reg_state *reg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
+		return false;
+
+	return btf_param_match_suffix(btf, arg, "__sz");
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
@@ -6302,8 +6310,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
-			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
+		} else if (is_kfunc && ((reg->type == PTR_TO_BTF_ID ||
+			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type))) ||
+			   (btf_param_match_suffix(btf, &args[i], "__maybe_null") &&
+			    (reg->type == PTR_TO_BTF_ID_OR_NULL ||
+			    (reg2btf_ids[base_type(reg->type)] &&
+			     type_flag(reg->type) == PTR_MAYBE_NULL))))) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -6316,7 +6328,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 
-			if (reg->type == PTR_TO_BTF_ID) {
+			if (base_type(reg->type) == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
 				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
@@ -6354,6 +6366,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (is_kfunc) {
 				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
 				bool arg_dynptr = !strcmp(ref_tname, "bpf_dynptr_kern");
+				bool arg_null_ok = btf_param_match_suffix(btf, &args[i],
+									  "__maybe_null") &&
+						   reg->type == SCALAR_VALUE &&
+						   tnum_equals_const(reg->var_off, 0);
 
 				/* Permit pointer to mem, but only when argument
 				 * type is pointer to scalar, or struct composed
@@ -6363,7 +6379,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				 */
 				if (!btf_type_is_scalar(ref_t) &&
 				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
-				    !arg_dynptr &&
+				    !arg_dynptr && !arg_null_ok &&
 				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
 					bpf_log(log,
 						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
@@ -6371,6 +6387,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					return -EINVAL;
 				}
 
+				/* kfunc accepts NULL pointer. */
+				if (arg_null_ok)
+					continue;
+
 				/* Assume initialized dynptr. */
 				if (arg_dynptr) {
 					if (!is_dynptr_reg_valid_init(env, reg,
-- 
2.25.1

