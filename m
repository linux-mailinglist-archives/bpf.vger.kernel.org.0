Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BFB47CC44
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 05:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbhLVEng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 23:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhLVEnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 23:43:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1092FC061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 20:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC53618A2
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 04:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA214C36AEC
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 04:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640148213;
        bh=CZCJ49GU/lnO9VEQ+lTa+QnxVaJaLaIW2O4nyTbT6DA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q2ggk/0tEpx0AO5YN9oi93wpZj+Avhiv4Zieypzx67HYsTBryeM4DUxWfvqL9rSMU
         PFvMpz536lzjXMU56rxqNSWtLjeI0+8bNT9adTCal2eqFvohmncd6k4clbwTykwAKN
         ozvkZvfmcwMlW2oNkewzRv/rkFxmTSKeUl0jGKfqG8zXvAgMEn0boCypmYl7ofWAZN
         n4lo5TYd6XkvrW7rSJrzKng7LHr0yWs5aPzOBA4kmrHzaJJj3raN1eowi0pNDoYbZr
         qCjY9VYgIuZ04K7wmE6Y3LeaEUd0JZubTlO8/zjJPdj00R5dBCa/Orz/1l9YwPxWtb
         rForsjfkK22rg==
Received: by mail-ed1-f43.google.com with SMTP id y13so3440835edd.13
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 20:43:33 -0800 (PST)
X-Gm-Message-State: AOAM530lapPcS7EU2KLm3Mclobtj3gfJiQXG6nHbuU+9VuihlP3Z8NWJ
        LWCetHSSIQju1ocyNoohbb2LSdE8+t+rZ4TsJ26vcw==
X-Google-Smtp-Source: ABdhPJz4aw/LkGc4427FQWKN9zZkAoo4Kaa6DyTnF/MzwGSEZoInL8rpzs7Hcl1jnrD5fdeUF6Z13/33ioPFRV8AvCg=
X-Received: by 2002:a05:6402:908:: with SMTP id g8mr1314039edz.59.1640148211942;
 Tue, 21 Dec 2021 20:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20211206151909.951258-1-kpsingh@kernel.org> <20211206151909.951258-2-kpsingh@kernel.org>
 <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com>
 <20211209070004.gj5b4ybrcdxqblbp@kafai-mbp.dhcp.thefacebook.com> <20211220185946.wx7r5vwwcnarcyfr@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211220185946.wx7r5vwwcnarcyfr@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 22 Dec 2021 10:13:20 +0530
X-Gmail-Original-Message-ID: <CACYkzJ7U_Db8OMoZ+kp-STSnxMqX3uS_S9568ryooxdw1Pfmrg@mail.gmail.com>
Message-ID: <CACYkzJ7U_Db8OMoZ+kp-STSnxMqX3uS_S9568ryooxdw1Pfmrg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Allow bpf_local_storage to be used
 by sleepable programs
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 12:30 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Dec 08, 2021 at 11:00:04PM -0800, Martin KaFai Lau wrote:
> > On Thu, Dec 09, 2021 at 03:18:21AM +0100, KP Singh wrote:
> > > On Thu, Dec 9, 2021 at 3:00 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
> > > > [ ... ]
> > > >
> > > > > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > > > > index 96ceed0e0fb5..20604d904d14 100644
> > > > > --- a/kernel/bpf/bpf_inode_storage.c
> > > > > +++ b/kernel/bpf/bpf_inode_storage.c
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include <linux/bpf_lsm.h>
> > > > >  #include <linux/btf_ids.h>
> > > > >  #include <linux/fdtable.h>
> > > > > +#include <linux/rcupdate_trace.h>
> > > > >
> > > > >  DEFINE_BPF_STORAGE_CACHE(inode_cache);
> > > > >
> > > > > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> > > > >       if (!bsb)
> > > > >               return NULL;
> > > > >
> > > > > -     inode_storage = rcu_dereference(bsb->storage);
> > > > > +     inode_storage =
> > > > > +             rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
> > > > >       if (!inode_storage)
> > > > >               return NULL;
> > > > >
> > > > > @@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
> > > > >        * local_storage->list was non-empty.
> > > > >        */
> > > > >       if (free_inode_storage)
> > > > > -             kfree_rcu(local_storage, rcu);
> > > > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > > > +                                  bpf_local_storage_free_rcu);
> > > > It is not clear to me why bpf_inode_storage_free() needs this change
> > > > but not in bpf_task_storage_free() and bpf_sk_storage_free().
> > > > Could you explain the reason here?
> > >
> > > I think I carried this forward from my older version and messed it up
> > > while applying diffs, I tested on the linux-next branch which has it
> > > for the other storages as well.
> > >
> > > We will need to free all these under trace RCU. Will fix it in v3.
> > For sk, bpf_sk_storage_free() is called when sk is about to be kfree.
> > My understanding is the sleepable bpf_lsm should not be running
> > with this sk in parallel at this point when the sk has already reached
> > the bpf_sk_storage_free().  iow, call_rcu_tasks_trace should not
> > be needed here.  The existing kfree_rcu() is for the
> > bpf_local_storage_map_free.
> >
> > I was not sure for inode since the inode's storage life time
> > is not obvious to me, so the earlier question.
> >
> > After another thought, the synchronize_rcu_mult changes in
> > bpf_local_storage_map_free() is also not needed.  The first
> > existing synchronize_rcu() is for the bpf_sk_storage_clone().
> > The second one is for the bpf_(sk|task|inode)_storage_free().
> KP, if the above comment makes sense, do you want to respin v3 ?
> or I can also help to respin and keep your SOB?  Thanks.

Hey Martin, the comment makes sense, I just took some time off and
traveled to India (which was complicated these days).
I can respin it this week.
