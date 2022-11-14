Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A45628913
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiKNTQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiKNTQ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:26 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08727146
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:25 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q1so11056798pgl.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWIbGV+DYS+tw6h00wRIr63WFHoC77MSAByntOXPym0=;
        b=RmViMI2JC7KuJv3K8h9u0VWLXNov7IfPQEKLA52bXn0EjTt1szv5KVHSWBnmaImroR
         u+YPwtndO7QdbB0f1nbRFmtUS4qOVGuK6D5ir6ddCMZqS7i9NbmtMcCvXB5nALZbnwj7
         ukhORugYvXgSiWBxsay9pS9vl99KUZoXM1xRxQVpkIQv0WDQ7Iq8+IhZkqd6dL90Np+K
         zDhQhub4sFv4YaKSfeBOojNdCa8wrWOycxTGjPq4Bf95FmgDCHh2UnYNYAIynbHpjLDb
         Fz49MdGunH/WTRYO/KPtWO3LLy78j8B94s/KC07zGGLhmpXn21fhDt+yvKn0r7oAwP4k
         PT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWIbGV+DYS+tw6h00wRIr63WFHoC77MSAByntOXPym0=;
        b=Ax0FsVWkU9IKi6RSSPQq0Wba9TB5UWBgzuSmtPmpL8oNatmpTu8ivv9Ov5pEy6rk2w
         Bbrwqg+FPL+Vwj5tZPSm6L6pE/v6ecA7LvSxliG9/7FtoOc7706VbSYS6vMUy0S2GTaN
         Id6pK5ReCW5wis+qRar8hlsTRCgXuOGlMq7F2ip29/9shvMyZDbRy/0Onuh7z4aYmpWW
         Pz13mUr8gg1CXNZBmHsulFhbwOp6q3/nQ1Rqivko0KFuwWEYvraUnQqewjWeQWEzA8jq
         //DM8EZv5zGS2MThPCHapOh18j6Koc8xUr9jNN8BZzo05NozD2CdEHheUXJwdmxy8QnT
         dOUA==
X-Gm-Message-State: ANoB5pmZax8i0AQqBmrSw2h4DmEa/qjWel28mpFJu7LnlvxKVg9Oxpd1
        qBR7STkwtTk/91qUZOXk3p7ZYSi5FONefA==
X-Google-Smtp-Source: AA0mqf7733W5Yq5SD2eSeNZO+oyW+7kSIUoyoY7Bx8rgS0QcgnMlXheX3J7GASvQBuZtJAE+/pLbtg==
X-Received: by 2002:a63:c001:0:b0:46f:e657:7d25 with SMTP id h1-20020a63c001000000b0046fe6577d25mr12517541pgg.347.1668453384903;
        Mon, 14 Nov 2022 11:16:24 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id t21-20020a1709028c9500b00176d218889esm7836781plo.228.2022.11.14.11.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 11/26] bpf: Allow locking bpf_spin_lock in allocated objects
Date:   Tue, 15 Nov 2022 00:45:32 +0530
Message-Id: <20221114191547.1694267-12-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6766; i=memxor@gmail.com; h=from:subject; bh=iEwNzupo2wEP+IFJ7zBWqno/omrHd/+4eO1JPSsEq9c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJ8xKPku/FblQ+LroVn2lest98veZ0IYNimwbR 8JvF7TyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8RyhUUEA CQ4ex9ezQBZFDRvpAltgcu9RGgzudwwD1w6NW2l6Qzk5Zz8rzL2rslWri+XWyBLybvFS2dAblKWsqL zQnLr/9DeRKALPic5vtZKWm/9OFtKbYW9hinC+FvJXoRxGtrjcpnNt9deCemwDn6MdvEBodxgA7hh8 5/Gs+s04vvJoejWqsFRmZQlzGj/QLrKahWpwFkopNnb+QCQmkdUpL5LXAyHgMjk06twpD6fxcBhyzT xwr05WvR4aYSOfQBJPGt7PVbvkK8Xa/laupI+ZY0t4UOrVABHc+PlbGyLHB/wYeeaWvsbIigmAmbTN kGPN7RGYPa4ktnd7yc3sLowxZhhU4eG4Yl+EW1s1j3dEFuYiI6qFQAL3VXR6Fv4VDMW82fPtVjijTY 0du44UMediMzzdr/tLsOzsnrhZeax7Kr0urjFB9VSQpq4332qTblkpmIj9+DUDWMYPxjZV7omN8hiY JppyiBapSgsOEYSlByQ+ziAGo5JOFWICFkQFBBiQGcCrEpaCK+xc/QYbJP5rR6Xm7LfBmKkxDTvLMs SOca+zhTn8XEPUu11JLoXvMJbX3NgKF47c5fskKaJ8B6Q9Cw528HhJJDrNjpnohkbpgXgdkabUnKvF 1kWaIesvAS51KbbhWjrbOWSlY4gtEW+wkd7jJlDsp7o+2EvSh6eCZlH6TdeQ==
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

