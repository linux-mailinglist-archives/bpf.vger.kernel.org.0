Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7EE3FCDF9
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhHaTjJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 15:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhHaTjJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 15:39:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA60260F9E
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438693;
        bh=wwBSEkrAC3WSatRuHDQSO5MogVd7BlL9mqp3If8UQvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qf2/eGnSHPLhE8kjShRlWkJ9uFDj9MGzh87aavIontOe/62Z4tBHXJFBhI95X1Njw
         HEGnjq+0FK9KO0ce8PY+Q9YmxePRi4Cf1OwPoTxhfrmQlesQNRg9k6uWD3ch/ryVZv
         gN1GSx/uaVJJj8CfWdOsrpwG5QOtQ8AvyMc5pD3/y3Iheg0TOtBBIqWLMAf6hf0OUO
         98zjFEijVLTNDpvsK54osvZmuxMJw9TM1SPuC2FPbzXXc+5NDBEF2Wlu0/n2sDQoYA
         a15XS3fpZPve9v7jzuBlFsg6HmvMJ2CTzNCfM5dIlDfmYre+/Fxv0SJuk6rhalrLLv
         X5iNumdz414IQ==
Received: by mail-lj1-f176.google.com with SMTP id d16so677816ljq.4
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 12:38:13 -0700 (PDT)
X-Gm-Message-State: AOAM530NmkkdaJbB7yx4icvhxRPYZe/1uLpoM3s4hF3u4NCgcDW59Nls
        Q2DVlUTJcS7KQFBO+0sfycfnoyCYsYKFjx6BtNtlYQ==
X-Google-Smtp-Source: ABdhPJyKagyQ0HeU/M/5vvU6qycdz8ISY1cfhiO4ZuGysPpHSm4EN5hPu/xlI9uHL8WCaRxRm47t3vwMlRW/9lYmXgw=
X-Received: by 2002:a2e:7814:: with SMTP id t20mr26404882ljc.13.1630438692084;
 Tue, 31 Aug 2021 12:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210826235127.303505-1-kpsingh@kernel.org> <20210826235127.303505-2-kpsingh@kernel.org>
 <20210827205530.zzqawd6wz52n65qh@kafai-mbp> <CACYkzJ6sgJ+PV3SUMtsg=8Xuun2hfYHn8szQ6Rdps7rpWmPP_g@mail.gmail.com>
 <20210831021132.sehzvrudvcjbzmwt@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ5nQ4O-XqX0VHCPs77hDcyjtbk2c9DjXLdZLJ-7sO6DgQ@mail.gmail.com> <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210831182207.2roi4hzhmmouuwin@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 31 Aug 2021 21:38:01 +0200
