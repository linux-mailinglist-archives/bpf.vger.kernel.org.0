Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBE43AAF9
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 06:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhJZEL7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 00:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJZELx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 00:11:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A63C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:09:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v7so31623439ybq.0
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUcWKpE55nuBB7nVh+DOAxCTFmU3b88wQBUod25DOfA=;
        b=bWDxjKIXD4iK0xsIoXmIEJY57dLU3yvj43FeQBIZM0Yj2hgf5U+TRvy4vwfcvgy3WJ
         qvO/zDfNVd/VkZ57W+9BuDYcLcOcfRgOA/XDF7ayTWtlAe6Bow/gytkz5V7m4Ih7NXgI
         BypIKdm1Q/oZ82H1GhHrI5m0o+W4XnEvw55+26ElxmFky37tW9PYZYwerWwUSizA649x
         GobZfZ1Ctvb1hPs807z9mj0G+rlGdL4cZQyKhBoe8YmrN1AWyjRYSb9ZYFI3/K+MVRkW
         +tYOcATJ0WRg5NQS79qsn9qjaGiWPXyP55TV68WdMxPFpFbUrWxvpBSmYovAygTScLPD
         2GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUcWKpE55nuBB7nVh+DOAxCTFmU3b88wQBUod25DOfA=;
        b=OA1/KaIvGwdxjQOEBMqvFGr6KEwo2VqsIer0yQ14/Mor4tjpXrtppgDb1WhcxOZyJk
         kTFoNBMLRZNdD8O+897+6gtoZfh5lwFQW/z4+mSXnb8A4xeXrjJD3KtB9XeU+vBz77pn
         g/3KQfVJwZFGZoP+Z7wBWKs1QF0QqaE/xO9OfFraEkpOntGJdR6gL5hGYh57gLZ6YEXN
         pIVAgPvkUtp/Kb9Ugy9f/Wo4InbUBAKVdXkCvJ0W+wnppoUt8/K283WsThGY/38IuQh+
         0mLrAu7/SZI3RuavYB3c1WN6BymZVEl9rkXUSFgxIQiAtpYiFh5KL3trnrTryZPKw/bk
         kHzw==
X-Gm-Message-State: AOAM532hJW6GAn05LW+s2MGIxJxXA1Yuz+x0Kmf/Mg+sQ4BRCJXOlViC
        9rHW46z1dkhAYhcdm8QXy54kY0LHYc0N1NzFJwQ=
X-Google-Smtp-Source: ABdhPJwkHc4bDajke9NL1N/lE3MAaymhMJHYygc/Dg7O0etnWu5KCJyxltEDZAWdzz1qKr5vEaQpgME226+NLdp/5mA=
X-Received: by 2002:a25:8749:: with SMTP id e9mr20936248ybn.2.1635221369580;
 Mon, 25 Oct 2021 21:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211025223345.2136168-1-fallentree@fb.com> <20211025223345.2136168-3-fallentree@fb.com>
In-Reply-To: <20211025223345.2136168-3-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 21:09:18 -0700
Message-ID: <CAEf4BzZFtCreYhRy01g1mXe9iU-LdP4Td45ynXF9ztQrKXBqGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: print subtest status line
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 3:33 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch restores behavior that prints one status line for each
> subtest executed. It works in both serial mode and parallel mode,  and
> all verbosity settings.
>
> The logic around IO hijacking could use some more simplification in the
> future.
>

This feels like a big hack, not a proper solution. What if we extend
MSG_TEST_DONE to signal also sub-test completion (along with subtest
logs)? Would that work better and result in cleaner logic?

> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 56 +++++++++++++++++++-----
>  tools/testing/selftests/bpf/test_progs.h |  4 ++
>  2 files changed, 50 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 1f4a48566991..ff4598126f9d 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -100,6 +100,18 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
>         return num < sel->num_set_len && sel->num_set[num];
>  }
>
> +static void dump_subtest_status(bool display) {

please run checkpatch.pl

> +       fflush(env.subtest_status_fd);
> +       if (display) {
> +               if (env.subtest_status_cnt) {
> +                       env.subtest_status_buf[env.subtest_status_cnt] = '\0';
> +                       fputs(env.subtest_status_buf, stdout);
> +               }
> +       }
> +       rewind(env.subtest_status_fd);
> +       fflush(env.subtest_status_fd);
> +}
> +
>  static void dump_test_log(const struct prog_test_def *test, bool failed)
>  {
>         if (stdout == env.stdout)
> @@ -112,12 +124,17 @@ static void dump_test_log(const struct prog_test_def *test, bool failed)
>         fflush(stdout); /* exports env.log_buf & env.log_cnt */
>
>         if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
> -               if (env.log_cnt) {
> -                       env.log_buf[env.log_cnt] = '\0';
> -                       fprintf(env.stdout, "%s", env.log_buf);
> -                       if (env.log_buf[env.log_cnt - 1] != '\n')
> -                               fprintf(env.stdout, "\n");
> -               }
> +               dump_subtest_status(false);
> +       } else {
> +               rewind(stdout);
> +               dump_subtest_status(true);
> +               fflush(stdout);
> +       }
> +       if (env.log_cnt) {
> +               env.log_buf[env.log_cnt] = '\0';
> +               fprintf(env.stdout, "%s", env.log_buf);
> +               if (env.log_buf[env.log_cnt - 1] != '\n')
> +                       fprintf(env.stdout, "\n");
>         }
>  }
>
> @@ -183,7 +200,12 @@ void test__end_subtest(void)
>
>         dump_test_log(test, sub_error_cnt);
>
> +       // Print two copies here, one as part of full logs, another one will
> +       // only be used if there is no need to show full logs.

C++ style comments

>         fprintf(stdout, "#%d/%d %s/%s:%s\n",
> +               test->test_num, test->subtest_num, test->test_name, test->subtest_name,
> +               sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
> +       fprintf(env.subtest_status_fd, "#%d/%d %s/%s:%s\n",
>                test->test_num, test->subtest_num, test->test_name, test->subtest_name,
>                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
>
> @@ -1250,6 +1272,15 @@ static int worker_main(int sock)
>
>                         run_one_test(test_to_run);
>
> +                       // discard logs if we don't need them

C++ style comment

> +                       if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> +                               dump_subtest_status(false);
> +                       } else {
> +                               rewind(stdout);
> +                               dump_subtest_status(true);
> +                               fflush(stdout);
> +                       }
> +
>                         stdio_restore();
>
>                         memset(&msg_done, 0, sizeof(msg_done));
> @@ -1260,10 +1291,9 @@ static int worker_main(int sock)
>                         msg_done.test_done.sub_succ_cnt = test->sub_succ_cnt;
>                         msg_done.test_done.have_log = false;
>
> -                       if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cnt) {
> -                               if (env.log_cnt)
> -                                       msg_done.test_done.have_log = true;
> -                       }
> +                       if (env.log_cnt)
> +                               msg_done.test_done.have_log = true;
> +
>                         if (send_message(sock, &msg_done) < 0) {
>                                 perror("Fail to send message done");
>                                 goto out;
> @@ -1357,6 +1387,12 @@ int main(int argc, char **argv)
>
>         env.stdout = stdout;
>         env.stderr = stderr;
> +       env.subtest_status_fd = open_memstream(

extremely misleading name, it's not an FD at all

> +               &env.subtest_status_buf, &env.subtest_status_cnt);
> +       if (!env.subtest_status_fd) {
> +               perror("Failed to setup env.subtest_status_fd");
> +               exit(EXIT_ERR_SETUP_INFRA);
> +       }
>
>         env.has_testmod = true;
>         if (!env.list_test_names && load_bpf_testmod()) {
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 93c1ff705533..a564215a63b1 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -89,6 +89,10 @@ struct test_env {
>         pid_t *worker_pids; /* array of worker pids */
>         int *worker_socks; /* array of worker socks */
>         int *worker_current_test; /* array of current running test for each worker */
> +
> +       FILE* subtest_status_fd; /* fd for printing status line for subtests */
> +       char *subtest_status_buf; /* buffer for subtests status */
> +       size_t subtest_status_cnt;
>  };
>
>  #define MAX_LOG_TRUNK_SIZE 8192
> --
> 2.30.2
>
