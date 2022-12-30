Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20451659C57
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 22:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiL3VAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 16:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiL3VAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 16:00:19 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE74A13F7A
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 13:00:16 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id a16so17936487qtw.10
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 13:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wXOg+COX3CI/MXze2uBMWC7GLE7ySzFLmLqCBuGOt8=;
        b=HMqNhuk0aifh+XKP0SZVT7EeC1FGr6Hrnbj2dIWC/KJHDayMkBfIeBjpt2Uvnsb2MM
         CsZ30CIhS7bfx/6jYAZsglYzO2HBRgCVXPtr9M3QZeQj+xPoEGN/YSU/HojLIFmEa66o
         SWv+yla7+71jxDD24Nk09kRkAI1Yd0kGwD5cgU6K/93uRAFHekG4rv8od2D810DtcpCS
         OLddsqorLBTkxHFyQL69VDwBAuuw4POVN+G3BcSAnfXS+sStbXvf2BGK0faTDkCHpKTj
         FcuOaDGRFhggVtUDkppCjo1jmRD1yKMWwuDElteTtiqP/LFShzjAScOtEeJrDGf9k08E
         fEZg==
X-Gm-Message-State: AFqh2kpkOzMje0lOY42+lmB6LjvK9X9+0BTP1pHWd0xADckJfmmB+iDA
        jTfzW/r4fTm0UnZAMBii5+U=
X-Google-Smtp-Source: AMrXdXtR/J4CyFyv8c9SY+DW7GfNB3mwZLZSTZ/+qvfOuqceGI4E4YFSKkJ+OtyhWJKk+l/sH86BQw==
X-Received: by 2002:a05:622a:4d47:b0:3ab:5dc7:6be7 with SMTP id fe7-20020a05622a4d4700b003ab5dc76be7mr49851590qtb.27.1672434015296;
        Fri, 30 Dec 2022 13:00:15 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3384])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b00705377347b9sm1020691qko.70.2022.12.30.13.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 13:00:14 -0800 (PST)
