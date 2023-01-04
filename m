Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B473265DC52
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbjADSoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 13:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjADSoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 13:44:07 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3071C117
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 10:44:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kw15so84673315ejc.10
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 10:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dw6q9oJA2i7kwiulIZ7r9BD7KzkOwf352wXKdhiAXM8=;
        b=RJB2x37wGpNwN5v6yjPpK0D2NyLVM5VbSS2XMuWhFszMWxTOWYQ/lqnf6QT8r9AKDo
         F2C+Wg6m8vfRNL+eXYEddZKf2HQHmlhvGPoP/B3UvcSmF26xDg/X3YyTbBhPSDsTqEGX
         5zCHLWRTCppwfncHbUvrUtb3c8awgM39iZMcGwQ+ksRqeeXaTwgxfgJBI1tap8Lh3zwG
         4YEyYxHL6yXfFy3xQsYcnE3cvQzUmiKNmRaA8J1CRPJnYgxdx/4uQOvBH4G4cryvuHzi
         FnKFgFMiiUG6Lng2AycDHYYMIIq9GjVqgzF6AAdjCNqNyaFZwDzFDJxAJLFRMaLSyjbn
         GfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dw6q9oJA2i7kwiulIZ7r9BD7KzkOwf352wXKdhiAXM8=;
        b=e/hN6ErNNab8vLWia3i6na8xbWKGFwWMwZTVFt3snwNfJhfWh+6rhN/CHQkcgMN5T6
         4cPhlOPvrkmaXrfskp6zqYazzEyC49nChD6Kfn3Rsw3JzvX3HEORrmGU8QTDLVGh4TF9
         mZhZobq7HlAMCQlhgnA7lUV44WxZf2iIpUaTas0kd3tSl5juYPen45L8dxVZNPedrh/p
         2j4VHAVcZ3ufyoitUdHx3Lr7E91re7C3CpVKkjlK1raRHzAQGuQq5zz3aCFqPcc59sUT
         UFVjTf+SscF/OVQ/m2wYUi7/Go6hHyjgDZtPRIHNwgTY3uXrfsKo2lOWZvoFgoTUNG0U
         NYqA==
X-Gm-Message-State: AFqh2kpkbfJv9MWrAUbj1YmUkkuERIPcLjNnpbmqnZNfcFjY0wPcBrS0
        ekHrrWInJBDUz8uY5RCGbzy64QXPc2fpjLwDXjw=
X-Google-Smtp-Source: AMrXdXun3wvdA0hUZnKSrWCTdIu9ACoyffu1fa9XCprlcaTsrjciJnEjcoKVcXkqpmCYoGQg5/AuDweLUN2X5ddKN7E=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr3749160ejr.115.1672857844211; Wed, 04
 Jan 2023 10:44:04 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local> <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com> <Y69RZeEvP2dXO7to@maniforge.lan>
In-Reply-To: <Y69RZeEvP2dXO7to@maniforge.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 10:43:52 -0800
Message-ID: <CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com>
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

On Fri, Dec 30, 2022 at 1:00 PM David Vernet <void@manifault.com> wrote:
>
> On Fri, Dec 30, 2022 at 11:31:12AM -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 30, 2022 at 12:38:55PM -0600, David Vernet wrote:
> > > On Thu, Dec 29, 2022 at 06:46:41PM -0800, Alexei Starovoitov wrote:
> > > > On Thu, Dec 29, 2022 at 03:10:22PM -0800, Andrii Nakryiko wrote:
> > > > > On Sun, Dec 25, 2022 at 1:52 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >

[...]

> I don't think the fact that we'll never be done is a valid counterpoint
> to "are we ready now"? The first iteration of kfuncs was definitely not
> in a good enough state to freeze all helpers. The usability of kfuncs
> has improved drastically since then. The question isn't "when will be at
> a complete stopping point?", it's, "are we sufficiently ready now?".
>
> > It's a bit of wishful thinking that addressing today's problem will somehow
> > make everything nice and clean and then we will be ready to stop adding helpers.
> > We'll keep improving the infra for years to come.
> > There is no "end of the road" sign.
>
> Yes, there's no end of the road, but my point is that there are still
> pieces that we know we need to change, and which we know are temporary
> (__sz and __k being the main examples).
>
> *That being said*: I completely admit that this is all subjective. From
> a technical standpoint, there is nothing stopping us from freezing
> helpers. And honestly, I don't disagree with you that getting out of
> UAPI immediately and forever is a huge positive; possibly even to the

