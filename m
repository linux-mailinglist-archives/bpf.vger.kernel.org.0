Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2C40C9AC
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhIOQCW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhIOQCW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 12:02:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B46C061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:01:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y16so6721385ybm.3
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2VMuCli8UnoDFwSRIe3z+S3a6j8ElQSC00f7iA23vA=;
        b=IBncYyJfkLlAcY4dAErxAu34EdhEXwh3JhIgjCx6KGikMjv8tJyA52uNTtrqIqc17C
         C/H7ECz1iOAQidDqQk0eTlnp3pbpicc6khsSCjyRqMTyv0OLL+FdJVy3Fj+5kB3ZXCLR
         SeAWVbmBNd98WY+ehyL5RSBZvOysmI/9uhUME9As21oG4NWvaqk2xaj61Wd25L7p6jHX
         nc3T8ahAcWqEFaSGy/RxrVwP2w3WnvatH+Xrp0hsD1gbDxVik1ihIqiNaoepjB1kXXCr
         r31FbDfxLEmXRvQAOrNBCDaPACk/YHtDTwJan65uJDsKxH3A0scXvkYbKD9begJ8W9VX
         J7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2VMuCli8UnoDFwSRIe3z+S3a6j8ElQSC00f7iA23vA=;
        b=wRAxQcSpaEToopvDZWLr8vOfoP6HRUzWfwJVhDYqcGTNh3O8542rqc1uUHHU3zMiyk
         +4jWuXAfr2ngLXmwj49L0OkyCMlzQA6/dZ8XXZWWKaFlIEbXxeoW6AabnIXWuteW5erB
         Gb8uWeSYyQfuNk/iBZif2RDeYk2D8TOkTPU+QoNPfGPWZzexfh8wn4C1AF1qUQXwXsDN
         nQRMy1XUeWyP5Tg01S86v/yuWlKLF/dMwH8kRCwsVFiHP60t5IzR8iI8kxn2e75ovmy7
         PIACEAkUhflcOtr+gKqUBS+MMzoFYhRwgXhhfMahF+pKhnhZ6eV9vfes1+ByxUxvcC5v
         20sQ==
X-Gm-Message-State: AOAM531bzZNhJHuyIv3D7XIgb/mm3dTz3BgPhtR34M4uujZnzADD6DU3
        yrYCa0hGg1j1bk7teWpvg24O6CBj7Qcbag0ai0o=
X-Google-Smtp-Source: ABdhPJzy+qHr60PSlIOedrUlu+kTFAmMp+7GwVtRL/ymtKSNBJlFp77pNNfXsnVoROpygl8isVJaVx9en+KdaONw8ps=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr902222ybj.504.1631721662074;
 Wed, 15 Sep 2021 09:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210913193906.2813357-1-fallentree@fb.com> <CAEf4BzZD7mTAb39vxG7s6mH1PxLchZTpJkk4rPH2UJPX2XfwXg@mail.gmail.com>
 <CAJygYd0Xd8hDpS6rNxgc_LAVJQAWmzYPv8aWv8EPUbjkYd--gQ@mail.gmail.com>
