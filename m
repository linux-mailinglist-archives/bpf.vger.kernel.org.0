Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8C52F697
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbiEUAKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243537AbiEUAKt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:10:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97291DBE
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:10:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e3so10290593ios.6
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kn/LwdemDIEt1SQPG8WeFtkZOHFnM0zGsySB8T2F+Zc=;
        b=RyYWE8IiCx2XfrNxaX7bPq+P3tycOmg3HQ33xV48znUFXH/51v+83E17epgnz1hM0l
         HckjdQd3GQz6stKIuHRyYUEnvnbOfoMI7aqO/I+Ud+KrSF0SXHNQO9BeOr3BjYYHgPY1
         4ocym83M2S7ztecbyLWmQUEbB5qI8MKgU9G7nk07OqC2vjaZ3oKDy6grc/EUGLcrGqd/
         tO7y9sQk1yxE2qQXRN7wpJXIfnYQcTFsvDOiVinCzBxSMzbDrDclSAOXSX2a5O0pUyCC
         l1reNcyEuBwRMM5AfiJEFZtuzPqSonLR9EHmLL3jD06V2I17MmqR2XgEu1iWAB/YBUPZ
         0a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kn/LwdemDIEt1SQPG8WeFtkZOHFnM0zGsySB8T2F+Zc=;
        b=z/8ISrQjXnEfLXw+WW4G1mIIlftYeIhETsF/1l+3ttxjzRiT7AaB3yngQn/vD45feS
         9TmGT5CYdFzgq7fL1PXjB7QDLPAQKC78Ep989osD8ku1KnRD2hsrNdNld6SFpx8Q4mxe
         pYJWTpF7tB8Q2XoUYpkbWEh9V4U/sPym5iSEnkTpde0Q8tzOxG2gTrriYjCSV7yM5QaI
         89/PMzDJVuk0qgqXR3XR4Q63aLNSP3VoEJpiFmT4On+vVWetPSJ62DwDEys8lLsA2CuZ
         Z+3JzVKocAw9cUFgKJMFTW8DEvpwbh2U1itWMCRq17PA0IypbYpEPFd4aLxgfqAd6H/6
         Bykw==
X-Gm-Message-State: AOAM533ZWa4K+M9OW5LvfNE5uB0Xq7J9dUPLC/hFvYnA06TzAtytaNZg
        8FIUqwKwGOrp+j9b7fo+YGPT4nox/RQz/kBy/phU1V4f
X-Google-Smtp-Source: ABdhPJy9DNUqGxhKDFVZCdPmG3/Tlwa0d+08N2hjuRCRib6Io6Xn5iDM+U5pFVDgGdktGF3GCzACFZcm8Qvcch2ViRE=
X-Received: by 2002:a05:6638:2393:b0:32e:319d:c7cc with SMTP id
 q19-20020a056638239300b0032e319dc7ccmr6703176jat.103.1653091848017; Fri, 20
 May 2022 17:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
In-Reply-To: <CAPxVHdL-dT2GQh-HEkNjNoTEzA9DRL4W4ZfmUzc1+Bdz89fftQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 May 2022 17:10:37 -0700
Message-ID: <CAEf4BzZg0r4YptYPu8Y_-qp=rY__W6dmb9kLwMV5MAH6C-2PSg@mail.gmail.com>
Subject: Re: Tracing NVMe Driver with BPF missing events
To:     John Mazzie <john.p.mazzie@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "John Mazzie (jmazzie)" <jmazzie@micron.com>
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

On Wed, May 18, 2022 at 2:35 PM John Mazzie <john.p.mazzie@gmail.com> wrote:
>
> My group at Micron is using BPF and love the tracing capabilities it
> provides. We are mainly focused on the storage subsystem and BPF has
> been really helpful in understanding how the storage subsystem
> interacts with our drives while running applications.
>
> In the process of developing a tool using BPF to trace the nvme
> driver, we ran into an issue with some missing events. I wanted to
> check to see if this is possibly a bug/limitation that I'm hitting or
> if it's expected behavior with heavy tracing. We are trying to trace 2
> trace points (nvme_setup_cmd and nvme_complete_rq) around 1M times a
> second.
> We noticed if we just trace one of the two, we see all the expected
> events, but if we trace both at the same time, the nvme_complete_rq

kprobe programs have per-CPU reentrancy protection. That is, if some
BPF kprobe/tracepoint program is running and something happens (e.g.,
BPF program calls some kernel function that has another BPF program
attached to it, or preemption happens and another BPF program is
supposed to run) that would trigger another BPF program, then that
nested BPF program invocation will be skipped.

This might be what happens in your case.

> misses events. I am using two different percpu_hash maps to count both
> events. One for setup and another for complete. My expectation was
> that tracing these events would affect performance, somewhat, but not
> miss events. Ultimately the tool would be used to trace nvme latencies
> at the driver level by device and process.
>
> My tool was developed using libbpf v0.7, and I've tested on Rocky
> Linux 8.5 (Kernel 4.18.0), Ubuntu 20.04 (Kernel 5.4) and Fedora 36
> (Kernel 5.17.6) with the same results.
>
> Thanks,
> John Mazzie
> Principal Storage Solutions Engineer
> Micron Technology, Inc.
