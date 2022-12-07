Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB950645013
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLGAPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLGAOx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:14:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA94B9A1
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:14:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a16so22675861edb.9
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 16:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xLd9Iz3rI/dDAyFoN6MxClTwZMLqlOMvTHoULJOwj0Q=;
        b=Uw58jhqJjbH2wujT/7X92HUEu7A/k6/NpUaZDo+giKDIqCW2NAjv7TFEcNHFVhQhz9
         jvhtB9U6qKme2rGsAhzdE6V5z20lSKXWO2UhGFGGuotXA9A647izFRsQFS90KwWJuhd9
         jeteMHDXlvv0WJwts/WcGlo2nx3L1W7FiMXmX8CHV//sfM/8BtiJOZK77bY/z6114a93
         kYKhWvegX2TFPWsxvTSQk/sw8OFGWVqpsW2gguBihmCxA3PCU2i4v6lBTlRdq4hx2rzs
         SQAh5SAp55YWysmRHQvS5Y9Tp5hzeUhd83H34pQPFYoLag2Mg/Z6GQEyyafPj+Q5A8Dg
         Iunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLd9Iz3rI/dDAyFoN6MxClTwZMLqlOMvTHoULJOwj0Q=;
        b=EcjfiqGRt6wYbp23tD9ldajPWA6/WXTHpawc2PT7MfolTAooLit5a9eK9lLkvGF+rY
         97/616lTDogCD83qymO4lI9UJl56iczfWX/Z0miXK2pS5JuY20kke2Kmj1BSG9OJckl/
         6cu6JtSHYCShoMT386LqOs0paIAkuw7IZgEsGwvKmLZKZ/fMTJWsZtC7R/76WTwYcX+C
         lHZHOL5rKsqovjpJZvaMWQJjjPjHMIWJLq1dR6tNUjhUNKriBpRrRylw09LfCMRNDYti
         WIpiTDORxVPqLNoUkx57ObG3M1PdVJcvNrrT4fbVoqVB4+SSPLyAdyIigCrClPpVxOcs
         C6vw==
X-Gm-Message-State: ANoB5pkkcGSoh7SAn+znQK4/BbW3UUO5Kfse5oCMW816d7UPE0xBgVKX
        k14G0lmMeHkgOjBZyWBMLWx5eHJ0dT99LEpkyoU=
X-Google-Smtp-Source: AA0mqf5DlGX5zyIvZOrooRu41NqTuvk/UkeRWad9r0dQVEmoVYoEjHrw2jbwGZRL7+fhIdEIrwHtFRIQY1DK6npUZ/U=
X-Received: by 2002:aa7:da10:0:b0:46c:43ff:6961 with SMTP id
 r16-20020aa7da10000000b0046c43ff6961mr16942714eds.14.1670372090214; Tue, 06
 Dec 2022 16:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20221205025039.149139-1-raj.khem@gmail.com>
In-Reply-To: <20221205025039.149139-1-raj.khem@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 16:14:38 -0800
Message-ID: <CAEf4BzYtGwponVcfMEK4wWgA=+jAHXzwy-gQmmvYx68MYLaQ9g@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build warning on ref_ctr_off
To:     Khem Raj <raj.khem@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Sun, Dec 4, 2022 at 7:01 PM Khem Raj <raj.khem@gmail.com> wrote:
>
> Clang warns on 32-bit ARM on this comparision
>
> libbpf.c:10497:18: error: result of comparison of constant 4294967296 with expression of type 'size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>         if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
>             ~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Check for platform long int to be larger than 32-bits before enabling
> this check, it false on 32bit anyways.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 91b7106a4a73..65cb70cdc22b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9837,7 +9837,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>         char errmsg[STRERR_BUFSIZE];
>         int type, pfd;
>
> -       if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
> +       if (BITS_PER_LONG > 32 && ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))

Where is BITS_PER_LONG defined? Is it a compiler-provided macro? A bit
hesitant about taking dependency on such a macro. Also quick googling
suggests user-space programs should use __BITS_PER_LONG?

Can you try if just casting ref_ctr_off to __u64 would make this
warning go away?

>                 return -EINVAL;
>
>         memset(&attr, 0, attr_sz);
> --
> 2.38.1
>