In-Reply-To: <CAJygYd0Xd8hDpS6rNxgc_LAVJQAWmzYPv8aWv8EPUbjkYd--gQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Sep 2021 09:00:50 -0700
Message-ID: <CAEf4BzYXk2a0bNRhOqbipZdBJ5VcsmaWSJjQV-dA9y2yaqQ0Aw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] selftests/bpf: Add parallelism to test_progs
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 6:29 AM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Tue, Sep 14, 2021 at 3:11 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 12:39 PM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > From: Yucong Sun <sunyucong@gmail.com>
> > >
> > > This patch adds "-j" mode to test_progs, executing tests in multiple process.
> > > "-j" mode is optional, and works with all existing test selection mechanism, as
> > > well as "-v", "-l" etc.
> > >
> > > In "-j" mode, main process use UDS/DGRAM to communicate to each forked worker,
> > > commanding it to run tests and collect logs. After all tests are finished, a
> > > summary is printed. main process use multiple competing threads to dispatch
> > > work to worker, trying to keep them all busy.
> > >
> >
> > Overall this looks great and I'm super excited that we'll soon be able
> > to run tests mostly in parallel. I've done the first rough pass over
> > the code, but haven't played with running this locally yet.
> >
> > I didn't trim the message to keep all the context in one place, so
> > please scroll through all of the below till the end.
> >
> > > Example output:
> > >
> > >   > ./test_progs -n 15-20 -j
> > >   [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
> > >   Launching 2 workers.
> > >   [0]: Running test 15.
> > >   [1]: Running test 16.
> > >   [1]: Running test 17.
> > >   [1]: Running test 18.
> > >   [1]: Running test 19.
> > >   [1]: Running test 20.
> > >   [1]: worker exit.
> > >   [0]: worker exit.
> >
> > I think these messages shouldn't be emitted in normal mode, and not
> > even with -v. Maybe -vv. They will be useful initially to debug bugs
> > in concurrent test runner, probably, so I'd hide them behind a very
> > verbose setting.
> >
> > >   #15 btf_dump:OK
> > >   #16 btf_endian:OK
> > >   #17 btf_map_in_map:OK
> > >   #18 btf_module:OK
> > >   #19 btf_skc_cls_ingress:OK
> > >   #20 btf_split:OK
> > >   Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Know issue:
> > >
> > > Some tests fail when running concurrently, later patch will either
> > > fix the test or pin them to worker 0.
> >
> > Hm.. patch #3 does that, no?
> >
> > >
> > > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > >
> > > V4 -> V3: address style warnings.
> > > V3 -> V2: fix missing outputs in commit messages.
> > > V2 -> V1: switch to UDS client/server model.
> >
> > patch sets with more than one patch should come with a cover letter.
> > Keeping more-or-less detailed history in a cover letter is the best.
> > For next revision please add the cover letter and move the history
> > there. Check some other patch sets for an example.
>
> Ack.
>
> >
> > > ---
> > >  tools/testing/selftests/bpf/test_progs.c | 458 ++++++++++++++++++++++-
> > >  tools/testing/selftests/bpf/test_progs.h |  36 +-
> > >  2 files changed, 480 insertions(+), 14 deletions(-)
> > >

[...]

> > > @@ -172,14 +182,14 @@ void test__end_subtest()
> > >
> > >         dump_test_log(test, sub_error_cnt);
> > >
> > > -       fprintf(env.stdout, "#%d/%d %s/%s:%s\n",
> > > +       fprintf(stdout, "#%d/%d %s/%s:%s\n",
> > >                test->test_num, test->subtest_num, test->test_name, test->subtest_name,
> > >                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> >
> > shouldn't this be emitted by the server (main) process, not the
> > worker? Worker itself just returns numbers through UDS.
>
> test__end_subtest() is executed by the worker,  and this output is
> part of the log that is sent back if there is an error executing
> subtests or in verbose mode.
>
> In theory we can print this on the server side, but that would require
> quite a bit hussle of sending back each subtest's execution stat
> individually, and I don't think it is worth the trouble.

Fair enough. Sub-tests are much more dynamic feature which is harder
to deal with. I have some ideas if we decide to parallelize sub-tests
as well, but ok, for now let's leave it as is.

>
> >
> > >
> > >         if (sub_error_cnt)
> > > -               env.fail_cnt++;
> > > +               test->error_cnt++;
> > >         else if (test->skip_cnt == 0)
> > > -               env.sub_succ_cnt++;
> > > +               test->sub_succ_cnt++;
> >
> > this also doesn't feel like a worker's responsibility and logic. It
> > feels like there is a bit of a missing separation between "executing
> > test" and "accounting and reporting test result". I'll get to that
> > below when talking about duplication of code and logic between
> > parallel and non-parallel modes of operation.
>
> This is also accounting the execution stats for the subtests of
> current tests, right now only main tests's cumlated stats are sent
> back, not individual subtests's stats.

Right, subtests again, ok.

>
> >
> > >         skip_account();
> > >
> > >         free(test->subtest_name);
> > > @@ -474,6 +484,7 @@ enum ARG_KEYS {
> > >         ARG_LIST_TEST_NAMES = 'l',
> > >         ARG_TEST_NAME_GLOB_ALLOWLIST = 'a',
> > >         ARG_TEST_NAME_GLOB_DENYLIST = 'd',
> > > +       ARG_NUM_WORKERS = 'j',
> > >  };
> > >

[...]

> > > +                       test_to_run = current_test_idx;
> > > +                       current_test_idx++;
> > > +
> > > +                       pthread_mutex_unlock(&current_test_lock);
> > > +               }
> > > +
> > > +               test = &prog_test_defs[test_to_run];
> > > +               test->test_num = test_to_run + 1;
> >
> > let's initialize test->test_num outside of all this logic in main()
> > (together with whatever other test_def initializations we need to
> > perform at startup)
> >
> > > +
> > > +               if (!should_run(&env.test_selector,
> > > +                               test->test_num, test->test_name))
> > > +                       continue;
> >
> > this probably also can be extracted outside of single-thread/parallel
> > execution paths, it's basically a simple pre-initialization as well.
> > Each test will be just marked as needing the run or not. WDYT?
>
> For this, yes, I added a bool should_run to the test struct, and we
> can avoid calling should_run() on every worker.
>
> However, for subtests, we still have to call it in the worker, since
> there is no way to iterate subtests without running the test.

right

> >
> > > +
> > > +               /* run test through worker */
> > > +               {
> > > +                       struct message msg_do_test;
> > > +

[...]

> > > +       /* wait for all dispatcher to finish */
> > > +       for (int i = 0; i < env.workers; i++) {
> > > +               while (true) {
> > > +                       struct timespec timeout = {
> > > +                               .tv_sec = time(NULL) + 5,
> > > +                               .tv_nsec = 0
> > > +                       };
> > > +                       if (pthread_timedjoin_np(dispatcher_threads[i], NULL, &timeout) != ETIMEDOUT)
> > > +                               break;
> > > +                       fprintf(stderr, "Still waiting for thread %d (test %d).\n", i,  env.worker_current_test[i] + 1);
> >
> > This is just going to spam output needlessly. Why dispatches have to
> > exit within 5 seconds, if there are tests that are running way longer
> > than that?... probably better to just do pthread_join()?
>
> In later patches I actually changed it to list the status of all
> threads every 10 seconds, a easy way to see which tests are blocking
> progress or what the threads are actually doing, If 10s is too
> aggressive, how about 30 seconds?

Ok, but let's hide it by default (i.e., only show in -vv mode)?

>
> >
> > > +               }
> > > +       }
> > > +       free(dispatcher_threads);
> > > +       free(env.worker_current_test);
> > > +       free(data);
> > > +
> > > +       /* generate summary */
> > > +       fflush(stderr);
> > > +       fflush(stdout);
> > > +
> > > +       for (int i = 0; i < prog_test_cnt; i++) {
> > > +               struct prog_test_def *current_test;
> > > +               struct test_result *result;
> > > +
> > > +               current_test = &prog_test_defs[i];
> > > +               result = &test_results[i];
> > > +
> > > +               if (!current_test->tested)
> > > +                       continue;
> > > +
> > > +               env.succ_cnt += result->error_cnt ? 0 : 1;
> > > +               env.skip_cnt += result->skip_cnt;
> > > +               env.fail_cnt += result->error_cnt;
> > > +               env.sub_succ_cnt += result->sub_succ_cnt;
> > > +
> > > +               if (result->log_cnt) {
> > > +                       result->log_buf[result->log_cnt] = '\0';
> > > +                       fprintf(stdout, "%s", result->log_buf);
> > > +                       if (result->log_buf[result->log_cnt - 1] != '\n')
> > > +                               fprintf(stdout, "\n");
> > > +               }
> > > +               fprintf(stdout, "#%d %s:%s\n",
> > > +                       current_test->test_num, current_test->test_name,
> > > +                       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
> >
> > it would be nice to see this as results come in (when handling
> > msg_test_done). It will come out of order, but it will sort of be a
> > progress indicator that stuff is happening. Why the totals summary
> > will be then output at the very end at the bottom.
>
> My first implementation is exactly that, but I don't quite like the
> out of order logs, it makes reading them  / comparing them much
> harder.

by out of order you mean that tests will finish in different order? Or
that logs from multiple tests will be intermingled? For the former I
think it's fine given this is parallel mode. For the latter, that
shouldn't happen, because log output should happen under common lock,
so that log of one test is finished before log of another test is
emitted.

As for comparing two log outputs, that's not something I ever really
do. Usually you want to see what failed and why, not how it differs
from the previous run. With the dumping of only errored tests at the
end (that we previously talked about), we can sort those and emit
their logs in order, because by that time all tests are done already.
But for now I'd just emit SUCCESS/FAIL as test results come in.

>
> That's the reason I added test_results and print threads status as a
> progress indicator.
>
> >
> > > +       }
> > > +
> > > +       fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> > > +               env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> > > +
> > > +       /* reap all workers */
> > > +       for (int i = 0; i < env.workers; i++) {
> > > +               int wstatus, pid;
> > > +
> > > +               pid = waitpid(env.worker_pids[i], &wstatus, 0);
> >
> > should we send SIGKILL as well to ensure that some stuck or buggy
> > worker gets reaped for sure?
>
> Right now if a worker is buggy it is possible for the dispatcher
> thread to get stuck (waiting for a message never arrives), then the
> main thread will never finish pthread_join() loop, so we can't make it
> here to kill the workers. The main process would need some kind of
> signal before starting to kill workers, we could use a fixed timeout ,
> but it would be hard to set the timeout value.


Hm.. If you kill a child process that didn't want to exit by itself,
its socket will be closed by the kernel. Which will result in the
dispatcher's read/write operation to fail. It's actually good to test
this, we don't want to debug this in Github Actions when some test
actually crashes a worker process (which will happen sooner or later).

>
> >
> > > +               assert(pid == env.worker_pids[i]);
> >
> > let's not use assert(), better print error message
>
> Ack.
>
> >

[...]

> > > +
> > > +#define MAX_LOG_TRUNK_SIZE 8192
> > > +enum message_type {
> > > +       MSG_DO_TEST = 0,
> > > +       MSG_TEST_DONE = 1,
> > > +       MSG_TEST_LOG = 2,
> > > +       MSG_EXIT = 255,
> > > +};
> >
> > nit: empty line between type definitions
> >
> > ok, here comes a bunch of naming nitpicking, sorry about that :) but
> > the current struct definition is a bit mouthful so it's a bit hard to
> > read, and some fields are actually too succinct at the same time, so
> > that it's hard to understand in some places what the field represents.
> >
> > > +struct message {
> > > +       enum message_type type;
> >
> > total nitpick, but given MSG_ enums above, I'd stick to "msg"
> > everywhere and have struct msg and enum msg_type
> >
> > > +       union {
> > > +               struct {
> > > +                       int num;
> >
> > this is the test number, right? test_num would make it more clear.
> > There were a few times when I wondered if it's worker number or a test
> > number.
> >
> > > +               } message_do_test;
> >
> > this is a bit tautological. In the code above you have accesses like:
> >
> > msg->u.message_do_test.num
> >
> > that message_ prefix doesn't bring any value, just makes everything
> > unnecessarily verbose. With the below suggestion to drop u name for
> > union and by dropping message_ prefix everywhere, we'll be down to a
> > clean ans simple
> >
> > msg->do_test.test_num
> >
> > (and I'd s/do_test/run_test/ because it reads better for me, but I
> > won't complain either way)
> >
>
> I think anonymous union/struct is in C11 , or gnu c99 extension, can we use it?

we use anonymous unions even in BPF UAPI, so yeah, we definitely can use it

>
> >
> > > +               struct {
> > > +                       int num;
> >
> > same about test_num
> > > +
> > > +                       int sub_succ_cnt;
> > > +                       int error_cnt;
> > > +                       int skip_cnt;
> > > +                       bool have_log;
> > > +               } message_test_done;
> > > +               struct {
> > > +                       char log_buf[MAX_LOG_TRUNK_SIZE + 1];
> > > +                       bool is_last;
> > > +               } message_test_log;
> > > +       } u;
> >
> > there is no need to name this union, it can be anonymous allowing to
> > skip .u. part in field accesses
> >
> > >  };
> > >
> > >  extern struct test_env env;
> > > --
> > > 2.30.2
> > >
