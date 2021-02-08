Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE9313DAE
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 19:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhBHShU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 13:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhBHSgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 13:36:37 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908DAC061788
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 10:35:57 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id r2so15547259ybk.11
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 10:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1wxRiTO8ubNVVrfqw9Xe5O/E3eDCn+UH9OcnEuIlp0=;
        b=JOoJrvQAUO9Kfe3P/BTMf3haT/v/Oe8mu32mPHUGdlJHOReAPnfbhn197uZ+BOoCvR
         HekYWSy3PfmUG8s8oyY1Hp35FGW3RnB1UG+YHSuW8dJRHnRTyiDRZwsHClwGfkPWsOeG
         E1TeP+EFfuA3/moWWYSrrLy67bcB1qOXdAYLJwfYiZ8mBpYKf4sjwvJ3/cm8olyOsPLY
         vlY9JH+dgG728lvEAdjnrEbgA08Lcr8Apehafnzyg6IlFLGTCLPdirBk7F+Bph9LKRwu
         4DfXILbCPFV2zz0Bo9kNrq9D4CDHOvwUCYRB2lKrYdcfC8J6vKk2W20bO/H8VRSdcTVM
         YIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1wxRiTO8ubNVVrfqw9Xe5O/E3eDCn+UH9OcnEuIlp0=;
        b=Mew9gh8pfyMC5WDSutBJY9DROk079WtwnMHdlymdqbMZzNAN33UmtR+Xbgp+rjghgw
         lQPphVUxowKAM0PBECWC2jgHdozCydwhBowVpV90yKBNRR1xJr0mtS0DDLApjMggmynC
         9pyNBiptKx7QNM7mfdq62qi7+8fG7EZjufuDibbTMkDtB2EnEzlztnF2PqKR5HZX7udP
         D0r1MpYgFBvQGn5lsk3DOZnBQdCnY4Cb02GFevdyAOO6ff/WcRrwrJVvTUyzZnqGcyEe
         qEEVc2R1aFD6h7ZqQz02zTX16Z8Kp8HqWF8y9p8YbI4spfcc81Mp/AbqqDwKyl6/WCOG
         ggiQ==
X-Gm-Message-State: AOAM530PBNPNMrbVEwR7g0TmMviaH74wPl3MVh1kVmx3t4yuRGufruIf
        F4vr30rS+l5Rt24KouTRMSLS6CQYJ6CBEifosXE=
X-Google-Smtp-Source: ABdhPJwj84AZpEcTPx+68Ywmv5sRUVo/siF31npx/kAX1lkGAlEAj73jnBYE8AqiFVqL6/nQiSmhnMevA591Ry5h0Uc=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr27142359yba.403.1612809356965;
 Mon, 08 Feb 2021 10:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234836.1629791-1-yhs@fb.com>
In-Reply-To: <20210204234836.1629791-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 10:35:46 -0800
Message-ID: <CAEf4BzZoLT1vtS--mfZ4XJQ-HRwhbY3pxzN-2xci9FUkPqRwqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: add arraymap test for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
>
> A test is added for arraymap and percpu arraymap. The test also
> exercises the early return for the helper which does not
> traverse all elements.
>     $ ./test_progs -n 44
>     #44/1 hash_map:OK
>     #44/2 array_map:OK
>     #44 for_each:OK
>     Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/for_each.c       | 54 ++++++++++++++
>  .../bpf/progs/for_each_array_map_elem.c       | 71 +++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
>

[...]

> +
> +       arraymap_fd = bpf_map__fd(skel->maps.arraymap);
> +       expected_total = 0;
> +       max_entries = bpf_map__max_entries(skel->maps.arraymap);
> +       for (i = 0; i < max_entries; i++) {
> +               key = i;
> +               val = i + 1;
> +               /* skip the last iteration for expected total */
> +               if (i != max_entries - 1)
> +                       expected_total += val;
> +               err = bpf_map_update_elem(arraymap_fd, &key, &val, BPF_ANY);
> +               if (CHECK(err, "map_update", "map_update failed\n"))
> +                       goto out;
> +       }
> +
> +       num_cpus = bpf_num_possible_cpus();
> +        percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);

formatting is off, please check with checkfile.pl


> +        percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
> +        if (CHECK_FAIL(!percpu_valbuf))

please don't use CHECK_FAIL, ASSERT_PTR_OK would work nicely here

> +                goto out;
> +
> +       key = 0;
> +        for (i = 0; i < num_cpus; i++)
> +                percpu_valbuf[i] = i + 1;
> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
> +       if (CHECK(err, "percpu_map_update", "map_update failed\n"))
> +               goto out;
> +
> +       do_dummy_read(skel->progs.dump_task);

see previous patch, iter/tasks seems like an overkill for these tests

> +
> +       ASSERT_EQ(skel->bss->called, 1, "called");
> +       ASSERT_EQ(skel->bss->arraymap_output, expected_total, "array_output");
> +       ASSERT_EQ(skel->bss->cpu + 1, skel->bss->percpu_val, "percpu_val");
> +
> +out:
> +       free(percpu_valbuf);
> +       for_each_array_map_elem__destroy(skel);
> +}
> +

[...]

> +SEC("iter/task")
> +int dump_task(struct bpf_iter__task *ctx)
> +{
> +       struct seq_file *seq =  ctx->meta->seq;
> +       struct task_struct *task = ctx->task;
> +       struct callback_ctx data;
> +
> +       /* only call once */
> +       if (called > 0)
> +               return 0;
> +
> +       called++;
> +
> +       data.output = 0;
> +       bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
> +       arraymap_output = data.output;
> +
> +       bpf_for_each_map_elem(&percpu_map, check_percpu_elem, 0, 0);

nit: NULL, 0 ?

> +
> +       return 0;
> +}
> --
> 2.24.1
>
