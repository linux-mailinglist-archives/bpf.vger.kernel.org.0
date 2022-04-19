Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D8A506336
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 06:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbiDSEaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 00:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSEaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 00:30:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A024F23
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:27:28 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r12so10549359iod.6
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTCbD1H6pyQz+z2/jmIUgDmiiJRL0CX0GaOM3nNcIJM=;
        b=SxuPG8tOa4ZLzafzxsPSfhdA0ZGzkaaVE4jh9NDZk+J7XKpIllc7lZF0j6t0XzREwq
         lSIpVwu/IrLXW/vKB/4AmN76nf21ORgCV0HEWlSCNf4bH2LCzggl1WoPNnQeBQoQan16
         fzNpb/gOAxKZpcINOFxWJalSiHhPncPIpuFaaVOvT59BZw7kvFWoqNrTULtJG1f1HzC6
         N8UhAPow/P/DdhK7DHbid+G32YImA8B6RNzez1AsoNvJR6D/Xze0ei5XWx2viSH8s+JN
         LCeliREwPt6c9fk4OrM+vGBpxpkq7EFFrE+ckTaYVwL3sfDIxK/rew9INC629/eyjVHu
         rNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTCbD1H6pyQz+z2/jmIUgDmiiJRL0CX0GaOM3nNcIJM=;
        b=WE4CmoqCEsJ9pkh3XdNe8lQgy1bRRcLtl6o2RW4b6xCjPMgAWYOL9fdamj9ZkJlOvP
         RoqUBLxO/gM8gOpL2ChQTI1nKMBctwBBkh5T0fPlYoqgJFpx8Srv1W3y8vzKN5Zvx88R
         HLkOYiR1+2hnYe+S9rY/RQ7gZliKvkYgD52AJa+C8IUeC526pJrASf3KVfyczhIBAdvM
         Cr+2yMqT0ToyNMp7z7D7xDkjNc/+7UrDQXwYuTWFkv6RL+7mJU+Y/vox5rYo5bRp8rBJ
         mK91aQY1h+WXkGt5Q7lNS9kzZTaQCisVcFkaVJRvWxUlg0kBeBe5h8aq9CBR8Z7oberH
         ZK2Q==
X-Gm-Message-State: AOAM5313ZnV0RduBKEElSKDxFubPrSmqRxxT9qXhEe8HcEWKqb+CZbjq
        aTtdg2EEZnfOofzgB68nKHRCwncIt5XF95xLnf/o6FSZCec=
X-Google-Smtp-Source: ABdhPJzfOXpkRTSkq3FOEJJtZyHSRxw9ohX9EwI+/tlhLQ1UIkkcw5lSCZ7PEEYFZGfWU/K6hPm8ccGKb1HZMzHMQ2E=
X-Received: by 2002:a05:6602:3787:b0:654:9cab:b681 with SMTP id
 be7-20020a056602378700b006549cabb681mr3161982iob.154.1650342447498; Mon, 18
 Apr 2022 21:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220418222507.1726259-1-mykolal@fb.com>
In-Reply-To: <20220418222507.1726259-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 Apr 2022 21:27:16 -0700
Message-ID: <CAEf4BzbKxAxmwN7u6+-WHoR_2KDm=ane7eaezfcN8KQPZ8d4Lw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: refactor prog_tests logging
 and test execution
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

On Mon, Apr 18, 2022 at 3:27 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> This is a pre-req to add separate logging for each subtest in
> test_progs.
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

I've added %-3d to test number output so that it's a bit more aligned:

#178 test_global_funcs:OK
#173 tcp_hdr_options:OK
#50  d_path:OK
#132 send_signal:OK
#23  btf_map_in_map:OK
#10  bpf_iter:OK
#184 test_skb_pkt_end:OK
#185 test_strncmp:OK
#46  core_reloc_btfgen:SKIP

And applied to bpf-next, thanks. Looking forward to subtest logging
improvements!

>  .../selftests/bpf/prog_tests/bpf_mod_race.c   |   4 +-
>  .../bpf/prog_tests/prog_tests_framework.c     |  56 +++
>  tools/testing/selftests/bpf/test_progs.c      | 327 +++++++-----------
>  tools/testing/selftests/bpf/test_progs.h      |  35 +-
>  4 files changed, 202 insertions(+), 220 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
>

[...]

>
>  /* A bunch of tests set custom affinity per-thread and/or per-process. Reset
> @@ -219,72 +205,79 @@ static void restore_netns(void)
>  void test__end_subtest(void)
>  {
>         struct prog_test_def *test = env.test;
> -       int sub_error_cnt = test->error_cnt - test->old_error_cnt;
> +       struct test_state *state = env.test_state;
>

this empty lines was breaking variable declaration block into two
separate blocks, I've removed an empty line here

> -       dump_test_log(test, sub_error_cnt);
> +       int sub_error_cnt = state->error_cnt - state->old_error_cnt;
>
>         fprintf(stdout, "#%d/%d %s/%s:%s\n",


[...]
