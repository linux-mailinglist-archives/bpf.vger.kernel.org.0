Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DBE441C52
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 15:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKAOPc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhKAOP2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 10:15:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F3BC061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 07:12:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o14so1522127plg.5
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oQN2hia9k8NnM+K/UbyiL9LtUQccnbGzFeDWj5dV2OQ=;
        b=KH1mNWmzFZpeyt4+VeVo3RVMCoVy8H1wi43UuxTtiuaskjdNj6zmNjKnUDPXdHv+DZ
         d72YxqFLWFuu3RB96kORcbAGwqn0CnsXz0etHlICDy22f492ukZPK1ZxSb9aA6gF6mQX
         qEKqfS+19aKyWIC1DEBx2yf3GXE4+WgV78wtXlQ6jp0ar8/1ZbYpMoVewas6zLeObusf
         ILAaopOY1u80BaUuOlzOSNSKjT1YUp4uUJ7q7eznYVj+2/tCemqhFkAmNKckYIfML87u
         2jWpqqEEDySfZmkmzPdigzc+lMwydbH89LiWThjNrGkLvSwcBpXJdWcnTRmcwc8jqS+E
         3N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oQN2hia9k8NnM+K/UbyiL9LtUQccnbGzFeDWj5dV2OQ=;
        b=gKa/0gCFDZjIo+SSn+SYSUDgLq88umOOU/cnGsM62by58BISDuZCOi5RPzCITKx7uV
         dJ+xP/fMs1apZr4c5SNmca/R1R33/OxN7FeGeN9EZBlCxAhy+OiUjwIJ1kyEVTdNsXie
         /0as3g0eCuKaFZ5/O8is3EGWe+GZP1hBKBFVayLLEPFjdfD8dZK4XL8m+An6d5qplPKn
         ZadJkwntLIOV95FPIG+khQsMbBeYfUyHQQTZhEEhbJUHEirl8C7EOjF8g2WYkFf3rIO5
         w7oD8X/KZs10dglFsujuCb9MdQ5WvqEG7fXgiR0LfUv1ppA6Fu4nLWynkdneRztGZVTY
         HbyQ==
X-Gm-Message-State: AOAM531NwVRhbIlVVuQIhYB4agoHlb82nEEHEJFyXPqIgSYBMPjsuPC7
        l3/z6xxegaH1nAo3rs0doN0=
X-Google-Smtp-Source: ABdhPJyU/JbRZu0a3l4HOwHkAY1MHwIyr0/mra0ERh9/7evD9zO6w96YEuhiIIPi2vHUXCfNMVBHZw==
X-Received: by 2002:a17:90b:4ad0:: with SMTP id mh16mr11385500pjb.176.1635775974150;
        Mon, 01 Nov 2021 07:12:54 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id m12sm12145381pjr.14.2021.11.01.07.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 07:12:53 -0700 (PDT)
Message-ID: <ac73a76c-e571-5b27-f711-1cfd9d5ac725@gmail.com>
Date:   Mon, 1 Nov 2021 22:12:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 01/14] bpftool: fix unistd.h include
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20211030045941.3514948-1-andrii@kernel.org>
 <20211030045941.3514948-2-andrii@kernel.org>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20211030045941.3514948-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2021/10/30 12:59 PM, Andrii Nakryiko wrote:
> cgroup.c in bpftool source code is defining _XOPEN_SOURCE 500, which,
> apparently, makes syscall() unavailable. Which is a problem now that
> libbpf exposes syscal()-usign bpf() API in bpf.h.
> 

typo: 
  syscal -> syscall
  usign -> using ?

> Fix by defining _GNU_SOURCE instead, which enables syscall() wrapper.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 3571a281c43f..4876364e753d 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -2,7 +2,7 @@
>  // Copyright (C) 2017 Facebook
>  // Author: Roman Gushchin <guro@fb.com>
>  
> -#define _XOPEN_SOURCE 500
> +#define _GNU_SOURCE


>  #include <errno.h>
>  #include <fcntl.h>
>  #include <ftw.h>
> 

According to the man page ([0]), defining _GNU_SOURCE also implicitly defines
_XOPEN_SOURCE with the value 700 (600 in glibc versions before 2.10; 500 in glibc
versions before 2.2), so this change should not break anything.

  [0]: https://man7.org/linux/man-pages/man7/feature_test_macros.7.html

--Hengqi
