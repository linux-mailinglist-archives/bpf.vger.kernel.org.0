Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B594620398
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKGXRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKGXRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:17:22 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C726577
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:17:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id b2so34214114eja.6
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjOceSxmqNszmyeJvzC+HwzbYyGCYOEIbrzxDnh9aRM=;
        b=jqO+nbx0DaWMf2ib/+KlChKjUMXkY+pnnvfQKq3XFb8UWxfN96BAqnodqTxTITxn4x
         ieKGjJqJ2wl3sVF9qm5cu2CCCxaJ1zLFQv3e3DY8OUFUcnVDblTXlSzkyxucYd2cP2Rk
         822B4PeTZxvGaYiJDSfWN5m5IajoFOVoR/Rj5wF/IglKtTGlNlnOInB8Lu9A9qcYR9GI
         elZaudpeyTMEnBcE458taX+5V7RJw6GZChnT/ZFvnkuykW3yNEgpMm5OM5s0OyCxSPXJ
         UUmsHUaYjOP70XgS4g2jFotDIoN74uktkUaoZdKq17vvfV7aHd7wIvM80mxcSw8fB/wx
         Bc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjOceSxmqNszmyeJvzC+HwzbYyGCYOEIbrzxDnh9aRM=;
        b=HzyOAF2xOTYJhdALQY1b9Nx/pizI9Rif/IQmmHVQR4SsQ28Wz0RgT6bwsZbgCokCHZ
         MwswuZj0M1MtZxkl9XDt3aJ02iqDx/uph4J6qmwlXA1HUff/mvYfvHrWdB72ueTX3/Tk
         OidGT13HTliOiTK/uM5x/b4+dO6TFKlAyZp48UiSr7j9paMaP9qg2E8iIx4JEf2tH5P/
         Zpx/vvxhHZylsqCL9w0ora6OpEGl9GJUiBQ54l/lHd1Tb63BbVBIOHutzkJ75sM4rWNR
         B2d/8whMNqzD/+Z+9X/HClfAVxfJOii+CXLbsMlEEh/C3vrPE0IFD7UzFVcJozqoOT4H
         lxVg==
X-Gm-Message-State: ACrzQf1FGPndvx/jaGAg/KTEOD9X8eBw1ZtZS/I2rXEhOQ3OD4wThwnt
        zRGyHiBGxKCrVfg40fRFfttAK3zYkDEYgM+enpo=
X-Google-Smtp-Source: AMsMyM41q3oCYAaEQFM0ph4dlAzC6SmblM6Jyak7cPe7WFo86BtLgV1oGFgB5ZZGjS84RkzOUPJCiGxSdy2g+0e++7k=
X-Received: by 2002:a17:907:a4e:b0:77d:94d:8148 with SMTP id
 be14-20020a1709070a4e00b0077d094d8148mr48112178ejc.607.1667863039317; Mon, 07
 Nov 2022 15:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-5-memxor@gmail.com>
In-Reply-To: <20221018135920.726360-5-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 7 Nov 2022 15:17:08 -0800
Message-ID: <CAJnrk1Y0F=+CGUhDZH6HTumbosG3EsoEnUC8TryxpV3amFowkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/13] bpf: Rework check_func_arg_reg_off
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
> While check_func_arg_reg_off is the place which performs generic checks
> needed by various candidates of reg->type, there is some handling for
> special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> ARG_PTR_TO_ALLOC_MEM.
>
> This commit aims to streamline these special cases and instead leave
> other things up to argument type specific code to handle.
>
> This is done primarily for two reasons: associating back reg->type to
> its argument leaves room for the list getting out of sync when a new
> reg->type is supported by an arg_type.
>
> The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
> we already handle, whenever a release argument is expected, it should
> be passed as the pointer that was received from the acquire function.
> Hence zero fixed and variable offset.
>
> There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
> its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
> with non-zero offset to other helper functions, which makes sense.
>
> Hence, lift the arg_type_is_release check for reg->off and cover all
> possible register types, instead of duplicating the same kind of check
> twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).
>
> Finally, for the release argument, arg_type_is_dynptr is the special
> case, where we go to actual object being freed through the dynptr, so
> the offset of the pointer still needs to allow fixed and variable offset
> and process_dynptr_func will verify them later for the release argument
> case as well.
>
> Finally, since check_func_arg_reg_off is meant to be generic, move
> dynptr specific check into process_dynptr_func.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 55 +++++++++++++++----
>  .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
>  2 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a49b95c1af1b..a8c277e51d63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5654,6 +5654,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>                 return -EFAULT;
>         }
>
> +       /* CONST_PTR_TO_DYNPTR has fixed and variable offset as zero, ensured by
> +        * check_func_arg_reg_off, so this is only needed for PTR_TO_STACK.
> +        */
> +       if (reg->off % BPF_REG_SIZE) {
> +               verbose(env, "cannot pass in dynptr at an offset\n");
> +               return -EINVAL;
> +       }
> +

