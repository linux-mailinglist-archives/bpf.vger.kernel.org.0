Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247FC5F1046
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiI3QvQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiI3QvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 12:51:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE01A1EBC
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:51:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso5386388wmq.4
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CitDTLj6oeUlOT8/MxFinS24qjs4jy/QcNKsXeutb7A=;
        b=oEvxe1ILVvb62hsZdJH2e01sQJP+WRF7xZI2qitAqlUfBQgL/PUgk+hrYEOhY9WyWd
         jizcFzfQxq3HMPfFH56uw67RDJet/n/GYhHcrVX+dmB+KG1eOxzyWm9azr7sj+ktrxlL
         cxB3ILCOYGsGVk9a/V/uvHzPoQGKvGZb45QXdSL+0tPmos+McCtfoA2LL2b5eTMTDFGF
         R1lZlFuh+bptc/HUf2mQNucUnx2zeHe3JAmFxSZKNoa0chKFmEsmRURWOYezMMJRo3gG
         MtbIjyblDSfvfJBQUUeYvqh4XRpAv5XY3jpdVQIzY6G19LQ3bgkOo0CpVdjhm0koAenn
         2AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CitDTLj6oeUlOT8/MxFinS24qjs4jy/QcNKsXeutb7A=;
        b=uBy0Yk69BgHJQjhPOPXC6U6IZ6tIAWPodRCRh+wBQvJlnGcqPFf8j0LDaRwAQZAyRk
         SsFA89vpv6ZyCeM1OrAFw6FdRNgfrbTe7Sbbe2monugAys5lF8y0OgYJl6jW9TIPOxX+
         pDKXMrr9uA4tjWA8qwQtmuUDJOPld4umCDmL8mxKSTesd+Wfat2ONey3/thfzOfqh88r
         7o22XFueYhLX4Ls+8JJahL1NppWreHQZAgZFv4LQeMKEFE4LexD+DYMFGwJNGn+RzabP
         7PeWPP+WWYpI7SvRvdypyjH0H85u2SiXR6QT59mfn8hcOKSM1Ez6r7TPXHbIKHxFUNdm
         nEPQ==
X-Gm-Message-State: ACrzQf2ZgRNGJa1FA9R+zvw4VpmEiZwoyVdTFBoe3MD/ODfgm80pDx8L
        echbYEsdHL1/13GvJiY83P4sEw==
X-Google-Smtp-Source: AMsMyM7NSie8C9fMkr8XonrI9M1mlg5/r4ZOIMdVKI8YELUKRILb8TJlHkGWOpi5x+j+WQe+CRyJHg==
X-Received: by 2002:a05:600c:1c89:b0:3b4:a612:c3e0 with SMTP id k9-20020a05600c1c8900b003b4a612c3e0mr6452765wms.20.1664556670398;
        Fri, 30 Sep 2022 09:51:10 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d6a43000000b0022cc0a2cbecsm2418322wrw.15.2022.09.30.09.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:51:09 -0700 (PDT)
Message-ID: <6983d329-d743-03dd-f091-5ec68030fe49@isovalent.com>
Date:   Fri, 30 Sep 2022 17:51:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] bpftool: Fix error message of strerror
Content-Language: en-GB
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     bpf@vger.kernel.org
References: <SY4P282MB1084AD9CD84A920F08DF83E29D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <SY4P282MB1084AD9CD84A920F08DF83E29D549@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wed Sep 28 2022 09:09:32 GMT+0100 ~ Tianyi Liu <i.pear@outlook.com>
> strerror() expects a positive errno, however variable err will never be
> positive when an error occurs. This causes bpftool to output too many
> "unknown error", even a simple "file not exist" error can not get an
> accurate message.
> 
> This patch fixed all "strerror(err)" patterns in bpftool.
> Specially in btf.c#L823, hashmap__append() is an internal function of
> libbpf and will not change errno, so there's a little difference.
> Some libbpf_get_error() calls are kept for return values.
> 
> Changes since v1: https://lore.kernel.org/bpf/SY4P282MB1084B61CD8671DFA395AA8579D539@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM/
> Check directly for NULL values instead of calling libbpf_get_error().
> 
> Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> ---
>  tools/bpf/bpftool/btf.c           | 11 +++++------
>  tools/bpf/bpftool/gen.c           |  4 ++--
>  tools/bpf/bpftool/map_perf_ring.c |  7 +++----
>  3 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 0744bd115..933177bdd 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -640,10 +640,9 @@ static int do_dump(int argc, char **argv)
>  
>  		btf = btf__parse_split(*argv, base ?: base_btf);
>  		err = libbpf_get_error(btf);
> -		if (err) {
> -			btf = NULL;
> +		if (!btf) {
>  			p_err("failed to load BTF from %s: %s",
> -			      *argv, strerror(err));
> +			      *argv, strerror(errno));
>  			goto done;
>  		}

I thought we could get rid of libbpf_get_error() entirely, but I hadn't
realised "err" is later returned by the function. We'll need a pass to
clean these up eventually, but this is beyond the scope of your patch.
Thanks! And good catch for hashmap__append().

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
