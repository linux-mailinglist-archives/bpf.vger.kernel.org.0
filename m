Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5863DA63
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiK3QSs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 11:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3QSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 11:18:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B412CCA4
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 08:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 892FC61CB8
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 16:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1F2C433D7
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669825126;
        bh=KZLVjRYAEWDOIkOwlUQk3o7idcubztUPk/V9lAeQDug=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ms7XRKU/tG97oZpE9gYVFLz43UAXWfmGdpnhiQdGsauyfLQkHBQakIkaGGRb7LWUl
         dpwR8DpnBZ/ginytQwd4uHBcQZQpa8BkVlHFaZ4K4bB9+lyQP6i0PyGkNFf1F/UGQv
         KMZXuDrXIBIU2uyo1jfJ7Adsupfs2ptTYs2LzYtCkSO0NDfKjOoTGKOq+xyU2ko404
         fdZLTJjSXJVaGOpOCoIHrRJ8Sp1ZswdfDAw8lA4jkUqjvOv4+QTgOs4LIyvt6q7vtE
         lxTnNBRjLArqM1FTxYhrmSA0PgWGMmintGLtWX4WJke2eafHoj11glZHmu8Bl4gJDg
         33HcLUrZuP8rw==
Received: by mail-ua1-f52.google.com with SMTP id q6so6342013uao.9
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 08:18:45 -0800 (PST)
X-Gm-Message-State: ANoB5pmspDK1mTB8B3N6nVneyZMZXYaJl5n1uwBpdTaMvcnE2hETIKmq
        0lS/09QqZFeloqcJU1SZkdcEjmhiRuGxwUo9bBg=
X-Google-Smtp-Source: AA0mqf4Xq2P2GMVmisZULrIbu8N7BwNZlMRiUfy9qur8wRsLMGvA3e8V7T4IjdHgfLQR/8CW7Q5eHwApmhIzh47Wt4M=
X-Received: by 2002:a9f:22a7:0:b0:418:87ba:c43a with SMTP id
 36-20020a9f22a7000000b0041887bac43amr25783128uan.114.1669825124875; Wed, 30
 Nov 2022 08:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20221107223921.3451913-1-song@kernel.org> <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <87lenuukj0.ffs@tglx> <CAPhsuW7BoJbRi7Tqck=cW1n0xdESOkwqU=PMAdL9LvCun47Y+w@mail.gmail.com>
 <871qpluxfu.ffs@tglx>
In-Reply-To: <871qpluxfu.ffs@tglx>
From:   Song Liu <song@kernel.org>
Date:   Wed, 30 Nov 2022 08:18:31 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
Message-ID: <CAPhsuW4Fy4kdTqK0rHXrPprUqiab4LgcTUG6YhDQaPrWkgZjwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thomas,

On Tue, Nov 29, 2022 at 3:56 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Song,
>
> On Tue, Nov 29 2022 at 09:26, Song Liu wrote:
> > On Tue, Nov 29, 2022 at 2:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Modules are the obvious starting point. Once that is solved pretty much
> >> everything else falls into place including BPF.
> >>
> >> Without modules support this whole exercise is pointless and not going
> >> anywhere near x86.
> >
> > I am not sure I fully understand your point here. Do you mean
> >
> > 1) There is something wrong with this solution, that makes it not suitable
> > for modules;
> >    or
> > 2) The solution is in the right direction and it will very likely work
> > for modules.
> > But we haven't finished module support. ?
>
> As I'm obviously unable to express myself coherently, let me try again:
>
>  A solution which solves the BPF problem, but does not solve the
>  underlying problem of module_alloc() is not acceptable.
>
> Is that clear enough?

While I sincerely want to provide a solution not just for BPF but also
for modules and others, I don't think I fully understand the underlying
problem of module_alloc(). I sincerely would like to learn more about it.

>
> > If it is 1), I would like to understand what are the issues that make it not
> > suitable for modules. If it is 2), I think a solid, mostly like working small
> > step toward the right direction is the better way as it makes code reviews
> > a lot easier and has much lower risks. Does this make sense?
>
> No. Because all you are interested in is to get your BPF itch scratched
> instead of actually sitting down and solving the underlying problem and
> thereby creating a benefit for everyone.

TBH, until your reply, I thought I was working on something that would
benefit everyone. It is indeed not just for BPF itch, as bpf_prog_pack
already scratched it for BPF.

>
> You are not making anything easier. You are violating the basic
> engineering principle of "Fix the root cause, not the symptom".
>

I am not sure what is the root cause and the symptom here. I
understand ideas referred in this lwn article:

   https://lwn.net/Articles/894557/

But I don't know which one of them (if any) would fix the root cause.

> By doing that you are actually creating more problems than you
> solve. Why?
>
>   Clearly your "solution" does not cover the full requirements of the
>   module space because you solely focus on executable memory allocations
>   which somehow magically go into the module address space.
>
>   Can you coherently explain how this results in a consistent solution
>   for the rest of the module requirements?
>
>   Can you coherently explain why this wont create problems down the road
>   for anyone who actually would be willing to solve the root cause?
>
> No, you can't answer any of these questions simply because you never
> explored the problem space sufficiently.

I was thinking, for modules, we only need something new for module text,
and module data will just use vmalloc(). I guess this is probably not the
right solution?

>
> I'm not the first one to point this out. Quite some people in the
> various threads regarding this issue have been pointing that out to you
> before. They even provided you hints on how this can be solved properly
> once and forever and for everyones benefits.

I tried to review various threads. Unfortunately, I am not able to identify
the proper hints and construct a solution.

>
> > I would also highlight that part of the benefit of this work comes from
> > reducing direct map fragmentations. While BPF programs consume less
> > memory, they are more dynamic and can cause more direct map
> > fragmentations. bpf_prog_pack in upstream kernel already covers this
> > part, but this set is a better solution than bpf_prog_pack.
> >
> > Finally, I would like to point out that 5/6 and 6/6 of (v5) the set let BPF
> > programs share a 2MB page with static kernel text. Therefore, even
> > for systems without many BPF programs, we should already see some
> > reduction in iTLB misses.
>
> Can you please stop this marketing nonsense? As I pointed out to you in
> the very mail which your are replying to, the influence of BPF on the
> system I picked randomly out of the pool is pretty close to ZERO.
>
> Ergo, the reduction of iTLB misses is going to be equally close to
> ZERO. What is the benefit you are trying to sell me?
>
> I'm happy to run perf on this machine and provide the numbers which put
> your 'we should already see some reduction' handwaving into perspective.
>
> But the above is just a distraction. The real point is:
>
> You can highlight and point out the benefits of your BPF specific
> solution as much as you want, it does not make the fact that you are
> "fixing" the symptom instead of the root cause magically go away.
>
> Again for the record:
>
>   The iTLB pressure problem, which affects modules, kprobes, tracing and
>   BPF, is caused by the  way how module_alloc() is implemented.

TBH, I don't think I understand this...

Do you mean the problem with  module_alloc() is that it is not aware of
desired permissions (W or X or neither)? If so, is permission vmalloc [1]
the right direction for this?

[1] https://lwn.net/ml/linux-mm/20201120202426.18009-1-rick.p.edgecombe@intel.com/

>
> That's the root cause and this needs to be solved for _ALL_ of the users
> of this infrastructure and not worked around by adding something which
> makes BPF shiny and handwaves about that it solves the underlying
> problem.

While I did plan to enable 2MB pages for module text, I didn't plan to
solve it in the first set. However, since you think it is possible and would
like to provide directions, I am up for the challenge and will give it a try.
Please share more details about the right direction. Otherwise, I am
still lost...

Thanks,
Song
