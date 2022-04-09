Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D752C4FA67D
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiDIJfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiDIJfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8693826F7
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n18so9931333plg.5
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnWXyabHChRIFEwxT65hvgljmdYsjjqYnX8FnzvbvYE=;
        b=DCFA14yuemOD/ZvPtAvjaiGoAc32MzMm6bR6jn49zDgDaXn9ULQLlS2Wzu87NJPoMT
         dDe6Kh2v+MLV4fgR73Y2SIfTN2sMxIw5FcmKABoL+/2upr5efbM9VVl6fdrDFoxWkVTd
         JJSZPH8Lr3WEylQzFD7ce9qsthxc60e6/KN/VYDQPgSlYZLJKsCBpqEiQMqM3iFopJIZ
         QKVpm32JmjK0mtw4msIZkaqD9RQDXJK0PI0xLelhJnBtx15eHVqeQOB2cKP3JXTVpjCD
         hYmEV/6ZGBX6rEl5uU1bKQa7SxDao35ctxmhip+WdmxsxeRT8OLHgP/X/MZD+AC4Xkeh
         BpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnWXyabHChRIFEwxT65hvgljmdYsjjqYnX8FnzvbvYE=;
        b=Guag1NXEg7jilKGb6NB3ggBBphBYKNHNUeAC5ac7SLAdKSj231MuB+XLvmCiy8Hn3x
         i8sxAKhaQn2hfv6DDMR7Bv4KJ1enaCEZHWElfsKNe2XOjlWzKdeH8MhqZdPu6in+azim
         At5UJdZO2RlJUzdmduwDJ1jz1Ph+U3HhEIi1PqKjaOrHZ8oR56/hLCiMgy/YXf3fHWzX
         +cCa5zaW70u6SQaTOcUzx87LOaRAtMIQS1PUgvB3OBK8z5PDc08WCP05PWjeQQUoAR3R
         JK/O/+IZ77dHF19s8USrSDnvcGcRtH6OWUoj66OSnSumfDJtQ909OsYNqbwf/xIu1EQl
         KhWA==
X-Gm-Message-State: AOAM532VDUols6pHBPTXOzOx/QITCiIULMSr5H0paklAtrd+4el5pZih
        3KUDXTs6yALPcyf1E6hKHAhZWI03ImM=
X-Google-Smtp-Source: ABdhPJxopZQ3ZdH6tEnn/3O//SL8r/sHy5fXmPUviRCviAQu8RpklSMBbui3HuamNcCKgTVWKHYT7A==
X-Received: by 2002:a17:903:40cd:b0:158:33d7:e886 with SMTP id t13-20020a17090340cd00b0015833d7e886mr3129259pld.80.1649496816885;
        Sat, 09 Apr 2022 02:33:36 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b004fac74c8382sm28903804pfv.47.2022.04.09.02.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:36 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 10/13] bpf: Teach verifier about kptr_get kfunc helpers
Date:   Sat,  9 Apr 2022 15:03:00 +0530
Message-Id: <20220409093303.499196-11-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5735; h=from:subject; bh=p6F6Kf4Sb901vTjH/xj/Jdd4FkMcydr85zxIZjLTx+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0aIwBPEg54KyzZ7OdNsbcx46JivjX1HpaeU0u dpe4u7uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8Ryi/aEA CktrflaSeEpoJvBBP62KHsY5wtvIe+i2vOo2F287DvMz2lZqVNd94PtW16aaDOunP7UQaKNaM6MYlw eNFFLn14vd6XuQdtiPiWhGtq9e8q/s/2e+q83cMFEG1JuM3ZNrySYFrKXvLuEEbHd3IcYdEWJousSf kD+Z6F/DMZYwSL6texE/OJXQKKdo2pw3dZ5/3ezvs4VdK4MjzEI6Krj/JCTMfc+hr2l2kHbkMI8AuH 6ZCAX++OKr8zqHEztLqdTIbpih14+NQfUeP2F3TV09OIWVspdyWJcCJ+Qek4E0Il/M/k3ttgJsJxFM msaKZR3FGFqftJMfTZYbF6XBKLUF48ORbl74wzk8awLAa2CsCYwG72urND5Ai+p+PD0ebv4Et9t+oo xUuHHsS+/oDVUVl/MfUiB51ivzZqBweIWuofElq/mG4ks0CAar0cF4hshhv6gnX9sx0005eq6EkfPy SUNKWpnQPtzLOXVVEPdo4SqxXw747HhqFuzNTv26NbRvyeJEwA17HrSWRot30kzzaErZZsjlNTjot3 qjwspD1kQfYjocf1p94+fIrUg/jHKI5YEbduetf0bui5sZuHoxBnDHi6ncndItP3wHJQaaTuYtr0q1 /mG/gX0ZyvzKiYhVvctOFEDMiU84jrsrdWxmvaD6T7VemUOJgcKap/EdsJ0g==
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
index 8978724b0b61..ddde28ce0d34 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6033,11 +6033,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6063,10 +6063,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6095,8 +6099,55 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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