Date:   Fri, 30 Dec 2022 15:00:21 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <Y69RZeEvP2dXO7to@maniforge.lan>
References: <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 30, 2022 at 11:31:12AM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 30, 2022 at 12:38:55PM -0600, David Vernet wrote:
> > On Thu, Dec 29, 2022 at 06:46:41PM -0800, Alexei Starovoitov wrote:
> > > On Thu, Dec 29, 2022 at 03:10:22PM -0800, Andrii Nakryiko wrote:
> > > > On Sun, Dec 25, 2022 at 1:52 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Dec 20, 2022 at 11:31:25AM -0800, Andrii Nakryiko wrote:
> > > > > > On Fri, Dec 16, 2022 at 9:35 AM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> > > > > > > >
> > > > > > > > There is no clean way to ever move from unstable kfunc to a stable helper.
> > > > > > >
> > > > > > > No clean way? Yet in the other email you proposed a way.
> > > > > > > Not pretty, but workable.
> > > > > > > I'm sure if ever there will be a need to stabilize the kfunc we will
> > > > > > > find a clean way to do it.
> > > > > >
> > > > > > You can't have stable and unstable helper definition in the same .c
> > > > > > file,
> > > > >
> > > > > of course we can.
> > > > > uapi helpers vs kfuncs argument is not a black and white comparison.
> > > > > It's not just stable vs unstable.
> > > > > uapi has strict rules and helpers in uapi/bpf.h have to follow those rules.
> > > > > While kfuncs in terms of stability are equivalent to EXPORT_SYMBOL_GPL.
> > > > > Meaning they are largely unstable.
> > > > > The upsteam kernel keeps changing those EXPORT_SYMBOL* functions,
> > > > > but distros can apply their own "stability rules".
> > > > > See Redhat's kABI, for example. A distro can guarantee a stability
> > > > > of certain EXPORT_SYMBOL* for their customers, but that doesn't bind
> > > > > upstream development.
> > 
> > This also sounds more in line with what was discussed at the maintainers
> > summit [0]. "A BPF program that depends on kernel symbols is not really
> > a user program anymore." Given that perspective, EXPORT_SYMBOL_GPL
> > sounds like the correct equivalency to "public BPF symbols".
> > 
> > [0]: https://lwn.net/Articles/908464/
> > 
> > > > >
> > > > > With uapi bpf helpers we have to guarantee their stability,
> > > > > while with kfuncs we can do whatever we want. Right now all kfuncs are
> > > > > unstable and to prove the point we changed them couple times already (nf_conn*).
> > > > > We also have bpf_obj_new_impl() kfunc which is equivalent to EXPORT_SYMBOL(__kmalloc).
> > > > > Hard to imagine more stable and more fundamental function.
> > > > > Of course we want bpf programs to use bpf_obj_new() and assume
> > > > > that it's going to be available in all future kernel releases.
> > > > > But at the same time we're not bound by uapi rules.
> > > > > bpf_obj_new() will likely be stable, but not uapi stable.
> > > > > If we screw up (or find better way to allocate memory in the future)
> > > > > we can change it.
> > > > > We can invent our own deprecation rules for stable-ish kfuncs and
> > > > > invent our more-unstable-than-current-unstable rules for kfuncs that
> > > > > are too much kernel release dependent.
> > > >
> > > > I'm talking about *mechanics* of having two incompatible definitions
> > > > of functions with the same name, not the *concept* of stable vs
> > > > unstable API. See [0] where I explained this as a reply to Joanne.
> > > >
> > > >   [0] https://lore.kernel.org/bpf/CAEf4BzbRQLEjAFUkzzStv0c0=O+r9iZ8hq33sJB2RtSuGrGAEA@mail.gmail.com/
> > >
> > > Mechanics for kfuncs are much better than for helpers.
> > >
> > > extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;
> > >
> > > will likely work with both gcc and clang.
> > > And if it doesn't we can fix it.
> > >
> > > While when gcc folks saw helpers:
> > >
> > > static bool (*bpf_dynptr_is_null)(const struct bpf_dynptr *p) = (void *) 777;
> > >
> > > they realized that it is a hack that abuses compiler optimizations.
> > > They even invented attr(kernel_helper) to workaround this issue.
> > > After a bunch of arguing gcc added support for this hack without attr,
> > > but it's going to be around forever... in gcc, in clang and in kernel.
> > > It's something that we could have fixed if it wasn't for uapi.
> > > Just one more example of unfixable mistake that causing issues
> > > to multiple projects.
> > > That's the core issue of kernel uapi rules: inability to fix mistakes.
> > >
> > > > >
> > > > > > But regardless, dynptr is modeled as black box with hidden state, and
> > > > > > its API surface area is bigger (offset, size, is null or not,
> > > > > > manipulations over those aspects; then there is skb/xdp abstraction to
> > > > > > be taken care of for generic read/write). It has a wider *generic* API
> > > > > > surface to be useful and effectively used.
> > > > >
> > > > > tbh dynptr as an abstraction of skb/xdp is not convincing.
> > > > > cilium created their own abstraction on top of skb and xdp and it's zero cost.
> > > > > While dynptr is not free, so xdp users unlikely to use dynptr(xdp) for perf reasons.
> > > > > So I suspect it won't be a success story in the long run, but we
> > > > > can certainly try it out since they will be kfuncs and can be deprecated
> > > > > if maintenance outweighs the number of users.
> > > > >
> > > > > > All *two* of them, bpf_get_current_task() and
> > > > > > bpf_get_current_task_btf(), right? They are 2 years apart.
> > > > > > bpf_get_current_task() was added before BTF era. It is still actively
> > > > > > used today and there is nothing wrong with it. It works on older
> > > > > > kernels just fine, even with BPF CO-RE (as backporting a few simple
> > > > > > patches to generate BTF is simple and easy; not so much with BPF
> > > > > > verifier changes to add native BTF support). I don't see much problem
> > > > > > having both, they are not maintenance burden.
> > > > >
> > > > > bpf_get_current_pid_tgid
> > > > > bpf_get_current_uid_gid
> > > > > bpf_get_current_comm
> > > > > bpf_get_current_task
> > > > > bpf_get_current_task_btf
> > > > > bpf_get_current_cgroup_id
> > > > > bpf_get_current_ancestor_cgroup_id
> > > > > bpf_skb_ancestor_cgroup_id
> > > > > bpf_sk_cgroup_id
> > > > > bpf_sk_ancestor_cgroup_id
> > > > >
> > > > > _are_ a maintenance burden.
> > > >
> > > > bpf_get_current_pid_tgid() was added in 2015, slightly and
> > > > uncritically touched by Daniel in 2016 and we never had any problems
> > > > with it ever since. No updates, no maintenance. I don't remember much
> > > > problem with other helpers in this list, but I didn't check each one.
> > 
> > You could argue that this actually a point in favor of kfuncs. If we
> > implement these as kfuncs and never touch them again, users will not
> > need to change anything and will have the same exact experience as if it
> > was in UAPI (minus being on platforms that don't support kfuncs, which
> > is something we should work to fix in general). It will just work
> > indefinitely, as long as we decide to support it.
> > 
> > The only time there will be pain felt by users is if we in fact do
> > actually have to change it. If we have to add a flags field, or change
> > the semantics to have different behavior, etc. I think Alexei's point is
> > that we simply _can't_ do that if we're bound by UAPI. At least with
> > kfuncs we have the choice to change it if we deem it necessary.
> > 
> > Taking bpf_get_current_task() as an example, I think it's better to have
> > the debate be "should we keep supporting this / are users still using
> > it?" rather than, "it's UAPI, there's nothing to even discuss". The
> > point being that even if bpf_get_current_task() is still used, there may
> > (and inevitably will) be other UAPI helpers that are useless and that we
> > just can't remove.
> > 
> > > >
> > > > But we certainly have a different understanding of what "maintenance
> > > > burden" is. If some code doesn't require constant change and doesn't
> > > > prevent changes in some other parts of the system, it's not a
> > > > maintenance burden.
> > >
> > > As I said it's not about working today. If one doesn't touch code
> > > it will keep working.
> > > It's about being able to change it.
> > > The uapi bits we simply cannot change.
> > 
> > I think Michael Kerrisk's classic "Once upon an API" talk [1] provides a
> > compelling, real-world example of this point:
> > 
> > [1]: https://kernel-recipes.org/en/2022/once-upon-an-api/
> > 
> > APIs can seem innocuous when you first add them, and then as you use
> > them more and in different ways, your platform grows more featureful and
> > things change, etc, you realize that the axioms upon which you designed
> > your APIs in the first place are no longer true. prctl() started out as
> > a dead-simple syscall where a child process would get a signal if its
> > parent process dies. Over the years, it's morphed into a monstrosity [2]
> > of a syscall with tons of odd behavior that's impossible [3] to fix even
> > a decade+ after the API was first introduced due to the possibility of
> > breaking applications that have come to rely on that non-sensical
> > behavior. Never breaking user space is a great philosophy, but I don't
> > think we need to inflict that same pain on ourselves for _kernel_
> > programs, which is what we're discussing here.
> > 
> > [2]: https://man7.org/linux/man-pages/man2/prctl.2.html
> > [3]: https://bugzilla.kernel.org/show_bug.cgi?id=43300#c22
> > 
> > I'm not trying to paint a false equivalency between prctl() and the
> > helpers you enumerated in [4], because I agree with you that it's very
> > unlikely that they'll change, but I also think it's impossible to know
> > that for sure, and I do agree with Alexei that the "hypothetical chance
> > to change something in the future" is hugely valuable. That being said,
> > I comment more on the dynptr helpers down below.
> > 
> > [4]: https://lore.kernel.org/all/CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com/
> > 
> > > >
> > > > > The verifier got smarter and we could have removed all of them,
> > > > > but uapi rules makes it impossible.
> > > > > The bpf prog could have been enabled to access all these task_struct
> > > > > and cgroup fields directly. Likely without any kfuncs.
> > > > >
> > > > > bpf_send_signal vs bpf_send_signal_thread
> > > > > bpf_jiffies64 vs bpf_this_cpu_ptr
> > > > > etc
> > > > > there are plenty examples where uapi bpf helpers became a burden.
> > > > > They are working and will keep working, but we could have done
> > > > > much better job if not for uapi.
> > > > > These are the examples where uapi rules are too strong for bpf development.
> > > > > Our pace of adding new features is high.
> > > > > The kernel uapi rules are too strict for us.
> > > >
> > > > I'm familiar with the burden of maintaining API stability and
> > > > backwards compat. But it's not just about the library/system
> > >
> > > libbpf 1.0 wasn't the smoothest example of deprecation.
> > > But we still did it despite all kinds of negative flame.
> > > With uapi helpers we cannot do any of that. No deprecation schemes.
> > > While kfuncs allow innovation.
> > >
> > > > developer's convenience and burden, it's also about the end user's
> > > > experience and convenience. BPF tool developers really appreciate when
> > > > there are few less quirks to remember and work around across kernel
> > > > versions, configurations, architectures, etc. It's the pain that
> > > > kernel engineers working on BPF bleeding-edge don't experience in the
> > > > BPF selftests environment.
> > >
> > > There is a trade off between users and developers. We want to make user
> > > experience as smooth as possible while preserve the speed of development
> > > for the kernel. uapi is in the way of that.
> > 
> > As illustrated in the prctl() example above, UAPI can get in the way of
> > users as well. If we can't fix an API or its semantics, some users are
> > stuck with that crappy behavior (while, admittedly, others get to enjoy
> > the consistency of the weird / existing behavior not changing out from
> > under them). I certainly see why there are strong reasons to have a
> > stable UAPI for user space, but for kernel programs I don't think so.
> > 
> > > > >
> > > > > At one point DaveM declared freeze on sizeof(struct sk_buff).
> > > > > It was a difficult, but correct decision.
> > > > > We have to declare freeze on bpf helpers.
> > > > > 211 helpers that have to be maintained forever is a huge burden.
> > 
> > While I agree that we should freeze helpers at some point, I also think
> > we need to take care of a few things before that can or should formally
> > go into effect. You mentioned some things we should take care of in [5].
> > Automatically emitting kfuncs into vmlinux.h, properly documenting
> > kfuncs. I think that list is insufficient, and that we need:
> > 
> > [5]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/
> 
> All of the below are 'nice to have' to improve kfunc user experience,
> but certainly not 'must have'.

