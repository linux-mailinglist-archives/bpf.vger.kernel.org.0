Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02D63E695
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 01:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLAAiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 19:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLAAiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 19:38:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2953AC20
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 16:38:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso3051212pjb.1
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf4u8STDIJ7ZPXurhpY615u2XnKVugK+E2ClxYkVvn0=;
        b=H17vMOj2c2NXEyrlpFYzVNyarbSq4Yd6YQeNCsJ9altJCky+Fn4o0nrVMALycw6mAR
         9Sz2QJHenlYOU+UkSUto63SdkZOheoh/7oQzuFxjdTUrIQPF4ppeTbIYZOgY4vIw7JSK
         JrB/N8PxzRb4JndkERh5rAXK/qZ3dZGsFL4Cx9e1vOKxS6qvrA6SVjv35YVZg6q8xfqe
         V/ZbSIfKBcuoEsk5QVk+kQvRUFbrmaTidiGGk9zVOsFHxXvTDk+7Hv6wA4typI9rQhcZ
         JX8uVHYkwu14/Oai590ev3muaoZ+24B73lrVa1JbFpCx3fLxR9CnvS3L57qwvEieqAaL
         CSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kf4u8STDIJ7ZPXurhpY615u2XnKVugK+E2ClxYkVvn0=;
        b=WZAsnmDkRBELbbNRKzcYhi6AAHqDOF9cNnEtUb6iN1GUg61EyA9uhL2A6R/MesVRjG
         e/0rLTSE/4qE/65dYWsTelo41dKs4sFKCm9CPQtBUgDAXKjbx5k7+Db1/ahIaPCzyCWV
         77GRmpKLt/NnQaWsVRz21qOSdXYhzpclfV4eHrewF9Vw1ecakoY+ww+C4m2SirCJqsRe
         NhJhEJuJM3i7b2lMAc8Y0vxTZSY8vPqY2PYf1xin0ubigAIxM7C476a4+UMpQsKR2MO9
         TKBOF+42CpzpUOfObmzdj9lKHbEBJSqCCwXwMMHzr1iNv+1oSXdBPinO6THyw92OedRO
         NOWw==
X-Gm-Message-State: ANoB5pngrKwmzQBIIB2K+l0C6oA6z5Ix5ceBD+gymOouUWAZd72xnKD1
        hX25y1jKk3ZROFB1/MepF2/Y8wV2ufKkhi0H3Qcy9w==
X-Google-Smtp-Source: AA0mqf5ewTDJM0MBBEk7PsgHmnfYFgvAYaYYHxXH80bhWCZoI2kuCT2HLyzklQfVDHhaOzfXZyWOh/i4suv/jNrVSwg=
X-Received: by 2002:a17:902:70c9:b0:176:a0cc:5eff with SMTP id
 l9-20020a17090270c900b00176a0cc5effmr54321264plt.128.1669855084558; Wed, 30
 Nov 2022 16:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
 <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com> <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
In-Reply-To: <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 30 Nov 2022 16:37:53 -0800
Message-ID: <CA+khW7gLUrBYLoCKPAOO8evofNjr97crX=Gw59FpZu-gM8FTHQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Song Liu <song@kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 10:07 AM Song Liu <song@kernel.org> wrote:
>
> On Wed, Nov 30, 2022 at 3:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> [...]
> > I understand that allowing ID->FD transition for CAP_SYS_ADMIN only is
> > for security.
> > But it also prevents the user from transiting its own bpf object ID,
> > that is a problem.
> >
> > > From the commit message, I'm not clear how BPF is debugged in
> > > containers in your use case. Maybe the debugging process should be
> > > required to have CAP_SYS_ADMIN?
> > >
> >
> > Some container users will run bpf programs in their container,
> > sometimes they want to check the bpf objects created by themselves  by
> > using bpftool or read/write the bpf maps with their own tools. But if
> > the bpf objects are not pinned, the only way to get these bpf objects
> > is via SCM_RIGHTS.
> > There should be a general way to get the FD of their own objects when
> > CAP_BPF is enabled.
> > With CAP_SYS_ADMIN, the container user can do almost anything, which
> > is very dangerous.
> > While with CAP_BPF, the risk can be kept within BPF.
> >
> > I think we should improve this situation by allowing the user to
> > transit its own bpf object IDs.
> > There are some possible solutions,
> > 1. introduce BPF_ID namespace
> >     Let's use namespace to isolate the bpf object ID instead of
> > preventing them from reading all IDs.
> > 2. introduce a global sysctl knob to allow users to do the ID->FD transition
> >     for example, introduce a new value into unprivileged_bpf_disabled.
> >     -0 Unprivileged calls to ``bpf()`` are enabled
> >    +0 Unprivileged calls to ``bpf()`` are enabled except the calls
> >    +  which explicitly requires ``CAP_BPF`` or ``CAP_SYS_ADMIN``
> >     1 Unprivileged calls to ``bpf()`` are disabled without recovery
> >     2 Unprivileged calls to ``bpf()`` are disabled
> >   +3 All unprivileged calls to ``bpf()`` are enabled
> >
> > WDYT ?
>
> Personally, I think some namespace might be the solution we need.
> But adding a namespace is a lot of work, so we need to make sure to
> do it correctly.
>
> This might be a good topic to discuss in the BPF office hour.
>

I think namespace is more preferable. A discussion in the BPF office
hour sounds good.

Following are my thoughts:

1. What does the BPF_ID namespace look like? Will it be like the PID
namespace, remapping IDs in each namespace? or just restricting the
object IDs visible to the users?

2. What's wrong with passing FD? Is it really necessary to introduce a
namespace for this purpose?

3. IIRC, Song proposed introducing a namespace for BPF isolation, not
just isolating IDs [1]. How does it relate to the BPF_ID namespace?

[1] https://lore.kernel.org/all/CAPhsuW6c17p3XkzSxxo7YBW9LHjqerOqQvt7C1+S--8C9omeng@mail.gmail.com/
