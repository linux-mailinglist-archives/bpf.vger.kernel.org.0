Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802FB4641CA
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 23:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbhK3Wyx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 17:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344681AbhK3Wyw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Nov 2021 17:54:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B60BC061574
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 14:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EA54B81D7B
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A51C53FC7;
        Tue, 30 Nov 2021 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638312689;
        bh=00/Gi5WBvw+LbFmvsI+NCEKKTfjEKvNFzCXk/JlAB7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GtLo2owuMsr3RqcXwHHe/leMSEERMQUkSWDLquRuiHw/L+1lrzcv7ESw9MK2AdwoF
         fG+YY3QOmhZGp5c4tPddW4C23EZZPQnOoX5vdQtw9YXYMWWZSbbuAznj4V+Ogmpbxy
         g1nJPoIXAeHA7BTmAj3jZYTxt7QKJBWwv5AAglYe39M6yB09jjBDdu2P5XO0O2TbyC
         noosbIaTXcLq3xhy8PWr/fT49jIQ+AJ4J0XfsNC2GkmrnmuvRf37KBY0r703j1LOri
         R1q4Esg5kjhF8UheVYmjlS1/wwYxth2EMyPHK0kEoZ15A6WKuno14rZ3+ztEI3jQR6
         TxnOMn4g8Cklg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67D8E5C0367; Tue, 30 Nov 2021 14:51:29 -0800 (PST)
Date:   Tue, 30 Nov 2021 14:51:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20211130225129.GB641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CACYkzJ58Yp_YQBGMFCL_5UhjK3pHC5n-dcqpR-HEDz+Y-yasfw@mail.gmail.com>
 <20210901063217.5zpvnltvfmctrkum@kafai-mbp.dhcp.thefacebook.com>
 <20210901202605.GK4156@paulmck-ThinkPad-P17-Gen-1>
 <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
 <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
 <20211130023410.hmyw7fhxwpskf6ba@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7+V=ui7kS-8u7zQoHPT3zZE6X3QuRROG3898Mai9JAcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ7+V=ui7kS-8u7zQoHPT3zZE6X3QuRROG3898Mai9JAcg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 30, 2021 at 05:22:25PM +0100, KP Singh wrote:
