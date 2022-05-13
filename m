Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527AF525A57
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355420AbiEMDp0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 23:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347398AbiEMDpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 23:45:24 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15682274A1B
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:45:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j12so4854431ila.12
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcPOH1PTTZP0aG6fXK1GmLrxoMS5AarW0j+AvBHcsCs=;
        b=nfVPH5j6xxLnYhetPViHKoplkdvQicISj7+Rjh/RLlaJNb5j5w2q96bpWXt0mJD0eU
         0dK0mrluTxW70ADvc1c+AyWbYoLaluq0ML7g00v0yytcbjHA3ZZOxvViUoWFAnKfMuhJ
         KQSt8u4qyzDPaxeI4pfHOuoi2gwy9+symj9C/RqWk8CD24QcraX6j6kgOCX9BOIsfwVn
         S7jPcvpQfM5osKg8bSGKF1s1LMJ+t/QUeYFkQSqaYZRNV0rLpNMjouz6P5KhARFJv183
         mFWmSmBAxrf24m8Y2K9qhOPobxSAeD7/eBpo4BEWqzZxSBM15WQKckDXuFJNMLf5R83C
         1biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcPOH1PTTZP0aG6fXK1GmLrxoMS5AarW0j+AvBHcsCs=;
        b=ItfOB9JD32T0p23pob2wAzhnXgvJ2VP4PVk1i38cDEUS7gjRJAbYYLQQeWOS3D84Sk
         5qB4q8EFRgfjdiz+WOjrjpj7CdQhZl+2rIaeSWz7WlBNO0j6Qmqxq6/Rm0WYEsstMaBA
         iu8/uBif2QCafUmhv1JxrAbhX9LU53aNvPTpwUn992bjdJYyiAEUb5xGQRpyS1nfJl6M
         aNK1JM6jtcSHVlBzRS3pxFqvRaNjcS+Pd7qYDbIeXenJM+K7B2gwBaUyd0clbSMQ0PNy
         gXil3RZi6YTH9anJNaiIJMI+KyTAd5Jac9zHS2gIEgefR/9tXoNMccIHym/U3EbKpUSe
         Heew==
X-Gm-Message-State: AOAM530Vj1ItIYyDYAoBg8O8L/wVJ4fpuxvdSb+goI8pN6kJgQvYWa0p
        tK71LaI2GB2vou3mF8eRREsq+fFYJ/ORbBv1sRY=
X-Google-Smtp-Source: ABdhPJwyEHKBrRrGDHtGBr8x6LYFCgDRwqpUDidHdLRuf3lzTGkHmnd07/2Gq58Vs6xuTI/4JGYqqEcnBhxK0dv8cvI=
X-Received: by 2002:a05:6e02:1c03:b0:2cf:2a1d:d99c with SMTP id
 l3-20020a056e021c0300b002cf2a1dd99cmr1568512ilh.98.1652413522534; Thu, 12 May
 2022 20:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com> <20220513011025.13344-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20220513011025.13344-2-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 May 2022 20:45:11 -0700
Message-ID: <CAEf4Bza2o+U4rhk-ceueOKbQB6S=opWiZT67zhi62Ky061JT4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check combination of jit
 blinding and pointers to bpf subprogs.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, May 12, 2022 at 6:10 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Check that ld_imm64 with src_reg=1 (aka BPF_PSEUDO_FUNC) works
> with jit_blinding.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/progs/test_subprogs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_subprogs.c b/tools/testing/selftests/bpf/progs/test_subprogs.c
> index b7c37ca09544..f8e9256cf18d 100644
> --- a/tools/testing/selftests/bpf/progs/test_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/test_subprogs.c
> @@ -89,6 +89,11 @@ int prog2(void *ctx)
>         return 0;
>  }
>
> +static int empty_callback(__u32 index, void *data)
> +{
> +       return 0;
> +}
> +
>  /* prog3 has the same section name as prog1 */
>  SEC("raw_tp/sys_enter")
>  int prog3(void *ctx)
> @@ -98,6 +103,9 @@ int prog3(void *ctx)
>         if (!BPF_CORE_READ(t, pid) || !get_task_tgid((uintptr_t)t))
>                 return 1;
>
> +       /* test that ld_imm64 with BPF_PSEUDO_FUNC doesn't get blinded */
> +       bpf_loop(1, empty_callback, NULL, 0);
> +
>         res3 = sub3(5) + 6; /* (5 + 3 + (4 + 1)) + 6 = 19 */
>         return 0;
>  }
> --
> 2.30.2
>
