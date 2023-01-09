Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF566230E
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 11:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjAIKVa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 05:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjAIKVH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 05:21:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9818C55BC
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 02:19:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8618794wmb.2
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 02:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7ln18gh0cveP+txYIsnJtyV5X57FZM4Umsy/KCQLVQ=;
        b=sZ8qxHUW0zYeLBPidLmXQxqNbv7j8/ngLmuwpRF6lAHypXNSvDpOWoVQ5bPB+Ybhpm
         ljOVAlpv2j5GhUhivrqv0vhlDx4Cf/rgO3wwXmjDrZp2rAeyV2Gzqw/fIcNWUVG1H7ag
         mNvhQZprIM0LVR40hLUespSB4hTDohK4Toy5Hw5D3NKG4CnEeqRn9xOHmgAhbKAB2ac8
         SpfCUxAfEB4zCU97t+eQi1OygzUYpcGHCSpXgtzARJxEdlJboqo8eFhnf14OdtbadojG
         Jo+3KiwWR/+2NgqYkqvoghp1fABkdyHIKvc/5+HReEPg/WuOaM59Z2cUnidiVgbouLgE
         BBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7ln18gh0cveP+txYIsnJtyV5X57FZM4Umsy/KCQLVQ=;
        b=cDRKnur6NR4YFrIdf76REuv3pQZiOy0ZHQEjAJ291Z3jK47oybzjNE2NgB2i3n6e+W
         8t2x/zwS/D5/vZnVq4uTtzhuZoZdA39ZT8+bDVxKZRh7r0FfzECjb2cWl87VeCZTdW0a
         9pHD8ipuD71ftkjxBsXyK3NS/RhzAo8vlSsVEK1cOTvHERHKaz/FZUEZy8xo1yIq+rOe
         9Auux7dgoNMYy5SSnQ9wuqZQJpd5W34+9rNndJOn6gEYnT/5BLpIYis68KxEbN6Dlcn3
         kumvKlHU33qsPBteTUtOK1eev/KoPZQfBzyIncfxJ9A1+XR7eu0b/seYOBBzRKmF9I01
         suTA==
X-Gm-Message-State: AFqh2kqh1RC1IfY1YMgsgjc/ovLGNfbN3NvcUXO1LTnlY9PF4IzTbICJ
        hrZayc2d6RsMoFi2wUpFR3jS4V3gqAloVlxHZfM=
X-Google-Smtp-Source: AMrXdXtrHPxJ+fJaeDqn4kJjpkwBy+7B/6KNeafpQx3JuK6K0MiDA9nsEMRSxoSDrUbv2xEWnFecmA==
X-Received: by 2002:a05:600c:3509:b0:3cf:93de:14e8 with SMTP id h9-20020a05600c350900b003cf93de14e8mr45279792wmq.39.1673259541109;
        Mon, 09 Jan 2023 02:19:01 -0800 (PST)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003a84375d0d1sm16442246wmc.44.2023.01.09.02.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:19:00 -0800 (PST)
Message-ID: <a457e653-6253-69e1-d2fd-f11b00ef49ef@isovalent.com>
Date:   Mon, 9 Jan 2023 10:19:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] bpftool: fix output for skipping kernel config
 check
Content-Language: en-GB
To:     Chethan Suresh <chethan.suresh@sony.com>, bpf@vger.kernel.org
Cc:     Kenta Tada <Kenta.Tada@sony.com>
References: <20230109023742.29657-1-chethan.suresh@sony.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230109023742.29657-1-chethan.suresh@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-01-09 08:07 UTC+0530 ~ Chethan Suresh <chethan.suresh@sony.com>
> When bpftool feature does not find kernel config
> files under default path or wrong format,
> do not output CONFIG_XYZ is not set.
> Skip kernel config check and continue.
> 
> Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  tools/bpf/bpftool/feature.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 36cf0f1517c9..da16e6a27ccc 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -486,16 +486,16 @@ static void probe_kernel_image_config(const char *define_prefix)
>  		}
>  	}
>  
> -end_parse:
> -	if (file)
> -		gzclose(file);
> -
>  	for (i = 0; i < ARRAY_SIZE(options); i++) {
>  		if (define_prefix && !options[i].macro_dump)
>  			continue;
>  		print_kernel_option(options[i].name, values[i], define_prefix);
>  		free(values[i]);
>  	}
> +
> +end_parse:
> +	if (file)
> +		gzclose(file);
>  }
>  
>  static bool probe_bpf_syscall(const char *define_prefix)

Thanks!

This will remove the output for the kernel config options in case the
config file is not found, including from the JSON output. I can't
remember the motivation for printing negative values in that case, at
the time. I'm somewhat concerned to see the JSON entries disappear when
the config file is missing. Ideally, we should have an alternative state
for when config file is not here; but even using a specific string in
that case could play badly with scripts expecting that the kconfig
option is set if the JSON probing output contains anything else than
'null' for that entry.

So I think we can go with this patch indeed, and see if anyone complains
about it. After all, this is consistent with what we do elsewhere: We
skip entirely most probes if BPF_SYSCALL is not set, or probes for
helpers related to unsupported program types.

Acked-by: Quentin Monnet <quentin@isovalent.com>
