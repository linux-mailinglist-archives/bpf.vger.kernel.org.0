Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358FC25A824
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBI65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBI6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 04:58:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47AEC061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 01:58:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 109so3640840otv.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiDsd6B/dYVFosEIJG1O23ZPINpzNzdqaWvyIrIqnTk=;
        b=Mfjx39fNU7fLPI4xNnp8NGb/Ro87TbKxgNFsLTQsRbAjD1olOLHSlX2TPfyzMDwBGs
         VwOpZFEE0sXqRK5Cwnmd4QPyw0HQ5S3bhsEyMKgg4amlVQa6a33vKGeOWcmXDogu7/AI
         Pk6P0uNKRw8aVo5JCXoIZZTahHXBQVXCcz32M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiDsd6B/dYVFosEIJG1O23ZPINpzNzdqaWvyIrIqnTk=;
        b=YVykQXviJFEMO38ILYAaTPoWgRM0j/WgksB6D+LCtPMN4eWuTx/Gt7WwmdA8cPXQZm
         0kZBubTwwXCqVNv85lNY9JAlAQQPtu9N3+gpeueEmbLjy3uRjB6QF6H21O4R6smlZ9FR
         NdAidCT+jynoZ1no9H0vVKochWmB6laoGU+qmXaFaiBe9Ep2nZcbCGRUWNrfpqalkMOQ
         YqlUlHwR0uUkkfwvQjOTJli23w5lBdHg9CO9K+LnOaMyWWEmB+WMZ6od//I38zrtKD3r
         vqPlO4zNMzOE38yGRnF0cZ8Bw/zCoQU1VJvP98/McMiOsi7/0lQFaRI8poWmybehPpbN
         B4Hw==
X-Gm-Message-State: AOAM530bdxpW2FdimPCI8KDA9dQCNmbKS1PuSldIddTFRupF74yfeyep
        8/Ki4WzZGIweo234I4kx27siuq07Z04Cwuvjr9RZmw==
X-Google-Smtp-Source: ABdhPJxdvE6vVOJv2tvHh3U44BF6WiDfnWsmUMCGaK5GBE2Vj1KnlQDCNMp/Xli+HA+u8CzhCANoQVsImMN19mYRIYE=
X-Received: by 2002:a05:6830:1653:: with SMTP id h19mr4164113otr.147.1599037133704;
 Wed, 02 Sep 2020 01:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200901103210.54607-1-lmb@cloudflare.com> <20200901103210.54607-3-lmb@cloudflare.com>
 <770162b0-7511-8d21-4d34-cb9b8aa191d0@fb.com>
In-Reply-To: <770162b0-7511-8d21-4d34-cb9b8aa191d0@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 2 Sep 2020 09:58:42 +0100
Message-ID: <CACAyw9-c6m_-ezAR7yPk=APMgCLJxQtOrNQrxyWGE1TFA0tG1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] net: Allow iterating sockmap and sockhash
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2 Sep 2020 at 06:08, Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/1/20 3:32 AM, Lorenz Bauer wrote:
> > Add bpf_iter support for sockmap / sockhash, based on the bpf_sk_storage and
> > hashtable implementation. sockmap and sockhash share the same iteration
> > context: a pointer to an arbitrary key and a pointer to a socket. Both
> > pointers may be NULL, and so BPF has to perform a NULL check before accessing
> > them. Technically it's not possible for sockhash iteration to yield a NULL
> > socket, but we ignore this to be able to use a single iteration point.
>
> There seems some misunderstanding about when the NULL object may be
> passed to the bpf program. The original design is to always pass valid
> object except the last iteration. If you see a NULL object (key/sock),
> that means it is the end of iteration, so you can finish aggregating
> the data and may send them to the user space.
>
> Sending NULL object in the middle of iterations is bad as bpf program
> will just check NULL and returns.
>
> The current arraymap iterator returns valid value for each index
> in the range. Since even if user did not assign anything for an index,
> the kernel still allocates storage for that index with default value 0.

I think that the current behaviour is actually in line with the NULL:
while sk may be NULL during iteration, key is guaranteed to be !NULL
except on the last iteration. This holds for sockmap and sockhash.

The wording of the commit message is a bit lacking. I'm trying to say
that for sockhash, ctx->sk will never be NULL (except during) the last
iteration. So in theory, sockhash could use a distinct context which
uses PTR_TO_SOCKET instead of PTR_TO_SOCKET_OR_NULL. However, I think
a single context for both sockmap and sockhash is nicer.

>
> For sockmap, it looks it is possible that some index may contain NULL
> socket pointer. I suggest skip these array elements and already returns
> a non-NULL object.

I think this would make sockmap inconsistent with other array map
iteration. It also breaks a use case: as you can see in the test, I
use sk == NULL to trigger map_delete_elem in the target, instead of
map_update_elem.