I certainly agree that what is 'must have' is subjective.

> 
> > 1. A formal, build-enforced policy for documenting kfuncs, as we
> > currently have for helpers (as you mentioned, minus the
> > build-enforcement).
> 
> That would be necessary only for stable-ish kfuncs.
> Like recently added bpf_obj_new.
> Unstable kfuncs would have to be documented differently and maybe not even documented.
> It will take time to figure it all out.

Why would we only want to make it necessary for stable-ish kfuncs? It's
simpler and less open to interpretation to just have a blanket "you must
document your kfuncs" policy. It seems pretty reasonable to expect
people who are exporting public symbols that can be linked against by
BPF programs to document those functions given that it takes no more
than ~5 minutes?

I also don't want to hijack the larger conversation here to discuss
documentation. I think we all agree that documentation is important. We
already have a pretty good kfuncs docs page [0] anyways. In my
subjective opinion, _the_ platform for documenting public / exported BPF
symbols should have a well-defined documentation story, but yes, arguing
for it to be a blocker is maybe a stretch.

[0]: https://docs.kernel.org/bpf/kfuncs.html

> > 2. Emitting kfuncs into vmlinux.h, as you mentioned.
> 
> Key kfuncs are already in bpf_experimental.h
> Unstable kfuncs might go into vmlinux.h.
> Maybe all.
> Many ways to go about it.

