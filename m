Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356668B118
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 18:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjBER3i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 12:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBER3h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 12:29:37 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7D1CADC
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 09:29:36 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id j4so3727944iog.8
        for <bpf@vger.kernel.org>; Sun, 05 Feb 2023 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AlN0W1pwFvqUnXK69HCRffupy1rMxJwnZS13lciKOvw=;
        b=SSxyzoKDlDzPXlRpXGWSDiR3XfUVhOuLXE9J+TGRbciRJ7/lhl9sVTWzc9q2XjA8Pw
         KnZHmAUAuX7zyni93CwxjWszXDmqRkkgCpndLpaRRElu8wlfQqLv7iXdxvFY1RMI622M
         fGRnvvHZ0yqe8uxRzlp0PjevmsqGKCp8N6CtvWyEq+j0cFo2ruq1birpTzwioOtdX1vj
         UaeKBYJKHASqX7Q0iAb4dDoExeLPG8ui9l4qnmYAEtQBYeWO3HDZ94/Me1mSyAXixnhO
         NcCgol1zcTRdkOQRfAQaUsRfS3+KQjZUM9GaG7zhPUIrTtmE8ky+hQK+BebHDtfDwDtb
         JawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlN0W1pwFvqUnXK69HCRffupy1rMxJwnZS13lciKOvw=;
        b=j/xyxy3/NYXHDhsxp5WI/QOlkFOtv1s/gXDm3GwzMtilWROXCj/rmkvjeM+3ZbuZ4j
         NA51lXBuPLatIe+N5aMZrsFRzIvm11qVB50RlTbMcVeMYEthGoMeOFDdDLZPeB0NMPC9
         jKQZ3zknQuElsFF/kdY5ctIewYuQscCSgTOthlt1gulwTBddTxZl4sxGrMoxEXsSRHPz
         2Vz/PgFsE4YPNB0MbGWskpnEonAXP69lCSewepkEd8vsF0wXUUGDngpdxEUSXtoVaOWk
         6/qSZa/qz0qP+gumpRYpaVuqgtCYJbI40yWkYJX2hG+6885YU5NA1skL9dSxDqtgAaTk
         q7tw==
X-Gm-Message-State: AO0yUKXI3aE/FvFpPUh51OQLCVgach4pZoRxFMAxMhtjVl2oV6Z5rIOu
        aXu9wZ8880x6FONWPKX42FY0eGAiKW8NjjP7NiI=
X-Google-Smtp-Source: AK7set+2aN3wZIX+csI9ZQZVBJ/tIG7imHHLl6OPNvcEq2Tfb+Dgf8mc0JUn23mZx75BHgHgasr3MbqC557+Q6lq8EM=
X-Received: by 2002:a6b:1488:0:b0:71a:1e2a:e12 with SMTP id
 130-20020a6b1488000000b0071a1e2a0e12mr3749043iou.82.1675618175755; Sun, 05
 Feb 2023 09:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20230203182812.20657-1-grantseltzer@gmail.com> <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev>
In-Reply-To: <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Sun, 5 Feb 2023 12:29:24 -0500
Message-ID: <CAO658oVRQTL8HfKFJ3X8zjYRLJCQWROjzyOcXeP=uVRML1UYOw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] Add support for tracing programs in BPF_PROG_RUN
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     andrii@kernel.org, kpsingh@kernel.org, bpf@vger.kernel.org
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

On Sat, Feb 4, 2023 at 1:58 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 2/3/23 10:28 AM, Grant Seltzer wrote:
> > This patch changes the behavior of how BPF_PROG_RUN treats tracing
> > (fentry/fexit) programs. Previously only a return value is injected
> > but the actual program was not run.
>
> hmm... I don't understand this. The actual program is run by attaching to the
> bpf_fentry_test{1,2,3...}. eg. The test in fentry_test.c

I'm not sure what you mean. Are you saying in order to use the
BPF_PROG_RUN bpf syscall command the user must first attach to
`bpf_fentry_test1` (or any 1-8), and then execute the BPF_PROG_RUN?

>
> > New behavior mirrors that of running raw tracepoint BPF programs which
> > actually runs the instructions of the program via `bpf_prog_run()`
>
> Which tracepoint and how is it tested?

I was referring to the `bpf_prog_test_run_raw_tp()` function in the
same file. I can write additional selftests

>
> The CI kernel is crashing:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230203182812.20657-1-grantseltzer@gmail.com/
>

Thanks for linking to this, I was unaware of this being available!