"huge positive" for whom? for happy kernel engineers that only care
about the latest version of everything in BPF selftests or
samples/bpf? Sure. But let's think about poor end user. Let's as a
hypothetical and trivial example think about dynptr and
bpf_dynptr_is_null(). Basic dynptr is usable in earlier kernel release
than bpf_dynptr_is_null() helper, so you could write BPF app that will
do some work-arounds without using bpf_dynptr_is_null() on old kernel,
but happily switch to new helper/kfunc, if available. With BPF helpers
I can detect this on BPF side completely transparently to user-space
part of my app:

struct bpf_dynptr dptr = ...;
bool is_null = false;

if (bpf_core_value_exists(enum bpf_func_id, BPF_FUNC_dynptr_is_null)) {
    is_null = bpf_dynptr_is_null(&dptr);
} else {
    struct bpf_dynptr_kern *kdptr = (void*)&dptr;
    is_null = !!BPF_CORE_READ(kdptr, data);
}

How do you detect the existence of kfunc today? Preferably without
doing extra work in user-space.

Now, let's say kfunc changes its signature. Show me a short example on
how you deal with that in BPF C code?


Think about sched_ext. Right now it's so bleeding edge that you have
to assume the very latest and freshest kernel code. So you know all
the kfuncs that you need should exist otherwise sched_ext doesn't work
at all. Ok, happy place.

Now a year or two passes by. Some kfuncs are added, some are changed.
We still believe that BPF CO-RE (compile once - run everywhere) is
good and we don't want to compile and distribute multiple versions of
BPF application, right? You'll want to do some extra (or more
performant) stuff if kernel is recent and has some new kfunc, but
fallback to some default suboptimal behavior otherwise. How do you do
that in a simple and straightforward way? But even worse is what if
some critical kfunc is changed between kernel versions and you do
*need* to support both versions. Think about those aspects, because
sched_ext will run into them almost inevitably soon after its
inclusion into kernel.


One way or another there are some technical solution of various
degrees of creativity. And I'm actually not sure if I have a solution
for kfunc signature change at all. Without BTF we could use two
separate .c files and statically link them together, which would work
because extern is untyped in pure C. But with BPF static linking we do
have BTF information for each extern, and those BTF types will be
incompatible for the same extern func.

We can probably come up with some hacks and conventions, as usual, but
better start thinking about them now.

But hopefully you can empathize a bit more with poor end users that
have to do hack like this and why having bpf_dynptr API defined as
stable BPF helpers, with no extra dependencies on BTF in kernel, on
kfunc support for architecture, and whatever other hidden dependencies
we all forgot or haven't thought about yet (believe me, there will
always be users trying to do something on some embedded system with
"unusual" kernel configs or architectures).


But again. Let me repeat my point *again*. BPF helpers and kfuncs are
not mutually exclusive, both can and should exist and evolve. That's
one of the main points which is somehow eluding this conversation.

