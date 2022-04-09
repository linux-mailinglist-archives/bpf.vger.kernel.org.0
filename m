Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B974FA677
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiDIJfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJfN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C562CC
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r66so9861449pgr.3
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=titycMFWsYpdPYnGu7KcdN/YXHoPnsqgvIsuh26Ogho=;
        b=MdjMKuVGarrXVEf2CW21HEzmJJOdgrlbD/mOd43IpuHRJNTYTjrFD1m4vLJ6nh64Zv
         x/vzz4HU68ZzkDUhXhTbD03dPXeI4XkKtIyled0OYA0zu52B/P70lXiIoAOufSTLbobv
         5zIOSaqTAqXCwM/xiFavVeYitC5ZVt5IEGl6wn/Zkw4QBS+VCUnAHmcPH4/pq7DoSl5I
         Q2owAZA49y85fkD9YDCWxe9rnL3iLjCDWMF0O2f5nSD/fCVCg7A/3IgNpOZAXE2Hyusq
         4RMjmeT9U9fl7HwXwqItCLMThrlw9juhkkNyJyeJ/kdHDn9f2q/bfv0k/0gvI+8qn34M
         QWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=titycMFWsYpdPYnGu7KcdN/YXHoPnsqgvIsuh26Ogho=;
        b=1+gGrniXBFLKWIpHFRkCeHlbgjPdttujSZrgTHTIcFhaF18UMBfH0MEtuSHNFSa2UZ
         yI6LOdU0Yuh2kldCF3VBBJO69/h7waRR8JeGCLWOn0lvgKy5W3pV4Ukkhho8qtHqtNWo
         RWME8pYzbEwzhB0yycISF+1HwFWyTDBkTZ1xNHFpeVsiIVSA2oaYhaY0XJKwxAH8tvQZ
         HjnfHejpZyWzA6Jh9phvYKQ4d3/vwtCme4+9DfQw+xdjF2fBTmivg9LTOxKMF78z6SXH
         jISWOTO56jnOdVKo49D9LCEN4+CDY9wjm+7nAyIDwjTyfpaWp6zz1ipXjwhTHk7N29um
         ssWw==
X-Gm-Message-State: AOAM532H29kDVrPxm1V/L+v2LhL9GsYY7TQi0nnYkrNSQDup45WUJA85
        FkPA4GYqbJjsdPY/y3+F6+42GMtMJNg=
X-Google-Smtp-Source: ABdhPJyxDeEHTvFogz4PgzhbooZ7EDvkkcx9LGNTS0Cm1FU498bHwWvkK0yDQ8tBeK+jsTrAlOIejA==
X-Received: by 2002:a05:6a00:1da2:b0:4fa:f803:ddd1 with SMTP id z34-20020a056a001da200b004faf803ddd1mr23260804pfw.53.1649496785824;
        Sat, 09 Apr 2022 02:33:05 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id f14-20020a63380e000000b0038253c4d5casm23755263pga.36.2022.04.09.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 04/13] bpf: Tag argument to be released in bpf_func_proto
Date:   Sat,  9 Apr 2022 15:02:54 +0530
Message-Id: <20220409093303.499196-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6293; h=from:subject; bh=8VL7y1Bca1LP4eVT36W9GkDNPQRp1BiF9GmecurjM2M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0R+omazcaN0X/0Mh7lfvmPWhBfXrENq6IXv9n 2ZicbMuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8Ryh2/EA C2wgBIslaSQOWtfNaUc26wdzHv7xO6WMBhus6kct+0KbOEbZHAUZtAtSFPdR69qOfRLhZaPNUxS32q 1PWrVSFoWddH9Y+VyY5PoT9HJ/AbRuTMf9tac2BeCUTYTWderwwufQE5rrDVISouc/bbUlDs6AEbJu hc2oSB0IDr3Db9bqgZO13wXLK0ypn1oDrjkbN3k3Gu1AuPl/4xIZWkc2J/3VypDv7DgU07y2qGXIaR hDmlmPgWfbiV7mKBFkHMX7eyCOu3MKU8TdCU/iayvPhUDrGNenLxu+XVnQIthw3zvB6diQ6wjHVEnM ZWEMn50Yrcq9EW3IqvyDOFlA9tFKsULYhuTH67r9VnBTAmyQtziD7+U7WLvid3dMDQVVbE+0+gJuJu LxNVdGYD6Tshpq+M8DB9TINq9KQlElPt09afBhXOQBkUTn9Lk1Y8slEKNhZTlNPohCIasPxVmff/7c CUuxzN5tQVTk3YOsTorje3DJvTZKFyRiI45y2rDuDxqAu5W/f4CoQyq7ZuJthCLoZmO/cssCpB/TIm 8YUJCOuLUd+l6GE6+3tVZ5kkQOPwvnVLauaptC+nREDnIPdw1aapsc4z4KtKMDLegvEDcRhbszBsQy uGzqtJKx8lZKur7sfvM9Yi1w54lB7gZBIQRjpSb7Dg4AvHCgl323qzyugbmg==
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

