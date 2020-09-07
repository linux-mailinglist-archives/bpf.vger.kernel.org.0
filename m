Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1125FC42
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgIGOtg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgIGOtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:49:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6617EC0613ED
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so12476852wme.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZ9QbxDdNDSOlAy4MSZ177vTpuQ3OmxNZoFmXtn1kwg=;
        b=i90G2QHxORHJrgeppgvVTOZ5IhPXK5MQVFK79Vm8xHqvx92GA7lZDz+i9Yo0447ZTJ
         n3yoc/3XcOAeXHSuUol6LBazmosmS84JO0IoZZHb157i0zHkfWX52f0+sRVzrMvmXVw6
         EpoExm4foGSUMsPR4nyF3fhJVhbV0KHbqlyOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZ9QbxDdNDSOlAy4MSZ177vTpuQ3OmxNZoFmXtn1kwg=;
        b=pNSpJ2BvU0gD+UXML0X32r/cI6uD7ND80lHbPPZt9xymBAGrF5TZ3RyCIDEDb3pzjJ
         Hv7A9wK0dZ+ZkcvkeXo3ae2wvsIgI4LtKiMl0Us8FshhBNXKHrF1x81i/CEWtDuIpI0h
         T9zutDeS2FOaPCvYmGto/lc6cD6m/pdxP2Nr+dQs3o72JIuKq9EHp6EcWdTSAaszEUl1
         y1HJSFp6/WECLk9ac+ULx3yG4OIvIEfpIfWZqVeeSRPgNO0C6m6CjRQyIgu297LNeW8W
         kiqX0T+5536RH0iAsWT4GWRoQ3Ybsvt47u1PrAVIu+jXN6bXWsyieI5x8cVjB/5NhL7I
         gaZQ==
X-Gm-Message-State: AOAM532N2WShh/SqH9LMPlq8DobnCj5JvCI8n1VYQ/l9CFvI4eZ0mEXr
        wo6Dy/AkqhKSAHJa5ouLqBNDBA==
X-Google-Smtp-Source: ABdhPJyVGphwa9PlvkdD2BdlyP2qUNAhYKI8i3++XoYdetcOLlsAagLR9ReBMWk9xqj2pIiI5OhpaA==
X-Received: by 2002:a1c:a5ca:: with SMTP id o193mr20949363wme.106.1599490110985;
        Mon, 07 Sep 2020 07:48:30 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:30 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 3/7] net: Allow iterating sockmap and sockhash
Date:   Mon,  7 Sep 2020 15:46:57 +0100
Message-Id: <20200907144701.44867-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
hashtable implementation. sockmap and sockhash share the same iteration
context: a pointer to an arbitrary key and a pointer to a socket. Both
pointers may be NULL, and so BPF has to perform a NULL check before accessing
them. Technically it's not possible for sockhash iteration to yield a NULL
socket, but we ignore this to be able to use a single iteration point.

Iteration will visit all keys that remain unmodified during the lifetime of
the iterator. It may or may not visit newly added ones.

Switch from using rcu_dereference_raw to plain rcu_dereference, so we gain
another guard rail if CONFIG_PROVE_RCU is enabled.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 280 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 278 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 82494810d0ee..e1f05e3fa1d0 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2017 - 2018 Covalent IO, Inc. http://covalent.io */
 
 #include <linux/bpf.h>
+#include <linux/btf_ids.h>
 #include <linux/filter.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -703,6 +704,109 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
 	.arg4_type      = ARG_ANYTHING,
 };
 
