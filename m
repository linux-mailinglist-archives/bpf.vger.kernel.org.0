Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD231A99E
	for <lists+bpf@lfdr.de>; Sat, 13 Feb 2021 03:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBMCKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBMCKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 21:10:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06AEC061574
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 18:09:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z7so764964plk.7
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 18:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g61dSmORtMH1xkaVe49/euCkjNUNspnF3AJsyurmKW0=;
        b=UbM+69SOcAlEE4iPfdGUNWP1vcKTOA7tetgjDuTh5IkZsgAfI4E1q66teq0w51+T26
         4GxqFcf6v9oIjz4KPIDcJGCtGgYu6wRMYo4Zx8we3HwtONqqaShMhH3DstTx6N/+6aYm
         le4htzImL6Grcwg5A19pZjHY5oHILCBMWxrNKUY2fKhkheler4KVstvu+gXMk6eSuWBQ
         1SMAYstJyrrVcPgCnk+VZqM/BxZdJQDRgoG3Xe7qFwD2fEk83gIaNYv2/WVinEDLjnDa
         5mBHNYHyxLi9lBZREarZuyrBE+MC/6RA8wFZWC/YvsMliiM0xI5piYLDxM8qcRXondKN
         96AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g61dSmORtMH1xkaVe49/euCkjNUNspnF3AJsyurmKW0=;
        b=SOtdcxUVi/V6KVJe1z7SWBHQYF7VHj7KdkdxT4Wi42pZWm3Ar8RSI+zI9nzaZKVAdi
         lmB/MScUSzdZiOK+JgaSiYn+PgqVSnZd+259KsRNtEJurMf9Xth0lUoslw2El17ww4bW
         V65H07XISgWiWV8IazmPi0O5h4Cq7ZSNPRtBIRawa591+tudzS2TFc6jEL21DWhaqSNf
         OwlqtbHZwMA7FOuPEn5LSsSEJqLO5WoxjltQ0DyEO5jJIIK70w/NJKJDzRIQtgDFye5P
         M6d4SRv6PHYjKUaAUV1VBDA2VTVuBIEI0izPhCbrSRdd/vFvO9Ph3DOFiGpM57+QJO7n
         2x7w==
X-Gm-Message-State: AOAM532bg1OoSooTOtv6V4F2sGxKRrbh2QPwcsssv1FMfVK+XjxiVKDK
        YpBvNidFTntRncSlSj5ZX3Q=
X-Google-Smtp-Source: ABdhPJy4kohaZ8ar2/TuBnl8lglzoiZkLOMQgpUYvvfrbVZQTtpQDyrPxJzNo/z+tT57qhf5sFn23g==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr5359974pjb.229.1613182180249;
        Fri, 12 Feb 2021 18:09:40 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4ab7])
        by smtp.gmail.com with ESMTPSA id y24sm9968471pfr.152.2021.02.12.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 18:09:39 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:09:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Support pointers in global func args
Message-ID: <20210213020937.g6lt3pczqbjj5h2u@ast-mbp.dhcp.thefacebook.com>
References: <20210212205642.620788-1-me@ubique.spb.ru>
 <20210212205642.620788-4-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212205642.620788-4-me@ubique.spb.ru>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 13, 2021 at 12:56:41AM +0400, Dmitrii Banshchikov wrote:
> Add an ability to pass a pointer to a type with known size in arguments
> of a global function. Such pointers may be used to overcome the limit on
> the maximum number of arguments, avoid expensive and tricky workarounds
> and to have multiple output arguments.

Thanks a lot for adding this feature and exhaustive tests.
It's a massive improvement in function-by-function verification.
Hopefully it will increase its adoption.
I've applied the set to bpf-next.

> @@ -5349,10 +5352,6 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  			goto out;
>  		}
>  		if (btf_type_is_ptr(t)) {
> -			if (reg->type == SCALAR_VALUE) {
> -				bpf_log(log, "R%d is not a pointer\n", i + 1);
> -				goto out;
> -			}

Thanks for nuking this annoying warning along the way.
People complained that the verification log for normal static functions
contains above inexplicable message.

>  			/* If function expects ctx type in BTF check that caller
>  			 * is passing PTR_TO_CTX.
>  			 */
> @@ -5367,6 +5366,25 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  					goto out;
>  				continue;
>  			}
> +
> +			if (!is_global)
> +				goto out;
> +
> +			t = btf_type_skip_modifiers(btf, t->type, NULL);
> +
> +			ref_t = btf_resolve_size(btf, t, &type_size);
> +			if (IS_ERR(ref_t)) {
> +				bpf_log(log,
> +				    "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
> +				    i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
> +					PTR_ERR(ref_t));

Hopefully one annoying message won't get replaced with this annoying message :)
I think the type size should be known most of the time. So it should be fine.

> +		if (btf_type_is_ptr(t)) {
> +			if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> +				reg->type = PTR_TO_CTX;
> +				continue;
> +			}

Do you think it would make sense to nuke another message in btf_get_prog_ctx_type ?
With this newly gained usability of global function the message
"arg#0 type is not a struct"
is not useful.
It was marginally useful in the past. Because global funcs supported
ptr_to_ctx only it wasn't seen as often.
Now this message probably can simply be removed. wdyt?
