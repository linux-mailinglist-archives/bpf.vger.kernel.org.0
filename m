Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583E43CBD0
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbhJ0OUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 10:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbhJ0OUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 10:20:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2BAC061767
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 07:17:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q74so818378ybq.11
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MH0010HujJrwRpYmRYUjwvEM/PVAhEf0zDzL2pj4VJI=;
        b=q6PhrNKt556F0lEnMwPLxZx6XEb9BQrLuuutmNUDkC5PqN9jX0VZLekijFf0qHwax1
         7djZcvqqcR9MCt+2wYJI8lvbN3nyjjnqqn6dArMrSW0WhzWyOkuMKgGX9CSPr6rE5Cpv
         Ji5xSJMGVgOWsMit445lSX6KTgTJzNEm0jOH4qhSqGRUl2i2WkAsImzY7N3ggsLEhoyC
         EQymvpgGhJQ46x4BRJymDGMbJsCpmg8W1nd3znD6wCnfQ+GC2IGZOWFtzV8LyKnVYJqA
         g/ILBHWUiq03GQSgsmctVasNLk3dGym1ab10aXxCxpeTpfcp2wEcOzhVRvf9IUVVD6dU
         hvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MH0010HujJrwRpYmRYUjwvEM/PVAhEf0zDzL2pj4VJI=;
        b=l1W5yHK8mUu492C+7NXSI/1m/HsctqAN3edY1UPmF3oXmB3T+CuDdSysT18Gk4meFQ
         bi72I8Gdru21YGFCIUjqHbMff1UOYqWGFiaAIEEeGePfkuBzIJPQkvp6xVpeOmj7U4zz
         iwPZWIq3Uqu742NWL7Sge7s+vZy5RIGwnHkMtePOclopEw5dtyk7Oe7X4aJeEyruP9mD
         FsMa9xS94aUnrW6SBuZIK0ryWxM11UBd7FK821j+mS1TJHc+6zGsC0XY8rksh6fC491j
         fizAOJaJ4A5IvvOmn2dVYaNHt14HqxgUVeoEGNOQF2tt9fd/olMl9tK0JK4QWQ5NFAgs
         aXOQ==
X-Gm-Message-State: AOAM533L5+vst6pt2ZED4KjdIsuNgk6PZXUOmLJY8Cyi64a5vmt5mKyq
        XY1Pa0LHdi54PB/NLdjP3DI8kCEA8sKrXOEpqFsyEw==
X-Google-Smtp-Source: ABdhPJxVpzmfmKHui3hQKSc/iTsKDkAW3WMny4zvowozRSeH1r/4+ZWmt/eXWz2lOT2RRQlKZSrIOhJ/sfdhpCXCLSY=
X-Received: by 2002:a25:3895:: with SMTP id f143mr29010794yba.268.1635344257689;
 Wed, 27 Oct 2021 07:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <1635253800-4459-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1635253800-4459-1-git-send-email-yangtiezhu@loongson.cn>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Wed, 27 Oct 2021 16:17:26 +0200
