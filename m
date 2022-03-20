Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5054E1C6B
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbiCTP5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbiCTP5S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687B554188
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p5so7455183pfo.5
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0mLN62+cRxqSBr0NxuA9nFQnj29ROBC80G+ZDENw88=;
        b=kb0URj5ScrM8fx4rqxkSfOcTvDF/2G7B7KJJlTSPDLIv0DQmV0b1lEmTL1hqI1Oqpb
         FTrtXgD2HYtUvYMxPWUY5XOVQE+uTWFHAhpALaQ9I8nzQL4JQrLB2DuYzVFBwEIwpSm7
         SVnzWITB5fReeL6A1jKW1WQm/qWFQ5xg2F83VvgW4nNUNAdz9lCpjtz2cG+Epso8RCNe
         X6nxhkK4a34k0EZnhZsqX8fN3HXPEquQzLe0BdYRZw1uH1nL0KJQM7CyAm46qHhXWrVP
         a4yBE7KjM7QvDChjFrFp1JMbhXqwQxDLIoEWW/vJHYH1WIEgoPh5T+0C6B2DoqWcGOW0
         Huww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0mLN62+cRxqSBr0NxuA9nFQnj29ROBC80G+ZDENw88=;
        b=JDZKtMmu4vn+A8S/4Y9EouP8Dd0GKoumCDnwjygn03wxetjUPSaz9u6xgBpMS3Gzhf
         puYGNLd7yYjkd18ED8N1yY83vmmi+M8gPCM9ykqNq81hhLz7hRab2sC3fPKEwMt7oC+4
         nJPiVg3kY30QtRz2EmMcnG8NnvjkMh88XIM73bj0gU91nl6ze224QD3g7Kvq3CLf6Xt8
         rUptsbIfWFl+3DqVns7TXe1u3iwOQPxWIpcLzy2OQyHTU8ApNJrUvE8pH6KEFcp2UJH9
         X2I0F+X6BUu7D/jhFoi76fGfJhe7z5ZIKuGtqJVbe6dtBkCslHNNhhAxu3mATA56R1h6
         Nhhw==
X-Gm-Message-State: AOAM53318W+CF11M3CeBorHgd7+UaUFWWbpH1aliVdpppnw5Qo9V/U1x
        sW0WV7Q4/6Y0u22dsnkZGYvvIyjdD7Y=
X-Google-Smtp-Source: ABdhPJxpiYpp8RK16IjPEcxdYwPcfgQDHnDhEwe+4xXuyBM1gC13r94hrXTVQoR+rVsCmShRkJVV8A==
X-Received: by 2002:a62:1ad3:0:b0:4fa:9adc:7680 with SMTP id a202-20020a621ad3000000b004fa9adc7680mr1960803pfa.25.1647791754759;
        Sun, 20 Mar 2022 08:55:54 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id x2-20020a63aa42000000b0038265eb2495sm2521405pgo.88.2022.03.20.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:54 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 10/13] bpf: Teach verifier about kptr_get kfunc helpers
Date:   Sun, 20 Mar 2022 21:25:07 +0530
Message-Id: <20220320155510.671497-11-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5735; h=from:subject; bh=RMnLYSm74flSd/a5yI436W0bZ7O4OfWVX+/9PxpWEus=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00yVf1FFW26pPQ3GTDFzGhTyjXGgvKzVqMNbJzh 0Aa1K9+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8RytHQD/ 9w2qFmDC2HlIVAzYYbaab3IEDdVZCdFcznMMjs8Fqdg4Q5wxlylf5Qhz7sGwc48MBnFe5kkQKKnWJ2 j17iRMiNSgTRT1H5ZvcmKMj5zmhLUdZ1EoY3yMMH6OSQTorY/WI0ErPYH7qJdFskIQzN+78sNdQhqQ RFqv2WoCMVHhO2KfeallNK519dezloE4lAvIn7s1tEi48EQP+UX5PhXqtsi6ZdaZTczAcPsWwWcjdo 4XGuUFFMPIV9QuXEHJvrzEiMit4lf/RQVGot4xf1H/V0SjFSKJlEKokKB/yzMcFlWaO/uX8N1qr7rL DvOaQg8l1JvWkb+ZGl6cPK1zXa+P7JBCHqNlWqhpEcbGQsp1wbXflWmkMk/YMrO5p0HaYKU2H5YX43 jRxgiInOnlqQ/D8RGUBPwbyBqVu5OCbCGKYXKdqJ0Fcdra5Jqs8ASuk7Wnv4UuLF89rVWN920jXgs6 LNCuCiYkSntN/R1GNiTTL+fUSGTwfYQFRei2t97vaVwZMmEkTtqcjc9u92KOblquO1EavzqrUhT/Kl 3IrDFU1KERuBTETHePbe7KpyTaOmHSi6VU79DmI7y6fQhLfXy25lrhdEjsZMP7YaXhdlNnjA4X46PI KTr+NVRk+rRucNQ74bYUSC7hJJ+vM/9OS5Yie0vDlH44NAawlsGq/3je/Bdw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We introduce a new style of kfunc helpers, namely *_kptr_get, where they
take pointer to the map value which points to a referenced kernel
pointer contained in the map. Since this is referenced, only
bpf_kptr_xchg from BPF side and xchg from kernel side is allowed to
change the current value, and each pointer that resides in that location
would be referenced, and RCU protected (this must be kept in mind while
adding kernel types embeddable as reference kptr in BPF maps).

