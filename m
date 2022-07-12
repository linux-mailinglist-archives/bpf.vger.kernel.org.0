Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CEF5714DD
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 10:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGLIkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 04:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiGLIk2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 04:40:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C7A5E72
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 01:40:26 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 185so7152646vse.6
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/3xRUw+AhDAaSaTQ4YnfHz8pUsuYyr5QJTCiKtU/+8=;
        b=g3H0LnpEr0UXO87E2vF/6HgNq4pD95kIbBUOrQzyjGoAQqT8nBf6gN5NLuhAtjStP8
         b6aPdzfcJL6MB5wDD+veOSIZ5altrCFQFeUrHBh9CIL/arF0mDq73uz+G14SyL/lp565
         YW8gYxKRJQy3MnjwkU6wj2BA0oU+aBLwsYOd/c4YcvN/xDWmqsZ6Kn8YGqUEkfzZSV4j
         j8STnavL36aao63TxNuLZAjI7MQYDGnf6EO2a9EFIgMsnc+rY+FaEypzSx9/wxYmOoVl
         zfB8WSkwLYL3Ysw65mRtqy/REe29XwnQjMxns+j54faeFqFdWssmNOICtp+tFwnIwmmy
         ze2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/3xRUw+AhDAaSaTQ4YnfHz8pUsuYyr5QJTCiKtU/+8=;
        b=N0GGuQFabc/H7sDNn0vjf+Qgb7LeTLErUtrIwxixx+Ty6r3sa7r7kwCDNTVpa3GxhU
         Ql7I9o5cYEiWALnwnSDuDZ0OjTD1O/gJNN9jFOgz3p3jrLrNdBf9kmyGfRmQv5EN720H
         +fw/Mz+4oTpA8nAQTCRah0L5DDarMjSGq4kCYMEEa6/abQGOwFi2g4D6R+BdVKyPW+O7
         LpYWE4cASWlyqdA6+bqLzBQt56VizBZG5Xfas9F6OtFYWYBpYIkosThFhAfyBAT9Sokv
         RDGTEVK6zL2BaNWJE+GBVmZnLXkQ9ZJdBYnTn9lyG0Xb4Vx/vtF4NKku+7W62qu4TH9i
         GdQg==
X-Gm-Message-State: AJIora+BmX9RpUMVgSxvXgQcUkLr7HtpeNA2EAVgkRRt0Zf2pB0p/sVf
        Jb8JDCDjNvwFQWXDxhYGIc0NTrZE2QRQLFzZ5sg=
X-Google-Smtp-Source: AGRyM1vy275iWu0ITFuTL2WLkRaiqo3KjUsVPwUtuph0/CqB1TAlh8Y0AJzSfsrkFmnlLWZL9NQ19TARqMXsu36o2ws=
X-Received: by 2002:a05:6102:411:b0:357:6e48:d34c with SMTP id
 d17-20020a056102041100b003576e48d34cmr2039803vsq.80.1657615225833; Tue, 12
 Jul 2022 01:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org> <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com> <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com> <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com> <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
In-Reply-To: <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 12 Jul 2022 16:39:48 +0800
Message-ID: <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Tue, Jul 12, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 11-07-22 21:39:14, Alexei Starovoitov wrote:
> > On Mon, Jul 11, 2022 at 02:15:07PM +0200, Michal Hocko wrote:
> > > On Sun 10-07-22 07:32:13, Shakeel Butt wrote:
> > > > On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> > > > > On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > [...]
> > > > > >
> > > > > > Most probably Michal's comment was on free objects sitting in the caches
> > > > > > (also pointed out by Yosry). Should we drain them on memory pressure /
> > > > > > OOM or should we ignore them as the amount of memory is not significant?
> > > > >
> > > > > Are you suggesting to design a shrinker for 0.01% of the memory
> > > > > consumed by bpf?
> > > >
> > > > No, just claim that the memory sitting on such caches is insignificant.
> > >
> > > yes, that is not really clear from the patch description. Earlier you
> > > have said that the memory consumed might go into GBs. If that is a
> > > memory that is actively used and not really reclaimable then bad luck.
> > > There are other users like that in the kernel and this is not a new
> > > problem. I think it would really help to add a counter to describe both
> > > the overall memory claimed by the bpf allocator and actively used
> > > portion of it. If you use our standard vmstat infrastructure then we can
> > > easily show that information in the OOM report.
> >
> > OOM report can potentially be extended with info about bpf consumed
> > memory, but it's not clear whether it will help OOM analysis.
>
> If GBs of memory can be sitting there then it is surely an interesting
> information to have when seeing OOM. One of the big shortcomings of the
> OOM analysis is unaccounted memory.
>
> > bpftool map show
> > prints all map data already.
> > Some devs use bpf to inspect bpf maps for finer details in run-time.
> > drgn scripts pull that data from crash dumps.
> > There is no need for new counters.
> > The idea of bpf specific counters/limits was rejected by memcg folks.
>
> I would argue that integration into vmstat is useful not only for oom
> analysis but also for regular health check scripts watching /proc/vmstat
> content. I do not think most of those generic tools are BPF aware. So
> unless there is a good reason to not account this memory there then I
> would vote for adding them. They are cheap and easy to integrate.
>
> > > OK, thanks for the clarification. There is still one thing that is not
> > > really clear to me. Without a proper ownership bound to any process why
> > > is it desired/helpful to account the memory to a memcg?
> >
> > The first step is to have a limit. memcg provides it.
>
> I am sorry but this doesn't really explain it. Could you elaborate
> please? Is the limit supposed to protect against adversaries? Or is it
> just to prevent from accidental runaways? Is it purely for accounting
> purposes?
>
> > > We have discussed something similar in a different email thread and I
> > > still didn't manage to find time to put all the parts together. But if
> > > the initiator (or however you call the process which loads the program)
> > > exits then this might be the last process in the specific cgroup and so
> > > it can be offlined and mostly invisible to an admin.
> >
> > Roman already sent reparenting fix:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/
>
> Reparenting is nice but not a silver bullet. Consider a shallow
> hierarchy where the charging happens in the first level under the root
> memcg. Reparenting to the root is just pushing everything under the
> system resources category.
>

Agreed. That's why I don't like reparenting.
Reparenting just reparent the charged pages and then redirect the new
charge, but can't reparents the 'limit' of the original memcg.
So it is a risk if the original memcg is still being charged. We have
to forbid the destruction of the original memcg.

> > > As you have explained there is nothing really actionable on this memory
> > > by the OOM killer either. So does it actually buy us much to account?
> >
> > It will be actionable. One step at a time.
> > In the other thread we've discussed an idea to make memcg selectable when
> > bpf objects are created. The user might create a special memcg and use it for
> > all things bpf. This might be the way to provide bpf specific accounting
> > and limits.
>
> Do you have a reference for those discussions?
>

I think it is https://lore.kernel.org/bpf/CALOAHbCM=ZxwutQOPmJx2LKY3Pd_hs+8v8r4-ybwPbBNBuNjXA@mail.gmail.com/
.
Introducing independent memcg to manage pinned bpf programs and maps
and forbid the user to destroy them if bpf programs are not unpinned,
that's the best workaround so sar, per my analysis.

-- 
Regards
Yafang
