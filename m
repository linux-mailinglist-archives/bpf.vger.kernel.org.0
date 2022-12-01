Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F038563F316
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiLAOrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 09:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLAOro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 09:47:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC43A60E6
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 06:47:43 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b9so2127448ljr.5
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mOZm2+WpbplMIhjXLKEW8ntbgq1d2rqRnWQhJn2grU=;
        b=n49YtQdcuTIIzkEUIg/q0p3Ai7DkKCwvooMPF9uqoNpMrL3OriogZPmASpva6zWbkp
         Bvxp3lKDU9u/+lyDa78g5WMxNsVCSR841bPPlqu1oJflGs1BpDw+eXhe4UH5G/0IQ03l
         QclZHX1KCHOZSRa8YggyGju03qnmi3Fj4rgFZ3bDkzFDSzrkf7jBeK8AXHBWyGJO9reL
         8I0pEPjWrJNGuK+I3QdyViex0SVl7qelPfVdZ6BDMJOl7s7DgzdSTCrFFftHQYFzaJlJ
         sW8AFOAFD7O2KRQJKYo+LsNAS0BFa1x3Bnd/5AQV5HeCagd2xPzC+yJmkCca0LwJRkib
         5lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mOZm2+WpbplMIhjXLKEW8ntbgq1d2rqRnWQhJn2grU=;
        b=IXjr8gzK/HHfz/Ox8FFVe3nATafBQQjfK6h1vnI90Dk0R57zTiI5WCn047cMiMghgj
         xKFcV/fx2zXnz/ELGs5S6ggdO2GLLngDrK7H8dMyT/AvGb6u1u8ZSbgZEIcmugOJHe5n
         T0J0alE0Dy1EuasICHVWMQRhd/oaX5/tfY394QR+uq6IgPQVXLncEhYjZgvM+4qGFopr
         lHU8EGPoxh9Fpr7+LwiDeAezpFEua4N60IahP1gXqIABEhqiDODpe2S0EC5PDrKky43w
         +ZOJUZe5X7TA3h2Tg4CbUsbrO8kT/CbjMHutC+7zzNEDdzbp68L+H+t2iQ391V5t9Tlp
         /G/Q==
X-Gm-Message-State: ANoB5pkp5gkRMvZ8r2Bi4qEt8thxAm9ODLPNpAkYuOahJrGxg77VxX5h
        GeAmKKi4l8gcKHlXsEINhCzmFyNOXg7ugFt8HCI=
X-Google-Smtp-Source: AA0mqf4UHDZax32BmyAFTVgunpO8rC94lLbeUEIxoD721e8Iyl3aUJ5GnrxY6TC0jl2R2fkeGrpW+iiLgkSN6dydjhY=
X-Received: by 2002:a05:651c:171b:b0:26f:a90a:fd82 with SMTP id
 be27-20020a05651c171b00b0026fa90afd82mr22620448ljb.248.1669906062038; Thu, 01
 Dec 2022 06:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
 <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com>
 <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com> <CA+khW7gLUrBYLoCKPAOO8evofNjr97crX=Gw59FpZu-gM8FTHQ@mail.gmail.com>
In-Reply-To: <CA+khW7gLUrBYLoCKPAOO8evofNjr97crX=Gw59FpZu-gM8FTHQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 1 Dec 2022 22:46:44 +0800
Message-ID: <CALOAHbCqR6Qmx9n4Sq9Vdh=9ba_L1nfh9BpAwnAMq2d9xHFiiQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Hao Luo <haoluo@google.com>
Cc:     Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
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

On Thu, Dec 1, 2022 at 8:38 AM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Nov 30, 2022 at 10:07 AM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Nov 30, 2022 at 3:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > [...]
> > > I understand that allowing ID->FD transition for CAP_SYS_ADMIN only is
> > > for security.
> > > But it also prevents the user from transiting its own bpf object ID,
> > > that is a problem.
> > >
> > > > From the commit message, I'm not clear how BPF is debugged in
> > > > containers in your use case. Maybe the debugging process should be
> > > > required to have CAP_SYS_ADMIN?
> > > >
> > >
> > > Some container users will run bpf programs in their container,
> > > sometimes they want to check the bpf objects created by themselves  by
> > > using bpftool or read/write the bpf maps with their own tools. But if
> > > the bpf objects are not pinned, the only way to get these bpf objects
> > > is via SCM_RIGHTS.
> > > There should be a general way to get the FD of their own objects when
> > > CAP_BPF is enabled.
> > > With CAP_SYS_ADMIN, the container user can do almost anything, which
> > > is very dangerous.
> > > While with CAP_BPF, the risk can be kept within BPF.
> > >
> > > I think we should improve this situation by allowing the user to
> > > transit its own bpf object IDs.
> > > There are some possible solutions,
> > > 1. introduce BPF_ID namespace
> > >     Let's use namespace to isolate the bpf object ID instead of
> > > preventing them from reading all IDs.
> > > 2. introduce a global sysctl knob to allow users to do the ID->FD transition
> > >     for example, introduce a new value into unprivileged_bpf_disabled.
> > >     -0 Unprivileged calls to ``bpf()`` are enabled
> > >    +0 Unprivileged calls to ``bpf()`` are enabled except the calls
> > >    +  which explicitly requires ``CAP_BPF`` or ``CAP_SYS_ADMIN``
> > >     1 Unprivileged calls to ``bpf()`` are disabled without recovery
> > >     2 Unprivileged calls to ``bpf()`` are disabled
> > >   +3 All unprivileged calls to ``bpf()`` are enabled
> > >
> > > WDYT ?
> >
> > Personally, I think some namespace might be the solution we need.
> > But adding a namespace is a lot of work, so we need to make sure to
> > do it correctly.
> >
> > This might be a good topic to discuss in the BPF office hour.
> >
>
> I think namespace is more preferable. A discussion in the BPF office
> hour sounds good.
>
> Following are my thoughts:
>

Thanks for your thoughts.

> 1. What does the BPF_ID namespace look like? Will it be like the PID
> namespace, remapping IDs in each namespace? or just restricting the
> object IDs visible to the users?
>

I prefer the former.  It looks like the PID namespace, which also uses
the idr_alloc().

> 2. What's wrong with passing FD? Is it really necessary to introduce a
> namespace for this purpose?
>

Passing FD is not flexible, and generic tools like bpftool can't work.
In the long run, I think the restriction of CAP_SYS_ADMIN should be
replaced by better isolation mechanisms, so introducing a namespace to
replace it won't be a bad idea.

> 3. IIRC, Song proposed introducing a namespace for BPF isolation, not
> just isolating IDs [1]. How does it relate to the BPF_ID namespace?
>
> [1] https://lore.kernel.org/all/CAPhsuW6c17p3XkzSxxo7YBW9LHjqerOqQvt7C1+S--8C9omeng@mail.gmail.com/

I have looked through the slides of this proposal, but failed to
figure out how Song will design the BPF namespace. Maybe Song can give
us a better explanation.
Per my understanding, the goal of Song's proposal should be combined
by many namespaces and other isolation mechanisms.  For example, with
the help of PID namespace, we can make sure only the tasks in this
container can be traced by the bpf programs running in it.

-- 
Regards
Yafang
