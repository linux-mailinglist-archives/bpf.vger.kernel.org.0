Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF42554C1F
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiFVOEi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiFVOEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 10:04:37 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052A1ADBA
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 07:04:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 184so2067603vsz.2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtwtT2xU4j8gOT4mH64wj0iI4pj/U4lgPtbUiyNkbZk=;
        b=W2aLiBMDiqPThzXrd2LN0bTCnkAJjmKGaueXEF/vWPV40sD2n8fXCeSkA/YYHuSAqX
         I3BK2aRkBXO7IzPpcLJ9NDB0vU+xa5N3H2gFXbZC/hz2Q7vIBjoNqF+H6LXgJYLDzi24
         Z68IQauMwDkgScdgWfDGVLUM27NFlG46p+FliPDaitL7ATGJQIu3NIIMeHV6S3chdwQN
         lqkPGs5IEyRW8o46wmjaOWmZuoeqeG4/KFzMRo0lO+1dD2iYFLNgx63BRoQ27Zhf1hcW
         bh94gtO5gZPSyphNRbl1b1RGiAU4ATAaF551e3mA3fe2W79TNlWu+Gl1dwE5u1NXiJF7
         svBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtwtT2xU4j8gOT4mH64wj0iI4pj/U4lgPtbUiyNkbZk=;
        b=JGtlFOdPj0OnuCLISfKmNIavzjno7OEROu1kLwl83Ywemhi6dxgqjTeF5mfhe5WPW1
         17lbONa9rYV6D3zhGCXyVl5Ko52k1G3v4FtzAgvKkKVJ9FJdQrLI+6uyenhhgxIni5nM
         VCGXVRV6tEniyNBiGZymkBkiwudcwAhbVuXul8Av7X7Lc5Ioaqy5UDReK8RI2gI+nYrt
         A4kM91pFrxc8McdNqwLSQAu/Alhi2opSKEBPjLOWtxMc1iAoNehjDHwXCFda74FA8V93
         53EkBYWfS03a6LF2q5LAf/uLfKVzH+FOYuIS2vuvf2zUjdPuvaftcKDjzW4cKBP2fPgs
         KE9w==
X-Gm-Message-State: AJIora+VP97Ww6uy8SgEXXT7rdFVuIQy76Am66V8/wPVdkSdc5o7L+RT
        m3VLiOUJkccWxCaQXDTeDkrD2KiqA+Ug4IPyH/Q=
X-Google-Smtp-Source: AGRyM1tQNpwRJF4W7gKzIoOQpg+veVUC9JuRFxQAd0iHfqa9Jdq+AWKAIKjRJ90O7Ywd27nw1R6jmcEkbdmjjmMfk78=
X-Received: by 2002:a05:6102:3d28:b0:354:5e75:7031 with SMTP id
 i40-20020a0561023d2800b003545e757031mr1277081vsv.35.1655906672311; Wed, 22
 Jun 2022 07:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <20220621232831.nkw2e7ezfy55p6hg@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220621232831.nkw2e7ezfy55p6hg@macbook-pro-3.dhcp.thefacebook.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 22 Jun 2022 22:03:55 +0800
