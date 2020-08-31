Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E45257719
	for <lists+bpf@lfdr.de>; Mon, 31 Aug 2020 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgHaKEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Aug 2020 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgHaKEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Aug 2020 06:04:01 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3840BC061573
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2020 03:04:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so3164465lfb.6
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2020 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=iS1OKR2WVG+oFG3cyCCRX51GGTXIDHLB0HFyTet9FNg=;
        b=gp5W6OgoiydvbdyqHkTdQKMgyDjVwYR/VQax7vBFImxP1M9DaG3xF+zw/agTK8UHPp
         9TDpQQ6w71eeXWEYsTZOjXy32s8ahFlP13zE/fQmpvm7VfPSFRJ/KeAmHl1cwPqrFrYk
         CLZDGra3gXil8zjpw8MVRS+LSdQwy9+q9Mqco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=iS1OKR2WVG+oFG3cyCCRX51GGTXIDHLB0HFyTet9FNg=;
        b=J1I5dTEuu6NTWJfY2Gc23BuglLmLrRIYCK9emJcZIqaf0sdX863Rn70zaabHQebSSG
         EWd59czhKyKJSbFbUFEtWUhUmQu0MKF5ChOxe9AnorPOk9K84fhBeGmRf9Bw4kO1GbhV
         bmCb9G0zjpADOof06tys/pZKuYbmdStqzau1nDg1gUcQ/knbkZgyu5PW5blamxshcGDe
         k0+LHzEUzM5uttWJuk+Z3P2chIbHXd8mJSdg2s7DauFZhSs+9BApUSpfc9he0rPtF48C
         aZ6wxqp50MVU88lrKht2ZuSbrCBBG8WJTZpyAQ1RSdP5ruvtJM1+Ak29foYga1prBM+3
         Zs3w==
X-Gm-Message-State: AOAM532GBp45RpKmAba41XMekFGpfr415StiGrWE6GnjdBmd6Rvif0OB
        wQrXREtaE0qAmyKtMTV+YCSN1A==
X-Google-Smtp-Source: ABdhPJwrT61UTGfVvmgRWUZCMSR8UHmoCXU+igfp39tLZeG1StO8D+UeNm5cyiymvF+0CoN1fuK9tA==
X-Received: by 2002:ac2:5547:: with SMTP id l7mr333054lfk.153.1598868239533;
        Mon, 31 Aug 2020 03:03:59 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id z6sm1427618ljm.103.2020.08.31.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:03:58 -0700 (PDT)