Agreed that there are many possibilities. In my once again subjective
opinion it would be good to get this ironed out, but yes, arguably not a
blocker.

> 
> > 3. Allowing users to specify flags per-argument in kfuncs. In my opinion
> > this is a big deficiency of kfuncs relative to helpers. This would mean
> > e.g. getting rid of the __sz and __k hacks. I think it's fine for us to
> > live with it for now while we're continuing to flesh-out and improve
> > kfuncs (a process which is happening quickly), but IMO it's really not
> > appropriate for it to be the official only way to add helpers. It's a
> > beta feature :-)
> 
> This is a huge discussion on pros and cons and correct approach.
> That might take years. We already had ~3 refactoring of how kfuncs
> are represented in the kernel in the last ~2 years.
> Is 4th refactoring going to be final? Likely no.

I don't think the fact that we'll never be done is a valid counterpoint
to "are we ready now"? The first iteration of kfuncs was definitely not
in a good enough state to freeze all helpers. The usability of kfuncs
has improved drastically since then. The question isn't "when will be at
a complete stopping point?", it's, "are we sufficiently ready now?".

> It's a bit of wishful thinking that addressing today's problem will somehow
> make everything nice and clean and then we will be ready to stop adding helpers.
> We'll keep improving the infra for years to come.
> There is no "end of the road" sign.

