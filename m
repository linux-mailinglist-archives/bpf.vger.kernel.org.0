Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37F58CA1D
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiHHOHL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbiHHOHJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CADFF5
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E66460D14
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1D4C433C1;
        Mon,  8 Aug 2022 14:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967625;
        bh=nQg4rmtCFj/hNrdrQ3y3cWuU45PQ5SdF/EvwyXrb00g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRxdKY0EgEOO6kn/Ro0aMBZLa7sVOVW25ufv4aFznkKffmeTFMLwk28wiL9bVrDjP
         l48JPua+IGyMwTd3Ws2fxOfH86s8Jro5HWSHFrp36b1aZbtjSbv3tLHM0j9XLnUxPI
         n9RrnhOcZlogwD2rV26+vLCSycaBXWoufgPeTKSEkuUnLmxg9zb3dPj0DN8WxHg9dZ
         ecq8TS42rJ6n8See8csfQyNFGMi/mjVsoaWD6N1/68cBkKdxKcJBbmH6j3GQuSpf5B
         OFyU+rOIislTADMjYXmBAyTvJlSSqJ16DQP4gbKr7yDCwzcaZudsHPxHJATo8e+OXN
         Zm4zlhUEHXMPA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 03/17] bpf: Store trampoline progs in arrays
Date:   Mon,  8 Aug 2022 16:06:12 +0200
Message-Id: <20220808140626.422731-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Storing programs for trampoline in array instead of in link
based list. This way we can have same program coming from
one link being shared across multiple trampolines.

Replacing list_head links array with bpf_prog_array objects
array that now stores all trampoline programs.

We already have bpf_trampoline_get_progs returning bpf_tramp_progs
object, so this patch does the rest:

  - storing trampoline programs of given type in bpf_prog_array
    objects

  - using bpf_tramp_prog object as program reference in link/unlink
    functions:

      int bpf_trampoline_link_prog(struct bpf_tramp_prog *tp,
                                   struct bpf_trampoline *tr);
      int bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp,
                                    struct bpf_trampoline *tr);

  - changing all the callers on above link/unlink to work with new
    interface

  - removing bpf_tramp_link struct, because it's no longer needed

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h            |  25 ++++----
 kernel/bpf/bpf_struct_ops.c    |  16 +++--
 kernel/bpf/syscall.c           |  19 +++---
 kernel/bpf/trampoline.c        | 105 ++++++++++++++++++++-------------
 net/bpf/bpf_dummy_struct_ops.c |   8 +--
 5 files changed, 96 insertions(+), 77 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 80b2c17da64d..0617982ca859 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -868,7 +868,7 @@ struct bpf_trampoline {
 	 */
 	struct bpf_prog *extension_prog;
 	/* list of BPF programs using this trampoline */
-	struct hlist_head progs_hlist[BPF_TRAMP_MAX];
+	struct bpf_prog_array *progs_array[BPF_TRAMP_MAX];
 	/* Number of attached programs. A counter per kind. */
 	int progs_cnt[BPF_TRAMP_MAX];
 	/* Executable image of trampoline */
@@ -912,9 +912,8 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 }
 
 #ifdef CONFIG_BPF_JIT
-struct bpf_tramp_link;
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
+int bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr);
+int bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr);
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
@@ -963,12 +962,12 @@ int bpf_jit_charge_modmem(u32 size);
 void bpf_jit_uncharge_modmem(u32 size);
 bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
 #else
-static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+static inline int bpf_trampoline_link_prog(struct bpf_tramp_prog *tp,
 					   struct bpf_trampoline *tr)
 {
 	return -ENOTSUPP;
 }
-static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp,
 					     struct bpf_trampoline *tr)
 {
 	return -ENOTSUPP;
@@ -1187,19 +1186,15 @@ struct bpf_link_ops {
 			      struct bpf_link_info *info);
 };
 
-struct bpf_tramp_link {
-	struct bpf_link link;
-	struct hlist_node tramp_hlist;
-	u64 cookie;
-};
-
 struct bpf_shim_tramp_link {
-	struct bpf_tramp_link link;
+	struct bpf_link link;
+	struct bpf_tramp_prog tp;
 	struct bpf_trampoline *trampoline;
 };
 
 struct bpf_tracing_link {
-	struct bpf_tramp_link link;
+	struct bpf_link link;
+	struct bpf_tramp_prog tp;
 	enum bpf_attach_type attach_type;
 	struct bpf_trampoline *trampoline;
 	struct bpf_prog *tgt_prog;
@@ -1243,7 +1238,7 @@ void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 				       void *value);
 int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
