Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782BC659441
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 03:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiL3Cqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 21:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiL3Cqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 21:46:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77115FE4
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 18:46:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so24661339pjj.2
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 18:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJjVQatpk1QRAKPLg/9+IbMz1QIJrg1ece+Kr9/x9EM=;
        b=l0n2ts7lFKGspeJyfoI/wFT+OaSi9Vhf2QIo7SQwPw2eIcW576dKx14x64zjj790tY
         TVb5NwN5CWhIYAwhijNOMkyqZQak8Wub4eVDCScTxLYuFlcANjpJ57HyQo/fzYgigz+W
         zoD+HOZMp1hg1TQvd2MX/CwMEv1JeArXwvFZebZ4PLtoccqsIkIzMAFJ/fSAeQDsZWp4
         qfIvDfzQeIr/F6tEqITM6k88hwoBUk2CqQP0FkkXzvj33KoQdeFWzbaEb1qNmWYRrLc4
         YtWdPaA8CNSJENAKJtmeh43OjVG7Ace0q0CvJRj/INbGJWOpIutAfKfA+4EiPwfmbOId
         9vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJjVQatpk1QRAKPLg/9+IbMz1QIJrg1ece+Kr9/x9EM=;
        b=W926l3FuGnOIhGv0ZN3CTTYr/sSjzeEuTfksPPZTNim1CkwF/t4mP5babcURWrgUA+
         ovVyD8CDgFP2dme4U2TURfZ3KVF9o9Cdr/3+3YbK8Tq+zELyKbLWQhXoUJR/A+y5fdeA
         cDBPN7C0gbd38pFDusFqcK+kJeHbKm+wQKnb+09rrfH9eSm+ohTQR6wSM9qcYS2yRUqV
         dFgLXVHa0+V2WjxRzr2Z5q1Qf9JmFMxoJojm8vq7GjhQKqhxCkzISNHStTBRDti0seiJ
         RF2MMKFR5VA4YZWl/6CVnO+1TOAFzihesYiTAjUCAJDC3gGCziMMeBYibiG13OWEH7oe
         eGFw==
X-Gm-Message-State: AFqh2kq6i/XakMsv9nl7wXXdysOuEH94cgc8ool92P6XCcO4p1X5Ik3K
        gQhq1cjdYoQzAGfba7DmHm0=
X-Google-Smtp-Source: AMrXdXssQbMMXI5Slx0WVgtCs3kLf1I8aCygLAB2t8kx6PXtADO4ID5ToZ7zgfGtkfjk/L7C9g5SbA==
X-Received: by 2002:a17:902:ee13:b0:187:c49:5a1a with SMTP id z19-20020a170902ee1300b001870c495a1amr33780813plb.17.1672368404268;
        Thu, 29 Dec 2022 18:46:44 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::4:afb4])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902d1d500b0019262dfa3ecsm12141403plb.112.2022.12.29.18.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:46:43 -0800 (PST)
Date:   Thu, 29 Dec 2022 18:46:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 03:10:22PM -0800, Andrii Nakryiko wrote:
> On Sun, Dec 25, 2022 at 1:52 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Dec 20, 2022 at 11:31:25AM -0800, Andrii Nakryiko wrote:
> > > On Fri, Dec 16, 2022 at 9:35 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> > > > >
> > > > > There is no clean way to ever move from unstable kfunc to a stable helper.
> > > >
> > > > No clean way? Yet in the other email you proposed a way.
> > > > Not pretty, but workable.
> > > > I'm sure if ever there will be a need to stabilize the kfunc we will
> > > > find a clean way to do it.
> > >
> > > You can't have stable and unstable helper definition in the same .c
> > > file,
> >
> > of course we can.
> > uapi helpers vs kfuncs argument is not a black and white comparison.
> > It's not just stable vs unstable.
> > uapi has strict rules and helpers in uapi/bpf.h have to follow those rules.
> > While kfuncs in terms of stability are equivalent to EXPORT_SYMBOL_GPL.
> > Meaning they are largely unstable.
> > The upsteam kernel keeps changing those EXPORT_SYMBOL* functions,
> > but distros can apply their own "stability rules".
> > See Redhat's kABI, for example. A distro can guarantee a stability
> > of certain EXPORT_SYMBOL* for their customers, but that doesn't bind
> > upstream development.
> >
> > With uapi bpf helpers we have to guarantee their stability,
> > while with kfuncs we can do whatever we want. Right now all kfuncs are
> > unstable and to prove the point we changed them couple times already (nf_conn*).
> > We also have bpf_obj_new_impl() kfunc which is equivalent to EXPORT_SYMBOL(__kmalloc).
> > Hard to imagine more stable and more fundamental function.
> > Of course we want bpf programs to use bpf_obj_new() and assume
> > that it's going to be available in all future kernel releases.
> > But at the same time we're not bound by uapi rules.
> > bpf_obj_new() will likely be stable, but not uapi stable.
> > If we screw up (or find better way to allocate memory in the future)
> > we can change it.
> > We can invent our own deprecation rules for stable-ish kfuncs and
> > invent our more-unstable-than-current-unstable rules for kfuncs that
> > are too much kernel release dependent.
> 
> I'm talking about *mechanics* of having two incompatible definitions
> of functions with the same name, not the *concept* of stable vs
> unstable API. See [0] where I explained this as a reply to Joanne.
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzbRQLEjAFUkzzStv0c0=O+r9iZ8hq33sJB2RtSuGrGAEA@mail.gmail.com/

Mechanics for kfuncs are much better than for helpers.

extern bool bpf_dynptr_is_null(const struct bpf_dynptr *p) __ksym;

