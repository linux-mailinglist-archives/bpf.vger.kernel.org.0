Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFDC6020D7
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 04:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJRCF4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 22:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJRCFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 22:05:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7288E0EC;
        Mon, 17 Oct 2022 19:03:57 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a14-20020a9d470e000000b00661b66a5393so6855479otf.11;
        Mon, 17 Oct 2022 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxTl7Pvn0Bec2shpwvEv5s8beVffTT/3S32nRS/mxsA=;
        b=BEmwZ/RYC149NHygsqHnZCK+2kx6DTG2aDAJrgSbLxkLMwP7pNNyoR0nvmuAXntAEP
         7jh0euTa7iBRNu/YKNQOi3JbO2r78uOaYbjkvMexAhKwkONmdq1YEovev48dSoaa6EKp
         uQa9EXAR0E2SaV5f8Y3nJW7cW3T7BvPM23UjZ0gU3ropuLsDiPqqllTPI/C3agDHWWAM
         cp3EBmroAKDfJPwiaY2TMto0V1T4wEwV9rcgv6oi/q+t3AqG+kwxGPtgdlbz6j5ZzTk7
         epBhjkX+xBVzejJn+DqAH8c1L4Y/zUTDji6JetE5sfm77p0FPUINPFBUupodaYnF8txk
         p0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxTl7Pvn0Bec2shpwvEv5s8beVffTT/3S32nRS/mxsA=;
        b=wWCiwwazlkoaNUvlcr3Ch30tBoYCtJa/X/lVK2TNG6BoFPo+9SarYjq2ztRzOMXIrn
         ZJiy7FIDLrC0Fd2uUvWdmfT3s7YwXfIaJ/GeH588K0QHLXFQKfQXhrIvSb5zAkJXKvaO
         mz0yK5uxehGYVsZhkOp0hqswnSBvEmGujaUALYZMlFs5ah4EE1cRwnS0dsK3LUITYmUB
         HRjMxdDg4KrosJUF6907YEaMq5aQmNytXT8OuU4mNOnQzyEZHnUWfCPR0pBVCYBKGhse
         1jKBx41u+HbA8XycV1t93h5qKV89MIp+2LgPkdEaLMNOum8u8BRbSwKdZGz4Tbs8KJsz
         0bjQ==
X-Gm-Message-State: ACrzQf0aZWesLUNZ7qfHtwk6+WbMExlhqpFUlkYcFOSJMLF7e6HWXyI0
        4xAAxNWHLHoaHLK3TaYdZHG1npYn3gFEegPHGxM=
X-Google-Smtp-Source: AMsMyM6YDyKg2qVy2VCwY4Wi8lkdnmdfkZsxSGCbhiZod/qb5zyMSTDdGcySP9NXBcuBz/yH2N+opeRkeqB+/UssNjg=
X-Received: by 2002:a9d:156:0:b0:661:c2eb:9da5 with SMTP id
 80-20020a9d0156000000b00661c2eb9da5mr363065otu.326.1666058626727; Mon, 17 Oct
 2022 19:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221014201427.2435461-1-void@manifault.com> <20221014201427.2435461-4-void@manifault.com>
 <CAP01T77PTK+bD2mBrxJShKNPhEypT2+nSHcr3=uuJbrghv_wFg@mail.gmail.com>
In-Reply-To: <CAP01T77PTK+bD2mBrxJShKNPhEypT2+nSHcr3=uuJbrghv_wFg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 18 Oct 2022 07:33:06 +0530
Message-ID: <CAP01T747PKC2jySOZCWu_gauHbBfaj4JE=hbtm4Z4C-Y8b3ZHg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] bpf/selftests: Add selftests for new task kfuncs
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org
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

On Tue, 18 Oct 2022 at 07:23, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Sat, 15 Oct 2022 at 01:45, David Vernet <void@manifault.com> wrote:
> >
> > A previous change added a series of kfuncs for storing struct
> > task_struct objects as referenced kptrs. This patch adds a new
> > task_kfunc test suite for validating their expected behavior.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> > [...]
> > +
> > +SEC("tp_btf/task_newtask")
> > +int BPF_PROG(task_kfunc_acquire_trusted_nested, struct task_struct *task, u64 clone_flags)
> > +{
> > +       struct task_struct *acquired;
> > +
> > +       if (!is_test_kfunc_task())
> > +               return 0;
> > +
> > +       /* Can't invoke bpf_task_acquire() on a trusted pointer at a nonzero offset. */
> > +       acquired = bpf_task_acquire(task->last_wakee);
>
> The comment is incorrect, that would be &task->last_wakee instead,
> this is PTR_TO_BTF_ID | PTR_NESTED.
>
> > +       if (!acquired)
> > +               return 0;
> > +       bpf_task_release(acquired);
> > +
> > +       return 0;
> > +}
> > +
> > [...]
> > +
> > +static int test_acquire_release(struct task_struct *task)
> > +{
> > +       struct task_struct *acquired;
> > +
> > +       acquired = bpf_task_acquire(task);
>
> Unfortunately a side effect of this change is that now since
> PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
> functions would begin working with tp_btf args. That probably needs to
> be fixed so that they reject them (ideally with a failing test case to
> make sure it doesn't resurface), probably with a new suffix __ref/or
> __owned as added here [0].
>
> Alexei, since you've suggested avoiding adding that suffix, do you see
> any other way out here?
> It's questionable whether bpf_ct_set_timeout/status should work for CT
> not owned by the BPF program.
>
>   [0]: https://lore.kernel.org/bpf/dfb859a6b76a9234baa194e795ae89cb7ca5694b.1662383493.git.lorenzo@kernel.org
>

Sorry for accidentally bumping this v3 thread instead of v5, whosoever
replies please continue there.
