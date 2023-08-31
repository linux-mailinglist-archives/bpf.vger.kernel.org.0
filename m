Return-Path: <bpf+bounces-9086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62C78F192
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB27F1C20B1C
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08F18C2C;
	Thu, 31 Aug 2023 16:58:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320618C21
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 16:58:27 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF054D1
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 09:58:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso10061865e9.1
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693501104; x=1694105904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymn3azl+ScmGyPjO3oOg448+KpidrafzQafY6W6ymC0=;
        b=LruVMMvKaPaQOHBp6u09F1Y18jzjswvDiPeo/sVIP5Z4PxVQ7tdnVW0ztRYBjs0Ifa
         csD6tfao9EI5SF0FRiPwcousnmwfcbt9CiWyL0p4jOlQPa8MwoMDa4V1WYU/KEFC/Z3s
         zGLFvqBr25kr9eCIknMtqfDQ38H+fShWfBSqJCTGMEepUyqE5Ab2b8yECwAQupA66SPX
         UvqUqiYTqtTL7grFEmGTT+/lzVLO7n9MCgmJHj6VNOTVxLFvspHhSaiZZcUf2bUbi8G6
         /6j6t9h6d46jh7AgZJKlpAfoKkqTikY/Dvn8fMxw6+tEpqIpYHp5MCo127QWId1BFBRU
         tauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501104; x=1694105904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymn3azl+ScmGyPjO3oOg448+KpidrafzQafY6W6ymC0=;
        b=DaR9e3zqyu6XDPfulbYyAhkp3nBs9jaF7vqV3SRi8n+pkNDM9egRnot3C+1Xldldo4
         WLypqbnqBmT5H90EEMabsAFhxolZLjrh+zHg7MilWXiFfJCURNO1me758m8TDYQi0djs
         H6lIUjwXEldXdfw+FWrRVFKkSFVj+s2avgy8kSV/BD/R4vMXtZ7jyB/aAsMZcYzpIUme
         /2dm17oDEfRYY4IauH9MP6+bjbLREh3ItUwMwWjyZOUIqR9kdoUmeIrXBdf8apWfWOL8
         QJvg/J3YlMATb//j68Uwy9+udZbN1cGDXzch70bVOQWT09xCU/plMqV9K47Wt8GP18bn
         gVeA==
X-Gm-Message-State: AOJu0YzopRFvLY5mefCcfqPrA2DOlDVWSsfDvL+a5ZOQdloIwznqBqTG
	gMnOCsP8iLoWSWJVsDoAAYkK0A==
X-Google-Smtp-Source: AGHT+IFOUsI6eFJ17qu/fO5dGue7InUW+VcH88IT/1Dp5OagpUUf2LZ08n3sp3NqUKUY+vyrFB1DVA==
X-Received: by 2002:a7b:c453:0:b0:3fb:a102:6d7a with SMTP id l19-20020a7bc453000000b003fba1026d7amr4368492wmi.28.1693501104291;
        Thu, 31 Aug 2023 09:58:24 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:791d:1b48:cf5a:273d? ([2a02:8011:e80c:0:791d:1b48:cf5a:273d])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fed630f560sm2512350wmc.36.2023.08.31.09.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 09:58:23 -0700 (PDT)
Message-ID: <d3ba2fc4-2210-418c-ac56-6b3af7ef1cce@isovalent.com>
Date: Thu, 31 Aug 2023 17:58:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230831153455.1867110-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 31/08/2023 16:34, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-cgroup.rst  | 23 ++++++++++++++-----
>  .../bpftool/Documentation/bpftool-prog.rst    | 10 ++++----
>  tools/bpf/bpftool/bash-completion/bpftool     | 14 +++++------
>  tools/bpf/bpftool/cgroup.c                    | 17 ++++++++------
>  tools/bpf/bpftool/prog.c                      |  9 ++++----
>  5 files changed, 45 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index bd015ec9847b..19dba2b55246 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst

> @@ -98,25 +101,33 @@ DESCRIPTION
>  		  **device** device access (since 4.15);
>  		  **bind4** call to bind(2) for an inet4 socket (since 4.17);
>  		  **bind6** call to bind(2) for an inet6 socket (since 4.17);
> +		  **bindun** call to bind(2) for a unix socket (since 6.3);
I missed it earlier - kernel version (6.3) won't be correct, please
update it for the next iteration.

Bpftool changes look all good otherwise, thank you!

Acked-by: Quentin Monnet <quentin@isovalent.com>

