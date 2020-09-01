Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F799258ADE
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgIAI7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAI7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 04:59:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F51C061244
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 01:59:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so522756otk.7
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZGelRgSx9tGvEbKgctmQTp6Ie2NlqtL3znOcuFIrtE=;
        b=ga8qXHRe5GGqYIL9KAcXkuSjXq9gEugm2OYp3NRw1ZmaAS7XVptj1v0mPx3lkI2Wvi
         3Hy+5jXSyQQbTwgIAI6JQG2j/2TWTR1dbI+E4jw/zxMgVTav69WKrJXPQwIOnpl08N4r
         SQzaKHH/06EBwYpxpGtkD7+Mzt1XG0qcsYyno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZGelRgSx9tGvEbKgctmQTp6Ie2NlqtL3znOcuFIrtE=;
        b=f/HufPqNgkGlslh3UXSVWMcq3MoAOYO+rskgvLfhGZX9xvz+U9IGt3/9rPJ/706Jbw
         tJHSqrB1o3f+2Truzz8P2nNmYIZRua5wbbhInhkMfB0SDdJiHY0ZhSdReAYY6/bmkWkA
         HLGBFNtzwe32s5EwNHJ6t7jKtJepRafRExUYbHss8CAPq3Nob9OgsrJbSUHkwSQSSlcq
         CdeiIOh+dt+VWsq3zrnAzIEB13S7ZH0QjnTfXIVuTnFOSiXn5C980wN7vozITzAPsp4z
         jDtNuR3BZkmHjQrLsrUvND5Ue1TyMnZTmc/oI26+ANzf/H1ITWFNk+G8tgJqPIdB2Iyx
         GcJA==
X-Gm-Message-State: AOAM530N36JaZr2Aj0XHjBrHqFcBrJfstQysYNMjrmFl0pt8XZQii1Ed
        9P6gkXCWMfm7yLXt9p5wfIz6GWF6jQuwznJufeyfkz/oP2gKVw==
X-Google-Smtp-Source: ABdhPJxL8cDRdOFd6b0msh/C6OK4Tdmf21F1ou2Ggdl4q6k9IBgGgzLEPs6vhLyc+v8NEWApEH++ncDtKoDD4TuiyhA=
X-Received: by 2002:a9d:2f23:: with SMTP id h32mr699957otb.334.1598950756927;
 Tue, 01 Sep 2020 01:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200828094834.23290-1-lmb@cloudflare.com> <20200828094834.23290-2-lmb@cloudflare.com>
 <87eennrv1u.fsf@cloudflare.com>
