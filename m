Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80BB50D561
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiDXVwQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVwP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2A644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so12378313pfe.10
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWhbvS1I5zzDB8aLSneoAZKAWVguxvEB816Egpxi/M4=;
        b=h2kqFVBXox8FG5Fsb07QS4Juad4izamRCB+LqBqllUTGDj924cZfgqPhRuCbMMzNFT
         +J6SeaG3Zw7Tt5pQDiSz5LSLK++DtJsixnXwolWmwWu4DOFTjfKrkxPfRcxuiWe+OHaJ
         YM9xtf7UZiuDNqA7nz7usv3mqqLinvBGKimVM9vKUV3FrjewyEztoES+AgTN1d5qTYvt
         iMplRBOiu3n5pUTxukUqyomls6BU4k1jS1xata0gQdbAiHbH35FruQSrJMMHQyqUxzTr
         5KC3ZUUUGl1k1H+DxpG0HQWm+he3AUM4FBIUhmancJIjJl0me538LjoE3g61RXPDBiFF
         fhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWhbvS1I5zzDB8aLSneoAZKAWVguxvEB816Egpxi/M4=;
        b=YumyZv2MqMG1zb8f0hj0AmiZFtcBGzbyY0FxMJAQB/MjUQwQNnYmlmrt6yfhgjyZEG
         9T+0o3/HUb0Oa4My96YliURjkR7Zq94sFo7KTV8ToYrRZjGTgSfghmhrl/CyhBSiaU5D
         BgoWsYY+eSwk0N0YX2anrpXdndyvgdyf3prKGy60Eg2Vd9GI/Cutqv+EKNdAF3OYTWRN
         7Ir801t5HBeQLY4eMW5PdWHQ5ON1vp5PJIXP30KNvmR3UQUbW1AFCMuVvKMNM1lfAiDO
         veGfVpm/l3slcclg18C2kU7NN0nJn2zxoR1a83j9AsSKQypptBFeAjvb9ikC9zf0WRGF
         8b/Q==
X-Gm-Message-State: AOAM532HPyMWc+c/wXBsgRmpuTRpPfnqT94vJYf23u1YKJh5IxnCYx9f
        MJO8h7O8LmYPU8Cv9VN878nCKvucEvU=
X-Google-Smtp-Source: ABdhPJxqbvqNevLPxUo7coAOGaUp53wDk1rrVmD9O6MD/3VGUOgAl+V28WoBWvURVcCwdD8YgIdOvw==
X-Received: by 2002:a05:6a00:24c7:b0:50a:6720:2998 with SMTP id d7-20020a056a0024c700b0050a67202998mr15812930pfv.36.1650836953651;
        Sun, 24 Apr 2022 14:49:13 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm9091766pfh.46.2022.04.24.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:13 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 08/13] bpf: Teach verifier about kptr_get kfunc helpers
Date:   Mon, 25 Apr 2022 03:18:56 +0530
Message-Id: <20220424214901.2743946-9-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5646; h=from:subject; bh=xxUzeIuRz9b4vLJkv7Y2Do1T/RPtVDt8wOuyLjWs6jg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTL/VgC4uCq2tX54i74/rIClKox1jtSCMi02yCe /l5EGUOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RyivND/ 97jHonpgDHj0k/PakmhCm0TIfySs1UzkE0p24/7QefcXgQuFUekOIR9xwuL687Y3sw6uQSmMsO2J+D 1pGuKDsGuuq9ivhaWLJhnRNjEMgGvkMvpoVQ4DfGccfHKCSpMFsSay4MyXXI1l1OSoS5T2YvmmZRd5 2kttMv/v+tinSechpMQwOosQA1N6mE6Dr+Q0C2kNBs0CJdUnv9l+3oP5lrj2kdlyAnzbrIzkEigjlW AXgOWNhdMTQ5EwouU3dw5SeHodhybV8rlB2rlQm/XLBNS3U+fk+4RAQp/iTyyefZomNA2F+3lN7qau wSIJ01nCJztLJiVV4metLapuEbs7AraW7MThmsy9cE51BK17l5eB+5Pon9xvnmwuWWmhWiJzyU/FQH krurjIDaUXCJMbQbiFbsipmx1IH6UkYi8C0+o1F7YflhRxvVl5lB+kqt4in5edayjV/Hvv8vxLD0jO wT/9LQoI5SGvXJapZl+UZCH0RkgVTE7h5Gx7LNhcb6rcfPXvl8wozSXH8ZYSh9bCjLGOUcN6MynZH4 sl4Qqp1+Gi8Z+8gSVhUEwMbu+zKgslNKDZdT8Q2cHwOiASEtVn+8UH4ZTweeVXXNG5UW8RSwvzPTEj WlMfPbFWp/7fZl30LmkqAU9OkFjp3wIBQnQP3ELqGkiay6zBvWFfwGr4cgVw==
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
 kernel/bpf/btf.c    | 58 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f70625dd5bb4..2611cea2c2b6 100644
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
index 1f2012fd89fb..494437fb40b7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6089,11 +6089,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6119,10 +6119,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6154,8 +6158,52 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
+			if (!off_desc || off_desc->type != BPF_KPTR_REF) {
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
+			if (!btf_struct_ids_match(log, btf, ref_id, 0, off_desc->kptr.btf,
+						  off_desc->kptr.btf_id)) {
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

