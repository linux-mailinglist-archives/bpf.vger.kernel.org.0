Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D709C37499F
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 22:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhEEUtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEUtT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 16:49:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA64C061574;
        Wed,  5 May 2021 13:48:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h202so4445372ybg.11;
        Wed, 05 May 2021 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDMfQFqI//uoDmFx0L1nKcXQXu3zQsow+j5o+jsouGM=;
        b=HHaySOxX/sizuss/R6FVSVAvU+L1PbRaw39ai5J7Twm2dwIBOrYCRpo5Fmbd1vQjBS
         sNamWGyhRc0O00Hc/WaSaki4JPkDH27eO3XCj6tCJvw4QTxBcCQO+a9T2ekpuSQvJVS6
         ZmwuEDESO46AbYMy3KxCDSkcpLWY19wK85FD08ZD/E0J5kmZYgy5ZqBBGbYPpSmp5mXR
         vUm1pwfr9B3X47CkPMwGucZNxJszC3l0IBU4pafHQY+L55rNoPB9uoTBQ65gqiFPeijA
         Dq7BGuvlR1LGXolFJepoF4cjQT9s0BwZNcsx6WVC1gtEI1A1GR1mazx3fA7mSbqZs2ot
         ajvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDMfQFqI//uoDmFx0L1nKcXQXu3zQsow+j5o+jsouGM=;
        b=f5JraOAvmSruRbbuMotktiy3wPnspPIKRRKMK/xk3jxY14UwND6NPAJQmLPqgz7Ojo
         0W8Wo+W5hbmfW0+TEfC0D4M0bVPHQHD2M5A6+cdy+h3GaPkfT7rcpF9YlGRQgPYSBfEM
         l5X9rwI0c/yEDZ4gVXjIKwUEJgI068aFQvL598GeU3aGEY25tb7Y2nikmuxm5aLTL0VE
         19yoE6SaDPIg42Ez+FeJGaXBo0iI8SkBW/DKHXax1Y9DbHfVQcigcTvyEMIX59h/uJ/A
         lds5PXFN4JAm0BIn/5n70/ULlOxWXme9ncTPP1I9P8zIN9y/ocvkEFmAYYVU/DNR79ty
         DiXw==
X-Gm-Message-State: AOAM531PJHxtlLgEupuhpTTqsizKFG3uIXPNNWjKUMwvRhc2XJekRUf5
        nyRKaNPl94eHTfNjV20uYNxNNukMII3QRXMYy+w=
X-Google-Smtp-Source: ABdhPJx6A9CvMT0el4X2OtaI5DdoRiuErAAe6r3oTRJXnCt65RwuIrdhUXdsQ2XyNMXs/QOFqlG9T2T9JaoASefByjI=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr843188ybg.459.1620247701369;
 Wed, 05 May 2021 13:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org> <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
 <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net>
In-Reply-To: <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 May 2021 13:48:10 -0700
Message-ID: <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 5, 2021 at 1:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> > On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
> >>
> >> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> >> per-cpu buffer that they use to store temporary data (arguments to
> >> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> >> by the end of their scope with bpf_bprintf_cleanup.
> >>
> >> If one of these helpers gets called within the scope of one of these
> >> helpers, for example: a first bpf program gets called, uses
> >
> > Can we afford having few struct bpf_printf_bufs? They are just 512
> > bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> > only situation where this can occur, right? If someone is doing
> > bpf_snprintf() and interrupt occurs and we run another BPF program, it
> > will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> > second BPF program, etc. We can't eliminate the probability, but
> > having a small stack of buffers would make the probability so
> > miniscule as to not worry about it at all.
> >
> > Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> > the changes are minimal. Nestedness property is preserved for
> > non-sleepable BPF programs, right? If we want this to work for
> > sleepable we'd need to either: 1) disable migration or 2) instead of

oh wait, we already disable migration for sleepable BPF progs, so it
should be good to do nestedness level only

> > assuming a stack of buffers, do a loop to find unused one. Should be
> > acceptable performance-wise, as it's not the fastest code anyway
> > (printf'ing in general).
> >
> > In any case, re-using the same buffer for sort-of-optional-to-work
> > bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> > suboptimal, so seems worth fixing this.
> >
> > Thoughts?
>
> Yes, agree, it would otherwise be really hard to debug. I had the same
> thought on why not allowing nesting here given users very likely expect
> these helpers to just work for all the contexts.
>
> Thanks,
> Daniel
