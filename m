Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264D06E0136
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDLVw1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVw1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:52:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07151448F
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:52:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f3ebcso304154766b.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsmVQxyo0nhecKaoB7BWPbhGC1hDy/r40pIQ9ksYMjE=;
        b=REAuXRZdH/yabAmCli8HtmwsO7VdvtV1agxL/3X4adNmvuXH1TrdZMe8PheGp11KK2
         KYXHBlTToR5tBgqbzp034y0FqbEnQv78hYMoXCp2aJ9W2w/RRpcoJncIPuovMh+fGK2Z
         oz51KWwahjG+bMMkJ5kPDD35eUyOESxlONFIH2cs0AiNjiWiIZkY8kMCG52EbGD5+qmQ
         3unE4ulM6OO6z89sKFRKs/7IYx0jN5ZqSu+KCFvyNAcOpXy9vAB3JB02+a3BNN+gCaK8
         05TaZUhZN3v5WOHp1m8auvO4wjG2XH62b0SzgRskPFmJpz/8Ag1F9rLVEZ4O1zOQSRpE
         7PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsmVQxyo0nhecKaoB7BWPbhGC1hDy/r40pIQ9ksYMjE=;
        b=S+ZyUiZ3bLle1hgSroBkYh2XE4m4hmTs5bJTX8M8BwAekeAM4/hOSLCDHQh64vOO5Z
         +iAwzDP+aMrPXTX4syV7UTNJW/jBAuO4Y6PkQvivbT/G/6nNsg1zKoSbjrJ+Lcde11WE
         Yo/5TsA1Y+B900InKECgSuqsi5oCGTReLajJzI3P6Rf5VVXr8xkoaWHSqTeM3VKOAJBf
         E86uWD48CxoX2TG/tL/FrATmUPzyMbn7qzx6M9H0rz8OU6upM5hJOd6fAIuyQttAs6Ae
         merw6PY975L46gxpz5n8vi4BHNJJr+Smq0CCgyQUAfC2i1mUPFcwRo7OLP540vm+btCM
         f+Jw==
X-Gm-Message-State: AAQBX9cYuW3WdpRE5OVayOu8Qm2Qne8JcWI0GzwJIMDQEf4EWNIAqdVW
        8EUjeFIY3UlmQjft4HjlyvUiMqgSHqiV3MMj7h0=
X-Google-Smtp-Source: AKy350Z25LTN25mohdKa5Sy06L4K4mg+4xPWdu3YMVaczNZMX1VpcYAlLQfoLjzCtIMlUdn0fjeO1Ni1bheqMMHFG7M=
X-Received: by 2002:a50:aa9c:0:b0:4fc:f0b8:7da0 with SMTP id
 q28-20020a50aa9c000000b004fcf0b87da0mr105619edc.1.1681336344451; Wed, 12 Apr
 2023 14:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com> <20230409033431.3992432-4-joannelkoong@gmail.com>
In-Reply-To: <20230409033431.3992432-4-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 14:52:12 -0700
Message-ID: <CAEf4BzbHcBLi9ru2rgL59HNGCjYP+zksbjvzmkirYevWu8jM-A@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> bpf_dynptr_get_size returns the number of useable bytes in a dynptr and
> bpf_dynptr_get_offset returns the current offset into the dynptr.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h      |  2 +-
>  kernel/bpf/helpers.c     | 24 +++++++++++++++++++++---
>  kernel/trace/bpf_trace.c |  4 ++--
>  3 files changed, 24 insertions(+), 6 deletions(-)
>

[...]

> +__bpf_kfunc __u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
> +{
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       return __bpf_dynptr_get_size(ptr);
> +}
> +
> +__bpf_kfunc __u32 bpf_dynptr_get_offset(const struct bpf_dynptr_kern *pt=
r)

I think get_offset is actually not essential and it's hard to think
about the case where this is going to be really necessary. Let's keep
only get_size for now?


> +{
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       return ptr->offset;
> +}
> +

[...]
