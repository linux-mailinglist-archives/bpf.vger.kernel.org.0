Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1F3FAEC8
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhH2VxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Aug 2021 17:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhH2VxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Aug 2021 17:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E86160F5B
        for <bpf@vger.kernel.org>; Sun, 29 Aug 2021 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630273935;
        bh=hciiu3pjpl8VMZuMEriH/9TR4QRqn7/lJuAZjfhKxlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dFNTdPJBmicbcs/W4YC0w8ms9n3IK3wJA2qR4DTQlvGmmpu4R3oLb1DonUhlw6irl
         dWWD2PvYG7Ioj9VylX6WsDSjzBb/gQMWyhnAhHZ3p+Qjxwn69xoNApr7fNp8YVCWUE
         1njcwYwygGQ9S1aOxh+kjDkL0wn9flOsi4sybs2JX4IDCH/2boWZjSRJAjhOyTJYRI
         xcr+USK6z1aJ3If2BUO804ZEUD4mSQhoJMEd0uWQV+Pf0ebQLhdX9+3dT/zrtZpgYi
         lFwE+bxRpbZOcw9MpewDYUVnRRslaAcXtAD2v/d8XrWSCPXvd/iGFeyd6k6wYYVHZ2
         V7mdD4oB7MURA==
Received: by mail-ed1-f46.google.com with SMTP id s25so18796534edw.0
        for <bpf@vger.kernel.org>; Sun, 29 Aug 2021 14:52:15 -0700 (PDT)
X-Gm-Message-State: AOAM533nGV8X6MnszKKcbeL03DvXDP8jcGRmHpDjPrAJSneBUjGL5owr
        9dBs5Uw5oPY3xadXgjFfZsAHdy0zFbsX9VxF5oUnzg==
X-Google-Smtp-Source: ABdhPJzvNg8GlwuWRIXDA1U+BfO9LFgCYLuzwWvWQJneYZpO4FzWq+Q9lPDa7wpyPlPojubBrrBgx0MTpYLFSNXtY+s=
X-Received: by 2002:a05:6402:714:: with SMTP id w20mr17025331edx.62.1630273933891;
 Sun, 29 Aug 2021 14:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210826235127.303505-1-kpsingh@kernel.org> <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
In-Reply-To: <20210827205530.zzqawd6wz52n65qh@kafai-mbp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 29 Aug 2021 23:52:03 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
Message-ID: <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 27, 2021 at 10:55 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Aug 26, 2021 at 11:51:26PM +0000, KP Singh wrote:
> > Other maps like hashmaps are already available to sleepable programs.
> > Sleepable BPF programs run under trace RCU. Allow task, local and inode
> > storage to be used from sleepable programs.
> >
> > The local storage code mostly runs under the programs RCU read section
> > (in __bpf_prog_enter{_sleepable} and __bpf_prog_exit{_sleepable})
> > (rcu_read_lock or rcu_read_lock_trace) with the exception the logic
> > where the map is freed.
> >
> > After some discussions and help from Jann Horn, the following changes
> > were made:
> >
> > bpf_local_storage{_elem} are freed with a kfree_rcu
> > wrapped with a call_rcu_tasks_trace callback instead of a direct
> > kfree_rcu which does not respect the trace RCU grace periods. The
> > callback frees the storage/selem with kfree_rcu which handles the normal
> > RCU grace period similar to BPF trampolines.
> >
> > Update the synchronise_rcu to synchronize_rcu_mult in the map freeing
> > code to wait for trace RCU and normal RCU grace periods.
> > While this is an expensive operation, bpf_local_storage_map_free
> > is not called from within a BPF program, rather only called when the
> > owning object is being freed.
> >
> > Update the dereferencing of the pointers to use rcu_derference_protected
> > (with either the trace or normal RCU locks held) and add warnings in the
> > beginning of the get and delete helpers.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---

[...]

> > @@ -16,6 +16,9 @@
> >
> >  #define BPF_LOCAL_STORAGE_CACHE_SIZE 16
> >
> > +#define bpf_local_storage_rcu_lock_held()                    \
> > +     (rcu_read_lock_held() || rcu_read_lock_trace_held() ||  \
> > +             rcu_read_lock_bh_held())
> There is a similar test in hashtab.  May be renaming it to a more
> generic name such that it can be reused there?

