Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1951450D562
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiDXVwW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiDXVwV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BC644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n18so22967002plg.5
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=li6sV+b3ISD42QEKSfUpcU30qpK5Ao91X2dl3dd05IA=;
        b=k8dTaW+gQE31EvfhcPCtjI/Bo2SLKCA/xT6KkXet6XfZgbnxxVslSogVVyflmTC5er
         vqYyAAwF+k0/jHr7KVgWPPbmeQnHrc3I5fmkc0WGxvCEWZH62nIdjNGdkUDEgoWxz0OE
         IGXp+B2GzDgNtP8t30KUfJLAWJryaeBFMVAUQRwDwQNsVWYNvwB7z7kBiyQOpM5PsXv8
         EA6rr+86tqL1j4A4a3JCpKuCBfxzP7OHtJniylDugoxBWHsQIRWMUybhvSLmyS+ECsgv
         Tefu8hg7/h8V+0k7THpUW+dqKz1EXUDgADsUqtFilUa2MJWY1Zuo6DW/Nrs/z9IX3IQ8
         ceYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li6sV+b3ISD42QEKSfUpcU30qpK5Ao91X2dl3dd05IA=;
        b=8KiAWmLgeQtwPEB4AVlXq5qgFmYUoYFqVxs1srPDrWQA6JipKuexIy5hFnFduHHYMi
         rYRSJVogrTmeaZVmADFQzYrzUxlfvgfSn6c++Wx+6RzwRuX+fBgAkeC6e4DRcyrllTHv
         er8rguGd+roYrqcVIMqfw5HpAwrRHY6skxgGOxhAbn/xItxpQbRy0oza0lRMDfUKmX4p
         LR/LbZYkau2ClM40flUULr+tQ9Oo1JhEc3ThXNdq+4v5gnlKZBzw59jdrvGJ2LmIU52N
         hcOMWw1dcaV6P2lyxBRZPOIxinauyADNvWnnLSj8qGLk6Suoo0yB48a1Vg+0tu3Ytabu
         ZAzA==
X-Gm-Message-State: AOAM532mrN/5/W0KPETtvq74p8w8UAmkj/rs4DERTVxL4LSQH3qohVIL
        asnNkq4AQUESgwF8TelSm6s+VCTW920=
X-Google-Smtp-Source: ABdhPJwW3dnAOxED5cBDe7hy4NPMf7Wg5b9G4TCmw2OkpzoCKW6SLRnYSRcSaQ3tp23DDfhBsxZTHw==
X-Received: by 2002:a17:902:7e06:b0:159:6c1:ea2b with SMTP id b6-20020a1709027e0600b0015906c1ea2bmr14767116plm.105.1650836958353;
        Sun, 24 Apr 2022 14:49:18 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id x23-20020a17090a0bd700b001cd498dc152sm12821809pjd.2.2022.04.24.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:18 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 09/13] bpf: Make BTF type match stricter for release arguments
Date:   Mon, 25 Apr 2022 03:18:57 +0530
Message-Id: <20220424214901.2743946-10-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5699; h=from:subject; bh=x5jfSNE5PFDUS9/vvfek+BFySIOHwyaRJHQlMjRpgUo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLoB9c3+t57iFqIC2wRxXXkZycnLqQWHXH60+e 7INUZgiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8Ryvx9EA CqZpVetcX2eNqD2DJUKPkm35jOiNdhldDz+s7GgLgjfSYlL6wkan4ilDtHGusqD6wLVcmmfz6cnu2A /zDK4AaPnUcoqEsmGN1+XGfS7gXzQEK8SZkj+xKxW0dGY2AkQ/LUr3nUNr1wKEu6w9U3wW3eELCT8e U69jU/d2hv9+dWCYypTsMUKBz2c52msFXkhJFF3tdqJZ/JO5ISk+IQ4HhgA5aZ1bpercERbOfPEfIt 75XF9OfkM3O/OAogRL2wP3LojEXFeU5wIPE5bP1tiPxP+4sCTZsE7o57vfBbpe4JwZtp7ucMyuTHXF u3oYGKRFpvO6ndTbY7ghZgiMrlmmQ218F9lRy8M4wcwHLR70jmauznsHqWQIpdte3XPjRA2+1Roud4 MA6C8s8FMIjGGkMWZPu9weG6+nuDTaOS/d+O2Y16Sy1D8p5t/TRgXXnWNtxwIcsgGCbUkCwzPyXUDm cd653aAXUftOZGLlcWGk27zJCbY4udPEqkj84AMFIcFCX7BH4DwPWWzaT7MWBYRA7+XZRDTaFyT5lA 6I/P2SXOT2yIYQE2BlJPkvcAiambOErzl5aPsycm6R8uGYshdQg4u5bHjEYryle9e++Rcp+kfVkO+0 Gb9BG3C6Bs/Y1aGt646AIPcmDbkIHtSZteh0Jpt4ZKMERZp2SQz1z6CkNLYg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current of behavior of btf_struct_ids_match for release arguments is
that when type match fails, it retries with first member type again
(recursively). Since the offset is already 0, this is akin to just
casting the pointer in normal C, since if type matches it was just
embedded inside parent sturct as an object. However, we want to reject
cases for release function type matching, be it kfunc or BPF helpers.

