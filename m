Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23618391D2D
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhEZQiz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhEZQix (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 12:38:53 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D58C061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:37:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id g11so1466040ilq.3
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTd05BB9u83g9Rw1TR7BTuNQ98y93oaBclDpda30Nz4=;
        b=G4yR6k+tl95mFcr1sMEmd3PD2OAkaWyNW+VPhShlhzmuhfgGbnr41IapWtGPOhk0Vo
         +o4IGM7k3eKtoHuWeKlBw1oUp5P1DlBJXcKDkG2jIlK/ydAr4zfKmZD3CcLCbjAyudrE
         MQWdV2jojDkeRnQeloln9JaLJwfWvTelca2rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTd05BB9u83g9Rw1TR7BTuNQ98y93oaBclDpda30Nz4=;
        b=htSplPx/QH7LgHwitLponNTG3LGDL90FnYPVDHmr72k8f9KlgFHcXTnokyw9M9usgH
         SJstpU7qDUoEaZ245EiSdY0OJa/+PhCLZhNksUGGY8D5akUtOcNx3PsLFfugOC5zUINA
         A6WtXdsX8F25ge8pm6XgV255UxyrJynuAfUuWprmfRYNMel393RQ8ak/dQFBIOAq+h4u
         Do8I0TLaijWFO7hGOpXKcoPypWlmxN925eFX5H2LPx3vNoQKcYqhxgZ1p9Lzl99gIgEk
         fHvzt+jk/ckW1YNoRh0KA99bwQBfjeVgJb7W0Y5ZWGfyX1mCRIH9ArOMpgYjMZQWNOKF
         T1gw==
X-Gm-Message-State: AOAM533Atz5H0m6vFpg0VYY0XTXzcJGab9A69/OS4PxaO4ze4exio7My
        kkF7Pgnq5CZJGvjMuxYzPAclfXGbu5uZ3rDu6eIkyA==
X-Google-Smtp-Source: ABdhPJwuosw3UvSM97y5j1YtMs2JtNqDj+RDTCQ/Xl3hdVes6AOPnF2xP6pRQDQUWm3oNhC/kwYdQbC0/6p/Wq++LpI=
X-Received: by 2002:a05:6e02:1b05:: with SMTP id i5mr30226678ilv.204.1622047039981;
 Wed, 26 May 2021 09:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201825.2729018-1-revest@chromium.org> <f3e6c21e-8d6e-2665-770c-65f9b98ccf93@iogearbox.net>
 <CABRcYmKhmxUXgDa-Mr5_fNB7R-U11h4bGwFdj1pKx3hxB_mW2g@mail.gmail.com> <CAEf4BzZpRL-n0V_JaHrkrOyPgNx+_RR9cQ2fiOfVuQ=Qew11kQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZpRL-n0V_JaHrkrOyPgNx+_RR9cQ2fiOfVuQ=Qew11kQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 26 May 2021 18:37:09 +0200
Message-ID: <CABRcYmL3t=KkSai4RYPp7vH3tmS+FoVqxGYZ3rh=BReRwFouGg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 6:35 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 26, 2021 at 8:01 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, May 26, 2021 at 8:35 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >
> > > On 5/25/21 10:18 PM, Florent Revest wrote:
> > > > These macros are convenient wrappers around the bpf_seq_printf and
> > > > bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> > > > targets low level tracing primitives. bpf_helpers.h is a better fit.
> > > >
> > > > The __bpf_narg and __bpf_apply macros are needed in both files so
> > > > provided twice and guarded by ifndefs.
> > > >
> > > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Florent Revest <revest@chromium.org>
> > >
> > > Given v1/v2 both target bpf tree in the subject, do you really mean bpf or
> > > rather bpf-next?
> >
> > I don't have a preference, it's up to you :)
> >
> > On one hand, I see no urgency in fixing this: BPF_SEQ_PRINTF has been
> > in bpf_tracing.h for a while already so it can wait for another kernel
> > release. Applying this to bpf-next would do.
> > On the other hand, BPF_SNPRINTF hasn't made it to a kernel release yet
> > so we still have a chance to do it right before users start including
> > bpf_tracing.h and we'd break them in the next release. That's why I
> > tagged it as bpf.
> >
> > The patch applies cleanly on both trees so if you prefer landing it in
> > bpf-next it's fine by me.
>
> I think it should go through bpf-next. It's not really a bug fix. And
> we are not going to break anyone with this move. And libbpf 0.4 is
> officially released without this change anyway. So, bpf-next.

Sounds good, I'll send a v3 tagged with bpf-next ;)
