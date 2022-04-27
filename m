Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E3512560
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 00:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiD0Wls (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiD0Wlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 18:41:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03826D85E
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 15:38:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e15so4792420iob.3
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWN87qdXgs/iQVjDGZhUMXSZImALY1HR2MJxSexxUPg=;
        b=iRKrqXl+Jc+Y9hx89KwnFSBol1v8rt11iGxdmf0K0DPW3tMnFv9QuN/DDCzP+tl8tS
         euQvWqSyBrl6WAi6VSIc3FcwQQYlR4Zoc1Qhz/m1vJlizdLgwAfKrJzlver0a7rJXLlH
         +ljwZuNj7N/WSBxruEovkqDG3Q0OYZvP5JMTpW9gqWB2yLkMhz65yM/vZR/0S4Yl/ZT1
         HViAgIqxWX/h2mMZZb3u8ImsC2z0LOwg6CyQTi+FfTk6K+mVE38da2rF11BjT2+RUQme
         qQYdHpZtp3tz1qxwE+NJUqmlp7f1WUQnP852dGETcCik/iplFWBHEranoFX6p5EnG7Fv
         VwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWN87qdXgs/iQVjDGZhUMXSZImALY1HR2MJxSexxUPg=;
        b=eTXWArp5yRwQk1bzbpxISzMBxccwBfF6+F6ZJcLZmH1dxfUIBZ03p8a0SsoOTbOz1y
         n1aqEAsgRoC/bUwOQTtSZdN5ittBiZmlTlWn0+9AN/cAWrcWLqaYujsDLLik2m7vTppY
         tHf0qrzh4U+VijeYvCIDsWtK+uWSWHFCJII9siVEfWcQEyzDfqwVLVZH8CoL5aZg2ZoV
         774tApFUtVpNp9ZazLzuuA2/5y0GVhWuCOu7SMV2sngOK7gzFQVXdFVskUXtIHb36kfo
         iz9cnOl08BvQnaSiSDLJ1Y3fahsjYEFJTrqUJa+/rpf/A4x5fV7nXeFG1qr0v3BuzCkz
         9j7Q==
X-Gm-Message-State: AOAM531R1MAvqavsDji2QF+QtohKYjAYuDAHl2vDXLFrdeKTvwq3r5xq
        uv7IK45bEcVPBRfDwwVj1L+6eon8XfRF5m0KWUQ=
X-Google-Smtp-Source: ABdhPJzTreO3I8QE1l6MGHUtytms6r+zzkuJeiR6k+OWnK4AACp5/jGZ8YqL/GkTN1TgoG5/82nF0fQHID3kuL7fDjg=
X-Received: by 2002:a05:6602:3787:b0:654:9cab:b681 with SMTP id
 be7-20020a056602378700b006549cabb681mr12444314iob.154.1651099102393; Wed, 27
 Apr 2022 15:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220427041353.246007-1-mykolal@fb.com>
In-Reply-To: <20220427041353.246007-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Apr 2022 15:38:11 -0700
Message-ID: <CAEf4Bzb0P259ReSRSTxUab=9NBsVJEpbxi+gzNgzMLe48ay9Cg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf/selftests: add granular subtest output
 for prog_test
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Apr 26, 2022 at 9:14 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> Implement per subtest log collection for both parallel
> and sequential test execution. This allows granular
> per-subtest error output in the 'All error logs' section.
> Add subtest log transfer into the protocol during the
> parallel test execution.
>
> Move all test log printing logic into dump_test_log
> function. One exception is the output of test names when
> verbose printing is enabled. Move test name/result
> printing into separate functions to avoid repetition.
>
> Print all successful subtest results in the log. Print
> only failed test logs when test does not have subtests.
> Or only failed subtests' logs when test has subtests.
>
> Disable 'All error logs' output when verbose mode is
> enabled. This functionality was already broken and is
> causing confusion.
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---

Works great! I've dropped the before test/subtest duplicated output of
test/subtest name, as it seems unnecessary in practice. I dropped few
lines of code that do that locally, as you suggested.

I also noticed a small memory leak, see comment below, please send a follow up.

>  tools/testing/selftests/bpf/test_progs.c | 640 +++++++++++++++++------
>  tools/testing/selftests/bpf/test_progs.h |  35 +-
>  2 files changed, 499 insertions(+), 176 deletions(-)
>

[...]

> +
> +static int dispatch_thread_read_log(int sock_fd, char **log_buf, size_t *log_cnt)
> +{
> +       FILE *log_fp = NULL;
> +
> +       log_fp = open_memstream(log_buf, log_cnt);
> +       if (!log_fp)
> +               return 1;
> +
> +       while (true) {
> +               struct msg msg;
> +
> +               if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_LOG))

leaking log_fp here?

> +                       return 1;
> +
> +               fprintf(log_fp, "%s", msg.test_log.log_buf);
> +               if (msg.test_log.is_last)
> +                       break;
> +       }
> +       fclose(log_fp);
> +       log_fp = NULL;
> +       return 0;
> +}
> +

[...]
