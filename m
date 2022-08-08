Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD258CD6A
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 20:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiHHSPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 14:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHHSPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 14:15:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345012AB3;
        Mon,  8 Aug 2022 11:15:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gk3so18026456ejb.8;
        Mon, 08 Aug 2022 11:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPx8e2WZ5x3O6RzJ0FBYuElFwi40nMqF3zJj8LRx/uM=;
        b=AeoyWAKH3SpNET04KSZr8c4od/fZuq6fXzbg3b1+sLGHGviz0lzCv3VWkC12aoxiPb
         YdyiIsZHoLrernC7n0pQkfXj5fw+W3TRfZ0qDDTEqH9oC1YfxHjZ5v0Ot5CXdjAEhb70
         QmTja47co3PpiIoksu2rXu22OhMF+T1Tc1kr5ThVNtkFRh3grGc0y/LApFcJccd3SZrx
         C4SRsj2UW05KGXhdLOMuWrviH/qo0WQzwklDw5v8kLtgJ+4g5kA9CKm3vAQHlNPjhJ5E
         QhOZNVra0D6NXhVMPlqpL9jIJOxywliKOWzTZ6y9L8nMS3nI53uIPTsnKapK832aN3bY
         6U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPx8e2WZ5x3O6RzJ0FBYuElFwi40nMqF3zJj8LRx/uM=;
        b=NhtqnTytynVhfYIMBcdNkmnuEYIUh2QRk9oCToLkDNBKju2pjm/Eky5sVeMF2cPADz
         yBsoGif1JKnOCXkJ3sBSCJ9lb+jM7vcf9CUnA2vheMoRHzzGHBrGgnssVbYEFFklXwV5
         Bqr6+uTOlBke+UDMqH1kkYG1DEk7gaLztw+PIowsZo7myMXS+AGbZhkj9h4hdCjcGSFF
         LHfMtFEL6HEOu1tGXs282cu8loM1oN6RB4vcW9dtO5Ochpcnc9sigZLjakJ6ropjAp+5
         Gvyxdf4Pk5/jZf8slC9s0MqxbYiJ+ydnbATXXAkWxjByqEUSmOqr47jvkUCZPKknRW3p
         l0Hw==
X-Gm-Message-State: ACgBeo1wouW4Ufp4VemMRVrGp3jCbfs2NVcIwAfwmlK+f8YXgdF7cbj3
        F0eZ3eAuMr+qs6hOgMNO3wETRaA0+bXWwnTtJsrzqDjHi+0=
X-Google-Smtp-Source: AA6agR5h3XhlvNoxhWzOgR+EtkZun8KF7u+zK+88U74khRnQcS1xjgGa4EMWaBY/RgQDnu4R4P0prGvyQa09K/CkQ/Y=
X-Received: by 2002:a17:907:8687:b0:730:7c7b:b9ce with SMTP id
 qa7-20020a170907868700b007307c7bb9cemr14127780ejc.656.1659982499687; Mon, 08
 Aug 2022 11:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com>
In-Reply-To: <20220808155341.2479054-1-void@manifault.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 8 Aug 2022 11:14:48 -0700
Message-ID: <CAJnrk1YL1N371vkRDx9E6_OU2GwCj4sVzasBdjmYNUBuzygF_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] bpf: Clear callee saved regs after updating REG0
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
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

On Mon, Aug 8, 2022 at 8:53 AM David Vernet <void@manifault.com> wrote:
>
> In the verifier, we currently reset all of the registers containing caller
> saved args before updating the callee's return register (REG0). In a
> follow-on patch, we will need to be able to be able to inspect the caller
> saved registers when updating REG0 to determine if a dynptr that's passed
> to a helper function was allocated by a helper, or allocated by a program.
>
> This patch therefore updates check_helper_call() to clear the caller saved
> regs after updating REG0.
>
Overall lgtm

There's a patch [0] that finds + stores the ref obj id before the
caller saved regs get reset, which would make this patch not needed.
That hasn't been merged in yet though and I think there's pros for
either approach.

In the one where we find + store the ref obj id before any caller
saved regs get reset, the pro is that getting the dynptr metadata (eg
ref obj id and in the near future, the dynptr type as well) earlier
will be useful (eg when we add skb/xdp dynptrs [1], we'll need to know
the type of the dynptr in order to determine whether to set the return
reg as PTR_TO_PACKET). In this patch, the pro is that the logic is a
lot more obvious to readers that the ref obj id for the dynptr gets
found and set in order to store it in the return reg's ref obj id.

I personally lean more towards the approach in [0] because I think
that ends up being cleaner for future extensibility, but I don't feel
strongly about it and would be happy going with this approach as well

[0] https://lore.kernel.org/bpf/20220722175807.4038317-1-joannelkoong@gmail.com/#t

[1] https://lore.kernel.org/bpf/20220726184706.954822-1-joannelkoong@gmail.com/T/#t

> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  kernel/bpf/verifier.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 096fdac70165..938ba1536249 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7348,11 +7348,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         if (err)
>                 return err;
>
> -       /* reset caller saved regs */
> -       for (i = 0; i < CALLER_SAVED_REGS; i++) {
> -               mark_reg_not_init(env, regs, caller_saved[i]);
> -               check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> -       }
> +       /* reset return reg */
> +       mark_reg_not_init(env, regs, BPF_REG_0);
> +       check_reg_arg(env, BPF_REG_0, DST_OP_NO_MARK);
>
>         /* helper call returns 64-bit value. */
>         regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> @@ -7488,6 +7486,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].ref_obj_id = dynptr_id;
>         }
>
> +       /* reset remaining caller saved regs */
> +       BUILD_BUG_ON(caller_saved[0] != BPF_REG_0);

nit: caller_saved is a read-only const, so I don't think this line is needed

> +       for (i = 1; i < CALLER_SAVED_REGS; i++) {

nit: maybe "for i = BPF_REG_1" ?

> +               mark_reg_not_init(env, regs, caller_saved[i]);
> +               check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> +       }
> +
>         do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
>
>         err = check_map_func_compatibility(env, meta.map_ptr, func_id);
> --
> 2.30.2
>
