Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A547EFA9
	for <lists+bpf@lfdr.de>; Fri, 24 Dec 2021 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhLXOir (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Dec 2021 09:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhLXOir (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Dec 2021 09:38:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE9EC061401
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 06:38:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50A35B82301
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 14:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC816C36AEB
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640356724;
        bh=0Wv0U5d7BcIqpZKgqu8eunTIPIHmJ+8elWlNpzgu9X8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPvKCiX3wimJHQJKShOXNR4NZPoMZs+48xgy0sj2+v/uCIxaG0dOL+JJYKp7QiScI
         SDsia+fUQpx2RSFwTfJ+A0E+cT1CDjqdhDeFtFtms+JSeTDwl6DzRXov3FiUDrvg5U
         PcCc7/ULwrHXJMGoGRAqiQ5ts32e0HkeWfysbUPE8uradSpyg+oCqI9QHTKUuJJPBK
         mfBb0649SCWthGL2cZyj0fIwGDrrXsoA+0b993pQ3YH2wFhB29gmnlg22ISODDIZd2
         pGITcOyscliCvqB7RcQmBGnIQN3oNTA9HT9jUXtXeXhMokkZIJ27dNO/ODWlpdt2hN
         Lyy6MTa2rA9lg==
Received: by mail-ed1-f47.google.com with SMTP id q14so26400516edi.3
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 06:38:43 -0800 (PST)
X-Gm-Message-State: AOAM5306SMXmb5VlAtrOZ3u2UeoW6HbGlEoj14sf11nKDBm2bu0FeeS+
        TSewsfI4XrSjrPiJGDYjqT26uWv7Qb+TWcZxz33+eA==
X-Google-Smtp-Source: ABdhPJz59rryUfD77TPnsYcJCz4gDz3fS/U/2wpdTbzjKYJfnPdSPprVJztaQdlVOLbhgg84qhmnPnFjlaeiIWgg15E=
X-Received: by 2002:a17:907:7b8d:: with SMTP id ne13mr5537044ejc.496.1640356722194;
 Fri, 24 Dec 2021 06:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20211206151909.951258-1-kpsingh@kernel.org> <20211206151909.951258-2-kpsingh@kernel.org>
 <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com> <20211209070004.gj5b4ybrcdxqblbp@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211209070004.gj5b4ybrcdxqblbp@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 24 Dec 2021 20:08:31 +0530
X-Gmail-Original-Message-ID: <CACYkzJ6X23jSoqPJfMgtQah4qbKfnmsyRwOn2dAVEGePk3_zcg@mail.gmail.com>
Message-ID: <CACYkzJ6X23jSoqPJfMgtQah4qbKfnmsyRwOn2dAVEGePk3_zcg@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 12:30 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Dec 09, 2021 at 03:18:21AM +0100, KP Singh wrote:
> > On Thu, Dec 9, 2021 at 3:00 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
> > > [ ... ]
> > >
> > > > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > > > index 96ceed0e0fb5..20604d904d14 100644
> > > > --- a/kernel/bpf/bpf_inode_storage.c
> > > > +++ b/kernel/bpf/bpf_inode_storage.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/bpf_lsm.h>
> > > >  #include <linux/btf_ids.h>
> > > >  #include <linux/fdtable.h>
> > > > +#include <linux/rcupdate_trace.h>
> > > >
> > > >  DEFINE_BPF_STORAGE_CACHE(inode_cache);
> > > >
> > > > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> > > >       if (!bsb)
> > > >               return NULL;
> > > >
> > > > -     inode_storage = rcu_dereference(bsb->storage);
> > > > +     inode_storage =
> > > > +             rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
> > > >       if (!inode_storage)
> > > >               return NULL;
> > > >
> > > > @@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
> > > >        * local_storage->list was non-empty.
> > > >        */
> > > >       if (free_inode_storage)
> > > > -             kfree_rcu(local_storage, rcu);
> > > > +             call_rcu_tasks_trace(&local_storage->rcu,
> > > > +                                  bpf_local_storage_free_rcu);
> > > It is not clear to me why bpf_inode_storage_free() needs this change
> > > but not in bpf_task_storage_free() and bpf_sk_storage_free().
> > > Could you explain the reason here?
> >
> > I think I carried this forward from my older version and messed it up
> > while applying diffs, I tested on the linux-next branch which has it
> > for the other storages as well.
> >
> > We will need to free all these under trace RCU. Will fix it in v3.
> For sk, bpf_sk_storage_free() is called when sk is about to be kfree.
> My understanding is the sleepable bpf_lsm should not be running
> with this sk in parallel at this point when the sk has already reached
> the bpf_sk_storage_free().  iow, call_rcu_tasks_trace should not
> be needed here.  The existing kfree_rcu() is for the
> bpf_local_storage_map_free.
>

You are right, the callback for both the task and inode are
called before the inode is actually freed,
[inode_free_security and task_free]
This is similar to the lifetime of the sk storage
so kfree_rcu should suffice.

> I was not sure for inode since the inode's storage life time
> is not obvious to me, so the earlier question.
>
> After another thought, the synchronize_rcu_mult changes in
> bpf_local_storage_map_free() is also not needed.  The first
> existing synchronize_rcu() is for the bpf_sk_storage_clone().
> The second one is for the bpf_(sk|task|inode)_storage_free().
