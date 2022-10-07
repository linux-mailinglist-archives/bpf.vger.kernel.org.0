Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDB5F766C
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJGJpn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJGJpm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 05:45:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A148C9D;
        Fri,  7 Oct 2022 02:45:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so6455666wrr.3;
        Fri, 07 Oct 2022 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQkrLmzT3Pvs6KFi5WAH9SS4PAeF6bOPV5uy+VMuFaU=;
        b=URWhMdnZurrj0JGkaHhZWS1Hb/wxi0oCu8/3WD0OIL65EtHWMnklxQ5XqxkIjTL/B5
         N7xpNnpQ+M8rKHRQFHYb+paRvh0EyNlN4EEUzu9CCRmTeHiVRNU/OwCXr2YchUlcof3e
         fevesm1nDkiNOXckaZO9/J4RT0wSUXaEGoKREPrlJBPo0O8082l8MKf8Zb49/PjF2TCS
         m2snA09tMpIoKXLCQu7c9iuXj9PTan9gdlQ79UdkKAuaUxrqaxr1wDmC1s7cx7mgfsCY
         9E5AIUFXpoRWDapYlzKFqxkuhPMThRplkkW2XHoJO+wUa9ssFtuP1EPwk82oxDc6HA2T
         jbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQkrLmzT3Pvs6KFi5WAH9SS4PAeF6bOPV5uy+VMuFaU=;
        b=UAzdWD32NFubJe0yYDj2QicvoB2ZVXHvTH0wudZZ2jj9avxgvad0yvgBbcrTLer4lC
         AAuiQMdEzxJnZdfR4iY95M7M9BBkYJfiY24FbyhcPt/0Kr8TKlBoor46s+ypuAHsr6nY
         KlH0bsDKBVeQCGJ1p4ULwM+YfxWVFE5XEasXvSjlqVKZu1gB8pmvzHO6o2/ku/KnrBww
         oDkr2KjSKPS7AaVGu7BzCB8gHCjtoEBr0XUt6MBw/sLGL22MrB/4w26yXi2a8vFp6YtP
         GHl69IrRDLkhPlsTZIyMPCiZUWqWsBh4rIwKR1yRAVahG9i9J/nMzc8eS902bILCp2lG
         vM6A==
X-Gm-Message-State: ACrzQf1R9vDNsxdanz+m0how/d+oAnY69wL0UTdepOpqAkGUkspkufvl
        w2WDFiZlVXozPcwoUCWkoaY=
X-Google-Smtp-Source: AMsMyM7n+NI3gVVcc2w9u29r2TQ7mzmd/4mQneSIxf8PvyH/zA3P6p6aUGX9oUN4sLE6BbdJqjQapw==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr2603406wrr.583.1665135939037;
        Fri, 07 Oct 2022 02:45:39 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c48a700b003a5537bb2besm1686541wmp.25.2022.10.07.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:45:38 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 7 Oct 2022 11:45:36 +0200
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>, peterz@infradead.org
Cc:     olsajiri@gmail.com, bpf@vger.kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, iii@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, namhyung@kernel.org,
        svens@linux.ibm.com, tip-bot2@linutronix.de, tmricht@linux.ibm.com,
        x86@kernel.org
Subject: Re: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
Message-ID: <Yz/1QNGfO39Y7dOJ@krava>
References: <Yz8lbkx3HYQpnvIB@krava>
 <20221007081327.1047552-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007081327.1047552-1-sumanthk@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 07, 2022 at 10:13:27AM +0200, Sumanth Korikkar wrote:
> * Raw data is also filled by bpf_perf_event_output.
> * Add sample_flags to indicate raw data.
> * This eliminates the segfaults as shown below:
>   Run ./samples/bpf/trace_output
>   BUG pid 9 cookie 1001000000004 sized 4
>   BUG pid 9 cookie 1001000000004 sized 4
>   BUG pid 9 cookie 1001000000004 sized 4
>   Segmentation fault (core dumped)
> 
> Fixes: 838d9bb62d13 ("perf: Use sample_flags for raw_data")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

Peter,
I think this should go through your tree again?
bpf-next/master does not have sample_flags merged yet

thanks,
jirka

> ---
>  kernel/trace/bpf_trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 49fb9ec8366d..1ed08967fb97 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
>  
>  	perf_sample_data_init(sd, 0, 0);
>  	sd->raw = &raw;
> +	sd->sample_flags |= PERF_SAMPLE_RAW;
>  
>  	err = __bpf_perf_event_output(regs, map, flags, sd);
>  
> @@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>  	perf_fetch_caller_regs(regs);
>  	perf_sample_data_init(sd, 0, 0);
>  	sd->raw = &raw;
> +	sd->sample_flags |= PERF_SAMPLE_RAW;
>  
>  	ret = __bpf_perf_event_output(regs, map, flags, sd);
>  out:
> -- 
> 2.36.1
> 
