Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798C96DA37A
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbjDFUjn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbjDFUj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:39:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0E11E88
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:35:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jw24so4240685ejc.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2oAg152dw2mwjYFRiEAtQKEW78SoVrJACwlAVnVIx0=;
        b=TTNJvxQRmaqXjhGbnztfhlPgElzQ27hQEb9D68n8UBaf4mftr6oBJcLjihBGHk6odf
         9pk+jdkYcGnE07jIXfC+F/j6344yYBP1X9JB+/FP5nTeLh2nIVPr/epbpBGQ6bRnKVXf
         YmIBx+xstej/jyJwWHwbsGYYHevBxXVKTQAu308yKJAhcX1kbXkID1FHAYkun/Hz1ohX
         giCdTDYAIvePFzOkmwU7g+DirJ0AQY7gi4MXyv36SVFYojsiqrUX7HuA6DF4iIoX6QMw
         g8Wvv6uRAccKK4cFiKS5NK60QPlSC09HTU/O2NgbbPngb7CvD/pI9YYZU3Ag+JCO6lCD
         Hfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2oAg152dw2mwjYFRiEAtQKEW78SoVrJACwlAVnVIx0=;
        b=EbFC+MNZjHrkhg3qVvFolp7ptwvZPQHE3bp21iOzjSQA8DAxeYnFW83IctMEsJmm+9
         2HKAErckli9+s0r8UDFt7CBJqXKWGU+IMywUx1LciWndPrqdWx/3f0Y8U81RpXHo8dYZ
         ZCZ6yqeeZ5dLLn1PajIz6l2cDuLIxHgB8qLNhdFw08sMWSyozjtuK2+seo8RnA0AkZEX
         OVSCq/ULsN4mPWUKx3EKW+AQ7twwYk9umysrJznT2CA7zHWd0+8ewDY/RXlZT4i4P9PP
         9RhxD2OM1NHeG8mWFTz7g+Bm1vL4d7GiULL7iVMsFZ6k6etWleT/PxXi9XJWkQ3cK0ZO
         EDHQ==
X-Gm-Message-State: AAQBX9cLQ3l8SyVlSo66dqx1t63uaiBOh7WM0iHRPZYJYNcWvjDM9On6
        tdGa9vlPKTqnfOt5wCa6u3H1E5t8WBdj29m2YZE=
X-Google-Smtp-Source: AKy350bX0KoMyihEJpEJzyUUckTfeOMqgTt6AFqWykRAgHCx2sKjpHvG0baf3u7ZL5mMxBN3mNddEruv1in+5u1hTHA=
X-Received: by 2002:a17:906:3287:b0:930:310:abf1 with SMTP id
 7-20020a170906328700b009300310abf1mr87795ejw.5.1680813335716; Thu, 06 Apr
 2023 13:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230406164450.1044952-1-yhs@fb.com> <20230406164455.1045294-1-yhs@fb.com>
In-Reply-To: <20230406164455.1045294-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:35:23 -0700
Message-ID: <CAEf4BzZF_ApUScNqHcHA4VQ2NUL8vKYpVq2b0wOfLdXbo=CN7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Improve verifier JEQ/JNE insn branch
 taken checking
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

On Thu, Apr 6, 2023 at 9:45=E2=80=AFAM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
> whether the branch is taken or not only if both operands
> are constants. Therefore, for the following code snippet,
>   0: (85) call bpf_ktime_get_ns#5       ; R0_w=3Dscalar()
>   1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=3Dscalar(umin=3D3)
>   2: (b7) r2 =3D 2                        ; R2_w=3D2
>   3: (1d) if r0 =3D=3D r2 goto pc+2 6
>
> At insn 3, since r0 is not a constant, verifier assumes both branch
> can be taken which may lead inproper verification failure.
>
> Add comparing umin/umax value and the constant. If the umin value
> is greater than the constant, or umax value is smaller than the constant,
> for JEQ the branch must be not-taken, and for JNE the branch must be take=
n.
> The jmp32 mode JEQ/JNE branch taken checking is also handled similarly.
>
> The following lists the veristat result w.r.t. changed number
> of processes insns during verification:
>
> File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns    (DIFF)
> -----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  ---------------
> test_cls_redirect.bpf.linked3.o                        cls_redirect      =
                                        64980      73472  +8492 (+13.07%)
> test_seg6_loop.bpf.linked3.o                           __add_egr_x       =
                                        12425      12423      -2 (-0.02%)
> test_tcp_hdr_options.bpf.linked3.o                     estab             =
                                         2634       2558     -76 (-2.89%)
> test_parse_tcp_hdr_opt.bpf.linked3.o                   xdp_ingress_v6    =
                                         1421       1420      -1 (-0.07%)
> test_parse_tcp_hdr_opt_dynptr.bpf.linked3.o            xdp_ingress_v6    =
                                         1238       1237      -1 (-0.08%)
> test_tc_dtime.bpf.linked3.o                            egress_fwdns_prio1=
00                                        414        411      -3 (-0.72%)
>
> Mostly a small improvement but test_cls_redirect.bpf.linked3.o has a 13% =
regression.
> I checked with verifier log and found it this is due to pruning.
> For some JEQ/JNE branches impacted by this patch,
> one branch is explored and the other has state equivalence and
> pruned.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 56f569811f70..5c6b90e384a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12651,10 +12651,14 @@ static int is_branch32_taken(struct bpf_reg_sta=
te *reg, u32 val, u8 opcode)
>         case BPF_JEQ:
>                 if (tnum_is_const(subreg))
>                         return !!tnum_equals_const(subreg, val);
> +               else if (val < reg->u32_min_value || val > reg->u32_max_v=
alue)
> +                       return 0;
>                 break;
>         case BPF_JNE:
>                 if (tnum_is_const(subreg))
>                         return !tnum_equals_const(subreg, val);
> +               else if (val < reg->u32_min_value || val > reg->u32_max_v=
alue)
> +                       return 1;
>                 break;
>         case BPF_JSET:
>                 if ((~subreg.mask & subreg.value) & val)
> @@ -12724,10 +12728,14 @@ static int is_branch64_taken(struct bpf_reg_sta=
te *reg, u64 val, u8 opcode)
>         case BPF_JEQ:
>                 if (tnum_is_const(reg->var_off))
>                         return !!tnum_equals_const(reg->var_off, val);
> +               else if (val < reg->umin_value || val > reg->umax_value)
> +                       return 0;
>                 break;
>         case BPF_JNE:
>                 if (tnum_is_const(reg->var_off))
>                         return !tnum_equals_const(reg->var_off, val);
> +               else if (val < reg->umin_value || val > reg->umax_value)
> +                       return 1;
>                 break;
>         case BPF_JSET:
>                 if ((~reg->var_off.mask & reg->var_off.value) & val)
> --
> 2.34.1
>
