Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E349662DA2
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjAIRu2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 12:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbjAIRtK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 12:49:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F846574EB
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 09:46:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u19so22005536ejm.8
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L03Xwhfs5L9gskLNW9fzjk1kC/HiwVznecpYygYPo+M=;
        b=NV/Nlo0HJeOtivuZuRKEJ/u4Ic/wGzgNxWfBOJlGuRDVtzagAi3O5tEoiaiGgTVKPf
         1R5o+i9mbEnDPPQk0w7RaG5hKwq2EQo4c5dxKMe5qsT2+dt2tkKQyArw6QuqzDkvLMgq
         bccGE8S41Ch2QK6eJgaXfhk1IWna5hFC4/LLIqxKxTKT2jZ/l3siCqhuH/ojushjBlW3
         d2omp7AWMSNEcAzjDM8RJc0rN+Xp1Pv/kj2GDN9OajjeTLgKI15ceuBdfIwAlLMRWl1U
         VV4QhFmjjWDZOeZJYdjK3RDoKk0biW7Vcc2Bqlp7ouNKOaSwn9yBKznW4CkjyhETMrDM
         uysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L03Xwhfs5L9gskLNW9fzjk1kC/HiwVznecpYygYPo+M=;
        b=MRGP61Ym3LHJm9sDF75gkc7VeSShBBgz/v/o0pl322P5DAqQx6y5t+A6rTDPpp7w7N
         4NRce+nqwujc6LMl4+fBe7ixRo5gWJJ/LEJw2oFfvG2OhCIYZdg6AT6bo1nWhKTsui5R
         5AlzivYiS+RuftKrkImfaeAczCt4eE0O4zKSklUcBktvNbQPRulNRpb9cm++2+sLXVR9
         AIQVIyi4Kvvxda+xu05qJkUXd6U0cDljaKSziVcR/DFlpk+Po5zM7dpTxX9gfzW+1Gsq
         s89tgv7IF+1EqPAeIKUy+dxCvScq/zLimDk/sB/h6hMzN8dWwrTvmk2OlVQsdVYudU/B
         Krhg==
X-Gm-Message-State: AFqh2koXclgPkPw6nomye2FIq0F/WKdjXkSJ4B7oUtQEVh6cSnwL7bb9
        fmtWbAndiYhbrUC19lFJx11Kv7nOAzpza5nFq9E=
X-Google-Smtp-Source: AMrXdXstff9yDQt7SPWDYZrg18s4nJIRowhRLUoACGzbFoBa6Eti5Q+emFVNAZIg9G+I9iNVM/3R6UnlpeFYX3s5/UI=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr5064834ejr.115.1673286400544; Mon, 09
 Jan 2023 09:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local> <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
 <Y7YQHC4FgYuLWmab@maniforge.lan> <CAEf4BzaJ4h4o+nrApBPABZ8zu-f+TpuV4FUvEfHsrLRsu1bObw@mail.gmail.com>
 <20230106025420.6xdhhjsknhdhbu3d@MacBook-Pro-6.local>
In-Reply-To: <20230106025420.6xdhhjsknhdhbu3d@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Jan 2023 09:46:28 -0800
Message-ID: <CAEf4BzZTYcGNVWL7gSPHCqao_Ehx_3P7YK6r+p_-hrvpE8fEvA@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
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

On Thu, Jan 5, 2023 at 6:54 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 05, 2023 at 01:01:56PM -0800, Andrii Nakryiko wrote:
> > Didn't find the best place to put this, so it will be here. I think it
> > would be beneficial to discuss BPF helpers freeze in BPF office hours.
> > So I took the liberty to put it up for next BPF office hours, 9am, Jan
> > 12th 2022. I hope that some more people that have exposure to
> > real-world BPF application and pains associated with all that could
> > join the discussion, but obviously anyone is welcome as well, no
> > matter which way they are leaning.
> >
> > Please consider joining, see details on Zoom meeting at [0]
> >
> > For the rest, please see below. I'll be out for a few days and won't
> > be able to reply, my apologies.
> >
> >   [0] https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit#gid=0
>
> Thanks for adding it to the agenda.
> Hopefully we'll be able to converge faster on a call.

