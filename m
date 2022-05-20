Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F352652F61E
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 01:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354062AbiETXXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 19:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354061AbiETXXk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:23:40 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C8A19C387
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:23:39 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id b7so9776974vsq.1
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9tYOnzzgi5Y6JwXwu7V65GX8kFcJVlQ3eMSkvDuBSk=;
        b=gXQn/Zx7+h0IiWuLnhgOoX5t4dmCzB1mdtQR2h6pGZWh0ikBlVGZqqjiOzW9QwCkbd
         qjFyYwMYpzDy6i3XiYLztc5DZPqMGcxRuwyXcAr0WKHirWNHecbGWr6GxureKZrKXIqB
         MN8oooiOJZe0yiKkJGIQT5nwhsRmF2rmOP1HHSm9LhyLatw1PteYoIBL7URFsBt+r4qc
         4lreeni2VTHISGx3gcpL248Vq/BYH6bMWl0+0+K7xP4XC8AlPdwLsC+EZ8YlwFSAGwWF
         kIx7b2DH4W8TkHzIGQpgTdPbk4IUQcauWAgdsjXNtruYQpKXZXxo/HTTmRL8K+1PzclK
         0dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9tYOnzzgi5Y6JwXwu7V65GX8kFcJVlQ3eMSkvDuBSk=;
        b=qPyhffdjphPvSBdHGT0S7I+tas59T6lWJhtLR3N/akrsy9yZ+iNr7eWax3pRf1AZ6/
         fGaS9cMfvmW/ab2mTQxWUuvEn9HRZgtwBF6ffRCI4m2UGhZUKHJSm1QVpM+LnmpcE4Wg
         IAAuvZJtD/hxzlSQyLw7ruwSFbxaw0Wsv3LJkwmaaV6WeJVhaVv5SMsNO8/Ej+KeOEpH
         sq49OBzh6dhRlfIgQ9ErjoDF5gEIelqTNULEGFsobBPzLPv7awnrqo/C6mQPTyBK3E5O
         Nu57pSCiQKTm+88DUth6kxdyqqxAq0lPiGq9k6fERem9M23fBsG3QJzM4mR+aCMvahzr
         IQ2g==
X-Gm-Message-State: AOAM531RMpwSpaL+oqh4CiqQlEZPqDf+8W+Fim6GxuD/twa7dl+JLiFu
        FSpPlnkxIQncJTYaWxfMSQf54KAFtjf01bEWhyY=
X-Google-Smtp-Source: ABdhPJzSACddVDQGzoTM+9bVXXkOqiIYIZi5ZIv/x4DFwYC32nWyjoTNnXfovLNLBX0o8qCH5vKBNSwH+KF8F9lmeyQ=
X-Received: by 2002:a05:6102:370a:b0:333:c0e7:77e8 with SMTP id
 s10-20020a056102370a00b00333c0e777e8mr5555637vst.54.1653089018093; Fri, 20
 May 2022 16:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220520070144.10312-1-mykolal@fb.com>
In-Reply-To: <20220520070144.10312-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 May 2022 16:23:27 -0700
Message-ID: <CAEf4BzYzhKepp2PR4RWgJSoidjxmx1d08G7m=RF=waDWkmT1Mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix subtest number formatting in test_progs
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 20, 2022 at 12:02 AM Mykola Lysenko <mykolal@fb.com> wrote:
>
> Remove weird spaces around / while preserving proper
> indentation
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index ecf69fce036e..262b7577b0ef 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -230,9 +230,14 @@ static void print_test_log(char *log_buf, size_t log_cnt)
>                 fprintf(env.stdout, "\n");
>  }
>
> +#define TEST_NUM_WIDTH 7
> +#define STRINGIFY(value) #value
> +#define QUOTE(macro) STRINGIFY(macro)
> +#define TEST_NUM_WIDTH_STR QUOTE(TEST_NUM_WIDTH)
> +
>  static void print_test_name(int test_num, const char *test_name, char *result)
>  {
> -       fprintf(env.stdout, "#%-9d %s", test_num, test_name);
> +       fprintf(env.stdout, "#%-" TEST_NUM_WIDTH_STR "d %s", test_num, test_name);

this is equivalent to

fprintf(env.stdout, "#%-*d %s", TEST_NUM_WIDTH, test_num, test_name);

but doesn't require macro stringify sequence, so I dropped STRINGIFY,
QUOTE and TEST_NU_WIDTH_STR and replaced it with * argument here and
below

>
>         if (result)
>                 fprintf(env.stdout, ":%s", result);
> @@ -244,8 +249,12 @@ static void print_subtest_name(int test_num, int subtest_num,
>                                const char *test_name, char *subtest_name,
>                                char *result)
>  {
> -       fprintf(env.stdout, "#%-3d/%-5d %s/%s",
> -               test_num, subtest_num,
> +       char test_num_str[TEST_NUM_WIDTH + 1];
> +
> +       snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest_num);
> +
> +       fprintf(env.stdout, "#%-" TEST_NUM_WIDTH_STR "s %s/%s",
> +               test_num_str,
>                 test_name, subtest_name);
>
>         if (result)
> --
> 2.30.2
>
