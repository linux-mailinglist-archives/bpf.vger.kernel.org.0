Return-Path: <bpf+bounces-76239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F32CABD28
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4C2302354A
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC6C2D7813;
	Mon,  8 Dec 2025 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2N876fe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B42D47F1
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159726; cv=none; b=FCAESLOCnZzXkzJzq8O9REOJW/wXaeHJZluutmwbkTA9RTdTo79iKLTwIWsPQnpqqt/IbBtcGWf/ErS+yAz3pHRHfu94zR5rczIsyy7FAkdbd17SOz3i+r86OXpVJaPW08pUZ70dnthA8NcTEMGZtir1wpfchCZ8dY9LtND/LnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159726; c=relaxed/simple;
	bh=ZaF79zPrmCwLI0B9RAvTq4G7dN3/Wm8w+tcTPkWv50k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJHTyb+zj9QnoYso779PvoKR8CxsXgl+ls04sn0eoHAVjZHCSougLG/yZaNwXt6nWfv7KCJeMPz2cFR4iovWka7oRIc78EfQoC5dRnnD6sHmHVjBmMH1Q70aT6Yof3ZQsA1r2cHIvSQp3qPpFlutwQ3mGQ7SoDKAKd91ULjwW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2N876fe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29555415c5fso45907665ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159724; x=1765764524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GVoTyCGpiPRgMVwchBG4irNVjtoPfX3zT9RBinRARc=;
        b=j2N876ferfSj0TvvewtA0+v6rIY/IIYnnbVLsetEz7qoJm24aIvTBjrirdjat4D0PT
         ut2Yt80edK/SzEeuPucIC7EF8vW/bgx3+gbssNKeUufrRolHWNM4LD5MIUlwvxjWo4Oc
         qxEPL2aJbKFtkpSd5D0BJ9fa8vHT+rHGuwHIbLLQZ5nDXsrbXA5071TtYG5+8ITSmNT+
         Mmdcmcaf4/BCICV5ttuHsHbPkrpfAebUBsYRySVyfAUhOKMawdUUcwznzPG7C4wcGzdE
         mb4dq7oJGDOAodH2JDG03vpnbhcJvp0aANnTVRtqgXyIC8yhoRvB+OhRk6XZeB77fzkl
         /PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159724; x=1765764524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GVoTyCGpiPRgMVwchBG4irNVjtoPfX3zT9RBinRARc=;
        b=RmzRFoGzOwdWiA4KvApLEJ1Ob7O2An2m74xLBM3rrzNb/Mt86RCLKyA22p3VOLj7L2
         27HyGi18epLrga5pEosnt+b6fzZWzJQacHwAfdXJa2jdrW3k/pj/WGvl2YPt24u3jNiq
         dojXFiOUSQ7r3wCj/LB7zGjd2doY/jhZ7vKNpEdgUSUzE11WR1F++VLzn/K/pOcjmwxL
         9mpvhMcFaN12kDUiS9K5Iga7oIJsZX3W8xiHlQ6VTEzcRSXC6SG562yhmb+l49EfCHNi
         mj1524AWSKmaypkEKJ5DBMyBYZP7/Vjy6r7CQefpEMAZJqe4RRum1EzCelc7pLGBjjo/
         wvrw==
X-Gm-Message-State: AOJu0YwEZGT+af2HyzPMMqNbXT++0SAAJiy59+lNHy6WjqxlbH6mWagC
	MvPIO7LyTxfFgwPdfju7bE1awPYGXd7+pzbU/jpxTDpVQz1kRjUPUJXa9FNsU3bO