References: <20200828094834.23290-1-lmb@cloudflare.com> <20200828094834.23290-2-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 1/3] net: Allow iterating sockmap and sockhash
In-reply-to: <20200828094834.23290-2-lmb@cloudflare.com>
Date:   Mon, 31 Aug 2020 12:03:57 +0200
Message-ID: <87eennrv1u.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 28, 2020 at 11:48 AM CEST, Lorenz Bauer wrote:
> Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
> hashtable implementation. sockmap and sockhash share the same iteration
> context: a pointer to an arbitrary key and a pointer to a socket. Both
> pointers may be NULL, and so BPF has to perform a NULL check before accessing
> them. Technically it's not possible for sockhash iteration to yield a NULL
> socket, but we ignore this to be able to use a single iteration point.
>
> Iteration will visit all keys that remain unmodified during the lifetime of
> the iterator. It may or may not visit newly added ones.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 283 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index d6c6e1e312fc..31c4332f06e4 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -703,6 +703,116 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
>  	.arg4_type      = ARG_ANYTHING,
>  };
>
> +struct sock_map_seq_info {
> +	struct bpf_map *map;
> +	struct sock *sk;
> +	u32 index;
> +};
> +
> +struct bpf_iter__sockmap {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct bpf_map *, map);
> +	__bpf_md_ptr(void *, key);
> +	__bpf_md_ptr(struct bpf_sock *, sk);
> +};
> +
> +DEFINE_BPF_ITER_FUNC(sockmap, struct bpf_iter_meta *meta,
> +		     struct bpf_map *map, void *key,
> +		     struct sock *sk)
> +
> +static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
> +{
> +	if (unlikely(info->index >= info->map->max_entries))
> +		return NULL;
> +
> +	info->sk = __sock_map_lookup_elem(info->map, info->index);
> +	if (!info->sk || !sk_fullsock(info->sk))

As we've talked off-line, we don't expect neither timewait nor request
sockets in sockmap so sk_fullsock() check is likely not needed.

> +		info->sk = NULL;
> +
> +	/* continue iterating */
> +	return info;
> +}
> +
> +static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct sock_map_seq_info *info = seq->private;
> +
> +	if (*pos == 0)
> +		++*pos;
> +
> +	/* pairs with sock_map_seq_stop */
> +	rcu_read_lock();
> +	return sock_map_seq_lookup_elem(info);
> +}
> +
> +static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct sock_map_seq_info *info = seq->private;
> +
> +	++*pos;
> +	++info->index;
> +
> +	return sock_map_seq_lookup_elem(info);
> +}
> +
> +static int __sock_map_seq_show(struct seq_file *seq, void *v)
> +{
> +	struct sock_map_seq_info *info = seq->private;
> +	struct bpf_iter__sockmap ctx = {};
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, !v);
> +	if (!prog)
> +		return 0;
> +
> +	ctx.meta = &meta;
> +	ctx.map = info->map;
> +	if (v) {
> +		ctx.key = &info->index;
> +		ctx.sk = (struct bpf_sock *)info->sk;
> +	}
> +
> +	return bpf_iter_run_prog(prog, &ctx);
> +}
> +
> +static int sock_map_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __sock_map_seq_show(seq, v);
> +}
> +
> +static void sock_map_seq_stop(struct seq_file *seq, void *v)
> +{
> +	if (!v)
> +		(void)__sock_map_seq_show(seq, NULL);
> +
> +	/* pairs with sock_map_seq_start */
> +	rcu_read_unlock();
> +}
> +
> +static const struct seq_operations sock_map_seq_ops = {
> +	.start	= sock_map_seq_start,
> +	.next	= sock_map_seq_next,
> +	.stop	= sock_map_seq_stop,
> +	.show	= sock_map_seq_show,
> +};
> +
> +static int sock_map_init_seq_private(void *priv_data,
> +				     struct bpf_iter_aux_info *aux)
> +{
> +	struct sock_map_seq_info *info = priv_data;
> +
> +	info->map = aux->map;
> +	return 0;
> +}
> +
> +static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
> +	.seq_ops		= &sock_map_seq_ops,
> +	.init_seq_private	= sock_map_init_seq_private,
> +	.seq_priv_size		= sizeof(struct sock_map_seq_info),
> +};
> +
>  static int sock_map_btf_id;
>  const struct bpf_map_ops sock_map_ops = {
>  	.map_alloc		= sock_map_alloc,

[...]

> @@ -1198,6 +1309,120 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
>  	.arg4_type      = ARG_ANYTHING,
>  };
>
> +struct sock_hash_seq_info {
> +	struct bpf_map *map;
> +	struct bpf_shtab *htab;
> +	u32 bucket_id;
> +};
> +
> +static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
> +				     struct bpf_shtab_elem *prev_elem)
> +{
> +	const struct bpf_shtab *htab = info->htab;
> +	struct bpf_shtab_bucket *bucket;
> +	struct bpf_shtab_elem *elem;
> +	struct hlist_node *node;
> +
> +	/* try to find next elem in the same bucket */
> +	if (prev_elem) {
> +		node = rcu_dereference_raw(hlist_next_rcu(&prev_elem->node));

I'm not convinced we need to go for the rcu_dereference_raw()
variant. Access happens inside read-side critical section, which we
entered with rcu_read_lock() in sock_hash_seq_start().

That's typical and rcu_dereference() seems appropriate. Basing this on
what I read in Documentation/RCU/rcu_dereference.rst.

> +		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> +		if (elem)
> +			return elem;
> +
> +		/* no more elements, continue in the next bucket */
> +		info->bucket_id++;
> +	}
> +
> +	for (; info->bucket_id < htab->buckets_num; info->bucket_id++) {
> +		bucket = &htab->buckets[info->bucket_id];
> +		node = rcu_dereference_raw(hlist_first_rcu(&bucket->head));
> +		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> +		if (elem)
> +			return elem;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct sock_hash_seq_info *info = seq->private;
> +
> +	if (*pos == 0)
> +		++*pos;
> +
> +	/* pairs with sock_hash_seq_stop */
> +	rcu_read_lock();
> +	return sock_hash_seq_find_next(info, NULL);
> +}
> +
> +static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct sock_hash_seq_info *info = seq->private;
> +
> +	++*pos;
> +	return sock_hash_seq_find_next(info, v);
> +}
> +
> +static int __sock_hash_seq_show(struct seq_file *seq, struct bpf_shtab_elem *elem)
> +{
> +	struct sock_hash_seq_info *info = seq->private;
> +	struct bpf_iter__sockmap ctx = {};
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, !elem);
> +	if (!prog)
> +		return 0;
> +
> +	ctx.meta = &meta;
> +	ctx.map = info->map;
> +	if (elem) {
> +		ctx.key = elem->key;
> +		ctx.sk = (struct bpf_sock *)elem->sk;
> +	}
> +
> +	return bpf_iter_run_prog(prog, &ctx);
> +}
> +
> +static int sock_hash_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __sock_hash_seq_show(seq, v);
> +}
> +
> +static void sock_hash_seq_stop(struct seq_file *seq, void *v)
> +{
> +	if (!v)
> +		(void)__sock_hash_seq_show(seq, NULL);
> +
> +	/* pairs with sock_hash_seq_start */
> +	rcu_read_unlock();
> +}
> +
> +static const struct seq_operations sock_hash_seq_ops = {
> +	.start	= sock_hash_seq_start,
> +	.next	= sock_hash_seq_next,
> +	.stop	= sock_hash_seq_stop,
> +	.show	= sock_hash_seq_show,
> +};
> +
> +static int sock_hash_init_seq_private(void *priv_data,
> +				     struct bpf_iter_aux_info *aux)
> +{
> +	struct sock_hash_seq_info *info = priv_data;
> +
> +	info->map = aux->map;
> +	return 0;
> +}
> +
> +static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
> +	.seq_ops		= &sock_hash_seq_ops,
> +	.init_seq_private	= sock_hash_init_seq_private,
> +	.seq_priv_size		= sizeof(struct sock_hash_seq_info),
> +};
> +
>  static int sock_hash_map_btf_id;
>  const struct bpf_map_ops sock_hash_ops = {
>  	.map_alloc		= sock_hash_alloc,

[...]
