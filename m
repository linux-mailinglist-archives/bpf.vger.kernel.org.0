Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF57938E23A
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEXIYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhEXIYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 04:24:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988C6C061756
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:23:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so3942187wme.5
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=L0fY8gBqEJkKAazAkhMKfyEaax1McdUDY1Rg8PvD5eo=;
        b=Z3+StMnsVYL0cdx5FJEP2cfb3D1Sr3nFWIV795k2yWF6SWWIFifI5Dj3M/jb0J9CyH
         zB673695fGuqoJPdcXXG9tFu5Wug5eAbHggcO48o4oLoNcZt49al5DNpUGG9ukXpl/0b
         QW9poOG9GrKb7TMQWhl02az0WY3W4d0meVgtbKO3Xpu6WxvT1KILyMVfjUFBL234tlRV
         k75GVxirE87OaexJd6v5P2Y2Dh12Bf3GjX8m2aMipJa4ccFHiI4XXdNSJfylkaDn42sx
         jbCb6Z3K8cUrqhSP3Ir6lzKR9yU+jT3IKilk7+/eINIhpmLCRv4YUYbrXlmWjN7H/Xgv
         yJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0fY8gBqEJkKAazAkhMKfyEaax1McdUDY1Rg8PvD5eo=;
        b=jfFok4OHaUxtyBVz/wmquuF79HpHCa6ZUdzYg+IjCWrspOr4vsANHqm8UhT5RcVT9b
         19ZzX1EqH8YOGS+yO4eL22KgESwODsYr0tJeSJwvIKCHBQZGwqLmyhS9qKjdqhGq3VZo
         8iGom/+eiRCd/VtN6ZSDEzI+hWW1Y7wUAFdc0douo7/GnlGuQ+nNS1IKqovKhgT8tVxo
         TfafWqXiyrD7WwuSh1zsHFewJyqXzNtu+e5ITBfqubJTUrMk0DBpqqbpgFa9QmdURtu8
         9zEwesDQbG7QxwTqsjVFKYzU/vMYGG5EpAAjLH8n0inPeNN1vVe5lT1pBWOMeuP6aqHW
         ateA==
X-Gm-Message-State: AOAM533UrHrZO/d8LsS25rNBREPHa2CJ6RXbAZYsGDu8ZHgVw2X5ZOyM
        OiqN1EE2Kmtn48v5eVjFCYIP8wW6soonCb+4
X-Google-Smtp-Source: ABdhPJwxS8uOow369BuD73wdKe0o8RwYEcGMWMajYv1hXnFlZ/ju0f1t/g1trTmPrdSsYKS6BQnGeQ==
X-Received: by 2002:a1c:2704:: with SMTP id n4mr19002813wmn.147.1621844599836;
        Mon, 24 May 2021 01:23:19 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.78.247])
        by smtp.gmail.com with ESMTPSA id h1sm1145449wmq.0.2021.05.24.01.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 01:23:19 -0700 (PDT)
Subject: Re: [PATCH v2] bpftool: Add sock_release help info for cgroup attach
 command
To:     Liu Jian <liujian56@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20210524080313.326151-1-liujian56@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <f8b76c9d-9d92-4b46-eaa3-ba2ba546f91f@isovalent.com>
Date:   Mon, 24 May 2021 09:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524080313.326151-1-liujian56@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-05-24 16:03 UTC+0800 ~ Liu Jian <liujian56@huawei.com>
> The help information is not added when the function is added.
> Add the missing help information.
> 
> Fixes: db94cc0b4805 ("bpftool: Add support for BPF_CGROUP_INET_SOCK_RELEASE")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v1 -> v2:
>     Add changelog text.
> 
>  tools/bpf/bpftool/cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index d901cc1b904a..6e53b1d393f4 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -28,7 +28,8 @@
>  	"                        connect6 | getpeername4 | getpeername6 |\n"   \
>  	"                        getsockname4 | getsockname6 | sendmsg4 |\n"   \
>  	"                        sendmsg6 | recvmsg4 | recvmsg6 |\n"           \
> -	"                        sysctl | getsockopt | setsockopt }"
> +	"                        sysctl | getsockopt | setsockopt |\n"	       \
> +	"                        sock_release }"
>  
>  static unsigned int query_flags;
>  
> 

Thanks a lot!

Note that there are a few other places in bpftool where the attach point
should be added, would you mind updating them too? That would be: the
documentation page for bpftool-cgroup, the one for bpftool-prog, the
help message in prog.c, and the bash completion. It should all be
straightforward. You can try something like "grep recvmsg4
tools/bpf/bpftool" to find the relevant locations.

Best regards,
Quentin