X-Gm-Gg: ASbGncs6qxYZ00W1OgmEZm68Y2BDw98PNHsB5wq+45F9VWdeQLRHF9A/qRnlbIfuE0j
	WBJAAGXK0/RVmLBxP4TjA7eR1EsRDblSE2NxGbusGyEfkwhKtu3TmyToo35cYCHyYZxmerP14Oz
	LfTZIBxip3SFbYKBsb4Kefh3vSTblply9SLW22QDqkeAo7AIk/vedneF33+AvalDman/Ir8Vmym
	dIFBxNsghNVShOFV4YbkVy+qDCMq85IYTD0U94sYt1GeO9VCjpOpJ1PE1fMTkyr9JpWNc2lFTRB
	vj0EFhImLy7mL9ZPSTprHRY2Bq9BIDdUzS4E54BBsO8aj2YVXIZe5/MvwxmHEq27XgOeNXllrEe
	SbJPGaA0pa0zcEiezcUkDL8G+ir4xyv4NQ+B/rAJ9kpyzx6EcOXUA+rxdyKiRUSSr4nxASJpeqP
	v98GzTgQ==
X-Google-Smtp-Source: AGHT+IGTYZfmmexPM79w4CYgQz4xlmR0ERuk8q1jGMa05jPebD0Xntvg17mrI7pDbTXN4bxgFU3n3w==
X-Received: by 2002:a17:903:1786:b0:295:f1f:65f with SMTP id d9443c01a7336-29df5da6ce5mr53775625ad.31.1765159723882;
        Sun, 07 Dec 2025 18:08:43 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f69esm108629205ad.56.2025.12.07.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:43 -0800 (PST)
Date: Mon, 8 Dec 2025 11:08:38 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 5/8] bpf: Create and populate oracle map
Message-ID: <51e3c47529366e072f15d9122d6d6fe7f31e2774.1765158925.git.paul.chaignon@gmail.com>
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

This creates and populates the main oracle map for our BPF program. The
map is populated with the inner oracle map created and populated in
previous patches. This main oracle map is a hashmap of maps with pruning
point indexes as keys and inner oracle maps as values.

Map flag BPF_F_INNER_MAP is required because our inner oracle maps won't
all hold the same number of states.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf.h          |   3 +
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/hashtab.c         |   6 +-
 kernel/bpf/oracle.c          | 130 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   5 ++
 5 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6bec31816485..58cba1b48f80 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2794,6 +2794,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 int bpf_fd_array_map_lookup_elem(struct bpf_map *map, void *key, u32 *value);
 int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 				void *key, void *value, u64 map_flags);
+long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
+				   void *value, u64 map_flags,
+				   bool percpu, bool onallcpus);
 int bpf_fd_htab_map_lookup_elem(struct bpf_map *map, void *key, u32 *value);
 
 int bpf_get_file_flag(int flags);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a93b5e2f4d7f..cffbd0552b43 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -846,6 +846,7 @@ struct bpf_verifier_env {
 	u32 longest_mark_read_walk;
 	u32 free_list_size;
 	u32 explored_states_size;
+	u32 num_prune_points;
 	u32 num_backedges;
 	bpfptr_t fd_array;
 
@@ -1128,5 +1129,6 @@ void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env);
 int save_state_in_oracle(struct bpf_verifier_env *env, int insn_idx);
 struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					 int i, int *cnt);
+int create_and_populate_oracle_map(struct bpf_verifier_env *env);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c8a9b27f8663..0cf286ff0084 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1249,9 +1249,9 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	return ret;
 }
 
-static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
-					  void *value, u64 map_flags,
-					  bool percpu, bool onallcpus)
+long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
+				   void *value, u64 map_flags,
+				   bool percpu, bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new, *l_old;
diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
index 404c641cb3f6..44b86e6ef3b2 100644
--- a/kernel/bpf/oracle.c
+++ b/kernel/bpf/oracle.c
@@ -190,3 +190,133 @@ struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bp
 	*cnt = 1;
 	return new_prog;
 }
