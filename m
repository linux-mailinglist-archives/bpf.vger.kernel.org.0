Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F5453FDC
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 06:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhKQFJs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 00:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhKQFJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 00:09:47 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB213C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 21:06:49 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d10so3772637ybe.3
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 21:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMrHlFslAtu5nsOhP8hWktV8XujxELIzntPVHJCXCVQ=;
        b=EoiGSPfRD4mcenOibTYkFe3riyyjK/RJJSqq2R75EMv4+1fUg+v2GK5GFj0y7qKUYf
         9tu2eDcb151rqgerxHojDO/CnBmLo2JXmEwivhnQxdtcwBnNBbcgSXZyrjELSfve0sAw
         qwfsnPIbs1Zl6Ok1619yFBZXWC5c9VsElT81DyNqARFUR/fGnsepn0isBwSF2ynI4PfB
         xNcdV6yqeELn64J6/dDI6xy1SF8zU753qopr3C0A6aZzVB6W0fNeDbHiojLV4DtpFgxa
         7+NvfvJlKa+afscPIV/CaMjOA3VZXfoEoTW6VWSpNtLGFeRQ/oYUyXGheDj9dyDvEfT8
         u99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMrHlFslAtu5nsOhP8hWktV8XujxELIzntPVHJCXCVQ=;
        b=OhXoHxjDitlRWtdsTKOAH0oGh19vAI3SCKn3/cUzkyD4g9wb00l22UeWKdQ2NmkQXz
         BkLGBDal1VuG/1BPdMIrDUl9yFGkXN7d83itZyXxYut/Lry0Zj4ap4MnMSqgSuN99HKM
         1Cuwv0dqZQel9QX4kydSd16YzHGFK4pBJ3SO8d3ovQNzN5YL/yeMjDSWkJjakatvxFXK
         WoFF0GWTgWdlM0eyBOymLLBIhw8HBJ1QbCZudo0cJfygfbxgl+gWvD18+SODee1lSNZ6
         vn1LvJ7mR+vYaV0O51iSl8cjGoBhXdyg7X75UwfmF5Dv3v07fvT5/vd63eM73mvmrCKc
         P+bw==
X-Gm-Message-State: AOAM531bEN7+O8ILjUlc5cpDgnYBPAf/m47L7Rhq3pH7IzXc5dMLSUE/
        gG1CieSlSV3cPokTGGpNZjdO4XeKvUhyU5Pj1Rw=
X-Google-Smtp-Source: ABdhPJwvdtTxZnv8o48odQN1eeBDwDsqplQgcgl6kxViwtt0BsZEkKHFAxtKXxSCPgOdr1a17u0ZXOJJFUJIa6PGvDA=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr14240090ybt.267.1637125608940;
 Tue, 16 Nov 2021 21:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20211112192535.898352-1-fallentree@fb.com> <20211112192535.898352-5-fallentree@fb.com>
In-Reply-To: <20211112192535.898352-5-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 21:06:38 -0800
Message-ID: <CAEf4Bzb0AiDdpXayjG=o42bfSE-vpGgec=yuTyRUP0=jfDPc9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add timing to tests_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 11:29 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds '--timing' to test_progs. It tracks and print timing
> information for each tests, it also prints top 10 slowest tests in the
> summary.

The timing doesn't work in serial mode, is that intended?

>
> Example output:
>   $./test_progs --timing -j
>   #1 align:OK (16 ms)
>   ...
>   #203 xdp_bonding:OK (2019 ms)
>   #206 xdp_cpumap_attach:OK (3 ms)
>   #207 xdp_devmap_attach:OK (4 ms)
>   #208 xdp_info:OK (4 ms)
>   #209 xdp_link:OK (4 ms)