Add a new type flag for bpf_arg_type that when set tells verifier that
for a release function, that argument's register will be the one for
which meta.ref_obj_id will be set, and which will then be released
using release_reference. To capture the regno, introduce a new field
release_regno in bpf_call_arg_meta.

This would be required in the next patch, where we may either pass NULL
or a refcounted pointer as an argument to the release function
bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
enough, as there is a case where the type of argument needed matches,
but the ref_obj_id is set to 0. Hence, we must enforce that whenever
meta.ref_obj_id is zero, the register that is to be released can only
be NULL for a release function.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  5 ++++-
 kernel/bpf/ringbuf.c  |  4 ++--
 kernel/bpf/verifier.c | 46 ++++++++++++++++++++++++++++++++++++-------
 net/core/filter.c     |  2 +-
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e267db260cb7..a6d1982e8118 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -364,7 +364,10 @@ enum bpf_type_flag {
 	 */
 	MEM_PERCPU		= BIT(4 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_PERCPU,
+	/* Indicates that the pointer argument will be released. */
+	PTR_RELEASE		= BIT(5 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= PTR_RELEASE,
 };
 
 /* Max number of base types. */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 710ba9de12ce..a22c21c0a7ef 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_submit_proto = {
 	.func		= bpf_ringbuf_submit,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
@@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_discard_proto = {
 	.func		= bpf_ringbuf_discard,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | PTR_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01d45c5010f9..6cc08526e049 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
 	struct bpf_map *map_ptr;
 	bool raw_mode;
 	bool pkt_access;
+	u8 release_regno;
 	int regno;
 	int access_size;
 	int mem_size;
@@ -5300,6 +5301,11 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
 	       type == ARG_PTR_TO_LONG;
 }
 
+static bool arg_type_is_release_ptr(enum bpf_arg_type type)
+{
+	return type & PTR_RELEASE;
+}
+
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type == ARG_PTR_TO_INT)
@@ -5532,7 +5538,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		/* Some of the argument types nevertheless require a
 		 * zero register offset.
 		 */
-		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
+		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
 			return 0;
 		break;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
@@ -6124,12 +6130,31 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
+static bool check_release_regno(const struct bpf_func_proto *fn, int func_id,
+				struct bpf_call_arg_meta *meta)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		if (arg_type_is_release_ptr(fn->arg_type[i])) {
+			if (!is_release_function(func_id))
+				return false;
+			if (meta->release_regno)
+				return false;
+			meta->release_regno = i + 1;
+		}
+	}
+	return !is_release_function(func_id) || meta->release_regno;
+}
+
+static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
+			    struct bpf_call_arg_meta *meta)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_btf_id_ok(fn) &&
-	       check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
+	       check_refcount_ok(fn, func_id) &&
+	       check_release_regno(fn, func_id, meta) ? 0 : -EINVAL;
 }
 
 /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
@@ -6808,7 +6833,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access = fn->pkt_access;
 
-	err = check_func_proto(fn, func_id);
+	err = check_func_proto(fn, func_id, &meta);
 	if (err) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
 			func_id_name(func_id), func_id);
@@ -6841,8 +6866,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return err;
 	}
 
+	regs = cur_regs(env);
+
 	if (is_release_function(func_id)) {
-		err = release_reference(env, meta.ref_obj_id);
+		err = -EINVAL;
+		if (meta.ref_obj_id)
+			err = release_reference(env, meta.ref_obj_id);
+		/* meta.ref_obj_id can only be 0 if register that is meant to be
+		 * released is NULL, which must be > R0.
+		 */
+		else if (meta.release_regno && register_is_null(&regs[meta.release_regno]))
+			err = 0;
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
 				func_id_name(func_id), func_id);
@@ -6850,8 +6884,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
-	regs = cur_regs(env);
-
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
 		err = check_reference_leak(env);
diff --git a/net/core/filter.c b/net/core/filter.c
index 143f442a9505..8eb01a997476 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 	.func		= bpf_sk_release,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_RELEASE,
 };
 
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
-- 
2.35.1

