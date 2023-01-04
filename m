Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B075C65E118
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 00:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjADXro (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 18:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjADXrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 18:47:43 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1242E2E
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 15:47:42 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id h21so28695806qta.12
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 15:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/mUped/7UKLiTLR3ava1AZiuLbINwedV1mSqN1ol3g=;
        b=n2ufHyPQzJcx4YyCm6rbrkSgmU7GVlR5v96GecGtYDJIuM4zDszMDZky1HqEZKWci0
         UKuDf7De4BFju4iL9oe49ewesehkvpTuEEK1C/86Hl6zeazWG3sQl21b/L7tyq2iXtKC
         96BjNEPSBclWyj57y920Xzq7W3yRMVQHSgBZGFvz6VyQalwfp8hqgmv+yVXl2kfkkvdT
         UMgYoK/G6IWcjL16hWFvL9Ta2VtEpudme0YRvle5oY9IrpLFgGVvg7I5R3fgP+Wuv/Ak
         Ir4KlGIe0x6CYEBCa6PBdFdORbJlBlXr4/eccn3rhdrFuIjzRieMBzYiHEDG2KZuPUih
         bWMg==
X-Gm-Message-State: AFqh2koQapG3D9kycp3iJhaM3G0tpZvfMb1EXdZx4taX1+ND2Woxyn3x
        aU2Z7YF9xWMaycHXySuhxjg=
X-Google-Smtp-Source: AMrXdXv8EWKCN3acsNYx6yHqChkL9nqxEUqG3xHV5D5aheYQFqFmRvPWXL5PvpoE9PxrhYb0xaqvNw==
X-Received: by 2002:ac8:60cc:0:b0:3a8:12be:4136 with SMTP id i12-20020ac860cc000000b003a812be4136mr71495173qtm.8.1672876060924;
        Wed, 04 Jan 2023 15:47:40 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:7c6c])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a455600b006fb112f512csm24860083qkp.74.2023.01.04.15.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 15:47:40 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:47:40 -0600
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <Y7YQHC4FgYuLWmab@maniforge.lan>
References: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <CAEf4Bzbvg2bXOj8LPwkRQ0jfTR4y5XQn=ajK_ApVf5W-F=wG2Q@mail.gmail.com>
 <20230104194438.4lfigy2c5m4xx6hh@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzag8K=7+TY-LPEiBJ7ocRi-U+SiDioAQvPDto+j0U5YaQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 04, 2023 at 01:55:32PM -0800, Andrii Nakryiko wrote:

[...]

> > > Yes, we won't change existing helpers, but we can add new ones if we
> > > need to extend them. That's how APIs work. Yes, they need careful
> > > considerations when designing and implementing new APIs. Yes, mistakes
> > > do happen, that's just fact of life and par for the course of software
> > > development. Yes, we have to live with those mistakes. Nothing changed
> > > about that.
> > >
> > > But somehow libraries and kernel still produce stable APIs and
> > > maintain them because they clearly provide benefits to end users.
> >
> > Did you 'live with mistakes done in libbpf 0.x' ? No.
> 
> for a long time yes. And it's not apples to apples comparison, with
> library it is possible to deprecate APIs, which is what we did. With
> lots of work and gradual transition, but did it.

User space <-> kernel is not an apples to apples comparison with kernel
<-> BPF programs either. Also, you're using the word "possible" here
like it's a foregone conclusion. It is "possible" to deprecate BPF APIs
as well, if we start using kfuncs going forward instead of adding to the
UAPI boundary.

> If we couldn't pull this through, yeah, I would live with whatever
> APIs are there. And added new ones as a better replacement. As is
> always done for APIs, nothing new here.

The point is that you had a choice.

> Within 0.x and 1.x APIs are stable and we live with them. This API
> stability fear doesn't paralyze libbpf development, we still add new
> stable APIs, if they are considered useful and thought through enough.

Nobody is claiming that we can't have stable APIs. We're arguing in
favor of being able to _choose_ which APIs to deprecate. Using your
logic, you wouldn't have been able to deprecate _anything_ for fear of
some user, somewhere being affected by it. I understand the sentiment,
and I agree that it's very important to have conservative and
predictable approaches to deprecation. What I don't think is important
is to provide _indefinite_ guarantees for _all_ APIs between two
different kernel contexts.

And to reiterate, as I've said a few times now but nobody seems to be
responding to (unless I missed something), this is for kernel <-> kernel
programs. We're not even talking about APIs that are available to user
space. Let's at least be clear about the boundaries for which we're
debating the merits of stability, because while some user space tooling
would certainly affected by choosing to freeze BPF helpers, kfuncs and
BPF helpers are ever invoked by _kernel_ programs.

> > You've introduced libbpf 1.0 with incompatible api and some users suffereed.
> 
> By "suffered" you mean a few systemd folks being grumpy about this?
> And having to do 100 lines of code changes ([0]) to support two
> incompatible major versions of libbpf *simultaneously*?
> 
> On the other hand we got a library with saner error propagation
> behavior and various API normalizations and additions. Not too bad of
> a trade off.

