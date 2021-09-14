Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7368F40A721
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbhINHMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbhINHMq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 03:12:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A4C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 00:11:29 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z18so26067028ybg.8
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfVrx2+97BUrCYq7QgJ66N1+OuyMMmeKANIynX1Su9E=;
        b=fuLJKvt2zX7zZxDdniE5Zg54A7Q2Qs8dolJRqBbeHqs+EzBfWdK0q/QRBWaVEzlUy5
         I2IhZXWJtAgi1zqodh+qAbgGaF6ucypTIl06EqIxPUMB6JaeyYWNEGGmJyubnBcZVAL+
         +o41McOwTFgsa+GqWYA6SLgvP8a97WAGm2GGlEdZ92l7LZs2y6HzzP6QM3bawoJQ/E4b
         OPq5dENTnXnq8YXa9ah9vDJCEruNv7o+togkTyouyOYE6Z+zaX5S1S3faEdq2D8+lGmX
         ecxcQ9g/y+OBMf4T9L0vJ1Lksnl92CQA+QgG9OZ1Cm51zpBxG0ZYxb30of2sASlvzDIq
         esqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfVrx2+97BUrCYq7QgJ66N1+OuyMMmeKANIynX1Su9E=;
        b=Upcwnx3SOzz3xd3LNOJTblLDdT5aQivE4z8W4gV+6E3dqQa2xBjm7+aWO4F799oThv
         F3uT2Dh0ZhwfqOP3rSqFLvm4gE7z3Eh05MKy8rFJkaMAbylEGjtOkNa9SJN087IsGcN9
         pqBdsopc7aM4bXQUw4/TRHD3JsspHDuZDuvyrB7Bolr+MHR5waYGUKjZlgvlInkoghwA
         Eno+jcECyn+2P+C3maLZ5KBNOi+yjMl6nwXHxsRRabkaW2GC0qqFGki+fUuvpd5/IniG
         ZD/fYIczmFV1iwq5Vc+CCzT+7NymqrkccdyWPglJO06jK0rX5F24DfJ6QCjtEQnN0Ixg
         J2Ww==
X-Gm-Message-State: AOAM530C7yMiiRGIDW4egJWMtjezGu1/qdvRX6C2kbJ+17dbRUx9r/QO
        U2bG8+1Msq5tTR8wOLpL1vIjtYWUEfa0M2t7xGs=
X-Google-Smtp-Source: ABdhPJxage+tHG6M1pDl3pkQvv3pNTlMUKRJkaRO0B0PXYp9K3rTKn82Yh+I5bklf9XyZT5fJuhgLJvx5v0eKsClD34=
X-Received: by 2002:a25:47c4:: with SMTP id u187mr21977461yba.225.1631603488945;
 Tue, 14 Sep 2021 00:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210913193906.2813357-1-fallentree@fb.com>
In-Reply-To: <20210913193906.2813357-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 00:11:17 -0700
Message-ID: <CAEf4BzZD7mTAb39vxG7s6mH1PxLchZTpJkk4rPH2UJPX2XfwXg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 12:39 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds "-j" mode to test_progs, executing tests in multiple process.
> "-j" mode is optional, and works with all existing test selection mechanism, as
> well as "-v", "-l" etc.
>
> In "-j" mode, main process use UDS/DGRAM to communicate to each forked worker,
> commanding it to run tests and collect logs. After all tests are finished, a
> summary is printed. main process use multiple competing threads to dispatch
> work to worker, trying to keep them all busy.
>

Overall this looks great and I'm super excited that we'll soon be able
to run tests mostly in parallel. I've done the first rough pass over
the code, but haven't played with running this locally yet.

I didn't trim the message to keep all the context in one place, so
please scroll through all of the below till the end.

