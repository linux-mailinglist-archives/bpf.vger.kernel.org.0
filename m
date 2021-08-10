Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E23E82B9
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhHJSRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 14:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbhHJSPD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 14:15:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79875C03E59A
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 10:47:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z128so37650958ybc.10
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY3DwjiYHW56CAkusykVlEcZuDftmWviWiJOr5ov9nE=;
        b=eTSTyectwG7u+kTITq2gO6JxEw+MMGeL5GHvK006DPJHm3yJHD9Ppx5Wtj39BiCB7Z
         GQe5N+cb7QWqrI/Zo28Zk3qSkuuy1QsG9uz78hd8dH1TtfCyVC6yrzZpNUO9glKKIvFr
         H4ilG/h43KFr/RNTYxSPVrRwNwf3k29zxR9fZKzaUIP34ysyAYPiEAMMS84/Nz4cQoDo
         byXhlO5xdPBmWFcobLr40hXRFO+/f1szEgp+mxQdyC4GTqIkKD7hIPifJvLIqpmONCiK
         CrsfYnaKai0o908Me2ZPEqa8jMauoYYhQ/0uQBDDlL0YhwsCQAd4DwJqtrsPobd8JFdP
         Yigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY3DwjiYHW56CAkusykVlEcZuDftmWviWiJOr5ov9nE=;
        b=uimiPXlLiZHOxXofmePjjCUBhJRIX32z89BQOkSIhx7H2L2mi+ZYmhm4TakTPsRyUb
         EXvarxAR5ozy0r/g7qdrL+Av5BgGPXSH43L1agtF3M32UKutE9EQo9DvW1o/wATTMEgC
         gv+0INGknkKfRG80mxIJxnHfo8TRY/vX17levvK+UpqNKJjZdWja2kcwiwVquT4w8Hwx
         N0jLaxp+t/IdBTwKouBzdWHRl7/NP4U667q5/mPdTcnnVUB9DUt1do6D5hI+KjIMYRJn
         XVUixJWjQnxLEh3zQ4WF+WZ6gsJ+otD540hlQnPMDA0QL4hvA+rpdV02M8C6UrLJXJJK
         EilA==
X-Gm-Message-State: AOAM5319TGEsHKHwomwvswMKiDX4qeNzXVqj552ZJPrmiAkxbpNu05Na
        Yb1NCSbXxKEzUrrVePHxO+oFZ6Dv0CUncQRXJp4=
X-Google-Smtp-Source: ABdhPJwm5PWeHv+3fm1Iv6bdbS+KiuWjc8H2y2RxijGO9F7lV98jjNRkmmmOh2LhYYShBn5dfNTMI/R+tr+bIFrDaac=
X-Received: by 2002:a25:9942:: with SMTP id n2mr40691317ybo.230.1628617640657;
 Tue, 10 Aug 2021 10:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210810001625.1140255-1-fallentree@fb.com> <20210810001625.1140255-4-fallentree@fb.com>
In-Reply-To: <20210810001625.1140255-4-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Aug 2021 10:47:09 -0700
Message-ID: <CAEf4BzbL-8_QT21uSFszebV8f-i0aSz0s6rC5Cjw6jOV+7-qKQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] Correctly display subtest skip status
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        sunyucong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 9, 2021 at 5:17 PM Yucong Sun <fallentree@fb.com> wrote:
>
> In skip_account(), test->skip_cnt is set to 0 at the end, this makes
> next print statement never display SKIP status for the subtest. This
> patch moves the accounting logic after the print statement, fixing the
> issue.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---

Looks good, but seems like we are not printing SKIP for normal tests,
let's do that while we are at fixing SKIP reporting?

>  tools/testing/selftests/bpf/test_progs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index c5bffd2e78ae..82d012671552 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -238,18 +238,18 @@ void test__end_subtest()
>         struct prog_test_def *test = env.test;
>         int sub_error_cnt = test->error_cnt - test->old_error_cnt;
>
> -       if (sub_error_cnt)
> -               env.fail_cnt++;
> -       else if (test->skip_cnt == 0)
> -               env.sub_succ_cnt++;
> -       skip_account();
> -
>         dump_test_log(test, sub_error_cnt);
>
>         fprintf(env.stdout, "#%d/%d %s:%s\n",
>                test->test_num, test->subtest_num, test->subtest_name,
>                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
>
> +       if (sub_error_cnt)
> +               env.fail_cnt++;
> +       else if (test->skip_cnt == 0)
> +               env.sub_succ_cnt++;
> +       skip_account();
> +
>         free(test->subtest_name);
>         test->subtest_name = NULL;
>  }
> --
> 2.30.2
>