In-Reply-To: <87eennrv1u.fsf@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 1 Sep 2020 09:59:05 +0100
Message-ID: <CACAyw9-dTaDEsDFLV8kX-Xd+ohjr5mmNRt=s2j7kiZArPrzwxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] net: Allow iterating sockmap and sockhash
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 31 Aug 2020 at 11:04, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Fri, Aug 28, 2020 at 11:48 AM CEST, Lorenz Bauer wrote:
> > Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
> > hashtable implementation. sockmap and sockhash share the same iteration
> > context: a pointer to an arbitrary key and a pointer to a socket. Both
> > pointers may be NULL, and so BPF has to perform a NULL check before accessing
> > them. Technically it's not possible for sockhash iteration to yield a NULL
> > socket, but we ignore this to be able to use a single iteration point.
> >
> > Iteration will visit all keys that remain unmodified during the lifetime of
> > the iterator. It may or may not visit newly added ones.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 283 insertions(+)
> >
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index d6c6e1e312fc..31c4332f06e4 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -703,6 +703,116 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
> >       .arg4_type      = ARG_ANYTHING,
> >  };
> >
> > +struct sock_map_seq_info {
> > +     struct bpf_map *map;
> > +     struct sock *sk;
> > +     u32 index;
> > +};
> > +
> > +struct bpf_iter__sockmap {
> > +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > +     __bpf_md_ptr(struct bpf_map *, map);
> > +     __bpf_md_ptr(void *, key);
> > +     __bpf_md_ptr(struct bpf_sock *, sk);
> > +};
> > +
> > +DEFINE_BPF_ITER_FUNC(sockmap, struct bpf_iter_meta *meta,
> > +                  struct bpf_map *map, void *key,
> > +                  struct sock *sk)
> > +
> > +static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
> > +{
> > +     if (unlikely(info->index >= info->map->max_entries))
> > +             return NULL;
> > +
> > +     info->sk = __sock_map_lookup_elem(info->map, info->index);
> > +     if (!info->sk || !sk_fullsock(info->sk))
>
> As we've talked off-line, we don't expect neither timewait nor request
> sockets in sockmap so sk_fullsock() check is likely not needed.

Ack.

>
> > +             info->sk = NULL;
> > +
> > +     /* continue iterating */
> > +     return info;
> > +}
> > +
> > +static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +     struct sock_map_seq_info *info = seq->private;
> > +
> > +     if (*pos == 0)
> > +             ++*pos;
> > +
> > +     /* pairs with sock_map_seq_stop */
> > +     rcu_read_lock();
> > +     return sock_map_seq_lookup_elem(info);
> > +}
> > +
> > +static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > +{
> > +     struct sock_map_seq_info *info = seq->private;
> > +
> > +     ++*pos;
> > +     ++info->index;
> > +
> > +     return sock_map_seq_lookup_elem(info);
> > +}
> > +
> > +static int __sock_map_seq_show(struct seq_file *seq, void *v)
> > +{
> > +     struct sock_map_seq_info *info = seq->private;
> > +     struct bpf_iter__sockmap ctx = {};
> > +     struct bpf_iter_meta meta;
> > +     struct bpf_prog *prog;
> > +
> > +     meta.seq = seq;
> > +     prog = bpf_iter_get_info(&meta, !v);
> > +     if (!prog)
> > +             return 0;
> > +
> > +     ctx.meta = &meta;
> > +     ctx.map = info->map;
> > +     if (v) {
> > +             ctx.key = &info->index;
> > +             ctx.sk = (struct bpf_sock *)info->sk;
> > +     }
> > +
> > +     return bpf_iter_run_prog(prog, &ctx);
> > +}
> > +
> > +static int sock_map_seq_show(struct seq_file *seq, void *v)
> > +{
> > +     return __sock_map_seq_show(seq, v);
> > +}
> > +
> > +static void sock_map_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     if (!v)
> > +             (void)__sock_map_seq_show(seq, NULL);
> > +
> > +     /* pairs with sock_map_seq_start */
> > +     rcu_read_unlock();
> > +}
> > +
> > +static const struct seq_operations sock_map_seq_ops = {
> > +     .start  = sock_map_seq_start,
> > +     .next   = sock_map_seq_next,
> > +     .stop   = sock_map_seq_stop,
> > +     .show   = sock_map_seq_show,
> > +};
> > +
> > +static int sock_map_init_seq_private(void *priv_data,
> > +                                  struct bpf_iter_aux_info *aux)
> > +{
> > +     struct sock_map_seq_info *info = priv_data;
> > +
> > +     info->map = aux->map;
> > +     return 0;
> > +}
> > +
> > +static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
> > +     .seq_ops                = &sock_map_seq_ops,
> > +     .init_seq_private       = sock_map_init_seq_private,
> > +     .seq_priv_size          = sizeof(struct sock_map_seq_info),
> > +};
> > +
> >  static int sock_map_btf_id;
> >  const struct bpf_map_ops sock_map_ops = {
> >       .map_alloc              = sock_map_alloc,
>
> [...]
>
> > @@ -1198,6 +1309,120 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
> >       .arg4_type      = ARG_ANYTHING,
> >  };
> >
> > +struct sock_hash_seq_info {
> > +     struct bpf_map *map;
> > +     struct bpf_shtab *htab;
> > +     u32 bucket_id;
> > +};
> > +
> > +static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
> > +                                  struct bpf_shtab_elem *prev_elem)
> > +{
> > +     const struct bpf_shtab *htab = info->htab;
> > +     struct bpf_shtab_bucket *bucket;
> > +     struct bpf_shtab_elem *elem;
> > +     struct hlist_node *node;
> > +
> > +     /* try to find next elem in the same bucket */
> > +     if (prev_elem) {
> > +             node = rcu_dereference_raw(hlist_next_rcu(&prev_elem->node));
>
> I'm not convinced we need to go for the rcu_dereference_raw()
> variant. Access happens inside read-side critical section, which we
> entered with rcu_read_lock() in sock_hash_seq_start().
>
> That's typical and rcu_dereference() seems appropriate. Basing this on
> what I read in Documentation/RCU/rcu_dereference.rst.

Yeah, that makes sense to me. However, sock_hash_get_next_key also
uses rcu_dereference_raw. John, can you shed some light on why that
is? Can we replace that with plain rcu_dereference as well?

>
> > +             elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> > +             if (elem)
> > +                     return elem;
> > +
> > +             /* no more elements, continue in the next bucket */
> > +             info->bucket_id++;
> > +     }
> > +
> > +     for (; info->bucket_id < htab->buckets_num; info->bucket_id++) {
> > +             bucket = &htab->buckets[info->bucket_id];
> > +             node = rcu_dereference_raw(hlist_first_rcu(&bucket->head));
> > +             elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> > +             if (elem)
> > +                     return elem;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +     struct sock_hash_seq_info *info = seq->private;
> > +
> > +     if (*pos == 0)
> > +             ++*pos;
> > +
> > +     /* pairs with sock_hash_seq_stop */
> > +     rcu_read_lock();
> > +     return sock_hash_seq_find_next(info, NULL);
> > +}
> > +
> > +static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> > +{
> > +     struct sock_hash_seq_info *info = seq->private;
> > +
> > +     ++*pos;
> > +     return sock_hash_seq_find_next(info, v);
> > +}
> > +
> > +static int __sock_hash_seq_show(struct seq_file *seq, struct bpf_shtab_elem *elem)
> > +{
> > +     struct sock_hash_seq_info *info = seq->private;
> > +     struct bpf_iter__sockmap ctx = {};
> > +     struct bpf_iter_meta meta;
> > +     struct bpf_prog *prog;
> > +
> > +     meta.seq = seq;
> > +     prog = bpf_iter_get_info(&meta, !elem);
> > +     if (!prog)
> > +             return 0;
> > +
> > +     ctx.meta = &meta;
> > +     ctx.map = info->map;
> > +     if (elem) {
> > +             ctx.key = elem->key;
> > +             ctx.sk = (struct bpf_sock *)elem->sk;
> > +     }
> > +
> > +     return bpf_iter_run_prog(prog, &ctx);
> > +}
> > +
> > +static int sock_hash_seq_show(struct seq_file *seq, void *v)
> > +{
> > +     return __sock_hash_seq_show(seq, v);
> > +}
> > +
> > +static void sock_hash_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     if (!v)
> > +             (void)__sock_hash_seq_show(seq, NULL);
> > +
> > +     /* pairs with sock_hash_seq_start */
> > +     rcu_read_unlock();
> > +}
> > +
> > +static const struct seq_operations sock_hash_seq_ops = {
> > +     .start  = sock_hash_seq_start,
> > +     .next   = sock_hash_seq_next,
> > +     .stop   = sock_hash_seq_stop,
> > +     .show   = sock_hash_seq_show,
> > +};
> > +
> > +static int sock_hash_init_seq_private(void *priv_data,
> > +                                  struct bpf_iter_aux_info *aux)
> > +{
> > +     struct sock_hash_seq_info *info = priv_data;
> > +
> > +     info->map = aux->map;
> > +     return 0;
> > +}
> > +
> > +static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
> > +     .seq_ops                = &sock_hash_seq_ops,
> > +     .init_seq_private       = sock_hash_init_seq_private,
> > +     .seq_priv_size          = sizeof(struct sock_hash_seq_info),
> > +};
> > +
> >  static int sock_hash_map_btf_id;
> >  const struct bpf_map_ops sock_hash_ops = {
> >       .map_alloc              = sock_hash_alloc,
>
> [...]



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
