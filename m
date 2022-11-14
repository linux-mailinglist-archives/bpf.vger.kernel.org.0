Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69A628B70
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 22:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiKNVlO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 16:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiKNVlN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 16:41:13 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9726965D5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:41:12 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id x15so8653000qvp.1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qwBkjTdd5jtJOC/OquNUxjgZKP2m8mqYsSEix57QxVA=;
        b=02X1SVXaLkuhEshm386sz27xI7GZNDA6NwdAr47MnXOe5Hq+yqAbHliYU6Zv4GKUuZ
         XC+xudolL0clLLXNDBSMh1zbGp6HEvYSrLYzSiy0y3BD998jHS2ufXFhjs7Kle2FB70Y
         SBiuj87qK+qWS56yvMjMqAof4fe3Yr11+ECDdz6yWfZnomMc74R5+AqdyFrrhRp3cJP7
         jG2IaFP43S1BCCWKJB3BWPaQtZIR1daMipeOVULrWXclnuftC3pYQCaOtuLCef9zC7nD
         vErjFAXcBq+bfFalmof3soTZ/AHdBUGq8WCEOjHZJKyWi/Uzo+xENmB15oWpPCGAVKMK
         CG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwBkjTdd5jtJOC/OquNUxjgZKP2m8mqYsSEix57QxVA=;
        b=uSJVxNWnGkBOVIQr7YOB90qcaagF/9mUvH4jEOgWHPlfMn44gTQoME2wiZEbL77V2L
         CVa98bCJ9C63qtkinNBbAiceJbSPUBwDbkuVvgas+AtHl084j7YIJ47Ejd/Vvdqgrp5t
         D3MukgwMUSQe9fl+7eDfDiFAWjJ6VBWmoFU0NPlq1Wl4+mVSuAtHVJy0LQW8uKL7O2WO
         +02cu1wUgWOtyHYacYGXEN6wjxTDdkmuVDsrFrGyCcKGhuU14yUIli+TVL1si0qKz+qf
         gkCYNlGRmjkl0X1ajGvfaXWIfWabaUGmdH+0qHB3NHZqbDfnWy5x+lXs4lf9ljb3WOtl
         d3Dg==
X-Gm-Message-State: ANoB5pnIGLdNZT46zBWyEvKcjA4Hz5NpNIaJFqRx5GOvfq8r5mquDX0M
        KD1bXYwKwL7vbOAYH+EolGoqPrxXu4v6+jwqE5cR8Wt+iNE=
X-Google-Smtp-Source: AA0mqf7Nd4grmFzP091sfChhM0PA/AjenhViPHAwHHOAW6fC/MhgpedtyP6FTvk8TUiutSAnxDI5ZBPOh6pPbkAT5T0=
X-Received: by 2002:a05:6214:5a07:b0:4bb:70d5:5b15 with SMTP id
 lu7-20020a0562145a0700b004bb70d55b15mr13888056qvb.12.1668462071771; Mon, 14
 Nov 2022 13:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20221113101438.30910-1-sahid.ferdjaoui@industrialdiscipline.com> <20221113101438.30910-3-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221113101438.30910-3-sahid.ferdjaoui@industrialdiscipline.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Mon, 14 Nov 2022 21:41:00 +0000
Message-ID: <CACdoK4KBR9LJvgMkJA_iXTdnn46boYH1Jty=j_GDxDcEwVB9pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpftool: replace return value
 PTR_ERR(NULL) with 0
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 13 Nov 2022 at 10:15, Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> There is no reasons to keep PTR_ERR() when kern_btf=NULL, let's just
> return 0.
> This also cleans this part of code from using libbpf_get_error().
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/struct_ops.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index e08a6ff2866c..1a235d0c6742 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -62,11 +62,8 @@ static __s32 get_map_info_type_id(void)
>         if (map_info_type_id)
>                 return map_info_type_id;
>
> -       kern_btf = get_btf_vmlinux();

This line was seemingly removed by mistake.

> -       if (libbpf_get_error(kern_btf)) {
> -               map_info_type_id = PTR_ERR(kern_btf);
> -               return map_info_type_id;
> -       }
> +       if (!kern_btf)
> +               return 0;
>
>         map_info_type_id = btf__find_by_name_kind(kern_btf, "bpf_map_info",
>                                                   BTF_KIND_STRUCT);
> --
> 2.34.1
>
>
