Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35ED62A155
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 19:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiKOSaR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOS36 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 13:29:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DE30544
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:29:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f27so38284066eje.1
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc7wVjBt3IG1h6qbbArhIbiMK7wp97B9RUYi54ZGNrI=;
        b=paJ7Jvz2sweZGIp5vujiyM6qQ6rO68h6rL1fwlDJduiKcZy1Kao5/9S0nKqBNHkZwj
         t1D/KyGGYjBay6RLeh/r96t/pILfJbCHoDTy+YkfXIWJpqYhnkOAUgQiLR8X6+x9zXOQ
         7rGa1fOJEdnEqMTwXZuTfkb9typBW8fkIzewQtTHDmsiU+3//Urc0mZrkkiZwa+rXx9b
         0KvmpIHPf5k3dVNGYUrAQYPntT7j/MkbKOk+BTyVSuE4nuJDNuDvUfvzB1NlJ07nXGlw
         /yM8Pfmi6rfvTiJVx/EJw0bY2o5Mf61nqrIBmPrTGr0EIrCyM7sl57oDBJz1WSMwCFp2
         ax0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc7wVjBt3IG1h6qbbArhIbiMK7wp97B9RUYi54ZGNrI=;
        b=vCKz4khDwNvAWmBsGSx3foAIH7ZHeJUWd2go2JF/U8PCf7n0z/zNVrHe3uZYIwXeNz
         YjiakHQgF39a0rkEN99oC1OTvrriwQB3aAK/hgajb27SZZQdEfOpNUbWjtE4WaAaEu52
         Oci2lA4SlewbWiDuB0rLiMknqpEL8SWqwcrbzrmc/yDNqpbT00NkoxRPQV29I2tGZ6Uq
         V49oVg4Vo5IgJqm8EolktfMwFQqvD1sii2ESykqvxIirwhZ1Rf9XIO8A8Oiec70AIMnT
         PoadN5sKnkw+LbuHkZM/ck/foA2Oni521bYMeMMB8UaO6w4wvtF4X46sujJiGyZtazaB
         moxA==
X-Gm-Message-State: ANoB5pmF6JekR9fTXfbCb77YMLDw/w39h78jUTENlSJQA1X2OwmtSFUg
        0YCLX6IfqH5rN3BzDkZ3IV4gEb+YdSMAkVS1OLA=
X-Google-Smtp-Source: AA0mqf7lss4aNKkgE6KSr0Dh0E8HBjk4YbaKmcoeTIf46effQTEVxAwW0ekI4H8JLWWB+r4EcvGB6ktXlGAWovKZB/Y=
X-Received: by 2002:a17:906:7ca:b0:7ad:934e:95d3 with SMTP id
 m10-20020a17090607ca00b007ad934e95d3mr14895676ejc.393.1668536984346; Tue, 15
 Nov 2022 10:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-6-memxor@gmail.com>
In-Reply-To: <20221115000130.1967465-6-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 15 Nov 2022 10:29:33 -0800
Message-ID: <CAJnrk1aq1bDfD5C5Cy-fdPo4TCeqhUO_ObONTBfTyWT-nZKAwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check to process_dynptr_func
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
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

On Mon, Nov 14, 2022 at 4:01 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> After previous commit, we are minimizing helper specific assumptions
> from check_func_arg_reg_off, making it generic, and offloading checks
> for a specific argument type to their respective functions called after
> check_func_arg_reg_off has been called.
>
> This allows relying on a consistent set of guarantees after that call
> and then relying on them in code that deals with registers for each
> argument type later. This is in line with how process_spin_lock,
> process_timer_func, process_kptr_func check reg->var_off to be constant.
> The same reasoning is used here to move the alignment check into
> process_dynptr_func. Note that it also needs to check for constant
> var_off, and accumulate the constant var_off when computing the spi in
> get_spi, but that fix will come in later changes.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 34e67d04579b..fd292f762d53 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5774,6 +5774,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>                 return -EFAULT;
>         }
>
> +       /* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
> +        * check_func_arg_reg_off's logic. We only need to check offset
> +        * alignment for PTR_TO_STACK.
> +        */
> +       if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> +               return -EINVAL;
> +       }
>         /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
>          * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
>          *
> @@ -6125,11 +6133,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         switch (type) {
>         /* Pointer types where both fixed and variable offset is explicitly allowed: */
>         case PTR_TO_STACK:
> -               if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
> -                       verbose(env, "cannot pass in dynptr at an offset\n");
> -                       return -EINVAL;
> -               }
> -               fallthrough;
>         case PTR_TO_PACKET:
>         case PTR_TO_PACKET_META:
>         case PTR_TO_MAP_KEY:
> --
> 2.38.1
>