> point that it warrants us just doing it now. More below.
>
> >
> > > 4. Getting rid of KF_TRUSTED_ARGS and making that the default.
> >
> > We've been talking about this possibility for months.
> > Are you suggesting to keep adding helpers for another year or so?
>
> I think that kfuncs should be the norm for the vast majority of things
> being added, and hopefully for everything (I'm going to walk back my
> suggestion of adding these new dynptr functions as helpers). Honestly,
> my point was really just that I think the API for defining kfuncs needs
> to be improved before we can totally and completely freeze helpers due
> to the fact that we have __sz and __k, and don't have a consistent
> documentation story. That being said, __sz and __k are there, they work,
> and as you and I have both said at this point, whether or not they're
> "blockers" is subjective.
>
> So my answer to your question of "should we add helpers for another year
> or so" in my last reply would have been "absolutely not, unless we truly
> have no choice because of the lack of per-arg flags". After reading your
> reply, if you're worried that that policy won't be strictly enforced
> (meaning that we'll end up having to add helpers that easily could have
> just been kfuncs) then I agree that we should just do the hard freeze
> now. We've de-facto been doing that anyways for the last year.
>
> That being said, I really would hope that we could at least get some of
> the documentation story figured out. Even if it's just something as
> simple as spelling out a formal policy on our kfuncs docs page
> stipulating that you have to add a doxygen header and link it from a
> docs page, it would be nice to have some policy that puts kfuncs on a
> road to being as well documented as helpers.
>
> > We already have 91 kfuncs and 211 helpers.
> > If we were not asking all developers to use kfuncs we would have had 300+ helpers.
>
> Agreed that this would have been a _very_ unfortunate outcome.

