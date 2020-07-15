Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9C2216CA
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGOVHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOVG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 17:06:59 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1503C061755
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 14:06:58 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e18so3240796ilr.7
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA84KjJsNtfMiCCTDEU7ofOM7jqvaAEQqQ4kL/V+YEE=;
        b=f2yfgmA2Y+nfFgpOkrWYBZvx0kQFhg9ZItVj3rTggwqXduuBmRYVmR5PLw2wkVjNMr
         Kg5AA5N6LVD2gSXkDgnIDVVdw2D7q8KXW26KrSO2o0ehBIln7J/o42Twrpf1zNIJqIUR
         wAufntbeRTfqKYfsWYre4Mu3Mn2SbO8kX0SifEOXBWHtFWlX1F/iLoBgdxx0Tic+8CIP
         /e8667LDiBF6CmW4KdMhJo/yBzEJ+alhmu9MDp2MkW7gmLFTuduvx+ohz4Rg+bnKr4FV
         g8foiIJP9J197EOk9sBNhf5OMWDeJMrmv6L++svPTZ7A0lm7PDsgMi5Xvm4Ul7vW/1xl
         3vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA84KjJsNtfMiCCTDEU7ofOM7jqvaAEQqQ4kL/V+YEE=;
        b=kyq2JUNCGB2bEbmfHALDeURqb7r77XMQq+d2+OdQiXWiI+pFIiPr9yWCI1Eze8p2EL
         /NbN1U9ePeyeV/jPFLIwnvICGN0EtbDyo7VjDxCKqUx7fF85UjMOZeSWkkrtsg3b5RTZ
         z5JMM0NBduSPbLBUFc3LEkcHJPX9pOq2UuQPBWRWXZ1lqJ7wAdKi1Zd0S9rZvKwEyOQH
         yFWZMWGqPeb3vukedThZFfB2FG96yxfEtUkwGZiaCkJn9F8CKFAl+dRmMo6uDKpFK7kr
         4DE7aYPt0Gi9WURg1hX4UpDJkizZYzem8hAbFJ+rLRs9FjZ0ed8270ZllSQ/nUf8OUCO
         yDXQ==
X-Gm-Message-State: AOAM530eKIfFKiZlXvY9CN6C7pL2UFzAkn/yvvJemFzdE5BX3uXrryPK
        IH4MDiGI4FmRLoxHmUeu6w4wSCqcefuRjkVhyR5lQg==
X-Google-Smtp-Source: ABdhPJwk5KiKsma5JdUK/vEQau0coT7Uj5MIui97YB6klBgfvWuBjtS+13QVQf42pKxTUaRUh69v3PTa0N7SOmNsNMU=
X-Received: by 2002:a05:6e02:eb3:: with SMTP id u19mr1480598ilj.130.1594847217654;
 Wed, 15 Jul 2020 14:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594333800.git.zhuyifei@google.com> <6c368691a54345cfeba099b42e69c84814afdae1.1594333800.git.zhuyifei@google.com>
 <20200714235344.jl7cqxxvy5knxbnu@kafai-mbp>
In-Reply-To: <20200714235344.jl7cqxxvy5knxbnu@kafai-mbp>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Wed, 15 Jul 2020 16:06:45 -0500
Message-ID: <CAA-VZPn0QB2_Wg3szW75hMvUnc2ZUHGzgb2csRKszcLT62siJg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > +     list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> > +             bpf_cgroup_storage_unlink(storage);
> > +             bpf_cgroup_storage_free(storage);
> cgroup_storage_map_free() is also doing unlink and free.
> It is not clear to me what prevent cgroup_bpf_release()
> and cgroup_storage_map_free() from doing unlink and free at the same time.
>
> A few words comment here would be useful if it is fine.

Good catch. This can happen. Considering that this section is guarded
by cgroup_mutex, and that cgroup_storage_map_free is called in
sleepable context (either workqueue or map_create) I think the most
straightforward way is to also hold the cgroup_mutex in
cgroup_storage_map_free. Will fix in v3.

> > @@ -458,10 +457,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
> >       if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
> >               return -ENOMEM;
> >
> > +     bpf_cgroup_storages_link(storage, cgrp);
> here. After the new change in bpf_cgroup_storage_link(),
> the storage could be an old/existing storage that is
> being used by other bpf progs.

Right, I will swap storages_alloc to below this kmalloc and goto
cleanup if storages_alloc fails.

> > -     bpf_cgroup_storages_free(old_storage);
> >       if (old_prog)
> >               bpf_prog_put(old_prog);
> >       else
> >               static_branch_inc(&cgroup_bpf_enabled_key);
> > -     bpf_cgroup_storages_link(pl->storage, cgrp, type);
> Another side effect is, the "new" storage is still published to
> the map even the attach has failed.  I think this may be ok.

Correct. To really fix this we would need to keep track of exactly
which storages are new and which are old, and I don't think that doing
so has any significant benefits given that the lifetime of the
storages are still bounded. If userspace receives the error they are
probably going to either exit or retry. Exit will cause the storages
to be freed along with the map, and retry, if successful, needs the
storage be published anyways. That is the reasoning for thinking it is
okay.


> > -     next->attach_type = storage->key.attach_type;
> The map dump (e.g. bpftool map dump) will also show attach_type zero
> in the key now.  Please also mention that in the commit message.

Will fix in v3.

> This patch allows a cgroup-storage to be shared among different bpf-progs
> which is in the right direction that makes bpf_cgroup_storage_map behaves
> more like other bpf-maps do.  However, each bpf-prog can still only allow
> one "bpf_cgroup_storage_map" to be used (excluding the difference in the
> SHARED/PERCPU bpf_cgroup_storage_type).
> i.e. each bpf-prog can only access one type of cgroup-storage.
> e.g. prog-A stores storage-A.  If prog-B wants to store storage-B and
> also read storage-A, it is not possible if I read it correctly.

You are correct. It is still bound by the per-cpu variable, and
because the per-cpu variable is an array of storages, one for each
type, it still does not support more than one storage per type.

> While I think this patch is a fine extension to the existing
> bpf_cgroup_storage_map and a good step forward to make bpf_cgroup_storage_map
> sharable like other bpf maps do.  Have you looked at bpf_sk_storage.c which
> also defines a local storage for a sk but a bpf prog can define multiple
> storages to be stored in a sk.  It is doing similar thing of this
> patch (e.g. a link to the storage, another link to the map, the life
> time of the storage is tied to the map and the sk...etc.).  KP Singh is
> generalizing it such that bpf-prog can store data in potentially any
> kernel object other than sk [1].  His use case is to store data in inode.
> I think it can be used for the cgroup also.  The only thing missing there
> is the "PERCPU" type.  It was not there because there is no such need for sk
> but should be something quite doable.

I think this is a good idea, but it will be a much bigger project. I
would prefer to fix this problem of cgroup_storage not being shareable
first, and when KP's patches land I'll take a look at how to reuse
their code. And, as you said, it would be more involved due to needing
to add "PERCPU" support.

YiFei Zhu
