Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75448CBC0
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiALTUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344510AbiALTTq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:19:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2159C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:19:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e9so6087401wra.2
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GglGXHq9IkiRqUDQ+lvY68pnSWgKtN0phJiqmJ13oi4=;
        b=mE1sJZ8Q+3YU1hjNJoBQl/i+oS2bgWSmPKAsxpPA9h2bSIgsIkuBJXKrhH4eGCn6fR
         N0eCbXwvQb5qGPHeEphaeqpI37OBYBOc1uaGG5kx2V4APjEVbIadLd1kTqw6aWzTa7i/
         5fKXQMviufYP0ONxh+RmdjyBRkhDk5O0vLUcQIwCq2DpTcd5Smihg9wsAdviYOFNng7t
         NoDGsf0sKmgqcocnvDVytevs8siMaO10a0mHcA+P0cbrlsbbygWVYctUitwMUu9NhMhW
         Ys2/rIUNajpHLUeeYXyFuRlMdZOqScYGk9xdwmFSWKFE9wwoaVMxOQsX7IbFOagMTni1
         TOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GglGXHq9IkiRqUDQ+lvY68pnSWgKtN0phJiqmJ13oi4=;
        b=J4IEJzrT5ujYbjF8todoA23SUNYiUKSQzty90vgQ8n0gDVdk4teGdZnPenWqtHNFow
         MzWrVgQqaEuybWuwcz4uXPyeRd+oAJSWJI8iAPt98oEBsOoY7DSt/VmsZZeh02/xPUn2
         HWlDozJiNJK+QM0TFoDl8xuDqeAJlgf5JMdHHgEu0KM1+2uJ0K71yR3hmIL58JPh1ydG
         6+4o93EjQ7SMJta1KHqLKdm0OcfI6YW9T9gmqEmScALX6k92oEx6ViglS2oOMJcbW2QH
         L0lQUBM2ZMODf6MflF4jRr57khW7+6wMtP9QkBiR/Qlzzd4IkUpLVs7RpCNFh6fkQ7vS
         6omA==
X-Gm-Message-State: AOAM533Hrn0D/TPvaszTC+0SFl2EEdB1QumYpgiC6kDADwQXhcnYtKKy
        sHjsI+CHWFqTafvViYDsuHMSvQyamBQ86lPckFaO9g==
X-Google-Smtp-Source: ABdhPJxovYxb5nXpSPXWYvmklOUlmV3P5LZYLUDDSpjG1oCGb/jq2ZGILATiBPZAwXxoFVFCGF9+ZRXHByS5BwNK4Lc=
X-Received: by 2002:adf:e44e:: with SMTP id t14mr1045664wrm.392.1642015184101;
 Wed, 12 Jan 2022 11:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com> <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
 <YdiTrq4Y7JwmQumc@google.com> <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
 <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7i3CMMLpHVAk9zG2GPoOiJrm1un4TgeUu-nM_Vp1C0m_g@mail.gmail.com> <CAPhsuW7srY_jncVtywOxxbtTwA43KAzKfnQyPyUNEdLCeAXKMQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7srY_jncVtywOxxbtTwA43KAzKfnQyPyUNEdLCeAXKMQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 12 Jan 2022 11:19:32 -0800
Message-ID: <CA+khW7j+NPBsR0uinPxtRyswbT6Z1Dfcjo_ZC=vMmxNdzT1OFg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
To:     Song Liu <song@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 12, 2022 at 10:55 AM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jan 11, 2022 at 10:20 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Jan 10, 2022 at 7:33 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jan 10, 2022 at 10:55:54AM -0800, Hao Luo wrote:
> > > >
> > > > I see. With attach API, are we also able to specify some attributes
> > > > for the attachment? For example, a property that we may want is: let
> > > > descendent cgroups inherit their parent cgroup's programs.
> > >
> > > Plenty of interesting ideas in this thread. Thanks for kicking it off.
> > > Maybe we should move it to office hours?
> > > The back and forth over email can take some time.
> >
> > No problem. Requested a time on Thursday (1/13/22).
>
> CC Tejun, who might be interested in this discussion.
>
> @Tejun, FYI the office hour is tomorrow 9am PST, via zoom:
>
>   https://fb.zoom.us/j/91157637485
>

Thanks Song, let me resend the whole patchset to include Tejun and cc
linux-kernel.

> Thanks,
> Song
