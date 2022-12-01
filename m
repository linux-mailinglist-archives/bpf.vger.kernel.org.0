Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F019F63F2F5
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLAOes (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 09:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLAOer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 09:34:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27AE5AE04
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 06:34:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j16so2745072lfe.12
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iezh4JJ5mFvbKg6O6m5Uisn1msWAWI7+/FJBtcFEyFQ=;
        b=E9ZpWTk8wLTmLGA6XfuZaRbVxyWJ1EO+Bo7HQaIquEKFmq5xXr3UOOJmUu2aDk6mwO
         tpmO+7hZrGjP0NKqE1x6BG3D9x6sq8LZ2PHEF1KN1XDlvJSvepvOv+NIJST9kP6zuD1s
         vpMg9Vo7LrCpXUlc6B1WhLA52wCpNiKapRH3uis3H6E+S6xdVnrymveCJR+jArRAeCHj
         pXqIwLUIaTrkaA53Hxc1X7t299CcJaI4wicXA8x9KfsRCTrBcGtx8dz5xIy9onI7Pk7c
         om74QwsC/qR24j7Tcx1ceMAFkqqO+3upQ765sUDoDvATE8lnXWqYYK9+N//QQDUsKmC6
         QeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iezh4JJ5mFvbKg6O6m5Uisn1msWAWI7+/FJBtcFEyFQ=;
        b=pl5Koig9iFEoeu6dsQJgVND0gDcmpoiRo2wvPTj5E8G+rSEmzKD7538WwRNOQlPHWH
         NWQeT5F6qssc2P+xmJLVvuiIjSbfkN7P/Vm7d9KZfoNGnqFkAVMWUPz4n5/8zbnOs0yD
         8F7DWGP+PgoAgHLCbDQ87UQHzvK8F1TgAAcKNJmq073TVbayyd5kWQZvj2HMfUS95W11
         mqMDaAaI5vIK+1xtEMatAESz4+jL8emOWIfaZ3JozFuDqfiIIAkaCds2NAHIil8hYgDc
         2HF95OHPDEJ29YiB7kv1ihmlIPi230QEfOkPW0Gkn1pGyBnu7RTQgOV1wNe1grMQdQE0
         OzPA==
X-Gm-Message-State: ANoB5pkTEoGsRnhg9HCbt/OSCdjfuxK79W2yD1pxWDSpEYMzPiefSbzG
        8akyXLBB2K8GYs5KHeaX9IBBDMkHK/Iacq+rlOg=
X-Google-Smtp-Source: AA0mqf4bFMSjPXX079cLLs25D4kL1Ucc9nxwM9iB87Dw80YzGDSsNyUaT48l/ebHe2cL2VMPtC0AGVRgH+MNsLvi3wE=
X-Received: by 2002:a19:ca02:0:b0:4a4:434e:1e07 with SMTP id
 a2-20020a19ca02000000b004a4434e1e07mr21488299lfg.172.1669905283971; Thu, 01
 Dec 2022 06:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20221129161612.45765-1-laoar.shao@gmail.com> <CA+khW7jjfQOLnx6-4UyJ8sYTj12qzp_NmiZJ-uiSwGU754hbXg@mail.gmail.com>
 <CALOAHbCGSigE9vjvw6DczLbRF=TaQ3vmh6SHvMvoAChM_6Mdfg@mail.gmail.com> <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
In-Reply-To: <CAPhsuW7B1fM=JYG0OeHPZU7isv+O2_OPc22EBsdC6ZNEWusqXA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 1 Dec 2022 22:34:07 +0800
Message-ID: <CALOAHbC1+v_xT5Jc+CN0rC27TZOaHcMA1sz5s0iJbJ368wEzPA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Allow get bpf object with CAP_BPF
To:     Song Liu <song@kernel.org>
Cc:     Hao Luo <haoluo@google.com>, ast@kernel.org, daniel@iogearbox.net,
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

On Thu, Dec 1, 2022 at 2:07 AM Song Liu <song@kernel.org> wrote:
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

Right, lots of code to write. I will think about it carefully.

> This might be a good topic to discuss in the BPF office hour.
>

Once I figure out a workable solution, I will post a proposal.

--
Regards
Yafang
