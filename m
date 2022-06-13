Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B8547F45
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 07:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiFMFvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiFMFvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 01:51:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212DF42
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 22:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2C15B80D5C
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 05:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51623C385A2
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655099473;
        bh=l3dV3kZehEhWWA1TBeEEO1V3rCrXLIwxVLy1aHTLBBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fOSTu94kNEkHJMuPTgmH742zyvDhy3zT1s5xNt6IkIDYu/Vcm/dTeEgJhnPnNHOoa
         /ckmb2W4lTIEOYpRM0QmalN2fHVhCL2UdIkVRTzs4ma8oHd5xTyodfl34mPpW5vcNZ
         WsjoctqJu9ItuZnQ9TkGjPmnYYsak+D7Jrs4+HDQDq/RGJubvb5JJ0QEDqXtjzXPJ0
         2R/wNfSKmcBBw0HbxEEsjBzJvOjShdZO0qgdf5AV/iaNqd/6flkBV+jFBagH/oYJyF
         8dpkbbHvLvzKEAClDzo1CcljGGkZwidN8YhjL1Dlic4QDJ9JbI5OKWjHYVWhxJ7KHK
         4iKQRjUGa3lMg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3137c877092so39917007b3.13
        for <bpf@vger.kernel.org>; Sun, 12 Jun 2022 22:51:13 -0700 (PDT)
X-Gm-Message-State: AOAM5306nnUBbSUnL7jzsHmtXmM5QRgOa92Co4OtS3NuOpjSLabbTh0j
        mmoUHbQnAyGBIyAfz2o0VMM/T+CptvltLZY6N00=
X-Google-Smtp-Source: ABdhPJz1lrJH+NDi5TiWqjvB3oI0GWB/dka8/xE/+q7bQs4RF0ewmDJqpO3U1lQ5x1uMX9eKNMXfCIA5wG3mBW0T3Uk=
X-Received: by 2002:a0d:eb4d:0:b0:30c:9849:27a1 with SMTP id
 u74-20020a0deb4d000000b0030c984927a1mr61220108ywe.472.1655099472358; Sun, 12
 Jun 2022 22:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220611114021.484408-1-eddyz87@gmail.com> <20220611114021.484408-4-eddyz87@gmail.com>
In-Reply-To: <20220611114021.484408-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 12 Jun 2022 22:51:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6r9f=yt93vOG0Lz+yxMWBKaj1xzg0bAVaG18MAtX3_uA@mail.gmail.com>
Message-ID: <CAPhsuW6r9f=yt93vOG0Lz+yxMWBKaj1xzg0bAVaG18MAtX3_uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 11, 2022 at 4:42 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>

[...]

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

[...]

>
> +static struct bpf_insn_aux_data *cur_aux(struct bpf_verifier_env *env)
> +{
> +       return &env->insn_aux_data[env->insn_idx];
> +}
> +
> +static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> +{
> +       struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> +       struct bpf_reg_state *regs = cur_regs(env);
> +       struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
> +       int flags_is_zero =
> +               register_is_const(flags_reg) && flags_reg->var_off.value == 0;

How about we add helper

static bool flag_is_zero(struct bpf_verifier_env *env, int regno)
{
        struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
        struct bpf_reg_state *regs = cur_regs(env);
        struct bpf_reg_state *flags_reg = &regs[regno];

        return register_is_const(flags_reg) && flags_reg->var_off.value == 0;
}

and ...

> +
> +       if (!state->initialized) {
> +               state->initialized = 1;
> +               state->fit_for_inline = flags_is_zero;

       state->fit_for_inline = flag_is_zero(env, BPF_REG_4);

and ...

> +               state->callback_subprogno = subprogno;
> +               return;
> +       }
> +
> +       if (!state->fit_for_inline)
> +               return;
> +
> +       state->fit_for_inline =
> +               flags_is_zero &&

flag_is_zero(env, BPF_REG_4);

This would avoid calculating flag_is_zero for !state->fix_for_inline case.


> +               state->callback_subprogno == subprogno;
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,

[...]

>  static void free_states(struct bpf_verifier_env *env)
>  {
>         struct bpf_verifier_state_list *sl, *sln;
> @@ -15030,6 +15188,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>         if (ret == 0)
>                 ret = check_max_stack_depth(env);
>
> +       if (ret == 0)
> +               optimize_bpf_loop(env);
> +
>         /* instruction rewrites happen after this point */

nit: I guess optimize_bpf_loop() is part of "instruction rewrite", so
this comment
should be above optimize_bpf_loop()?

>         if (is_priv) {
>                 if (ret == 0)
> --
> 2.25.1
>
