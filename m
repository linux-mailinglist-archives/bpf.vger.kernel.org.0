Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF940CBF6
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhIORyP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIORyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 13:54:15 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A23C061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 10:52:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c6so7351844ybm.10
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOJxWO2J0AhhHBmsQZQjvgkvRNA5dvvchsy6xDhHLOU=;
        b=MngreB2N3DHAnlTSKsJr1ohClSsKaTcN58VvAwCoUc/doPHLB5hUItiC8CvnFPJEdC
         KPw1kyBlz8i6fW43YSry5S46295lMkXG993KNWR9LbHun9Yqk7ktcTLnksG9Jxy/u/cl
         Hj2dg8ZhijukkzKopNVvU4yY8ReK36qe4X+J7YnOawIalzlA4j7M8Ifix2YFEKWKEqXs
         Jw2UMyI7QasCGMybwwTtIE9jbcyhMnxxSQrss8GjHJdaGYgLuTlTqjV9zhmDvxyIh+5s
         VbZVcUSEyg0tt2sWCaMkwEC4OMoHnwZUm62YUKFQXDCTP76udqPGuddQALe4LRJi9vAx
         FeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOJxWO2J0AhhHBmsQZQjvgkvRNA5dvvchsy6xDhHLOU=;
        b=EvOrsx8GHRXHQTrF6amjSBRf+gQ+d0fGA2VqiXviQtRfYvzkp3gsDAjP/NX77FokTa
         BZmk8Sb+DI8pznFZ0+oZ9ZuYfa179utd4oKTxkMeGlhv/AgoewM27YYDmpCRdZ4u5hHp
         wh6tp9SOM9l6eUJ/ac9w+os0514SiqF2OcryQmfce/YDJeQ5n6GDsRwENf+HUAVEYOXw
         Fyh8ggcIvmNb+qkWPiCffmqYFLSNPgQ80N6h4G+R4Yq4mXCin3v3GYYYhF+2J2VREqua
         kP+K2IEQNyU9b8Y75wbDhHSpa94xekX3g/MHfsneJAzxUbMQIfaifY2D9kzCZGf6M8bt
         m9/w==
X-Gm-Message-State: AOAM533cUXFoMc/F1jfAr4mCEloLn0hkUv0voUR7YMJKCh8YpTMe67JR
        1fcgCaA8UzxftleFjf+1LvYTDmWhySZ1OOdp9eg=
X-Google-Smtp-Source: ABdhPJyPZfKp0hFK3EcHK1okhTAMxMgU5W2vNmMF5A/H3kmtkGFA5qHB0JVaQt9L5jzIvTf2f9/GxKTDk5W+oRCgHRQ=
X-Received: by 2002:a5b:408:: with SMTP id m8mr1552714ybp.2.1631728375275;
 Wed, 15 Sep 2021 10:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210913193906.2813357-1-fallentree@fb.com> <CAEf4BzZD7mTAb39vxG7s6mH1PxLchZTpJkk4rPH2UJPX2XfwXg@mail.gmail.com>
 <CAJygYd0Xd8hDpS6rNxgc_LAVJQAWmzYPv8aWv8EPUbjkYd--gQ@mail.gmail.com>
 <CAEf4BzYXk2a0bNRhOqbipZdBJ5VcsmaWSJjQV-dA9y2yaqQ0Aw@mail.gmail.com>
 <CAJygYd3bQ_zB7Tz2VCryNMSWUgATySS21ZLCzY=TBaUZt2BNfw@mail.gmail.com>
 <CAEf4BzZsuXQoaCWG=o7JtwBBG6Z+fAUrkkLkZ2MbxHEBvN9sCQ@mail.gmail.com> <CAJygYd17-3mEsbM9LYoC2vtLdqp2z3h_SZZxt=_3PaL4oNLexg@mail.gmail.com>
