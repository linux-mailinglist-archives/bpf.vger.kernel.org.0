Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE1A65F577
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 22:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjAEVCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 16:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjAEVCN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 16:02:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D096338D
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 13:02:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t17so92717505eju.1
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 13:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aNr1MGBIVwcQw+BiKvB3BNiiafqmWFm3LEAGAEN7duE=;
        b=LSQ4uifsT0w0Gy5f+7ts1dpLZrFPy/oOOklgAank9UtgRfoG1pXUbsrF0InSsqadin
         ZJds62eOz46rN3FW57Tfxb0lJQj7YUQTWthMx6UE0HMG1c4eZJ0QbvGbjqhSa3yQxVNj
         7hl/1GKIjf9B/E7WTPUSiUNw46H2Ix1/8JF0dLdFvMg9j8kIuydt6OHHIMk1n1SKPknV
         ZiZAuhIP5Tn+/k6L/i4+hVf0HKuRjhYrv6O3FtfYUYEVq++VwoH2xEkr3+FE/4wyivXY
         hlg8qEAVYMnuud6gtLBUjZegZBK8iqe5YdLB8fXveYhme9Lvm/dXaC8r+wTq1N4Jipuq
         +cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNr1MGBIVwcQw+BiKvB3BNiiafqmWFm3LEAGAEN7duE=;
        b=5Z2SqnUtK9gySnRfhJG+kvaEcldO967UwV8auCYYhf1xpLdyuINDctMrLRotdn/1cN
         hn07QQHbo/BYr6Ng82NiOxci6vfia7RF6zF4LV1Dtdj4ZhjCuX4lNXvG/3CF4XSdhsp/
         CfS+FRd9SBdyk4daMKls9bQ5WLWo2sw9BvPpDnXfyY4lj/EYcgSZM55RPVbZ9HS63mXu
         lIr5TFUZEr5a2X+vnDp6IRvNYOzj5W9A9mt/WBzpeJva3BhS2d7AgiU9BZ5ZyOjzyAPU
         16ey2b8wdpTfuh5KrlDmK794JGuscY6N++CDJ8OZuxoBgM+P2WdycDPF7lnNvnmqTil6
         6Z2g==
X-Gm-Message-State: AFqh2kq2uByBMU+vqZ9N+rc9wUtpmg4TRvgHiUSJgSORcpmBIL8+1CrQ
        syE5ddBjoUF+mqV0jl/uJ0VKQaYABxgDN7eossk=
X-Google-Smtp-Source: AMrXdXvPQVP/JK6pIcNL19ocbc1thjLxizhZ4rP9XFN2/du5/H0Ub1iFUz0Cwn5BEry/b+tyldpx8FC9Qk7HCJNuy6E=
X-Received: by 2002:a17:906:a014:b0:7c1:8450:f964 with SMTP id
 p20-20020a170906a01400b007c18450f964mr5013909ejy.176.1672952528974; Thu, 05
 Jan 2023 13:02:08 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local> <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com> <Y7YQHC4FgYuLWmab@maniforge.lan>
In-Reply-To: <Y7YQHC4FgYuLWmab@maniforge.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Jan 2023 13:01:56 -0800
Message-ID: <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     David Vernet <void@manifault.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
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

Didn't find the best place to put this, so it will be here. I think it
would be beneficial to discuss BPF helpers freeze in BPF office hours.
So I took the liberty to put it up for next BPF office hours, 9am, Jan
12th 2022. I hope that some more people that have exposure to
real-world BPF application and pains associated with all that could
join the discussion, but obviously anyone is welcome as well, no
matter which way they are leaning.

Please consider joining, see details on Zoom meeting at [0]

