Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFF65930F
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 00:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiL2XKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 18:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiL2XKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 18:10:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0816487
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 15:10:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c17so28426562edj.13
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2MAiN+MFIid9ikl5Hr4fTjAH8BaEFhIswV+GcMuWrw=;
        b=lAxyCSq42iws1VCTcfvSWUFGAOo8h8d9MoUBAr/v2MQe+SQ+rp4It3KXfh/JYOL5A1
         jiusR1uCljlXI3NV5MqF88UwF/Sa0SbsdYYx0KXbh0twiZDvpEk2EUUbe3WzmSXmZUfq
         Sol2APvgAcsIsMioQxlMYXdX0xI3ex6MPuJnyRzVlWPqatzdDtLJwhVtYHJqeVtLSRs+
         FuNZ7nmQNzx0srkXCndRC4vHqV84nIwBeyij/Yw8VeNwfm0eKhbd9lt9hd+py3jCRjfW
         7HhrgU51KUwH8g/O+zUUmNCWNWtiYiO/FlGSZD4GTNrn1q+8NkGRXNZKpG4h+kSxQsJ1
         vVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2MAiN+MFIid9ikl5Hr4fTjAH8BaEFhIswV+GcMuWrw=;
        b=ex4c12rSHH7hIJp5t2hmzUeiBaHYLp0M+l/5pcox9sbmVuYjdfE3PoI6gMzr2EnVel
         jvw0toqJ+yCXSiLIpKZP75A/PQErN6N8cNJtUxpS23kDrG3zQsSLbhRihyxTysYrsBGE
         nKeQSsDtI3R/bhtWJErH2G3iBV8SYMjwNTJvvWP8Z+3zoWI9Mh1Mldo00Afamjnw314x
         zT1MdGBf/okea5fLEdv2VG5MhxufYcIkwyfS0TrgHdB+DYe4qY1FtxqTDDWjZoHNOlTv
         Ch3+I6utoKfkZC1hWyAxE5E1SGXEE0vyriONwZCwclzQZyRHFE8zavUdjqczxas9g7sf
         +5zw==
X-Gm-Message-State: AFqh2krrDdHn/hGuMbQhJLENw+bed2HJmaT4AX3tY2kzdSIwOgV7gI6U
        HTKGAhGLLPzQb/ROHCA+gsuiJGhrJWattD+Xa9Y=
X-Google-Smtp-Source: AMrXdXsZcmStaw2i9mJsNyfkwVfkAo1CDr5gY8hxNdQWd3Rrc+LnVLwIcyDBrspWgKfJoT591KHp5//t0FsQxC8DSOY=
X-Received: by 2002:a05:6402:2208:b0:48a:7ada:b260 with SMTP id
 cq8-20020a056402220800b0048a7adab260mr157116edb.311.1672355433999; Thu, 29
 Dec 2022 15:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local> <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Dec 2022 15:10:22 -0800
Message-ID: <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
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

On Sun, Dec 25, 2022 at 1:52 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 20, 2022 at 11:31:25AM -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 16, 2022 at 9:35 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> > > >
> > > > There is no clean way to ever move from unstable kfunc to a stable helper.
> > >
> > > No clean way? Yet in the other email you proposed a way.
> > > Not pretty, but workable.
> > > I'm sure if ever there will be a need to stabilize the kfunc we will
> > > find a clean way to do it.
> >
> > You can't have stable and unstable helper definition in the same .c
> > file,
>
> of course we can.
> uapi helpers vs kfuncs argument is not a black and white comparison.
> It's not just stable vs unstable.
> uapi has strict rules and helpers in uapi/bpf.h have to follow those rules.
> While kfuncs in terms of stability are equivalent to EXPORT_SYMBOL_GPL.
> Meaning they are largely unstable.
> The upsteam kernel keeps changing those EXPORT_SYMBOL* functions,
> but distros can apply their own "stability rules".
> See Redhat's kABI, for example. A distro can guarantee a stability
> of certain EXPORT_SYMBOL* for their customers, but that doesn't bind
> upstream development.
>
> With uapi bpf helpers we have to guarantee their stability,
> while with kfuncs we can do whatever we want. Right now all kfuncs are
> unstable and to prove the point we changed them couple times already (nf_conn*).
> We also have bpf_obj_new_impl() kfunc which is equivalent to EXPORT_SYMBOL(__kmalloc).
> Hard to imagine more stable and more fundamental function.
> Of course we want bpf programs to use bpf_obj_new() and assume
> that it's going to be available in all future kernel releases.
> But at the same time we're not bound by uapi rules.
> bpf_obj_new() will likely be stable, but not uapi stable.
> If we screw up (or find better way to allocate memory in the future)
> we can change it.
> We can invent our own deprecation rules for stable-ish kfuncs and
> invent our more-unstable-than-current-unstable rules for kfuncs that
> are too much kernel release dependent.

