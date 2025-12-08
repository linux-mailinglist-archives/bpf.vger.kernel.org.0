Return-Path: <bpf+bounces-76237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF2CABCC6
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 875A73003527
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9238256C8D;
	Mon,  8 Dec 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQj3boEf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D4253B59
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159638; cv=none; b=qhxjXM7w3RB0Ifv0KbPv/t7BfkO+kwr+MmTmtQPzNu/OOacK3ogQyAsWjZCzn1sSbSdLtlyPDgpMMH9s0h1omlD3A/N6++o3KFzvPNCBjCHTCNCIbfCprfcK3uDBBVRcp4DM5PoYyERSUWgssrWkE509bk/u021hGNgFCQl6V3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159638; c=relaxed/simple;
	bh=1TcVRhtuW44UlRc6yVvrKz/lXSs2PwM+4yUHUPEscoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q41iwOPIG8NrhfVy50+/SUweZf08lzjOaWnGN1euU6Bx4x1Fz8EgINF4TeQxr1HhaQF6rSb8ANchmD+ICYZuSHA4cNrE6IbSxkTkg0DHnCk/N+x2LB16/Cotko2P1mQbrGJKqwn2KHUztnGZjVlS/i/V7H1KrtCAGdLh0lCvzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQj3boEf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297dd95ffe4so35314615ad.3
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159631; x=1765764431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etCCOiXR8x0v5LmWoSQ60BkC9aw+g+h9LZCI19rrL8Y=;
        b=LQj3boEfqoyGWEGtnrg1Ve3nvu8tvehNT/VR1Fvf/fQY/s9lOkx7heR+iBykrH/ne2
         a4sm8sWDo6KYT6K7AO5tm5hvUdIUgR7HxPnKdTCgOpGVJUVyXZTdz/9cX6mFH8v8NjR4
         xvgCPFng2d2qcCMRvcdXdIYhWUBlejpsSRlxlxp+UupLxLLsKdKtfcLA1la+xl79ofaG
         BFJtHffWdOVOyf2a0xE5xz4S49gnRocBh0hH4q0Wplj0z01gSJ7utpiWxZhGh0ltSWgP
         yXidTay0Zj6GpbzklQIYEOPmZCvxsDDnl/+7ngz4VW0l3uHIvGAJUA51YJfx8gQNRy/k
         KQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159631; x=1765764431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etCCOiXR8x0v5LmWoSQ60BkC9aw+g+h9LZCI19rrL8Y=;
        b=re/Krrgq6rAkXtJeGAalnF+FS1IonlGursVCCCZQatH1vZoaf+nip9Qe8m4atThxA7
         sC9Qhkg9gZTpighKNrC+2UViTgy4sQYLJUCIJDRn+nsYjPZynMihWfNrgLPEIdosUlPW
         hlYAQYXmoxjWNki+UFjGHtM95ii2G9vOqZvaT0RWXy49bxLuS6IhwfcHmTeduQbtcJYp
         RoYIPKCe1VPJ9YqQ+0Y4EiOC3Q9oK9eELC/gNnWQ8gd+SoLaU4HHnsC/BL0oDVV/qoF3
         A132nrDnWAJZ9sKaXd14vggr3yskZpbUobzT4SyXhVj10f/jmayIwjGgVnYI2PnpJtVA
         cE3Q==
X-Gm-Message-State: AOJu0YxHZ5eCbWDCeZr5PU5uwfbKiDQ5IArNPbDo7xPIIF5dQAb087sW
	IWisoP2LhI5GeuucuMPfNbkWS6Tm5P+cHIcDT2JJ7HpwrPZanV7qzJA/HsjBI4GG
