Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F6B659B72
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiL3Siy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 13:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiL3Six (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 13:38:53 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662319C37
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 10:38:51 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id v14so14947231qtq.3
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 10:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAYXzzIFwf7k+U1S1hpOJG0WfL39E92veq7V43125Fk=;
        b=Gji/pTlKMb1hPmiO4F3r/5pyJr/oJBBz65xlpKIHqdkfSE2WXv/kVu47zOdEuiGbaL
         E/MqzCn1mrO/fvFsyQ6FLaUcehtGcLgy0QrFPVWXjHOY8YD4y6oduECMc+PrJ9m0RQzo
         meXloxVJDhvvBv1IzjozFU5lrMD1P/diRUoaNyOwMGSt9eBpm/Hc0XmjQjIxEjvSGPVW
         YoL50WlxBonaf3Nc/9CN+mLpPzSz/eUqtzWE3yigRJYoQ5KIpaXEBSt/glAo6cTa0DwZ
         mL8/XqKCMeVdDCQRhB/58jeZ5UfzoaKjojOMz4Pi5LaLS31vRNGUF8zaOlapwksd2bNJ
         1VsA==
X-Gm-Message-State: AFqh2kp9oM9OSaKCvDI0LZ6UIkzEpP2ywvgBpW3dK+8erctpw2H3SiIW
        DMlxlXJNHNGWXMUQ0LiXmAg=
X-Google-Smtp-Source: AMrXdXtBekofqs7zCSBs/CoQINQc0tv8L21skgwMQ89cEC5tEVdy1CBF95gMZ9BwYtWzE6KkfYoSsg==
X-Received: by 2002:ac8:541a:0:b0:3ab:5ce2:6b98 with SMTP id b26-20020ac8541a000000b003ab5ce26b98mr44217842qtq.22.1672425530078;
        Fri, 30 Dec 2022 10:38:50 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:3384])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05622a489000b003a6a7a20575sm13441527qtb.73.2022.12.30.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 10:38:49 -0800 (PST)
Date:   Fri, 30 Dec 2022 12:38:55 -0600
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
Message-ID: <Y68wP/MQHOhUy2EY@maniforge.lan>
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 06:46:41PM -0800, Alexei Starovoitov wrote:
> On Thu, Dec 29, 2022 at 03:10:22PM -0800, Andrii Nakryiko wrote:
> > On Sun, Dec 25, 2022 at 1:52 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Dec 20, 2022 at 11:31:25AM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Dec 16, 2022 at 9:35 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> > > > > >
> > > > > > There is no clean way to ever move from unstable kfunc to a stable helper.
> > > > >
> > > > > No clean way? Yet in the other email you proposed a way.
> > > > > Not pretty, but workable.
> > > > > I'm sure if ever there will be a need to stabilize the kfunc we will
> > > > > find a clean way to do it.
> > > >
> > > > You can't have stable and unstable helper definition in the same .c
> > > > file,
> > >
> > > of course we can.
> > > uapi helpers vs kfuncs argument is not a black and white comparison.
> > > It's not just stable vs unstable.
> > > uapi has strict rules and helpers in uapi/bpf.h have to follow those rules.
> > > While kfuncs in terms of stability are equivalent to EXPORT_SYMBOL_GPL.
> > > Meaning they are largely unstable.
> > > The upsteam kernel keeps changing those EXPORT_SYMBOL* functions,
> > > but distros can apply their own "stability rules".
> > > See Redhat's kABI, for example. A distro can guarantee a stability
> > > of certain EXPORT_SYMBOL* for their customers, but that doesn't bind
> > > upstream development.

This also sounds more in line with what was discussed at the maintainers
summit [0]. "A BPF program that depends on kernel symbols is not really
a user program anymore." Given that perspective, EXPORT_SYMBOL_GPL
sounds like the correct equivalency to "public BPF symbols".

[0]: https://lwn.net/Articles/908464/

