Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17575755C8
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiGNTVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbiGNTVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 15:21:48 -0400
Received: from sinsgout.his.huawei.com (sinsgout.his.huawei.com [119.8.179.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7543E58
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 12:21:47 -0700 (PDT)
Received: from sinmsgout01.his.huawei.com (unknown [172.28.115.139])
        by sinsgout.his.huawei.com (SkyGuard) with ESMTP id 4LkPN10yvxz5RkBr
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 03:15:45 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.156.147])
        by sinmsgout01.his.huawei.com (SkyGuard) with ESMTP id 4LkPGH6vn7z9xFC0;
        Fri, 15 Jul 2022 03:10:47 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 21:15:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [RFC][PATCH v8 03/12] btf: Handle dynamic pointer parameter in kfuncs
Date:   Thu, 14 Jul 2022 21:14:46 +0200
Message-ID: <20220714191455.2101834-4-roberto.sassu@huawei.com>
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

Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
that the dynamic pointer is valid and initialized.

Cc: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/btf.c             | 16 ++++++++++++++++
 kernel/bpf/verifier.c        |  4 ++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e3bad8640dc..55876fbdbae2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -560,6 +560,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
+bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg,
+			      enum bpf_arg_type arg_type);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e6fc01de7e50..9e94571d1626 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6353,6 +6353,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 			if (is_kfunc) {
 				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
+				bool arg_dynptr = !strcmp(ref_tname, "bpf_dynptr_kern");
 
 				/* Permit pointer to mem, but only when argument
 				 * type is pointer to scalar, or struct composed
@@ -6362,6 +6363,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				 */
 				if (!btf_type_is_scalar(ref_t) &&
 				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
+				    !arg_dynptr &&
 				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
 					bpf_log(log,
 						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
@@ -6369,6 +6371,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					return -EINVAL;
 				}
 
+				/* Assume initialized dynptr. */
+				if (arg_dynptr) {
+					if (!is_dynptr_reg_valid_init(env, reg,
+							ARG_PTR_TO_DYNPTR)) {
+						bpf_log(log,
+							"arg#%d pointer type %s %s must be initialized\n",
+							i, btf_type_str(ref_t),
+							ref_tname);
+						return -EINVAL;
+					}
+
+					continue;
+				}
+
 				/* Check for mem, len pair */
 				if (arg_mem_size) {
 					if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 328cfab3af60..d71c43ee9374 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -773,8 +773,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				     enum bpf_arg_type arg_type)
+bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			      enum bpf_arg_type arg_type)
 {
 	struct bpf_func_state *state = func(env, reg);
 	int spi = get_spi(reg->off);
-- 
2.25.1

