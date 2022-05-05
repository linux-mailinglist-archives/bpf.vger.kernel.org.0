Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6551BCFF
	for <lists+bpf@lfdr.de>; Thu,  5 May 2022 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355287AbiEEKTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 May 2022 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351993AbiEEKTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 May 2022 06:19:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6273251E4F
        for <bpf@vger.kernel.org>; Thu,  5 May 2022 03:15:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 129so2346159wmz.0
        for <bpf@vger.kernel.org>; Thu, 05 May 2022 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z6OmioYcg+Gg/DbvEZYcuCPLgkbvxe3adzL1pGEHZ0c=;
        b=EhXwJqcvKC0UCQoKKIA79e/HPCM8+4KWqDDi+8TCTcXLgRLd2R9dv96T1dpM6SDRJO
         e905oVoA1gkElVZg7CeEpyyQr0mYIlbpZZh2ZnUHEcIAGVgDyiBBPRRDLDG8UeAWZ/Ld
         AbldpHiDDSIouItWreIg3JFLmdh59V60L/B1TJC/zUjgM7BfGa+IV/W0iZq5tsjBN5kH
         2IYzR+jy8cmxQz4qHx7Ys5S0yKfPu3ZFhEYqu5O8zBugsMSvUDyBq2Ek9TgQM+fSCoZH
         plVp73ye1y7djh75TZSBrRrhaA9HOYbdojYH9Xx2Jp+vfPK6vftniX6DkQ0EYAaeMZy3
         bZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z6OmioYcg+Gg/DbvEZYcuCPLgkbvxe3adzL1pGEHZ0c=;
        b=kSM3gGSHc14P3vPLrBPMQFuEFVlak2V5f8ffXUg7qvg0TRMtFtwRsmRMryLYd7/R9y
         n5rt6yTyM9s4JTaUcxxK4dBwaEtq7E199B9N8yyUXSA/q/8CP4Tm1vvdsBtu+niZQoPb
         UE8o1E99JIQIwD8zWE6J5/1ML5hMpfNGCmU4jg4kyeQ4A5w4N5uKZ8iZ8Jr959r5iQrM
         /XVJriWmRIL9pr1tlofx9iMRUz9kzzFR57W50yaBgc8Bm2/UJCTz3/pXpG999K2w/gmE
         Mlg867wi6o7TlNZ779MgnX1vGrDBuZIOOUKYxGScFwbTxv3K+SVHEcaCa2UYx8Jp5Kh0
         JE8A==
X-Gm-Message-State: AOAM531ED4zJUY23Iye4G7XrSnSTd1UXJNJyWvMSLnZrSER6Wc6vaND2
        bapwWlHCQ3xvHG2p47ErOXJSBA==
X-Google-Smtp-Source: ABdhPJyEng2b6Eu4gOFH/LVREzpQIIvEEGpAdMcNZM+/Ca8rhv/dNHz8RRJnrgn/W1H2BtkWI28Law==
X-Received: by 2002:a05:600c:1991:b0:393:ef28:7ab2 with SMTP id t17-20020a05600c199100b00393ef287ab2mr3854226wmq.20.1651745749849;
        Thu, 05 May 2022 03:15:49 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c211300b003942a244ebesm1075441wml.3.2022.05.05.03.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 03:15:49 -0700 (PDT)
Message-ID: <d8358294-83df-1a4c-aae9-64d3a4910a0e@isovalent.com>
Date:   Thu, 5 May 2022 11:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH bpf-next 0/2] bpftool: fix feature output when helper
 probes fail
Content-Language: en-GB
To:     Milan Landaverde <milan@mdaverde.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220504161356.3497972-1-milan@mdaverde.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220504161356.3497972-1-milan@mdaverde.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-04 12:13 UTC-0400 ~ Milan Landaverde <milan@mdaverde.com>
> Currently in bpftool's feature probe, we incorrectly tell the user that
> all of the helper functions are supported for program types where helper
> probing fails or is explicitly unsupported[1]:
> 
> $ bpftool feature probe
> ...
> eBPF helpers supported for program type tracing:
> 	- bpf_map_lookup_elem
> 	- bpf_map_update_elem
> 	- bpf_map_delete_elem
> 	...
> 	- bpf_redirect_neigh
> 	- bpf_check_mtu
> 	- bpf_sys_bpf
> 	- bpf_sys_close
> 
> This patch adjusts bpftool to relay to the user when helper support
> can't be determined:
> 
> $ bpftool feature probe
> ...
> eBPF helpers supported for program type lirc_mode2:
>     Program type not supported
> eBPF helpers supported for program type tracing:
>     Could not determine which helpers are available
> eBPF helpers supported for program type struct_opts:
>     Could not determine which helpers are available
> eBPF helpers supported for program type ext:
>     Could not determine which helpers are available
> 
> Rather than imply that no helpers are available for the program type, we
> let the user know that helper function probing failed entirely.
> 
> [1] https://lore.kernel.org/bpf/20211217171202.3352835-2-andrii@kernel.org/
> 
> Milan Landaverde (2):
>   bpftool: adjust for error codes from libbpf probes
>   bpftool: output message if no helpers found in feature probing
> 
>  tools/bpf/bpftool/feature.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> --
> 2.32.0
> 

Looks good to me, thank you

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
