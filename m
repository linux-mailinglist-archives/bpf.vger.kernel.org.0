Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD020F8C4
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbgF3PqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389432AbgF3PqO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 11:46:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635DC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:46:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so18997416qkb.8
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfTErsTTuXZhWL1YMoqeI/+ksAueZZ5oz4W9+Fc0gJY=;
        b=nR5++/tmRspeDSGf2Z34Hd4wf+8niHeakWHYHH1XVQqnfT0mvn0m/pLV5kBA2FxCL2
         /t7fUa63rYMf7M5WyqO/QR+Ys/BCOZO+x7gUVIVgL0qvDHnSs+5Ub/Qozn2hekiD4wOF
         jdLPZXgCXbp6YhIgq4/dIzzB5sXd5wA0Fyk3MxnDVpqn6bCUb/9kXJh/7nxLqkCX7tx9
         hPCWh3bs+q6LgfW28LCPcLw/jd354JeTQS1dFT2ldWAKNCT5HG7RigFfSPYQTyv0+7kI
         U5ArLWNbeAkL5NF/FNf6c5RCsDl2u6POhjEou1rsVdt0N4eIM4KrFlygJxAi5dv0zIfV
         NE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfTErsTTuXZhWL1YMoqeI/+ksAueZZ5oz4W9+Fc0gJY=;
        b=jSCPa8myuTXtkafrWizy+Rkxkb++maCm5UnNZ5IZsfmsreGnLl6gWxRZd2cxbGtr8I
         Vo6Yol5oFnwfkNsO3LpZCUk64LrwHKYRWNGRKoluQpA4DvOYi2fEnf3BqobEucLSt7U+
         jUq/AywBzA7+tjPYCy9k77lvAQpDWXHsNkoksKXXrTLTbiZ2UM2DQRRJaN8+o+2IDcdC
         VIEW7owm+aeBsfWhHltgPNRM+ib5fDr6yl7QjaaP+jQ+g7X4KwazpUnhW+A489NBdrxg
         E0RVLAKzOrLGbvycwKDNsmOwZylNpunmP5HHNJShkenBu4bVqDXmC73CAosPHDfrKY5e
         fx5Q==
X-Gm-Message-State: AOAM531wUxpMpC9A359Tcu2njwBQ8PkrPiM/mPRNhIA1bBKGKP+h0YB3
        veBldMGrzjcWG+92OYeRabbPbLeqSi+GHxUFXAE=
X-Google-Smtp-Source: ABdhPJxyePb/nLtWmHUMSwHft9W7hVz2COkLsC80gOJsWD0LI3QDWEptefB1fDoaeEndoRwj8KaEFX8rL1XK1CGAG4I=
X-Received: by 2002:a05:620a:2409:: with SMTP id d9mr21312486qkn.36.1593531973061;
 Tue, 30 Jun 2020 08:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <159353162763.912056.3435319848074491018.stgit@firesoul>
In-Reply-To: <159353162763.912056.3435319848074491018.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Jun 2020 08:46:01 -0700
Message-ID: <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for listing
 test names
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 8:40 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> The program test_progs have some very useful ability to specify a list of
> test name substrings for selecting which tests to run.
>
> This patch add the ability to list the selected test names without running
> them. This is practical for seeing which tests gets selected with given
> select arguments (which can also contain a exclude list via --name-blacklist).
>
> This output can also be used by shell-scripts in a for-loop:
>
>  for N in $(./test_progs --list -t xdp); do \
>    ./test_progs -t $N 2>&1 > result_test_${N}.log & \
>  done ; wait
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c |   20 ++++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h |    1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 1aa5360c427f..36abc3d4a8e2 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -367,6 +367,7 @@ enum ARG_KEYS {
>         ARG_VERIFIER_STATS = 's',
>         ARG_VERBOSE = 'v',
>         ARG_GET_TEST_CNT = 'c',
> +       ARG_LIST_TEST_NAMES = 'l',
>  };
>
>  static const struct argp_option opts[] = {
> @@ -382,6 +383,8 @@ static const struct argp_option opts[] = {
>           "Verbose output (use -vv or -vvv for progressively verbose output)" },
>         { "count", ARG_GET_TEST_CNT, NULL, 0,
>           "Get number of top-level tests " },
> +       { "list", ARG_LIST_TEST_NAMES, NULL, 0,
> +         "List test names that would run (without running them) " },
>         {},
>  };
>
> @@ -517,6 +520,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>         case ARG_GET_TEST_CNT:
>                 env->get_test_cnt = true;
>                 break;
> +       case ARG_LIST_TEST_NAMES:
> +               env->list_test_names = true;
> +               break;
>         case ARGP_KEY_ARG:
>                 argp_usage(state);
>                 break;
> @@ -665,6 +671,12 @@ int main(int argc, char **argv)
>                                 test->test_num, test->test_name))
>                         continue;
>
> +               if (env.list_test_names) {
> +                       fprintf(env.stdout, "%s\n", test->test_name);
> +                       env.succ_cnt++;
> +                       continue;
> +               }
> +
>                 test->run_test();
>                 /* ensure last sub-test is finalized properly */
>                 if (test->subtest_name)
> @@ -688,9 +700,17 @@ int main(int argc, char **argv)
>                         cleanup_cgroup_environment();
>         }
>         stdio_restore();
> +
> +       if (env.list_test_names) {
> +               if (env.succ_cnt == 0)
> +                       env.fail_cnt = 1;
> +               goto out;
> +       }
> +

Why failure if no test matched? Is that to catch bugs in whitelisting?

>         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
>
> +out:
>         free_str_set(&env.test_selector.blacklist);
>         free_str_set(&env.test_selector.whitelist);
>         free(env.test_selector.num_set);
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index 0030584619c3..ec31f382e7fd 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -67,6 +67,7 @@ struct test_env {
>
>         bool jit_enabled;
>         bool get_test_cnt;
> +       bool list_test_names;
>
>         struct prog_test_def *test;
>         FILE *stdout;
>
>
