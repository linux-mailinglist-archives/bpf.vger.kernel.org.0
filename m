Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA44C40FFEF
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbhIQTqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 15:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbhIQTqO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 15:46:14 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A16C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 12:44:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id y144so20934357qkb.6
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/e5rFI5CfZCvsgDDvbOiObx/TyYo+b6AcUTrZdc9r08=;
        b=YuCwwy2SUj2HUnB2YSRovXrDr2khDREgQrsOskqKrxMpaTf1rKUkpP5dcMyfgQUajp
         KxVAusrzugVADe4h7NmNz9iiBfXxzeczumDvGTaFFymt7bab8708aJmY/a6Cx7dIaxHl
         nI7OJ216DL4E0zfptHgUBT6xz8nT9hFNlPYMhfkM/ohpvMqDlf6ekK74UlOTDoCjzs4J
         NjEq/e0YitGkdaTXZdrpkUnYbHBvUqBzZMY6iy4slqO/MeBFwxVtvU83kxWH9kCplfaE
         fyAk47T1yDsaZ22upAsTnaAl4K4kOnejFpWL8RWll8NXLK7LS23dwWQslF6KRIIPtSLZ
         y4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/e5rFI5CfZCvsgDDvbOiObx/TyYo+b6AcUTrZdc9r08=;
        b=BMj60y9r7YXKaMdgtrPfZqdcn5RQr4NF1kvdNzapEnKDxWo/+ReiC3JybYKsqcthwv
         f4yYuGOb7uGGVWLqtEY0Hgh/N8WSGRUDexYX6ReahG5TR+3UCwfP5bpitx0v3URZXOpo
         Wo6xDNSiaLnfmpBuiW53ZDTgbaHuFNa1lILn625Ey9lZWMIncpZ8T0Ty9SiY2PglCGb3
         jOev+aEugZq2k4o8XkwRfj1dU+eApOkH5kSH1QGv4UN5e0kAt13dDrfKcFArq2yi2Ns4
         o5x4wXA+qKKsgfPoXboSvKejjT78XDMCRJJIsuPNlDLDIVVg4N3zE6T/Fcl3ECOV1CiZ
         DjIw==
X-Gm-Message-State: AOAM530RytxTOVGQD13cuFoiSb56FqqYPCkAbDJ/3SbteCvkISIWoULL
        //2CRPUwf9NkEQ/16wgQPMLQnih6fShC8aQM0PQ=
X-Google-Smtp-Source: ABdhPJw8VKErWzbWrvFxnrxsIfJjyOXpdgrBYgIqD1u1eemP6RAM75MQTm5HzpPf6rnfQdvqKsUeZgodKecea5J4q1Y=
X-Received: by 2002:a25:840d:: with SMTP id u13mr1794481ybk.455.1631907890988;
 Fri, 17 Sep 2021 12:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210916032641.1413293-1-fallentree@fb.com> <20210916032641.1413293-2-fallentree@fb.com>
In-Reply-To: <20210916032641.1413293-2-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 12:44:39 -0700
Message-ID: <CAEf4BzYNWRGNLH_s2Yi5iYC3a9_gEi7u1kRJ-+J0xV2q7idKeQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 8:26 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds "-j" mode to test_progs, executing tests in multiple process.
> "-j" mode is optional, and works with all existing test selection mechanism, as
> well as "-v", "-l" etc.
>
> In "-j" mode, main process use UDS to communicate to each forked worker,
> commanding it to run tests and collect logs. After all tests are
> finished, a summary is printed. main process use multiple competing
> threads to dispatch work to worker, trying to keep them all busy.
>
> The test status will be printed as soon as it is finished, if there are error
> logs, it will be printed after the final summary line.
>
> By specifying "--debug", additional debug information on server/worker
> communication will be printed.
>
> Example output:
>   > ./test_progs -n 15-20 -j
>   [   12.801730] bpf_testmod: loading out-of-tree module taints kernel.
>   Launching 8 workers.
>   #20 btf_split:OK
>   #16 btf_endian:OK
>   #18 btf_module:OK
>   #17 btf_map_in_map:OK
>   #19 btf_skc_cls_ingress:OK
>   #15 btf_dump:OK
>   Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

