Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39A248F482
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiAOCx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 21:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiAOCxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 21:53:55 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91196C061574;
        Fri, 14 Jan 2022 18:53:55 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p7so14668758iod.2;
        Fri, 14 Jan 2022 18:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YE/aKRxV1Frj8g+/MVLSz2SGDwngA0eVhWnoNWIKlP4=;
        b=O50z9LOWVpwi+35d+IIk7xItMdbWBn8yqCaxIXNRPOi9b7w92Iix6duBqp9xB3z2YF
         ncf+vl0PZykccLq0L9HItDMPjDohR+bNTz7QUTvpBvUD6azSlJkmRcXc4DTRiBgv3Ili
         b81O16cbjjDOQZ17ReTkwjpIvKiWaZhXBVhaNsvQZU/RY7t53CXAv3svKAi9IJmk6OlR
         ZCcsJXLX8HjMh2wGHvfq3wWdIii7tmGCm4gZe5JJuWL2PHfFa29UP33mxzzZRErTdcJo
         nINGN92dGKcB0q9d9mcy3b70vXkOGKWbfl7EaGrRRKrq97gpCy0gljlS6DkXoBvOWTuf
         T5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YE/aKRxV1Frj8g+/MVLSz2SGDwngA0eVhWnoNWIKlP4=;
        b=zp3K3Exul0F11bpJwwhSGNN1aLbKO5lujKkCILX5qNz/E82zU6l2BKysdgYW29Xx2l
         o4cIf8CKlvfonkCvgmdZk6XsaIypqgK/KvrXuwOiwl1a5xOv+XNNtww5qN1n8uNglhJe
         2pCjxcTHmjpRKzBZVXsn7573hhTr6YizIcu24qqxlmJ/C7rkte7P4nLUwg1cQ5Bg/vAp
         qn12A8A50I/wIUgVeRkSIM4PzgS6udfJHU5lFTGiVnhSm2Klo215ky4jzRTvvk22FOOj
         CEezklnBnLkIa44d0s7kcyW/0epJadIlTBMeW7Vl3ytIWb0FVdbF9xxR+Z70q3djzTsW
         lYxA==
X-Gm-Message-State: AOAM530XUKL7evIjGO6nwZ8CpjtGGPtIXs5Urn1Th0zTQz13a02wxmBg
        nrRcWQN5/YDWcJtWgIU7EpgNmeuTQI+fIiyggOU=
X-Google-Smtp-Source: ABdhPJwSPuYMTGNjTd3GMHFwQiA486px6P6waCb2aszWdRwMHn5I9W4b7wQ3m9C59KYM5IBqCicTFaHu5HDZYneGf/w=
X-Received: by 2002:a02:8648:: with SMTP id e66mr4537417jai.145.1642215234726;
 Fri, 14 Jan 2022 18:53:54 -0800 (PST)
