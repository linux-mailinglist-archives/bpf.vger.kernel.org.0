Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A44F92D0
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiDHKXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiDHKXU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 06:23:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0514144F
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 03:21:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a6so16486395ejk.0
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXaUMWQyNVby9gQyNh0yAHaXhYaCw1nxsGNXPnfEvIw=;
        b=OTSFPGmUiDr1pNEAMdqLD8aGo77yeuobQ7iYxDYfCaYeUOuDO98HhAvuRIiqyVEqOR
         UvTKlpSSJjQHTwuIS4QtG8xRVtcxUXG5h0dqzxx6AyeJf1p/MTAilrLSOVh4ZNn5JUyw
         Qun1yPXtk2b45ynipkGJVLgcgL6ZNmXh1fEiezyXIKcY0VlVlfFsW1Pb4jiS1+wFWK/F
         D+MMijtabzokQ7oHLW5SFMYgWlXZRnCF/HIX6y2m6XkeUvX/rxa5gK11PIDe+SGTxGVo
         SEtfGjfdlNb/QaEkUVH8dL7AruaQ4WhMt2fmzRpE4tG4IjaE8WQZhyye+L9mhvJQ4SN9
         +XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXaUMWQyNVby9gQyNh0yAHaXhYaCw1nxsGNXPnfEvIw=;
        b=RKVxa8UXzgQ7xU0NT/+FDoCkH0VdiSHOiD4JHvBzfGOs9zuFIdVWpmTmq1XFAh2JVK
         faXE6cZX87b19JqBnH636x7UKlIl6tGEf74/V1E+g3LAXFxVcUSYuyvMFJO61ADtJdUt
         EEPWuDvrdsc5OSK5eBBMAExYTh5RUnTuxM50UcXie9zCb8o+g9KpmmJp752wMgcAe3Of
         KyfYbCX35fX2oypxmjI0v2EE4LiOc1GlIIogL/FjdL3uJigLcBa+qIdnmaN7JFy0aFgY
         Q42Lie/A9/cFKQwMjliXPVclFpvBHc1mM1a7olb3Ju4J9KQyyh+7GUJeAZJQxPbAyNa+
         hCUw==
X-Gm-Message-State: AOAM530ezVTWttGd1knePXZIrQLxsBl7/xGOgC8+2dzLiRmWMWt6fg+1
        lApTsz0EqqtXpFoyXZhgtbeNQtOk1MSCtpQoA2ODZQ==
X-Google-Smtp-Source: ABdhPJxdeuZZFwsx5XHxKgPpxscMLR8+lWP5nzo2+K+m5XVltT8dNU+L1Sgi4lBY/bIfm/nOYfFIPhBDeU8gAkeAJzw=
X-Received: by 2002:a17:907:9614:b0:6e7:9ff0:38d0 with SMTP id
 gb20-20020a170907961400b006e79ff038d0mr17216437ejc.313.1649413275674; Fri, 08
 Apr 2022 03:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <CAEf4BzbfFtgebrWOyfOP71Cn6ZAYXGfjLDPDNmyhzTJ3uTPFpQ@mail.gmail.com>
 <CA+i-1C1wjFcH5OMGVWt4+nB4hoSp_aVU=mv3LPtLq-5Ua-dggw@mail.gmail.com> <CAJnrk1YKaRDpW-etMzraKLHwLaVMetZGpdjujsNLSbzh4Q1LoQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YKaRDpW-etMzraKLHwLaVMetZGpdjujsNLSbzh4Q1LoQ@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Fri, 8 Apr 2022 12:21:04 +0200
Message-ID: <CA+i-1C2oea6YHatfE_4WtLTF+2JC0sxgN2fpSQ7nRci1kWRNdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Dynamic pointers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 7 Apr 2022 at 22:40, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 5:44 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Thu, 7 Apr 2022 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Apr 1, 2022 at 6:59 PM Joanne Koong <joannekoong@fb.com> wrote:
> > > >
> > > > From: Joanne Koong <joannelkoong@gmail.com>
> > > KP, Florent, Brendan,
> > >
> > > You always wanted a way to work with runtime-sized BPF ringbuf samples
> > > without extra copies. This is the way we can finally do this with good
> > > usability and simplicity. Please take a look and provide feedback.
> > > Thanks!
> >
> > Thanks folks, this looks very cool. Please excuse my ignorance, one
> > thing that isn't clear to me is does this work for user memory? Or
> > would we need bpf_copy_from_user_dynptr to avoid an extra copy?
>
> Userspace programs will not be able to use or interact with dynptrs
> directly. If there is data at a user-space address that needs to be
> copied into the ringbuffer, the address can be passed to the bpf
> program and then the bpf program can use a helper like
> bpf_probe_read_user_dynptr (not added in this patchset but will be
> part of a following one), which will read the contents at that user
> address into the ringbuf dynptr.

Ah yeah right, this is not for userspace programs just programs in the
kernel that need to read user memory; the specific case I'm thinking
of is reading the argv/env from the exec path.
bpf_probe_read_user_dynptr sounds for sure like it would solve that
case.