Sure.

>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > index b305270b7a4b..7760bc4e9565 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -11,6 +11,8 @@
> >  #include <net/sock.h>
> >  #include <uapi/linux/sock_diag.h>
> >  #include <uapi/linux/btf.h>
> > +#include <linux/rcupdate_trace.h>
> > +#include <linux/rcupdate_wait.h>
> >
> >  #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
> >
> > @@ -81,6 +83,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> >       return NULL;
> >  }
> >
> > +void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_local_storage *local_storage;
> > +
> > +     local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> > +     kfree_rcu(local_storage, rcu);
> > +}
> > +
> > +static void bpf_selem_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_local_storage_elem *selem;
> > +
> > +     selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > +     kfree_rcu(selem, rcu);
> > +}
> > +
> >  /* local_storage->lock must be held and selem->local_storage == local_storage.
> >   * The caller must ensure selem->smap is still valid to be
> >   * dereferenced for its smap->elem_size and smap->cache_idx.
> > @@ -118,12 +136,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> >                *
> >                * Although the unlock will be done under
> >                * rcu_read_lock(),  it is more intutivie to
> > -              * read if kfree_rcu(local_storage, rcu) is done
> > +              * read if the freeing of the storage is done
> >                * after the raw_spin_unlock_bh(&local_storage->lock).
> >                *
> >                * Hence, a "bool free_local_storage" is returned
> > -              * to the caller which then calls the kfree_rcu()
> > -              * after unlock.
> > +              * to the caller which then calls then frees the storage after
> > +              * all the RCU grace periods have expired.
> >                */
> >       }
> >       hlist_del_init_rcu(&selem->snode);
> > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> >           SDATA(selem))
> >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> >
> > -     kfree_rcu(selem, rcu);
> > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> Although the common use case is usually storage_get() much more often
> than storage_delete(), do you aware any performance impact for
> the bpf prog that does a lot of storage_delete()?

I have not really measured the impact on deletes, My understanding is
that it should
not impact the BPF program, but yes, if there are some critical
sections that are prolonged
due to a sleepable program "sleeping" too long, then it would pile up
the callbacks.

But this is not something new, as we have a similar thing in BPF
trampolines. If this really
becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
with this flag would be allowed in sleepable progs.

We could then wait for both critical sections only when this flag is
set on the map.

>
> >
> >       return free_local_storage;
> >  }
> > @@ -154,7 +172,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
> >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> >
> >       if (free_local_storage)
> > -             kfree_rcu(local_storage, rcu);
> > +             call_rcu_tasks_trace(&local_storage->rcu,
> > +                                  bpf_local_storage_free_rcu);
> >  }
> >
> >  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
> > @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> >       struct bpf_local_storage_elem *selem;
> >
> >       /* Fast path (cache hit) */
> > -     sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> > +     sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> > +                                       bpf_local_storage_rcu_lock_held());
> There are other places using rcu_dereference() also.
> e.g. in bpf_local_storage_update().
> Should they be changed also?

From what I saw, the other usage of rcu_derference is in a nested
(w.r.t to the RCU section that in bpf_prog_enter/exit) RCU
read side critical section/rcu_read_{lock, unlock} so it should not be required.

If there are some that are not, then they need to be updated. Did I miss any?

>
> [ ... ]
>
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -13,6 +13,7 @@
> >  #include <net/sock.h>
> >  #include <uapi/linux/sock_diag.h>
> >  #include <uapi/linux/btf.h>
> > +#include <linux/rcupdate_trace.h>
> >
> >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> >
> > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> >       struct bpf_local_storage *sk_storage;
> >       struct bpf_local_storage_map *smap;
> >
> > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > +                                            bpf_local_storage_rcu_lock_held());
> >       if (!sk_storage)
> >               return NULL;
> >
> > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> >  {
> >       struct bpf_local_storage_data *sdata;
> >
> > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> sk is protected by rcu_read_lock here.
> Is it always safe to access it with the rcu_read_lock_trace alone ?

We don't dereference sk with an rcu_dereference though, is it still the case for
tracing and LSM programs? Or is it somehow implicity protected even
though we don't
use rcu_dereference since that's just a READ_ONCE + some checks?

Would grabbing a refcount earlier in the code be helpful?

>
> >               return (unsigned long)NULL;
> >
