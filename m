Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B217A502D75
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355701AbiDOQHM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355698AbiDOQHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:07:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F117A9B
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so7576238pfu.11
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7pHtsy/Dx/Bbdmy1yiGkZi7S1svy4/VhI7xUrS2Az8=;
        b=Nt+2gLTsvyzISJAW5h0YPVlMCng/mzle2vnO/mMlQJ3hqmyRSvsxHD7/ijjnxVU2J0
         odJkPs29aoDTdkT9Ige4J0X+sQDvhhfYKdjo4GFC1yHE3n/wSkdzNaZGwSUylxO1mswd
         yJrfKVbQbdxeyrxfVZ6tVMG9rHLZEnSQF1NeFcrz2Jme1MNCy65Vx9kiUiic9Z2YTfhY
         hUB+sLIUoRDlymlcFXSVLzPeuVjqPtj7F2pygEFGvmkS6LzPBA67TAveR1vpJp7kXZ2H
         0ZbEJDHkJCbvNqSCoVHNNZeGGCZwOh0p3YtlDmec+g5X4Ft6BMxMopyXp+3wI9yw1Iuy
         es9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7pHtsy/Dx/Bbdmy1yiGkZi7S1svy4/VhI7xUrS2Az8=;
        b=JIx31QOytDB+zi9Y/gSsixD56WmUyAuTEL6scp4fgqyh214sFKYOIa8ACnN6LGck1A
         liXDpIlXhdCdlLiYpM3gXwx9qBzg1KX2jn4IJ0xPcE5RGZ1En90P7HaerCX5PrQnxxKj
         epQBpT+NLIKgvyupaORopYzuT52we+T75pwnrnS71dxoNl4QCtyOCIJcRAXUmxOI+4NJ
         m6uRrY71jHnsN0pUUc3rv/Hg5h4Nj+WA/Rel7xyf08VFjTj/kVZD9MW1l+xHIailD0Vm
         Rb7joy7om5CSA2zAMkVYRmeZuRg75D30qwc8o5TbmQTmYK15HJjuCQNGWPsn8laoJI5h
         cgVQ==
X-Gm-Message-State: AOAM5303ptCAg+26eiKSCH5ea4pxp75/t1VYiVCjP6+Qo3QgBU45V4bi
        sohUrFV3ls1wCXfu6JXnh7fBfulke3k=
X-Google-Smtp-Source: ABdhPJxK2ijXoYflomrU34yB1kE6PlQbPo4Y3cPmymSEfeg7yXDgzmOVeCoAfJzF+w6tt+RLXZwBJg==
X-Received: by 2002:a63:1e23:0:b0:39f:ea07:305b with SMTP id e35-20020a631e23000000b0039fea07305bmr6729392pge.246.1650038682850;
        Fri, 15 Apr 2022 09:04:42 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm4806881pgh.67.2022.04.15.09.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 10/13] bpf: Teach verifier about kptr_get kfunc helpers
Date:   Fri, 15 Apr 2022 21:33:51 +0530
Message-Id: <20220415160354.1050687-11-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5664; h=from:subject; bh=0IonrH91nqSMAX9vCU8yazLXQ1XlFXSPOlW5WuZfVvI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdCXCjzZmfQa3XRvsi5vQ73Qf+WRReGRdKoa3AV 8ru78hyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQgAKCRBM4MiGSL8RyrppD/ 9Un9j//GX7ZoRsrhc9bqwmSJI72OGaYHIQcZng+AFRNfQZKavigE2GIXaU9uxMBGQwIJ0/ZG9g0+OF WPSbQ85v8+J0ZPHg+s0jiXddpnpey+Z2iqkbt6nhlPjcw8zZDJUCUiLrgyrUHIzgoh6NSoFffW5Wng ji8ALG6IPpTiFhP4bzAC+8mYb7ELb6LS2RjCXw+0aqZ3Ad0LFhfWc6xtFpBdPsrkzNlWnjh0GqNsA0 DKIdvzoA2dR/IjWTCiX+Y9vRy937SfuprCeMgQr0IUcCqdp9YRTSslBz4Y4zUYZjiaKfh4lxl6gBuo mqq4ANZiM6QtMroiVifbrATKD2hyJnAEVd/mNLSNNbP3txDXZm2fCdPo+/cRMxRNZbe8sXUF/aGSkt QZDuTb69LVwpWSAnntIbDizyWNbsxELx14Y8eJ8C3EBQvwkWPbY1Uw3MvhPkTOF6WkgMvKF3mHaD6m MSZEXq3fPhTAPhqxPBhKspBSO0FkM+PtzrwkZkCxHlAki8o/3XaBUE352C0wY+EKvMuSGToDvM3mgn tDOdOQcMMho11pMwnqppkVMrMBYFwBZsY9GINUmpR1b4i7ceIAQvOD7e1T8ioTIxdFN51fxULGtiZ1 Zr6aUto+Mprs90J5wTbSbYgwOYF3KE/3xn403rqrpjoGnH+7D0FdYjoW/yiQ==
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
index 062a751c1595..7155874f1902 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6035,11 +6035,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6065,10 +6065,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6100,8 +6104,52 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
+			if (!off_desc || off_desc->type != BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
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