-				      struct bpf_tramp_link *link,
+				      struct bpf_prog *prog,
 				      const struct btf_func_model *model,
 				      void *image, void *image_end);
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d51dced406eb..910f1b7deb8f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -322,9 +322,7 @@ static void bpf_struct_ops_link_release(struct bpf_link *link)
 
 static void bpf_struct_ops_link_dealloc(struct bpf_link *link)
 {
-	struct bpf_tramp_link *tlink = container_of(link, struct bpf_tramp_link, link);
-
-	kfree(tlink);
+	kfree(link);
 }
 
 const struct bpf_link_ops bpf_struct_ops_link_lops = {
@@ -333,13 +331,13 @@ const struct bpf_link_ops bpf_struct_ops_link_lops = {
 };
 
 int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
-				      struct bpf_tramp_link *link,
+				      struct bpf_prog *prog,
 				      const struct btf_func_model *model,
 				      void *image, void *image_end)
 {
 	u32 flags;
 
-	tprogs[BPF_TRAMP_FENTRY].progs[0].prog = link->link.prog;
+	tprogs[BPF_TRAMP_FENTRY].progs[0].prog = prog;
 	tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
 	/* BPF_TRAMP_F_RET_FENTRY_RET is only used by bpf_struct_ops,
 	 * and it must be used alone.
@@ -405,7 +403,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
-		struct bpf_tramp_link *link;
+		struct bpf_link *link;
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
@@ -474,11 +472,11 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			err = -ENOMEM;
 			goto reset_unlock;
 		}
-		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
+		bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS,
 			      &bpf_struct_ops_link_lops, prog);
-		st_map->links[i] = &link->link;
+		st_map->links[i] = link;
 
-		err = bpf_struct_ops_prepare_trampoline(tprogs, link,
+		err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
 							&st_ops->func_models[i],
 							image, image_end);
 		if (err < 0)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83c7136c5788..42272909ac08 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2887,9 +2887,9 @@ EXPORT_SYMBOL(bpf_link_get_from_fd);
 static void bpf_tracing_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+		container_of(link, struct bpf_tracing_link, link);
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->tp,
 						tr_link->trampoline));
 
 	bpf_trampoline_put(tr_link->trampoline);
@@ -2902,7 +2902,7 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+		container_of(link, struct bpf_tracing_link, link);
 
 	kfree(tr_link);
 }
@@ -2911,7 +2911,7 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 					 struct seq_file *seq)
 {
 	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+		container_of(link, struct bpf_tracing_link, link);
 
 	seq_printf(seq,
 		   "attach_type:\t%d\n",
@@ -2922,7 +2922,7 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 					   struct bpf_link_info *info)
 {
 	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+		container_of(link, struct bpf_tracing_link, link);
 
 	info->tracing.attach_type = tr_link->attach_type;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
@@ -3004,10 +3004,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		err = -ENOMEM;
 		goto out_put_prog;
 	}
-	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
+	bpf_link_init(&link->link, BPF_LINK_TYPE_TRACING,
 		      &bpf_tracing_link_lops, prog);
 	link->attach_type = prog->expected_attach_type;
-	link->link.cookie = bpf_cookie;
+	link->tp.cookie = bpf_cookie;
+	link->tp.prog = prog;
 
 	mutex_lock(&prog->aux->dst_mutex);
 
@@ -3075,11 +3076,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		tgt_prog = prog->aux->dst_prog;
 	}
 
-	err = bpf_link_prime(&link->link.link, &link_primer);
+	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
 		goto out_unlock;
 
-	err = bpf_trampoline_link_prog(&link->link, tr);
+	err = bpf_trampoline_link_prog(&link->tp, tr);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f41fb1af9f0e..854d0a3b9b31 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -152,7 +152,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 {
 	struct bpf_trampoline *tr;
 	struct hlist_head *head;
-	int i;
 
 	mutex_lock(&trampoline_mutex);
 	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
@@ -181,8 +180,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	hlist_add_head(&tr->hlist, head);
 	refcount_set(&tr->refcnt, 1);
 	mutex_init(&tr->mutex);
-	for (i = 0; i < BPF_TRAMP_MAX; i++)
-		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 out:
 	mutex_unlock(&trampoline_mutex);
 	return tr;
@@ -272,9 +269,11 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 static struct bpf_tramp_progs *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
+	const struct bpf_prog_array_item *item;
+	struct bpf_prog_array *prog_array;
 	struct bpf_tramp_progs *tprogs;
-	struct bpf_tramp_link *link;
 	struct bpf_tramp_prog *tp;
+	struct bpf_prog *prog;
 	int kind;
 
 	*total = 0;
@@ -287,13 +286,16 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 		*total += tr->progs_cnt[kind];
 		tp = &tprogs[kind].progs[0];
 
-		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			struct bpf_prog *prog = link->link.prog;
+		prog_array = tr->progs_array[kind];
+		if (!prog_array)
+			continue;
+		item = &prog_array->items[0];
 
+		while ((prog = READ_ONCE(item->prog))) {
 			*ip_arg |= prog->call_get_func_ip;
 			tp->prog = prog;
-			tp->cookie = link->cookie;
-			tp++;
+			tp->cookie = item->bpf_cookie;
+			tp++; item++;
 		}
 	}
 	return tprogs;
@@ -545,14 +547,16 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 	}
 }
 
-static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr)
 {
+	struct bpf_prog_array *old_array, *new_array;
+	const struct bpf_prog_array_item *item;
 	enum bpf_tramp_prog_type kind;
-	struct bpf_tramp_link *link_exiting;
+	struct bpf_prog *prog;
 	int err = 0;
 	int cnt = 0, i;
 
-	kind = bpf_attach_type_to_tramp(link->link.prog);
+	kind = bpf_attach_type_to_tramp(tp->prog);
 	if (tr->extension_prog)
 		/* cannot attach fentry/fexit if extension prog is attached.
 		 * cannot overwrite extension prog either.
@@ -566,48 +570,57 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 		/* Cannot attach extension if fentry/fexit are in use. */
 		if (cnt)
 			return -EBUSY;
-		tr->extension_prog = link->link.prog;
+		tr->extension_prog = tp->prog;
 		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
-					  link->link.prog->bpf_func);
+					  tp->prog->bpf_func);
 	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
