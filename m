Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12D648ABD
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLIWYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 17:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLIWYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 17:24:23 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A213F60
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 14:24:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i186so7166076ybc.9
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qps69tDaUX4GgluHwWigtRdppzDv1qR9M/+BASYIvU=;
        b=a7fuU0L+lnDxuF7QFFD6gzSQLStVUIE7NeGaXRRJeEzKBXM8yUSa2VHNoj//Q76uIE
         EaWKBlZpkdZFhj1b6JUIFntsJJ0ZBYttZGe4obTJsx+/80Ov+FWJjE5joRtVBoOkfcgL
         q2mcoyKubJUg6f4bRtreejnemVQy8DYIevRZIoks7aeRxsF5jjp4RFnISARfoEJReOoV
         Djf59pZ9POn6MIAVRodW1e1zvZtZiWuB9CGMFBdWK/5ICXVscDR+fIR9DkNUyt8QeXNk
         tSSmJ/xTejWkHCAVffyS2Pc6US5okxPjshHymzJE1Sozlz8Go02NE7urq9R6g3pGhIHk
         evqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qps69tDaUX4GgluHwWigtRdppzDv1qR9M/+BASYIvU=;
        b=4d6TA+tATofaWhzz60eIE7BJ564qnXYZNZM4wAKXPZEloo8BBR30hPvXdWwny+83qS
         RYArCSbMTgmUzDrGdzfkgkcc2w+sQh90pWcPGlvkW/GOd9vcRerQW89XbcB9IQ1p5p1V
         RWjriuQMzc55aZVhg0/GN/VX2Y/59bbmJeUbhh5BHsMa2C5Ol4WzUQEh1brAQoHeg95c
         fUH1jBRxLIjbuAEepmjiJe79C8tysm48nJJ6mH2NqG26xGnTn8PUuPwf5F+X2gDUHIYL
         yc3Fj8uKofCvNd5g/LXlcXhm51WyqHgklpXs282eaZN2G7zMMpo8BtTsBHPm3aD/FPpg
         1Q5A==
X-Gm-Message-State: ANoB5pkcM4/s0DVdz+Nt06I4XC6AJpoBpUNqNJqQ1i1aeBogGhlw9hSq
        243Bu+T4Qq/TsMpAAVAqw71Dld83Z5dfw5/9sgE=
X-Google-Smtp-Source: AA0mqf6IbFFWjlKV5DsZ5GMlvPtyBokwGOO5qVB1Conn5wpp9eJdrrGIqMAdJdn0uPad+jxAi6gTD4a7RVQ8YHixg9M=
X-Received: by 2002:a25:d8d1:0:b0:70c:bbcb:3432 with SMTP id
 p200-20020a25d8d1000000b0070cbbcb3432mr4101473ybg.173.1670624660529; Fri, 09
 Dec 2022 14:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com> <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
In-Reply-To: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 9 Dec 2022 14:24:09 -0800
Message-ID: <CAJnrk1YgfO6fk40cX0bxDko737=_w2sN8rc6we7sNUh=odxQ6Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
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

On Thu, Dec 8, 2022 at 5:30 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 8, 2022 at 4:42 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 7, 2022 at 5:54 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Dec 07, 2022 at 12:55:31PM -0800, Joanne Koong wrote:
> > > > This patchset is the 3rd in the dynptr series. The 1st can be found here [0]
> > > > and the 2nd can be found here [1].
> > > >
> > > > In this patchset, the following convenience helpers are added for interacting
> > > > with bpf dynamic pointers:
> > > >
> > > >     * bpf_dynptr_data_rdonly
> > > >     * bpf_dynptr_trim
> > > >     * bpf_dynptr_advance
> > > >     * bpf_dynptr_is_null
> > > >     * bpf_dynptr_is_rdonly
> > > >     * bpf_dynptr_get_size
> > > >     * bpf_dynptr_get_offset
> > > >     * bpf_dynptr_clone
> > > >     * bpf_dynptr_iterator
> > >
> > > This is great, but it really stretches uapi limits.
> >
> > Stretches in what sense? They are simple and straightforward getters
> > and trim/advance/clone are fundamental modifiers to be able to work
> > with a subset of dynptr's overall memory area.
> >
> > > Please convert the above and those in [1] to kfuncs.
> > > I know that there can be an argument made for consistency with existing dynptr uapi
> >
> > yeah, given we have bpf_dynptr_{read,write} and bpf_dynptr_data() as
> > BPF helpers, it makes sense to have such basic things like is_null and
> > trim/advance/clone as BPF helpers as well. Both for consistency and
> > because there is nothing unstable about them. We are not going to
> > remove dynptr as a concept, it's pretty well defined.
> >
> > Out of the above list perhaps only move bpf_dynptr_iterator() might be
> > a candidate for kfunc. Though, personally, it makes sense to me to
> > keep it as BPF helper without GPL restriction as well, given it is
> > meant for networking applications in the first place, and you don't
> > need to be GPL-compatible to write useful networking BPF program, from
> > what I understand. But all the other ones is something you'd need to
> > make actual use of dynptr concept in real-world BPF programs.
> >
> > Can we please have those as BPF helpers, and we can decide to move
> > slightly fancier bpf_dynptr_iterator() (and future dynptr-related
> > extras) into kfunc?
>
> Sorry, uapi concerns are more important here.
> non-gpl and consistency don't even come close.
> We've been doing everything new as kfuncs and dynptr is not special.
>
> > > helpers, but we got burned on them once and scrambled to add 'flags' argument.
> > > kfuncs are unstable and can be adjusted/removed at any time later.
> >
> > I don't see why we would remove any of the above list ever? They are
> > generic and fundamental to dynptr as a concept, they can't restrict
> > what dynptr can do in the future.
>
> It's not about removing them, but about changing them.
>
> Just for example the whole discussion of whether frags should
> be handled transparently and how write is handled didn't inspire
> confidence that there is a strong consensus on semantics
> of these new dynptr accessors.
>
> Scrambling to add flags to dynptr helpers was another red flag.
>
> All signs are pointing out that we're not ready do fix dynptr api.
> It will evolve and has to evolve without uapi pain.
>
> kfuncs only. For everything. Please.

Thanks for your feedback, Alexei and Andrii. I share the same opinion
as Andrii about helpers for the APIs that are straightforward (eg
bpf_dynptr_get_offset), but I see your point as well about doing
everything new as kfuncs.

I'll change this to use kfuncs for v3.
