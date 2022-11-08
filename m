Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BF622017
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 00:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKHXI5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 18:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKHXI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 18:08:56 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1D1D32A
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 15:08:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y14so42423471ejd.9
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xShCMhCXPuEy3Po4sgncjutUracDoMujeXtTY0rilc=;
        b=fL/jV1YuVe7SXgV1Nc0syF4HUra4Yab9rTtmrnQrKQtpqBZcSE5e2G3RKrvXIDopj2
         hnnN1VbZ+fpeNq91yLih1Yf7s/xza2mls1ctERnE7Mfrcegzj8Jh+cD2W4v4EuHK+aF+
         t0U1jCe2q29Lt3sqrA1FYNmxhFAd/5s1oRWe8Bvv3iVOYWb6gWstJLJCbsEfssp1z98s
         0ukQublNSfHG7j+AveVFZE49fWy+S9uOcyPC0HgtY0Ck/EZcpZk8Pg7VhRpSZ4RZlwUc
         ZjYB+qyVf+xQvdm4czJ/VAnSShunJILa6jPSZFzkzI1l1UT2UiE3iZQr+hCedh+HWynL
         MpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xShCMhCXPuEy3Po4sgncjutUracDoMujeXtTY0rilc=;
        b=0rMl+ea1LBKD2stQ3ZnGpj199Hh2gpvfmObNfdN3pfZfayJVTMKywX8tnwlvXhofz5
         2AHYPgQctqxq1Fc1lQcFTovJnYkZNHctrenhR9GgxhAJdgmvocFYTJ/xmrt0NFlDDzpq
         6XqnGYqJa+qfpwhBwxPujKE9fc+8mjy3r7w6t6QT3QFFJEzZtxVAuA7j8R68+kFnJ8rB
         fc0UVhv379JiBnEvIwnwin2Oq6nb31CL6wv64YrJzRAQC7xGh/6EuenChicfzTxTpKwH
         ISaXX8qsrWab4nsi7FjiQbRKfu4gUPFpu78pL6EMJ2+HVHpTAvMVhI8Wbcl1tR+pKckk
         aESg==
X-Gm-Message-State: ACrzQf3Vs2v3Wiv1uSVpV0j8cSgRt9AXvzHYIseL69C4eJWVVbgOpI2R
        xs/Vf54bbxArEquGoG6Cz2ShWwYzKc79Nr1xSic=
X-Google-Smtp-Source: AMsMyM6YJ47FMBDiqBif3n+C8O8Mb/rp7jwSDOZHNFg1mUQ8PboVaJarIkdlQkoEKKurWgk8v2H/Rv85hao9PySTJ6c=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr35576693eja.545.1667948931290; Tue, 08
 Nov 2022 15:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-5-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-5-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 15:08:39 -0800
Message-ID: <CAEf4BzaVDbU3wtm=Qee_D15Lh4ax2AR_ZxXHHAy5XZUD1YC_0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 04/25] bpf: Rename RET_PTR_TO_ALLOC_MEM
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Currently, the verifier has two return types, RET_PTR_TO_ALLOC_MEM, and
> RET_PTR_TO_ALLOC_MEM_OR_NULL, however the former is confusingly named to
> imply that it carries MEM_ALLOC, while only the latter does. This causes
> confusion during code review leading to conclusions like that the return
> value of RET_PTR_TO_DYNPTR_MEM_OR_NULL (which is RET_PTR_TO_ALLOC_MEM |
> PTR_MAYBE_NULL) may be consumable by bpf_ringbuf_{submit,commit}.
>
> Rename it to make it clear MEM_ALLOC needs to be tacked on top of
> RET_PTR_TO_MEM.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

The whole MEM_ALLOC as related to ringbuf is so confusing. Why can't
be just call it for what it is: RET_PTR_TO_RINGBUF_MEM_OR_NULL,
ARG_PTR_TO_RINGBUF_MEM, PTR_TO_RINGBUF_MEM ?

It would be also much easier to make sure (by looking at the code)
that ringbuf invariants are properly checked.

>  include/linux/bpf.h   | 6 +++---
>  kernel/bpf/verifier.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05f98e9e5c48..2fe3ec620d54 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -607,7 +607,7 @@ enum bpf_return_type {
>         RET_PTR_TO_SOCKET,              /* returns a pointer to a socket */
>         RET_PTR_TO_TCP_SOCK,            /* returns a pointer to a tcp_sock */
>         RET_PTR_TO_SOCK_COMMON,         /* returns a pointer to a sock_common */
> -       RET_PTR_TO_ALLOC_MEM,           /* returns a pointer to dynamically allocated memory */
> +       RET_PTR_TO_MEM,                 /* returns a pointer to memory */
>         RET_PTR_TO_MEM_OR_BTF_ID,       /* returns a pointer to a valid memory or a btf_id */
>         RET_PTR_TO_BTF_ID,              /* returns a pointer to a btf_id */
>         __BPF_RET_TYPE_MAX,
> @@ -617,8 +617,8 @@ enum bpf_return_type {
>         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
>         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
>         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
> -       RET_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
> -       RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
> +       RET_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_MEM,
> +       RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
>         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
>
>         /* This must be the last entry. Its purpose is to ensure the enum is
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0374f03d1f56..2407e3b179ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7621,7 +7621,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 mark_reg_known_zero(env, regs, BPF_REG_0);
>                 regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
>                 break;
> -       case RET_PTR_TO_ALLOC_MEM:
> +       case RET_PTR_TO_MEM:
>                 mark_reg_known_zero(env, regs, BPF_REG_0);
>                 regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
>                 regs[BPF_REG_0].mem_size = meta.mem_size;
> --
> 2.38.1
>
