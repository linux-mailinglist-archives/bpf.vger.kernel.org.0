Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D365E02B
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjADWoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 17:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjADWoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 17:44:20 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027642E06
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 14:44:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id gh17so86244350ejb.6
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 14:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RWdjtnMpneBtOuJg5RnAJ4hwDxafYCFv1pePTxk43MQ=;
        b=JbNtCONXAImqvzRiscDXSGB+eZyMtQgx4YahWVoeFVqTqia0SYYQFed1g8Q1Gs/f+a
         xYg6h1IQmMYFWs4xc4vnVn4rB1dqCcgflMYvziXA+SPjJKRBreq9BqD94j8nqe/bW0gR
         jJtWAhwkfSd34d0AXsHj48vtSN087lnm9gwCKQSQEBlaR+Vfx1OWnBU9/XHyYQwu8Knz
         d1WQYB0p4kjSDJGp8eceO3INCKSTRpPofSVyplRdkSji17IjAqD8H6ikivagXBHyoas8
         9wvrHuQTdsledLJIw9xmmyPbHMQoUF48S/+M0NoAW5GJWbBIF+LFLJmRe43AcE/Sc0pP
         NI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWdjtnMpneBtOuJg5RnAJ4hwDxafYCFv1pePTxk43MQ=;
        b=NTnVR5hSnZ+3PakR+SG0CgpQ8niXWxzH0/zaFQQ0E58oxv7YWncKkpB2OIyHNHk0Pw
         eiKPbWXPkD+QFOeiKjYoDBT6IIGL5rnFa1yTsZmyQ66GAyYBQPrA065lEcSUpGdEj7pr
         eQbqWbWGulTfY/eu/EspwUFgRkWvmg8V401hl2ttWTR/Uq2YUtbjQK7pAlNLgIBDb39f
         CZ8wL6ij711BsFbxdGeXXXcbmWkmqvqfWQIKSns8K0KAtEJZC1Xj132PsffcAslsy97w
         GcAOAo5+Us/LJYYlvG15ooMTFXWz8stW3Fb4BKMpe8UtX0cx2U7Q6OMmeDgYFoX2cXMo
         D/yw==
X-Gm-Message-State: AFqh2kqigRUMlqAkS6MyRT532046Cs/gFMRiA2TkraujrivfdyBPcNWA
        2PrySSl9gLE0R+MDpSZUgqNAMykJGfR3/3roGQQ=
X-Google-Smtp-Source: AMrXdXvhmElkg/fTKm2SiWkSG1OdNBRqbOodfJfjHy3OsjhVO2E3zfli8F9QLSttIPBlBvz+DBI7rfVrcUnhU0T6NAg=
X-Received: by 2002:a17:906:a014:b0:7c1:8450:f964 with SMTP id
 p20-20020a170906a01400b007c18450f964mr4664707ejy.176.1672872257989; Wed, 04
 Jan 2023 14:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-5-memxor@gmail.com>
In-Reply-To: <20230101083403.332783-5-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 14:44:05 -0800
Message-ID: <CAEf4BzYVjd=Z-7n1E=wsMdPD-guOoDz-Cedc9=+QisZ9m2150w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: Allow reinitializing unreferenced
 dynptr stack slots
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
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

On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Consider a program like below:
>
> void prog(void)
> {
>         {
>                 struct bpf_dynptr ptr;
>                 bpf_dynptr_from_mem(...);
>         }
>         ...
>         {
>                 struct bpf_dynptr ptr;
>                 bpf_dynptr_from_mem(...);
>         }
> }
>
> Here, the C compiler based on lifetime rules in the C standard would be
> well within in its rights to share stack storage for dynptr 'ptr' as
> their lifetimes do not overlap in the two distinct scopes. Currently,
> such an example would be rejected by the verifier, but this is too
> strict. Instead, we should allow reinitializing over dynptr stack slots
> and forget information about the old dynptr object.
>

As mentioned in the previous patch, shouldn't we allow this only for
dynptrs that don't require OBJ_RELEASE, which would be those with
ref_obj_id == 0?


> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b985d90505cc..e85e8c4be00d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -786,6 +786,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return -EINVAL;
>
> +       destroy_stack_slots_dynptr(env, state, spi);
> +       destroy_stack_slots_dynptr(env, state, spi - 1);
> +
>         for (i = 0; i < BPF_REG_SIZE; i++) {
>                 state->stack[spi].slot_type[i] = STACK_DYNPTR;
>                 state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> @@ -901,7 +904,7 @@ static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi, i;
> +       int spi;
>
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return false;
> @@ -914,12 +917,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return true;
>
> -       for (i = 0; i < BPF_REG_SIZE; i++) {
> -               if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
> -                   state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
> -                       return false;
> -       }
> -
> +       /* We allow overwriting existing STACK_DYNPTR slots, see
> +        * mark_stack_slots_dynptr which calls destroy_stack_slots_dynptr to
> +        * ensure dynptr objects at the slots we are touching are completely
> +        * destructed before we reinitialize them for a new one.
> +        */
>         return true;
>  }
>
> --
> 2.39.0
>
