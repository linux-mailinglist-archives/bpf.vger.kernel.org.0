Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B58611933
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJ1RWZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiJ1RWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 13:22:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40822AB4D
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 10:22:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v27so8876546eda.1
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zL/+Ty6Nr3nn+uPHS8ztTREttDXXP6qvU1YxurIkUQY=;
        b=UhRnBV2nh2TiraIMvaBv4zAU9bK2ln4qbG/E3WfCi8/v8fXyH8IX2X4Ij6g2JdbsiY
         4vney7Z/4E6U5VBo6WK180hEPXG6uxTdPjFh4Rj6TK/aVwgSh9lkkUdkII2ScrC6pwlx
         myON2W5fowHJ1EFL+wJWnOGByKiBjJSaWywMiPw4+aFdFwb/hUmJFUCSQXaqrV8xztQk
         oVYB5qJfMkUBbtirMFtIR1IPlC9wJlcgUzX/5fE3evbjOLibw2Myb4tlH9/CwdMuEScI
         krZRa6X3Fyw9/+SGCwMwO9Jq2azudX6bT1rZepjO5PaHUH3VvB4GKskqW3wGfOt4FCqm
         HQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zL/+Ty6Nr3nn+uPHS8ztTREttDXXP6qvU1YxurIkUQY=;
        b=ys2yYPYMmGrq1ar20qHqhaUSVb8fYiZeXbSmif7SNWjJ3SHoj1j70nWxTLsdcIbkMO
         JroANq+bZPz80ywW8HP4MuQBucreNuFI0rXsKzvIPKiyn34J1tKJR2KkF6pwAilL/XAy
         I9jGAJGFSQSbmVSk7eQfbW8BvAgAfoQ6QZubAApRctmQGWl/t9TxzfaKTfXguk7thpUQ
         ffdTfzdXAf5DzjLy30sa8z6XxSGt1xsUAngyzzaxSDFvUFeCvfjZxfAQ8o9jjJfkkRhU
         epmRp1T+OPtRzhKo3HbF5XtYmwTuyivS2BeNdKp9KwezEGLQXtef0owPMkG5SBHrKCVE
         l5dg==
X-Gm-Message-State: ACrzQf0YXigtfIx3wxoJtJlC6et1KgLZ2paq5maIJxCTccPdQ5bCRbvx
        M2egfaGcLSqD4Hxj3cqSno/3pTluEACdouZQsRvJeoyD3MY=
X-Google-Smtp-Source: AMsMyM7KVSv/BNGyTxtIgKWeqWo7FyRYJDk8GZb7fpGiHihq0RVqA7niKKZsdKJ2Et6/Y+Qf5rlI5fbeIRgUlUTA1x8=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr459792edb.333.1666977736698; Fri, 28
 Oct 2022 10:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oUcnKPHZvFO+-2tDuDny9spYg_9AftkuqLL=cH5S-s4kw@mail.gmail.com>
In-Reply-To: <CAO658oUcnKPHZvFO+-2tDuDny9spYg_9AftkuqLL=cH5S-s4kw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 28 Oct 2022 10:22:04 -0700
Message-ID: <CAEf4BzaMNU2UoutOLdX-HbkA0037EV6kwQg3-TJLHV_8tjdzDg@mail.gmail.com>
Subject: Re: libbpf not properly detecting support for memcg-based memory accounting
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Fri, Oct 28, 2022 at 7:26 AM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> It appears that while using libbpf 1.0.1 on a 5.10 kernel, libbpf is
> not properly recognizing a lack of support for memcg-based memory
> accounting. This is happening in Google's default Kubernetes
> environment (GKE). The error message we receive is:

Yes, unfortunately the way the switch to memcg accounting is
implemented makes it hard to detect it easily. So libbpf is detecting
another feature that went together with memcg switch (see
probe_memcg_account()). So it's kind of known, though unfortunate,
state of the things.

Do you have some good ideas on how to implement this better? And yes,
the ability to bump memory limits manually is sort of an intended
work-around.

>
> ```
> libbpf: map 'sys_32_to_64_map': failed to create: operation not permitted(-1)
> libbpf: permission error while running as root; try raising 'ulimit
> -l'? current value: 64.0 KiB
> libbpf: failed to load object 'embedded-core'
> ```
>
> We were able to fix this issue by manually bumping the memory rlimit,
> leading to the conclusion that the detection of memcg-based memory is
> not functioning properly, and therefore libbpf is not handling this
> manual bump as advertised.
>
> Environment:
>
> ```
> Linux ubuntu 5.10.123+ #1 SMP Sat Jul 9 14:51:14 UTC 2022 x86_64
> x86_64 x86_64 GNU/Linux
> ```
>
> Thanks so much,
> Grant Seltzer
