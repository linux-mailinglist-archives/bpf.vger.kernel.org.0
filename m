Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370F6156D6
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 02:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiKBBBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 21:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKBBBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 21:01:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727FD95B2;
        Tue,  1 Nov 2022 18:01:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r83so17750666oih.2;
        Tue, 01 Nov 2022 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPxKHoqs1nZBvvoGdz9zFUuB17/tBWtWnfP0oY5ArZ0=;
        b=hUImzmZkcLjPzntgFucjeUqEBnNC8+NXL+wLHnZpI1n3L8/sVEpygNiulWbru+npFN
         AENvQTch6VxL4ORCFwKgGbM2iZRReJ5DKSBI13h6gij6mtZmPRXWioL9kKAZ7WlHvooB
         /8goqcBT6DQBixygb5UTg9RSwHh7zpiqgHGvLREj11Jra157x+W0W2L61FzibMySsnCW
         2k3WPDOjXsgVKvdbMUz90fe46u+pKb6ZHZANHeZPfgfDje/CocMOrmBoZCQlGDncgwpg
         HWSAKD3VjcsHoZRjpmnF2YWANbnNaFOqeJ4hhDJdUo6xIzYExnoRP0CjcYWQ7ZyAATHj
         xExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPxKHoqs1nZBvvoGdz9zFUuB17/tBWtWnfP0oY5ArZ0=;
        b=qv7ArsbC1baeDj6DJksjE60niVfRwHPIlKk6/sr+Uo201iQ0fj2ZRQt2vyaERR8W2L
         bl3HKcCikzvbyM0KCsjBNur5ybSJ/KT/gkhteYizfk4Ln+xy6HC5BXoukY0X46+HkK4b
         KXuXLQLMtjFeGmcmnIXNJp3pvX+1SiGAhAZGAwIav8uupSXfVJuW5kQvtKKBjoTCNl87
         6p9tkzVCaS2Nj251anl2fE2WNZm0XUEYtp15/5nljkM1XXZxT23LJn5fQxocmSXmRrls
         /dNs3TFWlxMqzYjxC/K+U6xiEXR4dNr/12enuqwHvolZzniOhhjYNadmAftVkPKk+PMS
         m8IA==
X-Gm-Message-State: ACrzQf3KtW9cUbi0uwAQyPpwytQT8mOZJ0Obuyar4fuh5eXsGaJrdMUK
        cVzkq8Bv2U7wWWFE4x4Hdzlf1+YHeP6ZNHPhIjA=
X-Google-Smtp-Source: AMsMyM66y7cS1rBa8dySVenleqU8yLcDEXNMxb+zPgXIXGEXgffgP3QLgYa9rW7VKq8Bg18KANBck4oMLnL1FHVTHc0=
X-Received: by 2002:a05:6808:f10:b0:355:ba4:257e with SMTP id
 m16-20020a0568080f1000b003550ba4257emr11888702oiw.58.1667350899693; Tue, 01
 Nov 2022 18:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221020222416.3415511-1-void@manifault.com> <20221020222416.3415511-2-void@manifault.com>
 <20221101000239.pbbmym4mbdbmnzjd@macbook-pro-4.dhcp.thefacebook.com>
 <Y2FhXC/s5GUkbr9P@maniforge.dhcp.thefacebook.com> <CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com>
 <Y2GRQhsyQMNCOZMT@maniforge.dhcp.thefacebook.com> <CAP01T75R+8WF7jAi5=9cvXfpKtKi9Dq6VxpuYyu7NbWjCtozNg@mail.gmail.com>
 <20221102003222.2isv2ewxxamoe6lw@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20221102003222.2isv2ewxxamoe6lw@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 2 Nov 2022 06:30:59 +0530
Message-ID: <CAP01T75cXDoKxj4c7YYrv2YLCLpRdsuWc9fVbV0Qzxii9wneGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
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

