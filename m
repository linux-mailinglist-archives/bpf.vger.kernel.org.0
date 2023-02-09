Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F768FC5E
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjBIBGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjBIBGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:06:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B34F12F0B
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:06:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id rp23so2016532ejb.7
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbbHzi8xHNNqgK8nu7a66pFrpiCdCpe9BK4WvJWbq6U=;
        b=G/LqFOB0xxbekjxA3kiM9mCgh6rclgKPhb5OaYIuxRz4jTybRsqW9qmAQR2+kM6g5L
         cU0lwRz+nriGmC4hCu1F8sc91imF+TwZr+LEL955sUueJVQtgQbHy5IC4Xl18Ul11e3e
         AkY9MPeWbrXsxe5t1ft43NpkQBPy80TlcOmIJVsci0Ij84Ge/Ce7N/62heGdug+zPBlq
         7vJKH9nbJARyrCrMn8tNr/Cp+yOU/89udrDlpS7j59KDf/94MhreK7Pt5o3ZzxKsCtPQ
         zWYRQrb+zKKHrGcPOPHXJoOH1gh08QLItZoHYCNLe2svnR3VeCy/Rdq/KQQ6oANftdNg
         3O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbbHzi8xHNNqgK8nu7a66pFrpiCdCpe9BK4WvJWbq6U=;
        b=LzmbHOousajSl71UdsfRPewtxxCV+jbxLD6NWJ5SC0YOzb5tg8npFiXO+X+/qv5Gd7
         EFIxMbLlHTYpL1ieYtTG8nUr+F3ktzO8JwLQJa9gjAkdNMChZcHaEzML9R4GHooNxObD
         hIajjT1fgmYjf8h+LeG+2+9WkYkjONwKUWN0V40xZBtYoykOcm4nZFUUCaBrOQr07+aN
         q5QJQQSS+x2J9poKn4VAGcGXFdmbJWhtelCi7EmplOKnDXQywUcDZMGE/qy22x8mFYcK
         sCvPJcbVeX+0jBQ5qngNVZqdZ4w1a9cD9++1fEFvdCY0zDtZCjwQzcrU4Ci/AstSDifX
         1MVg==
X-Gm-Message-State: AO0yUKU1WIRzFvimBhH0S+G6pbobCAQywT3aXkYZ2s9TW2TRqjgEfMZw
        q+vJ9+7cNazMG0NAgJKQswI88Uotz559pXzNMQg=
X-Google-Smtp-Source: AK7set+sYimnbZBmG8bi1Q4pab5246FBycm3HIt8qGn2FMAUsWltHF3fndQK3Liy0ntRLCsKaAAFkxDlAAKDcEqwQok=
X-Received: by 2002:a17:906:5a60:b0:8aa:bdec:d9ae with SMTP id
 my32-20020a1709065a6000b008aabdecd9aemr1335539ejc.12.1675904776709; Wed, 08
 Feb 2023 17:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-7-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-7-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:06:04 -0800
Message-ID: <CAEf4BzZ-_0sC71U_u9sQ8bBU-KZFpF23W-UqJzecPGTMifMcFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/9] selftests/bpf: Attach to fopen()/fclose() in attach_probe
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> malloc() and free() may be completely replaced by sanitizers, use
> fopen() and fclose() instead.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 10 +++++-----
>  tools/testing/selftests/bpf/progs/test_attach_probe.c |  8 +++++---
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9566d9d2f6ee..56374c8b5436 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -33,8 +33,8 @@ void test_attach_probe(void)
>         struct test_attach_probe* skel;
>         ssize_t uprobe_offset, ref_ctr_offset;
>         struct bpf_link *uprobe_err_link;
> +       FILE *devnull;
>         bool legacy;
> -       char *mem;
>
>         /* Check if new-style kprobe/uprobe API is supported.
>          * Kernels that support new FD-based kprobe and uprobe BPF attachment
> @@ -147,7 +147,7 @@ void test_attach_probe(void)
>         /* test attach by name for a library function, using the library
>          * as the binary argument. libc.so.6 will be resolved via dlopen()/dlinfo().
>          */
> -       uprobe_opts.func_name = "malloc";
> +       uprobe_opts.func_name = "fopen";
>         uprobe_opts.retprobe = false;
>         skel->links.handle_uprobe_byname2 =
>                         bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_byname2,
> @@ -157,7 +157,7 @@ void test_attach_probe(void)
>         if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname2, "attach_uprobe_byname2"))
>                 goto cleanup;
>
> -       uprobe_opts.func_name = "free";
> +       uprobe_opts.func_name = "fclose";
>         uprobe_opts.retprobe = true;
>         skel->links.handle_uretprobe_byname2 =
>                         bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe_byname2,
> @@ -195,8 +195,8 @@ void test_attach_probe(void)
>         usleep(1);
>
>         /* trigger & validate shared library u[ret]probes attached by name */
> -       mem = malloc(1);
> -       free(mem);
> +       devnull = fopen("/dev/null", "r");
> +       fclose(devnull);
>
>         /* trigger & validate uprobe & uretprobe */
>         trigger_func();
> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> index a1e45fec8938..269a184c265c 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -94,10 +94,12 @@ int handle_uretprobe_byname(struct pt_regs *ctx)
>  SEC("uprobe")
>  int handle_uprobe_byname2(struct pt_regs *ctx)
>  {
> -       unsigned int size = PT_REGS_PARM1(ctx);
> +       void *mode_ptr = (void *)(long)PT_REGS_PARM2(ctx);

let's use BPF_UPROBE() macro instead of PT_REGS_xxx() calls?

> +       char mode[2] = {};
>
> -       /* verify malloc size */
> -       if (size == 1)
> +       /* verify fopen mode */
> +       bpf_probe_read_user(mode, sizeof(mode), mode_ptr);
> +       if (mode[0] == 'r' && mode[1] == 0)
>                 uprobe_byname2_res = 7;
>         return 0;
>  }
> --
> 2.39.1
>