For the rest, please see below. I'll be out for a few days and won't
be able to reply, my apologies.

  [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit#gid=0

On Wed, Jan 4, 2023 at 3:47 PM David Vernet <void@manifault.com> wrote:
>
> On Wed, Jan 04, 2023 at 01:55:32PM -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > > Yes, we won't change existing helpers, but we can add new ones if we
> > > > need to extend them. That's how APIs work. Yes, they need careful
> > > > considerations when designing and implementing new APIs. Yes, mistakes
> > > > do happen, that's just fact of life and par for the course of software
> > > > development. Yes, we have to live with those mistakes. Nothing changed
> > > > about that.
> > > >
> > > > But somehow libraries and kernel still produce stable APIs and
> > > > maintain them because they clearly provide benefits to end users.
> > >
> > > Did you 'live with mistakes done in libbpf 0.x' ? No.
> >
> > for a long time yes. And it's not apples to apples comparison, with
> > library it is possible to deprecate APIs, which is what we did. With
> > lots of work and gradual transition, but did it.
>
> User space <-> kernel is not an apples to apples comparison with kernel
> <-> BPF programs either. Also, you're using the word "possible" here
> like it's a foregone conclusion. It is "possible" to deprecate BPF APIs
> as well, if we start using kfuncs going forward instead of adding to the
> UAPI boundary.

I'm not sure what to make out of this reply, to be honest. Yes, I
think kernel and libraries are sufficiently different to not draw
direct comparisons. No, I didn't claim anything about foregone
conclusions. I think it's even possible to deprecate BPF helpers, if
we really want to. In the end, technically, the only UAPI part about
BPF helper is it's ID. That should stay fixed. We do change over time
which helpers are available in which program types. Yes, it would be
really bad to change helper signature and I'd be very much against
this, but from my perspective (and I'm sure others will disagree),
it's in the realm of possibility to do gradual deprecation of some
helpers. We'll leave BPF_FUNC_xxx enumerator intact, of course, but
add a simple wrapper that will just -ENOTSUP.

E.g., Linus requested bpf_probe_read() to not exist and not be used,
everyone agreed. Good opportunity?

But really, we are going on so many tangents instead of addressing
specific points. As I said early on in the discussion, this will be a
discussion to exhaustion of one side or the other, unfortunately.

>
> > If we couldn't pull this through, yeah, I would live with whatever
> > APIs are there. And added new ones as a better replacement. As is
> > always done for APIs, nothing new here.
>
> The point is that you had a choice.

The point is that UAPI stability is not the end of the world and
paranoia is bad. We shouldn't get paralyzed because we add APIs. We do
that to libbpf and APIs will stay stable within entire 1.x version.
Yes, we don't have such a nice "luxury" with kernel, but see above.
There are libraries that go to great lengths to keep old APIs, however
broken or inconvenient they are. Yes, it's a pain, but it doesn't
paralyze development.

>
> > Within 0.x and 1.x APIs are stable and we live with them. This API
> > stability fear doesn't paralyze libbpf development, we still add new
> > stable APIs, if they are considered useful and thought through enough.
>
> Nobody is claiming that we can't have stable APIs. We're arguing in
> favor of being able to _choose_ which APIs to deprecate. Using your
> logic, you wouldn't have been able to deprecate _anything_ for fear of
> some user, somewhere being affected by it. I understand the sentiment,
> and I agree that it's very important to have conservative and
> predictable approaches to deprecation. What I don't think is important
> is to provide _indefinite_ guarantees for _all_ APIs between two
> different kernel contexts.
>
> And to reiterate, as I've said a few times now but nobody seems to be
> responding to (unless I missed something), this is for kernel <-> kernel
> programs. We're not even talking about APIs that are available to user
> space. Let's at least be clear about the boundaries for which we're
> debating the merits of stability, because while some user space tooling
> would certainly affected by choosing to freeze BPF helpers, kfuncs and
> BPF helpers are ever invoked by _kernel_ programs.

I'm also for the choice. And freezing BPF helpers removes this choice.
I want to have functionality that won't depend on arch-specific kfunc
support, won't depend on BTF, etc.

Think about it this way (and try to avoid the temptation to point out
imperfections of analogy). How would you feel if Rust added slice
support, and said that it will work in some super basic form
everywhere. But some things, like deriving subslice or checking
slice's size would be  architecture-specific, they will initially work
in Tier 1 supported architectures, maybe or soon they might work on
Tier 2, but unlikely to work on Tier 3, unless someone will do a bunch
of highly technical work and signs up to maintain it going forward.
Does this sound reasonable for something that is a stable and simple
abstraction, which should feel like an integral part of the BPF
framework. It doesn't have any ties into arch-specific details, it
doesn't require debug information to be usable and efficient, etc.
Alas.

Another example. I'm adding BPF open-coded iterators. One of them is
fundamentally an improved (in terms of functionality and ergonomics)
version of bpf_loop() and bounded BPF loop support. It consists of a
black-box struct bpf_iter to keep state and three helpers:
bpf_iter_range_new(), bpf_iter_range_next() and
bpf_iter_range_destroy(). It can be used roughly like this:

struct bpf_iter it;
int N = ..., *v, i;

bpf_iter_range_new(&it, 0, N);
while ((v = bpf_iter_range_next(&it))) {
  i = *v;
  /* use i which will take values from 0 to N-1 */
}

Not too bad, but a bit verbose. I'd like to add a simple macro to help
write this a bit more natural. Right now I know how to do it so that
is looks roughly like this:

bpf_for(i, 0, N, ({
    /* my code using i and any other local variables */
}));

Here's a few concerns if I'm made to do these bpf_iter_xxx() functions as kfunc:

a) I'll have an ability to do this iteration only on architectures
that do support kfunc, which is not *all* architectures that support
BPF. So there are case where I can write some BPF programs, kernel
could be recent enough to support bpf_iter_*() APIs, but I won't be
able to rely on my BPF applications (which is some simple tool that
doesn't need anything fancy from BPF, no BTF, no BPF trampoline, no
nothing, I just want to trace some uprobes and USDTs, fetch some data
from user-space app, do post-processing, maintains few simple ARRAY
and HASH maps, dump data through perfbuf/ringbuf).

Why do I need to explain to customers why they can't use bpf_iter_*()
even if they have a recent kernel? There is no reason for a simple
looping construct to require all this extra baggage. ZERO.

b) I'd like to provide bpf_for() macro from libbpf. Well, whether you
agree or not, but libbpf does provide stable APIs as well. bpf_for()
can't be really stable because bpf_iter_*() funcs are declared
unstable (and if they are stable, then why can't I make them BPF
helpers). If something change, it will be on libbpf to come up with
some creative ingenious work arounds. If they get removed -- oops, too
bad, libbpf.

