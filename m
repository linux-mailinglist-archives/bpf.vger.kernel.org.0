Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAAB50809C
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 07:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348011AbiDTFfG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 01:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiDTFfF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 01:35:05 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C636B63
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 22:32:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y11so334160ilp.4
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XE3rxgiSAO2VfvXKl3TwC0m83eWFy270pwPAUGprTE=;
        b=mBvN6CGc4g4IXG7EW0OhO1GVHjkB8eK5KRWKWPKcfPAuQ8nKOvj6aqGXypYe9cgk+F
         DUBU3clqSE+pMkU2F/BhhuBoMt3wJsJSaKsp3X+MwCILRNQx3JTdzmuEidQuGUwex6WN
         pUW3QiCSSjuiZoXj0aleX7cN0J7SCPZWncMpeI8A2C3vUur1VuPB6zqqHVvKTHMAJxa7
         Tr5BGfQQuIThBt/RZv3DGnqlVjb5zDM0xIkBKE/r3ym/n1SKkolA+SbUmN7bGmON7btg
         EhTsByqnI4DfwC/LrJvrT2R/K0m52omBYoIT5i4a19oTLN4S8GQZIWWv7NUXKlq5iC5U
         5tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XE3rxgiSAO2VfvXKl3TwC0m83eWFy270pwPAUGprTE=;
        b=62+n9HiE3Fv0DIKpDo93RrVrVFE4+1VbTe6F1latefh5szmgwf9NjqdrktOtMhrAil
         I3XZ5ft3MIlTXbRxr4Y5tvWq1EkixfyCA1slICSak0bisKfoumtebAwaxkieN3c7bMci
         EED5oF0/w8r+9ezCjGoqcolZb7CLgyUkyOOvtFx9F4HE1jbukKPMQLdn9MQasdXnxuKZ
         3kzVMvKFAYhnsKv2OvC/olgwyjwKgKxjgrZWEG9tyIGexPLS+voed2PBeJIiguWk+vdd
         vbd6sLHcCS2CbIpTg3h8i9+5JOrlJkqz/BATWiu8tdMeMFtlO2T4ZFPrMxkaFxts/xiA
         HSIw==
X-Gm-Message-State: AOAM532qSQtZK80356jT2HYKa9/QtWBJhVXipYFEwllVDyHK/nxCYpcF
        pZs1PjMCFcyvnQVEdpP088FoiZuoA1Au5aGvNNY=
X-Google-Smtp-Source: ABdhPJwj/QtbFiHopmkrmFOXjjtWr9fLAnYNcZWLpGHFd2DaQ1W08PHo4JbmKkcXfk2ZMrFkBAwtyV0W6KC+RDiWsz8=
X-Received: by 2002:a92:cd83:0:b0:2cc:1a66:6435 with SMTP id
 r3-20020a92cd83000000b002cc1a666435mr6301526ilb.252.1650432740302; Tue, 19
 Apr 2022 22:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160346.35633-1-grantseltzer@gmail.com>
In-Reply-To: <20220419160346.35633-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Apr 2022 22:32:09 -0700
Message-ID: <CAEf4Bzb0JsoSkbCBtDqyMxjQOjs2LZ5gMWiAeKk242pHV7ym8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] Add error returns to two API functions
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>
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

On Tue, Apr 19, 2022 at 9:04 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds an error return to the following API functions:
>
> - bpf_program__set_expected_attach_type()
> - bpf_program__set_type()
>
> In both cases, the error occurs when the BPF object has
> already been loaded when the function is called. In this
> case -EBUSY is returned.
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bf4f7ac54ebf..0ed1a8c9c398 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8551,8 +8551,11 @@ enum bpf_prog_type bpf_program__type(const struct bpf_program *prog)
>         return prog->type;
>  }
>
> -void bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
> +int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
>  {
> +       if (prog->obj->loaded)
> +               return libbpf_err(-EBUSY);
> +
>         prog->type = type;

return 0;

>  }
>
> @@ -8598,10 +8601,14 @@ enum bpf_attach_type bpf_program__expected_attach_type(const struct bpf_program
>         return prog->expected_attach_type;
>  }
>
> -void bpf_program__set_expected_attach_type(struct bpf_program *prog,
> +int bpf_program__set_expected_attach_type(struct bpf_program *prog,
>                                            enum bpf_attach_type type)
>  {
> +       if (prog->obj->loaded)
> +               return libbpf_err(-EBUSY);
> +
>         prog->expected_attach_type = type;
> +       return 0;
>  }
>
>  __u32 bpf_program__flags(const struct bpf_program *prog)
> --
> 2.34.1
>