Message-ID: <CALOAHbCM=ZxwutQOPmJx2LKY3Pd_hs+8v8r4-ybwPbBNBuNjXA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse bpf map
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 7:28 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Jun 19, 2022 at 03:50:22PM +0000, Yafang Shao wrote:
> > After switching to memcg-based bpf memory accounting, the bpf memory is
> > charged to the loader's memcg by default, that causes unexpected issues for
> > us. For instance, the container of the loader may be restarted after
> > pinning progs and maps, but the bpf memcg will be left and pinned on the
> > system. Once the loader's new generation container is started, the leftover
> > pages won't be charged to it. That inconsistent behavior will make trouble
> > for the memory resource management for this container.
> >
> > In the past few days, I have proposed two patchsets[1][2] to try to resolve
> > this issue, but in both of these two proposals the user code has to be
> > changed to adapt to it, that is a pain for us. This patchset relieves the
> > pain by triggering the recharge in libbpf. It also addresses Roman's
> > critical comments.
> >
> > The key point we can avoid changing the user code is that there's a resue
> > path in libbpf. Once the bpf container is restarted again, it will try
> > to re-run the required bpf programs, if the bpf programs are the same with
> > the already pinned one, it will reuse them.
> >
> > To make sure we either recharge all of them successfully or don't recharge
> > any of them. The recharge prograss is divided into three steps:
> >   - Pre charge to the new generation
> >     To make sure once we uncharge from the old generation, we can always
> >     charge to the new generation succeesfully. If we can't pre charge to
> >     the new generation, we won't allow it to be uncharged from the old
> >     generation.
> >   - Uncharge from the old generation
> >     After pre charge to the new generation, we can uncharge from the old
> >     generation.
> >   - Post charge to the new generation
> >     Finnaly we can set pages' memcg_data to the new generation.
> > In the pre charge step, we may succeed to charge some addresses, but fail
> > to charge a new address, then we should uncharge the already charged
> > addresses, so another recharge-err step is instroduced.
> >
> > This pachset has finished recharging bpf hash map. which is mostly used
> > by our bpf services. The other maps hasn't been implemented yet. The bpf
> > progs hasn't been implemented neither.
>
> ... and the implementation in patch 10 is missing recharge of htab->elems
> which consumes the most memory.

You got to the point. I intended to skip htab->elemes due to some reasons.
You have pointed out one of the reasons that it is complex for
non-preallocated memory.
Another reason is memcg reparenting, for example, once the memcg is
offline, its pages and other related memory things like obj_cgroup
will be reparented, but unlikely the map->memcg is still the offline
memcg. There _must_ be issues in it, but I haven't figured out what it
may cause to the user. One issue I can imagine is that the memcg limit
may not work well in this case.  That should be another different
issue, and I'm still working on it.

> That begs the question how the whole set was tested.

In my test case, htab->buckets is around 120MB, which can be used to
do the comparison.  The number is charged back without any kernel
warnings, so I posted this incomplete patchset to get feedback to
check if I'm in the right direction.

>
> Even if that bug is fixed this recharge approach works only with preallocated
> maps. Their use will be reduced in the future.
> Maps with kmalloc won't work with this multi step approach.
> There is no place where bpf_map_release_memcg can be done without racing
> with concurrent kmallocs from bpf program side.

Right, that is really an issue.

>
> Despite being painful for user space the user space has to deal with it.
> It created a container, charged its memcg, then destroyed the container,
> but didn't free the bpf map. It's a user bug. It has to free the map.

It seems that I didn't describe this case clearly.
It is not a user bug but a user case in the k8s environment. For
example, after the user has deployed its container, it may need to
upgrade its user application or bpf prog, then the user should upgrade
its container, that means the old container will be destroyed and a
new container will be created.  In this upgrade progress, the bpf
program can continue to work without interruption because they are
pinned.

> The user space can use map-in-map solution. In the new container the new bpf map
> can be allocated (and charged to new memcg), the data copied from old map,
> and then inner map replaced. At this point old map can be freed and memcg
> uncharged.

The map-in-map solution may work for some cases, but it will allocate
more memory, which is not okay if the bpf map has lots of memory.

> To make things easier we can consider introducing an anon FD that points to a memcg.
> Then user can pick a memcg at map creation time instead of get_mem_cgroup_from_current.

This may be a workable solution.  The life cycle of a pinned bpf
program is independent of the application which loads an pins it, so
it is reasonable to introduce an independent memcg to manage the bpf
memory, for example a memcg like /sys/fs/cgroup/memory/pinned_bpf
which is independent of the k8s pod.
I will analyze it. Thanks for the suggestion.

-- 
Regards
Yafang