I'm talking about *mechanics* of having two incompatible definitions
of functions with the same name, not the *concept* of stable vs
unstable API. See [0] where I explained this as a reply to Joanne.

  [0] https://lore.kernel.org/bpf/CAEf4BzbRQLEjAFUkzzStv0c0=O+r9iZ8hq33sJB2RtSuGrGAEA@mail.gmail.com/

>
> > But regardless, dynptr is modeled as black box with hidden state, and
> > its API surface area is bigger (offset, size, is null or not,
> > manipulations over those aspects; then there is skb/xdp abstraction to
> > be taken care of for generic read/write). It has a wider *generic* API
> > surface to be useful and effectively used.
>
> tbh dynptr as an abstraction of skb/xdp is not convincing.
> cilium created their own abstraction on top of skb and xdp and it's zero cost.
> While dynptr is not free, so xdp users unlikely to use dynptr(xdp) for perf reasons.
> So I suspect it won't be a success story in the long run, but we
> can certainly try it out since they will be kfuncs and can be deprecated
> if maintenance outweighs the number of users.
>
> > All *two* of them, bpf_get_current_task() and
> > bpf_get_current_task_btf(), right? They are 2 years apart.
> > bpf_get_current_task() was added before BTF era. It is still actively
> > used today and there is nothing wrong with it. It works on older
> > kernels just fine, even with BPF CO-RE (as backporting a few simple
> > patches to generate BTF is simple and easy; not so much with BPF
> > verifier changes to add native BTF support). I don't see much problem
> > having both, they are not maintenance burden.
>
> bpf_get_current_pid_tgid
> bpf_get_current_uid_gid
> bpf_get_current_comm
> bpf_get_current_task
> bpf_get_current_task_btf
> bpf_get_current_cgroup_id
> bpf_get_current_ancestor_cgroup_id
> bpf_skb_ancestor_cgroup_id
> bpf_sk_cgroup_id
> bpf_sk_ancestor_cgroup_id
>
> _are_ a maintenance burden.

bpf_get_current_pid_tgid() was added in 2015, slightly and
uncritically touched by Daniel in 2016 and we never had any problems
with it ever since. No updates, no maintenance. I don't remember much
problem with other helpers in this list, but I didn't check each one.

But we certainly have a different understanding of what "maintenance
burden" is. If some code doesn't require constant change and doesn't
prevent changes in some other parts of the system, it's not a
maintenance burden.


> The verifier got smarter and we could have removed all of them,
> but uapi rules makes it impossible.
> The bpf prog could have been enabled to access all these task_struct
> and cgroup fields directly. Likely without any kfuncs.
>
> bpf_send_signal vs bpf_send_signal_thread
> bpf_jiffies64 vs bpf_this_cpu_ptr
> etc
> there are plenty examples where uapi bpf helpers became a burden.
> They are working and will keep working, but we could have done
> much better job if not for uapi.
> These are the examples where uapi rules are too strong for bpf development.
> Our pace of adding new features is high.
> The kernel uapi rules are too strict for us.

I'm familiar with the burden of maintaining API stability and
backwards compat. But it's not just about the library/system
developer's convenience and burden, it's also about the end user's
experience and convenience. BPF tool developers really appreciate when
there are few less quirks to remember and work around across kernel
versions, configurations, architectures, etc. It's the pain that
kernel engineers working on BPF bleeding-edge don't experience in the
BPF selftests environment.

>
> At one point DaveM declared freeze on sizeof(struct sk_buff).
> It was a difficult, but correct decision.
> We have to declare freeze on bpf helpers.
> 211 helpers that have to be maintained forever is a huge burden.

I still didn't get why we have to freeze anything and how exactly
helpers are a burden.

But especially in this specific case of few simple dynptr helpers,
especially that other dynptrs generic APIs are already BPF helpers. I
just don't get it and honestly all I see from this discussion is that
you've made up your mind and there is nothing that can be done to
convince you.

The only "BPF helpers are stable and thus a burden" argument is just
not convincing and I'd even say is mostly false. There are no upsides
to having dynptr helpers as kfuncs, as far as I'm concerned. But there
are a bunch of downsides, even if some of those might be lifted in the
future.

The unfortunate thing is that end users that are meant to benefit from
all these helpers and them being "a standard API offering" are not
well represented on the BPF mailing list, unfortunately. And my
opinion and arguments as a proxy for theirs is clearly not enough.

> All new features should use kfuncs and we need to figure out a deprecation
> and stability story for them. How to document kfuncs cleanly,
> how to discover them, etc.
