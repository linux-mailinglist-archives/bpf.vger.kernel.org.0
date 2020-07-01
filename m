Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82BC211495
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGAUvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgGAUve (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 16:51:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702DC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 13:51:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so23607713qkg.5
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1ioNmDaMh6MGwC3yLPD2ogSEfWXGly5kwatxUJEInk=;
        b=HdV0tLmCdp1K5ACH/D84fG9+2YyIm3xbtr84xOAcveg077EoLlFs8IYE56/91mRjsG
         qM4qs2oh0EcrYj6lsT99Xghu2JBDumS9D/ATwOmJlMn2E4OySfu6oI4mP1X7SKJJ8hOr
         Hwt5DV46Fe/nL7nCt3PywbQhk/sGJJ+aLab0/22C+jy3whUvVV1MvcCgZb8buebJlp7W
         xrq1nEZz5AUhOjv1Nesps+5nd557l7qfnnwh6qNs1qIIsD+Qw2z4gSBw8RRfo9ruwDq9
         wDiKWJNsZyAMfRYdtbAlwol7H18FV1eNhe3B1BlfOXkeQ5V/Ii+HyV2uUY2VAFFiouAG
         S9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1ioNmDaMh6MGwC3yLPD2ogSEfWXGly5kwatxUJEInk=;
        b=Jcc4cWBJjRqBavJhk+yNhyQr9WPr8I9F5b+BLmsZanWJgBGMMkCZSuc6NLCotwPpho
         dPGiMB1oVSrDSgTuawKDVehh0EuD5aI+LOGEWnF3y19MgbfQkjMAFEUrESHRoWyve8ZN
         tpVaLfspR4+wTZuW0YK7oOmAhmq+l0b2NO/xVy4lyvwbzq3eA8QlWyLMhDRHO/ILjX6C
         gQ6SOEalTknt4ZanblZJK8l607m21+DAQDr++OdzjvGdshpO4HIwWgnrSmz5i/Z0PwXw
         niLRcSeVlcKiIfwGilIra2RmKXg1om8boY0UOKEcfGBCD5g4huYloXQKdMgBWvrXssvy
         K/BQ==
X-Gm-Message-State: AOAM531rsvKpSK3ujG6I6FH6SS3pwpFGrN9qELlSNNoO0z7Md8Sn7X9r
        V16rTWhPaqszlx1sLRmWzfCNrBLOe09R/af7ndm+Zm5ILA0=
X-Google-Smtp-Source: ABdhPJyCmr5otb4u1SAxz9OYYIOH9b6JZxhPQ8f6eVNXM449y8fPrbmIQB/UpOEppZPg3QU935lInmTjo3naPcMdtjw=
X-Received: by 2002:a05:620a:1666:: with SMTP id d6mr27459283qko.449.1593636693350;
 Wed, 01 Jul 2020 13:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <159363468114.929474.3089726346933732131.stgit@firesoul> <159363474417.929474.570677654666099808.stgit@firesoul>
In-Reply-To: <159363474417.929474.570677654666099808.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Jul 2020 13:51:22 -0700
Message-ID: <CAEf4BzaXA=jnuwhXdQapJba+7JrtOtTOrC7w-AEvk+-kzLKQzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 2/3] selftests/bpf: test_progs option for
 listing test names
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 1:19 PM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
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
> This features can also be used for looking up a test number and returning
> a testname. If the selection was empty then a shell EXIT_FAILURE is
> returned.  This is useful for scripting. e.g. like this:
>
>  n=1;
>  while [ $(./test_progs --list -n $n) ] ; do \
>    ./test_progs -n $n ; n=$(( n+1 )); \
>  done
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c |   18 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h |    1 +
>  2 files changed, 19 insertions(+)
>

[...]

> +       if (env.list_test_names) {
> +               if (env.succ_cnt == 0)
> +                       env.fail_cnt = 1;
> +               goto out;
> +       }
> +

How about making it a failure if no tests were selected in general,
regardless of --count, --list or normal case? It seems sensible that
if you specified wrong selection, that's not what you wanted?

>         fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>                 env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
>
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
