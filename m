Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8188E4D103C
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 07:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiCHG3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 01:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiCHG3Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 01:29:16 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250436E0B
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 22:28:19 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id b16so5503221ioz.3
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 22:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZ0dLHELZfeWq3yQE1BjMkvxxie9VvWlILUqaqqAKaQ=;
        b=SupgMiDEUNkCXvdZEXZa1muzJJ5Uaz8X6LD/jHdo4UZdOBOuQk/0PgpucWYjX3B+eP
         dunS3S8fqyO5XwcQ5irM86hYSj3cniTLl7QV99trTiuv3ow2TaNtZtSibW7WG5x559/1
         k/Kwba9l68gP9/ZSMA2bi/UVIW73d/kZZkjX81cKnC8iAD1q96IVxyP7gnI3QGxiDtvd
         IBKaax9UE558n6kNcP1ZBaOJo7WTYy2HFbPsfBfOCStVOJLbqq5mr/9z8Cr064GUAL7X
         Pg3Qy/M1gqRiP03mg9IKO6Yv+qHeNpKYILqDJN1ubbS/VSV0BJzJ1h0FV0MbQM38GeIr
         TJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZ0dLHELZfeWq3yQE1BjMkvxxie9VvWlILUqaqqAKaQ=;
        b=rEqNIS8ZWUD2x5gTJM3ACxq7jquiG+RAN+zskLL4jwcz+cA4OMAi/ZWiePFwZ6lkN9
         48w2ZDGh9VieSKi60Fj7u1giiKhutQDQiMO07TfE3Hj8+QDie0kvvWZqZbjXqJ8EQSJm
         EVAZ8ujKFNTKnGL5t1jqbU21oqyNMY82+Je4BanD8b8MqSmLHU7q5uw2u/bp8gV9sZNn
         bt9ifHda0vrkh0TuXQqd6si1Uvdl4aP5UWYPV3XGOQvYMD8Xc9qjPYrJKENzMIYC3n8l
         MBnS3K4AUwoADXCQused79AbfgeTIw/9SaMbip/KwqS9aQt0bGC0nF+kIXXOxAoWdIh6
         0Hpg==
X-Gm-Message-State: AOAM531leHYz9xge6Sv1uuF+t+7MR1Ptr4vqY8vu6YTNi6UkTabJvDvc
        8oYoYwaV2KE/t15XZ5hY8VrEQwqyx+aD1FH4da+zyRnSPw0=
X-Google-Smtp-Source: ABdhPJyMPyyvA93d+2jM36vG4LK5UmG5ottZpnwNYjJjkT7Fm2AJ5T1yyd5PwbtIRg8VZezGs1QKkMGvdOvY2/bx2kQ=
X-Received: by 2002:a05:6602:1605:b0:644:d491:1bec with SMTP id
 x5-20020a056602160500b00644d4911becmr13306341iow.63.1646720898746; Mon, 07
 Mar 2022 22:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20220307133048.1287644-1-kpsingh@kernel.org>
In-Reply-To: <20220307133048.1287644-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Mar 2022 22:28:07 -0800
Message-ID: <CAEf4BzabX8nojj_saPyMMsX39gsP=yZGbSMmZXVUV02j6O5K-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/docs: Update vmtest docs for static linking
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Mar 7, 2022 at 5:30 AM KP Singh <kpsingh@kernel.org> wrote:
>
> Dynamic linking when compiling on the host can cause issues when the
> libc version does not match the one in the VM image. Update the
> docs to explain how to do this.
>
> Before:
>   ./vmtest.sh -- ./test_progs -t test_ima
>   ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
>
> After:
>
>   LDLIBS=-static ./vmtest.sh -- ./test_progs -t test_ima
>   test_ima:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/testing/selftests/bpf/README.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index d099d91adc3b..f7fa74448492 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -32,6 +32,14 @@ For more information on about using the script, run:
>
>    $ tools/testing/selftests/bpf/vmtest.sh -h
>
> +Incase of linker errors when running selftests, try using static linking:

fixed typo here and pushed to bpf-next.

It would still be good to fix the use of LDFLAGS, of course ;)

> +
> +.. code-block:: console
> +
> +  $ LDLIBS=-static vmtest.sh
> +
> +.. note:: Some distros may not support static linking.
> +
>  .. note:: The script uses pahole and clang based on host environment setting.
>            If you want to change pahole and llvm, you can change `PATH` environment
>            variable in the beginning of script.
> --
> 2.35.1.616.g0bdcbb4464-goog
>