> > >
> > > With uapi bpf helpers we have to guarantee their stability,
> > > while with kfuncs we can do whatever we want. Right now all kfuncs are
> > > unstable and to prove the point we changed them couple times already (nf_conn*).
> > > We also have bpf_obj_new_impl() kfunc which is equivalent to EXPORT_SYMBOL(__kmalloc).
> > > Hard to imagine more stable and more fundamental function.
> > > Of course we want bpf programs to use bpf_obj_new() and assume
> > > that it's going to be available in all future kernel releases.
> > > But at the same time we're not bound by uapi rules.
> > > bpf_obj_new() will likely be stable, but not uapi stable.
> > > If we screw up (or find better way to allocate memory in the future)
> > > we can change it.
> > > We can invent our own deprecation rules for stable-ish kfuncs and
> > > invent our more-unstable-than-current-unstable rules for kfuncs that
> > > are too much kernel release dependent.
> >
> > I'm talking about *mechanics* of having two incompatible definitions
> > of functions with the same name, not the *concept* of stable vs
> > unstable API. See [0] where I explained this as a reply to Joanne.
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzbRQLEjAFUkzzStv0c0=O+r9iZ8hq33sJB2RtSuGrGAEA@mail.gmail.com/
>
> Mechanics for kfuncs are much better than for helpers.
>
> extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;
>
> will likely work with both gcc and clang.
> And if it doesn't we can fix it.
>
> While when gcc folks saw helpers:
>
> static bool (*bpf_dynptr_is_null)(const struct bpf_dynptr *p) = (void *) 777;
>
> they realized that it is a hack that abuses compiler optimizations.
> They even invented attr(kernel_helper) to workaround this issue.
> After a bunch of arguing gcc added support for this hack without attr,
> but it's going to be around forever... in gcc, in clang and in kernel.
> It's something that we could have fixed if it wasn't for uapi.
> Just one more example of unfixable mistake that causing issues
> to multiple projects.
> That's the core issue of kernel uapi rules: inability to fix mistakes.
>
> > >
> > > > But regardless, dynptr is modeled as black box with hidden state, and
> > > > its API surface area is bigger (offset, size, is null or not,
> > > > manipulations over those aspects; then there is skb/xdp abstraction to
> > > > be taken care of for generic read/write). It has a wider *generic* API
> > > > surface to be useful and effectively used.
> > >
> > > tbh dynptr as an abstraction of skb/xdp is not convincing.
> > > cilium created their own abstraction on top of skb and xdp and it's zero cost.
> > > While dynptr is not free, so xdp users unlikely to use dynptr(xdp) for perf reasons.
> > > So I suspect it won't be a success story in the long run, but we
> > > can certainly try it out since they will be kfuncs and can be deprecated
> > > if maintenance outweighs the number of users.
> > >
> > > > All *two* of them, bpf_get_current_task() and
> > > > bpf_get_current_task_btf(), right? They are 2 years apart.
> > > > bpf_get_current_task() was added before BTF era. It is still actively
> > > > used today and there is nothing wrong with it. It works on older
> > > > kernels just fine, even with BPF CO-RE (as backporting a few simple
> > > > patches to generate BTF is simple and easy; not so much with BPF
> > > > verifier changes to add native BTF support). I don't see much problem
> > > > having both, they are not maintenance burden.
> > >
> > > bpf_get_current_pid_tgid
> > > bpf_get_current_uid_gid
> > > bpf_get_current_comm
> > > bpf_get_current_task
> > > bpf_get_current_task_btf
> > > bpf_get_current_cgroup_id
> > > bpf_get_current_ancestor_cgroup_id
> > > bpf_skb_ancestor_cgroup_id
> > > bpf_sk_cgroup_id
> > > bpf_sk_ancestor_cgroup_id
> > >
> > > _are_ a maintenance burden.
> >
> > bpf_get_current_pid_tgid() was added in 2015, slightly and
> > uncritically touched by Daniel in 2016 and we never had any problems
> > with it ever since. No updates, no maintenance. I don't remember much
> > problem with other helpers in this list, but I didn't check each one.

You could argue that this actually a point in favor of kfuncs. If we
implement these as kfuncs and never touch them again, users will not
need to change anything and will have the same exact experience as if it
was in UAPI (minus being on platforms that don't support kfuncs, which
is something we should work to fix in general). It will just work
indefinitely, as long as we decide to support it.

The only time there will be pain felt by users is if we in fact do
actually have to change it. If we have to add a flags field, or change
the semantics to have different behavior, etc. I think Alexei's point is
that we simply _can't_ do that if we're bound by UAPI. At least with
kfuncs we have the choice to change it if we deem it necessary.