>
> >
> > Iteration will visit all keys that remain unmodified during the lifetime of
> > the iterator. It may or may not visit newly added ones.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >   net/core/sock_map.c | 283 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 283 insertions(+)
> >
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index ffdf94a30c87..4767f9df2b8b 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -703,6 +703,114 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
> >       .arg4_type      = ARG_ANYTHING,
> >   };
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
> > +
> > +     /* can't return sk directly, since that might be NULL */
>
> As said in the above, suggest to skip NULL socket and always return
> valid non-NULL socket.
>
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
> >   static int sock_map_btf_id;
> >   const struct bpf_map_ops sock_map_ops = {
> >       .map_alloc              = sock_map_alloc,
> > @@ -716,6 +824,7 @@ const struct bpf_map_ops sock_map_ops = {
> >       .map_check_btf          = map_check_no_btf,
> >       .map_btf_name           = "bpf_stab",
> >       .map_btf_id             = &sock_map_btf_id,
> > +     .iter_seq_info          = &sock_map_iter_seq_info,
> >   };
> >
> >   struct bpf_shtab_elem {
> > @@ -1198,6 +1307,121 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
> >       .arg4_type      = ARG_ANYTHING,
> >   };
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
> > +             elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
> > +             if (elem)
> > +                     return elem;
> > +
> > +             /* no more elements, continue in the next bucket */
> > +             info->bucket_id++;
> > +     }
>
> Looks like there are some earlier discussion on lock is not needed here?
> It would be good to add some comments here.

I've discussed it with Jakub off-list, but I was hoping that either
you or John can weigh in here. I think taking the bucket lock is
actually dangerous and could lead to a deadlock if the iterator
triggers an update of the same bucket.

Parts of sockhash were probably copied from the regular hashtable, so
maybe you can shed some light why the hashtable iterator takes the
bucket lock?

>
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
> > +     info->htab = container_of(aux->map, struct bpf_shtab, map);
> > +     return 0;
> > +}
> > +
> > +static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
> > +     .seq_ops                = &sock_hash_seq_ops,
> > +     .init_seq_private       = sock_hash_init_seq_private,
> > +     .seq_priv_size          = sizeof(struct sock_hash_seq_info),
> > +};
> > +
> >   static int sock_hash_map_btf_id;
> >   const struct bpf_map_ops sock_hash_ops = {
> >       .map_alloc              = sock_hash_alloc,
> > @@ -1211,6 +1435,7 @@ const struct bpf_map_ops sock_hash_ops = {
> >       .map_check_btf          = map_check_no_btf,
> >       .map_btf_name           = "bpf_shtab",
> >       .map_btf_id             = &sock_hash_map_btf_id,
> > +     .iter_seq_info          = &sock_hash_iter_seq_info,
> >   };
> >
> >   static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
> > @@ -1321,3 +1546,61 @@ void sock_map_close(struct sock *sk, long timeout)
> >       release_sock(sk);
> >       saved_close(sk, timeout);
> >   }
> > +
> > +static int sock_map_iter_attach_target(struct bpf_prog *prog,
> > +                                    union bpf_iter_link_info *linfo,
> > +                                    struct bpf_iter_aux_info *aux)
> > +{
> > +     struct bpf_map *map;
> > +     int err = -EINVAL;
> > +
> > +     if (!linfo->map.map_fd)
> > +             return -EBADF;
> > +
> > +     map = bpf_map_get_with_uref(linfo->map.map_fd);
> > +     if (IS_ERR(map))
> > +             return PTR_ERR(map);
> > +
> > +     if (map->map_type != BPF_MAP_TYPE_SOCKMAP &&
> > +         map->map_type != BPF_MAP_TYPE_SOCKHASH)
> > +             goto put_map;
> > +
> > +     if (prog->aux->max_rdonly_access > map->key_size) {
> > +             err = -EACCES;
> > +             goto put_map;
> > +     }
> > +
> > +     aux->map = map;
> > +     return 0;
> > +
> > +put_map:
> > +     bpf_map_put_with_uref(map);
> > +     return err;
> > +}
> > +
> > +static void sock_map_iter_detach_target(struct bpf_iter_aux_info *aux)
> > +{
> > +     bpf_map_put_with_uref(aux->map);
> > +}
> > +
> > +static struct bpf_iter_reg sock_map_iter_reg = {
> > +     .target                 = "sockmap",
> > +     .attach_target          = sock_map_iter_attach_target,
> > +     .detach_target          = sock_map_iter_detach_target,
> > +     .show_fdinfo            = bpf_iter_map_show_fdinfo,
> > +     .fill_link_info         = bpf_iter_map_fill_link_info,
> > +     .ctx_arg_info_size      = 2,
> > +     .ctx_arg_info           = {
> > +             { offsetof(struct bpf_iter__sockmap, key),
> > +               PTR_TO_RDONLY_BUF_OR_NULL },
> > +             { offsetof(struct bpf_iter__sockmap, sk),
> > +               PTR_TO_SOCKET_OR_NULL },
> > +     },
> > +     .seq_info               = &sock_map_iter_seq_info,
>
> The .seq_info here is not needed here. The sock_map_iter_seq_info
> or sock_hash_iter_seq_info already registered in corresponding
> map_ops.

Ack.


>
> > +};
> > +
> > +static int __init bpf_sockmap_iter_init(void)
> > +{
> > +     return bpf_iter_reg_target(&sock_map_iter_reg);
> > +}
> > +late_initcall(bpf_sockmap_iter_init);
> >



--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
