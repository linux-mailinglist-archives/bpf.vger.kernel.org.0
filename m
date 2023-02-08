Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6768F238
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 16:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBHPlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 10:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBHPlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 10:41:09 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C94615D
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 07:41:04 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y7so7080221iob.6
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 07:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JkZ58MYpEhG2IwgSBdaX6mp9aV0KvO0RkSxNMsdPhHc=;
        b=oD1cHhuFwSExgigEC5/cuhqv5oBMKXkmYj7TI/9ME8tU3GuxLC37Ghu++ISVQL2wN7
         rBdkgBzOv5AG/Yp4ObjbJGIGTe31fdYt09XdtHeESFH4URp706nPVddaaZIXgHXrJnDt
         DnjD1ajs9ErVnghYA0vw/ZVe89CICfxRKlQ0jiezXiYycxtCcPT1nCWjbMa/KkzJXw5+
         336AxghiMNGUfUB1QnBLYYsWX+8mNDWT2vaqbtNJI7L1YMPEddrYAbeetbjPEXBtIf6u
         B6EufycjRxQ1A7ba0TVIBvSmyqToC8r4ok5AJCf7WmX6qL/ajqojBR3x8AxOyENl+Emo
         0NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkZ58MYpEhG2IwgSBdaX6mp9aV0KvO0RkSxNMsdPhHc=;
        b=DcHkMYLWn4pF0m0AM81beoLY9Kc274MezFrbalJxRqMFRAeE6UM4uqvsTfYhIK5BYC
         4+pR0SnIJXzhZf7iV4dxcNI73jRDg9TbOBRsEKvQzBhnUJHapxpwzeXxnT32EWvbMwI+
         PlboXEacF9I/iuBJp2bRFbQSZiTinib10qm/72P/dO4x7trjeoz0zNGH7p2+icKpIjOk
         SYe4oQOxD6h46vHfc7PNqlYMB7m8XZR1rgCyOGiiPKblG6qObUUbze/j2y8DI3vj/3Ek
         ecCAMYLDPJEPaUKB1HSJ1YcmBdZP4yiD4bUXyCDnxZMGID656GxlXHOWcKu1TrRHJoER
         en1A==
X-Gm-Message-State: AO0yUKXHWwCXFWkYTD40bCTFO2wdZVz+bCyxaxD2vyuNTKYGZD7d1VqH
        SsJjfoThXkIxuKseu51Ry3WxCil+QmuocPNGBfuSSeLHxTKxXw==
X-Google-Smtp-Source: AK7set9F+qi9hhqT1pb8ssTepVxMc/R33bV88CYbyXLiEVrpY2H5lmWnTCt4NXHjSGYxqs+Qa+QrXkL+ogppS3kRQkc=
X-Received: by 2002:a02:b707:0:b0:38a:4b1f:f69b with SMTP id
 g7-20020a02b707000000b0038a4b1ff69bmr216754jam.4.1675870864203; Wed, 08 Feb
 2023 07:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20230203182812.20657-1-grantseltzer@gmail.com>
 <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev> <CAO658oVRQTL8HfKFJ3X8zjYRLJCQWROjzyOcXeP=uVRML1UYOw@mail.gmail.com>
 <f2afdc22-a9c1-eaad-fab4-2ff61b409282@linux.dev> <CAO658oUUZf2eAA-hRvGm8=u9bX-g2xXxB_Vvr1b5Bg=wKX6xQw@mail.gmail.com>
 <616140cf-b2e1-5bca-a6cb-8057c7d9ae0d@linux.dev>
In-Reply-To: <616140cf-b2e1-5bca-a6cb-8057c7d9ae0d@linux.dev>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Wed, 8 Feb 2023 10:40:53 -0500
Message-ID: <CAO658oUgbed5r9K6fEBoqoxjUeZDd4kBwOxa2c8-nq5YDpy+8A@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 8:05 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 2/7/23 7:46 AM, Grant Seltzer Richman wrote:
> > On Mon, Feb 6, 2023 at 3:37 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 2/5/23 9:29 AM, Grant Seltzer Richman wrote:
> >>> On Sat, Feb 4, 2023 at 1:58 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>>
> >>>> On 2/3/23 10:28 AM, Grant Seltzer wrote:
> >>>>> This patch changes the behavior of how BPF_PROG_RUN treats tracing
> >>>>> (fentry/fexit) programs. Previously only a return value is injected
> >>>>> but the actual program was not run.
> >>>>
> >>>> hmm... I don't understand this. The actual program is run by attaching to the
> >>>> bpf_fentry_test{1,2,3...}. eg. The test in fentry_test.c
> >>>
> >>> I'm not sure what you mean. Are you saying in order to use the
> >>> BPF_PROG_RUN bpf syscall command the user must first attach to
> >>> `bpf_fentry_test1` (or any 1-8), and then execute the BPF_PROG_RUN?
> >>
> >> It is how the fentry/fexit/fmod_ret...BPF_PROG_TYPE_TRACIN_xxx prog is setup to
> >> run now in test_run. afaik, these tracing progs require the trampoline setup
> >> before calling the bpf prog, so don't understand how __bpf_prog_test_run_tracing
> >> will work safely.
> >
> > My goal is to be able to take a bpf program of type
> > BPF_PROG_TYPE_TRACING and run it via BPF_PROG_TEST_RUN without having
> > to attach it. The motivation is testing. You can run tracing programs
> > but the actual program isn't run, from the users perspective the
> > syscall just returns 0. You can see how I'm testing this here [1].
> >
> > If I understand you correctly, it's possible to do something like
> > this, can you give me more information on how I can and I'll be sure
> > to submit documentation for it?
> >
> > [1] https://github.com/grantseltzer/bpf-prog-test-run/tree/main/programs
>
> In raw tracepoint, the "ctx" is just a u64 array for the args.
>
> fentry/fexit/fmod_ret is much demanding than preparing a u64 array. The
> trampoline is preparing more than just 'args'. The trampoline is likely to be
> expanded and changed in the future also. You can take a look at
> arch_prepare_bpf_trampoline().
>
> Yes, might be the trampoline preparation can be reused. However, I am not
> convinced tracing program can be tested through test_run in a meaningful and
> reliable way to worth this complication. eg. A tracing function taking 'struct
> task_struct *task'. It is not easy for the user space program to prepare the ctx
> containing a task_struct and the task_struct layout may change also. There are
> so many traceable kernel functions and I don't think test_run can ever become a
> single point to test tracing prog for all kernel functions.
> [ Side-note: test_run for skb/xdp has much narrower focus in terms of argument
> because it is driven by the packet header like the standard IPv6/TCP/UDP. ]
>
> Even for bpf_prog_test_run_raw_tp, the raw_tp_test_run.c is mostly testing if
> the prog is running on a particular cpu. It is not looking into the args which
> is what the tracing prog usually does.
>
> Please attach the tracing prog to the kernel function to test
> or reuse the existing bpf_prog_test_run_raw_tp to test it if it does not care
> the args.

Thank you for the explanation, I understand!
