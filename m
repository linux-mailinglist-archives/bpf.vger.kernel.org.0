Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7462216E
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 02:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKIBvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 20:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIBvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 20:51:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05566C8A
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 17:51:21 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b2so43090023eja.6
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 17:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xay9Rm42QTKsR0+BtUN+XwY0YlziWgMC9zUPdtHPWPQ=;
        b=YTCwIvTvozUuKDLBFE8V4JLi+9B9Xj3Qto/Qk2SVjsUjdgiQw7GfJX1B9mOu9wLhqV
         rawp5PrYVYhv9QkKjiFusMRz/IWheJoVqmi9v+cUOm53Byhlwu6574HPWbIeqpRb5KK/
         0faFySuy3t/Hy+N9SFK2pjxTNfZfTX1oGdIlY2wE2HiPMiNSZRWfmzIwFu1khnpx+ENj
         6Mo8GFj2RKiUCqKKlvSsEt9t/BCw56VvngofBANz9jXW4H+smof4CMLddmA61qHF7alo
         e27pcXlkQ+Q+RjlyDtfQoypycCtOQpvPn0eqCGnrc91ZnIpN7Jm7D3IXKjz+8lo7hOoP
         jGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xay9Rm42QTKsR0+BtUN+XwY0YlziWgMC9zUPdtHPWPQ=;
        b=UTqXjYAKDywyLSchryb4NEr09ZbBZMw2LBJTrh2tlp4BUBooW191ax8T+V8e2S8R/x
         5dpvxSJvVvaIUsXaJu8yhMMViFTmqswdiWggFR67kRVEa0xwQkT6v5ajnQYcl0nIFb9y
         3uiryepD511YSUpW4P0L7NhQGfshn8H/bngGh8Jjf9kaCpvE92LhZO3hDX/bEaqxRSfw
         cntpXGJqZ2pY60T0yqvO8kgoKXFY8Z/s020fewAQ6HNLWuu0uYNzTwZNfsxdr1dJDsNc
         gSaJ6ZamA1zkH9ScZhE15enqNhJm9wVuFcvd+6zVOcA1bqp+piGRM/0pkX/vib2LkQU0
         ZAyg==
X-Gm-Message-State: ACrzQf2+w+diQXkQEVaiMKeTP6EdqCASNVwxHLRafyHsCWOioFJO9Byu
        OtMIFpCAVrKmLaVGkxI5KzDN1T+WtkGv1HyM70Fipb5a
X-Google-Smtp-Source: AMsMyM6z2mdQ08HeTBoP5z1jNcqEGugEIMdBPGmiYKtiBpyKyIop4eY3bwmfrLs9wQ17TbdK5oynMOVzzjvCulRdWX8=
X-Received: by 2002:a17:906:1f48:b0:7ae:77d:bac with SMTP id
 d8-20020a1709061f4800b007ae077d0bacmr34970991ejk.708.1667958679845; Tue, 08
 Nov 2022 17:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20221027143914.1928-1-dthaler1968@googlemail.com> <20221027143914.1928-4-dthaler1968@googlemail.com>
In-Reply-To: <20221027143914.1928-4-dthaler1968@googlemail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Nov 2022 17:51:07 -0800
Message-ID: <CAADnVQKmzQJRX9KL06sbtpuQUO4A2Wc4Em+8--Y2Uku9fFPKRg@mail.gmail.com>
Subject: Re: [PATCH 4/4] bpf, docs: Explain helper functions
To:     dthaler1968@googlemail.com
Cc:     bpf <bpf@vger.kernel.org>, Dave Thaler <dthaler@microsoft.com>
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

On Thu, Oct 27, 2022 at 7:46 AM <dthaler1968@googlemail.com> wrote:
>
> From: Dave Thaler <dthaler@microsoft.com>
>
> Explain helper functions
>
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index aa1b37cb5..40c3293d6 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -242,7 +242,7 @@ BPF_JSET  0x40   PC += off if dst & src
>  BPF_JNE   0x50   PC += off if dst != src
>  BPF_JSGT  0x60   PC += off if dst > src     signed
>  BPF_JSGE  0x70   PC += off if dst >= src    signed
> -BPF_CALL  0x80   function call
> +BPF_CALL  0x80   function call              see `Helper functions`_
>  BPF_EXIT  0x90   function / program return  BPF_JMP only
>  BPF_JLT   0xa0   PC += off if dst < src     unsigned
>  BPF_JLE   0xb0   PC += off if dst <= src    unsigned
> @@ -253,6 +253,22 @@ BPF_JSLE  0xd0   PC += off if dst <= src    signed
>  The eBPF program needs to store the return value into register R0 before doing a
>  BPF_EXIT.
>
> +Helper functions
> +~~~~~~~~~~~~~~~~
> +Helper functions are a concept whereby BPF programs can call into a
> +set of function calls exposed by the eBPF runtime.  Each helper

eBPF right next to BPF looks odd. Let's stick to BPF everywhere?
