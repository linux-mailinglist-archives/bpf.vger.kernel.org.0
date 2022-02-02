Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C274A691A
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243160AbiBBAMW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 19:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243127AbiBBAMW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 19:12:22 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB787C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 16:12:21 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m17so2530486ilj.12
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 16:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TD4OvnlttATPFFjMKUsuISAvidOf+StumdRTIsdlU8=;
        b=mxmIwrJTEs0pwzqmqjueMykhARfqp7MHcSKemaKSynI5NbG8YRa6evIUMNpM74sjqb
         o0emb+pA/RSCJ6gfRw4Or3gsb4BEpB6OYbMZVkWFp07a9TD6vxUyE0X9pfJGsMl1XwIL
         qFd9yhPPHouNuzv0H0bSnb0SDZcaEgHCJxFqXsTnvCwO5teyW8m+fWF/A0p2Z9AHOQye
         JoGplaCvUno60Vtm13etmF8G8cLv/7Ej1sK4ykKlzxwZ5XKkCMLMBHH8maI4/6AatGfe
         pnvZfCtU//JjR3oV7m/tA1KkrHht40z64+ZM5j6jToaRQf6sZrtWDOm+xn3lwx2qoV/R
         Xx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TD4OvnlttATPFFjMKUsuISAvidOf+StumdRTIsdlU8=;
        b=3h870y6eclIz4hASB/2HQBiQkeDIHgLpedEgd8K1/eMEcAl+/uYpgE0paXXu/KJRDq
         BDPAGyH+0ZcWIGY17oQCN/OGGCSPW0j1X4SFW9RynmkwGBU6ejclhd8RsjjxwYXM3O6Y
         8FRNNUrPhU5XpxodOPPJGDggwhNNkFMbm4CHhDRzv+ul/JOBmBNY1t4xf3v8UZhBiFnL
         /0xBRKAfn5qZtZugyu+jLPlC2wtC8X33cJdCJt5y7VSFn2ZnRtNwN6SwBjizmIteZR9O
         nu1/cH/wowVTnKkQXuGBJ1QjqkTjyQdtGx40YwT/bsoGAQVf/W4MqjGBJBMj/7hpXshp
         T/NA==
X-Gm-Message-State: AOAM531io8Og4ozvL78Xb1K93W/lqifvIKmcCZHKXSf01dGKmW0EhBu4
        OiIVHw+He0W6FGs7pQL5mLDXSerAqke+O2qXfDI=
X-Google-Smtp-Source: ABdhPJxwIcaxr3rxWZ6WykChrnHo0dryMzCEP4PiY/ZqVKBBoDxepulrpNqPQJQz/RGQEWwkKRJwYyMraf15bEdyTIk=
X-Received: by 2002:a05:6e02:1a6c:: with SMTP id w12mr10928478ilv.305.1643760741310;
 Tue, 01 Feb 2022 16:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20220128012319.2494472-1-delyank@fb.com> <20220128012319.2494472-2-delyank@fb.com>
 <CAEf4Bzbg50Ki=ii-Y0AqzpyQnAUEc5qGLx7LW5yGebDeb540BA@mail.gmail.com> <ae55c8fc5d43517b29b1d6532eace60d82accd8a.camel@fb.com>
In-Reply-To: <ae55c8fc5d43517b29b1d6532eace60d82accd8a.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Feb 2022 16:12:10 -0800
Message-ID: <CAEf4BzY-wv-j=n1HLJBZWR_xtt4grFxwGZEevh7+2LOMh4cJEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] selftests: bpf: migrate from bpf_prog_test_run
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 1, 2022 at 4:01 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Mon, 2022-01-31 at 17:24 -0800, Andrii Nakryiko wrote:
> > for simple case like this you can just keep it single line:
> >
> > LIBBPF_OPTS(bpf_test_run_opts, topts, .repeat = 1)
> >
> > But, it seems like the kernel does `if (!repeat) repeat = 1;` logic
> > for program types that support repeat feature, so I'd suggest just
> > drop .repeat = 1 and keep it simple.
>
> Sure.
>
> >
> > let's not add new CHECK*() variants, CHECK() and its derivative are
> > deprecated, we are using ASSERT_xxx() macros for all new code.
> >
> > In this case, I think it's best to replace CHECK() with just:
> >
> > ASSERT_OK(err, "run_err");
> > ASSERT_OK(topts.retval, "run_ret_val");
> >
> > I don't think logging duration is useful for most, if not all, tests,
> > so I wouldn't bother.
>
> Ah, this makes a lot of sense, I was wondering what was going on with these
> quite unreadable CHECK{,_ATTR} macros. I'll rewrite the ones I'm changing in
> this series to use ASSERT_* if you're okay with that amount of churn?

No, it's fine with me. As I said, I'd like all CHECK()s to be gone, so
the sooner and closer we get to that the better. We have BPF CI setup
to make sure that we don't accidentally screw up checks in a major
way, so it's pretty safe to do.

>
> > You didn't have to touch this code, you could have just kept duration
> > = 0 (which CHECK() internally assumes, unfortunately).
>
> I didn't *have* to but leaving the variable around to satisfy a macro feels
> super awkward. Happy to minimize these changes, if they're going overboard but
> I'd rather clean up the CHECK usage where I can.

Heh, we do have some selftests doing `static int duration;` in a file
to satisfy CHECK() :) But I don't mind more selftest code churn to
convert to ASSERT_xxx() macros.

>
> >
> > Alternatively, just switch to ASSERT_OK_PTR(fentry_skel,
> > "fentry_skel_load"); and be done with it. As I mentioned, we are in a
> > gradual process of removing CHECK()s,
> > [...]
> > At some point we'll do the final push and remove CHECK() altogether,
> > but it doesn't have to be part of this patch set (unless you are
> > interested in doing some more mechanical conversions, of course, it's
> > greatly appreciated, but I didn't yet have heart to ask anyone to do
> > those 2000 conversions...).
>
> I don't think I have it in me to volunteer for the whole refactor but I'll do my
> bit in the usages this series touches.

No worries and thanks!