> Example output:
>
>   > ./test_progs -n 15-20 -j
>   [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
>   Launching 2 workers.
>   [0]: Running test 15.
>   [1]: Running test 16.
>   [1]: Running test 17.
>   [1]: Running test 18.
>   [1]: Running test 19.
>   [1]: Running test 20.
>   [1]: worker exit.
>   [0]: worker exit.

I think these messages shouldn't be emitted in normal mode, and not
even with -v. Maybe -vv. They will be useful initially to debug bugs
in concurrent test runner, probably, so I'd hide them behind a very
verbose setting.

>   #15 btf_dump:OK
>   #16 btf_endian:OK
>   #17 btf_map_in_map:OK
>   #18 btf_module:OK
>   #19 btf_skc_cls_ingress:OK
>   #20 btf_split:OK
>   Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
>
> Know issue:
>
> Some tests fail when running concurrently, later patch will either
> fix the test or pin them to worker 0.

Hm.. patch #3 does that, no?

>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
>
> V4 -> V3: address style warnings.
> V3 -> V2: fix missing outputs in commit messages.
> V2 -> V1: switch to UDS client/server model.

patch sets with more than one patch should come with a cover letter.
Keeping more-or-less detailed history in a cover letter is the best.
For next revision please add the cover letter and move the history
there. Check some other patch sets for an example.

> ---
>  tools/testing/selftests/bpf/test_progs.c | 458 ++++++++++++++++++++++-
>  tools/testing/selftests/bpf/test_progs.h |  36 +-
>  2 files changed, 480 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 2ed01f615d20..c542e2d2f893 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -12,6 +12,11 @@
>  #include <string.h>
>  #include <execinfo.h> /* backtrace */
>  #include <linux/membarrier.h>
> +#include <sys/sysinfo.h> /* get_nprocs */
> +#include <netinet/in.h>
> +#include <sys/select.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
>
>  /* Adapted from perf/util/string.c */
>  static bool glob_match(const char *str, const char *pat)
> @@ -48,6 +53,7 @@ struct prog_test_def {
>         bool force_log;
>         int error_cnt;
>         int skip_cnt;
> +       int sub_succ_cnt;
>         bool tested;
>         bool need_cgroup_cleanup;
>
> @@ -97,6 +103,10 @@ static void dump_test_log(const struct prog_test_def *test, bool failed)
>         if (stdout == env.stdout)
>                 return;
>
> +       /* worker always holds log */
> +       if (env.worker_index != -1)
> +               return;
> +
>         fflush(stdout); /* exports env.log_buf & env.log_cnt */
>
>         if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
> @@ -172,14 +182,14 @@ void test__end_subtest()
>
>         dump_test_log(test, sub_error_cnt);
>
> -       fprintf(env.stdout, "#%d/%d %s/%s:%s\n",
> +       fprintf(stdout, "#%d/%d %s/%s:%s\n",
>                test->test_num, test->subtest_num, test->test_name, test->subtest_name,
>                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));

shouldn't this be emitted by the server (main) process, not the
worker? Worker itself just returns numbers through UDS.

>
>         if (sub_error_cnt)
> -               env.fail_cnt++;
> +               test->error_cnt++;
>         else if (test->skip_cnt == 0)
> -               env.sub_succ_cnt++;
> +               test->sub_succ_cnt++;

this also doesn't feel like a worker's responsibility and logic. It
feels like there is a bit of a missing separation between "executing
test" and "accounting and reporting test result". I'll get to that
below when talking about duplication of code and logic between
parallel and non-parallel modes of operation.

>         skip_account();
>
>         free(test->subtest_name);
> @@ -474,6 +484,7 @@ enum ARG_KEYS {
>         ARG_LIST_TEST_NAMES = 'l',
>         ARG_TEST_NAME_GLOB_ALLOWLIST = 'a',
>         ARG_TEST_NAME_GLOB_DENYLIST = 'd',
> +       ARG_NUM_WORKERS = 'j',
>  };
>
>  static const struct argp_option opts[] = {
> @@ -495,6 +506,8 @@ static const struct argp_option opts[] = {
>           "Run tests with name matching the pattern (supports '*' wildcard)." },
>         { "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
>           "Don't run tests with name matching the pattern (supports '*' wildcard)." },
> +       { "workers", ARG_NUM_WORKERS, "WORKERS", OPTION_ARG_OPTIONAL,
> +         "Number of workers to run in parallel, default to number of cpus." },
>         {},
>  };
>
> @@ -661,6 +674,17 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>         case ARG_LIST_TEST_NAMES:
>                 env->list_test_names = true;
>                 break;
> +       case ARG_NUM_WORKERS:
> +               if (arg) {
> +                       env->workers = atoi(arg);
> +                       if (!env->workers) {
> +                               fprintf(stderr, "Invalid number of worker: %s.", arg);
> +                               return -1;
> +                       }
> +               } else {
> +                       env->workers = get_nprocs();
> +               }
> +               break;
>         case ARGP_KEY_ARG:
>                 argp_usage(state);
>                 break;
> @@ -678,7 +702,7 @@ static void stdio_hijack(void)
>         env.stdout = stdout;
>         env.stderr = stderr;
>
> -       if (env.verbosity > VERBOSE_NONE) {
> +       if (env.verbosity > VERBOSE_NONE && env.worker_index == -1) {
>                 /* nothing to do, output to stdout by default */
>                 return;

there is a big #ifdef __GLIBC__ guard around this code. If its false
and we can't really hijack stdout/stderr in parallel mode, we should
just error out, otherwise it will be a mess with output.

>         }
> @@ -704,10 +728,6 @@ static void stdio_restore(void)
>                 return;
>
>         fclose(stdout);
> -       free(env.log_buf);
> -
> -       env.log_buf = NULL;
> -       env.log_cnt = 0;
>
>         stdout = env.stdout;
>         stderr = env.stderr;
> @@ -799,6 +819,366 @@ void crash_handler(int signum)
>         backtrace_symbols_fd(bt, sz, STDERR_FILENO);
>  }
>
> +int current_test_idx = 0;
> +pthread_mutex_t current_test_lock;

does this have to be global?

> +
> +struct test_result {
> +       int error_cnt;
> +       int skip_cnt;
> +       int sub_succ_cnt;
> +
> +       size_t log_cnt;
> +       char *log_buf;
> +};
> +
> +struct test_result test_results[ARRAY_SIZE(prog_test_defs)];

same, make static?

> +
> +static inline const char *str_msg(const struct message *msg)
> +{
> +       static char buf[255];

str_msg is called from send_message/recv_message, which are called
from one of many dispatch threads. You can't use shared static buf,
you'll inevitably corrupt each other messages

> +
> +       switch (msg->type) {
> +       case MSG_DO_TEST:
> +               sprintf(buf, "MSG_DO_TEST %d", msg->u.message_do_test.num);
> +               break;
> +       case MSG_TEST_DONE:
> +               sprintf(buf, "MSG_TEST_DONE %d (log: %d)",
> +                       msg->u.message_test_done.num,
> +                       msg->u.message_test_done.have_log);
> +               break;
> +       case MSG_TEST_LOG:
> +               sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
> +                       strlen(msg->u.message_test_log.log_buf),
> +                       msg->u.message_test_log.is_last);
> +               break;
> +       case MSG_EXIT:
> +               sprintf(buf, "MSG_EXIT");
> +               break;
> +       default:
> +               sprintf(buf, "UNKNOWN");
> +               break;
> +       }
> +
> +       return buf;
> +}
> +
> +int send_message(int sock, const struct message *msg)

here and everywhere else, unless function and variable has to be
global, it has to be static

> +{
> +       if (env.verbosity > VERBOSE_NONE)
> +               fprintf(stderr, "Sending msg: %s\n", str_msg(msg));
> +       return send(sock, msg, sizeof(*msg), 0);
> +}
> +
> +int recv_message(int sock, struct message *msg)
> +{
> +       int ret;
> +
> +       memset(msg, 0, sizeof(*msg));
> +       ret = recv(sock, msg, sizeof(*msg), 0);
> +       if (ret >= 0) {
> +               if (env.verbosity > VERBOSE_NONE)
> +                       fprintf(stderr, "Received msg: %s\n", str_msg(msg));
> +       }
> +       return ret;
> +}
> +
> +struct dispatch_data {
> +       int idx;

is idx a worker index? let's make it clear with worker_idx/worker_id/worker_num?

> +       int sock;

is this a socket file descriptor? sock_fd then?

> +};
> +
> +void *dispatch_thread(void *_data)

our code base doesn't really use _-prefixed arguments, why not just
call it "arg" or "input" or "ctx"?

> +{
> +       struct dispatch_data *data;
> +       int sock;
> +       FILE *log_fd = NULL;
> +
> +       data = (struct dispatch_data *)_data;

in C you can just:

struct dispatch_data *data = input;

right there at variable declaration

> +       sock = data->sock;
> +
> +       while (true) {
> +               int test_to_run = -1;
> +               struct prog_test_def *test;
> +               struct test_result *result;
> +
> +               /* grab a test */
> +               {
> +                       pthread_mutex_lock(&current_test_lock);
> +
> +                       if (current_test_idx >= prog_test_cnt) {
> +                               pthread_mutex_unlock(&current_test_lock);
> +                               goto done;
> +                       }
> +                       test_to_run = current_test_idx;
> +                       current_test_idx++;
> +
> +                       pthread_mutex_unlock(&current_test_lock);
> +               }
> +
> +               test = &prog_test_defs[test_to_run];
> +               test->test_num = test_to_run + 1;

let's initialize test->test_num outside of all this logic in main()
(together with whatever other test_def initializations we need to
perform at startup)

> +
> +               if (!should_run(&env.test_selector,
> +                               test->test_num, test->test_name))
> +                       continue;

this probably also can be extracted outside of single-thread/parallel
execution paths, it's basically a simple pre-initialization as well.
Each test will be just marked as needing the run or not. WDYT?

> +
> +               /* run test through worker */
> +               {
> +                       struct message msg_do_test;
> +
> +                       msg_do_test.type = MSG_DO_TEST;
> +                       msg_do_test.u.message_do_test.num = test_to_run;
> +                       if (send_message(sock, &msg_do_test) < 0) {
> +                               perror("Fail to send command");
> +                               goto done;
> +                       }
> +                       env.worker_current_test[data->idx] = test_to_run;
> +               }
> +
> +               /* wait for test done */
> +               {
> +                       struct message msg_test_done;
> +
> +                       if (recv_message(sock, &msg_test_done) < 0)
> +                               goto error;
> +                       if (msg_test_done.type != MSG_TEST_DONE)
> +                               goto error;
> +                       if (test_to_run != msg_test_done.u.message_test_done.num)
> +                               goto error;
> +
> +                       result = &test_results[test_to_run];
> +
> +                       test->tested = true;
> +
> +                       result->error_cnt = msg_test_done.u.message_test_done.error_cnt;
> +                       result->skip_cnt = msg_test_done.u.message_test_done.skip_cnt;
> +                       result->sub_succ_cnt = msg_test_done.u.message_test_done.sub_succ_cnt;
> +
> +                       /* collect all logs */
> +                       if (msg_test_done.u.message_test_done.have_log) {
> +                               log_fd = open_memstream(&result->log_buf, &result->log_cnt);
> +                               if (!log_fd)
> +                                       goto error;
> +
> +                               while (true) {
> +                                       struct message msg_log;
> +
> +                                       if (recv_message(sock, &msg_log) < 0)
> +                                               goto error;
> +                                       if (msg_log.type != MSG_TEST_LOG)
> +                                               goto error;
> +
> +                                       fprintf(log_fd, "%s", msg_log.u.message_test_log.log_buf);
> +                                       if (msg_log.u.message_test_log.is_last)
> +                                               break;
> +                               }
> +                               fclose(log_fd);
> +                               log_fd = NULL;
> +                       }
> +               }
> +       } /* while (true) */
> +error:
> +       fprintf(stderr, "[%d]: Protocol/IO error: %s", data->idx, strerror(errno));
> +
> +       if (log_fd)
> +               fclose(log_fd);
> +done:
> +       {
> +               struct message msg_exit;
> +
> +               msg_exit.type = MSG_EXIT;
> +               if (send_message(sock, &msg_exit) < 0)
> +                       fprintf(stderr, "[%d]: send_message msg_exit: %s", data->idx, strerror(errno));
> +       }
> +       return NULL;
> +}
> +
> +int server_main(void)
> +{
> +       pthread_t *dispatcher_threads;
> +       struct dispatch_data *data;
> +
> +       dispatcher_threads = calloc(sizeof(pthread_t), env.workers);
> +       data = calloc(sizeof(struct dispatch_data), env.workers);
> +
> +       env.worker_current_test = calloc(sizeof(int), env.workers);
> +       for (int i = 0; i < env.workers; i++) {
> +               int rc;
> +
> +               data[i].idx = i;
> +               data[i].sock = env.worker_socks[i];
> +               rc = pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &data[i]);
> +               if (rc < 0) {
> +                       perror("Failed to launch dispatcher thread");
> +                       return -1;
> +               }
> +       }
> +
> +       /* wait for all dispatcher to finish */
> +       for (int i = 0; i < env.workers; i++) {
> +               while (true) {
> +                       struct timespec timeout = {
> +                               .tv_sec = time(NULL) + 5,
> +                               .tv_nsec = 0
> +                       };
> +                       if (pthread_timedjoin_np(dispatcher_threads[i], NULL, &timeout) != ETIMEDOUT)
> +                               break;
> +                       fprintf(stderr, "Still waiting for thread %d (test %d).\n", i,  env.worker_current_test[i] + 1);

This is just going to spam output needlessly. Why dispatches have to
exit within 5 seconds, if there are tests that are running way longer
than that?... probably better to just do pthread_join()?

> +               }
> +       }
> +       free(dispatcher_threads);
> +       free(env.worker_current_test);
> +       free(data);
> +
> +       /* generate summary */
> +       fflush(stderr);
> +       fflush(stdout);
> +
> +       for (int i = 0; i < prog_test_cnt; i++) {
> +               struct prog_test_def *current_test;
> +               struct test_result *result;
> +
> +               current_test = &prog_test_defs[i];
> +               result = &test_results[i];
> +
> +               if (!current_test->tested)
> +                       continue;
> +
> +               env.succ_cnt += result->error_cnt ? 0 : 1;
> +               env.skip_cnt += result->skip_cnt;
> +               env.fail_cnt += result->error_cnt;
> +               env.sub_succ_cnt += result->sub_succ_cnt;
> +
> +               if (result->log_cnt) {
> +                       result->log_buf[result->log_cnt] = '\0';
> +                       fprintf(stdout, "%s", result->log_buf);
> +                       if (result->log_buf[result->log_cnt - 1] != '\n')
> +                               fprintf(stdout, "\n");
> +               }
> +               fprintf(stdout, "#%d %s:%s\n",
> +                       current_test->test_num, current_test->test_name,
> +                       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));

it would be nice to see this as results come in (when handling
msg_test_done). It will come out of order, but it will sort of be a
progress indicator that stuff is happening. Why the totals summary
will be then output at the very end at the bottom.

> +       }
> +
> +       fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> +               env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> +
> +       /* reap all workers */
> +       for (int i = 0; i < env.workers; i++) {
> +               int wstatus, pid;
> +
> +               pid = waitpid(env.worker_pids[i], &wstatus, 0);

should we send SIGKILL as well to ensure that some stuck or buggy
worker gets reaped for sure?

> +               assert(pid == env.worker_pids[i]);

let's not use assert(), better print error message

> +       }
> +
> +       return 0;
> +}
> +
> +int worker_main(int sock)
> +{
> +       save_netns();
> +
> +       while (true) {
> +               /* receive command */
> +               struct message msg;
> +
> +               assert(recv_message(sock, &msg) >= 0);

see above about assert()s

> +
> +               switch (msg.type) {
> +               case MSG_EXIT:
> +                       fprintf(stderr, "[%d]: worker exit.\n",  env.worker_index);
> +                       goto out;
> +               case MSG_DO_TEST: {
> +                       int test_to_run;
> +                       struct prog_test_def *test;
> +                       struct message msg_done;
> +
> +                       test_to_run = msg.u.message_do_test.num;
> +
> +                       fprintf(stderr, "[%d]: Running test %d.\n",
> +                               env.worker_index, test_to_run + 1);
> +
> +                       test = &prog_test_defs[test_to_run];
> +
> +                       env.test = test;
> +                       test->test_num = test_to_run + 1;
> +
> +                       stdio_hijack();
> +
> +                       test->run_test();
> +
> +                       /* ensure last sub-test is finalized properly */
> +                       if (test->subtest_name)
> +                               test__end_subtest();
> +
> +                       stdio_restore();
> +
> +                       test->tested = true;
> +
> +                       skip_account();

my biggest concern right now is with all this setup/teardown code
being duplicated between sequential mode and parallel mode. Let's
ensure that as much as possible is shared and re-used through either
helper functions or by doing whatever initialization that can be done
outside of test running loop itself (as suggested for test->test_num
and test filtering logic).

one way to attach some of that duplication is by having the logic for
MSG_DO_TEST handling extracted into a separate function that would be
called both from forked worker process *and* from sequential mode main
process all the same. The send_message() logic would stay in
parallelized worker code, most probably.

> +
> +                       reset_affinity();
> +                       restore_netns();
> +                       if (test->need_cgroup_cleanup)
> +                               cleanup_cgroup_environment();
> +
> +                       memset(&msg_done, 0, sizeof(msg_done));
> +                       msg_done.type = MSG_TEST_DONE;
> +                       msg_done.u.message_test_done.num = test_to_run;
> +                       msg_done.u.message_test_done.error_cnt = test->error_cnt;
> +                       msg_done.u.message_test_done.skip_cnt = test->skip_cnt;
> +                       msg_done.u.message_test_done.sub_succ_cnt = test->sub_succ_cnt;
> +                       msg_done.u.message_test_done.have_log = false;
> +
> +                       if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> +                               if (env.log_cnt)
> +                                       msg_done.u.message_test_done.have_log = true;
> +                       }
> +                       assert(send_message(sock, &msg_done) >= 0);
> +
> +                       /* send logs */
> +                       if (msg_done.u.message_test_done.have_log) {
> +                               char *src;
> +                               size_t slen;
> +
> +                               src = env.log_buf;
> +                               slen = env.log_cnt;
> +                               while (slen) {
> +                                       struct message msg_log;
> +                                       char *dest;
> +                                       size_t len;
> +
> +                                       memset(&msg_log, 0, sizeof(msg_log));
> +                                       msg_log.type = MSG_TEST_LOG;
> +                                       dest = msg_log.u.message_test_log.log_buf;
> +                                       len = slen >= MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
> +                                       memcpy(dest, src, len);
> +
> +                                       src += len;
> +                                       slen -= len;
> +                                       if (!slen)
> +                                               msg_log.u.message_test_log.is_last = true;
> +
> +                                       assert(send_message(sock, &msg_log) >= 0);
> +                               }
> +                       }
> +                       if (env.log_buf) {
> +                               free(env.log_buf);
> +                               env.log_buf = NULL;
> +                               env.log_cnt = 0;
> +                       }
> +                       break;
> +               } /* case MSG_DO_TEST */
> +               default:
> +                       fprintf(stderr, "[%d]: unknown message.\n",  env.worker_index);
> +                       return -1;
> +               }
> +       }
> +out:
> +       restore_netns();
> +       return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         static const struct argp argp = {
> @@ -837,13 +1217,57 @@ int main(int argc, char **argv)
>                 return -1;
>         }
>
> -       save_netns();
> -       stdio_hijack();
>         env.has_testmod = true;
>         if (!env.list_test_names && load_bpf_testmod()) {
>                 fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
>                 env.has_testmod = false;
>         }
> +
> +       /* ignore workers if we are just listing */
> +       if (env.get_test_cnt || env.list_test_names)
> +               env.workers = 0;
> +
> +       /* launch workers if requested */
> +       env.worker_index = -1; /* main process */
> +       if (env.workers) {
> +               env.worker_pids = calloc(sizeof(__pid_t), env.workers);
> +               env.worker_socks = calloc(sizeof(int), env.workers);
> +               fprintf(stdout, "Launching %d workers.\n", env.workers);
> +               for (int i = 0; i < env.workers; i++) {
> +                       int sv[2];
> +                       __pid_t pid;

nit: how's __pid_t different from pid_t?

> +
> +                       if (socketpair(AF_UNIX, SOCK_DGRAM, 0, sv) < 0) {
> +                               perror("Fail to create worker socket");
> +                               return -1;
> +                       }
> +                       pid = fork();
> +                       if (pid < 0) {
> +                               perror("Failed to fork worker");
> +                               return -1;
> +                       } else if (pid != 0) { /* main process */
> +                               close(sv[1]);
> +                               env.worker_pids[i] = pid;
> +                               env.worker_socks[i] = sv[0];
> +                       } else { /* inside each worker process */
> +                               close(sv[0]);
> +                               env.worker_index = i;
> +                               return worker_main(sv[1]);
> +                       }
> +               }
> +
> +               if (env.worker_index == -1) {

it can't be anything else here, so you can just run server_main() directly

> +                       server_main();
> +                       goto out;
> +               }
> +       }
> +
> +       /* The rest of the main process */
> +
> +       /* on single mode */
> +       save_netns();
> +       stdio_hijack();
> +
>         for (i = 0; i < prog_test_cnt; i++) {
>                 struct prog_test_def *test = &prog_test_defs[i];
>
> @@ -866,6 +1290,7 @@ int main(int argc, char **argv)
>                 }
>
>                 test->run_test();
> +
>                 /* ensure last sub-test is finalized properly */
>                 if (test->subtest_name)
>                         test__end_subtest();
> @@ -882,16 +1307,21 @@ int main(int argc, char **argv)
>                         env.fail_cnt++;
>                 else
>                         env.succ_cnt++;
> +
>                 skip_account();
> +               env.sub_succ_cnt += test->sub_succ_cnt;
>
>                 reset_affinity();
>                 restore_netns();
>                 if (test->need_cgroup_cleanup)
>                         cleanup_cgroup_environment();

