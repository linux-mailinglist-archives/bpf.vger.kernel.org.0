Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2DD6620D5
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 10:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAIJBt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 04:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjAIJBP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 04:01:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B441408F
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 00:53:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso3041551wmb.3
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 00:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9U5fLV8pJKDLKCn7wZ+oRG/22XsbHRmVQMRDRTsc8=;
        b=mR7/Zi3tcNZtFX6Ap9i4VCU2egxdUoXMbLOty/XRmmFLr+VB8mT3rXiiLGEQxj4gjq
         hOf+Iw/aTnDTYJan0MSm2A0wrZsh269eo6w9lQrG/7DtXBixVXBg8VBy9krBaPfNMsQ5
         FC1vJpUZEhg7ZOQa+7EkN1yuRuT/ySbof7XQTJmeJGviUDNdO3reZU/EAH++cpzLsaNH
         OMXPYeojlgICEKf1KxKdgkUlcBFn158DBEoqePARI4wkG2BvF2J7zTndEWpaNdyU1qEf
         tRP7nikOOiOHmY7UCjP1hIbNQ5HQv/Hu/5qkDeljem9QQ7/+9QLzw88sAD4wc5yrfenZ
         bkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O9U5fLV8pJKDLKCn7wZ+oRG/22XsbHRmVQMRDRTsc8=;
        b=IaWSaD4/zBnnhlnTvd8qJ6teWRN/A9wabGTqtok+GfXOFGxIJHHDRqxeB8aO5rBYYV
         VLpsKm+gh22A/XFsH3ZURzmasf+RYu+KN7HGsLUkB13bZxos+xESE856zeAEfvlyyCTu
         drfqFiPFGVHNndYZrwWx2xH4gScbESWikzBpXFfuOIjBWFv/oK6CYqY1yZbwzBNZ25Zc
         btbN7xWg82oSlcBNIbSB3sOIN2/MZd8Akwqp38fo+4EI/B9KF0K7fG5KKFXT7KeEm1yY
         nprnNDPe8fRV0rU7MQsiTk1YIiLaXdZAjaJvCA8LzomdW6GmiGQ1yQ8T8A/cFA/q/fT6
         xN+w==
X-Gm-Message-State: AFqh2koP3zWvN+DXWlyyh+F0hm/AqA4w5Vn20jOFThwyHLXETteseOBn
        cZqzEDzATZFpbG2/GF+c1bA=
X-Google-Smtp-Source: AMrXdXsndnnqVAs0W4ZcJKAUDUWkmlyg8pcgc0MHdRWbmbyKQM4q8JhOiWC8HsQeJyZ8iv4aK2PkEQ==
X-Received: by 2002:a05:600c:47d1:b0:3d3:496b:de9d with SMTP id l17-20020a05600c47d100b003d3496bde9dmr45777631wmo.34.1673254418665;
        Mon, 09 Jan 2023 00:53:38 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003c6c3fb3cf6sm10501113wmj.18.2023.01.09.00.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:53:38 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 9 Jan 2023 09:53:35 +0100
To:     Ludovic L'Hours <ludovic.lhours@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] libbpf: Fix map creation flags sanitization
Message-ID: <Y7vWD5osnN0e5LdY@krava>
References: <20230108182018.24433-1-ludovic.lhours@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108182018.24433-1-ludovic.lhours@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 08, 2023 at 07:20:18PM +0100, Ludovic L'Hours wrote:
> As BPF_F_MMAPABLE flag is now conditionnaly set (by map_is_mmapable),
> it should not be toggled but disabled if not supported by kernel.
> 
> Fixes: 4fcac46c7e10 ("libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars")
> Signed-off-by: Ludovic L'Hours <ludovic.lhours@gmail.com>

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a5c67a3c93c5..f8dfee32c2bc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7355,7 +7355,7 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
>  		if (!bpf_map__is_internal(m))
>  			continue;
>  		if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
> -			m->def.map_flags ^= BPF_F_MMAPABLE;
> +			m->def.map_flags &= ~BPF_F_MMAPABLE;
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 