X-Gmail-Original-Message-ID: <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
Message-ID: <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 8:22 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 31, 2021 at 11:50:48AM +0200, KP Singh wrote:
> > On Tue, Aug 31, 2021 at 4:11 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Sun, Aug 29, 2021 at 11:52:03PM +0200, KP Singh wrote:
> > > [ ... ]
> > >
> > > > > > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> > > > > > index b305270b7a4b..7760bc4e9565 100644
> > > > > > --- a/kernel/bpf/bpf_local_storage.c
> > > > > > +++ b/kernel/bpf/bpf_local_storage.c
> > > > > > @@ -11,6 +11,8 @@
> > > > > >  #include <net/sock.h>
> > > > > >  #include <uapi/linux/sock_diag.h>
> > > > > >  #include <uapi/linux/btf.h>
> > > > > > +#include <linux/rcupdate_trace.h>
> > > > > > +#include <linux/rcupdate_wait.h>
> > > > > >
> > > > > >  #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
> > > > > >
> > > > > > @@ -81,6 +83,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> > > > > >       return NULL;
> > > > > >  }
> > > > > >
> > > > > > +void bpf_local_storage_free_rcu(struct rcu_head *rcu)
> > > > > > +{
> > > > > > +     struct bpf_local_storage *local_storage;
> > > > > > +
> > > > > > +     local_storage = container_of(rcu, struct bpf_local_storage, rcu);
> > > > > > +     kfree_rcu(local_storage, rcu);
> > > > > > +}
> > > > > > +
> > > > > > +static void bpf_selem_free_rcu(struct rcu_head *rcu)
> > > > > > +{
> > > > > > +     struct bpf_local_storage_elem *selem;
> > > > > > +
> > > > > > +     selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> > > > > > +     kfree_rcu(selem, rcu);
> > > > > > +}
> > > > > > +
> > > > > >  /* local_storage->lock must be held and selem->local_storage == local_storage.
> > > > > >   * The caller must ensure selem->smap is still valid to be
> > > > > >   * dereferenced for its smap->elem_size and smap->cache_idx.
> > > > > > @@ -118,12 +136,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > >                *
> > > > > >                * Although the unlock will be done under
> > > > > >                * rcu_read_lock(),  it is more intutivie to
> > > > > > -              * read if kfree_rcu(local_storage, rcu) is done
> > > > > > +              * read if the freeing of the storage is done
> > > > > >                * after the raw_spin_unlock_bh(&local_storage->lock).
> > > > > >                *
> > > > > >                * Hence, a "bool free_local_storage" is returned
> > > > > > -              * to the caller which then calls the kfree_rcu()
> > > > > > -              * after unlock.
> > > > > > +              * to the caller which then calls then frees the storage after
> > > > > > +              * all the RCU grace periods have expired.
> > > > > >                */
> > > > > >       }
> > > > > >       hlist_del_init_rcu(&selem->snode);
> > > > > > @@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > >           SDATA(selem))
> > > > > >               RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
> > > > > >
> > > > > > -     kfree_rcu(selem, rcu);
> > > > > > +     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > > Although the common use case is usually storage_get() much more often
> > > > > than storage_delete(), do you aware any performance impact for
> > > > > the bpf prog that does a lot of storage_delete()?
> > > >
> > > > I have not really measured the impact on deletes, My understanding is
> > > > that it should
> > > > not impact the BPF program, but yes, if there are some critical
> > > > sections that are prolonged
> > > > due to a sleepable program "sleeping" too long, then it would pile up
> > > > the callbacks.
> > > >
> > > > But this is not something new, as we have a similar thing in BPF
> > > > trampolines. If this really
> > > > becomes an issue, we could add a flag BPF_F_SLEEPABLE_STORAGE and only maps
> > > > with this flag would be allowed in sleepable progs.
> > > Agree that is similar to trampoline updates but not sure it is comparable
> > > in terms of the frequency of elems being deleted here.  e.g. many
> > > short lived tcp connections created by external traffic.
> > >
> > > Adding a BPF_F_SLEEPABLE_STORAGE later won't work.  It will break
> > > existing sleepable bpf prog.
> > >
> > > I don't know enough on call_rcu_tasks_trace() here, so the
> > > earlier question on perf/callback-pile-up implications in order to
> > > decide if extra logic or knob is needed here or not.
> >
> > I will defer to the others, maybe Alexei and Paul,
>
> > we could also just
> > add the flag to not affect existing performance characteristics?
> I would see if it is really necessary first.  Other sleepable
> supported maps do not need a flag.  Adding one here for local
> storage will be confusing especially if it turns out to be
> unnecessary.
>
> Could you run some tests first which can guide the decision?

I think the performance impact would happen only in the worst case which
needs some work to simulate. What do you think about:

A bprm_committed_creds program that processes a large argv
and also gets a storage on the inode.

A file_open program that tries to delete the local storage on the inode.

Trigger this code in parallel. i.e. lots of programs that execute with a very
large argv and then in parallel the executable being opened to trigger the
delete.

Do you have any other ideas? Is there something we could re-use from
the selftests?

>
> >
> > >
> > > >
> > > > We could then wait for both critical sections only when this flag is
> > > > set on the map.
> > > >
> > > > >
> > > > > >
> > > > > >       return free_local_storage;
> > > > > >  }
> > > > > > @@ -154,7 +172,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
> > > > > >       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > > > > >
> > > > > >       if (free_local_storage)
> > > > > > -             kfree_rcu(local_storage, rcu);
> > > > > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > > > > +                                  bpf_local_storage_free_rcu);
> > > > > >  }
> > > > > >
> > > > > >  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
> > > > > > @@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> > > > > >       struct bpf_local_storage_elem *selem;
> > > > > >
> > > > > >       /* Fast path (cache hit) */
> > > > > > -     sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
> > > > > > +     sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
> > > > > > +                                       bpf_local_storage_rcu_lock_held());
> > > > > There are other places using rcu_dereference() also.
> > > > > e.g. in bpf_local_storage_update().
> > > > > Should they be changed also?
> > > >
> > > > From what I saw, the other usage of rcu_derference is in a nested
> > > > (w.r.t to the RCU section that in bpf_prog_enter/exit) RCU
> > > > read side critical section/rcu_read_{lock, unlock} so it should not be required.
> > > hmm... not sure what nested or not has to do here.
> > > It is likely we are talking different things.
> > >
> > Yeah, we were looking at different things.
> >
> > e.g. bpf_selem_unlink does not need to be changed as it is in
> > a rcu_read_lock.
> No.  It is not always under rcu_read_lock().  From the patch 2 test,
> it should have a splat either from bpf_inode_storage_delete()
> or bpf_sk_storage_delete(), depending on which one runs first.

