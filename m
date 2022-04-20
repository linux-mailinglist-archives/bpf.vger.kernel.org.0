Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3E508EEF
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiDTR7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbiDTR7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:59:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3185443F3
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:57:03 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i8so1486870ila.5
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVzGpN24p5e2F50RQXXQFs1aIndKUkAZr8zpZrZWiZ8=;
        b=JtaPxoA5saD5hgZi9vZ9IJPhJiOIsz+7avma5fsYVnCHqH/pdHkZZk0mkDPtr7bqQj
         cmspEnzEGK0NpbGanOohXAcV+C4IpM+F2LukrjzNe+P/zePcGiy8qGRq3ws8LSZsZWkc
         XvWteJ6UIPBL9jf+zZ6Ce6Zw6c3CPn9T4OYEijGLyDBInSKvrFHhIvJwh2x29HKf8Go5
         dBKDmEDqWPUVhA5FGxsmFewFeYjYfj4VWHrlMBgLRYbl2WVPju/2YIYOs2lR/Wia80iG
         X32Rpa8A5t+Z/1hT8t3DgUdlclKYKqb7RbTiBsdWmoAWUs0+B8E0LVqA6yGyaIOOwCEG
         4LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVzGpN24p5e2F50RQXXQFs1aIndKUkAZr8zpZrZWiZ8=;
        b=ZEZRprJhRzsVCC+A8j/jKNXnHauHl7cD0VUmpYPT0WZQbvZm0wGsPS7azhWGhbdo/+
         +IoI97gU+ZmAweStAv8+NoXryvKVqb8/OzJH96A3bSCsMmaadzFkRVOnFrEDUfy/PsDD
         jvQ9CsRKsm7a7Jm1lC2Bjpi9KQ20+L0al+i0cuAp9K6V1Pve3b+1B/dmBsa6BejVcp3/
         LEyFi0fatwODLk9vY6w7CWXcwqPZMKyHKLFQgiyIwN7REgnOy4OZWXS1HrrcNlphjJTr
         dqnV2h7YbLLmBvsHTwibb6xmn7E2AaSW9w2TrN/ABs/BTyZaPaeREDhCmaLhWzsdzNfH
         IvuQ==
X-Gm-Message-State: AOAM530BeouJeIRdDhjlpX3dfrYkBDXag7w6/KVdR2H/k8vfhJyjHYN/
        PAQ6vuleXwiBNEFXUXS5pTb5u4MQuSAStQkPCoIqvLjE
X-Google-Smtp-Source: ABdhPJz8BI+Ti7uN0BIBXZASaGocAlvunYwfIGzP8RIpLawGkNla+ajImgtC6+vLtdddOVF6kfjFp1jz7Sl5HbHtoJg=
X-Received: by 2002:a92:cd83:0:b0:2cc:1a66:6435 with SMTP id
 r3-20020a92cd83000000b002cc1a666435mr7506568ilb.252.1650477423430; Wed, 20
 Apr 2022 10:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220416042940.656344-1-kuifeng@fb.com> <20220416042940.656344-7-kuifeng@fb.com>
In-Reply-To: <20220416042940.656344-7-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Apr 2022 10:56:52 -0700
Message-ID: <CAEf4BzbDgX-Y7dCRkB61dM-NdK=iQS-=16_NBETWk=f4pvCQ3g@mail.gmail.com>
Subject: Re: [PATCH dwarves v6 6/6] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Fri, Apr 15, 2022 at 9:30 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Make sure BPF cookies are correct for fentry/fexit/fmod_ret.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c     | 53 +++++++++++++++++++
>  .../selftests/bpf/progs/test_bpf_cookie.c     | 40 +++++++++++---
>  2 files changed, 85 insertions(+), 8 deletions(-)
>

[...]

> -static void update(void *ctx, int *res)
> +static void update(void *ctx, __u64 *res)
>  {
>         if (my_tid != (u32)bpf_get_current_pid_tgid())
>                 return;
> @@ -82,4 +85,25 @@ int handle_pe(struct pt_regs *ctx)
>         return 0;
>  }
>
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry_test1, int a)
> +{
> +       update(ctx, &fentry_res);
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_fentry_test1")
> +int BPF_PROG(fexit_test1, int a, int ret)
> +{
> +       update(ctx, &fexit_res);
> +       return 0;
> +}
> +
> +SEC("fmod_ret/bpf_modify_return_test")
> +int BPF_PROG(fmod_ret_test, int _a, int *_b, int _ret)
> +{
> +       update(ctx, &fmod_ret_res);
> +       return 1234;
> +}
> +
>  char _license[] SEC("license") = "GPL";

would be great to add LSM and freplace (BPF_PROG_TYPE_EXT) tests as well

> --
> 2.30.2
>
