Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F704BBD05
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiBRQJI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 11:09:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiBRQJH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 11:09:07 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6DECC76
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 08:08:49 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qx21so16068449ejb.13
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O5twPjM7X0srGo3B3a6rDev2c+Nzwoe8biU/Lfon52w=;
        b=bd8GoHJoFAygz47vYlWEZeLXamFxBxWxVIEKGwnCVjbBUv6Ep3Cj8R6vEp8r5ziKyF
         GGMGmpfnSURCyhjq41SPLlGG4kIAjRcvXdh+JRptpyOWcHMVJmShy+3wIP4lGzQ4AHfU
         sKadO+t1GmAXWg69YtOZxMyiBDmcmaPO7mFa6X0Nj/B2CB09hwTrPMUmQ8u3ZOnbixaa
         33RTIT8mdg+PFk0XaggQRW0astjOkWxBiycei/vi1woSCEP7FnBZokmLZuz12I9q3CZH
         k+LZvUVVDx6L56di+ZTr69/jHHCJI+0sTVIjMHNj/InqmGRr9XNW8t9s9D5xGQsGiCtf
         mGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O5twPjM7X0srGo3B3a6rDev2c+Nzwoe8biU/Lfon52w=;
        b=BJjjZYWskeNC+GsoqxGbf11yoAAq/DN0AlvXMrn6P3TM0p8r3uuR7JXpuGzb+eNhvy
         KAxIplKP2POzJ7Oh/8K6q7d5gZwJSip6BXDTPf/RcGNPHxx2ztUrGvetj1WI+wmP82+h
         nUIX+yNJM37bKL7afiy17NxydW+9ssF7XGQn1G5clo5mtzZQGUZQr8ufR80yfBHN/1NC
         lpda/An/9xkPlKHg2gYEqIvEjYG6A81qCADAfhhiLJMcvL6KIdc4MBP/2KSxMxmEYxPP
         H6c/gFu+B92OhK794ZuA1I5ZGFKRNxduF06u9yWMDdi9rST7Ty0iNnPRLNnVj6iq0jJ7
         8HUw==
X-Gm-Message-State: AOAM532N+x/+v6IFZM5FSqoaGuNOJjVDtk2Tclf1IaZYDmfhBVxIx2xH
        CO3Jx4z2MFV7/JdCO2+WnLoOMzgsQzXcvQ==
X-Google-Smtp-Source: ABdhPJwCTAHIuyrATDL1++wE6KJdJTx8le4J1XfGInTQOom01InRjX+vRHoEJuaui0LT44QhMMY4+Q==
X-Received: by 2002:a17:907:12d5:b0:6cf:bb0d:9b2f with SMTP id vp21-20020a17090712d500b006cfbb0d9b2fmr7047243ejb.138.1645200528340;
        Fri, 18 Feb 2022 08:08:48 -0800 (PST)
Received: from [192.168.1.8] ([149.86.76.251])
        by smtp.gmail.com with ESMTPSA id eq6sm4655777edb.83.2022.02.18.08.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 08:08:47 -0800 (PST)
Message-ID: <8c890e30-d701-0da4-c6f9-f5ca7d80d7ee@isovalent.com>
Date:   Fri, 18 Feb 2022 16:08:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bpftool: Allow building statically
Content-Language: en-GB
To:     Nikolay Borisov <nborisov@suse.com>, andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org
References: <20220217120435.2245447-1-nborisov@suse.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220217120435.2245447-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-02-17 14:04 UTC+0200 ~ Nikolay Borisov <nborisov@suse.com>
> Sometime it can be useful to haul around a statically built version of
> bpftool. Simply add support for passing STATIC=1 while building to build
> the tool statically.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> Currently the bpftool being distributed as part of libbpf-tools under bcc project
> is dynamically built on a system using GLIBC 2.28, this makes the tool unusable on
> ubuntu 18.04 for example. Perhaps after this patch has landed the bpftool in bcc
> can be turned into a static binary.
> 
>  tools/bpf/bpftool/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 83369f55df61..835621e215e4 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -13,6 +13,10 @@ else
>    Q = @
>  endif
> 
> +ifeq ($(STATIC),1)
> +	CFLAGS += --static
> +endif
> +
>  BPF_DIR = $(srctree)/tools/lib/bpf
> 
>  ifneq ($(OUTPUT),)
> --
> 2.25.1
> 

Why not just pass the flag on the command line? I don't think the
Makefile overwrites it:

    $ CFLAGS=--static make

Quentin
