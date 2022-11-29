Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7663CC01
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiK2X4n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 18:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK2X4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 18:56:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD65ADE3
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 15:56:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669766198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ciH+KN2VCKnkPceqB8qk/ZvYiib3qLho11Tk6MOO6VU=;
        b=16Yf48tjxUPsuw0WulIhQd5+7YojsaluMmMEHlNNZ++g8j8+62QJNjGAFYatJTDU7FbJPi
        EnxL5XtU1cQZo+9RZkkD5D/4vbwMN8fRATEs9YAkwTcIOcjhHj7rozT9NznyXlMqUpKLxs
        IF1EHwgm7ndXk7HGJDTHtl5j3Y/R10Sv3gheWJwVrc954aeRLaxJDhhp+4JgIduyb42cyY
        gKl4X1X0hDkC6yXN/Lj2PCtjwLAsACRmgoA7Dh3a7bB+rOnXACT/AThi9ThzJv+G1hlXSB
        oCw2FxUG21L8OWMaFHEePvdroatllYsl007svF98j2FhEVn2EoeM/Z+wJJ3yIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669766198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ciH+KN2VCKnkPceqB8qk/ZvYiib3qLho11Tk6MOO6VU=;
        b=6r5CjmoRjjS88tPzxoZ/OFxObZfxxLo0X6kpqon4m4URZr0qFe+DJknPuudjP4F4EF6TSf
        4UFB1tQ4Xx5LeODA==
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org,
        akpm@linux-foundation.org, x86@kernel.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
In-Reply-To: <CAPhsuW7BoJbRi7Tqck=cW1n0xdESOkwqU=PMAdL9LvCun47Y+w@mail.gmail.com>
References: <20221107223921.3451913-1-song@kernel.org>
 <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
 <87lenuukj0.ffs@tglx>
 <CAPhsuW7BoJbRi7Tqck=cW1n0xdESOkwqU=PMAdL9LvCun47Y+w@mail.gmail.com>
Date:   Wed, 30 Nov 2022 00:56:37 +0100
Message-ID: <871qpluxfu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song,

On Tue, Nov 29 2022 at 09:26, Song Liu wrote:
> On Tue, Nov 29, 2022 at 2:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Modules are the obvious starting point. Once that is solved pretty much
>> everything else falls into place including BPF.
>>
>> Without modules support this whole exercise is pointless and not going
>> anywhere near x86.
>
> I am not sure I fully understand your point here. Do you mean
>
> 1) There is something wrong with this solution, that makes it not suitable
> for modules;
>    or
> 2) The solution is in the right direction and it will very likely work
> for modules.
> But we haven't finished module support. ?

As I'm obviously unable to express myself coherently, let me try again:

 A solution which solves the BPF problem, but does not solve the
 underlying problem of module_alloc() is not acceptable.

Is that clear enough?

> If it is 1), I would like to understand what are the issues that make it not
> suitable for modules. If it is 2), I think a solid, mostly like working small
> step toward the right direction is the better way as it makes code reviews
> a lot easier and has much lower risks. Does this make sense?

No. Because all you are interested in is to get your BPF itch scratched
instead of actually sitting down and solving the underlying problem and
thereby creating a benefit for everyone.

You are not making anything easier. You are violating the basic
engineering principle of "Fix the root cause, not the symptom".

By doing that you are actually creating more problems than you
solve. Why?

  Clearly your "solution" does not cover the full requirements of the
  module space because you solely focus on executable memory allocations
  which somehow magically go into the module address space.

  Can you coherently explain how this results in a consistent solution
  for the rest of the module requirements?

  Can you coherently explain why this wont create problems down the road
  for anyone who actually would be willing to solve the root cause?

No, you can't answer any of these questions simply because you never
explored the problem space sufficiently.

I'm not the first one to point this out. Quite some people in the
various threads regarding this issue have been pointing that out to you
before. They even provided you hints on how this can be solved properly
once and forever and for everyones benefits.

> I would also highlight that part of the benefit of this work comes from
> reducing direct map fragmentations. While BPF programs consume less
> memory, they are more dynamic and can cause more direct map
> fragmentations. bpf_prog_pack in upstream kernel already covers this
> part, but this set is a better solution than bpf_prog_pack.
>
> Finally, I would like to point out that 5/6 and 6/6 of (v5) the set let BPF
> programs share a 2MB page with static kernel text. Therefore, even
> for systems without many BPF programs, we should already see some
> reduction in iTLB misses.

Can you please stop this marketing nonsense? As I pointed out to you in
the very mail which your are replying to, the influence of BPF on the
system I picked randomly out of the pool is pretty close to ZERO.

Ergo, the reduction of iTLB misses is going to be equally close to
ZERO. What is the benefit you are trying to sell me?

I'm happy to run perf on this machine and provide the numbers which put
your 'we should already see some reduction' handwaving into perspective.

But the above is just a distraction. The real point is:

You can highlight and point out the benefits of your BPF specific
solution as much as you want, it does not make the fact that you are
"fixing" the symptom instead of the root cause magically go away.

Again for the record:

  The iTLB pressure problem, which affects modules, kprobes, tracing and
  BPF, is caused by the way how module_alloc() is implemented.

That's the root cause and this needs to be solved for _ALL_ of the users
of this infrastructure and not worked around by adding something which
makes BPF shiny and handwaves about that it solves the underlying
problem.

Thanks,

        tglx



