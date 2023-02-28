Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4346A5925
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjB1Mfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 07:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Mfq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 07:35:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6DD2ED58
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 04:35:44 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 16so5511397pge.11
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 04:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhWe8sLMccBLRrPsWcYHRaaybNDxZ0zi1CaL4lrAFvc=;
        b=iJtweGpDdSTqN2kXZgyLyRHBqBC9GUkRRoy6rynxSdBwc/xi7Vbq/3f2N94C5mLujq
         w9EG2wiCllviId6GNDlLkbXFwd3mXYXseKL95wKTB6KmEQRjBHJCGbOqKmbCti3DI+ge
         /jjBYZdSq+2BssKiI8DTPI5TE4zup3ctckwnYAZoqcHmwlnU/lF34WLBlpPh5DbmZW1x
         OnYjrkr1l05OXbW3P7CY1B6CopBD27raod6Z7rbWXHCofjgDskhx3QBlMTRKsjTh8d0+
         GZZSBSrne7Q72pybnSMNmSC0ZLCujlURHmZoqWO/H6Tviay4BkJWod6ZfRaG33ptLhER
         A9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhWe8sLMccBLRrPsWcYHRaaybNDxZ0zi1CaL4lrAFvc=;
        b=0xHoqpW6qn+gGCoKt6rBCo/M7oODiY28+ee8wY6dZ0U3nPhLXLQccgVR9DF+K4eBn6
         tJwrsz3GpYFg7k5Zuo+sGDd01iEDdpZBQegoSZDa8P1VLl8o141cjgjRvjK0XTAWhTz8
         V0B5viPkaV4q80BerzP+oi1kakpEC6QgSuPzzc1xxmLh3N6A8Sk8iIn/Aau4Oj9FaeVE
         Efiq1BM1il/6v9zxHYzN7blHQxD51tEXmqURFlkTXDJ64AUQZ10jB7navhsmU8b5VLH+
         r4wL7oQlyAyWrWpu3ly+gBJsgYzw7emx15tUZeiuMJwC9sFdIK+hobGB5GbcAIjFUgOG
         MVaA==
X-Gm-Message-State: AO0yUKVAe7F/JFdwD16FOSMnT63wBzTF8iALct1FnCTrGxtXTIZlLcwy
        k+afLgA+qG6husRSEqAYHMpmMhC/kBME9psGYhPrAw==
X-Google-Smtp-Source: AK7set982toa957BfsESaT9p96TlyfxqaTB6xdGDJ93u6JOrGrfrsLteEwl7OmrMxFUw0AK+STVOgMbUnjwZ3PQRWHE=
X-Received: by 2002:a63:7807:0:b0:502:f4c6:b96 with SMTP id
 t7-20020a637807000000b00502f4c60b96mr701622pgc.5.1677587743821; Tue, 28 Feb
 2023 04:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20230228113305.83751-1-jiaxun.yang@flygoat.com> <20230228113305.83751-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20230228113305.83751-2-jiaxun.yang@flygoat.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Tue, 28 Feb 2023 13:35:32 +0100
Message-ID: <CAM1=_QTwYqAH+21fNnG3aBW-cV8vxtgM7h=enqZYaj2wbRnV8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: ebpf jit: Implement DADDI workarounds
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, paulburton@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

On Tue, Feb 28, 2023 at 12:33=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
>
> For DADDI errata we just workaround by disable immediate operation
> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.
>
> All other use cases in JIT won't cause overflow thus they are all safe.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop 64BIT ifdef
> ---
>  arch/mips/Kconfig            | 1 -
>  arch/mips/net/bpf_jit_comp.c | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 37072e15b263..df0910e3895c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -64,7 +64,6 @@ config MIPS
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_EBPF_JIT if !CPU_MICROMIPS && \
> -                               !CPU_DADDI_WORKAROUNDS && \
>                                 !CPU_R4000_WORKAROUNDS && \
>                                 !CPU_R4400_WORKAROUNDS
>         select HAVE_EXIT_THREAD
> diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
> index b17130d510d4..a40d926b6513 100644
> --- a/arch/mips/net/bpf_jit_comp.c
> +++ b/arch/mips/net/bpf_jit_comp.c
> @@ -218,9 +218,13 @@ bool valid_alu_i(u8 op, s32 imm)
>                 /* All legal eBPF values are valid */
>                 return true;
>         case BPF_ADD:
> +               if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> +                       return false;
>                 /* imm must be 16 bits */
>                 return imm >=3D -0x8000 && imm <=3D 0x7fff;
>         case BPF_SUB:
> +               if (IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS))
> +                       return false;
>                 /* -imm must be 16 bits */
>                 return imm >=3D -0x7fff && imm <=3D 0x8000;
>         case BPF_AND:
> --
> 2.37.1 (Apple Git-137.1)
>