Yep, hopefully. Looking forward to BPF office hours this week.

>
> There are several things to discuss:
> 1. whether or not to freeze helpers.
> 2. whether dynptr accessors should be helpers or kfuncs.
> 3. whether your future inline iterators should be helpers or kfuncs.
> 4. whether cilium's bpf_sock_destroy should be helper or kfunc.
>
> If we hard freeze helpers in 1 it automatically decides the fate for 2, 3, 4.
> We can soft freeze the helpers then 2,3,4 are up for discussion.
> Looks like the thread so far was primarily about 1.

The thread started as 2 and got expanded to 1, but I agree that 2, 3,
and 4 are all separate topics (just predicated on 1 being decided in
favor of not freezing helpers).

> 4 was touched separately. Daniel hasn't replied yet to my suggestion for it to be kfunc.
> You insist that 2 and 3 must be helpers.
> No one seen the patches for 3. I've seen you whiteboard them. It's impossible
> for others to participate without patches, so let's postpone that.

Sure, as I intended to do in [0], except if BPF helpers are
hard-frozen, there would be no discussion to have. But hopefully it's
clear that my example with iterators was about stability and
generality of certain concepts (looping) and how libbpf has stable API
expectations and responsibilities as well.

  [0] https://lore.kernel.org/bpf/CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com/

