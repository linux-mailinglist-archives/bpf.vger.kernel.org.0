Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989DD46E0D1
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 03:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhLICWJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 21:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLICWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 21:22:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD0DC061746
        for <bpf@vger.kernel.org>; Wed,  8 Dec 2021 18:18:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BFAEB8236F
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 02:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F10AC00446
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 02:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639016313;
        bh=djzq423oJ8FQsR3BME7b4e5yajauwvUp1t0HmCLs90s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AINylwePjahSJcGvkbPGD0CPOQ6zDgrL+CvHumM4j/BtQAVHQpUmqBGuNvlVt4zqd
         rGjNkDkLzQpQ9mSGnF8I23d3WuSTKaLCd/VxeuWnW139fywqAiTRWw1UKCnYt/vm5D
         hoGG//oT6XbOet39WYztDwfIUszy8dgPGblseVJblSeiWlA6QbgO4eZUPtq3zj9GoB
         jJNHqWGyBy0Oy3OJI++IU6YcZhZF9+jWFAWmdxdk7r7KUMkNjWHBCbbO6BLP/Hscgo
         hYg0bjHeZm9/bEkP1uCuvpeA2vBMf0NvoL4w1d7IZtpaI/AHELgvFiM8yoa6o+eMVK
         CWJzzMAgWj+gg==
Received: by mail-ed1-f42.google.com with SMTP id g14so14438610edb.8
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 18:18:33 -0800 (PST)
X-Gm-Message-State: AOAM5302zTEXPmxZK+x/1WIQp0Xzvsh/gl5xDrBObRSr4jGFIcure7Q/
        V5UmEvxdIEwyC1ZnOLrPTHg48fEZCPvjIpc7K5GDCw==
X-Google-Smtp-Source: ABdhPJx9s9DbLgGUTYSJ8pA9+sTPZSTIlnXmqs8VKl7BVl1ZonkRro4nvmOCXERMMbeaG8bd7jEsAhQaEAdYIe1UYJk=
X-Received: by 2002:a17:907:3e0a:: with SMTP id hp10mr12218579ejc.318.1639016311671;
 Wed, 08 Dec 2021 18:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20211206151909.951258-1-kpsingh@kernel.org> <20211206151909.951258-2-kpsingh@kernel.org>
 <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211209015938.s2f4wmjtiqagjwqy@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 9 Dec 2021 03:18:21 +0100
X-Gmail-Original-Message-ID: <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com>
Message-ID: <CACYkzJ77G4f_FJ=q7BKCta-rodWiescgEnkqE5U+kAW+=bw5_w@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 3:00 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Dec 06, 2021 at 03:19:08PM +0000, KP Singh wrote:
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > index 96ceed0e0fb5..20604d904d14 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/fdtable.h>
> > +#include <linux/rcupdate_trace.h>
> >
> >  DEFINE_BPF_STORAGE_CACHE(inode_cache);
> >
> > @@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
> >       if (!bsb)
> >               return NULL;
> >
> > -     inode_storage = rcu_dereference(bsb->storage);
> > +     inode_storage =
> > +             rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
> >       if (!inode_storage)
> >               return NULL;
> >
> > @@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
> >        * local_storage->list was non-empty.
> >        */
> >       if (free_inode_storage)
> > -             kfree_rcu(local_storage, rcu);
> > +             call_rcu_tasks_trace(&local_storage->rcu,
> > +                                  bpf_local_storage_free_rcu);
> It is not clear to me why bpf_inode_storage_free() needs this change
> but not in bpf_task_storage_free() and bpf_sk_storage_free().
> Could you explain the reason here?

I think I carried this forward from my older version and messed it up
while applying diffs, I tested on the linux-next branch which has it
for the other storages as well.

We will need to free all these under trace RCU. Will fix it in v3.

>
> > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > index bb69aea1a777..1def13ad5c72 100644
> > --- a/kernel/bpf/bpf_task_storage.c
> > +++ b/kernel/bpf/bpf_task_storage.c
> > @@ -17,6 +17,7 @@
> >  #include <uapi/linux/btf.h>
> >  #include <linux/btf_ids.h>
> >  #include <linux/fdtable.h>
> > +#include <linux/rcupdate_trace.h>
> >
> >  DEFINE_BPF_STORAGE_CACHE(task_cache);
> >
> > @@ -59,7 +60,8 @@ task_storage_lookup(struct task_struct *task, struct bpf_map *map,
> >       struct bpf_local_storage *task_storage;
> >       struct bpf_local_storage_map *smap;
> >
> > -     task_storage = rcu_dereference(task->bpf_storage);
> > +     task_storage =
> > +             rcu_dereference_check(task->bpf_storage, bpf_rcu_lock_held());
> >       if (!task_storage)
> >               return NULL;
> >
> > @@ -77,7 +79,8 @@ void bpf_task_storage_free(struct task_struct *task)
> >
> >       rcu_read_lock();
> >
> > -     local_storage = rcu_dereference(task->bpf_storage);
> > +     local_storage =
> > +             rcu_dereference_check(task->bpf_storage, bpf_rcu_lock_held());
> This change is unnecessary.  There is a rcu_read_lock() above.

Thanks, agreed.

>
> >       if (!local_storage) {
> >               rcu_read_unlock();
> >               return;
>
