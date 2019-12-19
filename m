Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1C125B54
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 07:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfLSGLM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 01:11:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38070 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfLSGLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 01:11:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so1795812qvs.5
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 22:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Dygq6LvynjqAF9eAg4KaBVu7HLkGvpmSlWiIQGu+BU=;
        b=WKXh2CJmgmIheOQd1xjPt5CfTce+ZSzdKrPCK3psUwbiiOlge4156XuM1CZZo26hlE
         kJ4t6SEyoh+jelnxZ0B16K+ejzGFKgNEJki1JTTBhTJOFtgfoPO1/auXOC1IOq3RJGzF
         OUXys44/WAyb42m6A93itWLrjpBkz0Wus/q3Ko5oTX4pSorE66XYFi5Wk/xHItWUkVOI
         35lplRHg9Efc1/LxOxEkGV6DWnw2m447OCjv9CMzwc7rtrjqYUELbqfqrb0WdGiTHXD0
         7Z9YK5evNYHvz5dU7h9Ul7vHlTODpmkWliRlMogbyjXW5S1QyAuYk8EC7yn3xg914btX
         94nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Dygq6LvynjqAF9eAg4KaBVu7HLkGvpmSlWiIQGu+BU=;
        b=q88DPN2q1BrSTtKZvTMej4d8cCiVScNkmGj1zs6pXMs7OywXiP2KIAzr/AXeq13ayd
         ZDigF4/SdYgAdynfRBXxQlxg072fiZTT0XnP6Wdy1MkjrpNk2e+anwq7bE/025yApizL
         mDEgAd/a/iVeLutI9ULaiCJwNrUbWK7qH0JgZju5X8UpwJpm/el8fpzgIcGI2K4nlX3M
         ipplTby/8HAopwbNasgFUsFQQ2ZLni69XfCuChmXSE1rML0tQtsVkrYNU3mH7dqI3eyQ
         M0p66vPDa3chRhp3/cHBvdPQuAgVz8DMdtpyUBHDk8T4KTxXSWdDS1tA/O3gsOeIngzc
         Z6DQ==
X-Gm-Message-State: APjAAAW6Ogr3i3xZeKpf3V6HdaoO69mcefaewrLN+fxEXgzS3VqZvdVT
        xsglUPxnlt3mHCx0u28YGscqVhDdvaiYxBb5vCCoZEMf
X-Google-Smtp-Source: APXvYqxSVwmEot6ljVjEGe97I+TnKD1q5u7duD4CpdmJLWVOjKdfJ6F8rmE5MitYPPd9ciJg6DtukhKHxfSBa5Zr9cU=
X-Received: by 2002:a05:6214:38c:: with SMTP id l12mr6139695qvy.224.1576735871319;
 Wed, 18 Dec 2019 22:11:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576720240.git.rdna@fb.com> <a13336d12dff699d2b437ffa024adc1d95c97fcd.1576720240.git.rdna@fb.com>
In-Reply-To: <a13336d12dff699d2b437ffa024adc1d95c97fcd.1576720240.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 Dec 2019 22:11:00 -0800
Message-ID: <CAEf4Bzb2_UqGJxxXvqqpdymzrE06dhj4-XWg5ndsgDndNw787w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/6] selftests/bpf: Convert test_cgroup_attach
 to prog_tests
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 6:14 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Convert test_cgroup_attach to prog_tests.
>
> This change does a lot of things but in many cases it's pretty expensive
> to separate them, so they go in one commit. Nevertheless the logic is
> ketp as is and changes made are just moving things around, simplifying
> them (w/o changing the meaning of the tests) and making prog_tests
> compatible:
>
> * split the 3 tests in the file into 3 separate files in prog_tests/;
>
> * rename the test functions to test_<file_base_name>;
>
> * remove unused includes, constants, variables and functions from every
>   test;
>
> * replace `if`-s with or `if (CHECK())` where additional context should
>   be logged and with `if (CHECK_FAIL())` where line number is enough;
>
> * switch from `log_err()` to logging via `CHECK()`;
>
> * replace `assert`-s with `CHECK_FAIL()` to avoid crashing the whole
>   test_progs if one assertion fails;
>
> * replace cgroup_helpers with test__join_cgroup() in
>   cgroup_attach_override only, other tests need more fine-grained
>   control for cgroup creation/deletion so cgroup_helpers are still used
>   there;
>
> * simplify cgroup_attach_autodetach by switching to easiest possible
>   program since this test doesn't really need such a complicated program
>   as cgroup_attach_multi does;
>
> * remove test_cgroup_attach.c itself.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---
>  tools/testing/selftests/bpf/.gitignore        |   1 -
>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  .../bpf/prog_tests/cgroup_attach_autodetach.c | 111 ++++
>  .../bpf/prog_tests/cgroup_attach_multi.c      | 238 ++++++++
>  .../bpf/prog_tests/cgroup_attach_override.c   | 148 +++++
>  .../selftests/bpf/test_cgroup_attach.c        | 571 ------------------
>  6 files changed, 498 insertions(+), 574 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
>  delete mode 100644 tools/testing/selftests/bpf/test_cgroup_attach.c
>