In-Reply-To: <CAJygYd17-3mEsbM9LYoC2vtLdqp2z3h_SZZxt=_3PaL4oNLexg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Sep 2021 10:52:44 -0700
Message-ID: <CAEf4BzainSK0CBPC_2cLqZdocQi8BCLmuxSDUYFstPdLwwCYNQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] selftests/bpf: Add parallelism to test_progs
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 10:44 AM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> On Wed, Sep 15, 2021 at 1:36 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Sep 15, 2021 at 9:56 AM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> > >
> > > On Wed, Sep 15, 2021 at 12:01 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 15, 2021 at 6:29 AM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 14, 2021 at 3:11 AM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 13, 2021 at 12:39 PM Yucong Sun <fallentree@fb.com> wrote:
> > > > > > >
> > > > > > > From: Yucong Sun <sunyucong@gmail.com>
> > > > > > >
> > > > > > > This patch adds "-j" mode to test_progs, executing tests in multiple process.
> > > > > > > "-j" mode is optional, and works with all existing test selection mechanism, as
> > > > > > > well as "-v", "-l" etc.
> > > > > > >
> > > > > > > In "-j" mode, main process use UDS/DGRAM to communicate to each forked worker,
> > > > > > > commanding it to run tests and collect logs. After all tests are finished, a
> > > > > > > summary is printed. main process use multiple competing threads to dispatch
> > > > > > > work to worker, trying to keep them all busy.
> > > > > > >
> > > > > >
> > > > > > Overall this looks great and I'm super excited that we'll soon be able
> > > > > > to run tests mostly in parallel. I've done the first rough pass over
> > > > > > the code, but haven't played with running this locally yet.
> > > > > >
> > > > > > I didn't trim the message to keep all the context in one place, so
> > > > > > please scroll through all of the below till the end.
> > > > > >
> > > > > > > Example output:
> > > > > > >
> > > > > > >   > ./test_progs -n 15-20 -j
> > > > > > >   [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
> > > > > > >   Launching 2 workers.
> > > > > > >   [0]: Running test 15.
> > > > > > >   [1]: Running test 16.
> > > > > > >   [1]: Running test 17.
> > > > > > >   [1]: Running test 18.
> > > > > > >   [1]: Running test 19.
> > > > > > >   [1]: Running test 20.
> > > > > > >   [1]: worker exit.
> > > > > > >   [0]: worker exit.
> > > > > >
> > > > > > I think these messages shouldn't be emitted in normal mode, and not
> > > > > > even with -v. Maybe -vv. They will be useful initially to debug bugs
> > > > > > in concurrent test runner, probably, so I'd hide them behind a very
> > > > > > verbose setting.
> > >
> > > I created a new "debug" mode, which will print these messages. putting
> > > them under verbose mode will also make all other test log output more
> > > stuff, which make it harder to debug.
> >
> > Cool, makes sense.
> >
> > >
> > > > > >
> > > > > > >   #15 btf_dump:OK
> > > > > > >   #16 btf_endian:OK
> > > > > > >   #17 btf_map_in_map:OK
> > > > > > >   #18 btf_module:OK
> > > > > > >   #19 btf_skc_cls_ingress:OK
> > > > > > >   #20 btf_split:OK
> > > > > > >   Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
> > > > > > >
> > > > > > > Know issue:
> > > > > > >
> > > > > > > Some tests fail when running concurrently, later patch will either
> > > > > > > fix the test or pin them to worker 0.
> > > > > >
> > > > > > Hm.. patch #3 does that, no?
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > > > > > >
> > > > > > > V4 -> V3: address style warnings.
> > > > > > > V3 -> V2: fix missing outputs in commit messages.
> > > > > > > V2 -> V1: switch to UDS client/server model.
> > > > > >
> > > > > > patch sets with more than one patch should come with a cover letter.
> > > > > > Keeping more-or-less detailed history in a cover letter is the best.
> > > > > > For next revision please add the cover letter and move the history
> > > > > > there. Check some other patch sets for an example.
> > > > >
> > > > > Ack.
> > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  tools/testing/selftests/bpf/test_progs.c | 458 ++++++++++++++++++++++-
> > > > > > >  tools/testing/selftests/bpf/test_progs.h |  36 +-
> > > > > > >  2 files changed, 480 insertions(+), 14 deletions(-)
> > > > > > >
> > > >
> > > > [...]
> > > >
> > > > > > > @@ -172,14 +182,14 @@ void test__end_subtest()
> > > > > > >
> > > > > > >         dump_test_log(test, sub_error_cnt);
> > > > > > >
> > > > > > > -       fprintf(env.stdout, "#%d/%d %s/%s:%s\n",
> > > > > > > +       fprintf(stdout, "#%d/%d %s/%s:%s\n",
> > > > > > >                test->test_num, test->subtest_num, test->test_name, test->subtest_name,
> > > > > > >                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> > > > > >
> > > > > > shouldn't this be emitted by the server (main) process, not the
> > > > > > worker? Worker itself just returns numbers through UDS.
> > > > >
> > > > > test__end_subtest() is executed by the worker,  and this output is
> > > > > part of the log that is sent back if there is an error executing
> > > > > subtests or in verbose mode.
> > > > >
> > > > > In theory we can print this on the server side, but that would require
> > > > > quite a bit hussle of sending back each subtest's execution stat
> > > > > individually, and I don't think it is worth the trouble.
> > > >
> > > > Fair enough. Sub-tests are much more dynamic feature which is harder
> > > > to deal with. I have some ideas if we decide to parallelize sub-tests
> > > > as well, but ok, for now let's leave it as is.
> > >
> > > I think it is much easier just to make sub-tests into top level tests,
> > > from what I've seen the actual setup/tear down code is not that much.
> >
> > That's what we'll end up doing for bpf_verif_scale tests, probably.
> > It's going to be the biggest bottleneck for speeding up testing in
> > parallel mode. For the rest we can probably keep all subtests within
> > their respective tests for now without increasing the total parallel
> > run time much.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > >         if (sub_error_cnt)
> > > > > > > -               env.fail_cnt++;
> > > > > > > +               test->error_cnt++;
> > > > > > >         else if (test->skip_cnt == 0)
> > > > > > > -               env.sub_succ_cnt++;
> > > > > > > +               test->sub_succ_cnt++;
> > > > > >
> > > > > > this also doesn't feel like a worker's responsibility and logic. It
> > > > > > feels like there is a bit of a missing separation between "executing
> > > > > > test" and "accounting and reporting test result". I'll get to that
> > > > > > below when talking about duplication of code and logic between
> > > > > > parallel and non-parallel modes of operation.
> > > > >
> > > > > This is also accounting the execution stats for the subtests of
> > > > > current tests, right now only main tests's cumlated stats are sent
> > > > > back, not individual subtests's stats.
> > > >
> > > > Right, subtests again, ok.
> > > >
> > > > >
> > > > > >
> > > > > > >         skip_account();
> > > > > > >
> > > > > > >         free(test->subtest_name);
> > > > > > > @@ -474,6 +484,7 @@ enum ARG_KEYS {
> > > > > > >         ARG_LIST_TEST_NAMES = 'l',
> > > > > > >         ARG_TEST_NAME_GLOB_ALLOWLIST = 'a',
> > > > > > >         ARG_TEST_NAME_GLOB_DENYLIST = 'd',
> > > > > > > +       ARG_NUM_WORKERS = 'j',
> > > > > > >  };
> > > > > > >
> > > >
> > > > [...]
> > > >
> > > > > > > +                       test_to_run = current_test_idx;
> > > > > > > +                       current_test_idx++;
> > > > > > > +
> > > > > > > +                       pthread_mutex_unlock(&current_test_lock);
> > > > > > > +               }
> > > > > > > +
> > > > > > > +               test = &prog_test_defs[test_to_run];
> > > > > > > +               test->test_num = test_to_run + 1;
> > > > > >
> > > > > > let's initialize test->test_num outside of all this logic in main()
> > > > > > (together with whatever other test_def initializations we need to
> > > > > > perform at startup)
> > > > > >
> > > > > > > +
> > > > > > > +               if (!should_run(&env.test_selector,
> > > > > > > +                               test->test_num, test->test_name))
> > > > > > > +                       continue;
> > > > > >
> > > > > > this probably also can be extracted outside of single-thread/parallel
> > > > > > execution paths, it's basically a simple pre-initialization as well.
> > > > > > Each test will be just marked as needing the run or not. WDYT?
> > > > >
> > > > > For this, yes, I added a bool should_run to the test struct, and we
> > > > > can avoid calling should_run() on every worker.
> > > > >
> > > > > However, for subtests, we still have to call it in the worker, since
> > > > > there is no way to iterate subtests without running the test.
> > > >
> > > > right
> > > >
> > > > > >
> > > > > > > +
> > > > > > > +               /* run test through worker */
> > > > > > > +               {
> > > > > > > +                       struct message msg_do_test;
> > > > > > > +
> > > >
> > > > [...]
> > > >
> > > > > > > +       /* wait for all dispatcher to finish */
> > > > > > > +       for (int i = 0; i < env.workers; i++) {
> > > > > > > +               while (true) {
> > > > > > > +                       struct timespec timeout = {
> > > > > > > +                               .tv_sec = time(NULL) + 5,
> > > > > > > +                               .tv_nsec = 0
> > > > > > > +                       };
> > > > > > > +                       if (pthread_timedjoin_np(dispatcher_threads[i], NULL, &timeout) != ETIMEDOUT)
> > > > > > > +                               break;
> > > > > > > +                       fprintf(stderr, "Still waiting for thread %d (test %d).\n", i,  env.worker_current_test[i] + 1);
> > > > > >
> > > > > > This is just going to spam output needlessly. Why dispatches have to
> > > > > > exit within 5 seconds, if there are tests that are running way longer
> > > > > > than that?... probably better to just do pthread_join()?
> > > > >
> > > > > In later patches I actually changed it to list the status of all
> > > > > threads every 10 seconds, a easy way to see which tests are blocking
> > > > > progress or what the threads are actually doing, If 10s is too
> > > > > aggressive, how about 30 seconds?
> > > >
> > > > Ok, but let's hide it by default (i.e., only show in -vv mode)?
> > > >
> > > > >
> > > > > >
> > > > > > > +               }
> > > > > > > +       }
> > > > > > > +       free(dispatcher_threads);
> > > > > > > +       free(env.worker_current_test);
> > > > > > > +       free(data);
> > > > > > > +
> > > > > > > +       /* generate summary */
> > > > > > > +       fflush(stderr);
> > > > > > > +       fflush(stdout);
> > > > > > > +
> > > > > > > +       for (int i = 0; i < prog_test_cnt; i++) {
> > > > > > > +               struct prog_test_def *current_test;
> > > > > > > +               struct test_result *result;
> > > > > > > +
> > > > > > > +               current_test = &prog_test_defs[i];
> > > > > > > +               result = &test_results[i];
> > > > > > > +
> > > > > > > +               if (!current_test->tested)
> > > > > > > +                       continue;
> > > > > > > +
> > > > > > > +               env.succ_cnt += result->error_cnt ? 0 : 1;
> > > > > > > +               env.skip_cnt += result->skip_cnt;
> > > > > > > +               env.fail_cnt += result->error_cnt;
> > > > > > > +               env.sub_succ_cnt += result->sub_succ_cnt;
> > > > > > > +
> > > > > > > +               if (result->log_cnt) {
> > > > > > > +                       result->log_buf[result->log_cnt] = '\0';
> > > > > > > +                       fprintf(stdout, "%s", result->log_buf);
> > > > > > > +                       if (result->log_buf[result->log_cnt - 1] != '\n')
> > > > > > > +                               fprintf(stdout, "\n");
> > > > > > > +               }
> > > > > > > +               fprintf(stdout, "#%d %s:%s\n",
> > > > > > > +                       current_test->test_num, current_test->test_name,
> > > > > > > +                       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
> > > > > >
> > > > > > it would be nice to see this as results come in (when handling
> > > > > > msg_test_done). It will come out of order, but it will sort of be a
> > > > > > progress indicator that stuff is happening. Why the totals summary
> > > > > > will be then output at the very end at the bottom.
> > > > >
> > > > > My first implementation is exactly that, but I don't quite like the
> > > > > out of order logs, it makes reading them  / comparing them much
> > > > > harder.
> > > >
> > > > by out of order you mean that tests will finish in different order? Or
> > > > that logs from multiple tests will be intermingled? For the former I
> > > > think it's fine given this is parallel mode. For the latter, that
> > > > shouldn't happen, because log output should happen under common lock,
> > > > so that log of one test is finished before log of another test is
> > > > emitted.
> > > >
> > > > As for comparing two log outputs, that's not something I ever really
> > > > do. Usually you want to see what failed and why, not how it differs
> > > > from the previous run. With the dumping of only errored tests at the
> > > > end (that we previously talked about), we can sort those and emit
> > > > their logs in order, because by that time all tests are done already.
> > > > But for now I'd just emit SUCCESS/FAIL as test results come in.
> > > >
> > >
> > > OK, as long as we are only outputting one line here it should be fine.
> >
> > It will be many lines if a test failed, is that a problem?
>
> Yes, because stdio is line buffered, if we output multiple line from

That's why I said you'd need a lock while emitting test log. I like
the summary, obviously and we should definitely do that (will
non-parallel mode have that as well?), but the problem with delaying
error logs till the very end is that you won't be able to ctrl-c and
go look at the error log before the whole run finishes. Which is quite
inconvenient in local development. Given it's just one lock + fflush()
away, can we do both -- log errors as test results come in, and then
dump only errors at the bottom after all tests finish?

> multiple dispatcher threads, they will be interleaved, so in the new
> revision of this patch I changed the way reporting is done, one single
> line will be printed as test getting finished to indicate progress,
> and once all tests are done, a summary line is printed, then all the
> error logs from failed logs, as example below
>
> ./test_progs -b scale,fentry,fexit -n 1-10 -j
> [   16.300708] bpf_testmod: loading out-of-tree module taints kernel.
> Launching 8 workers.
> #6 bind_perm:OK
> #1 align:OK
> #10 bpf_obj_id:FAIL
> #5 autoload:OK
> #2 atomic_bounds:OK
> #4 attach_probe:OK
> #7 bpf_cookie:FAIL
> #8 bpf_iter:OK
> #3 atomics:OK
> #9 bpf_iter_setsockopt:OK
> Summary: 8/51 PASSED, 0 SKIPPED, 4 FAILED
> test_bpf_cookie:PASS:skel_open 0 nsec
> kprobe_subtest:PASS:link1 0 nsec
> kprobe_subtest:PASS:link2 0 nsec
> kprobe_subtest:PASS:retlink1 0 nsec
> kprobe_subtest:PASS:retlink2 0 nsec
> kprobe_subtest:PASS:kprobe_res 0 nsec
> kprobe_subtest:PASS:kretprobe_res 0 nsec
> #7/1 bpf_cookie/kprobe:OK
> uprobe_subtest:PASS:link1 0 nsec
> uprobe_subtest:PASS:link2 0 nsec
> uprobe_subtest:PASS:retlink1 0 nsec
> uprobe_subtest:PASS:retlink2 0 nsec
> uprobe_subtest:PASS:uprobe_res 0 nsec
> uprobe_subtest:PASS:uretprobe_res 0 nsec
> #7/2 bpf_cookie/uprobe:OK
> tp_subtest:PASS:link1 0 nsec
> tp_subtest:PASS:link2 0 nsec
> tp_subtest:PASS:tp_res1 0 nsec
> tp_subtest:PASS:link3 0 nsec
> tp_subtest:PASS:tp_res2 0 nsec
> #7/3 bpf_cookie/tracepoint:OK
> pe_subtest:PASS:perf_fd 0 nsec
> pe_subtest:PASS:link1 0 nsec
> burn_cpu:PASS:set_thread_affinity 0 nsec
> pe_subtest:FAIL:pe_res1 unexpected pe_res1: actual 0 != expected 1048576
> pe_subtest:PASS:link2 0 nsec
> burn_cpu:PASS:set_thread_affinity 0 nsec
> pe_subtest:PASS:pe_res2 0 nsec
> #7/4 bpf_cookie/perf_event:FAIL
> #7 bpf_cookie:FAIL
> test_bpf_obj_id:PASS:get-fd-by-notexist-prog-id 0 nsec
> test_bpf_obj_id:PASS:get-fd-by-notexist-map-id 0 nsec
> test_bpf_obj_id:PASS:get-fd-by-notexist-link-id 0 nsec
> test_bpf_obj_id:PASS:prog_attach 0 nsec
> test_bpf_obj_id:PASS:get-map-info(fd) 0 nsec
> test_bpf_obj_id:PASS:get-prog-info(fd) 0 nsec
> test_bpf_obj_id:PASS:get-link-info(fd) 0 nsec
> test_bpf_obj_id:PASS:prog_attach 0 nsec
> test_bpf_obj_id:PASS:get-map-info(fd) 0 nsec
> test_bpf_obj_id:PASS:get-prog-info(fd) 0 nsec
> test_bpf_obj_id:PASS:get-link-info(fd) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd-bad-nr-map-ids 0 nsec
> test_bpf_obj_id:PASS:get-prog-info(next_id->fd) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd-bad-nr-map-ids 0 nsec
> test_bpf_obj_id:PASS:get-prog-info(next_id->fd) 0 nsec
> test_bpf_obj_id:PASS:get-prog-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:check total prog id found by get_next_id 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:check get-map-info(next_id->fd) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-map-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:check get-map-info(next_id->fd) 0 nsec
> test_bpf_obj_id:PASS:check total map id found by get_next_id 0 nsec
> test_bpf_obj_id:PASS:get-link-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-link-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-link-fd(next_id) 0 nsec
> test_bpf_obj_id:PASS:get-link-fd(next_id) 0 nsec
> test_bpf_obj_id:FAIL:get-link-fd(next_id) link_fd -11 next_id 7 errno 11
> test_bpf_obj_id:FAIL:check total link id found by get_next_id nr_id_found 0(2)
> #10 bpf_obj_id:FAIL
>
> >
> > >
> > > > >
> > > > > That's the reason I added test_results and print threads status as a
> > > > > progress indicator.
> > > > >
> > > > > >
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> > > > > > > +               env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> > > > > > > +
> > > > > > > +       /* reap all workers */
> > > > > > > +       for (int i = 0; i < env.workers; i++) {
> > > > > > > +               int wstatus, pid;
> > > > > > > +
> > > > > > > +               pid = waitpid(env.worker_pids[i], &wstatus, 0);
> > > > > >
> >
> > [...]