On Wed, 2 Nov 2022 at 06:02, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 02, 2022 at 04:01:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 2 Nov 2022 at 03:06, David Vernet <void@manifault.com> wrote:
> > >
> > > On Tue, Nov 01, 2022 at 01:22:39PM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Nov 1, 2022 at 11:11 AM David Vernet <void@manifault.com> wrote:
> > > > >
> > > > > > What kind of bpf prog will be able to pass 'struct nf_conn___init *' into these bpf_ct_* ?
> > > > > > We've introduced / vs nf_conf specifically to express the relationship
> > > > > > between allocated nf_conn and other nf_conn-s via different types.
> > > > > > Why is this not enough?
> > > > >
> > > > > Kumar should have more context here (he originally suggested this in
> > > > > [0]),
> > > >
> > > > Quoting:
> > > > "
> > > > Unfortunately a side effect of this change is that now since
> > > > PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> > > > functions would begin working with tp_btf args.
> > > > "
> > > > I couldn't find any tracepoint that has nf_conn___init as an argument.
> > > > The whole point of that new type was to return it to bpf prog,
> > > > so the verifier type matches it when it's passed into bpf_ct_*
> > > > in turn.
> > > > So I don't see a need for a new OWNED flag still.
> > > > If nf_conn___init is passed into tracepoint it's a bug and
> > > > we gotta fix it.
> > >
> > > Yep, this is what I'm seeing as well. I think you're right that
> > > KF_OWNED_ARGS is just strictly unnecessary and that creating wrapper
> > > types is the way to enable an ownership model like this.
> > >
> >
> > It's not just nf_conn___init. Some CT helpers also take nf_conn.
> > e.g. bpf_ct_change_timeout, bpf_ct_change_status.
> > Right now they are only allowed in XDP and TC programs, so the tracing
> > args part is not a problem _right now_.
>
> ... and it will be fine to use bpf_ct_change_timeout from tp_btf as well.
>
> > So currently it may not be possible to pass such a trusted but
> > ref_obj_id == 0 nf_conn to those helpers.
> > But based on changes unrelated to this, it may become possible in the
> > future to obtain such a trusted nf_conn pointer.
>
> From kfunc's pov trusted pointer means valid pointer.
> It doesn't need to be ref_obj_id refcounted from the verifier pov.
> It can be refcounted on the kernel side and it will be trusted.
> The code that calls trace_*() passes only trusted pointers into tp-s.
> If there is a tracepoint somewhere in the kernel that uses a volatile
> pointer to potentially uaf kernel object it's a bug that should be fixed.
>

This is all fine. I'm asking you to distinguish between
trusted-not-refcounted and trusted-and-refcounted.
It is necessary for nf_conn, since the object can be reused if the
refcount is not held.
Some other CPU could be reusing the same memory and allocating a new
nf_conn on it while we change its status.
So it's not ok to call bpf_ct_change_timeout/status on trusted
nf_conn, but only on trusted+refcounted nf_conn.

Trusted doesn't capture the difference between 'valid' vs 'valid and
owned by prog' anymore with the new definition
for PTR_TO_BTF_ID.

Yes, in most cases the tracepoints/tracing functions whitelisted will
have the caller ensure that,
but we should then allow trusted nf_conn in those hooks explicitly,
not implicitly by default everywhere.
Until then it should be restricted to ref_obj_id > 0 IMO as it is right now.

> > It is a requirement of those kfuncs that the nf_conn has its refcount
> > held while they are called.
>
> and it will be. Just not by the verifier.
>
> > KF_TRUSTED_ARGS was encoding this requirement before, but it wouldn't anymore.
> > It seems better to me to keep that restriction instead of relaxing it,
> > if it is part of the contract.
>
> Disagree as explained above.
>
> > It is fine to not require people to dive into these details and just
> > use KF_TRUSTED_ARGS in general, but we need something to cover special
> > cases like these where the object is only stable while we hold an
> > active refcount, RCU protection is not enough against reuse.
>
> This is not related to RCU. Let's not mix RCU concerns in here.
> It's a different topic.
>

What I meant is that in the normal case, usually objects aren't reused
while the RCU read lock is held.
In case of nf_conn, the refcount needs to be held to ensure that,
since it uses SLAB_TYPESAFE_BY_RCU.
This is why bpf_ct_lookup needs to bump the refcount and match the key
after that again, and cannot just return the looked up ct directly.

> > It could be 'expert only' __ref suffix on the nf_conn arg, or
> > KF_OWNED_ARGS, or something else.
>
> I'm still against that.
>

I understand (and agree) that you don't want to complicate things further.
It's fine if you want to deal with this later when the above concern
materializes. But it will be yet another thing to keep in mind for the
future.
