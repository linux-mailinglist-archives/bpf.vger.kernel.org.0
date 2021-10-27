Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C643CEF0
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbhJ0QtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbhJ0QtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 12:49:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CBC061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 09:46:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m63so7858704ybf.7
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWiSWcojLp2c1pp7cPH+NoB96f5GqyfYdfLKYMPjrvI=;
        b=CZXMakWXFq1cykYykmWi3t+z8axuz3nCxPyO0svRt/E89HWt2cadnVQqYPvD/hjXwM
         6UXZrQzByKCRIlDftU1KgQFLBLjhZ7eFmRRFn/VXSlWPqH4/4h54f09IZ2RmxAuyIeHL
         bxnut9x8bVaOT3JJDDA5eh/6ORclriUEWK179Yww1So+ij7MxQRCYrWxgzJ6KiUMqGbP
         cDwnMLXLcd4P3gNUxVHQvGCqbN1gAAJgpd9Zw/LR6Q4UoRH4wN61DNlMNMoGBRhtmnXA
         alj5+0Dfd6T9UhAo7/6C9FibZ1CDn/UmAKsgYqSk0az3do33krHKwzXsL6L1fEvSEe5E
         nhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWiSWcojLp2c1pp7cPH+NoB96f5GqyfYdfLKYMPjrvI=;
        b=iTrYfu9xCFDtJl3vnRU7McyqKWJSIZusFiRukE3j/ATQ3uK4PdwFCiT+69hufi71EJ
         BcSniAnKofYdX/9YK3p8/quWCe+Fc3xLOngWwaYmQGfo3G7qU844Yov330Zi1FwOHAfY
         rMlZ2a0rStHbiYKaLPUQlQB2c0U5ydb0la9YFMmggUvo4UZwVsDnym5RkHvHAJx5ppGG
         b1uZjwTkX1EidZAJbZtxsadXHy4PUl1w0Kp6iXUk1lo5UQZhy834bIvjT3baTM8IV23f
         9CvSKBBjIV+JSJ6X04slcRBMOYAbOUdGKWMC1+84T3p3sjse+ppjgvEbO64PWoz8ANRP
         R0Bw==
X-Gm-Message-State: AOAM531p5woGaSneAg1fR5RWy48EWwM2lTOiTqJQYzt3cjxrWXm8XIBB
        vfjydSRbatZwGSQX0HoxMw7gaPp3CGrj5fdhot0=
X-Google-Smtp-Source: ABdhPJzoRiBNV6SLpwEyLRKojO7ZiXK7kMviETdALKgkScZU8oFXcgT/wG+Uv0AGmJ74uPEoLdhFODDsmoaP2ZAJKDQ=
X-Received: by 2002:a25:b19b:: with SMTP id h27mr7156851ybj.225.1635353215805;
 Wed, 27 Oct 2021 09:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211025223345.2136168-1-fallentree@fb.com> <20211025223345.2136168-3-fallentree@fb.com>
 <CAEf4BzZFtCreYhRy01g1mXe9iU-LdP4Td45ynXF9ztQrKXBqGQ@mail.gmail.com> <CAJygYd0pMMuZ2Q5ZJtxK=z8qKHJmRO45io+W7VJ66mGhPY1yRw@mail.gmail.com>
In-Reply-To: <CAJygYd0pMMuZ2Q5ZJtxK=z8qKHJmRO45io+W7VJ66mGhPY1yRw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Oct 2021 09:46:44 -0700
Message-ID: <CAEf4BzYV5_VLo+gU5RvneGjKtNPXS-pfn3FN+A1xtNa+W4Q3Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: print subtest status line
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 10:24 AM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 9:09 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 3:33 PM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > From: Yucong Sun <sunyucong@gmail.com>
> > >
> > > This patch restores behavior that prints one status line for each
> > > subtest executed. It works in both serial mode and parallel mode,  and
> > > all verbosity settings.
> > >
> > > The logic around IO hijacking could use some more simplification in the
> > > future.
> > >
> >
> > This feels like a big hack, not a proper solution. What if we extend
> > MSG_TEST_DONE to signal also sub-test completion (along with subtest
> > logs)? Would that work better and result in cleaner logic?
>
> I think the current solution is actually cleaner.  Yes we could add

I disagree. Subtest is a first-class citizen, even if it's harder to
parallelize due to more dynamic nature. Having protocol that reflects
the fact that test can consist of subtests is the right way to go, I
think.

> fields in task struct to record each subtest's name and status and
> generate the status line separately, but it will only work in
> situations where all tests pass.
> When there is an error, we do want to mix the status line with the
> actual stdout logs, which we won't be able to do afterwards.

I don't understand why success of failure is different. Worker
shouldn't log status line into the logs and should send subtest logs
separately from subtest name and status. And then dispatcher thread
will print log (depending on success/failure and/or verbosity
settings) and pre-defined status line. Status line is a fixed-format
thing that's derived from subtest name and its success/failure result.
It's not part of "log" per se.

>
> Besides, we will still need to implement separate logic in 3 places
> (serial mode,  parallel mode in worker process, and serial part of
> parallel mode execution). Having two copies of stdout logs is actually
> not that bad.

Which is exactly why I was asking to reuse sequential loop, so that we
only have 2 loops. You felt it's not big deal. Maybe now is time to
rethink this?

Two copies of logs is certainly a design smell, so please give it some
thought and try to fix the protocol to accommodate subtests as a
concept.

>
> >
> > > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/test_progs.c | 56 +++++++++++++++++++-----
> > >  tools/testing/selftests/bpf/test_progs.h |  4 ++
> > >  2 files changed, 50 insertions(+), 10 deletions(-)
> > >

[...]

> > > @@ -1357,6 +1387,12 @@ int main(int argc, char **argv)
> > >
> > >         env.stdout = stdout;
> > >         env.stderr = stderr;
> > > +       env.subtest_status_fd = open_memstream(
> >
> > extremely misleading name, it's not an FD at all
>
> it is indeed a file descriptor, isn't it? What's a better name for it?

FD is an integer. This one is FILE *, so it may be "file", but
certainly not an fd.

>
> >
> > > +               &env.subtest_status_buf, &env.subtest_status_cnt);
> > > +       if (!env.subtest_status_fd) {
> > > +               perror("Failed to setup env.subtest_status_fd");
> > > +               exit(EXIT_ERR_SETUP_INFRA);
> > > +       }
> > >
> > >         env.has_testmod = true;
> > >         if (!env.list_test_names && load_bpf_testmod()) {
> > > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > > index 93c1ff705533..a564215a63b1 100644
> > > --- a/tools/testing/selftests/bpf/test_progs.h
> > > +++ b/tools/testing/selftests/bpf/test_progs.h
> > > @@ -89,6 +89,10 @@ struct test_env {
> > >         pid_t *worker_pids; /* array of worker pids */
> > >         int *worker_socks; /* array of worker socks */
> > >         int *worker_current_test; /* array of current running test for each worker */
> > > +
> > > +       FILE* subtest_status_fd; /* fd for printing status line for subtests */
> > > +       char *subtest_status_buf; /* buffer for subtests status */
> > > +       size_t subtest_status_cnt;
> > >  };
> > >
> > >  #define MAX_LOG_TRUNK_SIZE 8192
> > > --
> > > 2.30.2
> > >
