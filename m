Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459CD3E82F3
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 20:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhHJSZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbhHJSZY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 14:25:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FBC0613C1
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 11:25:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l3so5471810ybt.7
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+zwg8kIDxWmg6RRR6e8AHopHhKn8DkjGjhz/1OYe9Y=;
        b=bZjvmZLsOcA1xEu2tOwgdO8Chp76ijZKcBFMx0N9gRyZfBSlo+qu2FpGJvvceTteR6
         BA/8GPZaecV1pAle7i9dACp5cF42od0DvhZypGIjY7JIrrmsKjZrIgldgYEX4v/LceCd
         6YydlvB5NedJeRDafUs2QsQaWWtvxVDRkg9OA78EVRRE3TA7AYzbZLkmIlQ+R4lYd+7+
         ihy8K7EiyY/dffQkLJW51sDTcCyT9rS4SC6ScFY+TfZ6j8hxvAwxBw6IIZnmxHHrC2ut
         IePxpf8yItd/jymJKqVO74qcb73+pZQefSYJmiWK8hHYISHdbgPCcaHP71dxPrDaFr72
         eGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+zwg8kIDxWmg6RRR6e8AHopHhKn8DkjGjhz/1OYe9Y=;
        b=EV+3XW0zS9/Q/mDxfUW4CKIqSP0QExkS14TPxt2m72uAdh2mYKsZ6P/VkYeMiQy12c
         0ltymY4JnXQZMLNgaN9Jh6ghPNQtfqzkyQquajyrGhoV9VqFTwcwrxxwKvwqN2Op4PXj
         gGVUtuZ7MMEYxslTF5bw3sdRad5eEkJzqzwHhtSHQtVz16c0cqaSQjkAzq3tM86juJim
         Iq0FyyHOtepyFun8w4GJJICBiZ+P9hhuGcDmygNNdzQ+yv26XAFbCy+sH/7zZLVrwtX2
         50YmegxqRdVpJRURULRCqL6nuE6rPp+5dMVk0XifnNOfwWpNLg5X/SMQpoyddoFeE/NS
         HTIQ==
X-Gm-Message-State: AOAM5314LyWqstMjVibRyvGkH8gP+IzqK5LXI/elIJqCSUMkBDPDJWzh
        nEzHs7a/0K4Nd0b4haSYRbd0LurBeBdrwySjd2I=
X-Google-Smtp-Source: ABdhPJwoqgOe3BqfEWFNMvBIe3baDtwUWByJ6y2xyVa3nPgtWOffTrBzXEDZA9yL0OgS07oK13FSSOvFMHxKzA9oEEU=
X-Received: by 2002:a5b:648:: with SMTP id o8mr41305592ybq.260.1628619901267;
 Tue, 10 Aug 2021 11:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210810001625.1140255-1-fallentree@fb.com> <20210810001625.1140255-6-fallentree@fb.com>
In-Reply-To: <20210810001625.1140255-6-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 11:24:50 -0700
Message-ID: <CAEf4BzYvSf2wuObnR-ck9VaGqcsy0fuNXJEL_mi+4DVDR1K+fg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/5] Record all failed tests and output after
 the summary line.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 5:17 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch records all failed tests and subtests during the run, output
> them after the summary line, making it easier to identify failed tests
> in the long output.

Well, but then you still have to search back to see what exactly
happened with that test. So it's definitely more useful, but not
completely useful for dealing with CI test failures. E.g., here's the
output I get:

.... lots of lines here ....
#167 xdp_link:OK
#168 xdp_noinline:OK
#169 xdp_perf:OK

Summary: 166/947 PASSED, 3 SKIPPED, 3 FAILED

#4 attach_probe: FAIL
#134 tc_bpf: FAIL
#153 trace_printk: FAIL


Now I need to go and grep trace_printk to see what exactly failed
about that test.

I think the best output would be the one that will repeat the entire
log of each failed test/subtest. This is great for CI, because we can
have a pretty simple post-processing script capturing relevant error
logs and posting them in the email, eventually.

>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 25 +++++++++++++++++++++++-
>  tools/testing/selftests/bpf/test_progs.h |  2 ++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 5cc808992b00..51a70031f07e 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -244,6 +244,11 @@ void test__end_subtest()
>                test->test_num, test->subtest_num, test->subtest_name,
>                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
>
> +       if (sub_error_cnt) {
> +               fprintf(env.summary_errors, "#%d/%d %s: FAIL\n",
> +                       test->test_num, test->subtest_num, test->subtest_name);
> +       }
> +
>         if (sub_error_cnt)
>                 env.fail_cnt++;
>         else if (test->skip_cnt == 0)
> @@ -816,6 +821,10 @@ int main(int argc, char **argv)
>                 .sa_flags = SA_RESETHAND,
>         };
>         int err, i;
> +       /* record errors to print after summary line */
> +       char *summary_errors_buf;
> +       size_t summary_errors_cnt;
> +
>
>         sigaction(SIGSEGV, &sigact, NULL);
>
> @@ -823,6 +832,9 @@ int main(int argc, char **argv)
>         if (err)
>                 return err;
>
> +       env.summary_errors = open_memstream(
> +               &summary_errors_buf, &summary_errors_cnt);
> +
>         err = cd_flavor_subdir(argv[0]);
>         if (err)
>                 return err;
> @@ -891,6 +903,11 @@ int main(int argc, char **argv)
>                         test->test_num, test->test_name,
>                         test->error_cnt ? "FAIL" : "OK");
>
> +               if(test->error_cnt) {
> +                       fprintf(env.summary_errors, "#%d %s: FAIL\n",
> +                               test->test_num, test->test_name);
> +               }
> +
>                 reset_affinity();
>                 restore_netns();
>                 if (test->need_cgroup_cleanup)
> @@ -908,9 +925,14 @@ int main(int argc, char **argv)
>         if (env.list_test_names)
>                 goto out;
>
> -       fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
> +       fprintf(stdout, "\nSummary: %d/%d PASSED, %d SKIPPED, %d FAILED\n\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);

this will emit an extra empty line even if no tests failed; let's just
do if (env.fail_cnt) fprintf(stdout, "\n"); ?

As for the empty line before Summary, is it really necessary?

>
> +       fclose(env.summary_errors);
> +       if(env.fail_cnt) {
> +               fprintf(stdout, "%s", summary_errors_buf);
> +       }

kernel style says that if/for/while statements with a single statement
shouldn't use {} around that statement. And `if` is not a function, so
there should be a space between if and ().

> +
>  out:
>         free_str_set(&env.test_selector.blacklist);
>         free_str_set(&env.test_selector.whitelist);
> @@ -919,6 +941,7 @@ int main(int argc, char **argv)
>         free_str_set(&env.subtest_selector.whitelist);
>         free(env.subtest_selector.num_set);
>         close(env.saved_netns_fd);
> +       free(summary_errors_buf);
>
>         if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
>                 return EXIT_NO_TEST;
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index c8c2bf878f67..63f4e534c6e5 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -82,6 +82,8 @@ struct test_env {
>         int skip_cnt; /* skipped tests */
>
>         int saved_netns_fd;
> +
> +       FILE* summary_errors;
>  };
>
>  extern struct test_env env;
> --
> 2.30.2
>