Message-ID: <CAM1=_QTnHz5rctNY1duhPh_DyhZVjGzqOU_r74DS0eyUD61nzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7] test_bpf: Add module parameter test_suite
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 3:10 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> After commit 9298e63eafea ("bpf/tests: Add exhaustive tests of ALU
> operand magnitudes"), when modprobe test_bpf.ko with jit on mips64,
> there exists segment fault due to the following reason:
>
> ALU64_MOV_X: all register value magnitudes jited:1
> Break instruction in kernel code[#1]
>
> It seems that the related jit implementations of some test cases
> in test_bpf() have problems. At this moment, I do not care about
> the segment fault while I just want to verify the test cases of
> tail calls.
>
> Based on the above background and motivation, add the following
> module parameter test_suite to the test_bpf.ko:
> test_suite=<string>: only the specified test suite will be run, the
> string can be "test_bpf", "test_tail_calls" or "test_skb_segment".
>
> If test_suite is not specified, but test_id, test_name or test_range
> is specified, set 'test_bpf' as the default test suite.
>
> This is useful to only test the corresponding test suite when specify
> the valid test_suite string.
>
> Any invalid test suite will result in -EINVAL being returned and no
> tests being run. If the test_suite is not specified or specified as
> empty string, it does not change the current logic, all of the test
> cases will be run.
>
> Here are some test results:
>  # dmesg -c
>  # modprobe test_bpf
>  # dmesg | grep Summary
>  test_bpf: Summary: 1009 PASSED, 0 FAILED, [0/997 JIT'ed]
>  test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [0/8 JIT'ed]
>  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_suite=test_bpf
>  # dmesg | tail -1
>  test_bpf: Summary: 1009 PASSED, 0 FAILED, [0/997 JIT'ed]
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_suite=test_tail_calls
>  # dmesg
>  test_bpf: #0 Tail call leaf jited:0 21 PASS
>  [...]
>  test_bpf: #7 Tail call error path, index out of range jited:0 32 PASS
>  test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [0/8 JIT'ed]
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_suite=test_skb_segment
>  # dmesg
>  test_bpf: #0 gso_with_rx_frags PASS
>  test_bpf: #1 gso_linear_no_head_frag PASS
>  test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_id=1
>  # dmesg
>  test_bpf: test_bpf: set 'test_bpf' as the default test_suite.
>  test_bpf: #1 TXA jited:0 54 51 50 PASS
>  test_bpf: Summary: 1 PASSED, 0 FAILED, [0/1 JIT'ed]
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_suite=test_bpf test_name=TXA
>  # dmesg
>  test_bpf: #1 TXA jited:0 54 50 51 PASS
>  test_bpf: Summary: 1 PASSED, 0 FAILED, [0/1 JIT'ed]
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_suite=test_tail_calls test_range=6,7
>  # dmesg
>  test_bpf: #6 Tail call error path, NULL target jited:0 41 PASS
>  test_bpf: #7 Tail call error path, index out of range jited:0 32 PASS
>  test_bpf: test_tail_calls: Summary: 2 PASSED, 0 FAILED, [0/2 JIT'ed]
>
>  # rmmod test_bpf
>  # dmesg -c
>  # modprobe test_bpf test_suite=test_skb_segment test_id=1
>  # dmesg
>  test_bpf: #1 gso_linear_no_head_frag PASS
>  test_bpf: test_skb_segment: Summary: 1 PASSED, 0 FAILED
>
> By the way, the above segment fault has been fixed in the latest bpf-next
> tree.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thank you. One more little thing that I missed before, see comment
inline below.

With that:
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

> ---
>
> v7:
>   -- Rename prepare_bpf_tests() to prepare_test_range(), remove
>      some unnecessary code, suggested by Johan Almbladh, thank you.
>
> v6:
>   -- Compute the valid range once in the beginning of prepare_bpf_tests(),
>      suggested by Johan Almbladh, thank you.
>
> v5:
>   -- Remove some duplicated code, suggested by Johan Almbladh,
>      thank you.
>   -- Initialize test_range[2] to {0, INT_MAX}.
>   -- If test_suite is specified, but test_range is not specified,
>      set the upper limit of each test_suite to overwrite INT_MAX.
>
> v4:
>   -- Fix the following checkpatch issues:
>      CHECK: Alignment should match open parenthesis
>      CHECK: Please don't use multiple blank lines
>
>      ./scripts/checkpatch.pl --strict *.patch
>      total: 0 errors, 0 warnings, 0 checks, 299 lines checked
>
>      the default max-line-length is 100 in ./scripts/checkpatch.pl,
>      but it seems that the netdev/checkpatch is 80:
>      https://patchwork.hopto.org/static/nipa/559961/12545157/checkpatch/stdout
>
> v3:
>   -- Use test_suite instead of test_type as module parameter
>   -- Make test_id, test_name and test_range selection applied to each test suite
>
> v2:
>   -- Fix typo in the commit message
>   -- Use my private email to send
>
>  lib/test_bpf.c | 212 ++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 135 insertions(+), 77 deletions(-)
>
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index e5b10fd..749d8c5 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -14316,72 +14316,9 @@ module_param_string(test_name, test_name, sizeof(test_name), 0);
>  static int test_id = -1;
>  module_param(test_id, int, 0);
>
> -static int test_range[2] = { 0, ARRAY_SIZE(tests) - 1 };
> +static int test_range[2] = { 0, INT_MAX };
>  module_param_array(test_range, int, NULL, 0);
>
> -static __init int find_test_index(const char *test_name)
> -{
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(tests); i++) {
> -               if (!strcmp(tests[i].descr, test_name))
> -                       return i;
> -       }
> -       return -1;
> -}
> -
> -static __init int prepare_bpf_tests(void)
> -{
> -       if (test_id >= 0) {
> -               /*
> -                * if a test_id was specified, use test_range to
> -                * cover only that test.
> -                */
> -               if (test_id >= ARRAY_SIZE(tests)) {
> -                       pr_err("test_bpf: invalid test_id specified.\n");
> -                       return -EINVAL;
> -               }
> -
> -               test_range[0] = test_id;
> -               test_range[1] = test_id;
> -       } else if (*test_name) {
> -               /*
> -                * if a test_name was specified, find it and setup
> -                * test_range to cover only that test.
> -                */
> -               int idx = find_test_index(test_name);
> -
> -               if (idx < 0) {
> -                       pr_err("test_bpf: no test named '%s' found.\n",
> -                              test_name);
> -                       return -EINVAL;
> -               }
> -               test_range[0] = idx;
> -               test_range[1] = idx;
> -       } else {
> -               /*
> -                * check that the supplied test_range is valid.
> -                */
> -               if (test_range[0] >= ARRAY_SIZE(tests) ||
> -                   test_range[1] >= ARRAY_SIZE(tests) ||
> -                   test_range[0] < 0 || test_range[1] < 0) {
> -                       pr_err("test_bpf: test_range is out of bound.\n");
> -                       return -EINVAL;
> -               }
> -
> -               if (test_range[1] < test_range[0]) {
> -                       pr_err("test_bpf: test_range is ending before it starts.\n");
> -                       return -EINVAL;
> -               }
> -       }
> -
> -       return 0;
> -}
> -
> -static __init void destroy_bpf_tests(void)
> -{
> -}
> -
>  static bool exclude_test(int test_id)
>  {
>         return test_id < test_range[0] || test_id > test_range[1];
> @@ -14553,6 +14490,10 @@ static __init int test_skb_segment(void)
>         for (i = 0; i < ARRAY_SIZE(skb_segment_tests); i++) {
>                 const struct skb_segment_test *test = &skb_segment_tests[i];
>
> +               cond_resched();
> +               if (exclude_test(i))
> +                       continue;
> +
>                 pr_info("#%d %s ", i, test->descr);
>
>                 if (test_skb_segment_single(test)) {
> @@ -14934,6 +14875,8 @@ static __init int test_tail_calls(struct bpf_array *progs)
>                 int ret;
>
>                 cond_resched();
> +               if (exclude_test(i))
> +                       continue;
>
>                 pr_info("#%d %s ", i, test->descr);
>                 if (!fp) {
> @@ -14966,29 +14909,144 @@ static __init int test_tail_calls(struct bpf_array *progs)
>         return err_cnt ? -EINVAL : 0;
>  }
>
> +static char test_suite[32];
> +module_param_string(test_suite, test_suite, sizeof(test_suite), 0);
> +
> +static __init int find_test_index(const char *test_name)
> +{
> +       int i;
> +
> +       if (!strcmp(test_suite, "test_bpf")) {
> +               for (i = 0; i < ARRAY_SIZE(tests); i++) {
> +                       if (!strcmp(tests[i].descr, test_name))
> +                               return i;
> +               }
> +       }
> +
> +       if (!strcmp(test_suite, "test_tail_calls")) {
> +               for (i = 0; i < ARRAY_SIZE(tail_call_tests); i++) {
> +                       if (!strcmp(tail_call_tests[i].descr, test_name))
> +                               return i;
> +               }
> +       }
> +
> +       if (!strcmp(test_suite, "test_skb_segment")) {
> +               for (i = 0; i < ARRAY_SIZE(skb_segment_tests); i++) {
> +                       if (!strcmp(skb_segment_tests[i].descr, test_name))
> +                               return i;
> +               }
> +       }
> +
> +       return -1;
> +}
> +
> +static __init int prepare_test_range(void)
> +{
> +       int valid_range;
> +
> +       if (!strcmp(test_suite, "test_bpf"))
> +               valid_range = ARRAY_SIZE(tests);
> +       else if (!strcmp(test_suite, "test_tail_calls"))
> +               valid_range = ARRAY_SIZE(tail_call_tests);
> +       else if (!strcmp(test_suite, "test_skb_segment"))
> +               valid_range = ARRAY_SIZE(skb_segment_tests);
> +       else
> +               return 0;
> +
> +       if (test_id >= 0) {
> +               /*
> +                * if a test_id was specified, use test_range to
> +                * cover only that test.
> +                */
> +               if (test_id >= valid_range) {
> +                       pr_err("test_bpf: invalid test_id specified for '%s' suite.\n",
> +                              test_suite);
> +                       return -EINVAL;
> +               }
> +
> +               test_range[0] = test_id;
> +               test_range[1] = test_id;
> +       } else if (*test_name) {
> +               /*
> +                * if a test_name was specified, find it and setup
> +                * test_range to cover only that test.
> +                */
> +               int idx = find_test_index(test_name);
> +
> +               if (idx < 0) {
> +                       pr_err("test_bpf: no test named '%s' found for '%s' suite.\n",
> +                              test_name, test_suite);
> +                       return -EINVAL;
> +               }
> +               test_range[0] = idx;
> +               test_range[1] = idx;
> +       } else if (test_range[0] != 0 || test_range[1] != INT_MAX) {
> +               /*
> +                * check that the supplied test_range is valid.
> +                */
> +               if (test_range[0] < 0 || test_range[1] >= valid_range) {
> +                       pr_err("test_bpf: test_range is out of bound for '%s' suite.\n",
> +                              test_suite);
> +                       return -EINVAL;
> +               }
> +
> +               if (test_range[1] < test_range[0]) {
> +                       pr_err("test_bpf: test_range is ending before it starts.\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int __init test_bpf_init(void)
>  {
>         struct bpf_array *progs = NULL;
>         int ret;
>
> -       ret = prepare_bpf_tests();
> +       if (strlen(test_suite) &&
> +           strcmp(test_suite, "test_bpf") &&
> +           strcmp(test_suite, "test_tail_calls") &&
> +           strcmp(test_suite, "test_skb_segment")) {
> +               pr_err("test_bpf: invalid test_suite '%s' specified.\n", test_suite);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * if test_suite is not specified, but test_id, test_name or test_range
> +        * is specified, set 'test_bpf' as the default test suite.
> +        */
> +       if (!strlen(test_suite) &&
> +           (test_id != -1 || strlen(test_name) ||
> +           (test_range[0] != 0 || test_range[1] != INT_MAX))) {
> +               pr_info("test_bpf: set 'test_bpf' as the default test_suite.\n");
> +               strcpy(test_suite, "test_bpf");

Use strscpy(test_suite, "test_bpf", sizeof(test_suite)) instead of strcpy.

The strcpy function is unsafe and may overwrite the destination buffer
if that is not large enough to hold the string. Won't happen in this
case here, but it is better to always use a bounds-checking version
when copying strings. That also makes the code more robust to changes,
if for example "test_bpf" is renamed to something longer. See
Documentation/process/deprecated.rst.

> +       }
> +
> +       ret = prepare_test_range();
>         if (ret < 0)
>                 return ret;
>
> -       ret = test_bpf();
> -       destroy_bpf_tests();
> -       if (ret)
> -               return ret;
> +       if (!strlen(test_suite) || !strcmp(test_suite, "test_bpf")) {
> +               ret = test_bpf();
> +               if (ret)
> +                       return ret;
> +       }
>
> -       ret = prepare_tail_call_tests(&progs);
> -       if (ret)
> -               return ret;
> -       ret = test_tail_calls(progs);
> -       destroy_tail_call_tests(progs);
> -       if (ret)
> -               return ret;
> +       if (!strlen(test_suite) || !strcmp(test_suite, "test_tail_calls")) {
> +               ret = prepare_tail_call_tests(&progs);
> +               if (ret)
> +                       return ret;
> +               ret = test_tail_calls(progs);
> +               destroy_tail_call_tests(progs);
> +               if (ret)
> +                       return ret;
> +       }
>
> -       return test_skb_segment();
> +       if (!strlen(test_suite) || !strcmp(test_suite, "test_skb_segment"))
> +               return test_skb_segment();
> +
> +       return 0;
>  }
>
>  static void __exit test_bpf_exit(void)
> --
> 2.1.0
>
