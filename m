Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751006E0323
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDMAXa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMAX1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:23:27 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE02134;
        Wed, 12 Apr 2023 17:23:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id j10so3528000ybj.1;
        Wed, 12 Apr 2023 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmBDZJgPCYMDfECNmjdw034TkpoGPUqRYrkwBaKLuzY=;
        b=WYfojTYQdc4DfNv0NG8/jLYT0SsWcHjEjgXGvJ2/kupJXeFFq4BF6XwNZfY+KoRgXi
         NlPDDVj57BETQuy6s6kD6uZ8c6yO2WFIxf+MP11Z/d0J4ndFXqnxL+9+kvXnoceNH4as
         jQ4j0GPjR+fFFskyYFGJXTg2hSHYrUIYDDsd5W5tJEZXT6eQWj5+kNxZGHbBucsTbDX7
         S0xd3JIUvjeXnDnsmuFBsI8dIZgCpWe5+QQQ3T4qylzJLcGzci8rDWVmFMuuAa8HERl6
         NJnE/9XCYz6OodFnu2YlF2JKTlqMkXGAHKucLO18wSjpd0If1C7QTJKN4vc9kA2Ivk/j
         EHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmBDZJgPCYMDfECNmjdw034TkpoGPUqRYrkwBaKLuzY=;
        b=ZwbYU/IfBg7UQwr1i5CK4YlAQMPnO+q+e/YM1KHl3IS6i7+QZiC7JheXtKkLKYFhKf
         /KWwC4xilR/gjzC5c9LFc9YJSVmNsoNlNWVfkpoq/htwJ9/JOOIR4pgi5hySWScFxxdi
         RZNxB0EqFKeEXXAOpvDhIcE8sGMUZQkVG098v8JLu9kDnOr7VaaWPjYTLcpnCTbXg358
         alwCGZ0m+79HfEp538Rc5ws2QTgf3ENUD3Z0SfiP16peY3O529CJBXg61jsRnxRg4sKg
         qChmkO3BoydEWpoQ0JM8Odd2mcamVKbi4za5QZdf2zW+W9dNBEG7CWsq+HoRvVCXNhy/
         Tfng==
X-Gm-Message-State: AAQBX9esOKNl1TqA41vdvr9O3n49gD3dVlxvqGQCOcWxj3arFZQcvurv
        zlwh7ukNN2Ohdda5383Lf5irljuFht0k8xfsIa37izuQ
X-Google-Smtp-Source: AKy350Yz7jRiFuZyqFv3yFK+Nvsoabupqu0eZtnxKvmxBrPUVzjGxnnQ+V5afq6UxCjrhEiSVxRQVfOQZccifL+vl6Y=
X-Received: by 2002:a25:d288:0:b0:b75:3fd4:1b31 with SMTP id
 j130-20020a25d288000000b00b753fd41b31mr306949ybg.1.1681345405642; Wed, 12 Apr
 2023 17:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-4-andrii@kernel.org>
 <6436f1ed.170a0220.6cc4d.79f3@mx.google.com>
In-Reply-To: <6436f1ed.170a0220.6cc4d.79f3@mx.google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 17:23:09 -0700
Message-ID: <CAEf4BzZ4Wr5c_vHXDVyZWXUbj2wasreV2MAEA3zgB6T=PYjnfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/8] bpf: centralize permissions checks for all
 BPF map types
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 11:01=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 11, 2023 at 09:32:55PM -0700, Andrii Nakryiko wrote:
> > This allows to do more centralized decisions later on, and generally
> > makes it very explicit which maps are privileged and which are not.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > [...]
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 00c253b84bf5..c69db80fc947 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -422,12 +422,6 @@ static int htab_map_alloc_check(union bpf_attr *at=
tr)
> >       BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=3D
> >                    offsetof(struct htab_elem, hash_node.pprev));
> >
> > -     if (lru && !bpf_capable())
> > -             /* LRU implementation is much complicated than other
> > -              * maps.  Hence, limit to CAP_BPF.
> > -              */
> > -             return -EPERM;
> > -
>
> The LRU part of this check gets lost, doesn't it? More specifically,
> doesn't this make the security check for htab_map_alloc_check() more
> strict than before? (If that's okay, please mention the logical change
> in the commit log.)