will likely work with both gcc and clang.
And if it doesn't we can fix it.

While when gcc folks saw helpers:

static bool (*bpf_dynptr_is_null)(const struct bpf_dynptr *p) = (void *) 777;

they realized that it is a hack that abuses compiler optimizations.
They even invented attr(kernel_helper) to workaround this issue.
After a bunch of arguing gcc added support for this hack without attr,
but it's going to be around forever... in gcc, in clang and in kernel.
It's something that we could have fixed if it wasn't for uapi.
Just one more example of unfixable mistake that causing issues
to multiple projects.
That's the core issue of kernel uapi rules: inability to fix mistakes.

> >
> > > But regardless, dynptr is modeled as black box with hidden state, and
> > > its API surface area is bigger (offset, size, is null or not,
> > > manipulations over those aspects; then there is skb/xdp abstraction to
> > > be taken care of for generic read/write). It has a wider *generic* API
> > > surface to be useful and effectively used.
> >
> > tbh dynptr as an abstraction of skb/xdp is not convincing.
> > cilium created their own abstraction on top of skb and xdp and it's zero cost.
> > While dynptr is not free, so xdp users unlikely to use dynptr(xdp) for perf reasons.
> > So I suspect it won't be a success story in the long run, but we
> > can certainly try it out since they will be kfuncs and can be deprecated
> > if maintenance outweighs the number of users.
> >
> > > All *two* of them, bpf_get_current_task() and
> > > bpf_get_current_task_btf(), right? They are 2 years apart.
> > > bpf_get_current_task() was added before BTF era. It is still actively
> > > used today and there is nothing wrong with it. It works on older
> > > kernels just fine, even with BPF CO-RE (as backporting a few simple
> > > patches to generate BTF is simple and easy; not so much with BPF
> > > verifier changes to add native BTF support). I don't see much problem
> > > having both, they are not maintenance burden.
> >
> > bpf_get_current_pid_tgid
> > bpf_get_current_uid_gid
> > bpf_get_current_comm
> > bpf_get_current_task
> > bpf_get_current_task_btf
> > bpf_get_current_cgroup_id
> > bpf_get_current_ancestor_cgroup_id
> > bpf_skb_ancestor_cgroup_id
> > bpf_sk_cgroup_id
> > bpf_sk_ancestor_cgroup_id
> >
> > _are_ a maintenance burden.
> 
> bpf_get_current_pid_tgid() was added in 2015, slightly and
> uncritically touched by Daniel in 2016 and we never had any problems
> with it ever since. No updates, no maintenance. I don't remember much
> problem with other helpers in this list, but I didn't check each one.
> 
> But we certainly have a different understanding of what "maintenance
> burden" is. If some code doesn't require constant change and doesn't
> prevent changes in some other parts of the system, it's not a
> maintenance burden.

As I said it's not about working today. If one doesn't touch code
it will keep working.
It's about being able to change it.
The uapi bits we simply cannot change.

> 
> > The verifier got smarter and we could have removed all of them,
> > but uapi rules makes it impossible.
> > The bpf prog could have been enabled to access all these task_struct
> > and cgroup fields directly. Likely without any kfuncs.
> >
> > bpf_send_signal vs bpf_send_signal_thread
> > bpf_jiffies64 vs bpf_this_cpu_ptr
> > etc
> > there are plenty examples where uapi bpf helpers became a burden.
> > They are working and will keep working, but we could have done
> > much better job if not for uapi.
> > These are the examples where uapi rules are too strong for bpf development.
> > Our pace of adding new features is high.
> > The kernel uapi rules are too strict for us.
> 
> I'm familiar with the burden of maintaining API stability and
> backwards compat. But it's not just about the library/system

libbpf 1.0 wasn't the smoothest example of deprecation.
But we still did it despite all kinds of negative flame.
With uapi helpers we cannot do any of that. No deprecation schemes.
While kfuncs allow innovation.

> developer's convenience and burden, it's also about the end user's
> experience and convenience. BPF tool developers really appreciate when
> there are few less quirks to remember and work around across kernel
> versions, configurations, architectures, etc. It's the pain that
> kernel engineers working on BPF bleeding-edge don't experience in the
> BPF selftests environment.

There is a trade off between users and developers. We want to make user
experience as smooth as possible while preserve the speed of development
for the kernel. uapi is in the way of that.

> >
> > At one point DaveM declared freeze on sizeof(struct sk_buff).
> > It was a difficult, but correct decision.
> > We have to declare freeze on bpf helpers.
> > 211 helpers that have to be maintained forever is a huge burden.
> 
> I still didn't get why we have to freeze anything and how exactly
> helpers are a burden.
> 
> But especially in this specific case of few simple dynptr helpers,
> especially that other dynptrs generic APIs are already BPF helpers. I
> just don't get it and honestly all I see from this discussion is that
> you've made up your mind and there is nothing that can be done to
> convince you.
> 
> The only "BPF helpers are stable and thus a burden" argument is just
> not convincing and I'd even say is mostly false. There are no upsides
> to having dynptr helpers as kfuncs, as far as I'm concerned. 

The main and only upside for everything as kfunc is that we can change it.
That's it.

> But there
> are a bunch of downsides, even if some of those might be lifted in the
> future.

imo ability to change outweighs all downsides, since downsides are fixable
while inability to change is a burden.

> The unfortunate thing is that end users that are meant to benefit from
> all these helpers and them being "a standard API offering" are not
> well represented on the BPF mailing list, unfortunately. And my
> opinion and arguments as a proxy for theirs is clearly not enough.

I also would like to hear what others on the list are thinking.