-	if (!hlist_unhashed(&link->tramp_hlist))
-		/* prog already linked */
-		return -EBUSY;
-	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
-		if (link_exiting->link.prog != link->link.prog)
-			continue;
-		/* prog already linked */
-		return -EBUSY;
+	old_array = tr->progs_array[kind];
+	if (old_array) {
+		item = &old_array->items[0];
+
+		while ((prog = READ_ONCE(item->prog))) {
+			/* prog already linked */
+			if (prog == tp->prog)
+				return -EBUSY;
+			item++;
+		}
 	}
 
-	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
+	err = bpf_prog_array_copy(old_array, NULL, tp->prog, tp->cookie, &new_array);
+	if (err < 0)
+		return -ENOMEM;
+	tr->progs_array[kind] = new_array;
 	tr->progs_cnt[kind]++;
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 	if (err) {
-		hlist_del_init(&link->tramp_hlist);
+		tr->progs_array[kind] = old_array;
 		tr->progs_cnt[kind]--;
+		bpf_prog_array_free(new_array);
+	} else {
+		bpf_prog_array_free(old_array);
 	}
 	return err;
 }
 
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+int bpf_trampoline_link_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr)
 {
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_link_prog(link, tr);
+	err = __bpf_trampoline_link_prog(tp, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
 
-static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+static int __bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr)
 {
+	struct bpf_prog_array *old_array, *new_array;
 	enum bpf_tramp_prog_type kind;
 	int err;
 
-	kind = bpf_attach_type_to_tramp(link->link.prog);
+	kind = bpf_attach_type_to_tramp(tp->prog);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
@@ -615,18 +628,26 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
 		tr->extension_prog = NULL;
 		return err;
 	}
-	hlist_del_init(&link->tramp_hlist);
+
+	old_array = tr->progs_array[kind];
+
+	err = bpf_prog_array_copy(old_array, tp->prog, NULL, 0, &new_array);
+	if (err < 0)
+		return err;
+
 	tr->progs_cnt[kind]--;
+	tr->progs_array[kind] = new_array;
+	bpf_prog_array_free(old_array);
 	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
+int bpf_trampoline_unlink_prog(struct bpf_tramp_prog *tp, struct bpf_trampoline *tr)
 {
 	int err;
 
 	mutex_lock(&tr->mutex);
-	err = __bpf_trampoline_unlink_prog(link, tr);
+	err = __bpf_trampoline_unlink_prog(tp, tr);
 	mutex_unlock(&tr->mutex);
 	return err;
 }
@@ -635,20 +656,20 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
 	struct bpf_shim_tramp_link *shim_link =
-		container_of(link, struct bpf_shim_tramp_link, link.link);
+		container_of(link, struct bpf_shim_tramp_link, link);
 
 	/* paired with 'shim_link->trampoline = tr' in bpf_trampoline_link_cgroup_shim */
 	if (!shim_link->trampoline)
 		return;
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link, shim_link->trampoline));
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->tp, shim_link->trampoline));
 	bpf_trampoline_put(shim_link->trampoline);
 }
 
 static void bpf_shim_tramp_link_dealloc(struct bpf_link *link)
 {
 	struct bpf_shim_tramp_link *shim_link =
-		container_of(link, struct bpf_shim_tramp_link, link.link);
+		container_of(link, struct bpf_shim_tramp_link, link);
 
 	kfree(shim_link);
 }
