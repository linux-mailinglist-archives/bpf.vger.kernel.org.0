Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8657A5F5
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiGSSBd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGSSBd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 14:01:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7652DEC
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:01:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j1so18310639wrs.4
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWRuvQ3wzgz9ZKqWvsdUHpwP47do7E1Ix+nkjoW47hc=;
        b=qrJpDLx97/8arZeXxkLqQ42Z08+K4zwCbpZhU9NFbYtZxEdfAGAIrzURDYHJsDOdBr
         eBVf+lIJKhI1uwbPx/gqHBXgluvVNTAsAPhdN1JEusRE3zHmMhVgSgFJFPwf9e4IbbCy
         kNsBTlKIoCHotoAarOfLh38inleNGOCRnj2b8OrgCJrW5HCQ3HBKc+m+c3/jJdeclBIZ
         c47qxPdcXbZ/+lJ7LqkAs06c7eki8DOymafKzTqCWEBrvyF+J6xTsNQ07+IA7UPNm1+V
         jYkpexXOzLsQrvqAoDPSQxx89ptcqW2TBBS119zdcitGkp1Yr0a6p9MrM3k7PArPTJpw
         qZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWRuvQ3wzgz9ZKqWvsdUHpwP47do7E1Ix+nkjoW47hc=;
        b=QArrkXJS0eTDa0RpScwKl5mEFgNu3ZzzZ8uZ3j9685i17zm35GUEATWO54+UccfxFH
         sLfQ+KyWhKPZtMf31w2IBGw4oZpFT8/xUWpnwjIjH0B1CON5ovK8BQL+fAY98ilmnfoi
         KG+GUYTKgTVtLTEBMv/QbP5SCqEukL+tMTmYGd5J+sjEe6RG0CjIV/nMrcPClPlIaIlC
         D50TrPy3a/qwblkLRje9QzQfLW6TbfzfRk86mMDJNAp6TZqaOaFAK4Bh5Aco3lHc6i7l
         U6037EEOZQLl+1PuAVRKGmRaE0/ZOeqvXZhRk8PXO7IcnEIahyr3q+HgmcBoWo2vmm1S
         0gRw==
X-Gm-Message-State: AJIora+J2+1kK/5LW+cIeezCX+w1cdyLbWYg5mdLGfCyaOm1kH6GU0VW
        nHkD2AoX/xkxX4hUSiC4V2dreWCgOHqEMmzl9X96cA==
X-Google-Smtp-Source: AGRyM1uPFfnsa6zz5rNW5jFsEg7G6aOHDTBpDetoeyiZkOs9+Nr1cYpQejpCnIlimtt7bBPKTlREAHcJxaBgiGw72Jc=
X-Received: by 2002:a05:6000:156f:b0:21d:887f:8ddf with SMTP id
 15-20020a056000156f00b0021d887f8ddfmr27525572wrz.534.1658253690032; Tue, 19
 Jul 2022 11:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com> <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
In-Reply-To: <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Jul 2022 11:00:53 -0700
Message-ID: <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 4:30 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 18-07-22 10:55:59, Yosry Ahmed wrote:
> > On Tue, Jul 12, 2022 at 7:39 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 11:52:11AM +0200, Michal Hocko wrote:
> > > > On Tue 12-07-22 16:39:48, Yafang Shao wrote:
> > > > > On Tue, Jul 12, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > [...]
> > > > > > > Roman already sent reparenting fix:
> > > > > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/
> > > > > >
> > > > > > Reparenting is nice but not a silver bullet. Consider a shallow
> > > > > > hierarchy where the charging happens in the first level under the root
> > > > > > memcg. Reparenting to the root is just pushing everything under the
> > > > > > system resources category.
> > > > > >
> > > > >
> > > > > Agreed. That's why I don't like reparenting.
> > > > > Reparenting just reparent the charged pages and then redirect the new
> > > > > charge, but can't reparents the 'limit' of the original memcg.
> > > > > So it is a risk if the original memcg is still being charged. We have
> > > > > to forbid the destruction of the original memcg.
> > >
> > > I agree, I also don't like reparenting for !kmem case. For kmem (and *maybe*
> > > bpf maps is an exception), I don't think there is a better choice.
> > >
> > > > yes, I was toying with an idea like that. I guess we really want a
> > > > measure to keep cgroups around if they are bound to a resource which is
> > > > sticky itself. I am not sure how many other resources like BPF (aka
> > > > module like) we already do charge for memcg but considering the
> > > > potential memory consumption just reparenting will not help in general
> > > > case I am afraid.
> > >
> > > Well, then we have to make these objects a first-class citizens in cgroup API,
> > > like processes. E.g. introduce cgroup.bpf.maps, cgroup.mounts.tmpfs etc.
> > > I easily can see some value here, but it's a big API change.
> > >
> > > With the current approach when a bpf map pins a memory cgroup of the creator
> > > process (which I think is completely transparent for most bpf users), I don't
> > > think preventing the deletion of a such cgroup is possible. It will break too
> > > many things.
> > >
> > > But honestly I don't see why userspace can't handle it. If there is a cgroup which
> > > contains shared bpf maps, why would it delete it? It's a weird use case, I don't
> > > think we have to optimize for it. Also, we do a ton of optimizations for live
> > > cgroups (e.g. css refcounting being percpu) which are not working for a deleted
> > > cgroup. So noone really should expect any properties from dying cgroups.
> > >
> >
> > Just a random thought here, and I can easily be wrong (and this can
> > easily be the wrong thread for this), but if we introduce a more
> > generic concept to generally tie a resource explicitly to a cgroup
> > (tmpfs, bpf maps, etc) using cgroupfs interfaces, and then prevent the
> > cgroup from being deleted unless the resource is freed or moved to a
> > different cgroup?
>
> My understanding is that Tejun would prefer a user space defined policy
> by a proper layering. And I would tend to agree that this is less prone
> to corner cases.
>
> Anyway, how would you envision such an interface?