See below, I wonder if we should just always output duration. Except
outputting it at the end obscures OK or FAIL verdict, so maybe right
after the test number (and make sure that we don't break naming
alignment by using %5d for milliseconds. Something like:

#203 [ 2019ms] xdp_bonding:OK
#206 [    3ms] xdp_cpumap_attach:OK

See also below, this should be also nicely sortable by sort command.

>
>   Top 10 Slowest tests:
>   #48 fexit_stress: 34356 ms
>   #160 test_lsm: 29602 ms
>   #161 test_overhead: 29190 ms
>   #159 test_local_storage: 28959 ms
>   #158 test_ima: 28521 ms
>   #185 verif_scale_pyperf600: 19524 ms
>   #199 vmlinux: 17310 ms
>   #154 tc_redirect: 11491 ms (serial)
>   #147 task_local_storage: 7612 ms
>   #183 verif_scale_pyperf180: 7186 ms
>   Summary: 212/973 PASSED, 3 SKIPPED, 0 FAILED
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 125 +++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h |   2 +
>  2 files changed, 120 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 296928948bb9..d4786e1a540f 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -491,6 +491,7 @@ enum ARG_KEYS {
>         ARG_TEST_NAME_GLOB_DENYLIST = 'd',
>         ARG_NUM_WORKERS = 'j',
>         ARG_DEBUG = -1,
> +       ARG_TIMING = -2,
>  };
>
>  static const struct argp_option opts[] = {
> @@ -516,6 +517,8 @@ static const struct argp_option opts[] = {
>           "Number of workers to run in parallel, default to number of cpus." },
>         { "debug", ARG_DEBUG, NULL, 0,
>           "print extra debug information for test_progs." },
> +       { "timing", ARG_TIMING, NULL, 0,
> +         "track and print timing information for each test." },

nit: all the description (except for debug and timing) start with a
capital letter, let's fix both to keep everything consistent

>         {},
>  };
>
> @@ -696,6 +699,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>         case ARG_DEBUG:
>                 env->debug = true;
>                 break;
> +       case ARG_TIMING:
> +               env->timing = true;
> +               break;
>         case ARGP_KEY_ARG:
>                 argp_usage(state);
>                 break;
> @@ -848,6 +854,7 @@ struct test_result {
>         int error_cnt;
>         int skip_cnt;
>         int sub_succ_cnt;
> +       __u32 duration_ms;
>
>         size_t log_cnt;
>         char *log_buf;
> @@ -905,9 +912,29 @@ static int recv_message(int sock, struct msg *msg)
>         return ret;
>  }
>
> -static void run_one_test(int test_num)
> +static __u32 timespec_diff_ms(struct timespec start, struct timespec end)
> +{
> +       struct timespec temp;
> +
> +       if ((end.tv_nsec - start.tv_nsec) < 0) {
> +               temp.tv_sec = end.tv_sec - start.tv_sec - 1;
> +               temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
> +       } else {
> +               temp.tv_sec = end.tv_sec - start.tv_sec;
> +               temp.tv_nsec = end.tv_nsec - start.tv_nsec;
> +       }
> +       return (temp.tv_sec * 1000) + (temp.tv_nsec / 1000000);
> +}
> +
> +
> +static double run_one_test(int test_num)
>  {
>         struct prog_test_def *test = &prog_test_defs[test_num];
> +       struct timespec start = {}, end = {};

instead of dealing with timespec, why not add a helper function that
will do clock_gettime(CLOCK_MONOTONIC) internally and convert
timespace to single nanosecond timestamp. We can put it into
testing_helpers.c and reuse it for other purposes. Actually, we have
such function in bench.h already (get_time_ns()), let's copy/paste it
into test_progs.h, it's useful (there are a bunch of existing
selftests that could use it instead of explicit clock_gettime() calls.

You won't need timespec_diff_ms() then, it will be just (end - start )
/ 1000000 for millisecond duration.

> +       __u32 duration_ms = 0;
> +
> +       if (env.timing)
> +               clock_gettime(CLOCK_MONOTONIC, &start);

it's cheap to measure this, we can always capture the duration, don't
even need to check env.timing

>
>         env.test = test;
>
> @@ -928,6 +955,13 @@ static void run_one_test(int test_num)
>         restore_netns();
>         if (test->need_cgroup_cleanup)
>                 cleanup_cgroup_environment();
> +
> +       if (env.timing) {
> +               clock_gettime(CLOCK_MONOTONIC, &end);
> +               duration_ms = timespec_diff_ms(start, end);
> +       }
> +
> +       return duration_ms;
>  }
>
>  struct dispatch_data {
> @@ -999,6 +1033,7 @@ static void *dispatch_thread(void *ctx)
>                         result->error_cnt = msg_test_done.test_done.error_cnt;
>                         result->skip_cnt = msg_test_done.test_done.skip_cnt;
>                         result->sub_succ_cnt = msg_test_done.test_done.sub_succ_cnt;
> +                       result->duration_ms = msg_test_done.test_done.duration_ms;
>
>                         /* collect all logs */
>                         if (msg_test_done.test_done.have_log) {
> @@ -1023,6 +1058,8 @@ static void *dispatch_thread(void *ctx)
>                         }
>                         /* output log */
>                         {
> +                               char buf[255] = {};
> +
>                                 pthread_mutex_lock(&stdout_output_lock);
>
>                                 if (result->log_cnt) {
> @@ -1032,9 +1069,15 @@ static void *dispatch_thread(void *ctx)
>                                                 fprintf(stdout, "\n");
>                                 }
>
> -                               fprintf(stdout, "#%d %s:%s\n",
> +                               if (env.timing) {
> +                                       snprintf(buf, sizeof(buf), " (%u ms)", result->duration_ms);
> +                                       buf[sizeof(buf) - 1] = '\0';
> +                               }

you don't really need a separate buf, you can split below fprintf to
move out \n into a separate fprintf, and then have optional extra
fprintf for timing

> +
> +                               fprintf(stdout, "#%d %s:%s%s\n",
>                                         test->test_num, test->test_name,
> -                                       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
> +                                       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"),
> +                                       buf);
>
>                                 pthread_mutex_unlock(&stdout_output_lock);
>                         }
> @@ -1092,6 +1135,57 @@ static void print_all_error_logs(void)
>         }
>  }
>
> +struct item {
> +       int id;
> +       __u32 duration_ms;
> +};
> +
> +static int rcompitem(const void *a, const void *b)
> +{
> +       __u32 val_a = ((struct item *)a)->duration_ms;
> +       __u32 val_b = ((struct item *)b)->duration_ms;
> +
> +       if (val_a > val_b)
> +               return -1;
> +       if (val_a < val_b)
> +               return 1;
> +       return 0;
> +}
> +
> +static void print_slow_tests(void)

I'm a bit on the fence about test_progs needing to do such "timing
summary", tbh. If we just output timing information (and we probably
can do it always, no need for --timing), then with a simple `sort -rn
-k <timing_column>` command. And it will be up to user to determine
how many top N items they want with extra head.

