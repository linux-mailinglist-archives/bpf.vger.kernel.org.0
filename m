Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F7B48F40C
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 02:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiAOBWM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiAOBWM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 20:22:12 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0EC061574;
        Fri, 14 Jan 2022 17:22:12 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z17so7795604ilm.3;
        Fri, 14 Jan 2022 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8oHtsdeK8l4VRxicdyv8/IAzOzw+vq4hmH9iza0OjA=;
        b=CvOj+XSBZsJlTUJOkNfg4Sl9RYiBNP9ZP+VRbVMEbSmN47PMerL+M6Mzz5FRC0AuLy
         Jmj1UwFKepNaZxLek/qhA1J2qt9SND1aSlv1zmV0kJ29SlgxrsTEx5dMsxjS6Ij0Rqsr
         ZwwdSxMgz10+cgkEREDtxgoY+WBR/MPR++v3CSrOyRFmyrLoijjmFNJUy/klgP8zjdzj
         QqZz4B5r9M/njW2hgsduRfqhWZeDG+RVg5CkBUpWxCOzYd0RpKpb3d3ZehcRsQouYZE9
         Svqu8Rfsw1X+mOfbW8xaQnyreoaAZf1LP9misO3IOn8byLpiWQNEWvaRCfkPoK+b8O2s
         AwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8oHtsdeK8l4VRxicdyv8/IAzOzw+vq4hmH9iza0OjA=;
        b=DLJvJTT2VUePAMUjL/7+akSM5CNl89aXjtcYQfytWYjeloIt41/Lsl3b9UB+hcc9Yj
         iFQA7D/3tkU+IcwwssfSroqUoXK4lr6jyZN6n3oLvEuGc2TaLC7xDZ16QXAR/gCPk5y6
         TXXTYF0WEjOuIEZJWsvmBufv07KrOzjZ0Q3NAiEt/nWuvGJ5nW41Dk5IYBPJmVNtNKJG
         eq7f3+iLJEA9nfZH1ES1iL64LuxT8wuOkaYXXH/SVj0VsukWjWJkeEKIaQFWaWG9531N
         oG0GKekwTVf0vR7czK56WcqqRMlZb8zCpgRS6bGxhR22SQOj6iPIuh8z5yLByaHkE1pE
         guLQ==
X-Gm-Message-State: AOAM532XTS8Li5aJrB6gZICQ8lS9uOAXA9OhXYceFiwMHbxZuVGb4Nbu
        CIgn9oo4pqc43mOzOteuHtH+39SDY8BYtwI6hryLYxt16ug=
X-Google-Smtp-Source: ABdhPJyvPA/xoTYapv9X+xSo8XBgwuItX/zE51O9hMmB6yzsQmRgOh+LH6d4KGTHCotbwTqJCixGtbAcTkzZ6V5VOws=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr6301160ilh.239.1642209731528;
 Fri, 14 Jan 2022 17:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20220113090029.1055-1-zhudi2@huawei.com> <8735lrpq6j.fsf@cloudflare.com>
In-Reply-To: <8735lrpq6j.fsf@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 17:22:00 -0800
Message-ID: <CAEf4BzZXsQ3z1CnYsg5VD9vZ0ELYRzV8f+qscCPhhhZ9vSFVGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Di Zhu <zhudi2@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, luzhihao@huawei.com,
        rose.chen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 13, 2022 at 8:15 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Thu, Jan 13, 2022 at 10:00 AM CET, Di Zhu wrote:
