Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940105964A2
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiHPVcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHPVcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:32:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ADD89CF6
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:32:03 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j17so9146192qtp.12
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pFzVOu3hVK0yb7sEGfFTFE8wv5SAKyPxZ+6D+5zxSaQ=;
        b=XxQeepEaE0eo4PRbZ619lKy0njo0bdg7+GHJ4Ms4OkBwT2lfazJKfDE31dgkb1XSnW
         ScIMcqpDvW2PvZaRQJyEKIDxaxhK8voX2qqbFC/OyK51JdKSHNMgmjoqM4Y2AZvDp+Nt
         4EMUKN0PYAT2RYqxm2t4o3/70m66VvvhAetkl1VQQDZGSr0cPtt8yWcdSC7Kr1whBGWN
         FXkWjB/ipbxNnELLpZ1zuWcW3M4pxdXmHPoUUH6HZ3IeUnwrnc/PQpOUG7BgJRlJfn/j
         FcMwV99hMG4uOYiLAoj85HOosKPzhAGveEygn1kygLksotMoMJrRQQ8CPpPz74iYty0t
         2Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pFzVOu3hVK0yb7sEGfFTFE8wv5SAKyPxZ+6D+5zxSaQ=;
        b=PI3SfkiP0g2Q0KV4EFGKeZoS2VEmUiefB0rSZ8MiM2Mxh+ywZI90rT+0FvGPDDq7Rv
         dlX2KwH22bweGWz5AuWlC5f8VHb8AVnwaeeoiGoLnUdG9TophFfEaAvLMK4y84TPO79f
         KBiH0fx7+DNyYsR8zuQ44mkRWcAmpyJ9gQR8yM4rSuFDL8mr6/5H9SuJvG5fjkbzFVF9
         +6ns6eQI+xxkrKjs7PFqTDJLLTR2zBYYFrAyUZC4jxx8lMwXz7wmQ+Tf6oWMNXld4g54
         Myj3SxC+/odIi6z6ZXOPzFTzu6mBWIMd28EWdu9ZhOqf7SU3D6L/wOiJiwzwfGyCgtNr
         KfLQ==
X-Gm-Message-State: ACgBeo1wEaInhDNTFPmfbyDtwnlOh/Z8bII2d8DnrPWLjx2x4p9iX76Z
        detlPSrU01I79n1P9AV3f/S6DVePjITleaFuF2f2oA==
X-Google-Smtp-Source: AA6agR6BJ7XgLyOromS5YWAPjXOYRnC1zxnFkTgtACKHMrnj8SwzFe+oTAuG/AaF1L6cxiwSy13L3sXSHdrULa1s4KA=
X-Received: by 2002:ac8:7f04:0:b0:343:36d:9a1f with SMTP id
 f4-20020ac87f04000000b00343036d9a1fmr19861941qtk.566.1660685522945; Tue, 16
 Aug 2022 14:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-2-andrii@kernel.org>
In-Reply-To: <20220816001929.369487-2-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 14:31:52 -0700
Message-ID: <CA+khW7i-7PEMjPfn3JE=Woa-iAX7ddyO9zxFuxgvRAPL0jpkFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] libbpf: fix potential NULL dereference when
 parsing ELF
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 8:52 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix if condition filtering empty ELF sections to prevent NULL
> dereference.
>
> Fixes: 47ea7417b074 ("libbpf: Skip empty sections in bpf_object__init_global_data_maps")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Hao Luo <haoluo@google.com>

> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index aa05a99b913d..5f0281e61437 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1646,7 +1646,7 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>                 sec_desc = &obj->efile.secs[sec_idx];
>
>                 /* Skip recognized sections with size 0. */
> -               if (sec_desc->data && sec_desc->data->d_size == 0)
> +               if (!sec_desc->data || sec_desc->data->d_size == 0)
>                         continue;
>
>                 switch (sec_desc->sec_type) {
> --
> 2.30.2
>
