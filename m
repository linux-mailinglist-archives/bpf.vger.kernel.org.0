Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160F53B80E1
	for <lists+bpf@lfdr.de>; Wed, 30 Jun 2021 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhF3Khk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Jun 2021 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3Khj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Jun 2021 06:37:39 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2ADC061756
        for <bpf@vger.kernel.org>; Wed, 30 Jun 2021 03:35:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t12so2341301ile.13
        for <bpf@vger.kernel.org>; Wed, 30 Jun 2021 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYowxdHPN61Y9qY1zFymchy5MCzI2srPYMEbOZef5aE=;
        b=hgDnjDNPxcONENyswmTFE8XXY4m3HgOTeKMOhw0bVmtFmk012qRj6ji+M+7jCJTHb3
         YqIvrawiTYLD2xSy/a7hBAXqqnpbXwnSVD9IrQyaV9RUyXnbBOjyoa2Xno/TwatLesaW
         E2KuVhmqNPdoPekT1NR8HoXVWtdY3oUFW1BpS0TvTEW5YAwHrq2C8khf0i2cAMGLZZbl
         76ecF3LebTIweZEMz/VFo0JMMLMfGc/jbRK46iQT86TtR7wW9MRPTNm/bCib3OTfKJM0
         ywBTie6eJSJFyTA7Z7EDHm+jDnxHor0OMMqMpnlt170jXxFg1sZabpFHfYLnCWIzEvMZ
         lxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYowxdHPN61Y9qY1zFymchy5MCzI2srPYMEbOZef5aE=;
        b=et5cDWq5UQVZsLzv6BcEhVph6q8VnZA0pFcgkbWIcYOfT9rJ82IZTQ7GWq9qtHEesF
         ONmEqvEtfhI7+DFMKCkpV0ffqEeZmzm0GGep4uqcaUV6Ua9J5ZAUHDOavXGtDJAdHCKa
         ZkzZTiFPYb3a+6xNldVeoS78/XUviEPyhseMM81l8c5bgE2c8UVdy9WjxWS0JR79FZj3
         wkMdYeKM1QT70qddqsopRFa6bOObN4PUfD3KWb9lEwCKLd9a78lvlUpMJlO62AKSqvaM
         kw0+djor1CQtkb4SUD1d+HK9dV7pEOY/638AygI0wdol++itYPsGA/2jQaRT7kXPFlgc
         xNmw==
X-Gm-Message-State: AOAM530NX0j+E9Ihc32BA62JrtGu2GG2xHcfAMWynb8xMG7vvsGKTjmR
        H+0gLBz6KIG1Uda8FD5QDpar0Y1E+omCCegJpKylbg==
X-Google-Smtp-Source: ABdhPJxRzsAEg4/s6pozP7seom0nszwjf0oBy2qft+RSoAbYrNP/1NTOVsnnPl/qEmYA92ggPR1vT+gqOkOE+sWob4M=
X-Received: by 2002:a92:6f07:: with SMTP id k7mr14654789ilc.276.1625049310206;
 Wed, 30 Jun 2021 03:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210202135002.4024825-1-jackmanb@google.com> <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava> <YNtEcjYvSvk8uknO@krava> <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava> <YNuL442y2yn5RRdc@krava>
In-Reply-To: <YNuL442y2yn5RRdc@krava>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 30 Jun 2021 12:34:58 +0200
Message-ID: <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 29 Jun 2021 at 23:09, Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jun 29, 2021 at 06:41:24PM +0200, Jiri Olsa wrote:
> > On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
> > > On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
> > > > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> > > > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:

> > > > > > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > > > > >
> > > > >
> > > > > hum, I guess not.. will check
> > > >
> > > > nope, it locks up the same:
> > >
> > > Do you mean it locks up at commit 91c960b0056 too?

Sorry I was being stupid here - the test didn't exist at this commit

> > I tried this one:
> >   37086bfdc737 bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH
> >
> > I will check also 91c960b0056, but I think it's the new test issue

So yeah hard to say whether this was broken on PowerPC all along. How
hard is it for me to get set up to reproduce the failure? Is there a
rootfs I can download, and some instructions for running a PowerPC
QEMU VM? If so if you can also share your config and I'll take a look.

If it's not as simple as that, I'll stare at the code for a while and
see if anything jumps out.