[...]

> +
> +       if (CHECK_FAIL(setup_cgroup_environment()))
> +               goto err;
> +
> +       cg1 = create_and_get_cgroup("/cg1");
> +       if (CHECK_FAIL(cg1 < 0))
> +               goto err;
> +       cg2 = create_and_get_cgroup("/cg1/cg2");
> +       if (CHECK_FAIL(cg2 < 0))
> +               goto err;
> +       cg3 = create_and_get_cgroup("/cg1/cg2/cg3");
> +       if (CHECK_FAIL(cg3 < 0))
> +               goto err;
> +       cg4 = create_and_get_cgroup("/cg1/cg2/cg3/cg4");
> +       if (CHECK_FAIL(cg4 < 0))
> +               goto err;
> +       cg5 = create_and_get_cgroup("/cg1/cg2/cg3/cg4/cg5");
> +       if (CHECK_FAIL(cg5 < 0))
> +               goto err;
> +
> +       if (CHECK_FAIL(join_cgroup("/cg1/cg2/cg3/cg4/cg5")))
> +               goto err;
> +
> +       if (CHECK(bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
> +                                 BPF_F_ALLOW_MULTI),
> +                 "prog0_attach_to_cg1_multi", "errno=%d\n", errno))
> +               goto err;
> +
> +       if (CHECK(!bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
> +                                  BPF_F_ALLOW_MULTI),
> +                 "fail_same_prog_attach_to_cg1", "unexpected success\n"))
> +               goto err;
> +
> +       if (CHECK(bpf_prog_attach(allow_prog[1], cg1, BPF_CGROUP_INET_EGRESS,
> +                                 BPF_F_ALLOW_MULTI),
> +                 "prog1_attach_to_cg1_multi", "errno=%d\n", errno))
> +               goto err;
> +
> +       if (CHECK(bpf_prog_attach(allow_prog[2], cg2, BPF_CGROUP_INET_EGRESS,
> +                                 BPF_F_ALLOW_OVERRIDE),
> +                 "prog2_attach_to_cg2_override", "errno=%d\n", errno))
> +               goto err;
> +
> +       if (CHECK(bpf_prog_attach(allow_prog[3], cg3, BPF_CGROUP_INET_EGRESS,
> +                                 BPF_F_ALLOW_MULTI),
> +                 "prog3_attach_to_cg3_multi", "errno=%d\n", errno))
> +               goto err;
> +
> +       if (CHECK(bpf_prog_attach(allow_prog[4], cg4, BPF_CGROUP_INET_EGRESS,
> +                           BPF_F_ALLOW_OVERRIDE),
> +                 "prog4_attach_to_cg4_override", "errno=%d\n", errno))
> +               goto err;
> +
> +       if (CHECK(bpf_prog_attach(allow_prog[5], cg5, BPF_CGROUP_INET_EGRESS, 0),
> +                 "prog5_attach_to_cg5_none", "errno=%d\n", errno))
> +               goto err;

nit: this looks like a good candidate for a loop...

> +
> +       CHECK_FAIL(system(PING_CMD));
> +       CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> +       CHECK_FAIL(value != 1 + 2 + 8 + 32);
> +

[...]

> -int main(void)
> -{
> -       int (*tests[])(void) = {
> -               test_foo_bar,
> -               test_multiprog,
> -               test_autodetach,
> -       };
> -       int errors = 0;
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(tests); i++)
> -               if (tests[i]())
> -                       errors++;

Depending on what you think is better structure (I couldn't follow
through entire test logic...), you could have done this as a single
test with 3 subtests. Search for test__start_subtest(). If that saves
you some duplication, I think it's worth converting (which will be
1-to-1 with original structure).

But either way thanks a lot for doing the convertion, brings as
another step closer to more uniform and consolidated testing infra.

> -
> -       if (errors)
> -               printf("test_cgroup_attach:FAIL\n");
> -       else
> -               printf("test_cgroup_attach:PASS\n");
> -
> -       return errors ? EXIT_FAILURE : EXIT_SUCCESS;
> -}
> --
> 2.17.1
>