This sounds like an argument in favor of why it is acceptable to
deprecate some things? Why are some users allowed to feel "pain" (a term
you've used in other threads), but other users who are affected by your
choices are just "grumpy"? Also, what about the myriad hypothetical
users you've never heard of (the ones who we're really protecting with
UAPI) who had to deal with breaking API stability changes?

> Sure, deprecation is not easy or free, there was a lot of prep work,
> and some users had to adjust their code to use new APIs. But this is
> quite a tangent.

I don't see how this is tangential to the discussion -- it seems very
relevant. From my perspective, the core of the discussion has been
whether it's acceptable to shift _any_ of the burden of API stability to
users. My point, and I believe Alexei's point as well, is that the
answer is "it depends and it's a tradeoff", as you've essentially said
here.

What I'm failing to understand is why your argument that there are
tradeoffs applies here, but not for kernel <-> BPF kernel programs? I'm
genuinely trying to understand what the distinction is, because from
where I'm sitting it feels like we're being selective about when the
unknown _threat_ of API instability automatically completely overrides
our ability to choose our own deprecation and stability story (a
stability story which is informed by our perception of an API's
importance, usage, etc).

Note that my point here applies to something you've raised on other
threads as well, such as on [0] where you (reasonably) reiterated this
point:

[0]: https://lore.kernel.org/all/CAEf4BzY0aJNGT321Y7Fx01sjHAMT_ynu2-kN_8gB_UELvd7+vw@mail.gmail.com/

> But again. Let me repeat my point *again*. BPF helpers and kfuncs are
> not mutually exclusive, both can and should exist and evolve. That's
> one of the main points which is somehow eluding this conversation.

This is one of the big disconnects for me. If you argue that both BPF
helpers and kfuncs can and should continue to coexist indefinitely, it
feels like you're arguing for two incompatible points (and please
correct me anywhere that I'm unintentionally misrepresenting your
perspective here):

- On the one hand you're arguing that in some cases, _no_ API
  instability is acceptable. That in general, the main kernel <-> kernel
  BPF program API boundary is equivalent to UAPI, and that it's _never_
  acceptable for us to ever, _ever_ deprecate certain APIs because
  _some_ users may be using them, and the possibilty of APIs ever
  changing or being deprecated will impose an unacceptable pain to users
  which will make it too difficult to build tooling and, and end up
  discouraging adoption onto BPF. It seems that you've been making
  making this argument in favor of what you consider to be "core" BPF
  helpers such as bpf_dynptr_is_null(), etc.

- At the same time, on the other hand, you're arguing that _some_ of the
  API boundary between kernel <-> BPF program can be unstable. That it's
  acceptable for _some_ users and _some_ tooling to feel the pain of
  certain APIs changing. To perhaps extrapolate your point a bit
  further, you're arguing that niche / non-core kfuncs can be unstable,
  and that we don't have to worry about the unknown, hypothetical user
  who would feel pain from having to deal with them being deprecated,
  because they're not "core".

Assuming that's all true, my question is:

Why not just give ourselves the _option_ of being able to deem those
core helpers as being indefinitely stable for the foreseeable future,
and keep the unstable kfuncs to have the same stability guarantees as
what they have today? In terms of _stability_ specifically (so ignoring
other concerns you've raised, such as that we need BTF and BPF
trampoline support for kfuncs -- not because they're irrelevant, but
just to keep the discussion focused on stability), what do we gain by
keeping the "core" / "stable" functions as BPF helpers, instead of just
making them "super stable" kfuncs? At least then we have the option in
the far-far-far future to deprecate them if they eventually, way later,
become 100% obsolete. Plus you get the other benefits that Alexei
mentioned such as potentially being able to backport them to older
kernels by including them in modules, etc.

Note that I'm not saying with 100% conviction that we don't have _any_
work to do before freezing helpers (though IMO we should just rip the
bandaid and do it now), but I am arguing with strong conviction that
once any of that precursor work is taken care of, there is no reason to
use BPF helpers in place of kfuncs. At least, that's how I see it at
this point.

>   [0] https://github.com/systemd/systemd/pull/24511/
> 
> >
> > > We'll get the same amount of flame when we try to change kfunc that's
> > > widely adopted.
> >
> > Of course. That's why we need to define a stability and deperecation
> > plan for them.
> 
> Lots of things that need to be defined and figured out, but we are
> already quick to freeze BPF helpers.

I agree with you that it would be prudent for us to iron some of this
out more concretely. In this discussion it seems like one of the key
points of contention has been around stability, and that the lack of a
concrete policy for kfuncs has largely (but not completely) been the
cause for concern. Perhaps it would help clarify things if someone
submitted a patch set that included a more formal kfunc stability
proposal?
