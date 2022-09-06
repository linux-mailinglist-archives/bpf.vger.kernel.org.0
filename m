Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA055AF869
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIFXcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIFXb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:31:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDFB7F27A
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E39C0CE1903
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DB4C43470
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662507112;
        bh=CAI8hCkDtEWznLoikyeoRYgOzfv7bwbIiilNJHWaewA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h9C4pXphgzyP6elgeCvwRwHa87M3zCAw3ZNU46n0IAdp8IAQDDk/MhPHCUA8Z7Zxb
         0FamvqVENzKRoRgJ/uqw5+zN5Wa37QLk7C2kY1kcgGSuhOWN1yMVUURFHeSlY3iAuU
         eayq6v0rdZeuK7+1VypMuNTyb5K/GwlPmFVz7R1HkX6/FXTxI6O6SS2+nSh5l7ntMY
         45pOSWv2fNPFBDCD3yNGtGFXY+wcpiEeYfxT+pmq9jvEAYQNyzLJNwQPFzP02GO6bY
         60R3sUO51YMm5ib/YXYcoJAn3PPRoHvR9Q8UeSHfKDQDvW88plTzzVm0GfNTjWIXTs
         fCKpF0yTnRR+g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127d10b4f19so6278790fac.9
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:31:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo1LNWS+6EVpqx9vqmby/pX5bNhX0DqO3KuI374BV0UzjIeHXked
        10yPG41spEMW9OUa6xlAay6p3nmfQygoGXzXb2w=
X-Google-Smtp-Source: AA6agR6Huj9oEdYmEGTf8Cr00s3b5+vb8j+pg/o0Osg6px/3zl2qHyrpjEmfxqpiUsrLAqpyUycltjapY1gJLc3NtvQ=
X-Received: by 2002:aca:3016:0:b0:345:9d47:5e11 with SMTP id
 w22-20020aca3016000000b003459d475e11mr10436132oiw.31.1662507111842; Tue, 06
 Sep 2022 16:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-5-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-5-quentin@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 16:31:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6DXecC3OsjrL7na-OHM=B6KfhEx5P21en+-QRN-RU_UQ@mail.gmail.com>
Message-ID: <CAPhsuW6DXecC3OsjrL7na-OHM=B6KfhEx5P21en+-QRN-RU_UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] bpftool: Group libbfd defs in Makefile, only
 pass them if we use libbfd
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 6:44 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
[...]

>
> +# If one of the above feature combinations is set, we support libbfd
>  ifneq ($(filter -lbfd,$(LIBS)),)
> -CFLAGS += -DHAVE_LIBBFD_SUPPORT
> -SRCS += $(BFD_SRCS)
> +  CFLAGS += -DHAVE_LIBBFD_SUPPORT
> +
> +  # Libbfd interface changed over time, figure out what we need
> +  ifeq ($(feature-disassembler-four-args), 1)
> +    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
> +  endif
> +  ifeq ($(feature-disassembler-init-styled), 1)
> +    CFLAGS += -DDISASM_INIT_STYLED
> +  endif
> +endif


> +ifeq ($(filter -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
> +  # No support for JIT disassembly
> +  SRCS := $(filter-out jit_disasm.c,$(SRCS))
>  endif

This part could just be an else clause for the ifneq above.
Well, I guess the difference is minimal.

Acked-by: Song Liu <song@kernel.org>

>
>  HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> --
> 2.34.1
>
