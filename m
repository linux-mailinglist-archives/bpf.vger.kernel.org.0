Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA21B2207EE
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgGOI5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 04:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgGOI5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 04:57:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E7C08C5C1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 01:57:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so4790757wmh.2
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4IiETtIm73dTeV+zNcJeVswphoArE8p5m7LV2qOzP0=;
        b=VwL56rzqLCfipwEfbn4bZDsh3LdGgB7V4Ei23cIWWAe/544bfoX1CM6ZkxHHQAbvZy
         r2wa1XiaBjlrrd3sj3msy5kGI/1y2UhhdeibAu2pJikFOz7a6376g2a0Q9vgeqqtwHSj
         mfDvqKMf8YdjDjux5FeFxYfHeZ1epT7TS20tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4IiETtIm73dTeV+zNcJeVswphoArE8p5m7LV2qOzP0=;
        b=hho0dvzNMFFGGig+V+n+05oFIjvTxdv8LVNNhANZJh95j7DAUQQYKW8gnr7bDA0ROr
         qa7nlWZn3mXvQL/URGEMrrs4O+OJ0EysSOCprmE/X1ExjNZmNUUAJQBwYJgGzqdv1jPt
         2m9/ZTL8VgKvt5mKQ1wpl4rdfbBa+bhu6TYQ1oIuNaABH0oiXYxYAEx02iVUgZieAO7x
         AIh7aYFSpsTkGc4q6VxkYZHDnqlEU/N9isGZHV4e+swGd729n6+OtOJnciOYr/nDw5MU
         plxy7Sc20AfpVLDYl7uVHhCbOt1GJvm9sAthb2C3Kb5mWC1FqTWVAVOBo1a/kiEey6VS
         Twzw==
X-Gm-Message-State: AOAM533BUkJZ+erYjOSqnagSWwGZv3rd14oZ6Whv+UkaFuda9inLNXIJ
        nfawgvnZ7QbbKcM/PTAiOhH+L88IPBsMYY6covnfgQ==
X-Google-Smtp-Source: ABdhPJyFutkBb9pd5Ntq3OBM44EWmhWOcL6F8vUceUKIrPpwVRtnTunOc9c6AqmJz1+hvmi+kwbB11hYY7U7I2orynA=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr7584704wml.170.1594803466398;
 Wed, 15 Jul 2020 01:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200709101239.3829793-1-kpsingh@chromium.org>
 <20200709101239.3829793-2-kpsingh@chromium.org> <20200710065917.4333wchwofpl7m2s@kafai-mbp>
 <CACYkzJ7szyY8vY=Rv_gr7RbMty=pxyZpPPzTpaREAa5_k0tAfg@mail.gmail.com>
 <20200715064339.gxtb4qwl77macuxt@kafai-mbp> <CACYkzJ7GmSPt8WV5nSNB2irH+Dn9QywSabZyLvqEcae2-jTuHQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7GmSPt8WV5nSNB2irH+Dn9QywSabZyLvqEcae2-jTuHQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 15 Jul 2020 10:57:35 +0200
Message-ID: <CACYkzJ5m4e0P5cU34jnOsN9ide=tWj7NdqtQ3Wfaa6xxCWvsYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Generalize bpf_sk_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[+lists]

I inadvertently missed them in my previous reply.