I missed this one, but I wonder why it did not trigger a warning. The test does
exercise the delete and rcu_dereference should have warned me that I am not
holding an rcu_read_lock();


>
> > But you are right there is another in bpf_local_storage_update which I will fix.
> >
> > > Did you turn on the lockdep rcu debugging in kconfig?
> >
> > Yes I have PROVE_RCU and LOCKDEP
> >
> > >
> > > afaik, lockdep uses the second "check" argument to WARN on incorrect usage.
> > > Even the right check is passed here, the later rcu_dereference() will still
> > > complain because it only checks for rcu_read_lock_held().
> >
> >
> > >
> > > Also, after another look, why rcu_dereference_protected() is used
> > > here instead of rcu_dereference_check()?  The spinlock is not acquired
> > > here.  The same comment goes for similar rcu_dereference_protected() usages.
> >
> >
> > Good catch, it should be rcu_dereference_check.
> >
> > >
> > > >
> > > > If there are some that are not, then they need to be updated. Did I miss any?
> > > >
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > --- a/net/core/bpf_sk_storage.c
> > > > > > +++ b/net/core/bpf_sk_storage.c
> > > > > > @@ -13,6 +13,7 @@
> > > > > >  #include <net/sock.h>
> > > > > >  #include <uapi/linux/sock_diag.h>
> > > > > >  #include <uapi/linux/btf.h>
> > > > > > +#include <linux/rcupdate_trace.h>
> > > > > >
> > > > > >  DEFINE_BPF_STORAGE_CACHE(sk_cache);
> > > > > >
> > > > > > @@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> > > > > >       struct bpf_local_storage *sk_storage;
> > > > > >       struct bpf_local_storage_map *smap;
> > > > > >
> > > > > > -     sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > > > +     sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
> > > > > > +                                            bpf_local_storage_rcu_lock_held());
> > > > > >       if (!sk_storage)
> > > > > >               return NULL;
> > > > > >
> > > > > > @@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
> > > > > >  {
> > > > > >       struct bpf_local_storage_data *sdata;
> > > > > >
> > > > > > +     WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
> > > > > >       if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
> > > > > sk is protected by rcu_read_lock here.
> > > > > Is it always safe to access it with the rcu_read_lock_trace alone ?
> > > >
> > > > We don't dereference sk with an rcu_dereference though, is it still the case for
> > > > tracing and LSM programs? Or is it somehow implicity protected even
> > > > though we don't use rcu_dereference since that's just a READ_ONCE + some checks?
> > > e.g. the bpf_prog (currently run under rcu_read_lock()) may read the sk from
> > > req_sk->sk which I don't think the verifier will optimize it out, so as good
> > > as READ_ONCE(), iiuc.
> > >
> > > The sk here is obtained from the bpf_lsm_socket_* hooks?  Those sk should have
> > > a refcnt, right?  If that is the case, it should be good enough for now.
> >
> > The one passed in the arguments yes, but if you notice the discussion in
> >
> > https://lore.kernel.org/bpf/20210826133913.627361-1-memxor@gmail.com/T/#me254212a125516a6c5d2fbf349b97c199e66dce0
> >
> > one may also get an sk in LSM and tracing progs by pointer walking.
> Right.  There is pointer walking case.
> e.g. "struct request_sock __rcu *fastopen_rsk" in tcp_sock.
> I don't think it is possible for lsm to get a hold on tcp_sock
> but agree that other similar cases could happen.
>
> May be for now, in sleepable program, only allow safe sk ptr
> to be used in helpers that take sk PTR_TO_BTF_ID argument.
> e.g. sock->sk is safe in the test in patch 2.  The same should go for other
> storages like inode.  This needs verifier change.
>

Sorry, I may be missing some context. Do you mean wait for Yonghong's work?

Or is there another way to update the verifier to recognize safe sk and inode
pointers?

> In the very near future, it can move to Yonghong's (cc) btf tagging solution
> to tag a particular member of a struct to make this verifier checking more
> generic.
