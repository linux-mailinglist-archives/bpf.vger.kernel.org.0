Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639DF1B57C0
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDWJHc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 05:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWJHc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 05:07:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72CC03C1AF
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 02:07:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so5883676wrw.12
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yJFyvUqV//1xm7gc+Oo0yQUwUCS1vMSAhlqJ8flup+E=;
        b=Sc1EG5VSpA3/VvEPU0wrzGbDct5oJI+UjF+WKDxGGO2+ydrTzVr697TKjVtY8nF/0F
         7hA0k0nDkZU6iHXC6UGJW3EtzA78bR7vEDS2vbnvtMzSgtp5QjsBBibYKZ/rzttf7j1A
         0P8w30ZSlgyekvpe10f4GAd4iA55XtmdIpplY5mmISKwLducAsl7q2Gs8b398SroUCK6
         4vdC6s9mu1Aeknbzz1fpi03Kbf+HTq5UrHAuOmnXa+Fxts8FnePL9hzCn4eJhVuT5/kM
         gi8RYY0AFlhPiSQYvElzS0XByXKjZexI1J1vMJxLrqAc7yiFvuE/43Wue2Srhd9NKYOf
         NSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yJFyvUqV//1xm7gc+Oo0yQUwUCS1vMSAhlqJ8flup+E=;
        b=GVBckvb2rDwI+F35oCNQtKWYtmCpEqSCTDJ1SexxxyuFsiw8jnL3KiReBju1hvncrn
         CjKmbkXKmMKic67BfSepXydtSvf2UC2sACEKDtQJ5bfjz0TKGa+WrSwyZKRcZvYOy9Xo
         R7JN3PP3QKnXmNCRyeOd4NkgSr2vXm1Gsyd2sk1K2ysijypQCPeAldQ7ZT2kOZbDRnKB
         Eho4OPOPHT9Kz/GamrmkHBIy+zT6P9jFAxfcP7BnLrlfj0tWpnCzGJ4AxO9tgZGdD5gS
         YN8qgLRSXL6ufQbjlaYS1Z/nJFgvOB3PBWcH6ZkcaLp26/YTbtSCw6s9gtmgdLIv+UCr
         n7hw==
X-Gm-Message-State: AGi0PubW2sCJoyPmp+xdIdnxEu73xN2PIbnIxrMN8rRfTbHKAUbpz+u+
        jBtMhgysKev4z7O/F/xOTW5Mvg==
X-Google-Smtp-Source: APiQypLDMCpS3TkzKNX0PIwmWczrI3J3DW6vOEaXewH/YIyrK5cO1hNDZumGhGICn4qndDTiUPZKXQ==
X-Received: by 2002:a5d:5646:: with SMTP id j6mr3951349wrw.207.1587632851020;
        Thu, 23 Apr 2020 02:07:31 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.104])
        by smtp.gmail.com with ESMTPSA id z18sm2710502wrw.41.2020.04.23.02.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:07:30 -0700 (PDT)
Subject: Re: [PATCH v2] bpf: Fix reStructuredText markup
To:     Jakub Wilk <jwilk@jwilk.net>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-man@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>
References: <20200420144753.3718-1-jwilk@jwilk.net>
 <20200422082324.2030-1-jwilk@jwilk.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <34f41c96-86c0-2ca9-3be9-75c59f803bc3@isovalent.com>
Date:   Thu, 23 Apr 2020 10:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422082324.2030-1-jwilk@jwilk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-22 10:23 UTC+0200 ~ Jakub Wilk <jwilk@jwilk.net>
> Fixes:
> 
>     $ scripts/bpf_helpers_doc.py > bpf-helpers.rst
>     $ rst2man bpf-helpers.rst > bpf-helpers.7
>     bpf-helpers.rst:1105: (WARNING/2) Inline strong start-string without end-string.
> 
> Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
> ---
> v2: "flags" should be italic, not bold
> 
>  include/uapi/linux/bpf.h       | 2 +-
>  tools/include/uapi/linux/bpf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 2e29a671d67e..7bbf1b65be10 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1642,7 +1642,7 @@ union bpf_attr {
>   * 		ifindex, but doesn't require a map to do so.
>   * 	Return
>   * 		**XDP_REDIRECT** on success, or the value of the two lower bits
> - * 		of the **flags* argument on error.
> + * 		of the *flags* argument on error.
>   *
>   * int bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
>   * 	Description
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 2e29a671d67e..7bbf1b65be10 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1642,7 +1642,7 @@ union bpf_attr {
>   * 		ifindex, but doesn't require a map to do so.
>   * 	Return
>   * 		**XDP_REDIRECT** on success, or the value of the two lower bits
> - * 		of the **flags* argument on error.
> + * 		of the *flags* argument on error.
>   *
>   * int bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
>   * 	Description
> 

I was about to send the same :). Thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
