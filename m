Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877962A148
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 19:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKOSYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKOSYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 13:24:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA7813CC3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:24:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l11so23137913edb.4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jC2PkYakuAoeBZZ1HRii6iFmDQnLOnZ0ORw0PZGEwRE=;
        b=H9SEsV5Sl6HvJznBxZ1oeWMcw3xPYvo0W+Iy2BX9dcHwlddatASK5horAbppu5LypE
         j4OGXS7t/h2f6PPiLFwxYjfWGcZ+YfgUBdCHNTaRJj2pBVUCkiVF9fL89be/863mhQos
         yzwSIkZYQnrSKkXO8muAI/K2pZnvOSRwVHhgpONRt4/Q0BS9Bua16g+6WF40Y2/gnc5G
         XI7yUvYfzLd/Ct4VRIi5izwciIGF63OBOfeAGaoqIH4W3zESnCtMmdx/4iAAtcSszDyr
         71KLXS3sVCxevofkPIiAHRlGBQ0T4c9YfkbBOq+xNf7T+RWv3wmk8+5jpCIhfgGw55sB
         BpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC2PkYakuAoeBZZ1HRii6iFmDQnLOnZ0ORw0PZGEwRE=;
        b=a0blARKiMhvMiMz+YMZRCFPTAqe+yMNoqk72BvAc/lsJBIZ7hO25RriN2NMzgZwDpn
         eiw1+jNVSTg34cLGhU++0YvtlroVGU8GAWVt8oBCWnbAxJYgNlvP+uw/sLAQXGfLJSI5
         U0MW/QvOk/ZPnAWagv5eaFkg2OZS9mJR0G69abT3GHxzTjc/nRlj/50YpPeI5CJEWnsP
         KQjWsZHZn7iw9+H/bVEuQzOwv/qe38m5Da1T88vY8MG482ZhyT2pPRep0f5y/GaWGyNX
         AngoAveiYNPlnujHoknNhR+Ge3FWh+3kHzwp/74nUX3kDC8zfUaBA3LtIdpQ87QKEoLE
         0YRQ==
X-Gm-Message-State: ANoB5pkQ4EimudaaIL+rySCpSG1ywxtWsmj7YEBSRWw5rLT3aHi0/unx
        6Bg3lOZ9FFWqC6GqH3W+jwCagRiFYr9LAqixbO4=
X-Google-Smtp-Source: AA0mqf7uBKi25mxw+M3GnGaG5u32h2O8V7m2haNCXnoEj/iCXD9tmkDzon2gv6pLFxMkHW4d4EqEfenWBBehoYdJdLs=
X-Received: by 2002:aa7:d64a:0:b0:45b:cb6b:c342 with SMTP id
 v10-20020aa7d64a000000b0045bcb6bc342mr16205679edr.282.1668536680622; Tue, 15
 Nov 2022 10:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-5-memxor@gmail.com>
In-Reply-To: <20221115000130.1967465-5-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 15 Nov 2022 10:24:29 -0800
Message-ID: <CAJnrk1aewh__MOvu3Yo_ePRhgEdgXdAyD-=jsphQBFkkK4t-1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Rework check_func_arg_reg_off
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
> While check_func_arg_reg_off is the place which performs generic checks
> needed by various candidates of reg->type, there is some handling for
> special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
> ARG_PTR_TO_ALLOC_MEM.
>
> This commit aims to streamline these special cases and instead leave
> other things up to argument type specific code to handle. The function
> will be restrictive by default, and cover all possible cases when
> OBJ_RELEASE is set, without having to update the function again (and
> missing to do that being a bug).
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
> For the release argument, arg_type_is_dynptr is the special case, where
> we go to actual object being freed through the dynptr, so the offset of
> the pointer still needs to allow fixed and variable offset and
> process_dynptr_func will verify them later for the release argument case
> as well.
>
> This is not specific to ARG_PTR_TO_DYNPTR though, we will need to make
> this exception for any future object on the stack that needs to be
> released. In this sense, PTR_TO_STACK as a candidate for object on stack
> argument is a special case for release offset checks, and they need to
> be done by the helper releasing the object on stack.
>
> Since the check has been lifted above all register type checks, remove
> the duplicated check that is being done for PTR_TO_BTF_ID.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c                         | 62 ++++++++++++-------
>  .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
>  2 files changed, 39 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c484e632b0cd..34e67d04579b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6092,11 +6092,38 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>                            const struct bpf_reg_state *reg, int regno,
>                            enum bpf_arg_type arg_type)
>  {
> -       enum bpf_reg_type type = reg->type;
> -       bool fixed_off_ok = false;
> +       u32 type = reg->type;
>
> -       switch ((u32)type) {
> -       /* Pointer types where reg offset is explicitly allowed: */
> +       /* When referenced register is passed to release function, it's fixed
> +        * offset must be 0.
> +        *
> +        * We will check arg_type_is_release reg has ref_obj_id when storing
> +        * meta->release_regno.
> +        */
> +       if (arg_type_is_release(arg_type)) {
> +               /* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
> +                * may not directly point to the object being released, but to
> +                * dynptr pointing to such object, which might be at some offset
> +                * on the stack. In that case, we simply to fallback to the
> +                * default handling.
> +                */
> +               if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {
> +                       /* Doing check_ptr_off_reg check for the offset will
> +                        * catch this because fixed_off_ok is false, but
> +                        * checking here allows us to give the user a better
> +                        * error message.
> +                        */
> +                       if (reg->off) {
> +                               verbose(env, "R%d must have zero offset when passed to release func\n",
> +                                       regno);
> +                               return -EINVAL;
> +                       }
> +                       return __check_ptr_off_reg(env, reg, regno, false);
> +               }
> +               /* Fallback to default handling */
> +       }
> +       switch (type) {
> +       /* Pointer types where both fixed and variable offset is explicitly allowed: */
>         case PTR_TO_STACK:
>                 if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
>                         verbose(env, "cannot pass in dynptr at an offset\n");
> @@ -6113,35 +6140,22 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
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
>         case PTR_TO_BTF_ID:
>                 /* When referenced PTR_TO_BTF_ID is passed to release function,
>                  * it's fixed offset must be 0. In the other cases, fixed offset
> -                * can be non-zero.
> +                * can be non-zero. This was already checked above. So pass
> +                * fixed_off_ok as true to allow fixed offset for all other
> +                * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
> +                * still need to do checks instead of returning.
>                  */
> -               if (arg_type_is_release(arg_type) && reg->off) {
> -                       verbose(env, "R%d must have zero offset when passed to release func\n",
> -                               regno);
> -                       return -EINVAL;
> -               }
> -               /* For arg is release pointer, fixed_off_ok must be false, but
> -                * we already checked and rejected reg->off != 0 above, so set
> -                * to true to allow fixed offset for all other cases.
> -                */
> -               fixed_off_ok = true;
> -               break;
> +               return __check_ptr_off_reg(env, reg, regno, true);
>         default:
> -               break;
> +               return __check_ptr_off_reg(env, reg, regno, false);
>         }
> -       return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  }
>
>  static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
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
> 2.38.1
>