Patch diff doesn't make this very obvious, unfortunately, but lru
variable is defined as

        bool lru =3D (attr->map_type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
                    attr->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH);

And below I'm adding explicit big switch where BPF_MAP_TYPE_LRU_HASH
and BPF_MAP_TYPE_LRU_PERCPU_HASH do bpf_capable() check, while non-LRU
hashes (like BPF_MAP_TYPE_HASH and BPF_MAP_TYPE_PERCPU_HASH) do not.
So I think the semantics was preserved.


>
> > [...]
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a090737f98ea..cbea4999e92f 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1101,17 +1101,6 @@ static int map_create(union bpf_attr *attr)
> >       int f_flags;
> >       int err;
> >
> > -     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > -      * creation commands for unprivileged users; other actions depend
> > -      * of fd availability and access to bpffs, so are dependent on
> > -      * object creation success.  Capabilities are later verified for
> > -      * operations such as load and map create, so even with unprivile=
ged
> > -      * BPF disabled, capability checks are still carried out for thes=
e
> > -      * and other operations.
> > -      */
> > -     if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> > -             return -EPERM;
> > -
>
> Given that this was already performing a centralized capability check,
> why were the individual functions doing checks before too?
>
> (I'm wondering if the individual functions remain the better place to do
> this checking?)

This sysctl_unprivileged_bpf_disabled was added much later to tighten
up security across any type of map/program. Just keep in mind that
sysctl_unprivileged_bpf_disabled is not mandatory, so some distros
might choose not to restrict unprivileged map creation yet.

So I think centralized makes more sense. And as you noticed below, it
allows us to easily be more strict by default (if we forget to add
bpf_capable check for new map type).

>
> >       err =3D CHECK_ATTR(BPF_MAP_CREATE);
> >       if (err)
> >               return -EINVAL;
> > @@ -1155,6 +1144,65 @@ static int map_create(union bpf_attr *attr)
> >               ops =3D &bpf_map_offload_ops;
> >       if (!ops->map_mem_usage)
> >               return -EINVAL;
> > +
> > +     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > +      * creation commands for unprivileged users; other actions depend
> > +      * of fd availability and access to bpffs, so are dependent on
> > +      * object creation success.  Capabilities are later verified for
> > +      * operations such as load and map create, so even with unprivile=
ged
> > +      * BPF disabled, capability checks are still carried out for thes=
e
> > +      * and other operations.
> > +      */
> > +     if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> > +             return -EPERM;
> > +
> > +     /* check privileged map type permissions */
> > +     switch (map_type) {
> > +     case BPF_MAP_TYPE_SK_STORAGE:
> > +     case BPF_MAP_TYPE_INODE_STORAGE:
> > +     case BPF_MAP_TYPE_TASK_STORAGE:
> > +     case BPF_MAP_TYPE_CGRP_STORAGE:
> > +     case BPF_MAP_TYPE_BLOOM_FILTER:
> > +     case BPF_MAP_TYPE_LPM_TRIE:
> > +     case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
> > +     case BPF_MAP_TYPE_STACK_TRACE:
> > +     case BPF_MAP_TYPE_QUEUE:
> > +     case BPF_MAP_TYPE_STACK:
> > +     case BPF_MAP_TYPE_LRU_HASH:
> > +     case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> > +     case BPF_MAP_TYPE_STRUCT_OPS:
> > +     case BPF_MAP_TYPE_CPUMAP:
> > +             if (!bpf_capable())
> > +                     return -EPERM;
> > +             break;
> > +     case BPF_MAP_TYPE_SOCKMAP:
> > +     case BPF_MAP_TYPE_SOCKHASH:
> > +     case BPF_MAP_TYPE_DEVMAP:
> > +     case BPF_MAP_TYPE_DEVMAP_HASH:
> > +     case BPF_MAP_TYPE_XSKMAP:
> > +             if (!capable(CAP_NET_ADMIN))
> > +                     return -EPERM;
> > +             break;
> > +     case BPF_MAP_TYPE_ARRAY:
> > +     case BPF_MAP_TYPE_PERCPU_ARRAY:
> > +     case BPF_MAP_TYPE_PROG_ARRAY:
> > +     case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
> > +     case BPF_MAP_TYPE_CGROUP_ARRAY:
> > +     case BPF_MAP_TYPE_ARRAY_OF_MAPS:
> > +     case BPF_MAP_TYPE_HASH:
> > +     case BPF_MAP_TYPE_PERCPU_HASH:
> > +     case BPF_MAP_TYPE_HASH_OF_MAPS:
> > +     case BPF_MAP_TYPE_RINGBUF:
> > +     case BPF_MAP_TYPE_USER_RINGBUF:
> > +     case BPF_MAP_TYPE_CGROUP_STORAGE:
> > +     case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> > +             /* unprivileged */
> > +             break;
> > +     default:
> > +             WARN(1, "unsupported map type %d", map_type);
> > +             return -EPERM;
>
> Thank you for making sure this fails safe! :)

