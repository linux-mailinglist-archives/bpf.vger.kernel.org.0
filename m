Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E559F02B
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 02:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiHXAXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiHXAXW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 20:23:22 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3D4F6AA
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 17:23:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id h27so11569667qkk.9
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nOzcA3rS/YzoTQm3mufkwndpYmIoKltWyuaOARH3bwA=;
        b=CqnNoNuKzKtmwalCFcLeGz1LmHJ73g0Dse/GMHn4DR7qOKXYreU2u8N2oH0ODaRuWC
         gx9lddxHfhEUOekQk/OZvVZKF+SArj56AxbRrrfq0xpMYiiDQiyq6ZdiktbLLwjnLmGN
         UcOoJFOnyzOXDNoj0++moct4tSDn5oaT8ZFn1nl7O8ZdrPb7uEMSp0Z0X5YmNtI760Dc
         QZT0wWvUJr7ov67GUePvmiTqC0KbtFLJZLkXo3uAJifPVycLCQngLSG6KvKaakGjs9Nf
         Pf6rdT9KB0MnpC+HC8qnYOdDkM8SAn98eScFjM4KZFnKv59X+TFTlt/B3IbcqsZkESae
         UYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nOzcA3rS/YzoTQm3mufkwndpYmIoKltWyuaOARH3bwA=;
        b=Hr04QbbnIgKZDSvP9RsA8maJlzpA8S6fQCI0BZKvBOPEiNqWt9QrfdpSHlOMvGORRz
         5xJErMJNpB2UpvexWV7+uIkd+Bn29oWk40Zb9s2o8s6fTvQEW07RhiuvrnhEtc5Lt8zj
         9nwzuw0YRE1g6WQgRmP0ZRHhwCOZAKWiTDttg+xP53lWOF556WW8Y2/aUgDbJYrhfJCD
         6sL7/4yIcrbBwQ6WmZtgrziVLUN0Zo5Ao/O0PfPRfgokUzmL9y/FaqVmGV2rK+mGOi7y
         af2Gpt9wqSb5UlZtBg7eOADOvhD4tE3xVdw3h3PE/q5/j7DN/t8slB1XzNzQIFfPt8F5
         8okg==
X-Gm-Message-State: ACgBeo0HeAcZ4gwS7EAqsN/fz08jM9dsJiNd7hAY48/SU/xmH0+qGXqN
        QkKc+wAReY6Ju77qDg1HyhLUHbuOGE2m5qg7sGht0A==
X-Google-Smtp-Source: AA6agR5fh4lw+gR4Rr1eIVp31Mm/w0enQgEM9jwiLmzHxu7UZxc0kEH6XrUL55nPhhbfQ/gg7jv1XIK59UWESv6mjMY=
X-Received: by 2002:a05:620a:458c:b0:6bb:848a:b86b with SMTP id
 bp12-20020a05620a458c00b006bb848ab86bmr18083896qkb.267.1661300599003; Tue, 23
 Aug 2022 17:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220812202802.3774257-1-haoluo@google.com> <20220812202802.3774257-2-haoluo@google.com>
 <CAEf4BzbuD+vLzxVkXpiX=yKu2WbHLrekrZS8hx2TWU04m0h-kA@mail.gmail.com>
