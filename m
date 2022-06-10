Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40794546ED7
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 22:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350550AbiFJUyb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 16:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350734AbiFJUya (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 16:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0703EF0D
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3BC61005
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 20:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3118C341C0
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654894465;
        bh=akgcWBQXnOVr+kAYKXUWba+pxl+aJnws5PCATCju7jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LaL6Bg/B2cESy24H8XKm0tYf9VrbADY3xEhwFVE48idJp3uWXpb+cVpDkYWBh1u8A
         yGorJ5zkBqSIYmlzZj1EPaai7i8E4Dyo28xVwyM0wJ3HJu0PcrgtjiTVZqJKk3jj6k
         oaXPEWvK0wfRAIBEAhtitWA9gkS8zKAknNXz3HA47UOFljsTsztvyzx3MkkRpd1Rko
         ONV61DKfHapKJRiLpWNf7zF0dYnx5cZ2+/EX/Gj9EluW2baAJDF66ZWbu4n0dKdOKs
         gJNaIYjrbI/YF7jI9SOPXYTsYbZ140JDEDLF4/doVEdhWZhEkz4Xq47t2rpRDhfwCD
         4NcPyFNexhDHw==
Received: by mail-yb1-f170.google.com with SMTP id t32so541556ybt.12
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:54:25 -0700 (PDT)
X-Gm-Message-State: AOAM531wzDwKSBlCFUZ86P8mVCeUqvajM+EkgBmQ/434JpJ09JnBw1Y0
        njVJ9KKi9BN9T2cPw1u0J3g591bFKanwm5wFX+U=
X-Google-Smtp-Source: ABdhPJwUni+MCbV2l4EjFyzy/8e8IrtS/eEL053mLWfcv2yO/Scq8HPaTpLgP3pxZiGa+Arpx2uWd79Dac17gmIt8n8=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr45884799ybc.257.1654894464763; Fri, 10
 Jun 2022 13:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-4-eddyz87@gmail.com>
In-Reply-To: <20220608192630.3710333-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 13:54:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
Message-ID: <CAPhsuW6RfokP8U6tDX+Qg+ufxpHfvgm_f=giE0nOUXONmV+iGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when
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

On Wed, Jun 8, 2022 at 12:27 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
[...]

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf.h          |   3 +
>  include/linux/bpf_verifier.h |  12 +++
>  kernel/bpf/bpf_iter.c        |   9 +-
>  kernel/bpf/verifier.c        | 168 +++++++++++++++++++++++++++++++++--
>  4 files changed, 183 insertions(+), 9 deletions(-)

[...]

> +struct bpf_loop_inline_state {
> +       bool initialized; /* set to true upon first entry */
> +       bool fit_for_inline; /* true if callback function is the same
> +                             * at each call and flags are always zero
> +                             */
> +       u32 callback_subprogno; /* valid when fit_for_inline is true */
> +};

nit: We only need one bit for initialized and fit_for_inline.

> +
>  /* Possible states for alu_state member. */
>  #define BPF_ALU_SANITIZE_SRC           (1U << 0)
>  #define BPF_ALU_SANITIZE_DST           (1U << 1)
> @@ -373,6 +381,10 @@ struct bpf_insn_aux_data {
>                                 u32 mem_size;   /* mem_size for non-struct typed var */
>                         };

[...]

> +
> +void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)

static void ...

> +{
> +       struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
> +       struct bpf_reg_state *regs = cur_regs(env);
> +       struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
> +

nit: we usually don't have empty lines here.

> +       int flags_is_zero =
> +               register_is_const(flags_reg) && flags_reg->var_off.value == 0;

If we replace "fit_for_inline" with "not_fit_for_inline", we can make the cannot
inline case faster with:

  if (state->not_fit_for_inline)
      return;

> +
> +       if (state->initialized) {
> +               state->fit_for_inline &=
> +                       flags_is_zero &&
> +                       state->callback_subprogno == subprogno;
> +       } else {
> +               state->initialized = 1;
> +               state->fit_for_inline = flags_is_zero;
> +               state->callback_subprogno = subprogno;
> +       }
> +}
> +
[...]

>
> +struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
> +                                int position,
> +                                s32 stack_base,
> +                                u32 callback_subprogno,
> +                                u32 *cnt)

missing static

> +{
> +       s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
> +       s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
> +       s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
> +       int reg_loop_max = BPF_REG_6;
> +       int reg_loop_cnt = BPF_REG_7;
> +       int reg_loop_ctx = BPF_REG_8;
> +
[...]
