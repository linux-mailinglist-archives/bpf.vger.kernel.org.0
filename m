Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BA43B81C
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhJZR1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJZR1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 13:27:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A6C061745
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 10:24:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j9so340135lfu.7
        for <bpf@vger.kernel.org>; Tue, 26 Oct 2021 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDrpnuZxjObjPC1Zo7alESxZb3WYT4LrDS903Eli4Xo=;
        b=anRkFpKxDIm3c5Iu/3JjwnUP6SN3SA007ddsUvalOve7JHDHq/vkZnaS7iQ3dSkCbY
         +CRgC7ujQNeNzpzzQHQOri/KFvwSGSHOwRMwFgLzwWLfX6J7j4eeEDoLWWRV/zCY7YR7
         UPnwecFsK5mql3pVee0n1mYsP6TTJARJLAkk/DPke6Zko+bAQF0q4uvb5vl1QCONz/nJ
         yOiMGuLzWRjIlnv4BZ44nyOuu/Egh+mxjLrtYaQTMzQ1wzKTTL95cOstB6Cr07uyktHH
         44j/Z9q3B+BRYQ/6stb9vBA0yCUGu9SzCTsAiu2adztcgEX48OyWVJg5sykm2anQtKc2
         tP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDrpnuZxjObjPC1Zo7alESxZb3WYT4LrDS903Eli4Xo=;
        b=H35Sk3zwgR/HTNhQsybxTWH5vxRSgv4oLMl+RIJeBDdmWSLq87pruVJR6VM//AAJsf
         N4ilMY7wsxtB478tAmK2wqGnWQgh5Z8aQySYEaa+yzJNiq/2ADQbviL9TT1ZeDRA1khc
         gXNvCH7sjJ57X1fVwsGwtH40OFx+JqKb1TBWa0IK8C1Sffyj8Rs27EdU7IOf5UbBYoBD
         fUvIYe71UEMm3EySocsjKlropLfydrsQt4MRLNIACyVFRhvapEIgFm/loZnY7//C7fED
         x12Av+/YC+w552+HWIO/BJ5FTlbXTMNuQk6YFzS2QTBwz7++t+29r330lL32t46eMpwV
         ab8g==
X-Gm-Message-State: AOAM533VrRHbW8XaJpD7hKwuR7FnnUm3iN0gdEWsPRsDWU7WWzMqjeae
        fIrfBySRcTIf7BcA/w3g3DR7WydnLFCpJ/e1JCgBS0z0
X-Google-Smtp-Source: ABdhPJxeR1qI0qDF75M2/SutqIS+gOAc6rxeSTpje0bMKxR8nqLudb9d/PVet6WxMSaaBi08NKspP9ylMhAx5dA2jEA=
X-Received: by 2002:a05:6512:31a:: with SMTP id t26mr17435574lfp.280.1635269077908;
 Tue, 26 Oct 2021 10:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211025223345.2136168-1-fallentree@fb.com> <20211025223345.2136168-3-fallentree@fb.com>
 <CAEf4BzZFtCreYhRy01g1mXe9iU-LdP4Td45ynXF9ztQrKXBqGQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZFtCreYhRy01g1mXe9iU-LdP4Td45ynXF9ztQrKXBqGQ@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Tue, 26 Oct 2021 10:24:11 -0700
Message-ID: <CAJygYd0pMMuZ2Q5ZJtxK=z8qKHJmRO45io+W7VJ66mGhPY1yRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: print subtest status line
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 9:09 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 3:33 PM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch restores behavior that prints one status line for each
> > subtest executed. It works in both serial mode and parallel mode,  and
> > all verbosity settings.
> >
> > The logic around IO hijacking could use some more simplification in the
> > future.
> >
>
> This feels like a big hack, not a proper solution. What if we extend
> MSG_TEST_DONE to signal also sub-test completion (along with subtest
> logs)? Would that work better and result in cleaner logic?

I think the current solution is actually cleaner.  Yes we could add
fields in task struct to record each subtest's name and status and
generate the status line separately, but it will only work in
situations where all tests pass.
When there is an error, we do want to mix the status line with the
actual stdout logs, which we won't be able to do afterwards.

Besides, we will still need to implement separate logic in 3 places
(serial mode,  parallel mode in worker process, and serial part of
parallel mode execution). Having two copies of stdout logs is actually
not that bad.

