Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708E34273F9
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhJHXAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 19:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:00:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0DC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:58:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r19so42963930lfe.10
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYdeFgx2KCqevXUmSXyIAHihOFhidgp91Fj31Z0MMmk=;
        b=L59Z4OWTGnyHTS8Io3x4Bkca4NeZo9XiwNq6c74G8B2a6doIO7gdbePeuW6mH+6yRP
         IJJd3Yq0WndoYJ8qyPCAzEThjzC9NIDjUiOdhzU8GlV7P0AoGJwdZax6dwUK5vn9D7Fc
         3HgJB5aGgN3BmaJbBxHlHtwDJg/8Nx1xok4Mnz2Avg0YM/DE5oxvnPV6KsBT/2fVNZ76
         gpU5TO2sB//1io0nDdbmDy9cOtVyCu9qY5885CPrQfjejKRfdPat6E747ReNJMdQaNUH
         F/o41CiiJ3rq7m118YDNhPnwwXGMxwN28dfBNYG912pmp1OZcr2iRPRqdK3dZeHw6WnY
         m7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYdeFgx2KCqevXUmSXyIAHihOFhidgp91Fj31Z0MMmk=;
        b=33n3lLABmgmuPjRrwbHoeIdGs/w0442QRg57aEuRrF6hElMC65mXZpLhKjAYyPk/uW
         bRDKLBQpBETkgId7awcq0Ht62AgQYYHAHI7FXPau6RbpbS20DAOHmPiZ7s5O2istyTpV
         0Dg/yPDt1WKwU46ihGPdBeyAlxo/CtYtbIDeOLnhPcKK4apRSGE9XcJxORbhaKvC26Ku
         vyzqyRkXCJnwaCPcVYjy9zF14Fn4iEm/zmKvGME3NTMPufUwwdot0Dsl9C6bhkmVVQUo
         u5QLRc6Cic03DEZHR5bemOGkPHuSHjDd/bUe6mOLJk8J8GrEu3YgT47GFOZNlXNNav3s
         xNdw==
X-Gm-Message-State: AOAM532IL5LN3RjPwsqrsxEyBALrhc2Yhtsj+gxV5cOeRSkHNZtuZtcD
        1c+b3xp3b/2IrnWFQ0/A5JZumvsxGEsAGnnG3L9nt6Bc
X-Google-Smtp-Source: ABdhPJziaLhmvQCeCljAemh2YHGyvZmLiVijeQa1hQfqX7pfh1OxagLh9Is7Xg9EA8FaaULevKAko44iPS05Ptfh910=
X-Received: by 2002:a2e:2205:: with SMTP id i5mr6507468lji.242.1633733889415;
 Fri, 08 Oct 2021 15:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-14-fallentree@fb.com>
 <CAEf4BzZ4vUndS=sLN6qVo4P3MXW+QE2R2Xm-BPYsXWsaFNft6w@mail.gmail.com>
In-Reply-To: <CAEf4BzZ4vUndS=sLN6qVo4P3MXW+QE2R2Xm-BPYsXWsaFNft6w@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 8 Oct 2021 15:57:43 -0700
Message-ID: <CAJygYd0XquMNOF7i-3fKXui_jo=4+V6j0Bcx3DGmaUKRcUNOdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 13/14] selftests/bpf: increase loop count for perf_branches
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This make this test more likely to succeed.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
>
> 100 million iterations seems a bit excessive. Why one million loops
> doesn't cause a single perf event? Can we make it more robust in some
> other way that is not as slow? I've dropped it for now while we
> discuss.

I don't know, without this patch the test constantly fails for me
regardless of serial or parallel mode.
I think it could be something related to compiler optimizations or hardware?

>
>
> >  tools/testing/selftests/bpf/prog_tests/perf_branches.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> > index 6b2e3dced619..d7e88b2c5f36 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> > @@ -16,7 +16,7 @@ static void check_good_sample(struct test_perf_branches *skel)
> >         int duration = 0;
> >
> >         if (CHECK(!skel->bss->valid, "output not valid",
> > -                "no valid sample from prog"))
> > +                "no valid sample from prog\n"))
> >                 return;
> >
> >         /*
> > @@ -46,7 +46,7 @@ static void check_bad_sample(struct test_perf_branches *skel)
> >         int duration = 0;
> >
> >         if (CHECK(!skel->bss->valid, "output not valid",
> > -                "no valid sample from prog"))
> > +                "no valid sample from prog\n"))
> >                 return;
> >
> >         CHECK((required_size != -EINVAL && required_size != -ENOENT),
> > @@ -84,7 +84,7 @@ static void test_perf_branches_common(int perf_fd,
> >         if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> >                 goto out_destroy;
> >         /* spin the loop for a while (random high number) */
> > -       for (i = 0; i < 1000000; ++i)
> > +       for (i = 0; i < 100000000; ++i)
> >                 ++j;
> >
> >         test_perf_branches__detach(skel);
> > --
> > 2.30.2
> >