Allow locking a bpf_spin_lock in an allocated object, in addition to
already support map value pointers. The handling is similar to that of
map values, by just preserving the reg->id of PTR_TO_BTF_ID | MEM_ALLOC
as well, and adjusting process_spin_lock to work with them  and remember
the id in verifier state.

Refactor the existing process_spin_lock to work with PTR_TO_BTF_ID |
MEM_ALLOC in addition to PTR_TO_MAP_VALUE. We need to update the
reg_may_point_to_spin_lock which is used in mark_ptr_or_null_reg to
preserve reg->id, that will be used in env->cur_state->active_spin_lock
to remember the currently held spin lock.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  2 ++
 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7bc71995f17c..5bc0b9f0f306 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -336,6 +336,7 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
 static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
@@ -358,6 +359,7 @@ const struct bpf_func_proto bpf_spin_unlock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d726d55622c9..070d003a99f0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -453,8 +453,16 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type == PTR_TO_MAP_VALUE &&
-	       btf_record_has_field(reg->map_ptr->record, BPF_SPIN_LOCK);
+	struct btf_record *rec = NULL;
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		rec = reg->map_ptr->record;
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
+		struct btf_struct_meta *meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
+	}
+	return btf_record_has_field(rec, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -5588,8 +5596,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_map *map = reg->map_ptr;
+	struct btf_record *rec = NULL;
 	u64 val = reg->var_off.value;
+	struct bpf_map *map = NULL;
+	struct btf *btf = NULL;
 
 	if (!is_const) {
 		verbose(env,
@@ -5597,19 +5607,32 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			regno);
 		return -EINVAL;
 	}
-	if (!map->btf) {
-		verbose(env,
-			"map '%s' has to have BTF in order to use bpf_spin_lock\n",
-			map->name);
-		return -EINVAL;
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		map = reg->map_ptr;
+		if (!map->btf) {
+			verbose(env,
+				"map '%s' has to have BTF in order to use bpf_spin_lock\n",
+				map->name);
+			return -EINVAL;
+		}
+		rec = map->record;
+	} else {
+		struct btf_struct_meta *meta;
+
+		btf = reg->btf;
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
 	}
-	if (!btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
+
+	if (!btf_record_has_field(rec, BPF_SPIN_LOCK)) {
+		verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "local",
+			map ? map->name : "kptr");
 		return -EINVAL;
 	}
-	if (map->record->spin_lock_off != val + reg->off) {
+	if (rec->spin_lock_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
-			val + reg->off, map->record->spin_lock_off);
+			val + reg->off, rec->spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -5815,13 +5838,19 @@ static const struct bpf_reg_types int_ptr_types = {
 	},
 };
 
+static const struct bpf_reg_types spin_lock_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_ALLOC,
+	}
+};
+
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
-static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
@@ -5946,6 +5975,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 		}
+	} else if (type_is_alloc(reg->type)) {
+		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
+			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
+			return -EFAULT;
+		}
 	}
 
 	return 0;
@@ -6062,7 +6096,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6680,9 +6715,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
-			return false;
-
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return !!fn->arg_btf_id[i];
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
+			return fn->arg_btf_id[i] == BPF_PTR_POISON;
 		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i] &&
 		    /* arg_btf_id and arg_size are in a union. */
 		    (base_type(fn->arg_type[i]) != ARG_PTR_TO_MEM ||
-- 
2.38.1

