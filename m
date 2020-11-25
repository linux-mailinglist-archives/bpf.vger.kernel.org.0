Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F852C4967
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 21:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgKYU51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 15:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgKYU51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 15:57:27 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40861C0613D4
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 12:57:27 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so5056016lfc.4
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VYYryNBAj3My0hSdQSAqcKflNrjgdtn42G8zBNZZMg=;
        b=f2G7AdObTOTz3LGEHw6rpMDF/Vzb0yHiIYN6HSeMD23t/AB5xnqQnuU4BlOHN6ZVkb
         d8bUmUmvYo1AnZE495oCDiEkS3f5WZnEjkScc0vLSrLtahER+T1MUKCcbBlGEXhGtQKe
         X6hzR6PgB+vytVgK6ZDNlhdKV5d7XKR5/ERF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VYYryNBAj3My0hSdQSAqcKflNrjgdtn42G8zBNZZMg=;
        b=Xn7QyaP+TeMqbXvmw030HYgCEeIEUFzvYZYXbE5Qdg3vTJ/eSjK1hUlTaWI1LLMUo3
         m9Wp2wtUUedL4lCdWJvV9U8sAfPsfOblTthzmSg9B+ieYl8TCkTDZ0L6AUEie9z8/rwk
         QvV2YeEli/NRfdr5OMjLgt+nUnKSJIyMXQo0FOgp/bY0Si8GIKP2x7sAtsC4cAoxMJHt
         rcn/lNA0OKlA3SqsDvp7XG7PrfYcALbm43zdvSV4TNRxxZ/tOtnKJ3H+S3WJVIYY1SOU
         YpP92kYvorO8kE7BaDxOLGpbv2V9zvb59XjdEGdSzn/BMGxMnvdDRZupDSumzEYIZ72A
         y46Q==
X-Gm-Message-State: AOAM530cOxxJPOfKIHa5/iH0Z/jTNFqMuLoke/qMWCIxsGh0dzO3/u4o
        k/kyG0wOwQ+Ac7MkQKny8MXu0poOuODcIAvkNo2Ahw==
X-Google-Smtp-Source: ABdhPJy3GTxer4jKOoITfJca2q8MF0PdRE0ROkPJoB1/qOqOH2jf/3yBkd4mJKakwQm0pHOqZT8F37x2VT2x3nV6aco=
X-Received: by 2002:a19:418d:: with SMTP id o135mr3669lfa.329.1606337845758;
 Wed, 25 Nov 2020 12:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20201125202404.1419509-1-kpsingh@chromium.org> <CAADnVQLrXjitW30nCq0N9+Tt_XzOkP5g0AcGp+wdQ0hyKiXCfQ@mail.gmail.com>
In-Reply-To: <CAADnVQLrXjitW30nCq0N9+Tt_XzOkP5g0AcGp+wdQ0hyKiXCfQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 25 Nov 2020 21:57:15 +0100
Message-ID: <CACYkzJ4ZfKDQBXy7nEVHN1zT+ZC3KWLZLmR5yey1ZjtckSB4TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add MAINTAINERS entry for BPF LSM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 25, 2020 at 9:53 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 25, 2020 at 12:24 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Similar to XDP and some JITs, also added Brendan and Florent who have
> > been reviewing all my patches internally as reviewers. The patches are
> > still expected to go via the BPF tree / list / merge workflows.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index af9f6a3ab100..09c902bee5d2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3366,6 +3366,17 @@ S:       Supported
> >  F:     arch/x86/net/
> >  X:     arch/x86/net/bpf_jit_comp32.c
> >
> > +BPF LSM (Security Audit and Enforcement using eBPF)
> > +M:     KP Singh <kpsingh@chromium.org>
> > +R:     Florent Revest <revest@chromium.org>
> > +R:     Brendan Jackman <jackmanb@chromium.org>
> > +L:     bpf@vger.kernel.org
> > +S:     Maintained
> > +F:     Documentation/bpf/bpf_lsm.rst
> > +F:     include/linux/bpf_lsm.h
> > +F:     kernel/bpf/bpf_lsm.c
> > +F:     security/bpf/
>
> I'm not sure what's the value of the additional entry.

I think it's better to add Brendan and Florent as reviewers for the LSM
bits but not the overall BPF stuff (for now). We can also keep
any tools/bpf stuff we add for LSM (at least initially) listed here.

> bpf has many different components. This is just one of them.
> Your maintainer of bpf_lsm responsibilities stay the same
> regardless of the entry in the file.

I do understand this does not entail any change in responsibilities
