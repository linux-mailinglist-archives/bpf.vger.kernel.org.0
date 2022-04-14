Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C134501EB5
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 00:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiDNWwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 18:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiDNWwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 18:52:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA7D33885
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 15:49:43 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k25so6951648iok.8
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfjIW3E48NMj5Ceh44JVUosWzHUARzIstTwLHpxm/Uk=;
        b=I/SkOpValo89IB8j+ngpCuBI8MFNf5Um2sXQUAQ5OsfZO/BW9C+Sow0D80r6dbNXB5
         WwIdwn+dziR9Lv2kujRtwQ388a9plWrZl1ebzJnQvZVHJvoa3KEmhspkaA8p32MR1/Hz
         98Pc0yxLf2PxBGgL8gfyIS2eFNn9c12nrSzBRzz/9WVGSps976moQZIQAh7WxUSVixtN
         rsjciSFtGdvie/DQmliOTmRkuYA/zIOmAwkp5uMeTdL1DoTDzLKDiZl+Ke6UhPYwInCE
         NUEe8JKMffyn1T0T+iDFJqudKPKTOLmctH43E7/9xJhA0xEZbW77SAu9Ty38T+snp5k8
         G5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfjIW3E48NMj5Ceh44JVUosWzHUARzIstTwLHpxm/Uk=;
        b=US5GUcbGgKTPNVtfiP3OQRKEOtA1b5PloRt9L8qvweLpCMbzwmCdDuO7qK9STaLZpu
         +wiNfBY1Pxl4IJTkxdEEGVMDun2hyF9r9TwOjOKMpX1zUxem5Vv9L8++xGkftiyWXjEK
         SxuK0GXxnXjlMHCudqWPdrt9YMUKF8tYj7zREzpw/b8JsuHZxnmNMDbCnglKkb58Szv7
         6ULjFObXPVuJ0wLWE7qMQFuppZ+GhuIw5R4c5x4pTW3dYs6t89qbol/TquypWjs4F0EV
         MdEDjn4F8x/u9rg7H2wQ1RibpsbZiQfVmPt4lkeAUKbKeIp0yxjGbFuamcDnO9NG7T9X
         t4lg==
X-Gm-Message-State: AOAM530MPPvjYA8M2fuxw3F5nlwUJfT6IEdkWp22IwDhJ6thf7ugL5qh
        sIKUrB4vn151lqEOXPET3gtFvnICz+NX7eLRIKs=
X-Google-Smtp-Source: ABdhPJy2D9hfcCaAZ2gBfIXAA+NsZAJCaa0ZhivcHvjDecUgvQTcIzCsOkbaJJYx1xT7HYA+ZWgK5NIVwvQjYEd8N78=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr2043961iod.112.1649976582600; Thu, 14
 Apr 2022 15:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220414050509.750209-1-mykolal@fb.com>
In-Reply-To: <20220414050509.750209-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Apr 2022 15:49:31 -0700
Message-ID: <CAEf4BzYRBtx3Oc8xu=dv15wwD-=y8bWm6KE_MPcH33kWMVnCPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: consolidate common code in
 run_one_test function
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

On Wed, Apr 13, 2022 at 10:05 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> This is a pre-req to add separate logging for each subtest.
>
> Move all the mutable test data to the test_result struct.
> Move per-test init/de-init into the run_one_test function.
> Consolidate data aggregation and final log output in
> calculate_and_print_summary function.
> As a side effect, this patch fixes double counting of errors
> for subtests and possible duplicate output of subtest log
> on failures.
>
> Also, add prog_tests_framework.c test to verify some of the
> counting logic.
>
> As part of verification, confirmed that number of reported
> tests is the same before and after the change for both parallel
> and sequential test execution.
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---

The consolidation of the per-test logic in one place is great, thanks
for tackling this! But I tried this locally and understood what you
were mentioning as completely buffered output. It really sucks and is
a big step back, I think :(

Running sudo ./test_progs -j I see no output for a long while and only
then get entire output at the end:

#239 xdp_noinline:OK
#240 xdp_perf:OK
#241 xdpwall:OK

All error logs:

#58 fexit_sleep:FAIL
test_fexit_sleep:PASS:fexit_skel_load 0 nsec
test_fexit_sleep:PASS:fexit_attach 0 nsec
test_fexit_sleep:PASS:clone 0 nsec
test_fexit_sleep:PASS:fexit_cnt 0 nsec
test_fexit_sleep:PASS:waitpid 0 nsec
test_fexit_sleep:PASS:exitstatus 0 nsec
test_fexit_sleep:FAIL:fexit_cnt 2
Summary: 240/1156 PASSED, 34 SKIPPED, 1 FAILED


First, just not seeing the progress made me wonder for a good minute
or more whether something is just stuck and deadlock. Which is anxiety
inducing and I'd rather avoid this :)

Second, as you can see, fexit_sleep actually failed (it does sometimes
in parallel mode). But I saw this only at the very end, while normally
I'd notice it as soon as it completes. In this case I know fexit_sleep
can fail and I'd ignore, but if there was some subtest that suddenly
breaks, I don't wait for all the tests to finish, I ctrl-C and go
investigate. Now I can't do that.

How much of a problem is it to preserve old behavior of streaming
results of tests as they come, but consolidate duplicate logic in one
place?

>  .../bpf/prog_tests/prog_tests_framework.c     |  55 ++++
>  tools/testing/selftests/bpf/test_progs.c      | 301 +++++++-----------
>  tools/testing/selftests/bpf/test_progs.h      |  32 +-
>  3 files changed, 195 insertions(+), 193 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> new file mode 100644
> index 000000000000..7a5be06653f7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +#include "test_progs.h"
> +#include "testing_helpers.h"
> +
> +static void clear_test_result(struct test_result *result)
> +{
> +       result->error_cnt = 0;
> +       result->sub_succ_cnt = 0;
> +       result->skip_cnt = 0;
> +}
> +
> +void test_prog_tests_framework(void)
> +{
> +       struct test_result *result = env.test_result;
> +
> +       // in all the ASSERT calls below we need to return on the first
> +       // error due to the fact that we are cleaning the test state after
> +       // each dummy subtest
> +
> +       // test we properly count skipped tests with subtests

C++ comments, please use /* */


> +       if (test__start_subtest("test_good_subtest"))
> +               test__end_subtest();
> +       if (!ASSERT_EQ(result->skip_cnt, 0, "skip_cnt_check"))
> +               return;
> +       if (!ASSERT_EQ(result->error_cnt, 0, "error_cnt_check"))
> +               return;
> +       if (!ASSERT_EQ(result->subtest_num, 1, "subtest_num_check"))
> +               return;
> +       clear_test_result(result);
> +

[...]
