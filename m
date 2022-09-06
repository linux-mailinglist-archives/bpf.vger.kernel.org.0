Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E225AEF88
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiIFPzm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiIFPzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 11:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5838E0D4
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662477204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKKnZ7bVoXC5XY3Hg2mohD3LMLumzak+WxpBWzrYkP8=;
        b=F0o4Ms9rdaMd4YiPXOhliJUYE+DDRv8MU/WsFwFalXWL434wnpKNa+tO+ZXzDvB1Lxzm9T
        3cNFK0OptOJz1QrhuRHpf2XsS4yy5mFavIEfeDkewcUbv/vSJWrVcG8FJlAcnxciKCEuU+
        gCSWhyDCNp7YfTZZpsCIp7yORsT9MNs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-amrWNzuVOyKOpOgvM8lV8A-1; Tue, 06 Sep 2022 11:13:19 -0400
X-MC-Unique: amrWNzuVOyKOpOgvM8lV8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A4FE3801F5B;
        Tue,  6 Sep 2022 15:13:18 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC19A40D296C;
        Tue,  6 Sep 2022 15:13:15 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH bpf-next v11 2/7] bpf: split btf_check_subprog_arg_match in two
Date:   Tue,  6 Sep 2022 17:12:58 +0200
Message-Id: <20220906151303.2780789-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20220906151303.2780789-1-benjamin.tissoires@redhat.com>
References: <20220906151303.2780789-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_check_subprog_arg_match() was used twice in verifier.c:
- when checking for the type mismatches between a (sub)prog declaration
  and BTF
- when checking the call of a subprog to see if the provided arguments
  are correct and valid

This is problematic when we check if the first argument of a program
(pointer to ctx) is correctly accessed:
To be able to ensure we access a valid memory in the ctx, the verifier
assumes the pointer to context is not null.
This has the side effect of marking the program accessing the entire
context, even if the context is never dereferenced.

For example, by checking the context access with the current code, the
following eBPF program would fail with -EINVAL if the ctx is set to null
from the userspace:

```
SEC("syscall")
int prog(struct my_ctx *args) {
  return 0;
}
```

In that particular case, we do not want to actually check that the memory
is correct while checking for the BTF validity, but we just want to
ensure that the (sub)prog definition matches the BTF we have.

So split btf_check_subprog_arg_match() in two so we can actually check
for the memory used when in a call, and ignore that part when not.

Note that a further patch is in preparation to disentangled
btf_check_func_arg_match() from these two purposes, and so right now we
just add a new hack around that by adding a boolean to this function.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v11

new in v10
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/btf.c      | 54 +++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c |  2 +-
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..c9c72a089579 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1943,6 +1943,8 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 struct bpf_reg_state;
 int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 				struct bpf_reg_state *regs);
+int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
+			   struct bpf_reg_state *regs);
 int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
 			      const struct btf *btf, u32 func_id,
 			      struct bpf_reg_state *regs,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 903719b89238..eca9ea78ee5f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6170,7 +6170,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
 				    bool ptr_to_mem_ok,
-				    u32 kfunc_flags)
+				    u32 kfunc_flags,
+				    bool processing_call)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	bool rel = false, kptr_get = false, trusted_arg = false;
@@ -6356,7 +6357,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					reg_ref_tname);
 				return -EINVAL;
 			}
-		} else if (ptr_to_mem_ok) {
+		} else if (ptr_to_mem_ok && processing_call) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
 
@@ -6431,7 +6432,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	return rel ? ref_regno : 0;
 }
 
-/* Compare BTF of a function with given bpf_reg_state.
+/* Compare BTF of a function declaration with given bpf_reg_state.
  * Returns:
  * EFAULT - there is a verifier bug. Abort verification.
  * EINVAL - there is a type mismatch or BTF is not available.
@@ -6458,7 +6459,50 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
 		return -EINVAL;
 
 	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
-	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, 0);
+	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, 0, false);
+
+	/* Compiler optimizations can remove arguments from static functions
+	 * or mismatched type can be passed into a global function.
+	 * In such cases mark the function as unreliable from BTF point of view.
+	 */
+	if (err)
+		prog->aux->func_info_aux[subprog].unreliable = true;
+	return err;
+}
+
+/* Compare BTF of a function call with given bpf_reg_state.
+ * Returns:
+ * EFAULT - there is a verifier bug. Abort verification.
+ * EINVAL - there is a type mismatch or BTF is not available.
+ * 0 - BTF matches with what bpf_reg_state expects.
+ * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
+ *
+ * NOTE: the code is duplicated from btf_check_subprog_arg_match()
+ * because btf_check_func_arg_match() is still doing both. Once that
+ * function is split in 2, we can call from here btf_check_subprog_arg_match()
+ * first, and then treat the calling part in a new code path.
+ */
+int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
+			   struct bpf_reg_state *regs)
+{
+	struct bpf_prog *prog = env->prog;
+	struct btf *btf = prog->aux->btf;
+	bool is_global;
+	u32 btf_id;
+	int err;
+
+	if (!prog->aux->func_info)
+		return -EINVAL;
+
+	btf_id = prog->aux->func_info[subprog].type_id;
+	if (!btf_id)
+		return -EFAULT;
+
+	if (prog->aux->func_info_aux[subprog].unreliable)
+		return -EINVAL;
+
+	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
+	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, 0, true);
 
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
@@ -6474,7 +6518,7 @@ int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *regs,
 			      u32 kfunc_flags)
 {
-	return btf_check_func_arg_match(env, btf, func_id, regs, true, kfunc_flags);
+	return btf_check_func_arg_match(env, btf, func_id, regs, true, kfunc_flags, true);
 }
 
 /* Convert BTF of a function into bpf_reg_state if possible
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0194a36d0b36..d27fae3ce949 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6626,7 +6626,7 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	func_info_aux = env->prog->aux->func_info_aux;
 	if (func_info_aux)
 		is_global = func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
-	err = btf_check_subprog_arg_match(env, subprog, caller->regs);
+	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
 	if (is_global) {
-- 
2.36.1