+struct sock_map_seq_info {
+	struct bpf_map *map;
+	struct sock *sk;
+	u32 index;
+};
+
+struct bpf_iter__sockmap {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct bpf_map *, map);
+	__bpf_md_ptr(void *, key);
+	__bpf_md_ptr(struct sock *, sk);
+};
+
+DEFINE_BPF_ITER_FUNC(sockmap, struct bpf_iter_meta *meta,
+		     struct bpf_map *map, void *key,
+		     struct sock *sk)
+
+static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
+{
+	if (unlikely(info->index >= info->map->max_entries))
+		return NULL;
+
+	info->sk = __sock_map_lookup_elem(info->map, info->index);
+
+	/* can't return sk directly, since that might be NULL */
+	return info;
+}
+
+static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct sock_map_seq_info *info = seq->private;
+
+	if (*pos == 0)
+		++*pos;
+
+	/* pairs with sock_map_seq_stop */
+	rcu_read_lock();
+	return sock_map_seq_lookup_elem(info);
+}
+
+static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock_map_seq_info *info = seq->private;
+
+	++*pos;
+	++info->index;
+
+	return sock_map_seq_lookup_elem(info);
+}
+
+static int sock_map_seq_show(struct seq_file *seq, void *v)
+{
+	struct sock_map_seq_info *info = seq->private;
+	struct bpf_iter__sockmap ctx = {};
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, !v);
+	if (!prog)
+		return 0;
+
+	ctx.meta = &meta;
+	ctx.map = info->map;
+	if (v) {
+		ctx.key = &info->index;
+		ctx.sk = info->sk;
+	}
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static void sock_map_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)sock_map_seq_show(seq, NULL);
+
+	/* pairs with sock_map_seq_start */
+	rcu_read_unlock();
+}
+
+static const struct seq_operations sock_map_seq_ops = {
+	.start	= sock_map_seq_start,
+	.next	= sock_map_seq_next,
+	.stop	= sock_map_seq_stop,
+	.show	= sock_map_seq_show,
+};
+
+static int sock_map_init_seq_private(void *priv_data,
+				     struct bpf_iter_aux_info *aux)
+{
+	struct sock_map_seq_info *info = priv_data;
+
+	info->map = aux->map;
+	return 0;
+}
+
+static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
+	.seq_ops		= &sock_map_seq_ops,
+	.init_seq_private	= sock_map_init_seq_private,
+	.seq_priv_size		= sizeof(struct sock_map_seq_info),
+};
+
 static int sock_map_btf_id;
 const struct bpf_map_ops sock_map_ops = {
 	.map_meta_equal		= bpf_map_meta_equal,
@@ -717,6 +821,7 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_check_btf		= map_check_no_btf,
 	.map_btf_name		= "bpf_stab",
 	.map_btf_id		= &sock_map_btf_id,
+	.iter_seq_info		= &sock_map_iter_seq_info,
 };
 
 struct bpf_shtab_elem {
@@ -953,7 +1058,7 @@ static int sock_hash_get_next_key(struct bpf_map *map, void *key,
 	if (!elem)
 		goto find_first_elem;
 
-	elem_next = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(&elem->node)),
+	elem_next = hlist_entry_safe(rcu_dereference(hlist_next_rcu(&elem->node)),
 				     struct bpf_shtab_elem, node);
 	if (elem_next) {
 		memcpy(key_next, elem_next->key, key_size);
@@ -965,7 +1070,7 @@ static int sock_hash_get_next_key(struct bpf_map *map, void *key,
 find_first_elem:
 	for (; i < htab->buckets_num; i++) {
 		head = &sock_hash_select_bucket(htab, i)->head;
-		elem_next = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),
+		elem_next = hlist_entry_safe(rcu_dereference(hlist_first_rcu(head)),
 					     struct bpf_shtab_elem, node);
 		if (elem_next) {
 			memcpy(key_next, elem_next->key, key_size);
@@ -1199,6 +1304,117 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
 	.arg4_type      = ARG_ANYTHING,
 };
 
+struct sock_hash_seq_info {
+	struct bpf_map *map;
+	struct bpf_shtab *htab;
+	u32 bucket_id;
+};
+
+static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
+				     struct bpf_shtab_elem *prev_elem)
+{
+	const struct bpf_shtab *htab = info->htab;
+	struct bpf_shtab_bucket *bucket;
+	struct bpf_shtab_elem *elem;
+	struct hlist_node *node;
+
+	/* try to find next elem in the same bucket */
+	if (prev_elem) {
+		node = rcu_dereference(hlist_next_rcu(&prev_elem->node));
+		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
+		if (elem)
+			return elem;
+
+		/* no more elements, continue in the next bucket */
+		info->bucket_id++;
+	}
+
+	for (; info->bucket_id < htab->buckets_num; info->bucket_id++) {
+		bucket = &htab->buckets[info->bucket_id];
+		node = rcu_dereference(hlist_first_rcu(&bucket->head));
+		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
+		if (elem)
+			return elem;
+	}
+
+	return NULL;
+}
+
+static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct sock_hash_seq_info *info = seq->private;
+
+	if (*pos == 0)
+		++*pos;
+
+	/* pairs with sock_hash_seq_stop */
+	rcu_read_lock();
+	return sock_hash_seq_find_next(info, NULL);
+}
+
+static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct sock_hash_seq_info *info = seq->private;
+
+	++*pos;
+	return sock_hash_seq_find_next(info, v);
+}
+
+static int sock_hash_seq_show(struct seq_file *seq, void *v)
+{
+	struct sock_hash_seq_info *info = seq->private;
+	struct bpf_iter__sockmap ctx = {};
+	struct bpf_shtab_elem *elem = v;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, !elem);
+	if (!prog)
+		return 0;
+
+	ctx.meta = &meta;
+	ctx.map = info->map;
+	if (elem) {
+		ctx.key = elem->key;
+		ctx.sk = elem->sk;
+	}
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static void sock_hash_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)sock_hash_seq_show(seq, NULL);
+
+	/* pairs with sock_hash_seq_start */
+	rcu_read_unlock();
+}
+
+static const struct seq_operations sock_hash_seq_ops = {
+	.start	= sock_hash_seq_start,
+	.next	= sock_hash_seq_next,
+	.stop	= sock_hash_seq_stop,
+	.show	= sock_hash_seq_show,
+};
+
+static int sock_hash_init_seq_private(void *priv_data,
+				     struct bpf_iter_aux_info *aux)
+{
+	struct sock_hash_seq_info *info = priv_data;
+
+	info->map = aux->map;
+	info->htab = container_of(aux->map, struct bpf_shtab, map);
+	return 0;
+}
+
+static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
+	.seq_ops		= &sock_hash_seq_ops,
+	.init_seq_private	= sock_hash_init_seq_private,
+	.seq_priv_size		= sizeof(struct sock_hash_seq_info),
+};
+
 static int sock_hash_map_btf_id;
 const struct bpf_map_ops sock_hash_ops = {
 	.map_meta_equal		= bpf_map_meta_equal,
@@ -1213,6 +1429,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_check_btf		= map_check_no_btf,
 	.map_btf_name		= "bpf_shtab",
 	.map_btf_id		= &sock_hash_map_btf_id,
+	.iter_seq_info		= &sock_hash_iter_seq_info,
 };
 
 static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
