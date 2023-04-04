Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8526D6FED
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 00:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjDDWJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 18:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjDDWJw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 18:09:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D740FD
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 15:09:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so136230137edd.12
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 15:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680646187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apkFWLRRNVr3GVj61N1GWi17A1sd/CillZUWpuijlTc=;
        b=Ei+UCWbZKUY10bd8vXf0LcbkwNOhWVSCj/ddoWPMjrLNOPJiZL/7R5aRvgGr2ESbsD
         p+7InzD8c6NvJgOFlyIhgwVhUsrt6T0C/dYX42CD/gBDLabONv8bg2Y3qFSeqsP9Cp7e
         bXuh2VHHsJPFkC4k1HFRjgH/nRnTMjFbkLcv1GSgy2iKp5bB0cPgjB4pdOpt1hDO87Ca
         H9qrDq6IVUaCcL1SkfiOfCEzBJv6Oqx1HwLMRh/GgIzH97l4JSXnqBfAVrBNxNm+9caI
         6NpGf/PHRZ8w7mltuv312kDKpxPb9Bab/oBIP75Lrcxju2OM5BsKTFyXRw30IfV1J0tf
         6tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apkFWLRRNVr3GVj61N1GWi17A1sd/CillZUWpuijlTc=;
        b=FaMscJC4DdadO0fuBuayHnqLZejFplGosnbYMbs3B2/E9KKaTWzjb2niPlbkoFnyfA
         fetv2d8YUZ45iDQ/gt2l/7msP0vzAgEMN2izug6OMfqPYcEOBV/7uWKxMoEafSrJQ9eK
         QEcnCDiegM//Bai+hYN+Q5DPp38ouNI9pB3ObmetF0OAFMRXBkk8EZXRsbpnlEOvJgNE
         GXrVakHuuAY8B8DHCk5kuQd9vIkXa2JZsRkeLQ4E+OU1UzLkumecjDAMX6cj6q1aC20s
         Ek+jcJb1Sw/cwbpA/5ky9xGaDirDFU5gI3W1cHLbLIwnh6HERV1dHlGFZrzD6UTKG9sV
         MLGw==
X-Gm-Message-State: AAQBX9cvkbvnjGSTtWBW6bmd0ZnrUxQKSOlJDK50usd1KbOj3a/Ig3nq
        ZcyLB+VZnYY1GsZy+Vv9QbHhqzpY3LgpLnCHZfzC9qL3
X-Google-Smtp-Source: AKy350buT0FrosicNx7UdhjFdlKkDhalNtlbVoPkwsu1upsGAh0MIDeCsc+o6pbwG/8gCnfjG9OoDB1ZcCA1pKdCpYE=
X-Received: by 2002:a17:906:9488:b0:931:ce20:db96 with SMTP id
 t8-20020a170906948800b00931ce20db96mr560344ejx.5.1680646187632; Tue, 04 Apr
 2023 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230330055600.86870-1-yhs@fb.com> <20230330055625.92148-1-yhs@fb.com>
In-Reply-To: <20230330055625.92148-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Apr 2023 15:09:35 -0700
Message-ID: <CAEf4BzbhsWVK45OXBSY4tz9v-z-8j7ndMT=3BK4aDvza8FVnkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index
 variable as precise
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 10:56=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
>
> For a loop, if loop index variable is spilled and between loop
> iterations, the only reg/spill state difference is spilled loop
> index variable, then verifier may assume an infinite loop which
> cause verification failure. In such cases, we should mark
> spilled loop index variable as precise to differentiate states
> between loop iterations.
>
> Since verifier is not able to accurately identify loop index
> variable, add a heuristic such that if both old reg state and
> new reg state are consts, mark old reg state as precise which
> will trigger constant value comparison later.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d070943a8ba1..d1aa2c7ae7c0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *e=
nv, struct bpf_func_state *old,
>                 /* Both old and cur are having same slot_type */
>                 switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
>                 case STACK_SPILL:
> +                       /* sometime loop index variable is spilled and th=
e spill
> +                        * is not marked as precise. If only state differ=
ence
> +                        * between two iterations are spilled loop index,=
 the
> +                        * "infinite loop detected at insn" error will be=
 hit.
> +                        * Mark spilled constant as precise so it went th=
rough value
> +                        * comparison.
> +                        */
> +                       old_reg =3D &old->stack[spi].spilled_ptr;
> +                       cur_reg =3D &cur->stack[spi].spilled_ptr;
> +                       if (!old_reg->precise) {
> +                               if (old_reg->type =3D=3D SCALAR_VALUE &&
> +                                   cur_reg->type =3D=3D SCALAR_VALUE &&
> +                                   tnum_is_const(old_reg->var_off) &&
> +                                   tnum_is_const(cur_reg->var_off))
> +                                       old_reg->precise =3D true;
> +                       }
> +

I'm very worried about heuristics like this. Thinking in abstract, if
scalar's value is important for some loop invariant and would
guarantee some jump to be always taken or not taken, then jump
instruction prediction logic should mark register (and then by
precision backtrack stack slot) as precise. But if precise values
don't guarantee only one branch being taken, then marking the slot as
precise makes no sense.

Let's be very diligent with changes like this. I think your other
patches should help already with marking necessary slots as precise,
can you double check that this issue still happens. And if yes, let's
address them as a separate feature. The rest of verifier logic changes
in this patch set look good to me and make total sense.


>                         /* when explored and current stack slot are both =
storing
>                          * spilled registers, check that stored pointers =
types
>                          * are the same as well.
> @@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *en=
v, struct bpf_func_state *old,
>                          * such verifier states are not equivalent.
>                          * return false to continue verification of this =
path
>                          */
> -                       if (!regsafe(env, &old->stack[spi].spilled_ptr,
> -                                    &cur->stack[spi].spilled_ptr, idmap)=
)
> +                       if (!regsafe(env, old_reg, cur_reg, idmap))
>                                 return false;
>                         break;
>                 case STACK_DYNPTR:
> --
> 2.34.1
>