@@ -686,9 +707,10 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 	p->type = BPF_PROG_TYPE_LSM;
 	p->expected_attach_type = BPF_LSM_MAC;
 	bpf_prog_inc(p);
-	bpf_link_init(&shim_link->link.link, BPF_LINK_TYPE_UNSPEC,
+	bpf_link_init(&shim_link->link, BPF_LINK_TYPE_UNSPEC,
 		      &bpf_shim_tramp_link_lops, p);
 	bpf_cgroup_atype_get(p->aux->attach_btf_id, cgroup_atype);
+	shim_link->tp.prog = p;
 
 	return shim_link;
 }
@@ -722,7 +744,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	shim_link = tr->shim_link;
 	if (shim_link) {
 		/* Reusing existing shim attached by the other program. */
-		bpf_link_inc(&shim_link->link.link);
+		bpf_link_inc(&shim_link->link);
 
 		mutex_unlock(&tr->mutex);
 		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
@@ -737,7 +759,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr);
+	err = __bpf_trampoline_link_prog(&shim_link->tp, tr);
 	if (err)
 		goto err;
 
@@ -752,7 +774,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	mutex_unlock(&tr->mutex);
 
 	if (shim_link)
-		bpf_link_put(&shim_link->link.link);
+		bpf_link_put(&shim_link->link);
 
 	/* have to release tr while _not_ holding its mutex */
 	bpf_trampoline_put(tr); /* bpf_trampoline_get above */
@@ -780,7 +802,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 	mutex_unlock(&tr->mutex);
 
 	if (shim_link)
-		bpf_link_put(&shim_link->link.link);
+		bpf_link_put(&shim_link->link);
 
 	bpf_trampoline_put(tr); /* bpf_trampoline_lookup above */
 }
@@ -817,9 +839,12 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 		goto out;
 	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 
-	for (i = 0; i < BPF_TRAMP_MAX; i++)
-		if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
+	for (i = 0; i < BPF_TRAMP_MAX; i++) {
+		if (!tr->progs_array[i])
+			continue;
+		if (WARN_ON_ONCE(!bpf_prog_array_is_empty(tr->progs_array[i])))
 			goto out;
+	}
 
 	/* This code will be executed even when the last bpf_tramp_image
 	 * is alive. All progs are detached from the trampoline and the
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 17add0bdf323..5a771cc74edf 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -81,7 +81,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
 	struct bpf_tramp_progs *tprogs;
-	struct bpf_tramp_link *link = NULL;
+	struct bpf_link *link = NULL;
 	void *image = NULL;
 	unsigned int op_idx;
 	int prog_ret;
@@ -115,10 +115,10 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 	/* prog doesn't take the ownership of the reference from caller */
 	bpf_prog_inc(prog);
-	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
+	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
 
 	op_idx = prog->expected_attach_type;
-	err = bpf_struct_ops_prepare_trampoline(tprogs, link,
+	err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
 						&st_ops->func_models[op_idx],
 						image, image + PAGE_SIZE);
 	if (err < 0)
@@ -137,7 +137,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	kfree(args);
 	bpf_jit_free_exec(image);
 	if (link)
-		bpf_link_put(&link->link);
+		bpf_link_put(link);
 	kfree(tprogs);
 	return err;
 }
-- 
2.37.1

