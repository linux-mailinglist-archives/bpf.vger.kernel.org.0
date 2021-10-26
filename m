Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2484A43AAE5
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 06:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhJZEEg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 00:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhJZEEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 00:04:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E20C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:02:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k26so12988856pfi.5
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 21:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XNCY2In2FTRlj7mvXmzs1Tca9yvDLgVV6DHArPqDtGk=;
        b=KZF/AOzHvvXeYatMsiCRYwiLQNVpaikIZ8wRTi8qweLPCNxD6t2JZhz9uXzUC4WrmZ
         DBrdUfnqUhlOqst9ZLP6krixBYrKZSYL4OStpUE40WowbSB8xyKBeOCXQguLOSpOlwje
         tU8KYMc3/KeS9sfkO2ewj61qj1ARfr0krBl4/s8BeyR4QnlMNzpNlncVR9a/BfFmj/Ac
         ZDVkL9gO+dkfdWXiUC3QIOczrF8H81iVZ3LfLfhTB+0h4GpFAl0d/8OspESvLW9cf+b3
         N4R4VkvBCRdmoVjNu+IMcrvleWGoNwvxRlIsk6sH8TByHmLSlYSgfksoLHRcSrV3CpWH
         87FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XNCY2In2FTRlj7mvXmzs1Tca9yvDLgVV6DHArPqDtGk=;
        b=Yc5pEE+YNSuqAWQab/rpCka07YL6MMdrIZ//3nlXNbpK9WL6JhlSna2ZVGYsLIf1bE
         EscwdMF7O/+kxAu5a/sI0X5MCrYO2av4vbCY2CccGtYl/LJylVImnmds98CHyAahX1IC
         YQol4iD42DQew/0VsyN0XwwwTe49iizn6YNmK/wUtgvBLEniO/X9k9XtnzMMvgbNk75I
         9uzISAkr0a1pKSPZSgYj2/AF+P5IiShLu/sM5azGPuKDJsDAmscrK3P3CQsmABo4fytM
         bToG11hmQyM31iC81nVNGoU4MjYNWvPuanSsQjwS6ewGBLIq/+KE/Fxj7yRfvOF5wOVR
         v73A==
X-Gm-Message-State: AOAM533pbJGAIgbEXzh1jd2SptFEdSlGtPR1OsFODKx2TJifp8UF2pJA
        aJp8XOzp0k+Pjd1O1RPuFplzvf8PfZ/SZU0hDhvJ1BeH
X-Google-Smtp-Source: ABdhPJyZLFFEXkDS6eSWByTd3EJ2d3LpH3HJU73Fy9w0FM6NuPDoD/zYkikmDtQgrFfXK+ECtgkRj3uO0lIhrY/2HIE=
X-Received: by 2002:aa7:9727:0:b0:47b:e175:2320 with SMTP id
 k7-20020aa79727000000b0047be1752320mr16610032pfg.77.1635220932289; Mon, 25
 Oct 2021 21:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAF7Jse9d9s0gFAi_bF3=ShE3FZw6k4X_nvDyGJkLRG7cDPDKCQ@mail.gmail.com>
In-Reply-To: <CAF7Jse9d9s0gFAi_bF3=ShE3FZw6k4X_nvDyGJkLRG7cDPDKCQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 25 Oct 2021 21:02:01 -0700
Message-ID: <CAADnVQJaRgQOA=hghLOwREYc=ebxMBPsRdBRZLNdZ4HV5xu7Zg@mail.gmail.com>
Subject: Re: [bpf-next] bpf, verifier: Automated formal verification tool for
 finding bugs in eBPF verifier range analysis routines
To:     Sanjit Bhat <sanjit.bhat@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, hovav@cs.utexas.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 9:19 AM Sanjit Bhat <sanjit.bhat@gmail.com> wrote:
>
> I=E2=80=99m Sanjit Bhat, a researcher at UT Austin. My advisor, Hovav Sha=
cham,
> and I have been working on a tool to enable developers to
> automatically check the eBPF verifier=E2=80=99s range analysis routines f=
or
> bugs, to generate sample bad inputs if bugs exist, and to formally
> prove that there are no range analysis bugs. We=E2=80=99re reaching out t=
o get
> your feedback on whether there would be interest in using our tool.
>
> Some more details about what the tool does:
>
> We verify the range analysis routines in the eBPF verifier. These
> routines predict the output range of ALU operations on scalar
> registers. They include all code touched from the
> `adjust_scalar_min_max_vals` function in `verifier.c`, as well as the
> functions in `tnum.c`. In the past, these routines have led to a few
> CVE=E2=80=99s, e.g., CVE-2020-8835, CVE-2020-27194, and CVE-2021-3490. Ou=
r
> tool, written purely in Python, translates the C range analysis code
> to Z3 SMT solver inputs and verifies that the code implements a
> correct range analysis pass for all 32- and 64-bit ALU operations on
> scalar registers. Our tool already produces some interesting results,
> described below, but we=E2=80=99re still actively working on it. We would=
 love
> your thoughts on ways we could make it more useful.
>
> Some preliminary results:
>
> We analyzed commit bc895e8b, which made a small change to the
> `signed_sub_overflows` function from 32-bit inputs to 64-bit inputs.
> Our tool found that before the commit, range analysis of 64-bit
> scalar-scalar subtraction was incorrect. The tool generated a BPF
> program that exploits the bug and leaves a register that has a
> concrete value outside the register=E2=80=99s tracked range. After applyi=
ng
> the patch, the tool determined that 64-bit subtraction was now
> correct. In addition to this bug, we were able to re-find bugs
> exploited in prior zero-days, and we=E2=80=99ve done preliminary analysis=
 on
> all verifier range analysis ops on a commit from back in May.
>
> Please let us know if this tool sounds interesting! We would be happy
> to explain it in more detail and collaborate on using it to aid eBPF
> verifier development.

It certainly sounds interesting! Keep us posted on the progress.
Do you plan to do forward analysis and find bugs proactively?
It sounds like the tool can only analyze the past commits?
Could you contribute the auto-generated progs as selftests?

Thanks!
