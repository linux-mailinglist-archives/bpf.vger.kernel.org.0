Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3760209E
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 03:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJRByG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 21:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJRByF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 21:54:05 -0400
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com [IPv6:2001:4860:4864:20::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19D9726A5;
        Mon, 17 Oct 2022 18:54:04 -0700 (PDT)
Received: by mail-oa1-x41.google.com with SMTP id 586e51a60fabf-1364357a691so15321511fac.7;
        Mon, 17 Oct 2022 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WW27PHINhmqz572mOzgv19LUc9CSwt2ngmBxIUlALDI=;
        b=B9LbLcI/GWyvGFXVgyafDTUNgzSGSerULnta25D63wM5fGW9nKy99y/ISV9TXdaVDK
         94kqihaM+fSRq6vAmoqk+cP9RxHFy3XoZK4/3loDDfVMRi0trJlXY7jyZ9oIejQGwmyx
         fw8ESLKWtH/5rz1GA7gPkUzDxieFvXgiIga4ilrBlZngBlBBPb/ouSkpQD8sViZPmvDx
         SPj1gyo/T+wpDdwDh7kbgyAEqmlgfQf/SXrEFrFJOWDkapgOvLSIZ2ZE6NI5OUNNzgQA
         AzpI5ZCUVAuIeDxrnGd8lLhHO6RkuGNRTwXri3hppLCKtk8xbNETVmeUw03cxEbr/Sba
         S5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WW27PHINhmqz572mOzgv19LUc9CSwt2ngmBxIUlALDI=;
        b=YTIc5Pnsu0Tl1W+OqqToEXNj2KVz2fe8tLAxcKKtiuxuI5lgmXi4I5Fs7g2jLfSobG
         ddy4bEqkz7tqeFccPfRpJ1k1TPd9EY+i3zwT69b0ROy/tB9VM9vXE8Pwdz6iJDoYgdeB
         vG/adPNH55YYffO6TopFqDCOSv0xeQw/7v3ua7kkT7BUYrax48y16Lj3AXpjRfos3C3T
         wGpeYr+n13d5X787UWDO6oSGEIL0t6zZCVK5ghI8hrgR1M28xb1Sdg99nYsNV2AHTlyq
         GF1J9sAKFaypqwd6ZN3weE8mJf/rET8rqfnktnE0ZUz2t07nPLaxCFwSrbMevMqLzAb9
         94HA==
X-Gm-Message-State: ACrzQf3/VwqT6lXatFO6+Iwszd4PjsFa5xHQmHBXEoz2cS7UY3QoGMCd
        GIJjicHniIkvBnW5ZdINka8pp0lQtXaQmC+/Sjk=
X-Google-Smtp-Source: AMsMyM4upC6ziRrHwqkb2Lh/VuXdUG6L+Y8YTZZbW4Nj5zACo57fiTfzwURvRb2GXa6IUtJwKkN6CGKD/IyqgdOnz74=
X-Received: by 2002:a05:6870:178e:b0:126:7055:fc78 with SMTP id
 r14-20020a056870178e00b001267055fc78mr406594oae.58.1666058043995; Mon, 17 Oct
 2022 18:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221014201427.2435461-1-void@manifault.com> <20221014201427.2435461-4-void@manifault.com>
In-Reply-To: <20221014201427.2435461-4-void@manifault.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 18 Oct 2022 07:23:23 +0530
Message-ID: <CAP01T77PTK+bD2mBrxJShKNPhEypT2+nSHcr3=uuJbrghv_wFg@mail.gmail.com>
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

On Sat, 15 Oct 2022 at 01:45, David Vernet <void@manifault.com> wrote:
>
> A previous change added a series of kfuncs for storing struct
> task_struct objects as referenced kptrs. This patch adds a new
> task_kfunc test suite for validating their expected behavior.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
> [...]
> +
> +SEC("tp_btf/task_newtask")
> +int BPF_PROG(task_kfunc_acquire_trusted_nested, struct task_struct *task, u64 clone_flags)
> +{
> +       struct task_struct *acquired;
> +
> +       if (!is_test_kfunc_task())
> +               return 0;
> +
> +       /* Can't invoke bpf_task_acquire() on a trusted pointer at a nonzero offset. */
> +       acquired = bpf_task_acquire(task->last_wakee);

The comment is incorrect, that would be &task->last_wakee instead,
this is PTR_TO_BTF_ID | PTR_NESTED.

> +       if (!acquired)
> +               return 0;
> +       bpf_task_release(acquired);
> +
> +       return 0;
> +}
> +
> [...]
> +
> +static int test_acquire_release(struct task_struct *task)
> +{
> +       struct task_struct *acquired;
> +
> +       acquired = bpf_task_acquire(task);

Unfortunately a side effect of this change is that now since
PTR_TO_BTF_ID without ref_obj_id is considered trusted, the bpf_ct_*
functions would begin working with tp_btf args. That probably needs to
be fixed so that they reject them (ideally with a failing test case to
make sure it doesn't resurface), probably with a new suffix __ref/or
__owned as added here [0].

Alexei, since you've suggested avoiding adding that suffix, do you see
any other way out here?
It's questionable whether bpf_ct_set_timeout/status should work for CT
not owned by the BPF program.

  [0]: https://lore.kernel.org/bpf/dfb859a6b76a9234baa194e795ae89cb7ca5694b.1662383493.git.lorenzo@kernel.org

> +       if (!acquired) {
> +               err = 1;
> +               return 0;
> +       }
> +
> +       bpf_task_release(acquired);
> +
> +       return 0;
> +}
> +
> [...]