Sure :)


>
> > +     }
> > +
> >       map =3D ops->map_alloc(attr);
> >       if (IS_ERR(map))
> >               return PTR_ERR(map);
> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> > index 7c189c2e2fbf..4b67bb5e7f9c 100644
> > --- a/net/core/sock_map.c
> > +++ b/net/core/sock_map.c
> > @@ -32,8 +32,6 @@ static struct bpf_map *sock_map_alloc(union bpf_attr =
*attr)
> >  {
> >       struct bpf_stab *stab;
> >
> > -     if (!capable(CAP_NET_ADMIN))
> > -             return ERR_PTR(-EPERM);
> >       if (attr->max_entries =3D=3D 0 ||
> >           attr->key_size    !=3D 4 ||
> >           (attr->value_size !=3D sizeof(u32) &&
> > @@ -1085,8 +1083,6 @@ static struct bpf_map *sock_hash_alloc(union bpf_=
attr *attr)
> >       struct bpf_shtab *htab;
> >       int i, err;
> >
> > -     if (!capable(CAP_NET_ADMIN))
> > -             return ERR_PTR(-EPERM);
> >       if (attr->max_entries =3D=3D 0 ||
> >           attr->key_size    =3D=3D 0 ||
> >           (attr->value_size !=3D sizeof(u32) &&
> > diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> > index 2c1427074a3b..e1c526f97ce3 100644
> > --- a/net/xdp/xskmap.c
> > +++ b/net/xdp/xskmap.c
> > @@ -5,7 +5,6 @@
> >
> >  #include <linux/bpf.h>
> >  #include <linux/filter.h>
> > -#include <linux/capability.h>
> >  #include <net/xdp_sock.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> > @@ -68,9 +67,6 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *=
attr)
> >       int numa_node;
> >       u64 size;
> >
> > -     if (!capable(CAP_NET_ADMIN))
> > -             return ERR_PTR(-EPERM);
> > -
> >       if (attr->max_entries =3D=3D 0 || attr->key_size !=3D 4 ||
> >           attr->value_size !=3D 4 ||
> >           attr->map_flags & ~(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WR=
ONLY))
> > diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled=
.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> > index 8383a99f610f..0adf8d9475cb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> > @@ -171,7 +171,11 @@ static void test_unpriv_bpf_disabled_negative(stru=
ct test_unpriv_bpf_disabled *s
> >                               prog_insns, prog_insn_cnt, &load_opts),
> >                 -EPERM, "prog_load_fails");
> >
> > -     for (i =3D BPF_MAP_TYPE_HASH; i <=3D BPF_MAP_TYPE_BLOOM_FILTER; i=
++)
> > +     /* some map types require particular correct parameters which cou=
ld be
> > +      * sanity-checked before enforcing -EPERM, so only validate that
> > +      * the simple ARRAY and HASH maps are failing with -EPERM
> > +      */
> > +     for (i =3D BPF_MAP_TYPE_HASH; i <=3D BPF_MAP_TYPE_ARRAY; i++)
> >               ASSERT_EQ(bpf_map_create(i, NULL, sizeof(int), sizeof(int=
), 1, NULL),
> >                         -EPERM, "map_create_fails");
> >
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
