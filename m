Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414575738BD
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 16:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiGMOY6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiGMOYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 10:24:47 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9593342C
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 07:24:43 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id s1so7412546vsr.12
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWXPjVie3sm72rSDN7Kiu+BHdXUWrF5jARXkQ8BtbN0=;
        b=BxoIP5+oTXnnHRCwZ4lrpGjz+ivHT0zYtrlPzqV2LvJowZUWFwTfKOhkJW6mcmXocU
         /x7XuBttgTBM3D2533dZaHLD99E3ttmPNc+EF2Sh8T/hOEORGrZ0A5ubSqA17uroh0Eh
         iiol2zMqN+47bNk34lKBt6JslkfEsbGBVkjG6A8XRIbsFjg6U+Q3n370yV0Yna/BnWPc
         /mxAqVCIFXB3DWLOnDnwVsGrE5Yun8BgZs6b3iumdawPJFZqS0FL+84oudojlYk5H2E+
         i0GVnPWyRXr6PHVR9iuQhWXJDBlLXObY4yd0nGLL4iWyTZXpZZKBIoSgs6k4FG4vfjr4
         Om9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWXPjVie3sm72rSDN7Kiu+BHdXUWrF5jARXkQ8BtbN0=;
        b=udYHQgFiL1tY0IoW+27gQ7GlJvSFCAiLCLvmCdpOoXuFDCVPnoo76HDyYkSB+nZ8g4
         flPqKau0Ya/+1bXqFtr9PXcyV00z9MqPgSAXnaceWHqUryFo7m92+idJOLsV+tPQEmem
         mSHbHd2XgHLzT+A7MVsR74B74eh+3tpKCub0Rz+HzwSezjUBpYDf1ZXpsmyiOuqydIb5
         LGMmgtd6V6qWlqbBcgnc7Xm9vE3gWIt4nA4vPckvgspJvZsbTyVyLgktlxisUlDRvBnl
         vQGU7PY+xJAcbhjiDXiu6Nt4tsFjJdqFdbzlmHzVOCe1zvQK8NIf2EaNtn4AmMmPqOoC
         YKhw==
X-Gm-Message-State: AJIora8YcIx8RqQjNL00/KkZX/GIEaM98F2pni2AnZ159Z4ISQniHmuP
        n3s0nCtkby0XZ2z3yiAcn7gm0GSV1SFdEg+PDEQ=
X-Google-Smtp-Source: AGRyM1tDKiU0EebMnrOiIsWxkxJInH8ck5QLYPgxv2VUGxnt9Ldyb/yIxvdnJxUJvz6fivGeg04TaHvSz+SxsYtjxyI=
X-Received: by 2002:a05:6102:3d20:b0:357:7f61:6127 with SMTP id
 i32-20020a0561023d2000b003577f616127mr1246333vsv.11.1657722282306; Wed, 13
 Jul 2022 07:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
In-Reply-To: <Ys4wRqCWrV1WeeWp@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 13 Jul 2022 22:24:05 +0800
Message-ID: <CALOAHbAyZBKRn3HpjeKsxpTP8aKnHxFiMD_kGJG22c0X8Cb9+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 10:39 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
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

I think we have discussed why the user can't handle it easily.
Actually It's NOT a weird use case if you are a k8s user.  (Of course
it may seem weird to the systemd user, but unfortunately systemd
doesn't rule the whole world. )
I have told you that it is not reasonable to refuse a containerized
process to pin bpf programs, but if you are not familiar with k8s, it
is not easy to explain clearly why it is a trouble for deployment.
But I can try to explain to you from a *systemd user's* perspective.

                   bpf-memcg                       (must be persistent)
                  /                \
  bpf-foo-memcg       bpf-bar-memcg   (must be persistent, and limit here)
-------------------------------------------------------
           /                              \
    bpf-foo pod              bpf-bar pod    (being created and
destroyed, but not limited)

I assume the above hierarchy is what you expect.
But you know, in the k8s environment, everything is pod-based, that
means if we use the above hierarchy in the k8s environment, the k8s's
limiting, monitoring, debugging must be changed consequently.  That
means it may be a fullstack change in k8s, a great refactor.

So below hierarchy is a reasonable solution,
                                          bpf-memcg
                                                |
  bpf-foo pod                    bpf-foo-memcg     (limited)
       /          \                                /
(charge)     (not-charged)      (charged)
proc-foo                     bpf-foo

And then keep the bpf-memgs persistent.

-- 
Regards
Yafang
