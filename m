Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A76290FB
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 04:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiKODx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 22:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiKODx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 22:53:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298A11A32
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:53:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a5so20109992edb.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qCb+H1aKdjS8OV1+GSYtbPZ2oW1lBxVM+lLaaRwwfE4=;
        b=XBNQSkL/62l4+8qS/JmpG8wk3jdUMqnqF3XbdgatLMEDZ+LwCHMQeBSovcUsW8wgnV
         1kEhjVQ1mUw8ggYV2lVhq04OzkSAqL2Hg92G9V0hhtoFSM/Ktzhy7nG1u2Z3X1KCKLv/
         TxZXajYxJD2TivlNxMBjP+b9wwOpdEPwii5n0ZgRqM7/Ko6D+vl42ZH0gPXE9eRWY6fW
         7Pn8A6VhGRuEm0OyrSltS69UBkPkKPmdrteKpT2CvoMTWlUZg4m99t62h02qz/dz/rtm
         Zka/BWMWGfQKiKkNB7sHmOUpD4XMQNKQ6gUKlRwQAYyG0KJqpSEkzERzhzBlmyNGh+bB
         em4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCb+H1aKdjS8OV1+GSYtbPZ2oW1lBxVM+lLaaRwwfE4=;
        b=OwD6e9s2bEzauqGpme6nZlcGIa+6k+Hun8CXlej0tQ4wE9hpzP95AYvGogDM8LpnYO
         gdId6lqxPqoY1HFglnBal2HoXBoNXSmi9LRHg7aOYbEF4CF8IMju6svhX/WXWKYwcVnD
         W6l8lnPiqJYpgYUcPsPZb6z+DpasnWXVznZHdmfUkDnv5py7+MMwvxqOMNwc3KkvDpBX
         /WCjCjoRO2LyRoe/dJV6WD30FNXVj0DoTO0VE0pPhJreD/H/ntbZJ9tVI1L0rVUvdo0C
         +ZaK+yiXO7kJd+iE9RaK2KtT2UUhhCZ4WjxzlaB5HgyT3Sq9n9J2iTPwngHB4YbO/biC
         2qhg==
X-Gm-Message-State: ANoB5pls61cVNNDTovAN7adzm4iNpVLcgIH7CAfu7KQLeWwfNI6ozm3T
        8wgVqXvZfrIkmcjZYeWVDEKd5BqhJiYFweaK2TM=
X-Google-Smtp-Source: AA0mqf6xnQDMTLTF0sZvmZaGVObt3CgQz4Ql5MVkvdYjqn86JTTgCIA2HLv1rMCbDy14HHL+Tv4xT+Jd1Y6uggGiDfI=
X-Received: by 2002:aa7:c155:0:b0:461:8cf7:4783 with SMTP id
 r21-20020aa7c155000000b004618cf74783mr13704480edp.385.1668484433942; Mon, 14
 Nov 2022 19:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-3-memxor@gmail.com>
In-Reply-To: <20221115000130.1967465-3-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 14 Nov 2022 19:53:42 -0800
Message-ID: <CAJnrk1Zn4-LxUfRoL1Brh=xnmg4NxXXfE_2uW9LrnamKc8e+Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf: Propagate errors from process_*
 checks in check_func_arg
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

On Mon, Nov 14, 2022 at 4:01 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, we simply ignore the errors in process_spin_lock,
> process_timer_func, process_kptr_func, process_dynptr_func.
> Instead, bubble up storing and checking err variable.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 56f48ab9827f..41ef7e4b73e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6220,19 +6220,22 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 break;
>         case ARG_PTR_TO_SPIN_LOCK:
>                 if (meta->func_id == BPF_FUNC_spin_lock) {
> -                       if (process_spin_lock(env, regno, true))
> -                               return -EACCES;
> +                       err = process_spin_lock(env, regno, true);
> +                       if (err)
> +                               return err;
>                 } else if (meta->func_id == BPF_FUNC_spin_unlock) {
> -                       if (process_spin_lock(env, regno, false))
> -                               return -EACCES;
> +                       err = process_spin_lock(env, regno, false);
> +                       if (err)
> +                               return err;
>                 } else {
>                         verbose(env, "verifier internal error\n");
>                         return -EFAULT;
>                 }
>                 break;
>         case ARG_PTR_TO_TIMER:
> -               if (process_timer_func(env, regno, meta))
> -                       return -EACCES;
> +               err = process_timer_func(env, regno, meta);
> +               if (err)
> +                       return err;
>                 break;
>         case ARG_PTR_TO_FUNC:
>                 meta->subprogno = reg->subprogno;
> @@ -6255,8 +6258,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 err = check_mem_size_reg(env, reg, regno, true, meta);
>                 break;
>         case ARG_PTR_TO_DYNPTR:
> -               if (process_dynptr_func(env, regno, arg_type, meta))
> -                       return -EACCES;
> +               err = process_dynptr_func(env, regno, arg_type, meta);
> +               if (err)
> +                       return err;
>                 break;
>         case ARG_CONST_ALLOC_SIZE_OR_ZERO:
>                 if (!tnum_is_const(reg->var_off)) {
> @@ -6323,8 +6327,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 break;
>         }
>         case ARG_PTR_TO_KPTR:
> -               if (process_kptr_func(env, regno, meta))
> -                       return -EACCES;
> +               err = process_kptr_func(env, regno, meta);
> +               if (err)
> +                       return err;
>                 break;
>         }
>
> --
> 2.38.1
>
