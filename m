Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0F314131
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 22:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhBHVDX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhBHVCM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 16:02:12 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91551C06178C
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 13:01:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y128so15951135ybf.10
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 13:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PB+MRL4kSOqSUDuSYo0AafVj6TUt+eIu7gq93EjO+eI=;
        b=MxqEDPVZMQX+l4er45qAeUDPGhMt0aCWknZQg/dYS3TizWda/xd90LOh5nZGDaWLTY
         JnA/zskTnALdsj4/vhkkgy8+xTnlCyx/8sS7BddoEKp68CFQQGQ05Jd7gAyxT/WPI+Q9
         9OFiVJaeCe8ARlt2cmSzhjk8BrdrlowKG1cagRUB4X2PZsnhB+dCjCJXzld1ZsrkMI4U
         3NtwC5w0ZTp2yf0SDkwZ+j0aIA25vnGWvdtjJeE9vmraO2rZcmmqcBUq48OZYKINYXvD
         A2jA4fzP2wFVyTt/NaFs+7MGrKgejHWBPaw3MvM+nd0giZ5s2RwURd6YYGKF2c4vlD17
         fx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PB+MRL4kSOqSUDuSYo0AafVj6TUt+eIu7gq93EjO+eI=;
        b=TtTh7UOH49JHyUvTnQb5HanCmeNEqCtEisTodTpyrYfHTELSkSrJge9HxqrY+thb6R
         6YJeSoDJ9RUww06EfJaMYaT62zcNGywUHHXhMhw3qOlKggCaH+H+y+nAyifsZNvqTgJx
         1eSxSQFiJa2EiRx1mUqeNAj28ImF8f+iAJx275JY1Svx+LGJ/l5MjroY9j3944bWM0hN
         HqYIQqNL8MbnsnxRYcct6NFfzZvMX19PPoTSZZ6IlOZe47A72wGDYc5UMzRT21U4XVTN
         tLtmNVZamgWNaoU/Rdsew6NbPrCrxai5jBAe2zMgaHBVtsQSnjWVWb4QJLiaLwIYWVIX
         OFmg==
X-Gm-Message-State: AOAM532F3XaIYNxEp0BEHyqmAk9DiY35PRIkOq83RCkBk69dJUZiij8m
        wkphHMeTD9ZufjcDjwqwXx9xHeH9tTQxISmaIAg=
X-Google-Smtp-Source: ABdhPJyfJChvqkJIJxPXHCRbBEzAsWzZOeD6ixp/yV57N3XTp3+zGijRNH7GraMqULScd564Y6aC2YmwF7701tgz7Gs=
X-Received: by 2002:a25:3805:: with SMTP id f5mr11230358yba.27.1612818090930;
 Mon, 08 Feb 2021 13:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-7-alexei.starovoitov@gmail.com> <CAEf4BzaAvDYU4jD8N=CziaRAXnEsvU1QYSa=-x8Q-Sv7iOTdtw@mail.gmail.com>
In-Reply-To: <CAEf4BzaAvDYU4jD8N=CziaRAXnEsvU1QYSa=-x8Q-Sv7iOTdtw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 13:01:20 -0800
Message-ID: <CAEf4Bzb-bMCu9HVbxvnHCaiwFvu+mZDv4yS8H2aS-g4VxF2S0Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/7] bpf: Allows per-cpu maps and map-in-map
 in sleepable programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 1:00 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Feb 6, 2021 at 9:06 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Since sleepable programs are now executing under migrate_disable
> > the per-cpu maps are safe to use.

Also made me wonder if PERF_EVENT_ARRAY map is usable in sleepable now?

> > The map-in-map were ok to use in sleepable from the time sleepable
> > progs were introduced.
> >
> > Note that non-preallocated maps are still not safe, since there is
> > no rcu_read_lock yet in sleepable programs and dynamically allocated
> > map elements are relying on rcu protection. The sleepable programs
> > have rcu_read_lock_trace instead. That limitation will be addresses
> > in the future.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> Great.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  kernel/bpf/hashtab.c  | 4 ++--
> >  kernel/bpf/verifier.c | 7 ++++++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index c1ac7f964bc9..d63912e73ad9 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1148,7 +1148,7 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
> >                 /* unknown flags */
> >                 return -EINVAL;
> >
> > -       WARN_ON_ONCE(!rcu_read_lock_held());
> > +       WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
> >
> >         key_size = map->key_size;
> >
> > @@ -1202,7 +1202,7 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
> >                 /* unknown flags */
> >                 return -EINVAL;
> >
> > -       WARN_ON_ONCE(!rcu_read_lock_held());
> > +       WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
> >
> >         key_size = map->key_size;
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 4189edb41b73..9561f2af7710 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10020,9 +10020,14 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
> >                 case BPF_MAP_TYPE_HASH:
> >                 case BPF_MAP_TYPE_LRU_HASH:
> >                 case BPF_MAP_TYPE_ARRAY:
> > +               case BPF_MAP_TYPE_PERCPU_HASH:
> > +               case BPF_MAP_TYPE_PERCPU_ARRAY:
> > +               case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> > +               case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> > +               case BPF_MAP_TYPE_HASH_OF_MAPS:
> >                         if (!is_preallocated_map(map)) {
> >                                 verbose(env,
> > -                                       "Sleepable programs can only use preallocated hash maps\n");
> > +                                       "Sleepable programs can only use preallocated maps\n");
> >                                 return -EINVAL;
> >                         }
> >                         break;
> > --
> > 2.24.1
> >
