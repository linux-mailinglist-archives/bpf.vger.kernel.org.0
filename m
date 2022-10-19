Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE8F603712
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJSAXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJSAXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 20:23:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF8DAC4E
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:23:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d26so36213654eje.10
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TV5B6hRLohgqoZZ33aceSX7uyQKt4JbC1XADWgLvU1k=;
        b=N4ju341+90/yMrpVbFILxBo755VRGHoFoMRzQrqsb1vyTpX9cq5oLmKBMqVXCmlZ3R
         kXE+l0bt9aJW3ixsKU8iGPZB9Z0NxxiBlNYROHvq/OgH5jXpcZnvbMPNYiA4ZFwxdhM7
         OCt0AwNMdeX5slWGzt2TEaldV4aQy2gAKWuxeF0bxvStfBPOIGtKP3A3wWKMwpQ/Nx7Z
         qqfq+jODleUfgFFQourSykMCz/4qwbME1t9L1PuGYn4pQXa5ZogFTV8bqpHHry7S+8Mq
         DhU6GbR2lCr58a/YZoGl6IO9GkpvI4gkazEBb6nKGWOPDmUGZNy2F1TXdFD1wgR3annR
         MN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV5B6hRLohgqoZZ33aceSX7uyQKt4JbC1XADWgLvU1k=;
        b=ccC48v6IjnixRUQf+e3s2Mo9VVrWHi91RiAcK65SqXjgPKdXFlWh+QvDKOQmDnNNCf
         qhOVrPBuhF4xPCy+FziLRRn/8lc7Z+1YJMaJ8wEiEnlOz9I4pOw/z+yDWhVo4/SPwirS
         LciiZAOKbDWb0C7ayUAMCcci83K76+gEzkhzO6/idiy/Ou0WmPycQXrdVf9Jm3Eu9wQ2
         UgHcI6dyxVN3/l2qusu49CX1aQy97wJ85A31ooB/JMBfnfYEx5QlX22WxhMUstVlmZNe
         4+QnTD1JsHg7/yk1xD2yMbr3UmbN17Ke19pOc47q5G5rZw6q2001iS6YQo6eJ6wPIiBj
         ZptA==
X-Gm-Message-State: ACrzQf0MX+FM2htgtjy5vWTmpUEt5yhAFXMX83lVAIzYft7RNVesnvv6
        PB1aQ8BMdBCKqj3Ix7I5/L7G95Ui/aCOX73c6QM=
X-Google-Smtp-Source: AMsMyM6wkyASBuI/Uf3Cl149V16Rd54tC2KWi6AM0ACvEPgfN7A3N3vNaijNgVmSRw8jiz+Ut/kqLLZHH/E6xShvAwE=
X-Received: by 2002:a17:906:dc8f:b0:78d:f675:226 with SMTP id
 cs15-20020a170906dc8f00b0078df6750226mr4521238ejc.745.1666139011535; Tue, 18
 Oct 2022 17:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <f7ee957a031f746400b97b6fc7730fda21bdb742.camel@fb.com>
In-Reply-To: <f7ee957a031f746400b97b6fc7730fda21bdb742.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Oct 2022 17:23:19 -0700
Message-ID: <CAEf4BzbMC_J+YUsO8YpcWGpWK9k2=EMM_bfdq6ZxCPZEWwzf6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
To:     Delyan Kratunov <delyank@meta.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Tue, Oct 18, 2022 at 4:25 PM Delyan Kratunov <delyank@meta.com> wrote:
>
> BPF CI has revealed flakiness in the task_local_storage/exit_creds test.
> The failure point in CI [1] is that null_ptr_count is equal to 0,
> which indicates that the program hasn't run yet. This points to the
> kern_sync_rcu (sys_membarrier -> synchronize_rcu underneath) not
> waiting sufficiently.
>
> Indeed, synchronize_rcu only waits for read-side sections that started
> before the call. If the program execution starts *during* the
> synchronize_rcu invocation (due to, say, preemption), the test won't
> wait long enough.
>
> As a speculative fix, make the synchornize_rcu calls in a loop until
> an explicit run counter has gone up.
>
>   [1]: https://github.com/kernel-patches/bpf/actions/runs/3268263235/jobs/5374940791
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  .../selftests/bpf/prog_tests/task_local_storage.c     | 11 +++++++++--
>  .../bpf/progs/task_local_storage_exit_creds.c         |  3 +++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 035c263aab1b..4e2e3293c914 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -53,8 +53,15 @@ static void test_exit_creds(void)
>         if (CHECK_FAIL(system("ls > /dev/null")))
>                 goto out;
>
> -       /* sync rcu to make sure exit_creds() is called for "ls" */
> -       kern_sync_rcu();
> +       /* kern_sync_rcu is not enough on its own as the read section we want
> +        * to wait for may start after we enter synchronize_rcu, so our call
> +        * won't wait for the section to finish. Loop on the run counter
> +        * as well to ensure the program has run.
> +        */
> +       do {
> +               kern_sync_rcu();
> +       } while (__atomic_load_n(&skel->bss->run_count, __ATOMIC_SEQ_CST) == 0);

let's also add some big enough max counter here to avoid being stuck
if something about test breaks and we actually never trigger the
program?

> +
>         ASSERT_EQ(skel->bss->valid_ptr_count, 0, "valid_ptr_count");
>         ASSERT_NEQ(skel->bss->null_ptr_count, 0, "null_ptr_count");
>  out:
> diff --git a/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c b/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
> index 81758c0aef99..41d88ed222ff 100644
> --- a/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
> +++ b/tools/testing/selftests/bpf/progs/task_local_storage_exit_creds.c
> @@ -14,6 +14,7 @@ struct {
>         __type(value, __u64);
>  } task_storage SEC(".maps");
>
> +int run_count = 0;
>  int valid_ptr_count = 0;
>  int null_ptr_count = 0;
>
> @@ -28,5 +29,7 @@ int BPF_PROG(trace_exit_creds, struct task_struct *task)
>                 __sync_fetch_and_add(&valid_ptr_count, 1);
>         else
>                 __sync_fetch_and_add(&null_ptr_count, 1);
> +
> +       __sync_fetch_and_add(&run_count, 1);
>         return 0;
>  }
> --
> 2.37.3
