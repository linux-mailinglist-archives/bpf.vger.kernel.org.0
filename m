Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE5C5788FA
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiGRR4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGRR4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 13:56:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6776527B31
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 10:56:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so2363058wrr.6
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUYa4FvEr0j+muM1OSqff8K+8eK7M8BpGNz6BG478ro=;
        b=k98T3SAbLzj/t6LT5j/X+Einj1T/WV5zhOrcX1I7klpDgDYv+2eh7xyfx/eJhD/27G
         3E3EFhfOvJVuh9/opS0p9VEP26y3EC8GzBHNpbgA5erVEOkMaVlN1moSINnTJjwfxySF
         nTAkGI25XvrBgDiNN8N/8mVp15yVTU14+eyTojC/5N99P77P+og+eG+voeue0EcGJjxa
         91c6Trqajcm/bO+3WXN6vpI3QLz5EQwKsvBgTfpmXtTGGGEFzE9Niq3ZRsheA66AA8+Z
         cvU1BM1o8Lgys2Fu4eY9r0lnikST8AIjuZCnlnXUALQUB9DjqN9nta2ZAllNh7+Qrib5
         L3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUYa4FvEr0j+muM1OSqff8K+8eK7M8BpGNz6BG478ro=;
        b=kk6ArlcS8HOfH/kZ1Ig69WUAceOAyq/z4HEPYUkYvxOKqxg7+kV5HX4ImVDz78ngFP
         bD9jI/o742yqtj6kVD0HU1ILiyWs9cEt0CHak6eM5ajxSsZVL74zLxN9edG6iYwgA09J
         hvA4e1v/3MgEwT6wqqBiM2Nr3ec8eTcb0YPOqKEatiG4bAVwn9xGe5c8RyXIGWY0SLnz
         c19xjt9xbP3U0IwK0UcsBJD3zEWfj4v4pOQC7vXWvPU2JI/Taf0pOnKw0wsTHOojFBFF
         h8RBiH+aexXhmCKDSGsWXI5mMZN/eYO3YMkC45QPsPq/dkG067mIE3936wBoEirUYil4
         Qlgg==
X-Gm-Message-State: AJIora8PbmnkqGHZNCWMpUT2Mku5wGQZL1yNyD8v/oF7/E4wjLOMMInn
        jhHbWzcC7OfD5ns9ruWwPJ5VJWIrc0pCPt4u7vVP+g==
X-Google-Smtp-Source: AGRyM1vDD0owJd7Go+UdK8dVZWCYHhPlbH9InqRBMMfSWW3kNQVP7If92+7nld/97anTGJka6f3ZBvtMP9RmIn11mBU=
X-Received: by 2002:a5d:47c6:0:b0:21d:97dc:8f67 with SMTP id
 o6-20020a5d47c6000000b0021d97dc8f67mr24403312wrc.372.1658166995767; Mon, 18
 Jul 2022 10:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
In-Reply-To: <Ys4wRqCWrV1WeeWp@castle>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 18 Jul 2022 10:55:59 -0700
Message-ID: <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>,
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

On Tue, Jul 12, 2022 at 7:39 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Jul 12, 2022 at 11:52:11AM +0200, Michal Hocko wrote:
> > On Tue 12-07-22 16:39:48, Yafang Shao wrote:
> > > On Tue, Jul 12, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > > Roman already sent reparenting fix:
> > > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/
> > > >
> > > > Reparenting is nice but not a silver bullet. Consider a shallow
> > > > hierarchy where the charging happens in the first level under the root
> > > > memcg. Reparenting to the root is just pushing everything under the
> > > > system resources category.
> > > >
> > >
> > > Agreed. That's why I don't like reparenting.
> > > Reparenting just reparent the charged pages and then redirect the new
> > > charge, but can't reparents the 'limit' of the original memcg.
> > > So it is a risk if the original memcg is still being charged. We have
> > > to forbid the destruction of the original memcg.
>
> I agree, I also don't like reparenting for !kmem case. For kmem (and *maybe*
> bpf maps is an exception), I don't think there is a better choice.
>
> > yes, I was toying with an idea like that. I guess we really want a
> > measure to keep cgroups around if they are bound to a resource which is
> > sticky itself. I am not sure how many other resources like BPF (aka
> > module like) we already do charge for memcg but considering the
> > potential memory consumption just reparenting will not help in general
> > case I am afraid.
>
> Well, then we have to make these objects a first-class citizens in cgroup API,
> like processes. E.g. introduce cgroup.bpf.maps, cgroup.mounts.tmpfs etc.
> I easily can see some value here, but it's a big API change.
>
> With the current approach when a bpf map pins a memory cgroup of the creator
> process (which I think is completely transparent for most bpf users), I don't
> think preventing the deletion of a such cgroup is possible. It will break too
> many things.
>
> But honestly I don't see why userspace can't handle it. If there is a cgroup which
> contains shared bpf maps, why would it delete it? It's a weird use case, I don't
> think we have to optimize for it. Also, we do a ton of optimizations for live
> cgroups (e.g. css refcounting being percpu) which are not working for a deleted
> cgroup. So noone really should expect any properties from dying cgroups.
>

Just a random thought here, and I can easily be wrong (and this can
easily be the wrong thread for this), but if we introduce a more
generic concept to generally tie a resource explicitly to a cgroup
(tmpfs, bpf maps, etc) using cgroupfs interfaces, and then prevent the
cgroup from being deleted unless the resource is freed or moved to a
different cgroup?

This would be optional, so the current status quo is maintainable, but
also gives flexibility to admins to assign resources to cgroups to
make sure nothing is ( unaccounted / accounted to a zombie memcg /
reparented to an unrelated parent ). This might be too fine-grained to
be practical but I just thought it might be useful. We will also need
to define an OOM behavior for such resources. Things like bpf maps
will be unreclaimable, but tmpfs memory can be swapped out.

I think this also partially addresses Johannes's concerns that the
memcg= mount option uses file system mounts to create shareable
resource domains outside of the cgroup hierarchy.

> Thanks!
>