Taking bpf_get_current_task() as an example, I think it's better to have
the debate be "should we keep supporting this / are users still using
it?" rather than, "it's UAPI, there's nothing to even discuss". The
point being that even if bpf_get_current_task() is still used, there may
(and inevitably will) be other UAPI helpers that are useless and that we
just can't remove.

> >
> > But we certainly have a different understanding of what "maintenance
> > burden" is. If some code doesn't require constant change and doesn't
> > prevent changes in some other parts of the system, it's not a
> > maintenance burden.
>
> As I said it's not about working today. If one doesn't touch code
> it will keep working.
> It's about being able to change it.
> The uapi bits we simply cannot change.

I think Michael Kerrisk's classic "Once upon an API" talk [1] provides a
compelling, real-world example of this point:

[1]: https://kernel-recipes.org/en/2022/once-upon-an-api/

APIs can seem innocuous when you first add them, and then as you use
them more and in different ways, your platform grows more featureful and
things change, etc, you realize that the axioms upon which you designed
your APIs in the first place are no longer true. prctl() started out as
a dead-simple syscall where a child process would get a signal if its
parent process dies. Over the years, it's morphed into a monstrosity [2]
of a syscall with tons of odd behavior that's impossible [3] to fix even
a decade+ after the API was first introduced due to the possibility of
breaking applications that have come to rely on that non-sensical
behavior. Never breaking user space is a great philosophy, but I don't
think we need to inflict that same pain on ourselves for _kernel_
programs, which is what we're discussing here.

[2]: https://man7.org/linux/man-pages/man2/prctl.2.html
[3]: https://bugzilla.kernel.org/show_bug.cgi?id=43300#c22

I'm not trying to paint a false equivalency between prctl() and the
helpers you enumerated in [4], because I agree with you that it's very
unlikely that they'll change, but I also think it's impossible to know
that for sure, and I do agree with Alexei that the "hypothetical chance
to change something in the future" is hugely valuable. That being said,
I comment more on the dynptr helpers down below.

[4]: https://lore.kernel.org/all/CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com/

> >
> > > The verifier got smarter and we could have removed all of them,
> > > but uapi rules makes it impossible.
> > > The bpf prog could have been enabled to access all these task_struct
> > > and cgroup fields directly. Likely without any kfuncs.
> > >
> > > bpf_send_signal vs bpf_send_signal_thread
> > > bpf_jiffies64 vs bpf_this_cpu_ptr
> > > etc
> > > there are plenty examples where uapi bpf helpers became a burden.
> > > They are working and will keep working, but we could have done
> > > much better job if not for uapi.
> > > These are the examples where uapi rules are too strong for bpf development.
> > > Our pace of adding new features is high.
> > > The kernel uapi rules are too strict for us.
> >
> > I'm familiar with the burden of maintaining API stability and
> > backwards compat. But it's not just about the library/system
>
> libbpf 1.0 wasn't the smoothest example of deprecation.
> But we still did it despite all kinds of negative flame.
> With uapi helpers we cannot do any of that. No deprecation schemes.
> While kfuncs allow innovation.
>
> > developer's convenience and burden, it's also about the end user's
> > experience and convenience. BPF tool developers really appreciate when
> > there are few less quirks to remember and work around across kernel
> > versions, configurations, architectures, etc. It's the pain that
> > kernel engineers working on BPF bleeding-edge don't experience in the
> > BPF selftests environment.
>
> There is a trade off between users and developers. We want to make user
> experience as smooth as possible while preserve the speed of development
> for the kernel. uapi is in the way of that.

As illustrated in the prctl() example above, UAPI can get in the way of
users as well. If we can't fix an API or its semantics, some users are
stuck with that crappy behavior (while, admittedly, others get to enjoy
the consistency of the weird / existing behavior not changing out from
under them). I certainly see why there are strong reasons to have a
stable UAPI for user space, but for kernel programs I don't think so.

> > >
> > > At one point DaveM declared freeze on sizeof(struct sk_buff).
> > > It was a difficult, but correct decision.
> > > We have to declare freeze on bpf helpers.
> > > 211 helpers that have to be maintained forever is a huge burden.

While I agree that we should freeze helpers at some point, I also think
we need to take care of a few things before that can or should formally
go into effect. You mentioned some things we should take care of in [5].
Automatically emitting kfuncs into vmlinux.h, properly documenting
kfuncs. I think that list is insufficient, and that we need:

