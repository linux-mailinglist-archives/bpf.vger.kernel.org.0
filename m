Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C804EB87E
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 04:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiC3CwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiC3CwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 22:52:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27E173F40
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 19:50:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e22so23286169ioe.11
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGBLANkgMIOa5nn6xA81zXQSzVtutGAnfVtu1fNPubY=;
        b=jmqO2EB3txbD1/ldJ6NXA+iK/KptyakFzEPqPzRzJ3MLwtYYhlHeHGbT/3XRZRci/P
         OtK4PlmgP08UvEkkzM3vXJkdGusGk2K8wYtpxSXbsZsSRe54DURGx+6rcKOrM6jAl2K5
         VLqCETghpqyoG4OnomYNInH3meVvuuqXTQC7UqTnnnFIonWthyJoYORvz7hZJCJpF7jy
         1EKtC9J6cJFgqczlrrrF8DojTSy++f5Qw2vwYYbVtz3smSjuUlLwNvdxp9qhYna3MbWv
         lZxHo6DUmbqsZXoM/qRHj8AX5WknyLOxf9YFZMhxomSol0p+wNyAevB0+TawbcmqAyY+
         n+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGBLANkgMIOa5nn6xA81zXQSzVtutGAnfVtu1fNPubY=;
        b=X9NJAJleHuiydHJDjnZSVqk95JVK6+KKams7ZUW9ITf68/TUFxThvu0MNKycj9A3jc
         R/agPwO2ArcjBN+fX4S93ou2gmBrnMR8/xGRJvvrYdSIuoutLIc18u9GKx9fxWXVnfKK
         pmmXC5vU1jJ43ljTMM+JxpnMyB4pZNi/VNvTcZA4sx6hTTawYGRXKoI/q8ZavxLwA/fy
         +IuPC6vdGLFjFhd8D7ieZMZwV+FgqW4au3OxIpMo51IvYDIFufazQmWr234/kO5FjdV5
         dmL2T+pyWQZTua2JTyRzw7RcqG3Uucczsri2e/mVkNL2Gs3N/JHMWpeqIT+RA4Q41A/A
         Bhlw==
X-Gm-Message-State: AOAM533wI4YVAsJe4p2sXujRuwZd1B/zswgg9lcR1wwhuXI+YGnwJlZ9
        RocGi7Qhau+4GfA5paSZ2wAN+6IMU6MvX5kj+mY=
X-Google-Smtp-Source: ABdhPJzxMnBG5DUiaefi94GCOjowCk3afhASI7SMa7kTsGqu6N3bAkuQQ9IrRn/fkUuwxIb4F/jU5Y5THqO3LdGkAB0=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr2973406jav.93.1648608626037; Tue, 29
 Mar 2022 19:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220326144320.560939-1-hengqi.chen@gmail.com>
 <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com> <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com>
In-Reply-To: <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Mar 2022 19:50:14 -0700
Message-ID: <CAEf4BzYBzOEDgE+KH9jgUu89=GT7GeMNXx3Rwek4La5wKZZ-AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs interface
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 29, 2022 at 7:30 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hello, Andrii
>
> On 2022/3/30 7:18 AM, Andrii Nakryiko wrote:
> > On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> On some old kernels, kprobe auto-attach may fail when attach to symbols
> >> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
> >> but don't allow attach to a symbol with '.' ([0]). Add a new option to
> >> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
> >> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
> >> custom sec handler to handle such case.
> >>
> >>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >
> > It's sad, but it makes sense. But, let's have a selftests that
> > validates uses legacy option explicitly (e.g., in
> > prog_tests/attach_probe.c). Also, let's fix this limitation in the
>
> OK, will add a selftest to exercise the new option.
>
> > kernel? It makes no sense to limit attaching to a proper kallsym
> > symbol.
>
> This limitation is lifted in newer kernel. Kernel v5.4 don't have this issue.

Oh, ok. So how about another plan of attack then: if kprobe target
function has '.' *and* we are on the kernel that doesn't support that,
switch to legacy kprobe automatically? No need for a new option,
libbpf handles this transparently.

Still need a test for kprobe with '.' in it, though not sure how
reliable that will be... We can use kallsyms cache to check if
expected xxx.isra.0 (or whatever) is present, and if not - skip
subtest?

>
> >
> >>  tools/lib/bpf/libbpf.c | 9 ++++++++-
> >>  tools/lib/bpf/libbpf.h | 4 +++-
> >>  2 files changed, 11 insertions(+), 2 deletions(-)
> >>
> >
> > [...]
>
> --
> Hengqi