Also given that kfuncs are not part of bpf_helper_defs.h (and
shouldn't, they are unstable), I'll have to define __ksym definitions
for necessary APIs somewhere in the same header where bpf_for() is
defined. Luckily (I checked, not too lazy to try solve problems
end-to-end, would be happy for someone to reply to my specific request
to do the same, but alas), it's ok to have multiple duplicated externs
__ksym definitions. So it's annoying, but at least not impossible.

I know what will come next: proposal to add some unstable headers and
APIs to libbpf and stuff. It's another discussion, everything is
possible, etc, etc. But I'm hoping that at least some people will
garner a bit of empathy for consequences of these helpers vs kfunc
choices.


Just to reiterate. I have no problem with kfuncs per se. Task struct,
ct, xfrm, whatever other things that are working with kernel objects
-- totally makes sense to have them as kfunc. Totally.

But concepts like dynptr (memory slice), for loop, etc. I see zero,
absolutely zero, reason to dictate that they should be unstable and
arch-specific.

>
> > > You've introduced libbpf 1.0 with incompatible api and some users suffereed.
> >
> > By "suffered" you mean a few systemd folks being grumpy about this?
> > And having to do 100 lines of code changes ([0]) to support two
> > incompatible major versions of libbpf *simultaneously*?
> >
> > On the other hand we got a library with saner error propagation
> > behavior and various API normalizations and additions. Not too bad of
> > a trade off.
>
> This sounds like an argument in favor of why it is acceptable to
> deprecate some things? Why are some users allowed to feel "pain" (a term
> you've used in other threads), but other users who are affected by your
> choices are just "grumpy"? Also, what about the myriad hypothetical
> users you've never heard of (the ones who we're really protecting with
> UAPI) who had to deal with breaking API stability changes?

I think you are twisting what I'm arguing for. I didn't say that
everything should be stable, did I? I'm saying some things should be
stable, like dynptr and for loop iterator.

As for the libbpf deprecation process. I'm happy to discuss how it
went and what could have been done better. But I don't think this
thread is the place to discuss this. Please, ping me offline or start
a separate thread.

>
> > Sure, deprecation is not easy or free, there was a lot of prep work,
> > and some users had to adjust their code to use new APIs. But this is
> > quite a tangent.
>
> I don't see how this is tangential to the discussion -- it seems very
> relevant. From my perspective, the core of the discussion has been
> whether it's acceptable to shift _any_ of the burden of API stability to
> users. My point, and I believe Alexei's point as well, is that the
> answer is "it depends and it's a tradeoff", as you've essentially said
> here.

Interesting. Alexei is saying "no more BPF helpers", and that has all
the consequences I outlined above (and probably more I haven't thought
about). Daniel is asking to have this "it depends" option by not
taking such a hard line on BPF helpers freeze.

From my perspective, the core of the discussion is whether stability
of UAPI is the paramount issue that overshadows everything else or
not. Me and Daniel are saying no, you and Alexei are arguing yes.

>
> What I'm failing to understand is why your argument that there are
> tradeoffs applies here, but not for kernel <-> BPF kernel programs? I'm
> genuinely trying to understand what the distinction is, because from
> where I'm sitting it feels like we're being selective about when the
> unknown _threat_ of API instability automatically completely overrides
> our ability to choose our own deprecation and stability story (a
> stability story which is informed by our perception of an API's
> importance, usage, etc).

There is some misunderstanding obviously. I'm all for flexibility and
considering tradeoffs. But dictating "no more BPF helpers" is not
that, it's the opposite of that. And yes, I do not believe that UAPI
stability is the most important and the only aspect that should be
taken into consideration.

I really hope that specific points about dynptr and for loop iterator
help you understand my position. It's not even so much a stability
(though that matter for core concepts, obviously), but rather all the
incidental complexities, dependencies, and limitations that come with
kfuncs (and some, like arch-specific support, are fundamental; while
others, like detecting their support are currently big hurdles, but
could be solved; and let's solve them first, before taking these hard
stances, not the other way around).

>
> Note that my point here applies to something you've raised on other
> threads as well, such as on [0] where you (reasonably) reiterated this
> point:
>
> [0]: https://lore.kernel.org/all/CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com/
>
> > But again. Let me repeat my point *again*. BPF helpers and kfuncs are
> > not mutually exclusive, both can and should exist and evolve. That's
> > one of the main points which is somehow eluding this conversation.
>
> This is one of the big disconnects for me. If you argue that both BPF
> helpers and kfuncs can and should continue to coexist indefinitely, it
> feels like you're arguing for two incompatible points (and please
> correct me anywhere that I'm unintentionally misrepresenting your
> perspective here):
>
> - On the one hand you're arguing that in some cases, _no_ API
>   instability is acceptable. That in general, the main kernel <-> kernel
>   BPF program API boundary is equivalent to UAPI, and that it's _never_
>   acceptable for us to ever, _ever_ deprecate certain APIs because

