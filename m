Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BC57A81F
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiGSUQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiGSUQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 16:16:17 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B542AC7
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:16:15 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id s1so14479010vsr.12
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fZYu+1ItEdtumrIwz+viCZWzbZgaVsyd8axTqL69J8=;
        b=lhMx3WCGxmsOPPKH8fXkrtq39pSx4jZoHIt7npcOYxvi9Z9J0pI3EzsCIk+Atu8L6o
         0ydgxUCSfKgitz0EJiaj/9X40kD3K0VnkE8sgf9rdRfrp2oNxCDnSi+GZFJDzYZtmRbe
         AdLa5FAd4/Bx1Hbqb5WWQgNYqbKXuWQUMoFBZGoHT66Sqv0UaykxXXilIZ8wR2Y/l+DD
         Em42wuztIwvg/r8hlcwHxHgnV87QwshBIHr1MmQ8OMxul6NXJJk2h4Wylfx1W0kAUbpt
         zwy6DLLgmN9JKNR1qxk308Bd4iP3pA3WYnBiZTsdAzNa7ecPwv1+jSE9JNLzbFk2ESK2
         B4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fZYu+1ItEdtumrIwz+viCZWzbZgaVsyd8axTqL69J8=;
        b=11/ofRcPOVIEUa4/8Tp+TfSSPmOe/EJ5HGR7RbphN9jbMcNyoYw8Yk3e5KmJxz/7ID
         UJtojQUfTdf24RmKn5tV7/AieuJaOsm9Ufg8AKUPNWUPm5rGRnIbiov3D+mCze52Jz2/
         laVDkfAu5a8GfT+c+ncfr2fGzsZkmLAbsSSnOIBFFFLqcY6AD0wbZ3r4UQ3RvL5+V6cn
         ijdqpF9XDgdki+v55f7/km/LkSKeJkeQkKVJ/82SZScDIy8Jx6ibjsH/crtg21mhkiKI
         G7y2sPV70UGIu/pVNi9xNJEaZ1cJNlvGYvSa2Bxy1y7tptwFFC4h1UTvD5u6CRQmwtDR
         K3hQ==
X-Gm-Message-State: AJIora9hbd9TtWpIq99Gq89AkaqrERFXlJemWXZXrspU/ui1mHVmWyLD
        efsm0C5THNmBQKfGZWtAi4FliwGn3zpFyobr61Zrxg==
X-Google-Smtp-Source: AGRyM1syMnsmkFypSHvlChPgZAVDlfKvy3Xew/8nGSWlc3qi7PA0FACDWczilu3QxVPEvGajBfphU8Q2sJcXLlP9tww=
X-Received: by 2002:a05:6102:3676:b0:357:6dd9:7145 with SMTP id
 bg22-20020a056102367600b003576dd97145mr12613977vsb.49.1658261774515; Tue, 19
 Jul 2022 13:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz> <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
 <YtcDEpaHniDeN7fP@slm.duckdns.org> <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
 <YtcIJClKxUPntdM9@slm.duckdns.org> <CAHS8izOrGBLUGDAo0_7Y0_7y4+2BusFeqOMkxwbXUSvMTvTGDQ@mail.gmail.com>
 <YtcL5Sb0Nu1DCfrv@slm.duckdns.org>
In-Reply-To: <YtcL5Sb0Nu1DCfrv@slm.duckdns.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 19 Jul 2022 13:16:02 -0700
Message-ID: <CAHS8izP4qd0vv3mmgVHu+Dxrimv3cegG-DCgDp+=bK60O0oaYQ@mail.gmail.com>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>
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

On Tue, Jul 19, 2022 at 12:54 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 19, 2022 at 12:47:39PM -0700, Mina Almasry wrote:
> > Hmm, sorry I might be missing something but I don't think we have the
> > same thing in mind?
> >
> > My understanding is that the sysadmin can do something like this which
> > is relatively inexpensive to implement in the kernel:
> >
> >
> > mount -t tmpfs /mnt/mymountpoint
> > echo "/mnt/mymountpoint" > /path/to/cgroup/cgroup.charge_for.tmpfs
> >
> >
> > At that point all tmpfs charges for this tmpfs are directed to
> > /path/to/cgroup/memory.current.
> >
> > Then the sysadmin can do something like:
> >
> >
> > echo "/mnt/mymountpoint" > /path/to/cgroup2/cgroup.charge_for.tmpfs
> >
> >
> > At that point all _future_ charges of that tmpfs will go to
> > cgroup2/memory.current. All existing charges remain at
> > cgroup/memory.current and get uncharged from there. Per my
> > understanding there is no need to move all the _existing_ charges from
> > cgroup/memory.current to cgroup2/memory.current.
>
> So, it's a lot better if the existing charges aren't moved around but it's
> also kinda confusing if something can be moved around the tree arbitrarily
> leaving charges behind. We already do get that from moving processes around
> but most common usages are pretty static at this point and I think it'd be
> better to avoid expanding the interface in that direction.
>

I think I'm flexible in this sense. Would you like the kernel to
prevent reattaching the tmpfs to a different cgroup? To be honest we
have a use case for that, but I'm not going to die on this hill. I
guess the worst case scenario is that I can carry a local patch on our
kernel which allows reattaching to a different cgroup and directs
future charges there...

> I'd much prefer something alont the line of `mount -t tmpfs -o cgroup=XXX`
> where the tmpfs code checks whether the specified cgroup is one of the
> ancestors and the mounting task has enough permission to shift the resource
> there.
>

Actually this is pretty much the same interface I opted for in my
original proposal (except I named it memcg= rather than cgroup=):
https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

Curious, why do we need to check if the cgroup= is an ancestor? We
actually do have a use case where the cgroups are unrelated and the
common ancestor is root. Again, I'm not sure I want to die on this
hill. At worst I can remove the restriction in a local patch for our
kernel again...

Before I get too excited and implement these changes and submit
another iteration of my proposal above, I'd love to hear from
Johannes/Michal/Roman. My previous proposal was a pretty strong nack
from Johannes and Michal in particular.

> Thanks.
>
> --
> tejun
