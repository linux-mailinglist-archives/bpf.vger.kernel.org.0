Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28317427403
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbhJHXIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 19:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbhJHXIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 19:08:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266CC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 16:06:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so44910502lfd.12
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQWbHRdz3Sjt/zFl73o7TuB1A5v/gzG9BJ0cBDyFw3g=;
        b=J+QZYqLChvvVRdWpdIdsAQmOA8SwXDNGVzAxgFprZ5zMiYaDXuEGJeIi5rxrRQrDWb
         yIFwaln+uj8UQwY4EaFSTxcatvUQ4TRAAX2C2as0gjYUk38hzvpT1oE1x+D8yeFXxwKd
         XfMEVab2aGr0iTAtGxCmZwsNtoyq0ZtUcTGGKbUpWM2oFJaiJv0PWDw6Uru1j1s3n1JK
         89/+GUya717f4y00yJiyTpj7EGbFePP5HzC2i86orJTr+502ZHn2uGVI5RNPWeLShJbu
         EM0a/chShDZus/cWSUhakKqznYRnh7hKX9nmo1X2kjD4PvZ/SK/2Lb16fAqoGPBnLBD6
         2uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQWbHRdz3Sjt/zFl73o7TuB1A5v/gzG9BJ0cBDyFw3g=;
        b=tuC1+3/sbsLvfXVGI2RDZiZirW9rChLb872AwynIRtBxFm4ljzWUrfeqOlykGeVErq
         oNz711XSPLOaOP2USxr8H5X3tDMaiA5341yLAIAdWHdVVIo+0pPmtTquTtq5dGmVYtUk
         tDA0LwjP2R82WNXLuny46+uFQKNsJkqYYnx/RtaEnoGVgzqUll7/F873aECKblhVEktS
         F6Eynq3wP0rCTCJGg7iqowEa9A4OME7tZuIswkk0sBDvdVxUiFV9kodlh8h5yhY1vPhb
         akptpi8T0ldVuZ5BitsrwOKMi01EX8lXAf5oO67g1LIO5ZgYQlM+6UrXQl1iwMglb87x
         2tIA==
X-Gm-Message-State: AOAM53119/20lpr+pKv37tf7n1TFkAx/3qk32vMlDZbP3rjXUO/JfqTE
        4MyYaE6BjY1sfNfQrL3jw5g4stQa7Umbt7ioRbE=
X-Google-Smtp-Source: ABdhPJyX7qmTmRZOm/8tzIXoy+62SHpMqDVhuJC6ki+dsvFGSaetmdaTBFBMJeBuZkotw6rL8TOPBxaint67Y6NOD1Q=
X-Received: by 2002:a05:6512:12d3:: with SMTP id p19mr13538686lfg.280.1633734402661;
 Fri, 08 Oct 2021 16:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-3-fallentree@fb.com>
 <CAEf4BzaOomCKAxLSShy1cF0xp4Xs22jKkyjdCNVJLrFwMwcNRw@mail.gmail.com>
In-Reply-To: <CAEf4BzaOomCKAxLSShy1cF0xp4Xs22jKkyjdCNVJLrFwMwcNRw@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 8 Oct 2021 16:06:15 -0700
Message-ID: <CAJygYd34kafprTobpd7gT9shdpPZF=aAcYF-YY0Vs+8Hh16bAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 02/14] selftests/bpf: Allow some tests to be
 executed in sequence
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch allows tests to define serial_test_name() instead of
> > test_name(), and this will make test_progs execute those in sequence
> > after all other tests finished executing concurrently.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c | 60 +++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 6 deletions(-)
> >
>
> [...]
>
> > @@ -1129,6 +1136,40 @@ static int server_main(void)
> >         free(env.worker_current_test);
> >         free(data);
> >
> > +       /* run serial tests */
> > +       save_netns();
> > +
> > +       for (int i = 0; i < prog_test_cnt; i++) {
> > +               struct prog_test_def *test = &prog_test_defs[i];
> > +               struct test_result *result = &test_results[i];
> > +
> > +               if (!test->should_run || !test->run_serial_test)
> > +                       continue;
> > +
> > +               stdio_hijack();
> > +
> > +               run_one_test(i);
> > +
> > +               stdio_restore();
> > +               if (env.log_buf) {
> > +                       result->log_cnt = env.log_cnt;
> > +                       result->log_buf = strdup(env.log_buf);
> > +
> > +                       free(env.log_buf);
> > +                       env.log_buf = NULL;
> > +                       env.log_cnt = 0;
> > +               }
> > +               restore_netns();
> > +
> > +               fprintf(stdout, "#%d %s:%s\n",
> > +                       test->test_num, test->test_name,
> > +                       test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> > +
> > +               result->error_cnt = test->error_cnt;
> > +               result->skip_cnt = test->skip_cnt;
> > +               result->sub_succ_cnt = test->sub_succ_cnt;
> > +       }
> > +
>
> Did you try to just reuse sequential running loop logic in main() for
> this? I'd like to avoid the third test running loop copy, if possible.
> What were the problems of reusing the sequential logic from main(),
> they do the same work, no?

Well, yes and no

The loop itself is small/simple enough, I'm not sure there is a value
to extract them to a common function with multiple arguments.
I think the main issue that needs to be refactored is that log
printing still works differently in serial mode or parallel mode,  it
works now, but I would like to get rid of the old dump_test_log()
function.

>
>
> >         /* generate summary */
> >         fflush(stderr);
> >         fflush(stdout);
> > @@ -1326,6 +1367,13 @@ int main(int argc, char **argv)
> >                         test->should_run = true;
> >                 else
> >                         test->should_run = false;
> > +
> > +               if ((test->run_test == NULL && test->run_serial_test == NULL) ||
> > +                   (test->run_test != NULL && test->run_serial_test != NULL)) {
> > +                       fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
> > +                               test->test_num, test->test_name, test->test_name, test->test_name);
> > +                       exit(EXIT_ERR_SETUP_INFRA);
> > +               }
> >         }
> >
> >         /* ignore workers if we are just listing */
> > --
> > 2.30.2
> >
