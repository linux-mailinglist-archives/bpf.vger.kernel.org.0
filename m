Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13436587249
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 22:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiHAUYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHAUYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 16:24:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB93ED4F;
        Mon,  1 Aug 2022 13:24:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so8435835ejp.13;
        Mon, 01 Aug 2022 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=VGHWLnPOuI0iW4HF+EMCDJDCZmTKff3mWYUEzLkNfiw=;
        b=dAzPq79++vwSq3w9xA+4dohDcZvqi0e0ZQ0sY20qPIv0KLftLe3e63OzidprZpDuoI
         dUcHn7uiB6ShtYIQEPH3oA23MVDDdQc/IBZUvm+nLbF8YFnVOdvokA/6adhir8ew94VV
         jDnADahwtP6A6hkTmXRV0krv2F+5BjZ04OB12O1eB8CqKY4ebhE2Kz4CJTajnzEBIQVe
         QYUcHbGs2Dw2OG8HsnIy7x/e9DC2Z6IVTYVomM5jdVsgUeXjHI/8mcJ+22uYBuQBIQaW
         cHcpGZp1pKi9mFeyMF1yuAFgwasQMxksaltwAlZc8QXa29StcOgY+ok9GDdvczOC8pej
         m6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=VGHWLnPOuI0iW4HF+EMCDJDCZmTKff3mWYUEzLkNfiw=;
        b=DPcbn64dLvy3IhLUDK59FIUKJMC3rM1umU6ElIeGrdNdsNhUfoo4KK9au73+D8ArrH
         nAUqwWZiDqS7HrNDncCa19Vwm7vB6S/G/i0ZqLJlLpSvlOPr4FKuPDErPdvFXmLKunnJ
         +iHv8tx429P5JWnb8cav9rM+/AgHngvB2x1mLuK8XuuBQ+C70RwIUmHvIf6NQw/EN7N/
         Sy/LL9R8OHls4PyKLxo4rZBw7puC7uyhvFUJLhqybUMFigvcaTM1Xtf21XIcIb1wDGPj
         1ByMe6Pe2ew7SerCtSmAJbhyix2agnE/S8UMGH57OCRO6peREy+bKZ/7epdx50Rqip29
         2wRA==
X-Gm-Message-State: AJIora/yzCshTgfDxIozmIOFZAqRXJ3WU8aNBGVCMigZONxRWoEuLg1D
        h20QmlHZ/sNqHrFmq4sRY5U=
X-Google-Smtp-Source: AGRyM1t3kp3muaqngGlm0Nz2Rmtd9ZP/PZxNvexVuNje+xgIsmXZMoTPLIjVHEmigwBTkt2r3eWYUw==
X-Received: by 2002:a17:907:2d90:b0:72f:5bb:1f32 with SMTP id gt16-20020a1709072d9000b0072f05bb1f32mr14043465ejc.758.1659385483943;
        Mon, 01 Aug 2022 13:24:43 -0700 (PDT)
Received: from krava ([83.240.62.89])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906301300b006fef0c7072esm5579555ejz.144.2022.08.01.13.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:24:43 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 1 Aug 2022 22:24:41 +0200
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Faust <david.faust@oracle.com>
Subject: Re: [PATCH] libbpf: skip empty sections in
 bpf_object__init_global_data_maps
Message-ID: <Yug2iYQyd0TNlnHW@krava>
References: <20220731232649.4668-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731232649.4668-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 31, 2022 at 05:26:49PM -0600, James Hilliard wrote:
> The GNU assembler generates an empty .bss section. This is a well
> established behavior in GAS that happens in all supported targets.
> 
> The LLVM assembler doesn't generate an empty .bss section.
> 
> bpftool chokes on the empty .bss section.
> 
> Additionally in bpf_object__elf_collect the sec_desc->data is not
> initialized when a section is not recognized. In this case, this
> happens with .comment.
> 
> So we must check that sec_desc->data is initialized before checking
> if the size is 0.

oops David send same change but I asked him to move the check
to bpf_object__elf_collect [1] .. but with your explanation this
fix actualy looks fine to me

jirka


[1] https://lore.kernel.org/bpf/YuKaFiZ+ksB5f0Ye@krava/

> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 50d41815f431..77e3797cf75a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>  	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
>  		sec_desc = &obj->efile.secs[sec_idx];
>  
> +		/* Skip recognized sections with size 0. */
> +		if (sec_desc->data && sec_desc->data->d_size == 0)
> +			continue;
> +
>  		switch (sec_desc->sec_type) {
>  		case SEC_DATA:
>  			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
> -- 
> 2.34.1
> 
