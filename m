Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C535BBB64
	for <lists+bpf@lfdr.de>; Sun, 18 Sep 2022 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiIRDqh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 23:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIRDqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 23:46:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0EFDF9F;
        Sat, 17 Sep 2022 20:45:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f9so40918287lfr.3;
        Sat, 17 Sep 2022 20:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Wk+IFsf/g5TmJwripJhySOO4Y9xftvJa0m7czYzxkng=;
        b=Nw2wvguZPytATzz86CZtgZrPgMYn3mT8inXh9MEGT6o+Mz2hQqYx8XHF2pfcP+6jbI
         DopuFCWLL2eTn/0bzMOxpC0bY96RPOKxFf/0F+VLtP5T2AXhqclP/lAe7RBN7257wVwH
         tQIgY8EZFShUY7tDb5N0tLcBzmXr8VT8El2DJiyMuNFTE2yWpKKwQ20dJf45bmx6SALi
         Qg8L3xQjZmou7lDT8zhyIxiCROzVn72TdWtmjp6pUmkN5UMJbfGipCuwVuHdPe5DF9Qe
         hfq/HLYIkuwkJObudCZf8+f4bHArbQcfIXdOWIyr2dFrruxTw7WusLXYCaBpL0WjvqLR
         5vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wk+IFsf/g5TmJwripJhySOO4Y9xftvJa0m7czYzxkng=;
        b=jd2QJ5uiGo2ecykt8PzRtN42ab+uHQaPdvepZKbItEpXEYZ8f1LqCr8HypsKn1IGiQ
         lnFX/sGtASMvNS7rYrOHQMFiHGYyZZhG4w5piPomM6XNguiEt8233ymJKIJyHBaPRNLX
         uk3VilJoLUOQPxHZootggtD4eqH8hrKrXXJi4VTGVhUosGM/E6oCJajyGn2Mt6jXk7Xo
         a7IkxCTqrHXD5NxX8F4uVJkMgh+LfWXtzw47HcXjq/yr9arnyQsWVzN0tI4JZcCsaHoE
         zdBPZK0SQbBDpL4ITO4b3Vp+JcNwzkNyi43NKjlgui8p8QBuLAGYQAj4/qrNqDk1UTI4
         Yh6Q==
X-Gm-Message-State: ACrzQf2KuizQfjo5BhteKM7lyfFCBcHTUuCnsRUD1ZtjkjhOxYphpp7M
        IBeU/cfPE/8gNtyycnIlFaS0pCxXhaB0XvseX+nnf4xzSpE=
X-Google-Smtp-Source: AMsMyM5/5kjR/1P6a7CA0K5q0l3e/H9sC6nfpXIoyJpLvfKAKu/0dhdr/twBqbcAXkmzAHzOe0joaK7nZkgUL+XOCfQ=
X-Received: by 2002:a05:6512:308d:b0:499:bd1a:d1bc with SMTP id
 z13-20020a056512308d00b00499bd1ad1bcmr4395173lfd.274.1663472725415; Sat, 17
 Sep 2022 20:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220902023003.47124-1-laoar.shao@gmail.com> <Yxi8I4fXXSCi6z9T@slm.duckdns.org>
 <YxkVq4S1Eoa4edjZ@P9FQF9L96D.corp.robot.car> <CALOAHbAp=g20rL0taUpQmTwymanArhO-u69Xw42s5ap39Esn=A@mail.gmail.com>
 <YxoUkz05yA0ccGWe@P9FQF9L96D.corp.robot.car> <CALOAHbAzi0s3N_5BOkLsnGfwWCDpUksvvhPejjj5jo4G2v3mGg@mail.gmail.com>
 <YySqFtU9skPaJipV@P9FQF9L96D.corp.robot.car>