This means that if do the load of the pointer value in an RCU read
section, and find a live pointer, then as long as we hold RCU read lock,
it won't be freed by a parallel xchg + release operation. This allows us
to implement a safe refcount increment scheme. Hence, enforce that first
argument of all such kfunc is a proper PTR_TO_MAP_VALUE pointing at the
right offset to referenced pointer.

For the rest of the arguments, they are subjected to typical kfunc
argument checks, hence allowing some flexibility in passing more intent
into how the reference should be taken.

For instance, in case of struct nf_conn, it is not freed until RCU grace
period ends, but can still be reused for another tuple once refcount has
dropped to zero. Hence, a bpf_ct_kptr_get helper not only needs to call
refcount_inc_not_zero, but also do a tuple match after incrementing the
reference, and when it fails to match it, put the reference again and
return NULL.

This can be implemented easily if we allow passing additional parameters
to the bpf_ct_kptr_get kfunc, like a struct bpf_sock_tuple * and a
tuple__sz pair.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 61 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 8acf728c8616..d5d37bfde8df 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -17,6 +17,7 @@ enum btf_kfunc_type {
 	BTF_KFUNC_TYPE_ACQUIRE,
 	BTF_KFUNC_TYPE_RELEASE,
 	BTF_KFUNC_TYPE_RET_NULL,
+	BTF_KFUNC_TYPE_KPTR_ACQUIRE,
 	BTF_KFUNC_TYPE_MAX,
 };
 
@@ -35,6 +36,7 @@ struct btf_kfunc_id_set {
 			struct btf_id_set *acquire_set;
 			struct btf_id_set *release_set;
 			struct btf_id_set *ret_null_set;
+			struct btf_id_set *kptr_acquire_set;
 		};
 		struct btf_id_set *sets[BTF_KFUNC_TYPE_MAX];
 	};
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6227c1be6326..e11e44f83301 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6060,11 +6060,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
+	bool rel = false, kptr_get = false;
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
 	int ref_regno = 0, ret;
-	bool rel = false;
 
 	t = btf_type_by_id(btf, func_id);
 	if (!t || !btf_type_is_func(t)) {
@@ -6090,10 +6090,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	/* Only kfunc can be release func */
-	if (is_kfunc)
+	if (is_kfunc) {
+		/* Only kfunc can be release func */
 		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						BTF_KFUNC_TYPE_RELEASE, func_id);
+		kptr_get = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						     BTF_KFUNC_TYPE_KPTR_ACQUIRE, func_id);
+	}
+
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -6122,8 +6126,55 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		if (ret < 0)
 			return ret;
 
-		if (btf_get_prog_ctx_type(log, btf, t,
-					  env->prog->type, i)) {
+		/* kptr_get is only true for kfunc */
+		if (i == 0 && kptr_get) {
+			struct bpf_map_value_off_desc *off_desc;
+
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				bpf_log(log, "arg#0 expected pointer to map value\n");
+				return -EINVAL;
+			}
+
+			ret = check_mem_reg(env, reg, regno, sizeof(u64));
+			if (ret < 0)
+				return ret;
+
+			/* check_func_arg_reg_off allows var_off for
+			 * PTR_TO_MAP_VALUE, but we need fixed offset to find
+			 * off_desc.
+			 */
+			if (!tnum_is_const(reg->var_off)) {
+				bpf_log(log, "arg#0 must have constant offset\n");
+				return -EINVAL;
+			}
+
+			off_desc = bpf_map_kptr_off_contains(reg->map_ptr, reg->off + reg->var_off.value);
+			if (!off_desc || !(off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
+				bpf_log(log, "arg#0 no referenced kptr at map value offset=%llu\n",
+					reg->off + reg->var_off.value);
+				return -EINVAL;
+			}
+
+			if (!btf_type_is_ptr(ref_t)) {
+				bpf_log(log, "arg#0 BTF type must be a double pointer\n");
+				return -EINVAL;
+			}
+
+			ref_t = btf_type_skip_modifiers(btf, ref_t->type, &ref_id);
+			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
+
+			if (!btf_type_is_struct(ref_t)) {
+				bpf_log(log, "kernel function %s args#%d pointer type %s %s is not supported\n",
+					func_name, i, btf_type_str(ref_t), ref_tname);
+				return -EINVAL;
+			}
+			if (!btf_struct_ids_match(log, btf, ref_id, 0, off_desc->btf, off_desc->btf_id)) {
+				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s\n",
+					func_name, i, btf_type_str(ref_t), ref_tname);
+				return -EINVAL;
+			}
+			/* rest of the arguments can be anything, like normal kfunc */
+		} else if (btf_get_prog_ctx_type(log, btf, t, env->prog->type, i)) {
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
-- 
2.35.1

