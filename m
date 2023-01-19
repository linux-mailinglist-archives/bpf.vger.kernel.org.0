Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4268674659
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjASWru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjASWr2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:47:28 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC13BD17D
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:30:53 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4d19b2686a9so48281647b3.6
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jD9MAIL3LNEaiNqPiv6p5MZbMjwgwknL0O/tmQu1S9Q=;
        b=cld//CcspzU9+SSzJ9dujqI1xlbXMnGHurvAkFhah5OraipJ91zQAvSiievF9BbsYa
         caD8WrY2GSt2AKAIgoEWjxkcrdHGJz2mE42iN1Nv5WA7oHWB75pCTECbLs9G9VyDNAY8
         9SEOIJ/AnC+x/cFv94fEwyy+pp9qhDPW4J7zF44eEMuHS27eehzstD57WDhZrbCbpoHN
         ZJ4cZhgC+RqrtZZFapg0X0Bcc94s6hffRkGyIYHAhwwec6vfgUPo5aKS7pMrjy6+vrvs
         i5y0F//vxCV7GUumuSSvXUHEJV0tFT8vPRa8FQcoPFfcVIGZN8KS5H6y4tW1OdbxzaWc
         928w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jD9MAIL3LNEaiNqPiv6p5MZbMjwgwknL0O/tmQu1S9Q=;
        b=3vV3dOhSmn5hHC0XTZmT1loRrSlYue5A/gjhRX+Ngpk1OZX/YOQD7Ax5kLKi7/ShV+
         DQEeyyvG2QivZfPFhaZqFNOEoB3Hyy0mPgG0+7qSt6xyBXZZ/LMXHMCVD5biJZL3HGkO
         Rp6SQ4hPWrRKosJmKTuxqV8uhnhlbrysX3YYCW0qOz4NZg1PP77Q44cM4nWJCtdIZlY5
         lLLAmEM2grieCgkoeVoYSpDLra/1T3Uiv4dIRMq16JaguLyLmUjVT7vrCGEjDKaRVJBV
         z3OQPgfndJOzLhjb7YyoerpcdLwcnQBaTOcO9M7t8Zhc4W2gRKuU+V8VoEh6HjPaUlkd
         MjHQ==
X-Gm-Message-State: AFqh2kp5oAF/ue7a6Bh5B2xP+R0fJ4ISsMp3eEt84IMEpiDemtMfzfSQ
        l8T6uND3nuHdE5PNSFY2ayepEoMJpq4j36Xy8v/wStATkxw=
X-Google-Smtp-Source: AMrXdXsfepme8PV/R+ciwp7Expc8Ldc+AW7Yuo4n39uTutoV/sbDuy3jFV59zwbnybDpIJ46952KTS209kRpC+HVlaQ=
X-Received: by 2002:a81:46:0:b0:3ce:df72:19d1 with SMTP id 67-20020a810046000000b003cedf7219d1mr1544498ywa.264.1674167453063;
 Thu, 19 Jan 2023 14:30:53 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-6-memxor@gmail.com>