MIME-Version: 1.0
References: <58661dd93a834a2abbe42dd16da93e0b@huawei.com>
In-Reply-To: <58661dd93a834a2abbe42dd16da93e0b@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 18:53:43 -0800
Message-ID: <CAEf4Bzax8aWb68favtYGUUYS0BshMAJNy+0Mj0GHNXxDZY2KCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
To:     "zhudi (E)" <zhudi2@huawei.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Luzhihao (luzhihao, Euler)" <luzhihao@huawei.com>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 6:38 PM zhudi (E) <zhudi2@huawei.com> wrote:
>
> > On Thu, Jan 13, 2022 at 8:15 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> > >
> > > On Thu, Jan 13, 2022 at 10:00 AM CET, Di Zhu wrote:
> > > > Right now there is no way to query whether BPF programs are
> > > > attached to a sockmap or not.
> > > >
> > > > we can use the standard interface in libbpf to query, such as:
> > > > bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> > > > the mapFd is the fd of sockmap.
> > > >
> > > > Signed-off-by: Di Zhu <zhudi2@huawei.com>
> > > > Acked-by: Yonghong Song <yhs@fb.com>
> > > > ---
> > > >  include/linux/bpf.h  |  9 +++++
> > > >  kernel/bpf/syscall.c |  5 +++
> > > >  net/core/sock_map.c  | 78
> > ++++++++++++++++++++++++++++++++++++++++----
> > > >  3 files changed, 85 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 6e947cd91152..c4ca14c9f838 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2071,6 +2071,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog
> > *prog,
> > > >  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog
> > *prog);
> > > >  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type
> > ptype);
> > > >  int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
> > *value, u64 flags);
> > > > +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > > > +                         union bpf_attr __user *uattr);
> > > > +
> > > >  void sock_map_unhash(struct sock *sk);
> > > >  void sock_map_close(struct sock *sk, long timeout);
> > > >  #else
> > > > @@ -2124,6 +2127,12 @@ static inline int
> > sock_map_update_elem_sys(struct bpf_map *map, void *key, void
> > > >  {
> > > >       return -EOPNOTSUPP;
> > > >  }
> > > > +
> > > > +static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > > > +                                       union bpf_attr __user
> > *uattr)
> > > > +{
> > > > +     return -EINVAL;
> > > > +}
> > > >  #endif /* CONFIG_BPF_SYSCALL */
> > > >  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
> > > >
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index fa4505f9b611..9e0631f091a6 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -3318,6 +3318,11 @@ static int bpf_prog_query(const union bpf_attr
> > *attr,
> > > >       case BPF_FLOW_DISSECTOR:
> > > >       case BPF_SK_LOOKUP:
> > > >               return netns_bpf_prog_query(attr, uattr);
> > > > +     case BPF_SK_SKB_STREAM_PARSER:
> > > > +     case BPF_SK_SKB_STREAM_VERDICT:
> > > > +     case BPF_SK_MSG_VERDICT:
> > > > +     case BPF_SK_SKB_VERDICT:
> > > > +             return sock_map_bpf_prog_query(attr, uattr);
> > > >       default:
> > > >               return -EINVAL;
> > > >       }
> > > > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > > > index 1827669eedd6..a424f51041ca 100644
> > > > --- a/net/core/sock_map.c
> > > > +++ b/net/core/sock_map.c
> > > > @@ -1416,38 +1416,50 @@ static struct sk_psock_progs
> > *sock_map_progs(struct bpf_map *map)
> > > >       return NULL;
> > > >  }
> > > >
> > > > -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog
> > *prog,
> > > > -                             struct bpf_prog *old, u32 which)
> > > > +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog
> > ***pprog,
> > > > +                             u32 which)
> > > >  {
> > > >       struct sk_psock_progs *progs = sock_map_progs(map);
> > > > -     struct bpf_prog **pprog;
> > > >
> > > >       if (!progs)
> > > >               return -EOPNOTSUPP;
> > > >
> > > >       switch (which) {
> > > >       case BPF_SK_MSG_VERDICT:
> > > > -             pprog = &progs->msg_parser;
> > > > +             *pprog = &progs->msg_parser;
> > > >               break;
> > > >  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> > > >       case BPF_SK_SKB_STREAM_PARSER:
> > > > -             pprog = &progs->stream_parser;
> > > > +             *pprog = &progs->stream_parser;
> > > >               break;
> > > >  #endif
> > > >       case BPF_SK_SKB_STREAM_VERDICT:
> > > >               if (progs->skb_verdict)
> > > >                       return -EBUSY;
> > > > -             pprog = &progs->stream_verdict;
> > > > +             *pprog = &progs->stream_verdict;
> > > >               break;
> > > >       case BPF_SK_SKB_VERDICT:
> > > >               if (progs->stream_verdict)
> > > >                       return -EBUSY;
> > > > -             pprog = &progs->skb_verdict;
> > > > +             *pprog = &progs->skb_verdict;
> > > >               break;
> > > >       default:
> > > >               return -EOPNOTSUPP;
> > > >       }
> > > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog
> > *prog,
> > > > +                             struct bpf_prog *old, u32 which)
> > > > +{
> > > > +     struct bpf_prog **pprog;
> > > > +     int ret;
> > > > +
> > > > +     ret = sock_map_prog_lookup(map, &pprog, which);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > >       if (old)
> > > >               return psock_replace_prog(pprog, prog, old);
> > > >
> > > > @@ -1455,6 +1467,58 @@ static int sock_map_prog_update(struct bpf_map
> > *map, struct bpf_prog *prog,
> > > >       return 0;
> > > >  }
> > > >
> > > > +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > > > +                         union bpf_attr __user *uattr)
> > > > +{
> > > > +     __u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> > > > +     u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
> > > > +     struct bpf_prog **pprog;
> > > > +     struct bpf_prog *prog;
> > > > +     struct bpf_map *map;
> > > > +     struct fd f;
> > > > +     u32 id = 0;
> > > > +     int ret;
> > > > +
> > > > +     if (attr->query.query_flags)
> > > > +             return -EINVAL;
> > > > +
> > > > +     f = fdget(ufd);
> > > > +     map = __bpf_map_get(f);
> > > > +     if (IS_ERR(map))
> > > > +             return PTR_ERR(map);
> > > > +
> > > > +     rcu_read_lock();
> > > > +
> > > > +     ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> > > > +     if (ret)
> > > > +             goto end;
> > > > +
> > > > +     prog = *pprog;
> > > > +     prog_cnt = !prog ? 0 : 1;
> > > > +
> > > > +     if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> > > > +             goto end;
> > > > +
> > > > +     id = prog->aux->id;
> > >
> > > ^ This looks like a concurrent read/write.
> >
> > You mean that bpf_prog_load() might be setting it in a different
> > thread? I think ID is allocated and fixed before prog FD is available
> > to the user-space, so prog->aux->id is set in stone and immutable in
> > that regard.
>
> What we're talking about here is that bpf_prog_free_id() will write the id
> identifier synchronously.

Hm.. let's say bpf_prog_free_id() happens right after we read id 123.
It's impossible to distinguish that from reading valid ID (that's not
yet freed), returning it to user-space and before user-space can do
anything about that this program and it's ID are freed. User-space
either way will get an ID that's not valid anymore. I don't see any
use of READ_ONCE/WRITE_ONCE with prog->aux->id, which is why I was
asking what changed.

>
> >
> > >
> > > Would wrap with READ_ONCE() and corresponding WRITE_ONCE() in
> > > bpf_prog_free_id(). See [1] for rationale.
> > >
> > > [1]
> > https://github.com/google/kernel-sanitizers/blob/master/other/READ_WRITE_O
> > NCE.md
> > >
> > > > +
> > > > +     /* we do not hold the refcnt, the bpf prog may be released
> > > > +      * asynchronously and the id would be set to 0.
> > > > +      */
> > > > +     if (id == 0)
> > > > +             prog_cnt = 0;
> > > > +
> > > > +end:
> > > > +     rcu_read_unlock();
> > > > +
> > > > +     if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
> > > > +         (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
> > > > +         copy_to_user(&uattr->query.prog_cnt, &prog_cnt,
> > sizeof(prog_cnt)))
> > > > +             ret = -EFAULT;
> > > > +
> > > > +     fdput(f);
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
> > > >  {
> > > >       switch (link->map->map_type) {
