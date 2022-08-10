Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A827758E4A0
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiHJBnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 21:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHJBmx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 21:42:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01F6FA2A
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 18:42:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so25222588ejp.2
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KHADnXhpj7armAd2wmbdMCnBwL4OaEHm3SVGv3C5Xnc=;
        b=hNT5aSamihOhh+j7xc/mQHXgR4XMogWuEJxqm6exBzOFTNzSJuIiM3EKjK3b+UuazA
         ORABmlNusUOiUqcaGMM9Hkk9L2Rq3+rOLWFKERrwJdmJrV75QgfanhIW9sn96ptRc1v1
         P0I5nyFaw/CWDeoTjAtW2KcXnfggA3xYwDL1uKHIOINCcssD2gf0NWDMUOm9+ijt5IIN
         ifmx10iLrXYrLke2O6NNjqJQwAGJadGS3Rp8TfjALPry34xZdlp4ARZxgWR+T9uKhTS/
         EQyzXZm6YHJfDAlvJEFYct9PTcGQ/thpYumXfRjGO7yefdRe323ANvcnRBllUXnmnzo8
         rFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KHADnXhpj7armAd2wmbdMCnBwL4OaEHm3SVGv3C5Xnc=;
        b=rO/TN618FzVVuDlWj/a0Y37I4fw2Y8en87xGNadWGkrfnDG00pPZIEH4lX9qAUO4sP
         3oMpWl04jCN8hMjHQv9k8wkd9IYj0XUDpoq4gQwTS6f1VZ9v5f+TS+EcDHDM/0FvjaRr
         T2MYPpQTYPuJtqLMn/frAdg/z3GZpTHmlKlSZtQ37ATGDIugLVKLavJ2jFjmMsyvXlEZ
         Bae3Xm/JLLn+Mae9a5G+zEXJ8a1Sidb4VE/wZUay2/N0dudnYBQrYu51/Zh9oxH3Isge
         PPCSiaphnOitLcrEaTDkXN4bX8dbiGTMRKFb2S9pEiR8zokvHRi2SwDeV17q8slb03aI
         JN1A==
X-Gm-Message-State: ACgBeo3knZMNb9tu2lpXymEGKspLvwfmGCbVzYcnowwJnkaEna3BMQD5
        N70aLm7kTEYbUTZgNcyXdKgqO7vraFmtGsIKnOoGXfKUgRY=
X-Google-Smtp-Source: AA6agR62s/CSaswwW77InVLoIVTgGzJ/TlXMOBYP7ZHwEJAyzUXt7sJxRyaapnblzZUxFzqIRQ0qhKHyqiAgxm4fAEw=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr19302991ejy.708.1660095771143; Tue, 09
 Aug 2022 18:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220809214055.4050604-1-joannelkoong@gmail.com>
In-Reply-To: <20220809214055.4050604-1-joannelkoong@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 18:42:39 -0700
Message-ID: <CAADnVQ+yLEuOFYQ47EDt4yGxHfEpL11qbMnabO_MHp_nihVY2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Aug 9, 2022 at 2:41 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> the ref obj id of the dynptr must be found and then associated with the data
> slice.
>
> The ref obj id of the dynptr must be found *before* the caller saved regs are
> reset. Without this fix, the ref obj id tracking is not correct for
> dynptrs that are at an offset from the frame pointer.
>
> Please also note that the data slice's ref obj id must be assigned after the
> ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> zero-marked.
>
> Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");

The proper format is:
Fixes: 34d4ef5775f7 ("bpf: Add dynptr data slices")
make sure you have abbrev = 12 in your .gitconfig
No need for ; at the end.

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/verifier.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01e7f48b4d8c..28b02dc67a2a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -504,7 +504,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
>                 func_id == BPF_FUNC_skc_to_tcp_request_sock;
>  }
>
> -static bool is_dynptr_acquire_function(enum bpf_func_id func_id)
> +static bool is_dynptr_ref_function(enum bpf_func_id func_id)
>  {
>         return func_id == BPF_FUNC_dynptr_data;
>  }
> @@ -518,7 +518,7 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
>                 ref_obj_uses++;
>         if (is_acquire_function(func_id, map))
>                 ref_obj_uses++;
> -       if (is_dynptr_acquire_function(func_id))
> +       if (is_dynptr_ref_function(func_id))
>                 ref_obj_uses++;
>
>         return ref_obj_uses > 1;
> @@ -7320,6 +7320,23 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                         }
>                 }
>                 break;
> +       case BPF_FUNC_dynptr_data:
> +               for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +                       if (arg_type_is_dynptr(fn->arg_type[i])) {
> +                               if (meta.ref_obj_id) {
> +                                       verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
> +                                       return -EFAULT;
> +                               }
> +                               /* Find the id of the dynptr we're tracking the reference of */
> +                               meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> +                               break;
> +                       }
> +               }
> +               if (i == MAX_BPF_FUNC_REG_ARGS) {
> +                       verbose(env, "verifier internal error: no dynptr in bpf_dynptr_data()\n");
> +                       return -EFAULT;
> +               }
> +               break;
>         }
>
>         if (err)
> @@ -7457,7 +7474,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 return -EFAULT;
>         }
>
> -       if (is_ptr_cast_function(func_id)) {
> +       if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>         } else if (is_acquire_function(func_id, meta.map_ptr)) {
> @@ -7469,21 +7486,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].id = id;
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = id;
> -       } else if (is_dynptr_acquire_function(func_id)) {
> -               int dynptr_id = 0, i;
> -
> -               /* Find the id of the dynptr we're tracking the reference of */
> -               for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> -                       if (arg_type_is_dynptr(fn->arg_type[i])) {
> -                               if (dynptr_id) {
> -                                       verbose(env, "verifier internal error: multiple dynptr args in func\n");
> -                                       return -EFAULT;
> -                               }
> -                               dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);

So this bit of code was just grabbing REG_[1-5] with reg->off == 0
and random spilled_ptr.id ?
It never worked correctly, right?

Technically bpf material, but applied to bpf-next due to conflicts.