In-Reply-To: <CAEf4BzbuD+vLzxVkXpiX=yKu2WbHLrekrZS8hx2TWU04m0h-kA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 23 Aug 2022 17:23:08 -0700
Message-ID: <CA+khW7gnAM0+dre+kF4z4-DB2FhemsZRBFKsjXVvVH5U6O4EPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/5] bpf: Introduce cgroup iter
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 9:17 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Aug 12, 2022 at 1:28 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Cgroup_iter is a type of bpf_iter. It walks over cgroups in four modes:
> >
> >  - walking a cgroup's descendants in pre-order.
> >  - walking a cgroup's descendants in post-order.
> >  - walking a cgroup's ancestors.
> >  - process only the given cgroup.
> >
> > When attaching cgroup_iter, one can set a cgroup to the iter_link
> > created from attaching. This cgroup is passed as a file descriptor
> > or cgroup id and serves as the starting point of the walk. If no
> > cgroup is specified, the starting point will be the root cgroup v2.
> >
> > For walking descendants, one can specify the order: either pre-order or
> > post-order. For walking ancestors, the walk starts at the specified
> > cgroup and ends at the root.
> >
> > One can also terminate the walk early by returning 1 from the iter
> > program.
> >
> > Note that because walking cgroup hierarchy holds cgroup_mutex, the iter
> > program is called with cgroup_mutex held.
> >
> > Currently only one session is supported, which means, depending on the
> > volume of data bpf program intends to send to user space, the number
> > of cgroups that can be walked is limited. For example, given the current
> > buffer size is 8 * PAGE_SIZE, if the program sends 64B data for each
> > cgroup, assuming PAGE_SIZE is 4kb, the total number of cgroups that can
> > be walked is 512. This is a limitation of cgroup_iter. If the output
> > data is larger than the kernel buffer size, after all data in the
> > kernel buffer is consumed by user space, the subsequent read() syscall
> > will signal EOPNOTSUPP. In order to work around, the user may have to
> > update their program to reduce the volume of data sent to output. For
> > example, skip some uninteresting cgroups. In future, we may extend
> > bpf_iter flags to allow customizing buffer size.
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h                           |   8 +
> >  include/uapi/linux/bpf.h                      |  35 +++
> >  kernel/bpf/Makefile                           |   3 +
> >  kernel/bpf/cgroup_iter.c                      | 283 ++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h                |  35 +++
> >  .../selftests/bpf/prog_tests/btf_dump.c       |   4 +-
> >  6 files changed, 366 insertions(+), 2 deletions(-)
> >  create mode 100644 kernel/bpf/cgroup_iter.c
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a627a02cf8ab..ecb8c61178a1 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -48,6 +48,7 @@ struct mem_cgroup;
> >  struct module;
> >  struct bpf_func_state;
> >  struct ftrace_ops;
> > +struct cgroup;
> >
> >  extern struct idr btf_idr;
> >  extern spinlock_t btf_idr_lock;
> > @@ -1730,7 +1731,14 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
> >         int __init bpf_iter_ ## target(args) { return 0; }
> >
> >  struct bpf_iter_aux_info {
> > +       /* for map_elem iter */
> >         struct bpf_map *map;
> > +
> > +       /* for cgroup iter */
> > +       struct {
> > +               struct cgroup *start; /* starting cgroup */
> > +               int order;
>
> why not using enum as a type here?
>

Sorry Andrii, I missed your reply.

No special reasons. Will use enum in the next version.

> > +       } cgroup;
> >  };
> >
> >  typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 7d1e2794d83e..bc3c901b9f70 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -87,10 +87,34 @@ struct bpf_cgroup_storage_key {
> >         __u32   attach_type;            /* program attach type (enum bpf_attach_type) */
> >  };
> >
> > +enum bpf_iter_order {
> > +       BPF_ITER_DESCENDANTS_PRE = 0,   /* walk descendants in pre-order. */
> > +       BPF_ITER_DESCENDANTS_POST,      /* walk descendants in post-order. */
> > +       BPF_ITER_ANCESTORS_UP,          /* walk ancestors upward. */
> > +       BPF_ITER_SELF_ONLY,             /* process only a single object. */
> > +};
> > +
> >  union bpf_iter_link_info {
> >         struct {
> >                 __u32   map_fd;
> >         } map;
> > +       struct {
> > +               /* Users must specify order using one of the following values:
> > +                *  - BPF_ITER_DESCENDANTS_PRE
> > +                *  - BPF_ITER_DESCENDANTS_POST
> > +                *  - BPF_ITER_ANCESTORS_UP
> > +                *  - BPF_ITER_SELF_ONLY
> > +                */
> > +               __u32   order;
>
> same, we just declared the UAPI enum above, why not specify that this
> is that enum here?
>

Will use enum.

> > +
> > +               /* At most one of cgroup_fd and cgroup_id can be non-zero. If
> > +                * both are zero, the walk starts from the default cgroup v2
> > +                * root. For walking v1 hierarchy, one should always explicitly
> > +                * specify cgroup_fd.
> > +                */
> > +               __u32   cgroup_fd;
> > +               __u64   cgroup_id;
>
> for my own education, does root cgroup has cgroup_id == 0?
>

Yeah, unfortunately, the root cgroup has cgroup_id == 1. :(

> > +       } cgroup;
> >  };
> >
>
> [...]