Love the error summary logic. Can we please have it in sequential mode
as well?... :)

Also didn't find anything obvious that would explain 20 second
parallel run for few small and fast tests.

>  tools/testing/selftests/bpf/test_progs.c | 577 +++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h |  36 +-
>  2 files changed, 581 insertions(+), 32 deletions(-)
>

[...]

> @@ -661,6 +678,20 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>         case ARG_LIST_TEST_NAMES:
>                 env->list_test_names = true;
>                 break;
> +       case ARG_NUM_WORKERS:
> +               if (arg) {
> +                       env->workers = atoi(arg);
> +                       if (!env->workers) {
> +                               fprintf(stderr, "Invalid number of worker: %s.", arg);
> +                               return -1;

I missed this problem when SELFTESTS_VERBOSE logic was added, but all
the rest of the code returns -EINVAL, not -EPERM (-1). Let's keep it
consistent.

> +                       }
> +               } else {
> +                       env->workers = get_nprocs();
> +               }
> +               break;
> +       case ARG_DEBUG:
> +               env->debug = true;
> +               break;
>         case ARGP_KEY_ARG:
>                 argp_usage(state);
>                 break;
> @@ -678,7 +709,7 @@ static void stdio_hijack(void)
>         env.stdout = stdout;
>         env.stderr = stderr;
>
> -       if (env.verbosity > VERBOSE_NONE) {
> +       if (env.verbosity > VERBOSE_NONE && env.worker_id == -1) {
>                 /* nothing to do, output to stdout by default */
>                 return;
>         }
> @@ -704,10 +735,6 @@ static void stdio_restore(void)
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
> @@ -794,11 +821,444 @@ void crash_handler(int signum)
>                 dump_test_log(env.test, true);
>         if (env.stdout)
>                 stdio_restore();
> -
> +       if (env.worker_id != -1)
> +               fprintf(stderr, "[%d]: ", env.worker_id);
>         fprintf(stderr, "Caught signal #%d!\nStack trace:\n", signum);
>         backtrace_symbols_fd(bt, sz, STDERR_FILENO);
>  }
>
> +void sigint_handler(int signum) {

{ on new line, please run checkpatch.pl

> +       for (int i = 0; i < env.workers; i++)
> +               close(env.worker_socks[i]);

this can race with env.worker_socks allocation, no? Better to install
signal handler after we initialize env completely. Also it's a good
idea to reset sigint handler after first ctrl-c just in case something
got stuck. So that second ctrl-c will unconditionally kill the
process. Nothing more annoying than application that got stuck and it
doesn't die on ctrl-c

> +}
> +
> +static int current_test_idx = 0;
> +static pthread_mutex_t current_test_lock;
> +static pthread_mutex_t stdout_output_lock;
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
> +static struct test_result test_results[ARRAY_SIZE(prog_test_defs)];
> +
> +static inline const char *str_msg(const struct msg *msg, char *buf)
> +{
> +       switch (msg->type) {
> +       case MSG_DO_TEST:
> +               sprintf(buf, "MSG_DO_TEST %d", msg->do_test.test_num);
> +               break;
> +       case MSG_TEST_DONE:
> +               sprintf(buf, "MSG_TEST_DONE %d (log: %d)",
> +                       msg->test_done.test_num,
> +                       msg->test_done.have_log);
> +               break;
> +       case MSG_TEST_LOG:
> +               sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
> +                       strlen(msg->test_log.log_buf),
> +                       msg->test_log.is_last);
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
> +static int send_message(int sock, const struct msg *msg)
> +{
> +       char buf[256];

empty line after variable declaration block

> +       if (env.verbosity > VERBOSE_SUPER)
> +               fprintf(stderr, "Sending msg: %s\n", str_msg(msg, buf));

I thought you were going to make this depend on --debug? you can also
combine check for --debug and verbosity levels, if necessry, so that
you can have more control for debugging

> +       return send(sock, msg, sizeof(*msg), 0);
> +}
> +
> +static int recv_message(int sock, struct msg *msg)
> +{
> +       int ret;
> +       char buf[256];
> +
> +       memset(msg, 0, sizeof(*msg));
> +       ret = recv(sock, msg, sizeof(*msg), 0);
> +       if (ret >= 0) {
> +               if (env.debug)
> +                       fprintf(stderr, "Received msg: %s\n", str_msg(msg, buf));
> +       }
> +       return ret;
> +}
> +
> +static void run_one_test(int test_num) {

{ on separate line

> +       struct prog_test_def *test = &prog_test_defs[test_num];
> +
> +       env.test = test;
> +
> +       test->run_test();
> +
> +       /* ensure last sub-test is finalized properly */
> +       if (test->subtest_name)
> +              test__end_subtest();
> +
> +       test->tested = true;
> +
> +       dump_test_log(test, test->error_cnt);
> +
> +       reset_affinity();
> +       restore_netns();
> +       if (test->need_cgroup_cleanup)
> +              cleanup_cgroup_environment();
> +}
> +
> +static const char *get_test_name(int idx)
> +{
> +       struct prog_test_def *test;
> +
> +       test = &prog_test_defs[idx];
> +       return test->test_name;
> +}

seems like a quite useless helper, prog_tests_defs[idx].test_name is
just as short. If you are worried about prog_test_defs[] setup
changing, then adding helper to return pointer to the test definition
itself is more useful, because you fetch that test def pointer in more
places

> +
> +struct dispatch_data {
> +       int worker_id;
> +       int sock_fd;
> +};
> +
> +void *dispatch_thread(void *ctx)

static

> +{
> +       struct dispatch_data *data = ctx;
> +       int sock_fd;
> +       FILE *log_fd = NULL;

not a FD, log_file/log_stream?

> +
> +       sock_fd = data->sock_fd;
> +
> +       while (true) {
> +               int test_to_run = -1;

no need to initialize, it's always set if it's used. This -1 made me
search the code needlessly to figure out where this -1 matters.

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
> +
> +                       test = &prog_test_defs[current_test_idx];
> +                       test_to_run = current_test_idx;
> +                       current_test_idx++;
> +
> +                       pthread_mutex_unlock(&current_test_lock);
> +               }
> +
> +               if (!test->should_run) {
> +                       continue;
> +               }

styling: no {} around single-line if bodies. But instead of
locking/unlocking and then checking, why not just find the next test
that should_run above?

> +
> +
> +               /* run test through worker */
> +               {
> +                       struct msg msg_do_test;
> +
> +                       msg_do_test.type = MSG_DO_TEST;
> +                       msg_do_test.do_test.test_num = test_to_run;
> +                       if (send_message(sock_fd, &msg_do_test) < 0) {
> +                               perror("Fail to send command");
> +                               goto done;
> +                       }
> +                       env.worker_current_test[data->worker_id] = test_to_run;
> +               }
> +
> +               /* wait for test done */
> +               {
> +                       struct msg msg_test_done;
> +
> +                       if (errno = recv_message(sock_fd, &msg_test_done) < 0)

is this

errno = (recv_message(sock_fd, &msg_test_done) < 0) && errno != 0

or

errno = recv_message(sock_fd, &msg_test_done);
if (errno < 0) { ... }

?

So please no. And also don't use errno (global thread-local variable
declared by libc) for this, declare `int err`.

> +                               goto error;
> +                       if (msg_test_done.type != MSG_TEST_DONE)
> +                               goto error;
> +                       if (test_to_run != msg_test_done.test_done.test_num)
> +                               goto error;
> +
> +                       test->tested = true;
> +                       result = &test_results[test_to_run];
> +
> +                       result->error_cnt = msg_test_done.test_done.error_cnt;
> +                       result->skip_cnt = msg_test_done.test_done.skip_cnt;
> +                       result->sub_succ_cnt = msg_test_done.test_done.sub_succ_cnt;

s/msg_test_done/msg/, same above for msg_do_test. You have a local
variable in extra {} lexical scope, so no conflict. And it will read
non-redundantly: msg.test_done.sub_succ_cnt.

> +
> +                       /* collect all logs */
> +                       if (msg_test_done.test_done.have_log) {
> +                               log_fd = open_memstream(&result->log_buf, &result->log_cnt);
> +                               if (!log_fd)
> +                                       goto error;
> +
> +                               while (true) {
> +                                       struct msg msg_log;
> +
> +                                       if (recv_message(sock_fd, &msg_log) < 0)
> +                                               goto error;
> +                                       if (msg_log.type != MSG_TEST_LOG)
> +                                               goto error;
> +
> +                                       fprintf(log_fd, "%s", msg_log.test_log.log_buf);
> +                                       if (msg_log.test_log.is_last)
> +                                               break;
> +                               }
> +                               fclose(log_fd);
> +                               log_fd = NULL;
> +                       }
> +                       /* output log */
> +                       {
> +                               pthread_mutex_lock(&stdout_output_lock);
> +
> +                               if (result->log_cnt) {
> +                                       result->log_buf[result->log_cnt] = '\0';
> +                                       fprintf(stdout, "%s", result->log_buf);
> +                                       if (result->log_buf[result->log_cnt - 1] != '\n')
> +                                               fprintf(stdout, "\n");
> +                               }
> +
> +                               fprintf(stdout, "#%d %s:%s\n",
> +                                       test->test_num, test->test_name,
> +                                       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
> +
> +                               pthread_mutex_unlock(&stdout_output_lock);
> +                       }
> +
> +               } /* wait for test done */
> +       } /* while (true) */
> +error:
> +       if (env.debug)
> +               fprintf(stderr, "[%d]: Protocol/IO error: %s.\n", data->worker_id, strerror(errno));

you don't always set errno above when you do `goto error`. Please
don't use errno directly, it's better to save it into int err, and do
`err = -errno; goto error;` everywhere. It's way too easy to forget
and clobber errno.

> +
> +       if (log_fd)
> +               fclose(log_fd);
> +done:
> +       {
> +               struct msg msg_exit;
> +
> +               msg_exit.type = MSG_EXIT;
> +               if (send_message(sock_fd, &msg_exit) < 0) {
> +                       if (env.debug)
> +                               fprintf(stderr, "[%d]: send_message msg_exit: %s.\n",
> +                                       data->worker_id, strerror(errno));
> +               }
> +       }
> +       return NULL;
> +}
> +
> +static int server_main(void)
> +{
> +       pthread_t *dispatcher_threads;
> +       struct dispatch_data *data;
> +
> +       dispatcher_threads = calloc(sizeof(pthread_t), env.workers);
> +       data = calloc(sizeof(struct dispatch_data), env.workers);
> +
> +       env.worker_current_test = calloc(sizeof(int), env.workers);

nit: this is backwards use of calloc(). First argument is the count,
the second is the size of the element. I don't know if that matters,
but it might matter for some alignment logic. So please swap the
order.

> +       for (int i = 0; i < env.workers; i++) {

int i inside for  isn't C89, please declare outside. And we should
specify whatever the compiler flags are specified for the kernel to
make the compiler complain about this...

> +               int rc;
> +
> +               data[i].worker_id = i;
> +               data[i].sock_fd = env.worker_socks[i];
> +               rc = pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &data[i]);
> +               if (rc < 0) {
> +                       perror("Failed to launch dispatcher thread");
> +                       return -1;
> +               }
> +       }
> +
> +       /* wait for all dispatcher to finish */
> +       for (int i = 0; i < env.workers; i++) {

same

> +               while (true) {
> +                       struct timespec timeout = {
> +                               .tv_sec = time(NULL) + 5,
> +                               .tv_nsec = 0
> +                       };

empty line goes here, checkpatch.pl goes everywhere :)

> +                       if (pthread_timedjoin_np(dispatcher_threads[i], NULL, &timeout) != ETIMEDOUT)
> +                               break;
> +                       if (env.debug)
> +                               fprintf(stderr, "Still waiting for thread %d (test %d).\n",
> +                                       i,  env.worker_current_test[i] + 1);
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
> +       }
> +
> +       fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> +               env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
> +       if (env.fail_cnt)
> +               fprintf(stdout, "\nAll error logs:\n");
> +
> +       /* print error logs again */
> +
> +       for (int i = 0; i < prog_test_cnt; i++) {
> +               struct prog_test_def *current_test;
> +               struct test_result *result;
> +
> +               current_test = &prog_test_defs[i];
> +               result = &test_results[i];
> +
> +               if (!current_test->tested || !result->error_cnt)
> +                       continue;
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

This if and fprintfs is duplicated, can you move it into a helper?

> +       }
> +
> +       /* reap all workers */
> +       for (int i = 0; i < env.workers; i++) {
> +               int wstatus, pid;
> +
> +               pid = waitpid(env.worker_pids[i], &wstatus, 0);
> +               if (pid != env.worker_pids[i])
> +                       perror("Unable to reap worker");
> +       }
> +
> +       return 0;
> +}
> +
> +static int worker_main(int sock)
> +{
> +       save_netns();
> +
> +       while (true) {
> +               /* receive command */
> +               struct msg msg;
> +
> +               if (recv_message(sock, &msg) < 0)
> +                       goto out;
> +
> +               switch (msg.type) {
> +               case MSG_EXIT:
> +                       if (env.debug)
> +                               fprintf(stderr, "[%d]: worker exit.\n",
> +                                       env.worker_id);
> +                       goto out;
> +               case MSG_DO_TEST: {
> +                       int test_to_run;
> +                       struct prog_test_def *test;
> +                       struct msg msg_done;
> +
> +                       test_to_run = msg.do_test.test_num;
> +
> +                       if (env.debug)
> +                               fprintf(stderr, "[%d]: #%d:%s running.\n",
> +                                       env.worker_id,
> +                                       test_to_run + 1,
> +                                       get_test_name(test_to_run));
> +
> +                       test = &prog_test_defs[test_to_run];
> +
> +                       stdio_hijack();
> +
> +                       run_one_test(test_to_run);
> +
> +                       stdio_restore();
> +
> +                       memset(&msg_done, 0, sizeof(msg_done));

just reuse msg, it's not used anymore at this point

> +                       msg_done.type = MSG_TEST_DONE;
> +                       msg_done.test_done.test_num = test_to_run;
> +                       msg_done.test_done.error_cnt = test->error_cnt;
> +                       msg_done.test_done.skip_cnt = test->skip_cnt;
> +                       msg_done.test_done.sub_succ_cnt = test->sub_succ_cnt;
> +                       msg_done.test_done.have_log = false;
> +
> +                       if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> +                               if (env.log_cnt)
> +                                       msg_done.test_done.have_log = true;
> +                       }
> +                       if (send_message(sock, &msg_done) < 0) {
> +                               perror("Fail to send message done");
> +                               goto out;
> +                       }
> +
> +                       /* send logs */
> +                       if (msg_done.test_done.have_log) {
> +                               char *src;
> +                               size_t slen;
> +
> +                               src = env.log_buf;
> +                               slen = env.log_cnt;
> +                               while (slen) {
> +                                       struct msg msg_log;

same, msg can be just reused

> +                                       char *dest;
> +                                       size_t len;
> +
> +                                       memset(&msg_log, 0, sizeof(msg_log));
> +                                       msg_log.type = MSG_TEST_LOG;
> +                                       dest = msg_log.test_log.log_buf;
> +                                       len = slen >= MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
> +                                       memcpy(dest, src, len);
> +
> +                                       src += len;
> +                                       slen -= len;
> +                                       if (!slen)
> +                                               msg_log.test_log.is_last = true;
> +
> +                                       assert(send_message(sock, &msg_log) >= 0);

missed assert here

> +                               }
> +                       }
> +                       if (env.log_buf) {
> +                               free(env.log_buf);
> +                               env.log_buf = NULL;
> +                               env.log_cnt = 0;
> +                       }
> +                       if (env.debug)
> +                               fprintf(stderr, "[%d]: #%d:%s done.\n",
> +                                       env.worker_id,
> +                                       test_to_run + 1,
> +                                       get_test_name(test_to_run));
> +                       break;
> +               } /* case MSG_DO_TEST */
> +               default:
> +                       if (env.debug)
> +                               fprintf(stderr, "[%d]: unknown message.\n",  env.worker_id);
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
> @@ -809,10 +1269,15 @@ int main(int argc, char **argv)
>         struct sigaction sigact = {
>                 .sa_handler = crash_handler,
>                 .sa_flags = SA_RESETHAND,
> -       };
> +               };
> +       struct sigaction sigact_int = {
> +               .sa_handler = sigint_handler,
> +               .sa_flags = SA_RESETHAND,
> +               };
>         int err, i;
>
>         sigaction(SIGSEGV, &sigact, NULL);
> +       sigaction(SIGINT, &sigact_int, NULL);

as mentioned above, let's delay it until we setup environment completely?

>
>         err = argp_parse(&argp, argc, argv, 0, NULL, &env);
>         if (err)
> @@ -837,21 +1302,76 @@ int main(int argc, char **argv)
>                 return -1;
>         }
>
> -       save_netns();
> -       stdio_hijack();
> +       env.stdout = stdout;
> +       env.stderr = stderr;
> +
>         env.has_testmod = true;
>         if (!env.list_test_names && load_bpf_testmod()) {
>                 fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will be skipped.\n");
>                 env.has_testmod = false;
>         }
> +
> +       /* initializing tests */
>         for (i = 0; i < prog_test_cnt; i++) {
>                 struct prog_test_def *test = &prog_test_defs[i];
>
> -               env.test = test;
>                 test->test_num = i + 1;
> -
> -               if (!should_run(&env.test_selector,
> +               if (should_run(&env.test_selector,
>                                 test->test_num, test->test_name))
> +                       test->should_run = true;
> +               else
> +                       test->should_run = false;

test->should_run = should_run(...)

> +       }
> +
> +       /* ignore workers if we are just listing */
> +       if (env.get_test_cnt || env.list_test_names)
> +               env.workers = 0;
> +
> +       /* launch workers if requested */
> +       env.worker_id = -1; /* main process */
> +       if (env.workers) {
> +               env.worker_pids = calloc(sizeof(__pid_t), env.workers);
> +               env.worker_socks = calloc(sizeof(int), env.workers);

check for NULLs

> +               fprintf(stdout, "Launching %d workers.\n", env.workers);

if (debug)

> +               for (int i = 0; i < env.workers; i++) {
> +                       int sv[2];
> +                       pid_t pid;
> +
> +                       if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv) < 0) {
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
> +                               env.worker_id = i;
> +                               return worker_main(sv[1]);
> +                       }
> +               }
> +
> +               if (env.worker_id == -1) {

you have return worker_main above, can't be anything else, drop unnecessary ifs

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
> +       for (i = 0; i < prog_test_cnt; i++) {
> +               struct prog_test_def *test = &prog_test_defs[i];
> +
> +               if (!test->should_run)
>                         continue;
>
>                 if (env.get_test_cnt) {
> @@ -865,14 +1385,7 @@ int main(int argc, char **argv)
>                         continue;
>                 }
>
> -               test->run_test();
> -               /* ensure last sub-test is finalized properly */
> -               if (test->subtest_name)
> -                       test__end_subtest();
> -
> -               test->tested = true;
> -
> -               dump_test_log(test, test->error_cnt);
> +               run_one_test(i);
>
>                 fprintf(env.stdout, "#%d %s:%s\n",
>                         test->test_num, test->test_name,
> @@ -882,16 +1395,16 @@ int main(int argc, char **argv)
>                         env.fail_cnt++;
>                 else
>                         env.succ_cnt++;
> -               skip_account();
>
> -               reset_affinity();
> -               restore_netns();
> -               if (test->need_cgroup_cleanup)
> -                       cleanup_cgroup_environment();
> +               skip_account();

can you please double-check skip accounting in parallel case? I'm not
sure it's there.

> +               env.sub_succ_cnt += test->sub_succ_cnt;
>         }
> -       if (!env.list_test_names && env.has_testmod)
> -               unload_bpf_testmod();
>         stdio_restore();
> +       if (env.log_buf) {
> +               free(env.log_buf);
> +               env.log_buf = NULL;
> +               env.log_cnt = 0;
> +       }

[...]
