Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB08620256
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 23:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiKGWfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGWfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 17:35:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6BF17A9C
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 14:35:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id q9so34144171ejd.0
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=025TwlV6VzWspfNkIy9c/zr8Po3T1rQcYujD5rkNU7I=;
        b=gWnxLIBHDW7QE+X0YxY4yvPmD+ju8rW3QJ2PuN+y6Ibuv4c+6ktWqAMiYA0jIj2qzQ
         CWnGgVh8MuoKpstOQskBqaM+23eLqYDFJ7Qst2jqaZkR4wEHHBqJnvejbGYKLHFPLXGF
         f/N/HKJdv+pDZxe+gENm1h46aYOpzJltl1sYCNJ6zxjUokf+olnF4uRMTIN6gW4fGD1t
         Nz4vqwIixQOdnklxZpRHGu5n2U0ihAjwVUeYc1nZ6GCDKLZgskqpf8fPMftsy7orkLs0
         b1v3gKQkTM/oK6+QMKw+P3QlqNqipj9xi6s4tv1TecS3iRG3DgyP1HsMYATZnC/WtB7R
         tt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=025TwlV6VzWspfNkIy9c/zr8Po3T1rQcYujD5rkNU7I=;
        b=kt18yJHKWO14yPXg4Xf4YJSZoBEbn00GjD4JrMNOMAheG1dLASJOaQ2N1e7EIOSs6T
         yz4oSV8TcFCJOTuljwgWX6qcrCHHevuvwZ9qwoXfkWh1DM5jRPQpmNPOIzI/j6UkLRP/
         eZRKXYKnhkIAw3f4W9Ij6YpcAPtxiNThQ8TshSChUd23PTR6shkH2j/FSS2Wwl7VPB7u
         Dvbhqc+PdRL1rvEgZ8dPZqBkL5vXfNcGrW5Vc69dygm8H/Gf7IgZwna9JJ/0GQmElD5R
         cw/3ufyi5vW1H+zWD2f1bRacdhm298/jDyru21N4AxwptLB7Zc6zhL90CAKmJN2q/PmP
         toHg==
X-Gm-Message-State: ACrzQf2vut7HT/x4TMin4dUM14ECwyIIRrFgFk6NzHrNCPYjjWzaARJS
        jd/ZAUD1yF0tzZ8qy5Aw31hHsW626Zfpzb9M4fem8/LJaLA=
X-Google-Smtp-Source: AMsMyM6TvcZEi8U29QWtzMN078KDhxBGZbjadYX3MwyuA+m6+Go7SzjthjU+25GMA3f/qVstaL9TETrqyX36O3lV2MM=
X-Received: by 2002:a17:907:1dc7:b0:7ad:83d5:6abd with SMTP id
 og7-20020a1709071dc700b007ad83d56abdmr48069749ejc.412.1667860533679; Mon, 07
 Nov 2022 14:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-4-memxor@gmail.com>
In-Reply-To: <20221018135920.726360-4-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 7 Nov 2022 14:35:22 -0800
Message-ID: <CAJnrk1YV7rxE+y5ud9tNUS+e3d=5PkEpgXibBg38AwPdt0f_8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/13] bpf: Rename confusingly named RET_PTR_TO_ALLOC_MEM
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
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

On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
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
>  include/linux/bpf.h   | 6 +++---
>  kernel/bpf/verifier.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 13c6ff2de540..834276ba56c9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -538,7 +538,7 @@ enum bpf_return_type {
>         RET_PTR_TO_SOCKET,              /* returns a pointer to a socket */
>         RET_PTR_TO_TCP_SOCK,            /* returns a pointer to a tcp_sock */
>         RET_PTR_TO_SOCK_COMMON,         /* returns a pointer to a sock_common */
> -       RET_PTR_TO_ALLOC_MEM,           /* returns a pointer to dynamically allocated memory */
> +       RET_PTR_TO_MEM,                 /* returns a pointer to dynamically allocated memory */
>         RET_PTR_TO_MEM_OR_BTF_ID,       /* returns a pointer to a valid memory or a btf_id */
>         RET_PTR_TO_BTF_ID,              /* returns a pointer to a btf_id */
>         __BPF_RET_TYPE_MAX,
> @@ -548,8 +548,8 @@ enum bpf_return_type {
>         RET_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
>         RET_PTR_TO_TCP_SOCK_OR_NULL     = PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
>         RET_PTR_TO_SOCK_COMMON_OR_NULL  = PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
> -       RET_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
> -       RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
> +       RET_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_MEM,

Can you also rename this to RET_PTR_TO_RINGBUF_MEM_OR_NULL instead of
RET_PTR_TO_ALLOC_MEM_OR_NULL, and MEM_RINGBUF instead of MEM_ALLOC?
RET_PTR_TO_ALLOC_MEM_OR_NULL only pertains to ringbuf records, not
generic dynamically allocated memory, so I think this rename would
make this a lot more clear.

> +       RET_PTR_TO_DYNPTR_MEM_OR_NULL   = PTR_MAYBE_NULL | RET_PTR_TO_MEM,
>         RET_PTR_TO_BTF_ID_OR_NULL       = PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
>
>         /* This must be the last entry. Its purpose is to ensure the enum is
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 87d9cccd1623..a49b95c1af1b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7612,7 +7612,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 mark_reg_known_zero(env, regs, BPF_REG_0);
>                 regs[BPF_REG_0].type = PTR_TO_TCP_SOCK | ret_flag;
>                 break;
> -       case RET_PTR_TO_ALLOC_MEM:
> +       case RET_PTR_TO_MEM:
>                 mark_reg_known_zero(env, regs, BPF_REG_0);
>                 regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
>                 regs[BPF_REG_0].mem_size = meta.mem_size;
> --
> 2.38.0
>
