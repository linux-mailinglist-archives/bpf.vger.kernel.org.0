Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7174E1C65
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiCTP4z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbiCTP4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:56:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378BC54194
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s11so13522610pfu.13
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oy/G68PKrNRew4ZKE6GOJcSvayUTQIzyyfAhHUa3f0=;
        b=A3w7oMmayb1GgfhYIWQPQ/5CAtSL1PwPR61JebJAsl8f/1grG5X/UYTmAzTL9Mc9Fj
         +5pkd5kqheZelXgi8vXrbOM8LW81tBloVgiaZIh6j/+tvT2ZRJV1ZWRRaOkSy9m81jp2
         W8uMrwau9WeOceL7PZuZnpDy9ZiHlY15oWKa5WtmqK1fleCyJPQKShJsHE8OC6auqm8t
         KnTfT/RYidReu/OF03vSo7qgeypkRbFAdnZjVhHtPvG9qHDdV9L5Wxfo2T6wABDul9vt
         bDMN5aInYv9XQY4KXMfHgtSLUnn9Oru20Ty+n//cerHNvrL6dppbDjSw4qzI2evKym7J
         jQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oy/G68PKrNRew4ZKE6GOJcSvayUTQIzyyfAhHUa3f0=;
        b=AJje+wAL/wbnLYUsBxO4hoWJSCHyo6W5ChH8v2z3TwXNGq4NUj/pCmLo0YxR0VXRoH
         wvoF/Ulxo0hl8C0swHnop8KGfds7xWxiWdj+b2vYMimfZjVpLGUrf5Qq0bTx3Jy8gyjn
         +DDWDC4uWZ8ElnzFYCOUVATv/ZJ2lvFpVDcPOn1yVLdXlCZVhupXimf9O4V2KD+uxRUk
         bcKwixiqJBmohp7XfSrl7qSVVfdXNT8OafMHjnMO1bJVuwHhV9K79vYnlcw8VzL2MYX3
         wEDFowVclz6/BnvJ5iKYkCtJkvEJiPSlnAawvKeNgWludrYG1SqGb/joAG9Z66+xUS8c
         M66g==
X-Gm-Message-State: AOAM532tXaArMTCsLodfHZTMnlMRNtmfKV15ULN9V9lEgHYLIMe3aklx
        BPRXkJ5JM6EagKgd505HZRyf9M0CC80=
X-Google-Smtp-Source: ABdhPJzfttmJ7BGGpM6CtXG9njrQoF206lznaYjSAhrCiBhjb+SJWZMAIdbWtJbLycyt2QwbV0Nu7w==
X-Received: by 2002:a05:6a00:c93:b0:4f7:c76:921f with SMTP id a19-20020a056a000c9300b004f70c76921fmr19478924pfv.73.1647791730564;
        Sun, 20 Mar 2022 08:55:30 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id d24-20020a637358000000b003823aefde04sm5613621pgn.86.2022.03.20.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:30 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 04/13] bpf: Indicate argument that will be released in bpf_func_proto
Date:   Sun, 20 Mar 2022 21:25:01 +0530
Message-Id: <20220320155510.671497-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5395; h=from:subject; bh=JQxBrJfBnHlT/mhhv+KRR8AAKWTEKqO5dyF4aYXpZ88=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00xTBpeHaT8slJR3mSTCefOFDeg6lABXodJTP+h 36EuxqmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMQAKCRBM4MiGSL8RyhuaD/ 9A1tG+4NWo5jNkjmWN6WRfrXSI2HOoFut8hoBr+OdEClQueQGwIXdVxo9ciwVlceO0jRfLrlA9y+px Ao+P6F4M3L3kt2fr9MAYIQrvwdsAXaHLBeD0NZgArlShAndFIz5Y2i0wyW1CYWAem9FE5lK9ZmwIge s4xqzITjcSu580eE+AafPIrkNLMOIP+oJ1MgOV7yzlAj1WQ4gY6Vlx5HeQPkizughhxP0MosAxsbQq CDzZJEAoC8vIe55ruA/z3RdoXCCSMdgeOLQiAHZmFuqxcYgtnw0RI6QjWWv6HV2hc84BPD5MxAVWki hazdHXfr84SpZw+/vEWGWSYGJYeHP9J1IJEEMoGUFNvWp1QbFwMzY5Bp+CuuJJcoY6JdZkxfNFUYLd Nxe/chRCjzMe8ugNWL/oc2zql5tEt6fapHkkDySm55Gu8PJR8q0bYpZiuISPm8Q1b/mqcvbZ22lzem 5MlZrGadFP4ZvydCh8KtOx9V8Eym3RRB/PIcrddBXmqSwfd/GGuuc2zumz+6Zp6P8ZH4K3+z2RIjbG DHn1qb6+CX9rX5MZbFSQzT1ukcETr3O7luNy8KtbES7Hk8dowBXinfEsjuavzcOsgP/Z27gtNMelu/ kFip6Rap6pqfgm6/naYreaV5v99IHcquaTQi8kykgyyAY2lkLIIXtrMCi1IA==
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

Add a few fields for each arg (argN_release) that when set to true,
tells verifier that for a release function, that argument's register
will be the one for which meta.ref_obj_id will be set, and which will
then be released using release_reference. To capture the regno,
introduce a release_regno field in bpf_call_arg_meta.

This would be required in the next patch, where we may either pass NULL
or a refcounted pointer as an argument to the release function
bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
enough, as there is a case where the type of argument needed matches,
but the ref_obj_id is set to 0. Hence, we must enforce that whenever
meta.ref_obj_id is zero, the register that is to be released can only
be NULL for a release function.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 10 ++++++++++
 kernel/bpf/ringbuf.c  |  2 ++
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++++++++++------
 net/core/filter.c     |  1 +
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f35920d279dd..48ddde854d67 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -487,6 +487,16 @@ struct bpf_func_proto {
 		};
 		u32 *arg_btf_id[5];
 	};
+	union {
+		struct {
+			bool arg1_release;
+			bool arg2_release;
+			bool arg3_release;
+			bool arg4_release;
+			bool arg5_release;
+		};
+		bool arg_release[5];
+	};
 	int *ret_btf_id; /* return value btf_id */
 	bool (*allowed)(const struct bpf_prog *prog);
 };
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 710ba9de12ce..f40ce718630e 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -405,6 +405,7 @@ const struct bpf_func_proto bpf_ringbuf_submit_proto = {
 	.func		= bpf_ringbuf_submit,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
+	.arg1_release	= true,
 	.arg2_type	= ARG_ANYTHING,
 };
 
@@ -418,6 +419,7 @@ const struct bpf_func_proto bpf_ringbuf_discard_proto = {
 	.func		= bpf_ringbuf_discard,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
+	.arg1_release	= true,
 	.arg2_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 744b7362e52e..b8cd34607215 100644
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
@@ -6101,12 +6102,31 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
+static bool check_release_regno(const struct bpf_func_proto *fn, int func_id,
+				struct bpf_call_arg_meta *meta)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_release); i++) {
+		if (fn->arg_release[i]) {
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
@@ -6785,7 +6805,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access = fn->pkt_access;
 
-	err = check_func_proto(fn, func_id);
+	err = check_func_proto(fn, func_id, &meta);
 	if (err) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
 			func_id_name(func_id), func_id);
@@ -6818,8 +6838,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -6827,8 +6856,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
-	regs = cur_regs(env);
-
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
 		err = check_reference_leak(env);
diff --git a/net/core/filter.c b/net/core/filter.c
index 03655f2074ae..17eff4731b06 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6622,6 +6622,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_release   = true,
 };
 
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
-- 
2.35.1