all the logic in this loop (and maybe more of the surrounding code as
well) is conceptually either 1) running the test or 2)
accounting/reporting test results. For sequential mode it can be
intermixed, but for parallel mode there is a strict distinction:
running happens inside the worker, while accounting happens in the
dispatcher process. For sequential we can model the interaction the
same way and reuse as much code as possible.

>         }
> -       if (!env.list_test_names && env.has_testmod)
> -               unload_bpf_testmod();
>         stdio_restore();
> +       if (env.log_buf) {
> +               free(env.log_buf);
> +               env.log_buf = NULL;
> +               env.log_cnt = 0;
> +       }
>
>         if (env.get_test_cnt) {
>                 printf("%d\n", env.succ_cnt);
> @@ -904,14 +1334,16 @@ int main(int argc, char **argv)
>         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
>
> +       close(env.saved_netns_fd);
>  out:
> +       if (!env.list_test_names && env.has_testmod)
> +               unload_bpf_testmod();
>         free_str_set(&env.test_selector.blacklist);
>         free_str_set(&env.test_selector.whitelist);
>         free(env.test_selector.num_set);
>         free_str_set(&env.subtest_selector.blacklist);
>         free_str_set(&env.subtest_selector.whitelist);
>         free(env.subtest_selector.num_set);
> -       close(env.saved_netns_fd);
>
>         if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
>                 return EXIT_NO_TEST;
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 94bef0aa74cf..aadb44543225 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -69,7 +69,8 @@ struct test_env {
>         bool get_test_cnt;
>         bool list_test_names;
>
> -       struct prog_test_def *test;
> +       struct prog_test_def *test; /* current running tests */
> +
>         FILE *stdout;
>         FILE *stderr;
>         char *log_buf;
> @@ -82,6 +83,39 @@ struct test_env {
>         int skip_cnt; /* skipped tests */
>
>         int saved_netns_fd;
> +       int workers; /* number of worker process */
> +       int worker_index; /* index number of current worker, main process is -1 */
> +       __pid_t *worker_pids; /* array of worker pids */
> +       int *worker_socks; /* array of worker socks */
> +       int *worker_current_test; /* array of current running test for each worker */
> +};
> +
> +#define MAX_LOG_TRUNK_SIZE 8192
> +enum message_type {
> +       MSG_DO_TEST = 0,
> +       MSG_TEST_DONE = 1,
> +       MSG_TEST_LOG = 2,
> +       MSG_EXIT = 255,
> +};

nit: empty line between type definitions

ok, here comes a bunch of naming nitpicking, sorry about that :) but
the current struct definition is a bit mouthful so it's a bit hard to
read, and some fields are actually too succinct at the same time, so
that it's hard to understand in some places what the field represents.

> +struct message {
> +       enum message_type type;

total nitpick, but given MSG_ enums above, I'd stick to "msg"
everywhere and have struct msg and enum msg_type

> +       union {
> +               struct {
> +                       int num;

this is the test number, right? test_num would make it more clear.
There were a few times when I wondered if it's worker number or a test
number.

> +               } message_do_test;

this is a bit tautological. In the code above you have accesses like:

msg->u.message_do_test.num

that message_ prefix doesn't bring any value, just makes everything
unnecessarily verbose. With the below suggestion to drop u name for
union and by dropping message_ prefix everywhere, we'll be down to a
clean ans simple

msg->do_test.test_num

(and I'd s/do_test/run_test/ because it reads better for me, but I
won't complain either way)


> +               struct {
> +                       int num;

same about test_num
> +
> +                       int sub_succ_cnt;
> +                       int error_cnt;
> +                       int skip_cnt;
> +                       bool have_log;
> +               } message_test_done;
> +               struct {
> +                       char log_buf[MAX_LOG_TRUNK_SIZE + 1];
> +                       bool is_last;
> +               } message_test_log;
> +       } u;

there is no need to name this union, it can be anonymous allowing to
skip .u. part in field accesses

>  };
>
>  extern struct test_env env;
> --
> 2.30.2
>