On Wed, Jul 15, 2020 at 10:22 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Wed, Jul 15, 2020 at 8:43 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 11:42:56PM +0200, KP Singh wrote:
> > >
> > >
> > > On Fri, Jul 10, 2020 at 8:59 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Thu, Jul 09, 2020 at 12:12:36PM +0200, KP Singh wrote:
> > > > > From: KP Singh <kpsingh@google.com>
> > > > >
> > > > > Refactor the functionality in bpf_sk_storage.c so that concept of
> > > > > storage linked to kernel objects can be extended to other objects like
> > > > > inode, task_struct etc.
> > > > >
> > > > > bpf_sk_storage is updated to be bpf_local_storage with a union that
> > > > > contains a pointer to the owner object.
> > > >
> > > > > The type of the
> > > > > bpf_local_storage can be determined using the newly added
> > > > > bpf_local_storage_type enum.
> > > > This is out dated.
> > > >
> > > > >
> > > > > Each new local storage will still be a separate map and provide its own
> > > > > set of helpers. This allows for future object specific extensions and
> > > > > still share a lot of the underlying implementation.
> > > > Thanks for v4.
> > > >
> > > > I do find it quite hard to follow by directly moving to
> > > > bpf_local_storage.c without doing all the renaming locally
> > > > at bpf_sk_storage.c first.  I will try my best to follow.
> > > >
> > >
> > > Thanks for painfully going through it. Will make it easier next time :)
> > >
> > > > There are some unnecessary name/convention change and function
> > > > folding that do not help on this side either.  Please keep them
> > > > unchanged for now and they can use another patch in the future if needed.
> > > > It will be easier to have a mostly one to one naming change
> > > > and please mention them in the commit message.
> > >
> > > So I am going to split the first change as:
> > >
> > > - A mechcanical change that does the following renames:
> > >
> > > Flags/consts:
> > >
> > >   SK_STORAGE_CREATE_FLAG_MASK -> BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
> > >   BPF_SK_STORAGE_CACHE_SIZE -> BPF_LOCAL_STORAGE_CACHE_SIZE
> > >   MAX_VALUE_SIZE -> BPF_LOCAL_STORAGE_MAX_VALUE_SIZE
> > >
> > > Structs:
> > >
> > >   bucket -> bpf_local_storage_map_bucket
> > >   bpf_sk_storage_map -> bpf_local_storage_map
> > >   bpf_sk_storage_data -> bpf_local_storage_data
> > >   bpf_sk_storage_elem -> bpf_local_storage_elem
> > >   bpf_sk_storage -> bpf_local_storage
> > >   selem_linked_to_sk -> selem_linked_to_storage
> > >   selem_alloc -> bpf_selem_alloc
> > >
> > >   and in bpf_local_storage change the name of the sk -> owner
> > >   (the type change happens in a subsequent patch).
> > >
> > > Functions:
> > >
> > >   __selem_unlink_sk -> bpf_selem_unlink_storage
> > >   __selem_link_sk -> bpf_selem_link_storage
> > >   selem_unlink_sk -> __bpf_selem_unlink_storage
> > >   sk_storage_update -> bpf_local_storage_update
> > >   __sk_storage_lookup -> bpf_local_storage_lookup
> > >   bpf_sk_storage_map_free -> bpf_local_storage_map_free
> > >   bpf_sk_storage_map_alloc -> bpf_local_storage_map_alloc
> > >   bpf_sk_storage_map_alloc_check -> bpf_local_storage_map_alloc_check
> > >   bpf_sk_storage_map_check_btf -> bpf_local_storage_map_check_btf
> > >
> > > - Split the caching generalization into its separate patch.
> > > - Do the rest of the changes within bpf_sk_storage.c without any
> > >   splitting to make the review easier.
> > > - Another mechanical no-change split into
> > >   bpf_local_storage.
> > >
> > > Hope this would make the review easier for you. Let me know if you
> > > have any concerns with the naming / split of patches.
> > That will be much better. Thanks!
> >
> > > > [ ... ]
> > > >
> > > > > +static struct bpf_local_storage_data *
> > > > > +sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
> > > > >  {
> > > > > -     struct bpf_sk_storage_data *old_sdata = NULL;
> > > > > -     struct bpf_sk_storage_elem *selem;
> > > > > -     struct bpf_sk_storage *sk_storage;
> > > > > -     struct bpf_sk_storage_map *smap;
> > > > > +     struct bpf_local_storage_data *old_sdata = NULL;
> > > > > +     struct bpf_local_storage_elem *selem;
> > > > > +     struct bpf_local_storage *local_storage;
> > > > > +     struct bpf_local_storage_map *smap;
> > > > > +     struct sock *sk;
> > > > >       int err;
> > > > >
> > > > > -     /* BPF_EXIST and BPF_NOEXIST cannot be both set */
> > > > > -     if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
> > > > > -         /* BPF_F_LOCK can only be used in a value with spin_lock */
> > > > > -         unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> > > > > -             return ERR_PTR(-EINVAL);
> > > > > +     err = bpf_local_storage_check_update_flags(map, map_flags);
> > > > > +     if (err)
> > > > > +             return ERR_PTR(err);
> > > > >
> > > > > -     smap = (struct bpf_sk_storage_map *)map;
> > > > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > -     if (!sk_storage || hlist_empty(&sk_storage->list)) {
> > > > > -             /* Very first elem for this sk */
> > > > > -             err = check_flags(NULL, map_flags);
> > > > > -             if (err)
> > > > > -                     return ERR_PTR(err);
> > > > > +     sk = owner;
> > > > > +     local_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > +     smap = (struct bpf_local_storage_map *)map;
> > > > >
> > > > > -             selem = selem_alloc(smap, sk, value, true);
> > > > > +     if (!local_storage || hlist_empty(&local_storage->list)) {
> > > > > +             /* Very first elem */
> > > > > +             selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
> > >
> > > > hmmm... If this map_selem_alloc is directly called here in sk_storage instead
> > > > of the common local_storage, does it have to be in map_ops?
> > >
> > > map_selem_alloc is also called from bpf_local_storage_update as well.
> > > However, map_local_storage_alloc is only called from here
> > > and we probably don't need that, so I removed it.
> > Ah. right, I meant map_local_storage_alloc.
> > Sorry for the confusion.
> >
> > >
> > > >
> > > > >               if (!selem)
> > > > >                       return ERR_PTR(-ENOMEM);
> > > > >
> > > > > -             err = sk_storage_alloc(sk, smap, selem);
> > > > > +             err = map->ops->map_local_storage_alloc(owner, smap, selem);
> > > > >               if (err) {
> > > > >                       kfree(selem);
> > > > >                       atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
> > > >
> > > > [ ... ]
> > > >
> > > > > -static void bpf_sk_storage_map_free(struct bpf_map *map)
> > > > > +static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
> > > > Hmmm... this change here... keep scrolling down and down .... :)
> > > >
> > > > >  {
> > > > > -     struct bpf_sk_storage_elem *selem;
> > > > > -     struct bpf_sk_storage_map *smap;
> > > > > -     struct bucket *b;
> > > > > -     unsigned int i;
> > >
> > > [...]
> > >
> > > > > -
> > > > > -     smap = (struct bpf_sk_storage_map *)map;
> > > > > -}
> > > > > -
> > > > > -static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
> > > > .... finally got it :p
> > > >
> > > > > -{
> > > > > -     struct bpf_sk_storage_data *sdata;
> > > > > +     struct bpf_local_storage_data *sdata;
> > > > >       struct socket *sock;
> > > > > -     int fd, err;
> > > > > +     int fd, err = -EINVAL;
> > > > This is a bug fix or to suppress compiler warning?
> > >
> > > I did not see any compiler warning. This came up in an internal
> > > discussion to protect against the (albeit hypothetical) case where the
> > > sockfd_lookup does not set err.
> > I don't see an issue in sockfd_lookup().
> > There are other cases in the kernel depending on sockfd_lookup() to set
> > the err properly.  I don't see it is enough to only workaround it in
> > this lookup function but not everywhere else.
> > If sockfd_lookup() had a bug, fix it there instead of asking
> > everybody to work around it.
>
> I agree. I dropped this change.
>
> >
> > >
> > > >
> > > > >
> > > > >       fd = *(int *)key;
> > > > >       sock = sockfd_lookup(fd, &err);
> > > > > @@ -752,17 +223,18 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
> > > > >       return ERR_PTR(err);
> > > > >  }
> > > > >
> > > >
> > > > [ ... ]
> > > >
> > > > >  static int sk_storage_map_btf_id;
> > > > >  const struct bpf_map_ops sk_storage_map_ops = {
> > > > > -     .map_alloc_check = bpf_sk_storage_map_alloc_check,
> > > > > -     .map_alloc = bpf_sk_storage_map_alloc,
> > > > > -     .map_free = bpf_sk_storage_map_free,
> > > > > +     .map_alloc_check = bpf_local_storage_map_alloc_check,
> > > > > +     .map_alloc = sk_storage_map_alloc,
> > > > > +     .map_free = sk_storage_map_free,
> > > > >       .map_get_next_key = notsupp_get_next_key,
> > > > > -     .map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
> > > > > -     .map_update_elem = bpf_fd_sk_storage_update_elem,
> > > > > -     .map_delete_elem = bpf_fd_sk_storage_delete_elem,
> > > > Why this "_fd_" name change?
> > >
> > > Shouldn't really be needed as a part of this series. So I will drop
> > > it. Do you want the corresponding inode functions to also have fd
> > > in the name?
> > I don't have strong opinion on the name here or in bpf_inode_storage.
>
> Me neither. :)
>
> > I think the idea in this patch is to have consistent naming with
> > bpf_inode_storage.
>
> I think the fd makes sense here (in sk_storage) because the key is an fd,
> it would not make sense for an inode storage though.
>
> >
> > For a short and small patch, I don't mind to squash this naming change
> > into a single patch.  However, this refactoring effort is not a small change.
> >
> > My only point is, if unncessary renaming/function-folding
> > is really desired in bpf_sk_storage,  please do it in a separate patch.
> > Unnecessary changes will make this refactoring effort less clean and harder
> > for the future reviewer to look back what has been done and why.
> >
>
> I agree. I think I had ended up renaming them to understand the code better
> and forgot to revert these changes, as you might have seen tracking / reviewing
> them in a giant patch was hard.
>
> > Thanks,
> > Martin
