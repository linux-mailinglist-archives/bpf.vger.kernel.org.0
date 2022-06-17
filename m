Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0254EF2B
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 04:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbiFQCPF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 22:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiFQCPE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 22:15:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE564BFC
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 19:15:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hj18so5471040ejb.0
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HrBRGA4EcIG5+0lmFSEC1SLiCFB1VTOZ3vuXga034s=;
        b=OYu6rwx05eO2kf2+kCyfzrMYKTYF4wF6qBKyOTaZovD7WzC55WpGwT08AHDGP/0QZ1
         V6IWOwPCFpvDYBHSgSFyLp3VNY822lYTu16ct4gOaa/iDHv197G3dKtq9kqD96wohqT8
         2EUnlRriiiIxU8X2hGBp2/Mzbk1DjD8xIRcX/101EH1OblnyMOJfghv1TH3RYOOELFeZ
         BkO/be+KN4adzPJ0l+9xWh7sY+pLlgXU6n3fEyQUuPdHPw1eoqw3xII7Xnvke2XCIvjR
         nfQlhnOLRjDQtikKDyEMAE+VT6hSyI4w3hclxdUJtAFH0eqyfr1yGmX2Hfc9jEcqRoCv
         hehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HrBRGA4EcIG5+0lmFSEC1SLiCFB1VTOZ3vuXga034s=;
        b=viRo80aT2mjyke7MtmN4rlndc2GS56p5jMkNcUH26XOuAMUY/gpIYYhGWPzUz/EcQT
         TC3TeERjf7qohKQFd9po41y0QMJlyxZ6CIcFzbxpVqPoqNzV4k4f8tGMfAfuiXoi4yjE
         DgC19ee0Okdi77mzrGuOJoiMABvN4c93J68+ELEp03G6XZm0UWQ9hfi3R1u2RSBO21kI
         HmLaY7bkxPkrOXolU/gUYRx18enGRIoYF7D9od2bZwdh2ykjE5QiVvzleInFvQ1X2jGL
         piGDBfEH/saqc+FHsZ/iCXgIjP32OPV4BGb/UaEJRl92UkKjEzNL1vZX1WeNe2kygZAL
         w9UQ==
X-Gm-Message-State: AJIora/G6Wr0bpbjTUr6yNiguLYRz+DjjnYHgR4mXWyWZTpvx2+p/swL
        sUOdpdnhsf5wfa3XiEXjmSCCQOFCLhTgqbvJdZ4=
X-Google-Smtp-Source: AGRyM1vV/Md76Ws1EMQ/nq4YxLmp0TLTC9PVD0WOBAgp5eNmA5e1XZrev1/7njQhQgVz4DI47Rdakk58Dsvtyw2CPFc=
X-Received: by 2002:a17:906:f293:b0:718:82e3:226b with SMTP id
 gu19-20020a170906f29300b0071882e3226bmr7247784ejb.676.1655432102544; Thu, 16
 Jun 2022 19:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220613205008.212724-1-eddyz87@gmail.com> <20220613205008.212724-4-eddyz87@gmail.com>
In-Reply-To: <20220613205008.212724-4-eddyz87@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Jun 2022 19:14:50 -0700
Message-ID: <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Mon, Jun 13, 2022 at 1:50 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> +
> +static bool loop_flag_is_zero(struct bpf_verifier_env *env)
> +{
> +       struct bpf_reg_state *regs = cur_regs(env);
> +       struct bpf_reg_state *reg = &regs[BPF_REG_4];
> +
> +       return register_is_const(reg) && reg->var_off.value == 0;
> +}

Great catch here by Daniel.
It needs mark_chain_precision().

> +
> +static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
> +{
> +       struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> +
> +       if (!state->initialized) {
> +               state->initialized = 1;
> +               state->fit_for_inline = loop_flag_is_zero(env);
> +               state->callback_subprogno = subprogno;
> +               return;
> +       }
> +
> +       if (!state->fit_for_inline)
> +               return;
> +
> +       state->fit_for_inline =
> +               loop_flag_is_zero(env) &&
> +               state->callback_subprogno == subprogno;

No need to heavy indent. Up to 100 char is fine.

> +static int optimize_bpf_loop(struct bpf_verifier_env *env)
> +{
> +       struct bpf_subprog_info *subprogs = env->subprog_info;
> +       int i, cur_subprog = 0, cnt, delta = 0;
> +       struct bpf_insn *insn = env->prog->insnsi;
> +       int insn_cnt = env->prog->len;
> +       u16 stack_depth = subprogs[cur_subprog].stack_depth;
> +       u16 stack_depth_extra = 0;
> +
> +       for (i = 0; i < insn_cnt; i++, insn++) {
> +               struct bpf_loop_inline_state *inline_state =
> +                       &env->insn_aux_data[i + delta].loop_inline_state;
> +
> +               if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
> +                       struct bpf_prog *new_prog;
> +
> +                       stack_depth_extra = BPF_REG_SIZE * 3;
> +                       new_prog = inline_bpf_loop(env,
> +                                                  i + delta,
> +                                                  -(stack_depth + stack_depth_extra),

See the fix that just landed:
https://lore.kernel.org/bpf/20220616162037.535469-2-jakub@cloudflare.com/

subprogs[cur_subprog].stack_depth may not be a multiple of 8.
But spill slots for r[678] have to be.
We need to round_up(,8) here and
increase stack_depth_extra accordingly.

The rest looks great.
Thank you for working on it!