>
> Let's try to focus this thread on 2 assuming both helpers and kfuncs
> are on the table for dynptrs...
>
> > conclusions. I think it's even possible to deprecate BPF helpers, if
> > we really want to. In the end, technically, the only UAPI part about
> > BPF helper is it's ID. That should stay fixed. We do change over time
> > which helpers are available in which program types. Yes, it would be
> > really bad to change helper signature and I'd be very much against
> > this, but from my perspective (and I'm sure others will disagree),
> > it's in the realm of possibility to do gradual deprecation of some
> > helpers. We'll leave BPF_FUNC_xxx enumerator intact, of course, but
> > add a simple wrapper that will just -ENOTSUP.
>
> Unfortunately you're completely wrong in the above paragraph.
> I suggest to read this Linus's rant first:
> https://lkml.org/lkml/2012/12/23/75
>
> Everything that user space sees we cannot change.
> We can try to, but it will be reverted if users complain.

I very well might be and it was my opinion (which I explicitly
acknowledged as certainly being controversial).

This is a completely separate discussion, but on one hand we say it's
fine to remove or change kfuncs, because kfuncs are only visible to
BPF programs, which are kernel-to-kernel programs and user-space rules
do not apply. On the other hand, BPF helpers are also only visible to
BPF programs, the only user-space visible part is enum name and ID.
Yet they are treated very differently.

It's fine, but to me it's more of an issue of a user contract, rather
than some technicality about being defined in some header. It feels
like we should be able to define a contract that some range of IDs
will be "unstable" in the sense that they might start eventually
returning -ENOTSUP if we have reasonable confidence they are not
useful anymore.

But it's just my opinion, and no amount of shouting at me will change that fact.

And as I said before, I don't think BPF helpers are a big maintenance
liability in the first place.


> That's why we never try unless there is a very strong reason like security issue.
>
> For example your last commit to uapi/bpf.h
> commit 8a76145a2ec2 ("bpf: explicitly define BPF_FUNC_xxx integer values")
> is a leap of faith.
> Though we tried to make it as transparent as possible and
> I googled BPF_FUNC_MAPPER before applying the patch to see in what weird ways
> people can use the macro, there is still a non zero chance that
> we would have to revert it if users complain loud enough.
>
> For example cilium has this bit of code:
> https://github.com/cilium/ebpf/blob/master/asm/func.go
> I suspect it's broken now, because you've changed 'FN' macro in that commit.
> Cilium folks are unlikely to complain and demand a revert, so we should be safe
> in this regard, but we cannot assume that for other users.

Sure, all above is true and we discussed all that when reviewing that
patch. And I liked that we could weigh pros and cons in that
particular case, and hopefully can keep doing that.

>
> It should be obvious that we cannot deprecate helpers with ENOTSUP
> or deprecate them in any other way.

I'm fine with that.

>
> > E.g., Linus requested bpf_probe_read() to not exist and not be used,
> > everyone agreed. Good opportunity?
>
> It's an exception that proves the rule.
> 1. it's a security issue that's why uapi breakage was on the table.
> 2. it wasn't completely removed. See:
>
> #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         case BPF_FUNC_probe_read:
>                 return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
>                        NULL : &bpf_probe_read_compat_proto;

Sure, not disputing this. I do think that it's just another example
emphasizing that the world is not black and white and there *has* to
be nuance in every decision.

>
> > The point is that UAPI stability is not the end of the world and
> > paranoia is bad. We shouldn't get paralyzed because we add APIs. We do
> > that to libbpf and APIs will stay stable within entire 1.x version.
> > Yes, we don't have such a nice "luxury" with kernel, but see above.
>
> Exactly. See above. There is no way at all to deprecate helpers.

OK.

>
> > >
> > > - On the one hand you're arguing that in some cases, _no_ API
> > >   instability is acceptable. That in general, the main kernel <-> kernel
> > >   BPF program API boundary is equivalent to UAPI, and that it's _never_
> > >   acceptable for us to ever, _ever_ deprecate certain APIs because
> >
> > you are being hyperbolic and overdramatic again for no good reason,
> > "ever, _ever_" -- really? There is no such thing.
>
> Andrii, it's really _ever_. You need to internalize that first
> before we discuss this topic again during office hours.

I'll try to. My point (somewhat subtle, perhaps) was that humans are
very bad about planning 5-10-20-50 years ahead. So any "ever" is
overdramatized and hyperbolic. There might be no BPF, Linux, or
computers in current form in 50 years. I refuse to stress about not
being able to remove BPF helpers in 50 years, sorry.

>
> > I'd probably still go for it. But building some tool like perf or
> > retsnoop -- I'd think twice if I want to take dependency on BPF map
> > (or dynptr for that matter), if it potentially limits the
> > applicability of my application.
>
> A quote from retsnoop readme:
> "
> NOTE: Retsnoop relies on BPF CO-RE technology, so please make sure your Linux
> kernel is built with CONFIG_DEBUG_INFO_BTF=y kernel config. Without this
> retsnoop will refuse to start.
> "
> and in calib_feat.bpf.c
> /* Detect if bpf_get_func_ip() helper is supported by the kernel.
> /* Detect if fentry/fexit re-entry protection is implemented.
> /* Detect if fexit is safe to use for long-running and sleepable
> /* Detect if bpf_get_branch_snapshot() helper is supported.
> /* Detect if BPF_MAP_TYPE_RINGBUF map is supported.
> /* Detect if BPF cookie is supported for kprobes.
> /* Detect if multi-attach kprobes are supported.
>
> If the feature is useful you will use it. In retsnoop and everywhere else.
> Regardless whether it's arch dependent, kernel dependent or unstable.

But I'm just a hostage of these BPF quirks and I very much would like
not to be (or at the very least minimize them)! Do you think I'm happy
that retsnoop won't work on so many different kernel configs and
arches, even though retsnoop would be very useful there? I'm happy I
don't make money off of retsnoop, so I can afford to just say "sorry,
retsnoop won't work in your particular situation, too bad". But if I
had a company and some product that relied on BPF, any such hurdle
would be painful and result in extra support, maintenance, developer
work, lost opportunity, hurdles in adoption, just headaches.

"If the feature is useful you will use it" is missing the nuance
again. Almost every feature can be worked around. And if some feature
adds too many unnecessary complexities and/or dependencies, I might
choose to just work around it. Or use some older feature that's less
convenient, less performant, maybe more fragile, but works.

E.g., instead of using bpf_ringbuf_reserve_dynptr() to minimize amount
of data sent over ringbuf, I'll choose to do bigger fixed-sized chunk,
lose efficiency, but not reduce a variety of kernels and systems that
my app will work on. But in some other situation this extra efficiency
might be the difference between product viability and death, so yeah,
I'll take that hit and do the extra work.

But again, as a BPF user I will feel as a hostage, knowing that it
didn't *have* to be this way.

That's why I'm fighting so passionately *to not add unnecessary
dependencies and complications*.

>
> > I disagree about ripping the bandaid and precluding dynptr framework
> > to be whole before we solve various problems I pointed out in [1]
> > (which unfortunately was mostly ignored, it seems).
>
> Let's look at your
> https://lore.kernel.org/all/CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com/
> "
> 1. Generic accessors to check validity of *any* dynptr, and it's
> inherent properties like offset, available size, read-only property
> (just as useful somethings as bpf_ringbuf_query() is for ringbufs,
> both for debugging and for various heuristics in production).
>
> bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> long bpf_dynptr_get_size(struct bpf_dynptr *ptr)
> long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
> bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
>
> There is nothing to add or remove here. No flags, no change in semantics.
> "
>
> You're arguing that it's obviously stable material.
> Like:
> +BPF_CALL_1(bpf_dynptr_get_offset, struct bpf_dynptr_kern *, ptr)
> +{
> +    if (!ptr->data)
> +         return -EINVAL;
> +
> +    return ptr->offset;
> +}
>
> but we can do it now in native bpf code:
>
> static inline int bpf_dynptr_get_offset(const struct bpf_dynptr *uptr)
> {
>      struct bpf_dynptr_kern *ptr = bpf_rdonly_cast(uptr, bpf_core_type_id_kernel(struct bpf_dynptr_kern));
>
>      if (!ptr->data)
>           return -EINVAL;
>
>      return ptr->offset;
> }
>
> No kernel changes necessary. No UAPI helpers. No kfuncs.
> CO-RE will take care of kernel version differences.
>
> Do you still insist that it should be a stable uapi helper ?

Yes!

bpf_rdonly_cast() is kfunc, with all the consequences. And we are not
just exposing internal implementation details of dynptr, we *expect*
users to know, care, and follow them. Neither is great.

These simple helpers I can implement with BPF_CORE_READ() even,
without kfunc dependency, as I already explained before. And it will
even work on kernels with no CO-RE support, thanks to BTFgen.

But I do not consider that a good approach and good API, sorry.
Certainly doesn't make me feel like dynptr is a core first-class
concept in BPF.


And I actually have no such solution for
bpf_dynptr_clone()/bpf_dynptr_advance()/bpf_dynptr_trim(), which is
absolutely critical to make dynptr a standard interface for passing
variable-sized chunks of memory to other helpers and kfuncs.

>
> > And for the "for loop iterator", I absolutely do not want to have a
> > useful generic abstraction for repeatable loop, that will have few
> > asterisks associated with them, dictating which arches and what kernel
> > config values (beyond basic BPF ones) should be ensured to make
> > iteration work. Kills any motivation to finish it.
>
> I'm really sad that you went down this ultimatum path.

This wasn't my intent and that's not what I'm doing here. I'm
explaining my motivation and how I feel about core concepts being part
of stable BPF API offerings. And how the inflexible BPF freeze
approach will hurt adoption. And yes, I'm afraid it might hurt even
the addition of new features if people feel that their work can't be
used universally because of arbitrary policies.

Human factor is real. Don't be sad, but try to see the argument behind
all the words and examples.

> Essentially you're saying: "loop iterator has to be stable helper or
> I quit working on it."
> Say we cave in and accepted your demand. Later you do another ultimatum

I hope you can "cave in" based on technical arguments and feedback
from users of BPF technology, which have to deal with real-world
aspects of all the BPF machinery. And then already have enough to care
about, no need to make their life harder.

I'm saying the loop iterator has to be a stable helper to be
universally used and universally recommended as *the solution for
doing repeatable work*. Without thinking about BTF, kfuncs,
arch-specific stuff. Because there is no reason why a loop iterator
would require any of that.

> and we cannot cave in for whatever reason. You stay true to your words
> and quit BPF development. Now we're stuck with your uapi that we cannot
> change, cannot improve, but still have to maintain it _forever_
> without you because you quit. That would suck.

This was always a risk for many years, that didn't stop BPF from
gaining lots of useful functionality, even if we'd retrospectively
would like to do some things differently.

> Let's get back to discussing technical merits without ultimatums. Ok?

That's what I've been (and still am) doing all this time.