X-Gm-Gg: ASbGncsQAqzUDtjZSA+A+ypOx9dJg/Ha4tBKYKosZsy18LZxJyS2EgdhmvRTtdLG+mI
	HuQU8ITijFBNTzGRwb2FIM9BRKTw8fphw0r7uaHO3DrG/hhP9L5VVliurTJ1gSPPdc0UCLb5T5Y
	Hese3WMXDmwP1kbT0R5GHT4KbVTZE2EKayfIYeodwJ/V9QlOVKVx3RhYc6nYSztCiTHjqraZJ4Z
	e56Yc3SE3i9jsHiXirSqDs49n3xxDEJb0eTV4hJuFSuSZJFXtw8HXe8khGd8TgaOFB5g3+rqzq7
	5Kt0pS0Ayy9rv5z3LnTuH5NpJESgYfMJdBq135CZru3ZLa1QGgtAB4NjbTWc3jsgb1FyHgwv7ce
	m03qq2YYUzBLbMWkboYy1GHrCiEGOzEZQ/9pH8zMJmGKVImRU0zSKddSZLUvjnpbfBoGvRhT5q7
	Th1x0eHg==
X-Google-Smtp-Source: AGHT+IHGLMgBFX8Nsvn0ky8pL7CT2dy72Vo5PL4/mSRQsvgR5OqFvrW3bGVjidkzpNxO9/Sxw2NmVw==
X-Received: by 2002:a17:903:4b0c:b0:274:3db8:e755 with SMTP id d9443c01a7336-29df5e1b7f0mr47409115ad.30.1765159631326;
        Sun, 07 Dec 2025 18:07:11 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaac16fsm105689175ad.87.2025.12.07.18.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:07:10 -0800 (PST)
Date: Mon, 8 Dec 2025 11:07:06 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 3/8] bpf: Create inner oracle maps
Message-ID: <7229111ef814fd10cac9c3a14d38ddb0f39dc376.1765158925.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

This patch creates the inner oracle maps that will store the information
on verifier states. Each pruning point needs an inner oracle map. They
are called inner because they will all be referred by a hashmap in a
later commit, indexed by instruction indexes. They are also referred
in the oracle instructions, for easier lookup from the interpreter.

For the inner maps, we can rely on array maps because at the time we
create them we know how many states will need to be saved. They won't
grow after program loading so they can have a static size.

These maps are not only useful for the oracle to iterate through states,
but also for debugging from userspace after we hit an oracle test
warning. Userspace should however never need to update them, so let's
limit permissions accordingly.

The bytecode ends up looking like:

    0: (bf) r2 = r10
    1: (7a) *(u64 *)(r2 -40) = -44
    2: (79) r6 = *(u64 *)(r2 -40)
    3: (85) call bpf_user_rnd_u32#28800
    4: (18) r0 = oracle_map[id:21]
    6: (b7) r0 = 0
    7: (95) exit

with our special instruction at index 4. A subsequent patch teaches the
interpreter to skip this special instruction at runtime, to avoid
overwriting R0.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf.h          |  3 ++
 include/linux/bpf_verifier.h |  6 +++-
 kernel/bpf/oracle.c          | 64 +++++++++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c         |  8 ++---
 kernel/bpf/verifier.c        |  2 +-
 5 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 28d8d6b7bb1e..6bec31816485 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -617,6 +617,9 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
+int bpf_map_alloc_id(struct bpf_map *map);
+void bpf_map_save_memcg(struct bpf_map *map);
+void bpf_map_free(struct bpf_map *map);
 
 struct bpf_offload_dev;
 struct bpf_offloaded_map;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e4c8457e02c1..a93b5e2f4d7f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -575,7 +575,10 @@ struct bpf_insn_aux_data {
 	};
 	struct bpf_iarray *jt;	/* jump table for gotox or bpf_tailcall call instruction */
 	struct btf_struct_meta *kptr_struct_meta;
-	struct list_head *oracle_states;
+	union {
+		struct list_head *oracle_states;
+		struct bpf_map *oracle_inner_map;
+	};
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
@@ -1109,6 +1112,7 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
 struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 				     const struct bpf_insn *patch, u32 len);
+int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
index 924a86c90b4e..66ee840a35eb 100644
--- a/kernel/bpf/oracle.c
+++ b/kernel/bpf/oracle.c
@@ -62,6 +62,53 @@ int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx)
 	return 0;
 }
 