In-Reply-To: <20230119021442.1465269-6-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 19 Jan 2023 14:30:42 -0800
Message-ID: <CAJnrk1aJBeyrimzgdYapZ6gQ22p5sfCtZsnkPuKoq8rvAwKbPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/11] bpf: Combine dynptr_get_spi and is_spi_bounds_valid
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
> Currently, a check on spi resides in dynptr_get_spi, while others
> checking its validity for being within the allocated stack slots happens
> in is_spi_bounds_valid. Almost always barring a couple of cases (where
> being beyond allocated stack slots is not an error as stack slots need
> to be populated), both are used together to make checks. Hence, subsume
> the is_spi_bounds_valid check in dynptr_get_spi, and return -ERANGE to
> specially distinguish the case where spi is valid but not within
> allocated slots in the stack state.
>
> The is_spi_bounds_valid function is still kept around as it is a generic
> helper that will be useful for other objects on stack similar to dynptr
> in the future.
>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c | 75 +++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 42 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4feaddd5d6dc..18b54b219fac 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -643,6 +643,28 @@ static int __get_spi(s32 off)
>         return (-off - 1) / BPF_REG_SIZE;
>  }
>
> +static struct bpf_func_state *func(struct bpf_verifier_env *env,
> +                                  const struct bpf_reg_state *reg)
> +{
> +       struct bpf_verifier_state *cur = env->cur_state;
> +
> +       return cur->frame[reg->frameno];
> +}
> +
> +static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
> +{
> +       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> +
> +       /* We need to check that slots between [spi - nr_slots + 1, spi] are
> +       * within [0, allocated_stack).
> +       *
> +       * Please note that the spi grows downwards. For example, a dynptr
> +       * takes the size of two stack slots; the first slot will be at
> +       * spi and the second slot will be at spi - 1.
> +       */
> +       return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
> +}
> +
>  static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         int off, spi;
> @@ -663,29 +685,10 @@ static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *re
>                 verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
>                 return -EINVAL;
>         }
> -       return spi;
> -}
> -
> -static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
> -{
> -       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
>
> -       /* We need to check that slots between [spi - nr_slots + 1, spi] are
> -        * within [0, allocated_stack).
> -        *
> -        * Please note that the spi grows downwards. For example, a dynptr
> -        * takes the size of two stack slots; the first slot will be at
> -        * spi and the second slot will be at spi - 1.
> -        */
> -       return spi - nr_slots + 1 >= 0 && spi < allocated_slots;
> -}
> -
> -static struct bpf_func_state *func(struct bpf_verifier_env *env,
> -                                  const struct bpf_reg_state *reg)
> -{
> -       struct bpf_verifier_state *cur = env->cur_state;
> -
> -       return cur->frame[reg->frameno];
> +       if (!is_spi_bounds_valid(func(env, reg), spi, BPF_DYNPTR_NR_SLOTS))
> +               return -ERANGE;
> +       return spi;
>  }
>
>  static const char *kernel_type_name(const struct btf* btf, u32 id)
> @@ -783,9 +786,6 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         if (spi < 0)
>                 return spi;
>
> -       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> -               return -EINVAL;
> -
>         /* We cannot assume both spi and spi - 1 belong to the same dynptr,
>          * hence we need to call destroy_if_dynptr_stack_slot twice for both,
>          * to ensure that for the following example:
> @@ -839,9 +839,6 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
>         if (spi < 0)
>                 return spi;
>
> -       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> -               return -EINVAL;
> -
>         for (i = 0; i < BPF_REG_SIZE; i++) {
>                 state->stack[spi].slot_type[i] = STACK_INVALID;
>                 state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> @@ -946,20 +943,18 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
> -       struct bpf_func_state *state = func(env, reg);
>         int spi;
>
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return false;
>
>         spi = dynptr_get_spi(env, reg);
> +       /* For -ERANGE (i.e. spi not falling into allocated stack slots), we
> +        * will do check_mem_access to check and update stack bounds later, so
> +        * return true for that case.
> +        */
>         if (spi < 0)
> -               return false;
> -
> -       /* We will do check_mem_access to check and update stack bounds later */
> -       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> -               return true;
> -
> +               return spi == -ERANGE;
>         /* We allow overwriting existing unreferenced STACK_DYNPTR slots, see
>          * mark_stack_slots_dynptr which calls destroy_if_dynptr_stack_slot to
>          * ensure dynptr objects at the slots we are touching are completely
> @@ -983,8 +978,7 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
>         spi = dynptr_get_spi(env, reg);
>         if (spi < 0)
>                 return false;
> -       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> -           !state->stack[spi].spilled_ptr.dynptr.first_slot)
> +       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
>                 return false;
>
>         for (i = 0; i < BPF_REG_SIZE; i++) {
> @@ -6153,7 +6147,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>          */
>         if (reg->type == PTR_TO_STACK) {
>                 err = dynptr_get_spi(env, reg);
> -               if (err < 0)
> +               if (err < 0 && err != -ERANGE)
>                         return err;
>         }
>
> @@ -6646,10 +6640,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                          */
>                         if (reg->type == PTR_TO_STACK) {
>                                 spi = dynptr_get_spi(env, reg);
> -                               if (spi < 0)
> -                                       return spi;
> -                               if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> -                                   !state->stack[spi].spilled_ptr.ref_obj_id) {
> +                               if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
>                                         verbose(env, "arg %d is an unacquired reference\n", regno);
>                                         return -EINVAL;
>                                 }
> --
> 2.39.1
>
