Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D191838B1
	for <lists+bpf@lfdr.de>; Thu, 12 Mar 2020 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLS3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 14:29:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34423 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLS33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Mar 2020 14:29:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so8799284wrl.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRHCWhmFlQPURHq+pBoLkGTysC+hecjyJW1t2JsHSNo=;
        b=0F+83U6vTNMbdxCfzp+9BGDCgJ+jfRfz+fpPiZtdHECW9DgBIRQvXb3oigJ2D5OBnD
         AFjjkcURKEUON/mmfIg6jBuYe/v0dMKdsCrzmssotT49QQ5xatloFHcHsrmNNzxpAQPp
         4/Aw5sXbxlKLvslU+ZRqkszwZEI1ZALuxx/qeILfrZgvWUt/NYAo0pZkASqJV5cIrdwr
         nUx84v5gVJMNbF+kpHQUX4zYy1WgZKHy8ssIPsTB5wxIkjkii+z2iO2fL0Duj+yvyL88
         zF80qSys1rAKitNELa5z08LXsV3Hr6VvWDtLk5KOI5Rb7uwyiz+l2h76AQopCRjAe3yh
         8H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRHCWhmFlQPURHq+pBoLkGTysC+hecjyJW1t2JsHSNo=;
        b=o3eJfEdtMpBbn4KrRfb4cUSSYI3mXtSNk9Ye12XEQN3467tjSu1YMke7RVrlOY12KK
         wiwVK3JWI1JiJHkmXIYPjpxJes+LoKxiDEYk6UIjxfexGuV9dqOzXOcF62IrT3DDrkg+
         g9RxFme5cmD0TXhwgxqohKdRrQqqmAvw5S9SwgXBiP0MV7MDQXpCNXtvmJKjMzq77T/x
         2YuWsvT6BnSOsFKucsB5m7r/n2aekCn7nZB4wKWIfRPrXDtDd/23zmL50AD0pRseTuD3
         eGfHp7A8ZGm1deQyb9YILtP85LOroLneFDwD0YQDZDfYwQgeMb1NMsdC5Jj2m3/UtzDs
         qNiQ==
X-Gm-Message-State: ANhLgQ1c8Z/6c5v1wt5bZfAopW+hlpxRyqYkC9CaSD1HY6AfyD0LLbv/
        2D9wk8k9d6q7JzeeqA9plUk32g==
X-Google-Smtp-Source: ADFU+vvnu5jhezFpKMT+q/UzwIwyGAsFngjVM2cWS8rR8k8ojNctNy1ZNn6SEm0BEXqVT+ko0vT/yQ==
X-Received: by 2002:a5d:52d0:: with SMTP id r16mr11893374wrv.379.1584037767514;
        Thu, 12 Mar 2020 11:29:27 -0700 (PDT)
Received: from [192.168.1.10] ([194.35.118.177])
        by smtp.gmail.com with ESMTPSA id e22sm13237842wme.45.2020.03.12.11.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:29:27 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 0/3] Fixes for bpftool-prog-profile
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     john.fastabend@gmail.com, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, arnaldo.melo@gmail.com, jolsa@kernel.org
References: <20200312182332.3953408-1-songliubraving@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <461f01a8-1506-97c9-11db-4f1f1bad092b@isovalent.com>
Date:   Thu, 12 Mar 2020 18:29:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312182332.3953408-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-03-12 11:23 UTC-0700 ~ Song Liu <songliubraving@fb.com>
> 1. Fix build for older clang;
> 2. Fix skeleton's dependency on libbpf;
> 3. Add files to .gitignore.
> 
> Changes v2 => v3:
> 1. Add -I$(LIBBPF_PATH) to Makefile (Quentin);
> 2. Use p_err() for error message (Quentin).
> 
> Changes v1 => v2:
> 1. Rewrite patch 1 with real feature detection (Quentin, Alexei).
> 2. Add files to .gitignore (Andrii).
> 
> Song Liu (3):
>   bpftool: only build bpftool-prog-profile if supported by clang
>   bpftool: skeleton should depend on libbpf
>   bpftool: add _bpftool and profiler.skel.h to .gitignore
> 
>  tools/bpf/bpftool/.gitignore                  |  2 ++
>  tools/bpf/bpftool/Makefile                    | 20 +++++++++++++------
>  tools/bpf/bpftool/prog.c                      |  1 +
>  tools/build/feature/Makefile                  |  9 ++++++++-
>  .../build/feature/test-clang-bpf-global-var.c |  4 ++++
>  5 files changed, 29 insertions(+), 7 deletions(-)
>  create mode 100644 tools/build/feature/test-clang-bpf-global-var.c
> 
> --
> 2.17.1
> 

Series looks great, thank you!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
