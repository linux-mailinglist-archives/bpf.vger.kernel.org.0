Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D580686F62
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjBAT5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 14:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjBAT5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 14:57:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327710AA3
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 11:57:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mc11so32220431ejb.10
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTpT6TDwXeNAxEBQfoAUKv2R7Zm2ElEx/h1CXkHpkIQ=;
        b=c2dOj0gU6MWTdQlWzd3a1M22aupufg1ULuIii58pweltmXbI+lgRNwtDsRDDnWIV9J
         8yDav8iaMAbpXC6Lyy0xUuc8Nz3q0bZtgiQVz/7lvvUITFTbbsMl/tvZs+tuGVhl/Pbj
         vZOCWoFsjYEMFaNrLhDRE5cLtM8pU7Igw/Jb7PA1eyWyyXBpIHl4Up1UpelDrV05gJjn
         mwKcglI1+1DLfW9xmBE1Bs9rBv5ow3QlGjc3EM+hUc/Bu56OC3R3CrXJAy2tHjSteZn5
         k4VcUqdcj/sfBJTvs2AOTNOVhpF47yB2VT6SXr4DQQD02VO3u8CVmit3PrlaUmj8US7H
         ZoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTpT6TDwXeNAxEBQfoAUKv2R7Zm2ElEx/h1CXkHpkIQ=;
        b=kOeQev859wLl8kbeWFZCVDerAaF9hr07k5MGIuJBwMkDR7Pq4oViKHkyclpDxBZL3p
         7ibRZf3vvZ7iarmxKWvbwzQEeBLC6k/IidFFaCFl3InftqNWxdx5bPDzN/cPEfc9rMLo
         LBG8RZcooAHkWt53LBmbOcLOs1yUFbXKnyYKFmdtQ64kwRbTW3hRz/zOPCOj6sUoyoHx
         M/eLq90/WCh01ygE2qCrFp4KrfnCzR4Iyq3h2G3J9QekjVpqlQAAUhMwtitFWfsDE99c
         gfo2+7G2iI1RQRaOVXjwpsUYGrb/6vfPsaSgA2XLTWuNTvgK6FKnAyWgXhuBan1eiK/j
         CdEg==
X-Gm-Message-State: AO0yUKXy7CTVI3JGiO1Snz4xxheLlC8AW8MLs+f0qcSIRpYhGjeHHZGE
        NkhwNF1c0Ip8+AXXlLH7jm0=
X-Google-Smtp-Source: AK7set9sjtAwhqqgoODByvwISsefvdo+TZ0Xwq1T2wyZjw9n5ZC9YlPumMzOQSVqn1+4FdRKgTgclw==
X-Received: by 2002:a17:907:6d15:b0:885:fcbd:40d3 with SMTP id sa21-20020a1709076d1500b00885fcbd40d3mr5253357ejc.8.1675281422236;
        Wed, 01 Feb 2023 11:57:02 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906394900b00872a726783dsm10430190eje.217.2023.02.01.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 11:57:01 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 1 Feb 2023 20:57:00 +0100
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
Subject: Re: [PATCH bpf-next v1] libbpf: Add wakeup_events to creation options
Message-ID: <Y9rEDDF7qqSs1wSs@krava>
References: <20230201090009.114398-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201090009.114398-1-arilou@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 01, 2023 at 11:00:09AM +0200, Jon Doron wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add option to set when the perf buffer should wake up, by default the
> perf buffer becomes signaled for every event that is being pushed to it.
> 
> In case of a high throughput of events it will be more efficient to wake
> up only once you have X events ready to be read.
> 
> So your application can wakeup once and drain the entire perf buffer.
> 
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  tools/lib/bpf/libbpf.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..6b30ff13922b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>  	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>  	attr.type = PERF_TYPE_SOFTWARE;
>  	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = 1;
> -	attr.wakeup_events = 1;
> +	attr.sample_period = OPTS_GET(opts, wakeup_events, 1);

hm, but I think we still want every event.. setting sample_period to X
would store only every X-th bpf-output event, no?

jirka

> +	attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
>  
>  	p.attr = &attr;
>  	p.sample_cb = sample_cb;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8777ff21ea1d..2e4bdfc58c82 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1246,6 +1246,7 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
>  /* common use perf buffer options */
>  struct perf_buffer_opts {
>  	size_t sz;
> +	__u32 wakeup_events;
>  };
>  #define perf_buffer_opts__last_field sz
>  
> -- 
> 2.39.1
> 