An example is the following:

struct foo {
	struct bar b;
};

struct foo *v = acq_foo();
rel_bar(&v->b); // btf_struct_ids_match fails btf_types_are_same, then
		// retries with first member type and succeeds, while
		// it should fail.

Hence, don't walk the struct and only rely on btf_types_are_same for
strict mode. All users of strict mode must be dealing with zero offset
anyway, since otherwise they would want the struct to be walked.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/btf.c      | 14 ++++++++++----
 kernel/bpf/verifier.c | 18 +++++++++++++++---
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6141564c76c8..0af5793ba417 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1748,7 +1748,8 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 		      u32 *next_btf_id, enum bpf_type_flag *flag);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
-			  const struct btf *need_btf, u32 need_type_id);
+			  const struct btf *need_btf, u32 need_type_id,
+			  bool strict);
 
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 494437fb40b7..4cfaf5eebecd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5746,7 +5746,8 @@ static bool btf_types_are_same(const struct btf *btf1, u32 id1,
 
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
-			  const struct btf *need_btf, u32 need_type_id)
+			  const struct btf *need_btf, u32 need_type_id,
+			  bool strict)
 {
 	const struct btf_type *type;
 	enum bpf_type_flag flag;
@@ -5755,7 +5756,12 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	/* Are we already done? */
 	if (off == 0 && btf_types_are_same(btf, id, need_btf, need_type_id))
 		return true;
-
+	/* In case of strict type match, we do not walk struct, the top level
+	 * type match must succeed. When strict is true, off should have already
+	 * been 0.
+	 */
+	if (strict)
+		return false;
 again:
 	type = btf_type_by_id(btf, id);
 	if (!type)
@@ -6197,7 +6203,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 			if (!btf_struct_ids_match(log, btf, ref_id, 0, off_desc->kptr.btf,
-						  off_desc->kptr.btf_id)) {
+						  off_desc->kptr.btf_id, true)) {
 				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s\n",
 					func_name, i, btf_type_str(ref_t), ref_tname);
 				return -EINVAL;
@@ -6250,7 +6256,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			reg_ref_tname = btf_name_by_offset(reg_btf,
 							   reg_ref_t->name_off);
 			if (!btf_struct_ids_match(log, reg_btf, reg_ref_id,
-						  reg->off, btf, ref_id)) {
+						  reg->off, btf, ref_id, rel && reg->ref_obj_id)) {
 				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
 					func_name, i,
 					btf_type_str(ref_t), ref_tname,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 955c3125576a..813f6ee80419 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3551,10 +3551,14 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 *                    // to match type
 	 *
 	 * In the kptr_ref case, check_func_arg_reg_off already ensures reg->off
-	 * is zero.
+	 * is zero. We must also ensure that btf_struct_ids_match does not walk
+	 * the struct to match type against first member of struct, i.e. reject
+	 * second case from above. Hence, when type is BPF_KPTR_REF, we set
+	 * strict mode to true for type match.
 	 */
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
-				  off_desc->kptr.btf, off_desc->kptr.btf_id))
+				  off_desc->kptr.btf, off_desc->kptr.btf_id,
+				  off_desc->type == BPF_KPTR_REF))
 		goto bad_type;
 	return 0;
 bad_type:
@@ -5593,6 +5597,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 found:
 	if (reg->type == PTR_TO_BTF_ID) {
+		/* For bpf_sk_release, it needs to match against first member
+		 * 'struct sock_common', hence make an exception for it. This
+		 * allows bpf_sk_release to work for multiple socket types.
+		 */
+		bool strict_type_match = arg_type_is_release(arg_type) &&
+					 meta->func_id != BPF_FUNC_sk_release;
+
 		if (!arg_btf_id) {
 			if (!compatible->btf_id) {
 				verbose(env, "verifier internal error: missing arg compatible BTF ID\n");
@@ -5605,7 +5616,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
 				return -EACCES;
 		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
-						 btf_vmlinux, *arg_btf_id)) {
+						 btf_vmlinux, *arg_btf_id,
+						 strict_type_match)) {
 			verbose(env, "R%d is of type %s but %s is expected\n",
 				regno, kernel_type_name(reg->btf, reg->btf_id),
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
-- 
2.35.1