+static struct bpf_map *create_inner_oracle_map(size_t size)
+{
+	struct bpf_map *map;
+	int err;
+
+	union bpf_attr map_attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = sizeof(__u32),
+		.value_size = sizeof(struct bpf_oracle_state),
+		.max_entries = size,
+		.map_flags = BPF_F_INNER_MAP | BPF_F_RDONLY,
+		.map_name = "oracle_inner",
+	};
+	map = array_map_ops.map_alloc(&map_attr);
+	if (IS_ERR(map))
+		return map;
+
+	map->ops = &array_map_ops;
+	map->map_type = BPF_MAP_TYPE_ARRAY;
+
+	err = bpf_obj_name_cpy(map->name, map_attr.map_name,
+			       sizeof(map_attr.map_name));
+	if (err < 0)
+		goto free_map;
+
+	mutex_init(&map->freeze_mutex);
+	spin_lock_init(&map->owner_lock);
+
+	err = security_bpf_map_create(map, &map_attr, NULL, false);
+	if (err)
+		goto free_map_sec;
+
+	err = bpf_map_alloc_id(map);
+	if (err)
+		goto free_map_sec;
+
+	bpf_map_save_memcg(map);
+
+	return map;
+
+free_map_sec:
+	security_bpf_map_free(map);
+free_map:
+	bpf_map_free(map);
+	return ERR_PTR(err);
+}
+
 struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					 int i, int *cnt)
 {
@@ -72,7 +119,8 @@ struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bp
 	struct list_head *head = aux->oracle_states;
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_prog *new_prog = env->prog;
-	int num_oracle_states;
+	int num_oracle_states, err;
+	struct bpf_map *inner_map;
 
 	if (env->subprog_cnt > 1)
 		/* Skip the oracle if subprogs are used. */
@@ -82,6 +130,12 @@ struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bp
 	if (!num_oracle_states)
 		goto noop;
 
+	inner_map = create_inner_oracle_map(num_oracle_states);
+	if (IS_ERR(inner_map))
+		return (void *)inner_map;
+
+	ld_addrs[0].imm = (u32)(u64)inner_map;
+	ld_addrs[1].imm = ((u64)inner_map) >> 32;
 	insn_buf[0] = ld_addrs[0];
 	insn_buf[1] = ld_addrs[1];
 	insn_buf[2] = *insn;
@@ -91,6 +145,14 @@ struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bp
 	if (!new_prog)
 		return ERR_PTR(-ENOMEM);
 
+	/* Attach oracle inner map to new LDIMM64 instruction. */
+	aux = &env->insn_aux_data[i];
+	aux->oracle_inner_map = inner_map;
+
+	err = __add_used_map(env, inner_map);
+	if (err < 0)
+		return ERR_PTR(err);
+
 	return new_prog;
 
 noop:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 211912c91652..5d8db1fed082 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -441,7 +441,7 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr)
 	map->map_extra = attr->map_extra;
 }
 
-static int bpf_map_alloc_id(struct bpf_map *map)
+int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
 
@@ -480,7 +480,7 @@ void bpf_map_free_id(struct bpf_map *map)
 }
 
 #ifdef CONFIG_MEMCG
-static void bpf_map_save_memcg(struct bpf_map *map)
+void bpf_map_save_memcg(struct bpf_map *map)
 {
 	/* Currently if a map is created by a process belonging to the root
 	 * memory cgroup, get_obj_cgroup_from_current() will return NULL.
@@ -580,7 +580,7 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 }
 
 #else
-static void bpf_map_save_memcg(struct bpf_map *map)
+void bpf_map_save_memcg(struct bpf_map *map)
 {
 }
 
@@ -880,7 +880,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 	}
 }
 
-static void bpf_map_free(struct bpf_map *map)
+void bpf_map_free(struct bpf_map *map)
 {
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ca52c6aaa3b..74fc568c1bc8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20969,7 +20969,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
+int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
 	int i, err;
 
-- 
2.43.0