you are being hyperbolic and overdramatic again for no good reason,
"ever, _ever_" -- really? There is no such thing.

>   _some_ users may be using them, and the possibilty of APIs ever
>   changing or being deprecated will impose an unacceptable pain to users
>   which will make it too difficult to build tooling and, and end up
>   discouraging adoption onto BPF. It seems that you've been making
>   making this argument in favor of what you consider to be "core" BPF
>   helpers such as bpf_dynptr_is_null(), etc.
>
> - At the same time, on the other hand, you're arguing that _some_ of the
>   API boundary between kernel <-> BPF program can be unstable. That it's
>   acceptable for _some_ users and _some_ tooling to feel the pain of
>   certain APIs changing. To perhaps extrapolate your point a bit
>   further, you're arguing that niche / non-core kfuncs can be unstable,
>   and that we don't have to worry about the unknown, hypothetical user
>   who would feel pain from having to deal with them being deprecated,
>   because they're not "core".
>

Yes, but I don't see the contradiction. If BPF map abstraction and its
API was declared unstable (and made arch-specific, this is not a small
detail which you conveniently want to ignore below), I as a user would
think twice before using them. Depends on the situation and what I'm
trying to do. Developing some app within Meta internally -- should,
I'd probably still go for it. But building some tool like perf or
retsnoop -- I'd think twice if I want to take dependency on BPF map
(or dynptr for that matter), if it potentially limits the
applicability of my application.