> +{
> +       int i;

[...]

> @@ -1200,6 +1303,9 @@ static int server_main(void)
>
>         print_all_error_logs();
>
> +       if (env.timing)
> +               print_slow_tests();
> +
>         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
>
> @@ -1236,6 +1342,7 @@ static int worker_main(int sock)
>                         int test_to_run;
>                         struct prog_test_def *test;
>                         struct msg msg_done;
> +                       __u32 duration_ms = 0;
>
>                         test_to_run = msg.do_test.test_num;
>                         test = &prog_test_defs[test_to_run];
> @@ -1248,7 +1355,7 @@ static int worker_main(int sock)
>
>                         stdio_hijack();
>
> -                       run_one_test(test_to_run);
> +                       duration_ms = run_one_test(test_to_run);

why not just add duration_ms to prog_test_def, just like error_cnt,
skip_cnt, etc?

>
>                         stdio_restore();
>
> @@ -1258,6 +1365,7 @@ static int worker_main(int sock)
>                         msg_done.test_done.error_cnt = test->error_cnt;
>                         msg_done.test_done.skip_cnt = test->skip_cnt;
>                         msg_done.test_done.sub_succ_cnt = test->sub_succ_cnt;
> +                       msg_done.test_done.duration_ms = duration_ms;
>                         msg_done.test_done.have_log = false;
>
>                         if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> @@ -1486,6 +1594,9 @@ int main(int argc, char **argv)
>
>         print_all_error_logs();
>
> +       if (env.timing)
> +               print_slow_tests();
> +
>         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
>
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 93c1ff705533..16b8c0a9ba5f 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -64,6 +64,7 @@ struct test_env {
>         bool verifier_stats;
>         bool debug;
>         enum verbosity verbosity;
> +       bool timing;
>
>         bool jit_enabled;
>         bool has_testmod;
> @@ -109,6 +110,7 @@ struct msg {
>                         int sub_succ_cnt;
>                         int error_cnt;
>                         int skip_cnt;
> +                       __u32 duration_ms;
>                         bool have_log;
>                 } test_done;
>                 struct {
> --
> 2.30.2
>