Again, this is a wrong dichotomy. Just because there are 91 (out of
which 25-ish are test-only kfuncs that should really be in
bpf_testmod, but somehow that doesn't bother anyone) kfuncs, doesn't
mean they would have to all be done as BPF helpers. dynptr is stable
generic concept, it should be done as BPF helpers. ct, xfrm, hid-bpf
are interfaces to kernel objects, they are perfectly fit with kfunc.

There is no contradiction there. Just some questionable conclusions.

>
> >
> > > 5. Ideally we could improve the story for _defining_ kfuncs as well,
> > > though IMO it's already far less painful than defining helpers. It would
> > > be nice if you could just tag a kfunc with something like a __bpf_kfunc
> > > macro and it would do the following:
> > >
> > > - Automatically disable the -Wmissing-prototypes warning. I doubt this
> > >   is possible without adding some compiler features that let you do
> > >   something like __attribute__(__nowarn__("Wmissing-prototypes")), so
> > >   maybe this isn't a hard blocker, but more of a medium / long-term
> > >   goal.
> > > - Add whatever other attributes we need for the kfuncs to be safe. For
> > >   example, 'noinline' and '__used'. Even if the symbols are global,
> > >   we'll probably need '__used' for LTO.
> >
> > would be nice, but that didn't stop existing 91 kfuncs to appear
> > and already used in production.
> > Yes. kfuncs are already used in production.
>
> This is something that would literally only take like 1-2 patches
> anyways. I'm happy to do it so we don't have to waste cycles thinking
> about it as a blocker for anything.
>
> >
> > > Overall, my point is really that we still have some homework to do
> > > before we can just unilaterally freeze helpers. We're getting close, but
> > > IMO not quite there yet.
> >
> > 91 vs 211 tells a different story.
>
> Yeah, the fact that we have 91 kfuncs is strong evidence that kfuncs are
> already in a good-enough place to just freeze helpers.
>
> Another counterpoint to my initial claim that not having per-arg flags
> could be problematic is that there are certain things that are global in
> kfuncs that are also global in helpers despite having per-arg modifiers.
> For example, the fact that you can only have one OBJ_RELEASE argument.
> And yet another is the fact that none of the helpers we've added in the
> last year relied on having per-arg modifiers, so in practice it hasn't
> been a problem.

You are conflating "single flag per func" with "which arg it belongs
to doesn't matter". There could be only one OBJ_RELEASE, but we need
to know which argument it applies to. Sure, today we take a shortcut
and say it should apply to the only ref_obj_id-enabled argument.

But think about some hypothetical kfunc:

int do_something_weird(struct bpf_dynptr *dptr1, struct bpf_dynptr *dptr2)

If it has OBJ_RELEASE, which arg (dptr1 or dptr2) it applies to?

OBJ_RELEASE is still an argument flag.

>
> I think it's fair to say that if you just look at the data instead of
> from an "API cleanlines" perspective, having per-arg modifiers is not a
> blocker. Data wins over subjectivity, so as mentioned above, I'm willing
> to change my mind about per-arg modifiers being a blocker, especially
> with __sz and __k.
>

[...]

> > > I'm not sure whether that's enough to warrant making them helpers
> > > instead of kfuncs, but I do think it's not exactly an apples to apples
> > > comparison with future features that today have no helper API presence.
> > > Putting myself in the shoes of a dynptr user, I would be very surprised
> > > and confused if all of a sudden, I couldn't use some of the core dynptr
> > > APIs due to being on a platform that doesn't have kfunc support. My two
> > > cents are that letting these dynptr functions stay as helpers, while
> > > agreeing that kfuncs is the way forward (though I don't think Andrii
> > > agrees with that even aside from just these dynptrs) is a reasonable
> > > compromise that errs on the side of user-friendliness for dynptr users.
> >
> > We already have this 'discrepancy' of both kfuncs and helpers for kptrs
> > (bpf_obj_new vs bpf_kptr_xhcg) and so far no complains.
> > Why dynptr is special?
>
> Well, lack of usability in one case doesn't necessarily mean we should
> allow it in another. That said, the "usability" gains from having a
> helper really are minimal to the point of practically being negligible
> anyways.

Depends on perspective. If I was some humble dev trying to build
BPF-based tool that should work on x86, arm64, s390x, and riscv (or
whatever other architecture), and dynptr API is only based on kfuncs,
I'm screwed. I can't sponsor or do kfunc support for my favorite
architecture, I'm stuck waiting for this to be done by someone some
time, if ever.

And all because we arbitrarily decided not to do BPF helper.

From a good engineering perspective, if some functionality doesn't
require dependency X to work in principle, it shouldn't depend on that
feature X. Even if feature X is beloved BTF.

>
> Part of me was trying to find a compromise here to move forward, but
> honestly, I do agree with you that we should aggressively make
> everything a kfunc unless we have a good reason not to, dynptr functions
> included. So I'm willing to walk this suggestion back as well -- let's
> just make these kfuncs.

How about the policy of "let's use common sense and decide on what's
best in each particular case"? Isn't that the best policy? Blanket
statements and hard-defined rules are easy to follow, but they do not
produce best outcomes (IMO).


>
> > > FWIW, I also don't think it's fair or logical to argue at this point in
> > > the game that dynptrs as a concept is inherently flawed. They were super
> > > useful for enabling the user ringbuf map type, which is a key part of
> > > rhone / user-space scheduling in sched_ext, and I wouldn't be surprised
> > > if ghOSt started using it as well as a way to make scheduling decisions
> > > without trapping into the kernel as well. Also, the attendees at LSFMM
> > > generally seemed enthusiastic about dynptrs and user ringbuf, though I
> > > admittedly don't know who's using either feature outside of rhone.
> >
> > rhone doesn't have stability guarantees just like sched-ext doesn't have them.
> > To drive that point rhone and sched-ext should really be using kfuncs.
> > Otherwise somebody might point the finger at helpers and argue that
> > this is somehow makes sched-ext stable.
>
> Also a reasonable point. My point above was really just a response to
> your claim in [0] that dynptrs are flawed. It wasn't related to kfuncs
> vs. helpers.
>
> [0]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/
>
> >
> > > That being said, to reiterate, I personally agree that once we take care
> > > of a few more things for kfuncs , they're 100% the way forward over
> > > helpers. BPF programs are kernel programs, no UAPI pain should be
> > > necessary.
> >
> > Similar arguments were made during sk_buff freeze... let's add few more fields
> > that are going to be sooo useful and then we'll freeze sk_buff...
> > dynptr is trying to be that special snow flake.
>
> The main points of my initial response were not about dynptrs, they were
> about how we define kfuncs. I agree there is nothing at all special
> about dynptrs beyond the fact that they as a feature already have
> helpers. Sure, let's add them as kfuncs. No reason to be beholden to the
> UAPI restrictions.
>
> >
> > bpf_rcu_read_lock was added as a kfunc. It's more fundamental than dynptr.
> > bpf_obj_new is a kfunc too. Also more fundamental than dynptr.
> > What is so special about dynptr that we need to make an exception for it?
>
> See above.
