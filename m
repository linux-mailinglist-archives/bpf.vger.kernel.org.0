Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B04DC560
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiCQMCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiCQMCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:02:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7C1877D4
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:01:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm4-20020a17090b358400b001c68e836fa6so825187pjb.3
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jtjj12L4p2jI1/AP7XLsucHzFL+jyXE/45Pn2BO0ZR4=;
        b=c6REnKIK/v6YNsQWXdqa/7Ev7SPA3Kj+E6ESOviAlDbFTTX/7fMryxyC/X7pwriIe3
         spqRqJTtp+ckVA6n9rVaDgqRz+Vxl9vnA3SLFGNrOqwvxHAVTC5X7NfV4LDPJrzSDxtI
         bMC/g1C8KVh4hyAy1S92+vHVcAsKz3Iz3qSNn1YyTyN6L7VMJcxFqU7sjwNEFZfUgQ+2
         pMJ6gazHzUfcXf2itA3lT6UdQ7HCqSK9liWgYZue1COWgiLMIkeiDYKyWdNG8vmHdycM
         Uob4hBpiPiNmBacs+8n0fqtmz6EIuFqxuyls16viH8AY4mdmRaUtchE/0DlBk7tlBiwO
         nGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jtjj12L4p2jI1/AP7XLsucHzFL+jyXE/45Pn2BO0ZR4=;
        b=Pc9iYDcchNJ/CAqwXVXJ+ZHCUUBV5sAnMqtmldRy1vMffFlFHyPijYVvzPHjPegvbU
         RTA3ELI0y41jRdFDP5FKc1JILQq/gTEX7gJyRfiImrelWTyOqK2KkZ6RuH0xh9n46ITL
         3slI0iBPupTAJxTgdWfIm1WkheRBu09N6uRtDnBkGN9VtPlPyY/jyWBukur3mU1Te9kp
         8xCzNW8V64153PxaLkiqwyRmhRUdr3qdVwnAG+VgaMc850IJh9cTnSW6dJOMFKV54ce9
         /DDcKnCMjBPXYX5VSsVhyG439oxsk//gtFOwwsHsgR/FKJ+/0F7eaCWAkHXZR1xaTGpF
         cGhg==
X-Gm-Message-State: AOAM530RFWhO3T2qBkMV6lcSFQG9hy77txsimG1YpIJfHyU8I06e3MqK
        fOAMcuT9gaicTXWgqyv/b81RLM0h3GA=
X-Google-Smtp-Source: ABdhPJwIU7EQMS+AZkU2LcOJdXOz5QmMoVewfAtnaB3e3SEmM3itg1VOyyyYG4ZoMdiV0RijlTYxaQ==
X-Received: by 2002:a17:902:da8c:b0:153:2942:4973 with SMTP id j12-20020a170902da8c00b0015329424973mr4654572plx.103.1647518459376;
        Thu, 17 Mar 2022 05:00:59 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f737480bb8sm6636806pfj.4.2022.03.17.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:59 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 12/15] bpf: Teach verifier about kptr_get kfunc helpers
Date:   Thu, 17 Mar 2022 17:29:54 +0530
Message-Id: <20220317115957.3193097-13-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5640; h=from:subject; bh=PxDF+cQ4wAPNoHWU1kIIJz6tnLfrXs7veluG3VK+g8E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKkXCPY1Va4VgjgrcuV5Alr+T7i4aJpidAlaDkA jIInhniJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMipAAKCRBM4MiGSL8RysQ6D/ 9SJwGCJa2g1WVHwOAUow7sFdA4wDu9HBwCOvM7eOzf4Hi3q52jzGyJ7aTK1vOSeemxMt1YcMhiYMFY oY44C60aW1Qi/0n5qUsgGqc8we0EQmg5aEVUuV6/v7rdu1rlVCUorc9GDXA8ULQ2pQt7gRn5yMJJKl T2vfvbpQ8YFd1laiGrwHN+UeSbMQMiTmV8rawEibbyhdlf+/gUpgSbGUY2jpp6flUAs1t1khxG1uix 9x78CtOXw6rpq2Hm3Lv3jP4vFHvxskvi7LDtqNJbL0/Nd3mP5ciMgt8if/FnBDfj4o+D5C8gdCHvu5 LvauCVSjAoo0Z8qq/r1Xpr9wFlHlTYzEFT6bU3We8ucmzsF9+otXNLgS93Qc7vr+MQekVB/K6MK+n4 g/lpFb5Jz5Fzz5R1az26Frzopen4MS9kxVMVOJJnrQcp0NCTnj2MXuJ8pxClmSttvdBqT/xWuvcIFi gmTpEhG/QWPovyz4KktH4JZiICWP74KHlGl5R6uwVk8oACLsieCfCexitTvro1mTVariv7ybcnXHtC jKoXm8kfHl3k2kGZT7iPwXG2TQ7be+u9sRJIGv+ZIH3ZjSJGMfz+0jwjKhBQP8bMgCFVORz+ZnU944 S7yInesEmNnnTVFrLlDrC59ja7fk28noLEdx6/VCK6Kyh6fnxeTBKaC7NLUw==
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
 kernel/bpf/btf.c    | 57 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 5 deletions(-)

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
index b561d807c9a1..34841e90a128 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6068,11 +6068,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6098,10 +6098,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6130,8 +6134,51 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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

