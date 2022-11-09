Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7166220A4
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKIANu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIANt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:13:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DD13D5E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:13:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s12so15330735edd.5
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWO+yv7uzyJr/m/WU1DN2E+s/KLr9p6QO7RU4jHMQhI=;
        b=ctwKJNwom893v1x89cTxQX3vPzikLbAW+IPVvxy3ZJlvJ6MGnyRx6YyGV8Wde573Tz
         dDL/dEEHJNLs3RwSujeEDYkYwF7mW6HpNUXMhEWu4zxRkeCddv0Dsl1CjI8PHJa7L6fj
         2k5KMHaGMH6HhQMBE192a9a0hGmT3zOi6mgsEhzSqyOSffLFuWN+RIRPOB0nlkql/bTs
         /ipmyuXBkj1TyCPkd+nadjtWWpv2kxHFH8jL49Vk03wzeAQ3MAivYCK7NIjT1hJAQDcD
         EZ1AWwWq3pNwbzbqoV12JXOpht9BqEqoOI16iDQuSyOk0ZE/dArt1bAHB46dMN7AkV0J
         jUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWO+yv7uzyJr/m/WU1DN2E+s/KLr9p6QO7RU4jHMQhI=;
        b=Qw5TBxSOX9jiUkWn6Fqcii8MnxQS1eMUvZ9eOICmiyoyj71HGrZ7gs+mfEyBCL3pXa
         7W7e68wYLzjC5tX5RsoOGHZmU4L64vWBPApfAGg+AD8MVwFI7kyIMn5W6iR5P9YdUw+G
         CMS6w6DQa0ehbspZNq2H9C8wYv6WCgq/eMJ9BWbLyeOxOxWLFVlEMO7noshHTYWcC5SM
         P3gPg60sGLwG6RXWmaTLvaMMuWBOzE6U+q6Nr+0MifjkMbw1T/pXx48BT4RVwD6NUQTd
         k4esN/+P59QfzC2Zd4rMPAeniajsho6wO5YjVz0KGsAZ50zoWF3+Fj2U/sznqW7N4E+h
         hp5w==
X-Gm-Message-State: ACrzQf1fZZp8TgaCnlERjb8D5enw6i/986qnW5z+iRJNKeyduB3+SLQL
        D3GfU4KauztLuLVS7PcqJNNKUF4JFXBIVZjedXc=
X-Google-Smtp-Source: AMsMyM7x1icihD+3reMEFwBOgAkS/Y6K5mTm8f8QNPDLcbsSoCCxiReOzFytX7Nit6V0xMJTlC3lCoP8yn2+5L4aPQM=
X-Received: by 2002:a50:9ea9:0:b0:461:a7e0:735c with SMTP id
 a38-20020a509ea9000000b00461a7e0735cmr1072653edf.14.1667952826217; Tue, 08
 Nov 2022 16:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-23-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-23-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 16:13:34 -0800
Message-ID: <CAEf4BzbpLYCxXe+k4Hq_Dy0GbqKL-70t_ad4-pdqBzdojLp2uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 22/25] selftests/bpf: Update spinlock selftest
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 3:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Make updates in preparation for adding more test cases to this selftest:
> - Convert from CHECK_ to ASSERT macros.
> - Use BPF skeleton
> - Fix typo sping -> spin
> - Rename spinlock.c -> spin_lock.c
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/spin_lock.c      | 46 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/spinlock.c       | 45 ------------------
>  .../selftests/bpf/progs/test_spin_lock.c      |  4 +-
>  3 files changed, 48 insertions(+), 47 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
>  delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
>

[...]

> +void test_spinlock(void)
> +{
> +       struct test_spin_lock *skel;
> +       pthread_t thread_id[4];
> +       int prog_fd, i;
> +       void *ret;
> +
> +       skel = test_spin_lock__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_spin_lock__open_and_load"))
> +               return;
> +       prog_fd = bpf_program__fd(skel->progs.bpf_spin_lock_test);
> +       for (i = 0; i < 4; i++)
> +               if (!ASSERT_OK(pthread_create(&thread_id[i], NULL,
> +                                             &spin_lock_thread, &prog_fd), "pthread_create"))

I mean... does that pthread_create() call have to happen inside ASSERT_OK?

err = pthread_create(...)
if (!ASSERT_OK(err, "pthread_create"))
    goto end;

> +                       goto end;
> +
> +       for (i = 0; i < 4; i++) {
> +               if (!ASSERT_OK(pthread_join(thread_id[i], &ret), "pthread_join"))
> +                       goto end;
> +               if (!ASSERT_EQ(ret, &prog_fd, "ret == prog_fd"))
> +                       goto end;
> +       }
> +end:
> +       test_spin_lock__destroy(skel);
> +}

[...]
