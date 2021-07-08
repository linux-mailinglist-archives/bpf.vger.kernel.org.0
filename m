Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19723BF372
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 03:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhGHBVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 21:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhGHBV2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 21:21:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DAC061574;
        Wed,  7 Jul 2021 18:18:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q10so3925188pfj.12;
        Wed, 07 Jul 2021 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5bXTMctrGiuYkOisntmpk5rXHpFme1XzOtvPb/WvUI=;
        b=qC+5tUc0MwhhyiWD7MX7esKBwG2JHd0brLtUd7XKFGo2ryvi21xPtBG7eGx908TEnR
         sVmIy6CkGFI7AfBVrZtArPbcYT16WZ9kuYsKObNZbdXd3SfUuS6aSMXDtQ10u4E4ectD
         jpMQGqYVKZz+U9+4jXUqJKIebHTkluMi+c38I1WuB+ZG2/kIvWeDgz5uN+bFzbRYSHvA
         cLS02X7cH9tff7iI10NkMKq5vfsr73m9pXUpWGT/AKZm6f7N58f8dml71kkAPxqwdMLo
         PWnR2vkKCO3yYqJZwLdxeP4IAaHepOk+na2XVAfpQ2MFGjVyKEdJzJMGzl23R0KQh/re
         BpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5bXTMctrGiuYkOisntmpk5rXHpFme1XzOtvPb/WvUI=;
        b=m9QM6dasoxAKYi64ggrk84tLVO326nx2sh142XmgpGQNuJPEKSBSjunoGEC847sd+v
         aM341cJ2EgxZvqdF+6z9ZrBK5TM0otZVhYGu0oJIvRZPTBIxLnaiXFr1lBlidKUfTTRX
         skbsM8cLJhs+KeljFb5zQHOS7HZnwXXlGs6zz35tBdbFnA0jvzDSkRonDD9Og/gPBih5
         p66Lmg4zAAxb16XRbp7aQqwN/g0wXpx0nzxssyGtHqh5VZ28ZfzlfTgdSGUVSfZ9psf/
         l3+9QDAzhgWB/sLXFJMlZixfpLdkqoDovq7NcTpKF8YM+v8vV6AFDjkEbDLin0LwVBct
         iPbg==
X-Gm-Message-State: AOAM532dV8EaRqywpa/z5fykI8615BtPJRWg4LZuedskwBKzLD387YHc
        IcDvjOH5vYGuE1bvuUNhV+A=
X-Google-Smtp-Source: ABdhPJyhYOZlZJncvFckZtLSLLPhOmH+05WFsCJPTaSxbjaKaJG/njs09wLJN8s2SU4CXt2QzDKbdQ==
X-Received: by 2002:a65:4382:: with SMTP id m2mr13053661pgp.205.1625707125878;
        Wed, 07 Jul 2021 18:18:45 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:9f4e])
        by smtp.gmail.com with ESMTPSA id d20sm417450pfn.219.2021.07.07.18.18.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 18:18:45 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 05/11] bpf: Prevent pointer mismatch in bpf_timer_init.
Date:   Wed,  7 Jul 2021 18:18:27 -0700
Message-Id: <20210708011833.67028-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210708011833.67028-1-alexei.starovoitov@gmail.com>
References: <20210708011833.67028-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

bpf_timer_init() arguments are:
1. pointer to a timer (which is embedded in map element).
2. pointer to a map.
Make sure that pointer to a timer actually belongs to that map.

Use map_uid (which is unique id of inner map) to reject:
inner_map1 = bpf_map_lookup_elem(outer_map, key1)
inner_map2 = bpf_map_lookup_elem(outer_map, key2)
if (inner_map1 && inner_map2) {
    timer = bpf_map_lookup_elem(inner_map1);
    if (timer)
        // mismatch would have been allowed
        bpf_timer_init(timer, inner_map2);
}

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  9 ++++++++-
 kernel/bpf/verifier.c        | 31 ++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e774ecc1cd1f..5d3169b57e6e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -53,7 +53,14 @@ struct bpf_reg_state {
 		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
 		 *   PTR_TO_MAP_VALUE_OR_NULL
 		 */
-		struct bpf_map *map_ptr;
+		struct {
+			struct bpf_map *map_ptr;
+			/* To distinguish map lookups from outer map
+			 * the map_uid is non-zero for registers
+			 * pointing to inner maps.
+			 */
+			u32 map_uid;
+		};
 
 		/* for PTR_TO_BTF_ID */
 		struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e44c36107d11..cb393de3c818 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -255,6 +255,7 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
+	int map_uid;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -1135,6 +1136,10 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 		if (map->inner_map_meta) {
 			reg->type = CONST_PTR_TO_MAP;
 			reg->map_ptr = map->inner_map_meta;
+			/* transfer reg's id which is unique for every map_lookup_elem
+			 * as UID of the inner map.
+			 */
+			reg->map_uid = reg->id;
 		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 			reg->type = PTR_TO_XDP_SOCK;
 		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
@@ -4708,6 +4713,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
 		return -EFAULT;
 	}
+	meta->map_uid = reg->map_uid;
 	meta->map_ptr = map;
 	return 0;
 }
@@ -5006,11 +5012,29 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 	if (arg_type == ARG_CONST_MAP_PTR) {
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
-		if (meta->map_ptr && meta->map_ptr != reg->map_ptr) {
-			verbose(env, "Map pointer doesn't match bpf_timer.\n");
-			return -EINVAL;
+		if (meta->map_ptr) {
+			/* Use map_uid (which is unique id of inner map) to reject:
+			 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
+			 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
+			 * if (inner_map1 && inner_map2) {
+			 *     timer = bpf_map_lookup_elem(inner_map1);
+			 *     if (timer)
+			 *         // mismatch would have been allowed
+			 *         bpf_timer_init(timer, inner_map2);
+			 * }
+			 *
+			 * Comparing map_ptr is enough to distinguish normal and outer maps.
+			 */
+			if (meta->map_ptr != reg->map_ptr ||
+			    meta->map_uid != reg->map_uid) {
+				verbose(env,
+					"timer pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
+					meta->map_uid, reg->map_uid);
+				return -EINVAL;
+			}
 		}
 		meta->map_ptr = reg->map_ptr;
+		meta->map_uid = reg->map_uid;
 	} else if (arg_type == ARG_PTR_TO_MAP_KEY) {
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
@@ -6204,6 +6228,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return -EINVAL;
 		}
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
+		regs[BPF_REG_0].map_uid = meta.map_uid;
 		if (fn->ret_type == RET_PTR_TO_MAP_VALUE) {
 			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
 			if (map_value_has_spin_lock(meta.map_ptr))
-- 
2.30.2

