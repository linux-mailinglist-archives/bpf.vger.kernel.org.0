Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050C674662
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjASWx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjASWxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:53:12 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DEFDA12F
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:35:39 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 123so4513747ybv.6
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oGB66Q18D0huqO5CKf0ZlBwhdSUatMaYioNAZeAgIQ8=;
        b=Y4l8+weM730JTLeMBLW7Ist4XApTH9iXPCAJAuDaIpg3dDMGZ+tOcLRE3W9d9rRoeq
         cg82PTEF7vf2OeWaRmaxOnUSxka+OihRGJ7MES2GF+emTIqtXIQky5DiLf/SnBKupoi/
         +6Jy3dhN3zW1nVKQAkfhi6QTkB8teagWgjcim/ELvvVId7/zf3C8Qo8t/cvWP7CFasj4
         SteALDh4bav2wnYAqYIPUlb6cgac2mh06oyPM2VioHK3LycpUwDvk8v5YvNT5XJjzVzZ
         8TQW4XAWBcF7SXpbW8z2vTXlzLUtuS+2u5fXHa5lH0ghXfZCynXX5Gw1R+r+/OdxyPuO
         STpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGB66Q18D0huqO5CKf0ZlBwhdSUatMaYioNAZeAgIQ8=;
        b=MvXV+sSj0WiJbtG8OFvrqEuyd76oDQt3QES2QTN7WYHw4A57sesk73UT61aOI75Dhb
         /ntCsd87XkP7wm9lmAd1wFaMgek0kpuxWRLCiBXdgwZRW2f4lErIAz4h2p50pMqMI0pf
         oXCMU6R18FNHbSbLOyLUIua4Uh18YG1Og8fl7F6v/1q3o8oHNCniYG91B5vTyIYQyc7n
         SAlXcuJ87/Izg/18sw8OJY7AeJ/xy7RMsX6xGJpOHaRYS3TBqPAwCXz6v4HDskXk4bls
         qi5IZ/4txtjrHhjniHSuNn1WuJ6D2fGHNFPStxoM+Ctr6xFeWfQLD0EmMZyMP7Ocwm2j
         SGsw==
X-Gm-Message-State: AFqh2kqM8fVa0QngQiApFWLRcg9W8iwZBOwgleYDUlP+O7E+xDY8Kn0q
        tvQII5BXttgbE4GFUe+vdaZISALZzbRkdwX7eYUUejiDtes=
X-Google-Smtp-Source: AMrXdXtexDCDkcU+VIbHGwVHt4oYJMAx1hnPoZbeagYjNBZnFw1bXGRDo7T+RTnJzQcWeopdE+VWLSHJKgyPOaMy1lY=
X-Received: by 2002:a25:2413:0:b0:711:cae6:c734 with SMTP id
 k19-20020a252413000000b00711cae6c734mr1529952ybk.433.1674167738189; Thu, 19
 Jan 2023 14:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-7-memxor@gmail.com>
In-Reply-To: <20230119021442.1465269-7-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 19 Jan 2023 14:35:27 -0800
Message-ID: <CAJnrk1YGTXAso2=+MDcQCphTrAb3gUJ2QRz9Ety3JHMKj4KTow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/11] bpf: Avoid recomputing spi in process_dynptr_func
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Wed, Jan 18, 2023 at 6:15 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, process_dynptr_func first calls dynptr_get_spi and then
> is_dynptr_reg_valid_init and is_dynptr_reg_valid_uninit have to call it
> again to obtain the spi value. Instead of doing this twice, reuse the
> already obtained value (which is by default 0, and is only set for
> PTR_TO_STACK, and only used in that case in aforementioned functions).
> The input value for these two functions will either be -ERANGE or >= 1,
> and can either be permitted or rejected based on the respective check.
>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18b54b219fac..7b8de84568a3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -941,14 +941,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> -static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                                      int spi)
>  {
> -       int spi;
> -
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return false;
>
> -       spi = dynptr_get_spi(env, reg);
>         /* For -ERANGE (i.e. spi not falling into allocated stack slots), we
>          * will do check_mem_access to check and update stack bounds later, so
>          * return true for that case.
> @@ -966,16 +964,16 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         return true;
>  }
>
> -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                                    int spi)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi, i;
> +       int i;
>
>         /* This already represents first slot of initialized bpf_dynptr */
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return true;
>
> -       spi = dynptr_get_spi(env, reg);
>         if (spi < 0)
>                 return false;
>         if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> @@ -6132,7 +6130,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>                         enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
>  {
>         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> -       int err;
> +       int err, spi = 0;
>
>         /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
>          * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> @@ -6146,9 +6144,9 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>          * and its alignment for PTR_TO_STACK.
>          */
>         if (reg->type == PTR_TO_STACK) {
> -               err = dynptr_get_spi(env, reg);
> -               if (err < 0 && err != -ERANGE)
> -                       return err;
> +               spi = dynptr_get_spi(env, reg);
> +               if (spi < 0 && spi != -ERANGE)
> +                       return spi;
>         }
>
>         /*  MEM_UNINIT - Points to memory that is an appropriate candidate for
> @@ -6167,7 +6165,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>          *               to.
>          */
>         if (arg_type & MEM_UNINIT) {
> -               if (!is_dynptr_reg_valid_uninit(env, reg)) {
> +               if (!is_dynptr_reg_valid_uninit(env, reg, spi)) {
>                         verbose(env, "Dynptr has to be an uninitialized dynptr\n");
>                         return -EINVAL;
>                 }
> @@ -6188,7 +6186,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>                         return -EINVAL;
>                 }
>
> -               if (!is_dynptr_reg_valid_init(env, reg)) {
> +               if (!is_dynptr_reg_valid_init(env, reg, spi)) {
>                         verbose(env,
>                                 "Expected an initialized dynptr as arg #%d\n",
>                                 regno);
> --
> 2.39.1
>
