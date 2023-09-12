Return-Path: <bpf+bounces-9726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3179C78B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F951C20A59
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDD1772A;
	Tue, 12 Sep 2023 07:02:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4568F44
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 07:02:17 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A4E79
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:02:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf55a81eeaso35459565ad.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502136; x=1695106936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ7auXMwt2HG2eO79EZb79CGVaa+fy/IcLCkXgQTU2E=;
        b=gJntY8cV6wapICpdZfEIKXOai/sUbNM/O2PEKnDVSxn2gbWVIXA5t6cb7ba/zTwtwZ
         WPKEc9Sb6BUUld9t3MOlZYSn36CNY7tArLtbbMwnTUTx3Mf5iaTfiZltVlVMV5xD4xQY
         X0FW9FZVCyndsjXUA8mh1czh/TU1HNC0/w83YQ7H09Et5h9x0ZmpeyHEFeji9O+0Vmxl
         xlJ0cfto8eS7a4We7zUxCHvM91RjLFelbmxD1yMP5jZN/ZD7K0XFwIEDw+SW7VfCMNOT
         Jep7/hQOIfpGe4m+m5bjhWqY0GvnE9Fwk1FcBmB1GqSj2HWUlw3/QSPGHW5JjFwi6oqI
         xDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502136; x=1695106936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ7auXMwt2HG2eO79EZb79CGVaa+fy/IcLCkXgQTU2E=;
        b=Rs2XSHnY+IMCElIusJ3xuze0yfEoyczfo3SafY69hwKw/dpJK5nMQHutkQ60kfGBqy
         TVVM51IfhJSKZsTNkFMi5sxLfGvMMq8Hi5Nz+PDrMvDut3WDEL2fIgIQIBh1KbmSDu8q
         U1uAvstEaTMUR/27c5mtjsdvNvv0DEJOGtFMLG7cXXtDHGXNYtSMSeuJXLozz2+ySjJF
         gTuDFUEwop5XIySoXojf9HGPao63pZ6Crip/RHu2ShxgWnzUnu1NpqUNNd/DaXcc1hYZ
         Swm+6x6azTNta3N3O5gK/JnktWBAMuWxkO2G8iRb1RLJdKZq0E9nGUYdjgpA+0xRUnKh
         o14Q==
X-Gm-Message-State: AOJu0Yws4job5gVDueRzfRpIndLgE4YeE1X6xbPM9EZ/jqyQbkhlWgCW
	3Q68y7KLj74EJpJG+7XOoSAVViQGdMNmct37Mqa6YQ==
X-Google-Smtp-Source: AGHT+IF1L3zszd0Qt7OImIjEsl7I2HCtreNc7f6XF9vPUvB7JGyRpTNFMRSxt9GUYpLv2X335et5TA==
X-Received: by 2002:a17:902:e883:b0:1bc:506a:58f2 with SMTP id w3-20020a170902e88300b001bc506a58f2mr10371670plg.46.1694502136153;
        Tue, 12 Sep 2023 00:02:16 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:15 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 5/6] bpf: teach the verifier to enforce css_iter and process_iter in RCU CS
Date: Tue, 12 Sep 2023 15:01:48 +0800
Message-Id: <20230912070149.969939-6-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

css_iter and process_iter should be used in rcu section. Specifically, in
sleepable progs explicit bpf_rcu_read_lock() is needed before use these
iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
use them directly.

This patch checks whether we are in rcu cs before we want to invoke
bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
let st->type = PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
reject if reg->type is UNTRUSTED.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2367483bf4c2..6a6827ba7a18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1172,7 +1172,13 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 
 static void __mark_reg_known_zero(struct bpf_reg_state *reg);
 
+static bool in_rcu_cs(struct bpf_verifier_env *env);
+
+/* check whether we are using bpf_iter_process_*() or bpf_iter_css_*() */
+static bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta);
+
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
+				 struct bpf_kfunc_call_arg_meta *meta,
 				 struct bpf_reg_state *reg, int insn_idx,
 				 struct btf *btf, u32 btf_id, int nr_slots)
 {
@@ -1193,6 +1199,12 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 
 		__mark_reg_known_zero(st);
 		st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
+		if (is_iter_need_rcu(meta)) {
+			if (in_rcu_cs(env))
+				st->type |= MEM_RCU;
+			else
+				st->type |= PTR_UNTRUSTED;
+		}
 		st->live |= REG_LIVE_WRITTEN;
 		st->ref_obj_id = i == 0 ? id : 0;
 		st->iter.btf = btf;
@@ -1281,6 +1293,8 @@ static bool is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_
 		struct bpf_stack_state *slot = &state->stack[spi - i];
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
+		if (st->type & PTR_UNTRUSTED)
+			return false;
 		/* only main (first) slot has ref_obj_id set */
 		if (i == 0 && !st->ref_obj_id)
 			return false;
@@ -7503,13 +7517,13 @@ static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_id
 				return err;
 		}
 
-		err = mark_stack_slots_iter(env, reg, insn_idx, meta->btf, btf_id, nr_slots);
+		err = mark_stack_slots_iter(env, meta, reg, insn_idx, meta->btf, btf_id, nr_slots);
 		if (err)
 			return err;
 	} else {
 		/* iter_next() or iter_destroy() expect initialized iter state*/
 		if (!is_iter_reg_valid_init(env, reg, meta->btf, btf_id, nr_slots)) {
-			verbose(env, "expected an initialized iter_%s as arg #%d\n",
+			verbose(env, "expected an initialized iter_%s as arg #%d or without bpf_rcu_read_lock()\n",
 				iter_type_str(meta->btf, btf_id), regno);
 			return -EINVAL;
 		}
@@ -10382,6 +10396,18 @@ BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_iter_css_task_new)
 
+BTF_SET_START(rcu_protect_kfuns_set)
+BTF_ID(func, bpf_iter_process_new)
+BTF_ID(func, bpf_iter_css_pre_new)
+BTF_ID(func, bpf_iter_css_post_new)
+BTF_SET_END(rcu_protect_kfuns_set)
+
+static inline bool is_iter_need_rcu(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return btf_id_set_contains(&rcu_protect_kfuns_set, meta->func_id);
+}
+
+
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
 	if (meta->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
-- 
2.20.1