Yes, there's no end of the road, but my point is that there are still
pieces that we know we need to change, and which we know are temporary
(__sz and __k being the main examples).

*That being said*: I completely admit that this is all subjective. From
a technical standpoint, there is nothing stopping us from freezing
helpers. And honestly, I don't disagree with you that getting out of
UAPI immediately and forever is a huge positive; possibly even to the
point that it warrants us just doing it now. More below.

> 
> > 4. Getting rid of KF_TRUSTED_ARGS and making that the default.
> 
> We've been talking about this possibility for months.
> Are you suggesting to keep adding helpers for another year or so?

I think that kfuncs should be the norm for the vast majority of things
being added, and hopefully for everything (I'm going to walk back my
suggestion of adding these new dynptr functions as helpers). Honestly,
my point was really just that I think the API for defining kfuncs needs
to be improved before we can totally and completely freeze helpers due
to the fact that we have __sz and __k, and don't have a consistent
documentation story. That being said, __sz and __k are there, they work,
and as you and I have both said at this point, whether or not they're
"blockers" is subjective.

So my answer to your question of "should we add helpers for another year
or so" in my last reply would have been "absolutely not, unless we truly
have no choice because of the lack of per-arg flags". After reading your
reply, if you're worried that that policy won't be strictly enforced
(meaning that we'll end up having to add helpers that easily could have
just been kfuncs) then I agree that we should just do the hard freeze
now. We've de-facto been doing that anyways for the last year.

That being said, I really would hope that we could at least get some of
the documentation story figured out. Even if it's just something as
simple as spelling out a formal policy on our kfuncs docs page
stipulating that you have to add a doxygen header and link it from a
docs page, it would be nice to have some policy that puts kfuncs on a
road to being as well documented as helpers.

> We already have 91 kfuncs and 211 helpers.
> If we were not asking all developers to use kfuncs we would have had 300+ helpers.

Agreed that this would have been a _very_ unfortunate outcome.

> 
> > 5. Ideally we could improve the story for _defining_ kfuncs as well,
> > though IMO it's already far less painful than defining helpers. It would
> > be nice if you could just tag a kfunc with something like a __bpf_kfunc
> > macro and it would do the following:
> > 
> > - Automatically disable the -Wmissing-prototypes warning. I doubt this
> >   is possible without adding some compiler features that let you do
> >   something like __attribute__(__nowarn__("Wmissing-prototypes")), so
> >   maybe this isn't a hard blocker, but more of a medium / long-term
> >   goal.
> > - Add whatever other attributes we need for the kfuncs to be safe. For
> >   example, 'noinline' and '__used'. Even if the symbols are global,
> >   we'll probably need '__used' for LTO.
> 
> would be nice, but that didn't stop existing 91 kfuncs to appear
> and already used in production.
> Yes. kfuncs are already used in production.

This is something that would literally only take like 1-2 patches
anyways. I'm happy to do it so we don't have to waste cycles thinking
about it as a blocker for anything.

> 
> > Overall, my point is really that we still have some homework to do
> > before we can just unilaterally freeze helpers. We're getting close, but
> > IMO not quite there yet.
> 
> 91 vs 211 tells a different story.

Yeah, the fact that we have 91 kfuncs is strong evidence that kfuncs are
already in a good-enough place to just freeze helpers.

Another counterpoint to my initial claim that not having per-arg flags
could be problematic is that there are certain things that are global in
kfuncs that are also global in helpers despite having per-arg modifiers.
For example, the fact that you can only have one OBJ_RELEASE argument.
And yet another is the fact that none of the helpers we've added in the
last year relied on having per-arg modifiers, so in practice it hasn't
been a problem.

I think it's fair to say that if you just look at the data instead of
from an "API cleanlines" perspective, having per-arg modifiers is not a
blocker. Data wins over subjectivity, so as mentioned above, I'm willing
to change my mind about per-arg modifiers being a blocker, especially
with __sz and __k.