> On Tue, Nov 30, 2021 at 3:34 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 11:20:40PM +0100, KP Singh wrote:
> > > On Tue, Nov 23, 2021 at 11:30 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Tue, Nov 23, 2021 at 10:22:04AM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Nov 23, 2021 at 06:11:14PM +0100, KP Singh wrote:
> > > > > > On Thu, Sep 2, 2021 at 6:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > > > > > I think the global lock will be an issue for the current non-sleepable
> > > > > > > netdev bpf-prog which could be triggered by external traffic,  so a flag
> > > > > > > is needed here to provide a fast path.  I suspect other non-prealloc map
> > > > > > > may need it in the future, so probably
> > > > > > > s/BPF_F_SLEEPABLE_STORAGE/BPF_F_SLEEPABLE/ instead.
> > > > > >
> > > > > > I was re-working the patches and had a couple of questions.
> > > > > >
> > > > > > There are two data structures that get freed under RCU here:
> > > > > >
> > > > > > struct bpf_local_storage
> > > > > > struct bpf_local_storage_selem
> > > > > >
> > > > > > We can choose to free the bpf_local_storage_selem under
> > > > > > call_rcu_tasks_trace based on
> > > > > > whether the map it belongs to is sleepable with something like:
> > > > > >
> > > > > > if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
> > > > Paul's current work (mentioned by his previous email) will improve the
> > > > performance of call_rcu_tasks_trace, so it probably can avoid the
> > > > new BPF_F_SLEEPABLE flag and make it easier to use.
> > > >
> > > > > >     call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > > > > else
> > > > > >     kfree_rcu(selem, rcu);
> > > > > >
> > > > > > Questions:
> > > > > >
> > > > > > * Can we free bpf_local_storage under kfree_rcu by ensuring it's
> > > > > >   always accessed in a  classical RCU critical section?
> > > > >>    Or maybe I am missing something and this also needs to be freed
> > > > > >   under trace RCU if any of the selems are from a sleepable map.
> > > > In the inode_storage_lookup() of this patch:
> > > >
> > > > +#define bpf_local_storage_rcu_lock_held()                      \
> > > > +       (rcu_read_lock_held() || rcu_read_lock_trace_held() ||  \
> > > > +        rcu_read_lock_bh_held())
> > > >
> > > > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> > > >         if (!bsb)
> > > >                 return NULL;
> > > >
> > > > -       inode_storage = rcu_dereference(bsb->storage);
> > > > +       inode_storage = rcu_dereference_protected(bsb->storage,
> > > > +                                                 bpf_local_storage_rcu_lock_held());
> > > >
> > > > Thus, it is not always in classical RCU critical.
> > > >
> > > > > >
> > > > > > * There is an issue with nested raw spinlocks, e.g. in
> > > > > > bpf_inode_storage.c:bpf_inode_storage_free
> > > > > >
> > > > > >   hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > > > > >   /* Always unlink from map before unlinking from
> > > > > >   * local_storage.
> > > > > >   */
> > > > > >   bpf_selem_unlink_map(selem);
> > > > > >   free_inode_storage = bpf_selem_unlink_storage_nolock(
> > > > > >                  local_storage, selem, false);
> > > > > >   }
> > > > > >   raw_spin_unlock_bh(&local_storage->lock);
> > > > > >
> > > > > > in bpf_selem_unlink_storage_nolock (if we add the above logic with the
> > > > > > flag in place of kfree_rcu)
> > > > > > call_rcu_tasks_trace grabs a spinlock and these cannot be nested in a
> > > > > > raw spin lock.
> > > > > >
> > > > > > I am moving the freeing code out of the spinlock, saving the selems on
> > > > > > a local list and then doing the free RCU (trace or normal) callbacks
> > > > > > at the end. WDYT?
> > > > There could be more than one selem to save.
> > >
> > > Yes, that's why I was saving them on a local list and then calling
> > > kfree_rcu or call_rcu_tasks_trace after unlocking the raw_spin_lock
> > >
> > > INIT_HLIST_HEAD(&free_list);
> > > raw_spin_lock_irqsave(&local_storage->lock, flags);
> > > hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> > >     bpf_selem_unlink_map(selem);
> > >     free_local_storage = bpf_selem_unlink_storage_nolock(
> > >     local_storage, selem, false);
> > >     hlist_add_head(&selem->snode, &free_list);
> > > }
> > > raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> > >
> > > /* The element needs to be freed outside the raw spinlock because spin
> > > * locks cannot nest inside a raw spin locks and call_rcu_tasks_trace
> > > * grabs a spinklock when the RCU code calls into the scheduler.
> > > *
> > > * free_local_storage should always be true as long as
> > > * local_storage->list was non-empty.
> > > */
> > > hlist_for_each_entry_safe(selem, n, &free_list, snode) {
> > >     if (selem->sdata.smap->map.map_flags & BPF_F_SLEEPABLE_STORAGE)
> > >         call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > >     else
> > >         kfree_rcu(selem, rcu);
> > > }
> > >
> > > But... we won't need this anymore.
> > Yep, Paul's work (thanks!) will make this piece simpler.
> 
> +100
> 
> >
> > KP, this set functionally does not depend on Paul's changes.
> > Do you want to spin a new version so that it can be reviewed in parallel?
> 
> Sure, I will fix the remaining issues (i.e. with RCU locks and renames) and
> spin a new version.
> 
> > When the rcu-task changes land in -next, it can probably
> > be merged into bpf-next first before landing the sleepable
> > bpf storage work.

And I just now got both the expand-queues and shrink-queues code at
least pretending to work, and it will be picked up in the next -next.
I was probably too late for today's edition, but there is always tomorrow.

There are probably still bugs, but it is passing much nastier tests than
a couple of weeks ago, so here is hoping...

							Thanx, Paul