[5]: https://lore.kernel.org/all/20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local/

1. A formal, build-enforced policy for documenting kfuncs, as we
currently have for helpers (as you mentioned, minus the
build-enforcement).

2. Emitting kfuncs into vmlinux.h, as you mentioned.

3. Allowing users to specify flags per-argument in kfuncs. In my opinion
this is a big deficiency of kfuncs relative to helpers. This would mean
e.g. getting rid of the __sz and __k hacks. I think it's fine for us to
live with it for now while we're continuing to flesh-out and improve
kfuncs (a process which is happening quickly), but IMO it's really not
appropriate for it to be the official only way to add helpers. It's a
beta feature :-)

4. Getting rid of KF_TRUSTED_ARGS and making that the default.

5. Ideally we could improve the story for _defining_ kfuncs as well,
though IMO it's already far less painful than defining helpers. It would
be nice if you could just tag a kfunc with something like a __bpf_kfunc
macro and it would do the following:

- Automatically disable the -Wmissing-prototypes warning. I doubt this
  is possible without adding some compiler features that let you do
  something like __attribute__(__nowarn__("Wmissing-prototypes")), so
  maybe this isn't a hard blocker, but more of a medium / long-term
  goal.
- Add whatever other attributes we need for the kfuncs to be safe. For
  example, 'noinline' and '__used'. Even if the symbols are global,
  we'll probably need '__used' for LTO.

Overall, my point is really that we still have some homework to do
before we can just unilaterally freeze helpers. We're getting close, but
IMO not quite there yet.

> >
> > I still didn't get why we have to freeze anything and how exactly
> > helpers are a burden.
> >
> > But especially in this specific case of few simple dynptr helpers,
> > especially that other dynptrs generic APIs are already BPF helpers. I
> > just don't get it and honestly all I see from this discussion is that
> > you've made up your mind and there is nothing that can be done to
> > convince you.
> >
> > The only "BPF helpers are stable and thus a burden" argument is just
> > not convincing and I'd even say is mostly false. There are no upsides
> > to having dynptr helpers as kfuncs, as far as I'm concerned.
>
> The main and only upside for everything as kfunc is that we can change it.
> That's it.
>
> > But there
> > are a bunch of downsides, even if some of those might be lifted in the
> > future.
>
> imo ability to change outweighs all downsides, since downsides are fixable
> while inability to change is a burden.
>
> > The unfortunate thing is that end users that are meant to benefit from
> > all these helpers and them being "a standard API offering" are not
> > well represented on the BPF mailing list, unfortunately. And my
> > opinion and arguments as a proxy for theirs is clearly not enough.
>
> I also would like to hear what others on the list are thinking.

The last thing I'll say is that everything I've said above is really in
regards to the more general debate of helpers vs. kfuncs. Specifically
for the dynptrs being added in this set, I agree with Andrii that it's
arguably an odd user experience for certain platforms to support
different only specific parts of the dynptr API surface.

I'm not sure whether that's enough to warrant making them helpers
instead of kfuncs, but I do think it's not exactly an apples to apples
comparison with future features that today have no helper API presence.
Putting myself in the shoes of a dynptr user, I would be very surprised
and confused if all of a sudden, I couldn't use some of the core dynptr
APIs due to being on a platform that doesn't have kfunc support. My two
cents are that letting these dynptr functions stay as helpers, while
agreeing that kfuncs is the way forward (though I don't think Andrii
agrees with that even aside from just these dynptrs) is a reasonable
compromise that errs on the side of user-friendliness for dynptr users.

FWIW, I also don't think it's fair or logical to argue at this point in
the game that dynptrs as a concept is inherently flawed. They were super
useful for enabling the user ringbuf map type, which is a key part of
rhone / user-space scheduling in sched_ext, and I wouldn't be surprised
if ghOSt started using it as well as a way to make scheduling decisions
without trapping into the kernel as well. Also, the attendees at LSFMM
generally seemed enthusiastic about dynptrs and user ringbuf, though I
admittedly don't know who's using either feature outside of rhone.

That being said, to reiterate, I personally agree that once we take care
of a few more things for kfuncs , they're 100% the way forward over
helpers. BPF programs are kernel programs, no UAPI pain should be
necessary.