@@ -1323,3 +1540,62 @@ void sock_map_close(struct sock *sk, long timeout)
 	release_sock(sk);
 	saved_close(sk, timeout);
 }
+
+static int sock_map_iter_attach_target(struct bpf_prog *prog,
+				       union bpf_iter_link_info *linfo,
+				       struct bpf_iter_aux_info *aux)
+{
+	struct bpf_map *map;
+	int err = -EINVAL;
+
+	if (!linfo->map.map_fd)
+		return -EBADF;
+
+	map = bpf_map_get_with_uref(linfo->map.map_fd);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (map->map_type != BPF_MAP_TYPE_SOCKMAP &&
+	    map->map_type != BPF_MAP_TYPE_SOCKHASH)
+		goto put_map;
+
+	if (prog->aux->max_rdonly_access > map->key_size) {
+		err = -EACCES;
+		goto put_map;
+	}
+
+	aux->map = map;
+	return 0;
+
+put_map:
+	bpf_map_put_with_uref(map);
+	return err;
+}
+
+static void sock_map_iter_detach_target(struct bpf_iter_aux_info *aux)
+{
+	bpf_map_put_with_uref(aux->map);
+}
+
+static struct bpf_iter_reg sock_map_iter_reg = {
+	.target			= "sockmap",
+	.attach_target		= sock_map_iter_attach_target,
+	.detach_target		= sock_map_iter_detach_target,
+	.show_fdinfo		= bpf_iter_map_show_fdinfo,
+	.fill_link_info		= bpf_iter_map_fill_link_info,
+	.ctx_arg_info_size	= 2,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__sockmap, key),
+		  PTR_TO_RDONLY_BUF_OR_NULL },
+		{ offsetof(struct bpf_iter__sockmap, sk),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+};
+
+static int __init bpf_sockmap_iter_init(void)
+{
+	sock_map_iter_reg.ctx_arg_info[1].btf_id =
+		btf_sock_ids[BTF_SOCK_TYPE_SOCK];
+	return bpf_iter_reg_target(&sock_map_iter_reg);
+}
+late_initcall(bpf_sockmap_iter_init);
-- 
2.25.1