Imo, this logic belongs more in check_func_arg_reg_off(). It's cleaner
to me to have all the logic for reg->off checking consolidated in one
place.

>         /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
>          * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
>          *
> @@ -5672,6 +5680,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>          *               destroyed, including mutation of the memory it points
>          *               to.
>          */
> +
>         if (arg_type & MEM_UNINIT) {
>                 if (!is_dynptr_reg_valid_uninit(env, reg)) {
>                         verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -5983,14 +5992,37 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         enum bpf_reg_type type = reg->type;
>         bool fixed_off_ok = false;
>
> -       switch ((u32)type) {
> -       /* Pointer types where reg offset is explicitly allowed: */
> -       case PTR_TO_STACK:
> -               if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> -                       verbose(env, "cannot pass in dynptr at an offset\n");
> +       /* When referenced register is passed to release function, it's fixed
> +        * offset must be 0.
> +        *
> +        * We will check arg_type_is_release reg has ref_obj_id when storing
> +        * meta->release_regno.
> +        */
> +       if (arg_type_is_release(arg_type)) {
> +               /* ARG_PTR_TO_DYNPTR is a bit special, as it may not directly
> +                * point to the object being released, but to dynptr pointing
> +                * to such object, which might be at some offset on the stack.
> +                *
> +                * In that case, we simply to fallback to the default handling.
> +                */
> +               if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)

Do we need the "arg_type_is_dynptr(arg_type)" part? I think just "if
(type == PTR_TO_STACK)" suffices since any release args on the stack
will be at some fp offset.

> +                       goto check_type;

I think this logic is a lot simpler to read:

if (arg_type_is_release(arg_type)) {
    if (type != PTR_TO_STACK) {
        if (reg->off) {
            verbose(env, "R%d must have zero offset...");
            return -EINVAL;
        }
        return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
    }
}

> +               /* Going straight to check will catch this because fixed_off_ok
> +                * is false, but checking here allows us to give the user a
> +                * better error message.
> +                */
> +               if (reg->off) {
> +                       verbose(env, "R%d must have zero offset when passed to release func\n",
> +                               regno);
>                         return -EINVAL;
>                 }
> -               fallthrough;
> +               goto check;

I think it's cleaner here to just "return __check_ptr_off_reg(env,
reg, regno, fixed_off_ok);" instead of adding the goto check.

> +       }
> +check_type:
> +       switch ((u32)type) {

btw I don't think we need this (u32) cast. type is an enum
bpf_reg_type, which is by default a u32.

> +       /* Pointer types where both fixed and variable reg offset is explicitly
> +        * allowed: */
> +       case PTR_TO_STACK:
>         case PTR_TO_PACKET:
>         case PTR_TO_PACKET_META:
>         case PTR_TO_MAP_KEY:
> @@ -6001,12 +6033,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         case PTR_TO_BUF:
>         case PTR_TO_BUF | MEM_RDONLY:
>         case SCALAR_VALUE:
> -               /* Some of the argument types nevertheless require a
> -                * zero register offset.
> -                */
> -               if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
> -                       return 0;
> -               break;
> +               return 0;
>         /* All the rest must be rejected, except PTR_TO_BTF_ID which allows
>          * fixed offset.
>          */

We should also remove the "if (arg_type_is_release(arg_type) &&
reg->off)" code in the PTR_TO_BTF_ID case.

> @@ -6023,12 +6050,16 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>                 /* For arg is release pointer, fixed_off_ok must be false, but
>                  * we already checked and rejected reg->off != 0 above, so set
>                  * to true to allow fixed offset for all other cases.
> +                *
> +                * var_off always must be 0 for PTR_TO_BTF_ID, hence we still
> +                * need to do checks instead of returning.
>                  */
>                 fixed_off_ok = true;
>                 break;
>         default:
>                 break;
>         }
> +check:
>         return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  }
>
> diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
> index b64d33e4833c..92e3f6a61a79 100644
> --- a/tools/testing/selftests/bpf/verifier/ringbuf.c
> +++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
> @@ -28,7 +28,7 @@
>         },
>         .fixup_map_ringbuf = { 1 },
>         .result = REJECT,
> -       .errstr = "dereference of modified alloc_mem ptr R1",
> +       .errstr = "R1 must have zero offset when passed to release func",
>  },
>  {
>         "ringbuf: invalid reservation offset 2",
> --
> 2.38.0
>
