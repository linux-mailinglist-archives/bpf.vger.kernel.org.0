Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F52539514
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 18:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiEaQrs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiEaQrr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 12:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC164D9E1;
        Tue, 31 May 2022 09:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E21260DD6;
        Tue, 31 May 2022 16:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA38C3411D;
        Tue, 31 May 2022 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654015665;
        bh=5c1Ux5q09brkMilfop68xT33fNHK9r2FFOhRcKeyXB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o7qp+Ztt2w1RLNnioq7owDkKvnLT02AUV1OwX7svsMGJmUkpiQZA0RTr6Ldmg6sgy
         EGTHO1wbTdS7RZDhevtr6QLFiurVfKYDmhVmvZTe8Cyesv8uqEY4bl6ID4Xfz6R/bK
         uqLlE0oKo3nR9FeRhYS0ABEstngbxMS/CpyyiFIisapMzB15C+uBWShY2lmAlilqFR
         jN1sO0s0aBLdk9bBhkH69pDHEYm5fcXUgBzYm0i2DM7zlFxOQXxPoxvOTjJsu5n8ZU
         yZpur9AHTvLPJLZt52Rrja3585fAMyMlF0KUtZmsYRjiCNZXbI4Qjl+D1aalsxXvCA
         0Jq7oWuiXgw9A==
Received: by mail-yb1-f172.google.com with SMTP id e184so15414444ybf.8;
        Tue, 31 May 2022 09:47:45 -0700 (PDT)
X-Gm-Message-State: AOAM532ohtQj2j8EUaRE7z4pEl8LQwIpEUSpNNskLLW+N8ALzZony3Lv
        ZyoDEagUHIXN3ja8C7nPyrxACCNPt/uXfa/8Jmo=
X-Google-Smtp-Source: ABdhPJxwr54H5eIirbWhVErNoMB8gMqRYyE6lu0yredipwrORsJC/3kgELzL1JmfgqZk5ftMBSAl59X7aduV7KhJDHA=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr3545432yba.389.1654015664482; Tue, 31
 May 2022 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653861287.git.dxu@dxuuu.xyz> <CAPhsuW4nC_7L48aMJfNPcx69O6JtS7zk8p2=4Vro2S1608dztw@mail.gmail.com>
 <20220530145639.slbwvbwewonj6im2@kashmir.localdomain>
In-Reply-To: <20220530145639.slbwvbwewonj6im2@kashmir.localdomain>
From:   Song Liu <song@kernel.org>
Date:   Tue, 31 May 2022 09:47:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ah1BPBbVsOH4Q4Bd1ZAFisnwFKc768+vqTMZOHee40w@mail.gmail.com>
Message-ID: <CAPhsuW7ah1BPBbVsOH4Q4Bd1ZAFisnwFKc768+vqTMZOHee40w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Add PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 30, 2022 at 7:56 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Song,
>
> On Sun, May 29, 2022 at 11:00:48PM -0700, Song Liu wrote:
> > On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > This patchset adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs.
> > > On top of being generally useful for unit testing kprobe progs, this
> > > feature more specifically helps solve a relability problem with bpftrace
> > > BEGIN and END probes.
> > >
> > > BEGIN and END probes are run exactly once at the beginning and end of a
> > > bpftrace tracing session, respectively. bpftrace currently implements
> > > the probes by creating two dummy functions and attaching the BEGIN and
> > > END progs, if defined, to those functions and calling the dummy
> > > functions as appropriate. This works pretty well most of the time except
> > > for when distros strip symbols from bpftrace. Every now and then this
> > > happens and users get confused. Having PROG_TEST_RUN support will help
> > > solve this issue by allowing us to directly trigger uprobes from
> > > userspace.
> > >
> > > Admittedly, this is a pretty specific problem and could probably be
> > > solved other ways. However, PROG_TEST_RUN also makes unit testing more
> > > convenient, especially as users start building more complex tracing
> > > applications. So I see this as killing two birds with one stone.
> >
> > We have BPF_PROG_RUN which is an alias of BPF_PROG_TEST_RUN. I guess
> > that's a better name for the BEGIN/END use case.
>
> Right, sorry. Was getting names mixed up.
>
> >
> > Have you checked out bpf_prog_test_run_raw_tp()? AFAICT, it works as good as
> > kprobe for this use case.
>
> I just took a look -- I think it'll work for BEGIN/END use case. But
> also like I mentioned, BPF_PROG_RUN/BPF_PROG_TEST_RUN support for
> kprobes is probably still useful. For example if kprobe accesses 13th
> register. I suppose the raw_tp 12 arg limit could be lifted but it might
> be tricky to capture that logic in the absence of something like `struct
> pt_regs` to check the ctx_size_in against.

Agreed that unit tests support for kprobe programs is great.

Thanks,
Song
