Return-Path: <bpf+bounces-8924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384CF78C8E6
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 17:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6895F1C20A3F
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B417FE5;
	Tue, 29 Aug 2023 15:51:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6E28E7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 15:51:28 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9DB113
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:51:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b5516104so41891845e9.2
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693324286; x=1693929086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEGPAg756tIu7slNy1u7SX3bvlr0a8VnUtZd6Qzfo84=;
        b=Lxm3XSP5FYhC/R36MRLiQfi9+yctlz8X70nIlL6Wk+XdVtkMHlmcnvX2Yi2+cRdqEu
         9sKRn8TOqkf7o99fXQqsGYUQCDNaIfy11J3rpZQAYgMbDLPlIQRtVvmJpqz+Fr3yx46G
         wuJA/ceZkQDjYuZdDa5vU5dqwH+oL0blebT+frTe/DqQISPrHwcDYQXumeoTtLtjQ/IA
         ogFaMLt0biFzWVfbq3I4slZuxREsUQh4rU4nv2wS8sqoBHtMILlPjWOOwFcleyPvYws4
         bS6SiRH8sJmUxLgd6OKakaLYG4l7T1Qi5RKxETyNdeibZ3vtHLefk65gNE8HwLi63S1R
         R1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693324286; x=1693929086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WEGPAg756tIu7slNy1u7SX3bvlr0a8VnUtZd6Qzfo84=;
        b=lgpzhGIXBvU+EEiOUUqQfQ1rg7b3plHTY7MZe4T4tUfVJm1lJ0vWRHEDnhajSbyTP7
         Qoh2/28WzcQJi8J3PtvFoGLOGG7YnYMZ+kh3IZy9pbwVLw2i6fbLe6aAGLLaBLFP1IZb
         mr9fSAPPAbh6kr6tNcbV9FWxVVYbOsGrlQpAM+kF7eUjxFRmzKH4Blgimy3n0dYc4wVW
         MLJ9o3zRom7+sGHVFz7Y+FT2Nvmo43lpHq/7zz488bxfcXm/O7D3JX1fwM3i4E6Rv/xP
         7B3s6eBxiZ1JGRJ5X3mYQcgDg1IaBWCqLga88VlympzAsGS0jIvs1zq5zFGwPtzmZPsb
         CZHA==
X-Gm-Message-State: AOJu0YxMiquth+txLuL5kuWxVAY0VBAtjA5g1dUGaTLqye8/ZjZKHx9K
	vjq8PyTQ7ELHK+Jfgm2tfK3AqQ==
X-Google-Smtp-Source: AGHT+IFDowZ7JmWG9d8OOFs9VphaoZzAXYG31mkTqigfmvXJ63vT+7/tYR/JWMOZ3mbvIHq+KaS6KA==
X-Received: by 2002:a7b:c38b:0:b0:3fe:2463:2614 with SMTP id s11-20020a7bc38b000000b003fe24632614mr21094311wmj.24.1693324285776;
        Tue, 29 Aug 2023 08:51:25 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:716a:ac4c:a6ab:1706? ([2a02:8011:e80c:0:716a:ac4c:a6ab:1706])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c294b00b003fee6e170f9sm14160951wmd.45.2023.08.29.08.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 08:51:25 -0700 (PDT)
Message-ID: <af79f4da-232b-4990-b7c0-74b4708953ba@isovalent.com>
Date: Tue, 29 Aug 2023 16:51:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Fix build error with
 -Werror=type-limits
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org
References: <20230829154248.3762-1-laoar.shao@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230829154248.3762-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29/08/2023 16:42, Yafang Shao wrote:
> Quentin reported a build error as follows,

Just a warning :)

> 
>     link.c: In function ‘perf_config_hw_cache_str’:
>     link.c:86:18: warning: comparison of unsigned expression in ‘>= 0’ is always true [-Wtype-limits]
>        86 |         if ((id) >= 0 && (id) < ARRAY_SIZE(array))      \
>           |                  ^~
>     link.c:320:20: note: in expansion of macro ‘perf_event_name’
>       320 |         hw_cache = perf_event_name(evsel__hw_cache, config & 0xff);
>           |                    ^~~~~~~~~~~~~~~
>     [... more of the same for the other calls to perf_event_name ...]
> 
> He also pointed out the reason and the solution:
> 
>   We're always passing unsigned, so it should be safe to drop the check on
>   (id) >= 0.
> 
> Fixes: 62b57e3ddd64 ("bpftool: Add perf event names")
> Reported-by: Quentin Monnet <quentin@isovalent.com>
> Closes: https://lore.kernel.org/bpf/a35d9a2d-54a0-49ec-9ed1-8fcf1369d3cc@isovalent.com
> Suggested-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Thank you!

Acked-by: Quentin Monnet <quentin@isovalent.com>


