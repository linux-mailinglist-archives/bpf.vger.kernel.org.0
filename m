Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3555F4276E0
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 05:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhJIDTT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 23:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhJIDTS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:19:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A53C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 20:17:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a7so25115063yba.6
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Da1ndcbL4WoXEJau5l6vSJZD753BagjN786SeSod+s=;
        b=CWDUIJy4SGVQN1wSIdkQrA3dnmcGpSRUEyLZVuiXfquIM9DKEHO+GQQiV0iuLd2Kb/
         g8kzkilA3JaAjGi6Z4FhxpAFijVzAKFKyqspC4NPraQtdn/2w1pG4HxMchsKTH6bLpvc
         R6IJhauXoA+GOEp1PAWftFV5GlSUHJM8dHvlamqetXgj558zwY9Vor0XT98Ye1w9AGF8
         W3q0gurK2PAKAmpyesohnoGFmuIcr73GYMocbPpPzxGsHk0CDpigNusyc/0X2LH4Y2ci
         X343ghvUqMnDI23IHIPxX9Z+RELOpNGn9lLk1R8e1t/SHXDB5UfgbAg92lQ8OuvJ61qv
         aVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Da1ndcbL4WoXEJau5l6vSJZD753BagjN786SeSod+s=;
        b=uECkvEtoY711x2x4+7IqH6U003J/K9vB9eAIeoJPGkNicut4rixKLjluY42F3Dvb7K
         ik5H9hICURVreuzy9TGxfV6bwYVvyV1MiQlkt59sDQo+7Cc7rJtpHILKnY61VI27pOCA
         jI059BaBfz3BftGSYl4jKnW1TTzOuvJDqqdJPnRW8WHW0o0k+WwZyVAmW6z725tccOpG
         uNMJ7E2VT4Le8OSb7fDmG58quyqj7intRJo3WSJC9lwXrnsZ1HW2yIqpek6kkwlUACHB
         DUFE1aP+Y50AD6Q94H37jg1S1ElTZqpab93QMbzJTCSrCz9yKzwLWmU7BOwhZvSjdeZ+
         saXA==
X-Gm-Message-State: AOAM530HAvs202z9VF0dTdMcFk6+/TOwgfuxzvDvHxqjAnW9H4VqyIUj
        h26FHaPG61d96LU/Fz8OE8n+P4/FbXpZiQBvemFhhNzY5Zg=
X-Google-Smtp-Source: ABdhPJzuU5YNgLQYVSlJa1m/jU3JOLVmDXL73Mr16FyukBAqgqoW6QEaosTmtvK+A/L2mLW9J0SR+Y/hDT+ip8RFK0U=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr7411160ybf.455.1633749441728;
 Fri, 08 Oct 2021 20:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-3-fallentree@fb.com>
 <CAEf4BzaOomCKAxLSShy1cF0xp4Xs22jKkyjdCNVJLrFwMwcNRw@mail.gmail.com> <CAJygYd34kafprTobpd7gT9shdpPZF=aAcYF-YY0Vs+8Hh16bAg@mail.gmail.com>
In-Reply-To: <CAJygYd34kafprTobpd7gT9shdpPZF=aAcYF-YY0Vs+8Hh16bAg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 20:17:08 -0700
Message-ID: <CAEf4Bzb8ukSDJk0sZokCVwh-7qNGKMD=PCh-aXVLQHPbgAYADA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 02/14] selftests/bpf: Allow some tests to be
 executed in sequence
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 4:06 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Fri, Oct 8, 2021 at 3:26 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > From: Yucong Sun <sunyucong@gmail.com>
> > >
> > > This patch allows tests to define serial_test_name() instead of
> > > test_name(), and this will make test_progs execute those in sequence
> > > after all other tests finished executing concurrently.
> > >
> > > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > > ---
> > >  tools/testing/selftests/bpf/test_progs.c | 60 +++++++++++++++++++++---
> > >  1 file changed, 54 insertions(+), 6 deletions(-)
> > >
> >
> > [...]
> >
> > > @@ -1129,6 +1136,40 @@ static int server_main(void)
> > >         free(env.worker_current_test);
> > >         free(data);
> > >
> > > +       /* run serial tests */
> > > +       save_netns();
> > > +
> > > +       for (int i = 0; i < prog_test_cnt; i++) {
> > > +               struct prog_test_def *test = &prog_test_defs[i];
> > > +               struct test_result *result = &test_results[i];
> > > +
> > > +               if (!test->should_run || !test->run_serial_test)
> > > +                       continue;
> > > +
> > > +               stdio_hijack();
> > > +
> > > +               run_one_test(i);
> > > +
> > > +               stdio_restore();
> > > +               if (env.log_buf) {
> > > +                       result->log_cnt = env.log_cnt;
> > > +                       result->log_buf = strdup(env.log_buf);
> > > +
> > > +                       free(env.log_buf);
> > > +                       env.log_buf = NULL;
> > > +                       env.log_cnt = 0;
> > > +               }
> > > +               restore_netns();
> > > +
> > > +               fprintf(stdout, "#%d %s:%s\n",
> > > +                       test->test_num, test->test_name,
> > > +                       test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> > > +
> > > +               result->error_cnt = test->error_cnt;
> > > +               result->skip_cnt = test->skip_cnt;
> > > +               result->sub_succ_cnt = test->sub_succ_cnt;
> > > +       }
> > > +
> >
> > Did you try to just reuse sequential running loop logic in main() for
> > this? I'd like to avoid the third test running loop copy, if possible.
> > What were the problems of reusing the sequential logic from main(),
> > they do the same work, no?
>
> Well, yes and no
>
> The loop itself is small/simple enough, I'm not sure there is a value
> to extract them to a common function with multiple arguments.

The loop has netns save/restore, stdio hijacking, output formatting,
we might add some more logic later. I'm mainly asking because there is
already a sequential loop in the main, and I was wondering if we can
reuse that (as in, let it run regardless of -j option, just run only
serial tests if -j is specified).


> I think the main issue that needs to be refactored is that log
> printing still works differently in serial mode or parallel mode,  it
> works now, but I would like to get rid of the old dump_test_log()
> function.
>
> >
> >
> > >         /* generate summary */
> > >         fflush(stderr);
> > >         fflush(stdout);
> > > @@ -1326,6 +1367,13 @@ int main(int argc, char **argv)
> > >                         test->should_run = true;
> > >                 else
> > >                         test->should_run = false;
> > > +
> > > +               if ((test->run_test == NULL && test->run_serial_test == NULL) ||
> > > +                   (test->run_test != NULL && test->run_serial_test != NULL)) {
> > > +                       fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
> > > +                               test->test_num, test->test_name, test->test_name, test->test_name);
> > > +                       exit(EXIT_ERR_SETUP_INFRA);
> > > +               }
> > >         }
> > >
> > >         /* ignore workers if we are just listing */
> > > --
> > > 2.30.2
> > >
