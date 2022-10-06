Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E505F6DC9
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 20:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiJFS7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 14:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiJFS7A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 14:59:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88AC7054;
        Thu,  6 Oct 2022 11:58:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so4195320edj.0;
        Thu, 06 Oct 2022 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb/bk8BNpi2tKTbf7/cObESzZiIZJYv/Q4YOIC+HPd0=;
        b=YYuG6HxYgeBzNGd94W7hp26h+G0406sfTbHxlXnUyMGJIEZDeSyp10hzk1a7KP9eLF
         /JyU1RgF2kMjLV9EQ15q4YTo7akAEfAQeHPBDERIHCpwnW6x98CnKZy2DD5f+VM4kaIN
         QKarG47tPXX1YVbmsDSQIJn0+kXxSjG7HqQwIeRb6ZKzw1IM+qXnHxYVo3jKIqq6k73h
         rf8NLKQDFpOYbMYRw2CMV4O/qRQWZyaZAWL4C71mUluvvE+wEy7X0sOM2onHvZEsefvT
         fPo0MixAS8uHtDN6V/4D1cR7flVf1j14ZGYp9LV4sLu9HJ8GgixnQzHcaL5UWQ6us66S
         fiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb/bk8BNpi2tKTbf7/cObESzZiIZJYv/Q4YOIC+HPd0=;
        b=p3gaq5gjX/DWt+gOLhhSP3hGPz0yxcPa3qRo1KGNN/sV+9lck6ZkL47hGIsFavPvww
         VZt3mOU0Ob/RKFp2D710CN85/tyYv9CVegKlHtKjLRh5+KdvEYhcGhEujRg9huuGa7mm
         SFydHOW9pW8y1Occ6vElYdJ0A2I+0eiYhwAwTPnXXuvB+DkVf9nqZgvGuOhDH021U1Du
         Pl4WoyoB8+Yd+u6HTrZVgiCuT1RKhY+ajR+8JY24ZCmWrSKyWJSNu7DngpG6PKTMIRpX
         zrUr4qkRKJgmVUj2zbHHyNJjISxLR8ysrI2MpavV/LlLzxYz3jKEgzyf42QXb4HXZlA0
         wTCg==
X-Gm-Message-State: ACrzQf3RQiObcFTn4aCwL7lAn11oiTxM6zJdp0un75wTlCcohUxE8wt5
        gg/50mFVCx0sSxeSGEBfUZM=
X-Google-Smtp-Source: AMsMyM7EPjvFFVwiB7qUDbwpU2mC3BFf/NBxSjoYwuLpamqsH7Rl8o6eK+Bysi8cX3UmUJYYOuSf5A==
X-Received: by 2002:aa7:c78e:0:b0:456:c524:90ec with SMTP id n14-20020aa7c78e000000b00456c52490ecmr1191935eds.192.1665082737280;
        Thu, 06 Oct 2022 11:58:57 -0700 (PDT)
Received: from krava ([83.240.62.156])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b00772061034dbsm50947ejf.182.2022.10.06.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:58:56 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 20:58:54 +0200
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     tip-bot2@linutronix.de, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, namhyung@kernel.org,
        peterz@infradead.org, x86@kernel.org, iii@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com, svens@linux.ibm.com,
        tmricht@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH] Re: [tip: perf/core] perf: Use sample_flags for raw_data
Message-ID: <Yz8lbkx3HYQpnvIB@krava>
References: <166434824149.401.4361243714612738808.tip-bot2@tip-bot2>
 <20221006160044.3397237-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006160044.3397237-1-sumanthk@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 06, 2022 at 06:00:44PM +0200, Sumanth Korikkar wrote:
> Hi,
> 
> This causes segfaults.
> 
> Steps to recreate:
> *  Run ./samples/bpf/trace_output
> BUG pid 9 cookie 1001000000004 sized 4
> BUG pid 9 cookie 1001000000004 sized 4
> BUG pid 9 cookie 1001000000004 sized 4
> Segmentation fault (core dumped)
> 
> Problem:
> * The following commit sets data->raw to NULL, when the raw data is not filled
> by PMU driver. This leads to stale data.
>    
> * raw data could also be filled by bpf_perf_event_output(), bpf_event_output()
> ...
>  686         perf_sample_data_init(sd, 0, 0);
>  687         sd->raw = &raw;
>  688
>  689         err = __bpf_perf_event_output(regs, map, flags, sd);
> ...
> 
> * The below patch eliminates segfaults. However, contradicts with
> the description mentioned in this commit (Filled by only PMU driver).

hi,
could you please resend the patch with formal changelog and Fixes tag?

thanks,
jirka

>   
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 49fb9ec8366d..1ed08967fb97 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
>  
>         perf_sample_data_init(sd, 0, 0);
>         sd->raw = &raw;
> +       sd->sample_flags |= PERF_SAMPLE_RAW;
>  
>         err = __bpf_perf_event_output(regs, map, flags, sd);
>  
> @@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>         perf_fetch_caller_regs(regs);
>         perf_sample_data_init(sd, 0, 0);
>         sd->raw = &raw;
> +       sd->sample_flags |= PERF_SAMPLE_RAW;
>  
>         ret = __bpf_perf_event_output(regs, map, flags, sd);
>  out:
>   
> --
> Thanks,
> Sumanth
