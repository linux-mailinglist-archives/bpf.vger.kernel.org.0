Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B445E674602
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjASWaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjASWaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:30:18 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3199A731F
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:13:56 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4c24993965eso47475107b3.12
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTQN9kZG8clvIv0dol3BqH7e+bO2NxRogFTez3vx1YE=;
        b=Yy/DAanDEu63RwRIbxrC24rYo5HX29ob2ScpResAOfr+91zeO4YhHckjl9sRiCNd88
         o9HRj+g3EJaUr3mqG09Pl/6GouV4B1jlsCg6d0CtfdMeSBHj9EGSlKe10vADQK8DxncO
         fX3EyGBtpI3TWi3B/rM+bZ5m2aQL+xIG/b1fov82AlRT+PJgyb69LHKrMm83Kp/qsFuK
         3NYzRpptogj+bn7GOUjdfZ0mJRXLMMwlBHEafjANQpexLftGEIx+NMr24GYHVWwzVu2F
         jOTlY4ditej+iEuJuzNtBtwwV40vMChj3+HnGzZyGUmz3/TzclI66V2hYf+nyA9gtal5
         XBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTQN9kZG8clvIv0dol3BqH7e+bO2NxRogFTez3vx1YE=;
        b=So0c6TvqCGK1iTbiwtZNeGJqIBSt6fVhcXWmNtuPNZhoKOnPKk5li+NitF2VCIFDDG
         qdNT0YUcOMQVEZzHND8mlbnJTPuOUpop1YblMidyo5YzLlro+QtVo+jXpnmteNtKGc/e
         LBLy3lK5JQEJfJZrF+pp1C1LpMw2eGgJnu8otgrZlaBav6r8jl1FUIQMxm/9zu2DNKus
         kyEx2yyV8HRHa7thnWWUbucK9bzWG5fiv1wve+gaZmfop99Y7F5g4yDthxJ3sp7x3TmV
         D/hriLyZHRS944Zk60ed5mtsn/AI68tgRvk2jMhUNMCcGrCVhbV+Q159c9qaLZTgegkt
         /ENg==
X-Gm-Message-State: AFqh2kphvmwc5rM0uaP4jw3OD7riboeNs5MGpHxyk4Xk0prIebJKjGo/
        tsQKDguSpMEgAE84rrRtsDPnjnSXTAdA3TlWb2U=
X-Google-Smtp-Source: AMrXdXsGOayVACSvv/H/T/UUQJcO8vJN0pZjrPhhVjPnxWr+7lUo2GnFs6+Hw2HNO2XWUE5yrzMwCpcdI9JSY+EDhzU=
X-Received: by 2002:a81:4602:0:b0:4d5:6812:d8a7 with SMTP id
 t2-20020a814602000000b004d56812d8a7mr1299797ywa.176.1674166436030; Thu, 19
 Jan 2023 14:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-5-memxor@gmail.com>
In-Reply-To: <20230119021442.1465269-5-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 19 Jan 2023 14:13:45 -0800
Message-ID: <CAJnrk1awKhQb0Ca_pD0g+VnFP5V3iz-uyh1f9usmnwi+C6q8jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/11] bpf: Allow reinitializing unreferenced
 dynptr stack slots
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

On Wed, Jan 18, 2023 at 6:14 PM Kumar Kartikeya Dwivedi
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
> The destroy_if_dynptr_stack_slot function already makes necessary checks
> to avoid overwriting referenced dynptr slots. This is done to present a
> better error message instead of forgetting dynptr information on stack
> and preserving reference state, leading to an inevitable but
> undecipherable error at the end about an unreleased reference which has
> to be associated back to its allocating call instruction to make any
> sense to the user.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 09c09d9bfd89..4feaddd5d6dc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -777,7 +777,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>  {
>         struct bpf_func_state *state = func(env, reg);
>         enum bpf_dynptr_type type;
> -       int spi, i, id;
> +       int spi, i, id, err;
>
>         spi = dynptr_get_spi(env, reg);
>         if (spi < 0)
> @@ -786,6 +786,22 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return -EINVAL;
>
> +       /* We cannot assume both spi and spi - 1 belong to the same dynptr,
> +        * hence we need to call destroy_if_dynptr_stack_slot twice for both,
> +        * to ensure that for the following example:
> +        *      [d1][d1][d2][d2]
> +        * spi    3   2   1   0
> +        * So marking spi = 2 should lead to destruction of both d1 and d2. In
> +        * case they do belong to same dynptr, second call won't see slot_type
> +        * as STACK_DYNPTR and will simply skip destruction.
> +        */
> +       err = destroy_if_dynptr_stack_slot(env, state, spi);
> +       if (err)
> +               return err;
> +       err = destroy_if_dynptr_stack_slot(env, state, spi - 1);
> +       if (err)
> +               return err;
> +
>         for (i = 0; i < BPF_REG_SIZE; i++) {
>                 state->stack[spi].slot_type[i] = STACK_DYNPTR;
>                 state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> @@ -931,7 +947,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi, i;
> +       int spi;
>
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return false;
> @@ -944,12 +960,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return true;
>
> -       for (i = 0; i < BPF_REG_SIZE; i++) {
> -               if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
> -                   state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
> -                       return false;
> -       }
> -
> +       /* We allow overwriting existing unreferenced STACK_DYNPTR slots, see
> +        * mark_stack_slots_dynptr which calls destroy_if_dynptr_stack_slot to
> +        * ensure dynptr objects at the slots we are touching are completely
> +        * destructed before we reinitialize them for a new one. For referenced
> +        * ones, destroy_if_dynptr_stack_slot returns an error early instead of
> +        * delaying it until the end where the user will get "Unreleased
> +        * reference" error.
> +        */
>         return true;
>  }
>
> --
> 2.39.1
>