> > > >
> > > > I still didn't get why we have to freeze anything and how exactly
> > > > helpers are a burden.
> > > >
> > > > But especially in this specific case of few simple dynptr helpers,
> > > > especially that other dynptrs generic APIs are already BPF helpers. I
> > > > just don't get it and honestly all I see from this discussion is that
> > > > you've made up your mind and there is nothing that can be done to
> > > > convince you.
> > > >
> > > > The only "BPF helpers are stable and thus a burden" argument is just
> > > > not convincing and I'd even say is mostly false. There are no upsides
> > > > to having dynptr helpers as kfuncs, as far as I'm concerned.
> > >
> > > The main and only upside for everything as kfunc is that we can change it.
> > > That's it.
> > >
> > > > But there
> > > > are a bunch of downsides, even if some of those might be lifted in the
> > > > future.
> > >
> > > imo ability to change outweighs all downsides, since downsides are fixable
> > > while inability to change is a burden.
> > >
> > > > The unfortunate thing is that end users that are meant to benefit from
> > > > all these helpers and them being "a standard API offering" are not
> > > > well represented on the BPF mailing list, unfortunately. And my
> > > > opinion and arguments as a proxy for theirs is clearly not enough.
> > >
> > > I also would like to hear what others on the list are thinking.
> > 
> > The last thing I'll say is that everything I've said above is really in
> > regards to the more general debate of helpers vs. kfuncs. Specifically
> > for the dynptrs being added in this set, I agree with Andrii that it's
> > arguably an odd user experience for certain platforms to support
> > different only specific parts of the dynptr API surface.
> > 
> > I'm not sure whether that's enough to warrant making them helpers
> > instead of kfuncs, but I do think it's not exactly an apples to apples
> > comparison with future features that today have no helper API presence.
> > Putting myself in the shoes of a dynptr user, I would be very surprised
> > and confused if all of a sudden, I couldn't use some of the core dynptr
> > APIs due to being on a platform that doesn't have kfunc support. My two
> > cents are that letting these dynptr functions stay as helpers, while
> > agreeing that kfuncs is the way forward (though I don't think Andrii
> > agrees with that even aside from just these dynptrs) is a reasonable
> > compromise that errs on the side of user-friendliness for dynptr users.
> 
> We already have this 'discrepancy' of both kfuncs and helpers for kptrs
> (bpf_obj_new vs bpf_kptr_xhcg) and so far no complains.
> Why dynptr is special?

Well, lack of usability in one case doesn't necessarily mean we should
allow it in another. That said, the "usability" gains from having a
helper really are minimal to the point of practically being negligible
anyways.

Part of me was trying to find a compromise here to move forward, but
honestly, I do agree with you that we should aggressively make
everything a kfunc unless we have a good reason not to, dynptr functions
included. So I'm willing to walk this suggestion back as well -- let's
just make these kfuncs.

> > FWIW, I also don't think it's fair or logical to argue at this point in
> > the game that dynptrs as a concept is inherently flawed. They were super
> > useful for enabling the user ringbuf map type, which is a key part of
> > rhone / user-space scheduling in sched_ext, and I wouldn't be surprised
> > if ghOSt started using it as well as a way to make scheduling decisions
> > without trapping into the kernel as well. Also, the attendees at LSFMM
> > generally seemed enthusiastic about dynptrs and user ringbuf, though I
> > admittedly don't know who's using either feature outside of rhone.
> 
> rhone doesn't have stability guarantees just like sched-ext doesn't have them.
> To drive that point rhone and sched-ext should really be using kfuncs.
> Otherwise somebody might point the finger at helpers and argue that
> this is somehow makes sched-ext stable.

Also a reasonable point. My point above was really just a response to
your claim in [0] that dynptrs are flawed. It wasn't related to kfuncs
vs. helpers.

[0]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/

> 
> > That being said, to reiterate, I personally agree that once we take care
> > of a few more things for kfuncs , they're 100% the way forward over
> > helpers. BPF programs are kernel programs, no UAPI pain should be
> > necessary.
> 
> Similar arguments were made during sk_buff freeze... let's add few more fields
> that are going to be sooo useful and then we'll freeze sk_buff...
> dynptr is trying to be that special snow flake.

The main points of my initial response were not about dynptrs, they were
about how we define kfuncs. I agree there is nothing at all special
about dynptrs beyond the fact that they as a feature already have
helpers. Sure, let's add them as kfuncs. No reason to be beholden to the
UAPI restrictions.

> 
> bpf_rcu_read_lock was added as a kfunc. It's more fundamental than dynptr.
> bpf_obj_new is a kfunc too. Also more fundamental than dynptr.
> What is so special about dynptr that we need to make an exception for it?

See above.