In-Reply-To: <YySqFtU9skPaJipV@P9FQF9L96D.corp.robot.car>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 18 Sep 2022 11:44:48 +0800
Message-ID: <CALOAHbAYx1=uu7AP=5Gbs6-eggXTKmkhzc-MhROezxqkbVQRiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Introduce selectable memcg for bpf map
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 17, 2022 at 12:53 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Tue, Sep 13, 2022 at 02:15:20PM +0800, Yafang Shao wrote:
> > On Fri, Sep 9, 2022 at 12:13 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Thu, Sep 08, 2022 at 10:37:02AM +0800, Yafang Shao wrote:
> > > > On Thu, Sep 8, 2022 at 6:29 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > >
> > > > > On Wed, Sep 07, 2022 at 05:43:31AM -1000, Tejun Heo wrote:
> > > > > > Hello,
> > > > > >
> > > > > > On Fri, Sep 02, 2022 at 02:29:50AM +0000, Yafang Shao wrote:
> > > > > > ...
> > > > > > > This patchset tries to resolve the above two issues by introducing a
> > > > > > > selectable memcg to limit the bpf memory. Currently we only allow to
> > > > > > > select its ancestor to avoid breaking the memcg hierarchy further.
> > > > > > > Possible use cases of the selectable memcg as follows,
> > > > > >
> > > > > > As discussed in the following thread, there are clear downsides to an
> > > > > > interface which requires the users to specify the cgroups directly.
> > > > > >
> > > > > >  https://lkml.kernel.org/r/YwNold0GMOappUxc@slm.duckdns.org
> > > > > >
> > > > > > So, I don't really think this is an interface we wanna go for. I was hoping
> > > > > > to hear more from memcg folks in the above thread. Maybe ping them in that
> > > > > > thread and continue there?
> > > > >
> > > >
> > > > Hi Roman,
> > > >
> > > > > As I said previously, I don't like it, because it's an attempt to solve a non
> > > > > bpf-specific problem in a bpf-specific way.
> > > > >
> > > >
> > > > Why do you still insist that bpf_map->memcg is not a bpf-specific
> > > > issue after so many discussions?
> > > > Do you charge the bpf-map's memory the same way as you charge the page
> > > > caches or slabs ?
> > > > No, you don't. You charge it in a bpf-specific way.
> > >
> >
> > Hi Roman,
> >
> > Sorry for the late response.
> > I've been on vacation in the past few days.
> >
> > > The only difference is that we charge the cgroup of the processes who
> > > created a map, not a process who is doing a specific allocation.
> >
> > This means the bpf-map can be indepent of process, IOW, the memcg of
> > bpf-map can be indepent of the memcg of the processes.
> > This is the fundamental difference between bpf-map and page caches, then...
> >
> > > Your patchset doesn't change this.
> >
> > We can make this behavior reasonable by introducing an independent
> > memcg, as what I did in the previous version.
> >
> > > There are pros and cons with this approach, we've discussed it back
> > > to the times when bpf memcg accounting was developed. If you want
> > > to revisit this, it's maybe possible (given there is a really strong and likely
> > > new motivation appears), but I haven't seen any complaints yet except from you.
> > >
> >
> > memcg-base bpf accounting is a new feature, which may not be used widely.
> >
> > > >
> > > > > Yes, memory cgroups are not great for accounting of shared resources, it's well
> > > > > known. This patchset looks like an attempt to "fix" it specifically for bpf maps
> > > > > in a particular cgroup setup. Honestly, I don't think it's worth the added
> > > > > complexity. Especially because a similar behaviour can be achieved simple
> > > > > by placing the task which creates the map into the desired cgroup.
> > > >
> > > > Are you serious ?
> > > > Have you ever read the cgroup doc? Which clearly describe the "No
> > > > Internal Process Constraint".[1]
> > > > Obviously you can't place the task in the desired cgroup, i.e. the parent memcg.
> > >
> > > But you can place it into another leaf cgroup. You can delete this leaf cgroup
> > > and your memcg will get reparented. You can attach this process and create
> > > a bpf map to the parent cgroup before it gets child cgroups.
> >
> > If the process doesn't exit after it created bpf-map, we have to
> > migrate it around memcgs....
> > The complexity in deployment can introduce unexpected issues easily.
> >
> > > You can revisit the idea of shared bpf maps and outlive specific cgroups.
> > > Lof of options.
> > >
> > > >
> > > > [1] https://www.kernel.org/doc/Documentation/cgroup-v2.txt
> > > >
> > > > > Beatiful? Not. Neither is the proposed solution.
> > > > >
> > > >
> > > > Is it really hard to admit a fault?
> > >
> > > Yafang, you posted several versions and so far I haven't seen much of support
> > > or excitement from anyone (please, fix me if I'm wrong). It's not like I'm
> > > nacking a patchset with many acks, reviews and supporters.
> > >
> > > Still think you're solving an important problem in a reasonable way?
> > > It seems like not many are convinced yet. I'd recommend to focus on this instead
> > > of blaming me.
> > >
> >
> > The best way so far is to introduce specific memcg for specific resources.
> > Because not only the process owns its memcg, but also specific
> > resources own their memcgs, for example bpf-map, or socket.
> >
> > struct bpf_map {                                 <<<< memcg owner
> >     struct memcg_cgroup *memcg;
> > };
> >
> > struct sock {                                       <<<< memcg owner
> >     struct mem_cgroup *sk_memcg;
> > };
> >
> > These resources already have their own memcgs, so we should make this
> > behavior formal.
> >
> > The selectable memcg is just a variant of 'echo ${proc} > cgroup.procs'.
>
> This is a fundamental change: cgroups were always hierarchical groups
> of processes/threads. You're basically suggesting to extend it to
> hierarchical groups of processes and some other objects (what's a good
> definition?).

Kind of, but not exactly.
We can do it without breaking the cgroup hierarchy. Under current
cgroup hierarchy, the user can only echo processes/threads into a
cgroup, that won't be changed in the future. The specific resources
are not exposed to the user, the user can only control these specific
resources by controlling their associated processes/threads.
For example,

                Memcg-A
                       |---- Memcg-A1
                       |---- Memcg-A2

We can introduce a new file memory.owner into each memcg. Each bit of
memory.owner represents a specific resources,

 memory.owner: | bit31 | bitN | ... | bit1 | bit0 |
                                         |               |
|------ bit0: bpf memory
                                         |
|-------------- bit1: socket memory
                                         |
                                         |---------------------------
bitN: a specific resource

There won't be too many specific resources which have to own their
memcgs, so I think 32bits is enough.

                Memcg-A : memory.owner == 0x1
                       |---- Memcg-A1 : memory.owner == 0
                       |---- Memcg-A2 : memory.owner == 0x1

Then the bpf created by processes in Memcg-A1 will be charged into
Memcg-A directly without charging into Memcg-A1.
But the bpf created by processes in Memcg-A2 will be charged into
Memcg-A2 as its memory.owner is 0x1.
That said, these specific resources are not fully independent of
process, while they are still associated with the processes which
create them.
Luckily memory.move_charge_at_immigrate is disabled in cgroup2, so we
don't need to care about the possible migration issue.

I think we may also apply it to shared page caches.  For example,
      struct inode {
          struct mem_cgroup *memcg;          <<<< add a new member
      };

We define struct inode as a memcg owner, and use scope-based charge to
charge its pages into inode->memcg.
And then put all memcgs which shared these resources under the same
parent. The page caches of this inode will be charged into the parent
directly.
The shared page cache is more complicated than bpf memory, so I'm not
quite sure if it can apply to shared page cache, but it can work well
for bpf memory.

Regarding the observability, we can introduce a specific item into
memory.stat for this specific memory. For example a new item 'bpf' for
bpf memory.
That can be accounted/unaccounted for in the same way as we do in
set_active_memcg(). for example,

    struct task_struct {
        struct mem_cgroup  *active_memcg;
        int                             active_memcg_item;   <<<<
introduce a new member
    };

    bpf_memory_alloc()
    {
             old_memcg = set_active_memcg(memcg);
             old_item = set_active_memcg_item(MEMCG_BPF);
             alloc();
             set_active_memcg_item(old_item);
             set_active_memcg(old_memcg);
    }

    bpf_memory_free()
    {
             old = set_active_memcg_item(MEMCG_BPF);
             free();
             set_active_memcg_item(old);
    }

Then we can know the bpf memory size in each memcg, and possible
system-wide bpf-memory usage if it can be supported in root memcg.
(Currently  kmem is not charged into root memcg)

> It's a huge change and it's scope is definetely larger
> than bpf and even memory cgroups. It will raise a lot of questions:
> e.g. what does it mean for other controllers (cpu, io, etc)?
> Which objects can have dedicated cgroups and which not? How the interface will
> look like? How the oom handling will work? Etc.
>

With the above hierarchy, I think the oom handling can work as-is.

> The history showed that starting small with one controller and/or specific
> use case isn't working well for cgroups, because different resources and
> controllers are not living independently.

Agreed. That is why I still associate the specific resources with the
process which creates them.
If all the resources are still associated with the process, I think it
can work well.

> So if you really want to go this way
> you need to present the whole picture and convince many people that it's worth
> it. I doubt this specific bpf map accounting thing can justify it.
>
> Personally I know some examples where such functionality could be useful,
> but I'm not yet convinced it's worth the effort and potential problems.
>

Thanks for your reply.

-- 
Regards
Yafang
