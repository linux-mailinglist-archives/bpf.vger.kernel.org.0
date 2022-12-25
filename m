Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF5655E69
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 23:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLYVwT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 16:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYVwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 16:52:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670232720
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 13:52:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso11446894pjb.1
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grOYH7hEEediwHZ9rTSJgHKGU7n+Zxw5IeM6JXac7Y8=;
        b=Ec+Wm4kAmh7erZdb0Kq0agyZYeSp+hwkVOpJb4oWLKO76RdNyiYvVkn/ms/GfaK8yi
         /jHcDF60BHQ5h6klR0AJAMOh+UfWrXEzc3ok3wrev/KpaWS8ANf7+6GVPZsDXfWJVmGq
         TlRTES05R6ehdxy26mz4g/SZ/pqWfu1IWYKts6tRcNr2XAEaWop3K19dGphat5Rcd7nt
         EXdlydSeeovJIxCnz636ws99B0xa2bp5Y985AMBh6jruhNkpSnffjtSUvdB9brgYMj7y
         118MVK/dg8z/WSc/z8xH812VDgFwr0VNx5UPgirwY1SEeoAwTN5Y4gbj44ZwRqNQIRy6
         sSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grOYH7hEEediwHZ9rTSJgHKGU7n+Zxw5IeM6JXac7Y8=;
        b=286xnZW90ZiBFP16cXzT/3EiKvyyZDK+CAJb3z4bnAfg1Z4/MTUM/R21M/QvYonrtE
         H/WwjDMhzIbbHdxbjcnK8eJwb8H2so3oEkfOt1ZNe62W7eeiUOKM+rlbePxkodHkdbnO
         lqHWkKGFKVQ01lAy4xvn6IUcC3GoRftQlxx3O5v8aliy6uxcWfx2kZ+syLS+dSVKM0ul
         CDasu8Fp0IIueSJ3ZLqrvQVC1SldipwQLLh768fVy3zkKAzhijLP9LhJTZkke/ZjhgoM
         5ftOHdOGUGduJ/OsrILSgYXxISW3y9xdpUrQl5Ah+JRLUoo7WHL/c16wk439+6/ITgJP
         v6AA==
X-Gm-Message-State: AFqh2kpq2SUe76ZOtnNq1GNvXLDp+O3oSud4/86mvWfQXq+MLK4xPKO8
        AnOjzFujLGqttLNk8OoDhhk=
X-Google-Smtp-Source: AMrXdXtMAi8r9F60mRNKGG9AG9daHglm4CuqSsCUf4ViNVvAk4sm/zsxpVJO/K6m0CnWNDYgU0GCxg==
X-Received: by 2002:a05:6a20:2d28:b0:b2:5a61:da0e with SMTP id g40-20020a056a202d2800b000b25a61da0emr21318177pzl.62.1672005134698;
        Sun, 25 Dec 2022 13:52:14 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:68a7])
        by smtp.gmail.com with ESMTPSA id g7-20020aa79f07000000b005758d26fbf7sm5668139pfr.58.2022.12.25.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:52:13 -0800 (PST)
Date:   Sun, 25 Dec 2022 13:52:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
Subject: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr convenience
 helpers
Message-ID: <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
 <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
 <CAEf4BzZM0+j6DXMgu2o2UvjtzoOxcjsJtT8j-jqVZYvAqxc52g@mail.gmail.com>
 <20221216173526.y3e5go6mgmjrv46l@MacBook-Pro-6.local>
 <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 20, 2022 at 11:31:25AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 16, 2022 at 9:35 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Dec 12, 2022 at 12:12:09PM -0800, Andrii Nakryiko wrote:
> > >
> > > There is no clean way to ever move from unstable kfunc to a stable helper.
> >
> > No clean way? Yet in the other email you proposed a way.
> > Not pretty, but workable.
> > I'm sure if ever there will be a need to stabilize the kfunc we will
> > find a clean way to do it.
> 
> You can't have stable and unstable helper definition in the same .c
> file,