>
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c | 56 +++++++++++++++++++-----
> >  tools/testing/selftests/bpf/test_progs.h |  4 ++
> >  2 files changed, 50 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 1f4a48566991..ff4598126f9d 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -100,6 +100,18 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
> >         return num < sel->num_set_len && sel->num_set[num];
> >  }
> >
> > +static void dump_subtest_status(bool display) {
>
> please run checkpatch.pl
>
> > +       fflush(env.subtest_status_fd);
> > +       if (display) {
> > +               if (env.subtest_status_cnt) {
> > +                       env.subtest_status_buf[env.subtest_status_cnt] = '\0';
> > +                       fputs(env.subtest_status_buf, stdout);
> > +               }
> > +       }
> > +       rewind(env.subtest_status_fd);
> > +       fflush(env.subtest_status_fd);
> > +}
> > +
> >  static void dump_test_log(const struct prog_test_def *test, bool failed)
> >  {
> >         if (stdout == env.stdout)
> > @@ -112,12 +124,17 @@ static void dump_test_log(const struct prog_test_def *test, bool failed)
> >         fflush(stdout); /* exports env.log_buf & env.log_cnt */
> >
> >         if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
> > -               if (env.log_cnt) {
> > -                       env.log_buf[env.log_cnt] = '\0';
> > -                       fprintf(env.stdout, "%s", env.log_buf);
> > -                       if (env.log_buf[env.log_cnt - 1] != '\n')
> > -                               fprintf(env.stdout, "\n");
> > -               }
> > +               dump_subtest_status(false);
> > +       } else {
> > +               rewind(stdout);
> > +               dump_subtest_status(true);
> > +               fflush(stdout);
> > +       }
> > +       if (env.log_cnt) {
> > +               env.log_buf[env.log_cnt] = '\0';
> > +               fprintf(env.stdout, "%s", env.log_buf);
> > +               if (env.log_buf[env.log_cnt - 1] != '\n')
> > +                       fprintf(env.stdout, "\n");
> >         }
> >  }
> >
> > @@ -183,7 +200,12 @@ void test__end_subtest(void)
> >
> >         dump_test_log(test, sub_error_cnt);
> >
> > +       // Print two copies here, one as part of full logs, another one will
> > +       // only be used if there is no need to show full logs.
>
> C++ style comments
>
> >         fprintf(stdout, "#%d/%d %s/%s:%s\n",
> > +               test->test_num, test->subtest_num, test->test_name, test->subtest_name,
> > +               sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> > +       fprintf(env.subtest_status_fd, "#%d/%d %s/%s:%s\n",
> >                test->test_num, test->subtest_num, test->test_name, test->subtest_name,
> >                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> >
> > @@ -1250,6 +1272,15 @@ static int worker_main(int sock)
> >
> >                         run_one_test(test_to_run);
> >
> > +                       // discard logs if we don't need them
>
> C++ style comment
>
> > +                       if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> > +                               dump_subtest_status(false);
> > +                       } else {
> > +                               rewind(stdout);
> > +                               dump_subtest_status(true);
> > +                               fflush(stdout);
> > +                       }
> > +
> >                         stdio_restore();
> >
> >                         memset(&msg_done, 0, sizeof(msg_done));
> > @@ -1260,10 +1291,9 @@ static int worker_main(int sock)
> >                         msg_done.test_done.sub_succ_cnt = test->sub_succ_cnt;
> >                         msg_done.test_done.have_log = false;
> >
> > -                       if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> > -                               if (env.log_cnt)
> > -                                       msg_done.test_done.have_log = true;
> > -                       }
> > +                       if (env.log_cnt)
> > +                               msg_done.test_done.have_log = true;
> > +
> >                         if (send_message(sock, &msg_done) < 0) {
> >                                 perror("Fail to send message done");
> >                                 goto out;
> > @@ -1357,6 +1387,12 @@ int main(int argc, char **argv)
> >
> >         env.stdout = stdout;
> >         env.stderr = stderr;
> > +       env.subtest_status_fd = open_memstream(
>
> extremely misleading name, it's not an FD at all

it is indeed a file descriptor, isn't it? What's a better name for it?

>
> > +               &env.subtest_status_buf, &env.subtest_status_cnt);
> > +       if (!env.subtest_status_fd) {
> > +               perror("Failed to setup env.subtest_status_fd");
> > +               exit(EXIT_ERR_SETUP_INFRA);
> > +       }
> >
> >         env.has_testmod = true;
> >         if (!env.list_test_names && load_bpf_testmod()) {
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > index 93c1ff705533..a564215a63b1 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -89,6 +89,10 @@ struct test_env {
> >         pid_t *worker_pids; /* array of worker pids */
> >         int *worker_socks; /* array of worker socks */
> >         int *worker_current_test; /* array of current running test for each worker */
> > +
> > +       FILE* subtest_status_fd; /* fd for printing status line for subtests */
> > +       char *subtest_status_buf; /* buffer for subtests status */
> > +       size_t subtest_status_cnt;
> >  };
> >
> >  #define MAX_LOG_TRUNK_SIZE 8192
> > --
> > 2.30.2
> >