But when we think about kfuncs that work with kernel object
(task_struct, sockets, whatnot), yes, it's reasonable that we in BPF
can't guarantee stability of those (though I'd very much hope that we
wouldn't willy-nilly keep changing them for no good reason and do
reasonable effort to isolate end users from some reasonable underlying
changes to how task/socket/etc are handled within kernel). If tomorrow
the kernel decides to drop socket abstraction, I don't think BPF
subsystem should "emulate" it somehow (though even that depends, tbh).

So yes, I don't see contradictions. With BPF map, dynptr, (some)
iterators -- BPF controls its destiny, it can and should provide an
unassuming interface, abstractions, APIs and stick to supporting them
and not dictating arbitrary extra dependencies.

> Assuming that's all true, my question is:
>
> Why not just give ourselves the _option_ of being able to deem those
> core helpers as being indefinitely stable for the foreseeable future,
> and keep the unstable kfuncs to have the same stability guarantees as
> what they have today? In terms of _stability_ specifically (so ignoring
> other concerns you've raised, such as that we need BTF and BPF
> trampoline support for kfuncs -- not because they're irrelevant, but
> just to keep the discussion focused on stability), what do we gain by

Quite convenient to ignore very important limitations, of course. But
hopefully I addressed your question above?

> keeping the "core" / "stable" functions as BPF helpers, instead of just
> making them "super stable" kfuncs? At least then we have the option in
> the far-far-far future to deprecate them if they eventually, way later,
> become 100% obsolete. Plus you get the other benefits that Alexei
> mentioned such as potentially being able to backport them to older
> kernels by including them in modules, etc.
>
> Note that I'm not saying with 100% conviction that we don't have _any_
> work to do before freezing helpers (though IMO we should just rip the
> bandaid and do it now), but I am arguing with strong conviction that
> once any of that precursor work is taken care of, there is no reason to
> use BPF helpers in place of kfuncs. At least, that's how I see it at
> this point.

I disagree about ripping the bandaid and precluding dynptr framework
to be whole before we solve various problems I pointed out in [1]
(which unfortunately was mostly ignored, it seems).

And for the "for loop iterator", I absolutely do not want to have a
useful generic abstraction for repeatable loop, that will have few
asterisks associated with them, dictating which arches and what kernel
config values (beyond basic BPF ones) should be ensured to make
iteration work. Kills any motivation to finish it. Imagine if HASH map
didn't work on some new minor platform, even though basic BPF works
there. How does that sound to you?

  [1] https://lore.kernel.org/all/CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com/

>
> >   [0] https://github.com/systemd/systemd/pull/24511/
> >
> > >
> > > > We'll get the same amount of flame when we try to change kfunc that's
> > > > widely adopted.
> > >
> > > Of course. That's why we need to define a stability and deperecation
> > > plan for them.
> >
> > Lots of things that need to be defined and figured out, but we are
> > already quick to freeze BPF helpers.
>
> I agree with you that it would be prudent for us to iron some of this
> out more concretely. In this discussion it seems like one of the key
> points of contention has been around stability, and that the lack of a
> concrete policy for kfuncs has largely (but not completely) been the
> cause for concern. Perhaps it would help clarify things if someone
> submitted a patch set that included a more formal kfunc stability
> proposal?

Stability isn't the only concern, hopefully I made this clear above.