of course we can.
uapi helpers vs kfuncs argument is not a black and white comparison.
It's not just stable vs unstable.
uapi has strict rules and helpers in uapi/bpf.h have to follow those rules.
While kfuncs in terms of stability are equivalent to EXPORT_SYMBOL_GPL.
Meaning they are largely unstable.
The upsteam kernel keeps changing those EXPORT_SYMBOL* functions,
but distros can apply their own "stability rules".
See Redhat's kABI, for example. A distro can guarantee a stability
of certain EXPORT_SYMBOL* for their customers, but that doesn't bind
upstream development.

With uapi bpf helpers we have to guarantee their stability,
while with kfuncs we can do whatever we want. Right now all kfuncs are
unstable and to prove the point we changed them couple times already (nf_conn*).
We also have bpf_obj_new_impl() kfunc which is equivalent to EXPORT_SYMBOL(__kmalloc).
Hard to imagine more stable and more fundamental function.
Of course we want bpf programs to use bpf_obj_new() and assume
that it's going to be available in all future kernel releases.
But at the same time we're not bound by uapi rules.
bpf_obj_new() will likely be stable, but not uapi stable.
If we screw up (or find better way to allocate memory in the future)
we can change it.
We can invent our own deprecation rules for stable-ish kfuncs and
invent our more-unstable-than-current-unstable rules for kfuncs that
are too much kernel release dependent.

> But regardless, dynptr is modeled as black box with hidden state, and
> its API surface area is bigger (offset, size, is null or not,
> manipulations over those aspects; then there is skb/xdp abstraction to
> be taken care of for generic read/write). It has a wider *generic* API
> surface to be useful and effectively used.

tbh dynptr as an abstraction of skb/xdp is not convincing.
cilium created their own abstraction on top of skb and xdp and it's zero cost.
While dynptr is not free, so xdp users unlikely to use dynptr(xdp) for perf reasons.
So I suspect it won't be a success story in the long run, but we
can certainly try it out since they will be kfuncs and can be deprecated
if maintenance outweighs the number of users.

> All *two* of them, bpf_get_current_task() and
> bpf_get_current_task_btf(), right? They are 2 years apart.
> bpf_get_current_task() was added before BTF era. It is still actively
> used today and there is nothing wrong with it. It works on older
> kernels just fine, even with BPF CO-RE (as backporting a few simple
> patches to generate BTF is simple and easy; not so much with BPF
> verifier changes to add native BTF support). I don't see much problem
> having both, they are not maintenance burden.

bpf_get_current_pid_tgid
bpf_get_current_uid_gid
bpf_get_current_comm
bpf_get_current_task
bpf_get_current_task_btf
bpf_get_current_cgroup_id
bpf_get_current_ancestor_cgroup_id
bpf_skb_ancestor_cgroup_id
bpf_sk_cgroup_id
bpf_sk_ancestor_cgroup_id

_are_ a maintenance burden.
The verifier got smarter and we could have removed all of them,
but uapi rules makes it impossible.
The bpf prog could have been enabled to access all these task_struct
and cgroup fields directly. Likely without any kfuncs.

bpf_send_signal vs bpf_send_signal_thread
bpf_jiffies64 vs bpf_this_cpu_ptr
etc
there are plenty examples where uapi bpf helpers became a burden.
They are working and will keep working, but we could have done
much better job if not for uapi.
These are the examples where uapi rules are too strong for bpf development.
Our pace of adding new features is high.
The kernel uapi rules are too strict for us.

At one point DaveM declared freeze on sizeof(struct sk_buff).
It was a difficult, but correct decision.
We have to declare freeze on bpf helpers.
211 helpers that have to be maintained forever is a huge burden.
All new features should use kfuncs and we need to figure out a deprecation
and stability story for them. How to document kfuncs cleanly,
how to discover them, etc.