+
+static int populate_oracle_map(struct bpf_verifier_env *env, struct bpf_map *oracle_map)
+{
+	struct bpf_insn_aux_data *aux;
+	int i, err;
+
+	/* Oracle checks are always before pruning points, so they cannot be the last
+	 * instruction.
+	 */
+	for (i = 0; i < env->prog->len - 1; i++) {
+		aux = &env->insn_aux_data[i];
+		if (!aux->oracle_inner_map || !aux->oracle_inner_map->max_entries)
+			continue;
+
+		bpf_map_inc(aux->oracle_inner_map);
+
+		rcu_read_lock();
+		err = htab_map_update_elem_in_place(oracle_map, &i, &aux->oracle_inner_map,
+						    BPF_NOEXIST, false, false);
+		rcu_read_unlock();
+		if (err) {
+			bpf_map_put(aux->oracle_inner_map);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static struct bpf_map *alloc_oracle_inner_map_meta(void)
+{
+	struct bpf_array *inner_array_meta;
+	struct bpf_map *inner_map_meta;
+
+	inner_map_meta = kzalloc(sizeof(*inner_map_meta), GFP_USER);
+	if (!inner_map_meta)
+		return ERR_PTR(-ENOMEM);
+
+	inner_map_meta->map_type = BPF_MAP_TYPE_ARRAY;
+	inner_map_meta->key_size = sizeof(__u32);
+	inner_map_meta->value_size = sizeof(struct bpf_oracle_state);
+	inner_map_meta->map_flags = BPF_F_INNER_MAP;
+	inner_map_meta->max_entries = 1;
+
+	inner_map_meta->ops = &array_map_ops;
+
+	inner_array_meta = container_of(inner_map_meta, struct bpf_array, map);
+	inner_array_meta->index_mask = 0;
+	inner_array_meta->elem_size = round_up(inner_map_meta->value_size, 8);
+	inner_map_meta->bypass_spec_v1 = true;
+
+	return inner_map_meta;
+}
+
+static struct bpf_map *create_oracle_map(struct bpf_verifier_env *env)
+{
+	struct bpf_map *map = NULL, *inner_map;
+	int err;
+
+	union bpf_attr map_attr = {
+		.map_type = BPF_MAP_TYPE_HASH_OF_MAPS,
+		.key_size = sizeof(__u32),
+		.value_size = sizeof(__u32),
+		.max_entries = env->num_prune_points,
+		.map_flags = BPF_F_RDONLY,
+		.map_name = "oracle_map",
+	};
+	/* We don't want to use htab_of_maps_map_ops here because it expects map_attr.inner_map_fd
+	 * to be set to the fd of inner_map_meta, which we don't have. Instead we can allocate and
+	 * set inner_map_meta ourselves.
+	 */
+	map = htab_map_ops.map_alloc(&map_attr);
+	if (IS_ERR(map))
+		return map;
+
+	map->ops = &htab_of_maps_map_ops;
+	map->map_type = BPF_MAP_TYPE_HASH_OF_MAPS;
+
+	inner_map = alloc_oracle_inner_map_meta();
+	if (IS_ERR(inner_map)) {
+		err = PTR_ERR(inner_map);
+		goto free_map;
+	}
+	map->inner_map_meta = inner_map;
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
+int create_and_populate_oracle_map(struct bpf_verifier_env *env)
+{
+	struct bpf_map *oracle_map;
+	int err;
+
+	if (env->num_prune_points == 0 || env->subprog_cnt > 1)
+		return 0;
+
+	oracle_map = create_oracle_map(env);
+	if (IS_ERR(oracle_map))
+		return PTR_ERR(oracle_map);
+
+	err = __add_used_map(env, oracle_map);
+	if (err < 0)
+		return err;
+
+	return populate_oracle_map(env, oracle_map);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74fc568c1bc8..9b39bc2ca7f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17560,6 +17560,8 @@ enum {
 
 static void mark_prune_point(struct bpf_verifier_env *env, int idx)
 {
+	if (!env->insn_aux_data[idx].prune_point)
+		env->num_prune_points++;
 	env->insn_aux_data[idx].prune_point = true;
 }
 
@@ -25301,6 +25303,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = do_misc_fixups(env);
 
+	if (ret == 0)
+		ret = create_and_populate_oracle_map(env);
+
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */
-- 
2.43.0


