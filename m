Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5192631D6
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgIIQ2Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbgIIQ1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA77C061756
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:27:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so3016328wmm.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZ9QbxDdNDSOlAy4MSZ177vTpuQ3OmxNZoFmXtn1kwg=;
        b=dsQHU2yOYgitZkVg7LSikEoY0cKL1Qm4G8U2/5GcOFMbX8ovmIdhyhE9RTtXOFTY0M
         yeH2llsntISmOo5IWy2koOyMJsRxuOna95/239KRtYTsshK2KhiZjoK2f/+aRBzQP0sU
         wJFRmweZcwZVuVFccRC4CgYh4It/nsd0Tvqk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZ9QbxDdNDSOlAy4MSZ177vTpuQ3OmxNZoFmXtn1kwg=;
        b=Nk0fhlrtTvvBtwVYnNlblM6HePDhAk1Chmnl6yAm735VoMYYQ46vT0TEsfbZdVIoMx
         0vt0MZdI93EygpXJSbbDs38BOTQsRj906QBbflKYAw9UZY+77c8OZ/dosvREQZbRu8tg
         kArRPtgQiCSM9VUgHf1JtktQtURReLSsZnjcdwqnABFOVcOS5xJgrPky5KEUtWcUHUPo
         6Dvyobk0V/TZGMEtw8+PPDj8v36UEzBHBGuf4qH7l/hmwwxPbXowv0rDNovQ06wBHswy
         jrECXY99vwynf5n8GTf7IXNOluCnGx1CwLE2tM5uuGxn+fXtRlFFx3cfN+zaqFJcM9L9
         o+pw==
X-Gm-Message-State: AOAM530xRvW2xEKsu4lktkbTNd79qeiJAScNOjGCP0oj/0kzXFvFYF9T
        92QBJrcYzoIZzMCW821iVJpl3w==
X-Google-Smtp-Source: ABdhPJxyextT8g8+ivylMYlv8HNw9yU2wIuaRCiyd5voX0ixNRKRZZ3wOzM+XWrP9wU67XZg7aKckA==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr4323781wmb.170.1599668865822;
        Wed, 09 Sep 2020 09:27:45 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l16sm5644276wrb.70.2020.09.09.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:27:45 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v5 2/3] net: Allow iterating sockmap and sockhash
Date:   Wed,  9 Sep 2020 17:27:11 +0100
Message-Id: <20200909162712.221874-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909162712.221874-1-lmb@cloudflare.com>
References: <20200909162712.221874-1-lmb@cloudflare.com>
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