I imagine something like cgroup.sticky.[bpf/tmpfs/..] (I suck at naming things).

The file can contain a list of bpf map ids or tmpfs inode ids or mount
paths. You can write a new id/path to the file to add one, or read the
file to see a list of them. Basically very similar semantics to
cgroup.procs. Instead of processes, we have different types of sticky
resources here that usually outlive processes. The charging of such
resources would be deterministically attributed to this cgroup
(instead of the cgroup of the process that created the map or touched
the tmpfs file first).

Since the system admin has explicitly attributed these resources to
this cgroup, it makes sense that the cgroup cannot be deleted as long
as these resources exist and are charged to it, similar to
cgroup.procs. This also addresses some of the zombie cgroups problems.

The obvious question is: to maintain the current behavior, bpf maps
and tmpfs mounts will be by default initially charged the same way as
today. bpf maps for the cgroup of the process that created them, and
tmpfs pages on first touch basis. How do we move their charging after
their creation in the current way to a cgroup.sticky file?

For things like bpf maps, it should be relatively simple to move
charges the same way we do when we move processes, because the bpf map
is by default charged to one memcg. For tmpfs, it would be challenging
to move the charges because pages could be individually attributed to
different cgroups already. For this, we can impose a (imo reasonable)
restriction that for tmpfs (and similar resources that are currently
not attributed to a single cgroup), that you can only add a tmpfs
mount to cgroup.sticky.tmpfs for the first time if no pages have been
charged yet (no files created). Once the tmpfs mount lives in any
cgroup.sticky.tmpfs file, we know that it is charged to one cgroup,
and we can move the charges more easily.

The system admin would basically mount the tmpfs directory and then
directly write it to a cgroup.sticky.tmpfs file. For that point
onwards, all tmpfs pages will be charged to that cgroup, and they need
to be freed or moved before the cgroup can be removed.

I could be missing something here, but I imagine such an interface(s)
would address both the bpf progs/maps charging concerns, and our
previous memcg= mount attempts. Please correct me if I am wrong.

>
> > This would be optional, so the current status quo is maintainable, but
> > also gives flexibility to admins to assign resources to cgroups to
> > make sure nothing is ( unaccounted / accounted to a zombie memcg /
> > reparented to an unrelated parent ). This might be too fine-grained to
> > be practical but I just thought it might be useful. We will also need
> > to define an OOM behavior for such resources. Things like bpf maps
> > will be unreclaimable, but tmpfs memory can be swapped out.
>
> Keep in mind that the swap is a shared resource in itself. So tmpfs is
> essentially a sticky resource as well. A tmpfs file is not bound to any
> proces life time the same way BPF program is. You might need less
> priviledges to remove a file but in principle they are consuming
> resources without any explicit owner.

I fully agree, which is exactly why I am suggesting having a defined
way to handle such "sticky" resources that outlive processes.
Currently cgroups operate in terms of processes and this can be a
limitation for such resources.

> --
> Michal Hocko
> SUSE Labs
