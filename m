Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B108F4273B5
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbhJHW2t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhJHW2t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:28:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD3C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:26:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v195so24278496ybb.0
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXF2Lhd+o5pnoK7mD0mbVCIQvb8b4HYdYGuVXgeAeZ0=;
        b=AtnMERfhLb5XuOnc5ClFznMJ+y1nLVqW1ZLbIhHmXxnubWmq1uxrjK8rFZvOk/yr/m
         K3fLfz+B9UnguYn/RLUNjSfq5Xgp1DQWUSxB6QwOQth9bQ+/J/VZIsbxj+fW7FCJBUUU
         TE7hxjxvnAglYNhaY6p0xNO0V2jRpy4sdbqc48s7k103+UFWIsnTbs/C4wtMpGBHn/7A
         z229jxImz5N76a0zv7gIqQRWBmAeybuSzpeu3RT2bHmzrww3fIYikajzPRqWXZRYGOu+
         6v4jWsQIlRRVmDYRsG3U2GFywvmm8iSWtFBEapcWLRo11/ml+m+0pw07hUd4F5MzAOgz
         uLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXF2Lhd+o5pnoK7mD0mbVCIQvb8b4HYdYGuVXgeAeZ0=;
        b=FmFC/OkPASWUWzACKsG2gDAi3BCkKLTHAGtdSJzMXeZFbOIwEYm4Bxdy1AGEcwyQa1
         /PhChlYN7ix8yx7aTu8JVGJlUiJLljYHW8ULAk1Q01Dqk4LBRy6MBUyDNLeDl/lbpJjP
         b0b4pqgNNovKR5x0G+ApPZtpYtFca+4ojEhei89tBywPWvxNFk3owI3Sb65YDAbn+t/N
         naG/pOstJRGIwFPVzXSPjd58qm4mYh6Rez4ZWT0Rz0qhCKwfj3r38wxozhswt9/83Dlh
         PBDb6aNNzQl+TsCAtITo9JwdeeLoNRQjIJQXIwZLSl3ANljtveltyIP484PhLX05DhCH
         paqA==
X-Gm-Message-State: AOAM531PsHNj71j6WxhQhgKTEaiimXADXjfK3wFOJoP89ROWGgDHXUfk
        c5a9xTJof2XcGs1lOn2K2REoduNS7xkfRbAY+JRnQ5RvexI=
X-Google-Smtp-Source: ABdhPJyFPgGku7Mq8owIS1fbuFfG4B36bePEsqvcphW62PIirYU+qD8RBEo7EqFxj8RnN5Xye9Ytfe6LCEglFMJYI4I=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr6514306ybj.504.1633732012624;
 Fri, 08 Oct 2021 15:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-2-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-2-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:26:41 -0700
Message-ID: <CAEf4BzZVFLt-4A3-dtPUNj1Pik+0JgiKPcMUJc+ZQ4+7udG-6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 01/14] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds "-j" mode to test_progs, executing tests in multiple
> process.  "-j" mode is optional, and works with all existing test
> selection mechanism, as well as "-v", "-l" etc.
>
> In "-j" mode, main process use UDS/DGRAM to communicate to each forked
> worker, commanding it to run tests and collect logs. After all tests are
> finished, a summary is printed. main process use multiple competing
> threads to dispatch work to worker, trying to keep them all busy.
>
> The test status will be printed as soon as it is finished, if there are
> error logs, it will be printed after the final summary line.
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
>  tools/testing/selftests/bpf/test_progs.c | 598 +++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h |  36 +-
>  2 files changed, 600 insertions(+), 34 deletions(-)
>

Looks good overall, error summary is a great time saver, as well as
parallelisation itself, of course, once we hammer out all the initial
pains. But instead of trying to make it perfect, let's iterate and
improve as we give it more every day testing.

There were a few stylistic problems which I fixed up, but see below
also for some more error handling follow ups.

[...]

> @@ -794,11 +819,456 @@ void crash_handler(int signum)
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

static, { on another line

> +       for (int i = 0; i < env.workers; i++)

C89 doesn't allow declaring variables inside for(). Please don't
forget to run checkpatch.pl before submission. I've fixed in few more
places below.

> +               if (env.worker_socks[i] > 0)
> +                       close(env.worker_socks[i]);
> +}
> +
> +static int current_test_idx;
> +static pthread_mutex_t current_test_lock;
> +static pthread_mutex_t stdout_output_lock;
> +

[...]

> +       dump_test_log(test, test->error_cnt);
> +
> +       reset_affinity();
> +       restore_netns();
> +       if (test->need_cgroup_cleanup)
> +               cleanup_cgroup_environment();
> +}
> +
> +struct dispatch_data {
> +       int worker_id;
> +       int sock_fd;
> +};
> +
> +void *dispatch_thread(void *ctx)

static, function has to be global for a reason, fixed up

> +{
> +       struct dispatch_data *data = ctx;
> +       int sock_fd;
> +       FILE *log_fd = NULL;
> +
> +       sock_fd = data->sock_fd;
> +

[...]

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

check errors instead of SIGSEGV?

We should also free memory. I'd like test_progs to run under
LeakSanitizer in near future, if we don't free all the memory property
and clean up everything, we'll be getting lots of false positive from
LeakSanitizer at the process exit. So we need to be diligent about
stuff like this. Please follow up with fixes.

> +               if (env.debug)
> +                       fprintf(stdout, "Launching %d workers.\n", env.workers);
> +               for (int i = 0; i < env.workers; i++) {
> +                       int sv[2];
> +                       pid_t pid;
> +

[...]

>                 fprintf(env.stdout, "#%d %s:%s\n",
>                         test->test_num, test->test_name,
>                         test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
>
> +               result = &test_results[i];
> +               result->error_cnt = test->error_cnt;
> +               if (env.log_buf) {
> +                       result->log_buf = strdup(env.log_buf);
> +                       result->log_cnt = env.log_cnt;
> +
> +                       free(env.log_buf);
> +                       env.log_buf = NULL;

unclear why this dance: strdup and free the original memory, would be
simpler to just use env.log_buf directly for result->log_buf and set
env.log_buf to NULL after?

> +                       env.log_cnt = 0;
> +               }
> +
>                 if (test->error_cnt)
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
> +               env.sub_succ_cnt += test->sub_succ_cnt;
>         }

[...]