> > Right now there is no way to query whether BPF programs are
> > attached to a sockmap or not.
> >
> > we can use the standard interface in libbpf to query, such as:
> > bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> > the mapFd is the fd of sockmap.
> >
> > Signed-off-by: Di Zhu <zhudi2@huawei.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >  include/linux/bpf.h  |  9 +++++
> >  kernel/bpf/syscall.c |  5 +++
> >  net/core/sock_map.c  | 78 ++++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 85 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 6e947cd91152..c4ca14c9f838 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2071,6 +2071,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
> >  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
> >  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
> >  int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
> > +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > +                         union bpf_attr __user *uattr);
> > +
> >  void sock_map_unhash(struct sock *sk);
> >  void sock_map_close(struct sock *sk, long timeout);
> >  #else
> > @@ -2124,6 +2127,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +
> > +static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > +                                       union bpf_attr __user *uattr)
> > +{
> > +     return -EINVAL;
> > +}
> >  #endif /* CONFIG_BPF_SYSCALL */
> >  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index fa4505f9b611..9e0631f091a6 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3318,6 +3318,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
> >       case BPF_FLOW_DISSECTOR:
> >       case BPF_SK_LOOKUP:
> >               return netns_bpf_prog_query(attr, uattr);
> > +     case BPF_SK_SKB_STREAM_PARSER:
> > +     case BPF_SK_SKB_STREAM_VERDICT:
> > +     case BPF_SK_MSG_VERDICT:
> > +     case BPF_SK_SKB_VERDICT:
> > +             return sock_map_bpf_prog_query(attr, uattr);
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index 1827669eedd6..a424f51041ca 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -1416,38 +1416,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
> >       return NULL;
> >  }
> >
> > -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> > -                             struct bpf_prog *old, u32 which)
> > +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
> > +                             u32 which)
> >  {
> >       struct sk_psock_progs *progs = sock_map_progs(map);
> > -     struct bpf_prog **pprog;
> >
> >       if (!progs)
> >               return -EOPNOTSUPP;
> >
> >       switch (which) {
> >       case BPF_SK_MSG_VERDICT:
> > -             pprog = &progs->msg_parser;
> > +             *pprog = &progs->msg_parser;
> >               break;
> >  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> >       case BPF_SK_SKB_STREAM_PARSER:
> > -             pprog = &progs->stream_parser;
> > +             *pprog = &progs->stream_parser;
> >               break;
> >  #endif
> >       case BPF_SK_SKB_STREAM_VERDICT:
> >               if (progs->skb_verdict)
> >                       return -EBUSY;
> > -             pprog = &progs->stream_verdict;
> > +             *pprog = &progs->stream_verdict;
> >               break;
> >       case BPF_SK_SKB_VERDICT:
> >               if (progs->stream_verdict)
> >                       return -EBUSY;
> > -             pprog = &progs->skb_verdict;
> > +             *pprog = &progs->skb_verdict;
> >               break;
> >       default:
> >               return -EOPNOTSUPP;
> >       }
> >
> > +     return 0;
> > +}
> > +
> > +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> > +                             struct bpf_prog *old, u32 which)
> > +{
> > +     struct bpf_prog **pprog;
> > +     int ret;
> > +
> > +     ret = sock_map_prog_lookup(map, &pprog, which);
> > +     if (ret)
> > +             return ret;
> > +
> >       if (old)
> >               return psock_replace_prog(pprog, prog, old);
> >
> > @@ -1455,6 +1467,58 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> >       return 0;
> >  }
> >
> > +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > +                         union bpf_attr __user *uattr)
> > +{
> > +     __u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> > +     u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
> > +     struct bpf_prog **pprog;
> > +     struct bpf_prog *prog;
> > +     struct bpf_map *map;
> > +     struct fd f;
> > +     u32 id = 0;
> > +     int ret;
> > +
> > +     if (attr->query.query_flags)
> > +             return -EINVAL;
> > +
> > +     f = fdget(ufd);
> > +     map = __bpf_map_get(f);
> > +     if (IS_ERR(map))
> > +             return PTR_ERR(map);
> > +
> > +     rcu_read_lock();
> > +
> > +     ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> > +     if (ret)
> > +             goto end;
> > +
> > +     prog = *pprog;
> > +     prog_cnt = !prog ? 0 : 1;
> > +
> > +     if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> > +             goto end;
> > +
> > +     id = prog->aux->id;
>
> ^ This looks like a concurrent read/write.

You mean that bpf_prog_load() might be setting it in a different
thread? I think ID is allocated and fixed before prog FD is available
to the user-space, so prog->aux->id is set in stone and immutable in
that regard.

>
> Would wrap with READ_ONCE() and corresponding WRITE_ONCE() in
> bpf_prog_free_id(). See [1] for rationale.
>
> [1] https://github.com/google/kernel-sanitizers/blob/master/other/READ_WRITE_ONCE.md
>
> > +
> > +     /* we do not hold the refcnt, the bpf prog may be released
> > +      * asynchronously and the id would be set to 0.
> > +      */
> > +     if (id == 0)
> > +             prog_cnt = 0;
> > +
> > +end:
> > +     rcu_read_unlock();
> > +
> > +     if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
> > +         (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
> > +         copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
> > +             ret = -EFAULT;
> > +
> > +     fdput(f);
> > +     return ret;
> > +}
> > +
> >  static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
> >  {
> >       switch (link->map->map_type) {
