Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86B2557F8
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgH1JtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 05:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1JtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 05:49:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799CFC061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so328408wmi.5
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3Nfp/MpmtpH3wyaYcWdTkoL8BnuseGzYkm1FtJR5fE=;
        b=Mb5FqoTzNfZaB0ZkuV6PBdnZcADU1OY7kF9qnf2j2/yrkpF4moS7s2/d2JSmQrfJSr
         udUoxsYzTLh1IyzndLo6TmBjkzvwXkXuf9Xaf7JKEoytfM36OodGH3XN16sRgzV17nN3
         Pb0s/f4xOrybjIoiffjF0Vn3HXqCkagtzSfrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3Nfp/MpmtpH3wyaYcWdTkoL8BnuseGzYkm1FtJR5fE=;
        b=WUm/8q+mIYfJHKkh7SxK1tj4iVQj+7w1HUKcp0fVDtVNvuE82ZhTmNg6Dy9XikSf9y
         INHleBbo4qLCtHProMQbYDRvHMQwQtAsPUGcquizH+9+3AANkKflFeig98E1Zkjtx5r+
         h4CyKa9pxfg8a2ihHxbzgFxuzdh5z6aXgyAsSnuoHVhAlwJ8YJecbbycDq81WaRhJo6Y
         4Ok5/3tlLedjOL4sHL7jBk/FIq4Z69GGYzRLaL9WiQUj3HPfNMisHtZlDuL5h3XMnNeA
         IjXRR7NuOak3qkvWtCF6h/0ABKWq+3T46PZEbcdTV2llmC4TbNS5/UYm7D+b2/wylXCg
         tz8w==
X-Gm-Message-State: AOAM533asD2SihwlsU7Zdsrg/yb7B6s6lKvilG5i8gdPnhWWDBqN/ias
        lcrCoogSRPwahF3PWubC9skPgw==
X-Google-Smtp-Source: ABdhPJwoskH0sb5AmNr8bk68mbCJBNTUsCTBZD2+rmVN6w/T+AzYxT82b9OkokWL14R4uDHj/jkhKQ==
X-Received: by 2002:a1c:2742:: with SMTP id n63mr813034wmn.24.1598608141752;
        Fri, 28 Aug 2020 02:49:01 -0700 (PDT)
Received: from antares.lan (5.8.0.7.f.1.6.5.2.2.a.f.0.8.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:80:fa22:561f:7085])
        by smtp.gmail.com with ESMTPSA id z203sm1371119wmc.31.2020.08.28.02.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:49:00 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 1/3] net: Allow iterating sockmap and sockhash
Date:   Fri, 28 Aug 2020 10:48:32 +0100
Message-Id: <20200828094834.23290-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828094834.23290-1-lmb@cloudflare.com>
References: <20200828094834.23290-1-lmb@cloudflare.com>
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

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d6c6e1e312fc..31c4332f06e4 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -703,6 +703,116 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
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
+	__bpf_md_ptr(struct bpf_sock *, sk);
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
+	if (!info->sk || !sk_fullsock(info->sk))
+		info->sk = NULL;
+
+	/* continue iterating */
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
+static int __sock_map_seq_show(struct seq_file *seq, void *v)
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
+		ctx.sk = (struct bpf_sock *)info->sk;
+	}
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int sock_map_seq_show(struct seq_file *seq, void *v)
+{
+	return __sock_map_seq_show(seq, v);
+}
+
+static void sock_map_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)__sock_map_seq_show(seq, NULL);
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
 	.map_alloc		= sock_map_alloc,
@@ -716,6 +826,7 @@ const struct bpf_map_ops sock_map_ops = {
 	.map_check_btf		= map_check_no_btf,
 	.map_btf_name		= "bpf_stab",
 	.map_btf_id		= &sock_map_btf_id,
+	.iter_seq_info		= &sock_map_iter_seq_info,
 };
 
 struct bpf_shtab_elem {
@@ -1198,6 +1309,120 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
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
+		node = rcu_dereference_raw(hlist_next_rcu(&prev_elem->node));
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
+		node = rcu_dereference_raw(hlist_first_rcu(&bucket->head));
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
+static int __sock_hash_seq_show(struct seq_file *seq, struct bpf_shtab_elem *elem)
+{
+	struct sock_hash_seq_info *info = seq->private;
+	struct bpf_iter__sockmap ctx = {};
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
+		ctx.sk = (struct bpf_sock *)elem->sk;
+	}
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int sock_hash_seq_show(struct seq_file *seq, void *v)
+{
+	return __sock_hash_seq_show(seq, v);
+}
+
+static void sock_hash_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)__sock_hash_seq_show(seq, NULL);
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
 	.map_alloc		= sock_hash_alloc,
@@ -1211,6 +1436,7 @@ const struct bpf_map_ops sock_hash_ops = {
 	.map_check_btf		= map_check_no_btf,
 	.map_btf_name		= "bpf_shtab",
 	.map_btf_id		= &sock_hash_map_btf_id,
+	.iter_seq_info		= &sock_hash_iter_seq_info,
 };
 
 static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
@@ -1321,3 +1547,60 @@ void sock_map_close(struct sock *sk, long timeout)
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
+	if (map->map_type != BPF_MAP_TYPE_SOCKMAP)
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
+		  PTR_TO_SOCKET_OR_NULL },
+	},
+	.seq_info		= &sock_map_iter_seq_info,
+};
+
+static int __init bpf_sockmap_iter_init(void)
+{
+	return bpf_iter_reg_target(&sock_map_iter_reg);
+}
+late_initcall(bpf_sockmap_iter_init);
-- 
2.25.1

