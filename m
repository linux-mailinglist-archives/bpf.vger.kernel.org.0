Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300BF4B78E2
	for <lists+bpf@lfdr.de>; Tue, 15 Feb 2022 21:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiBOSpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 13:45:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiBOSpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 13:45:54 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A15DB498
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 10:45:44 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z18so15567956iln.2
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3AOo60tfBaJy0Iklwh+IzdN0WzcJlMEZNrEs/WOwvw=;
        b=LrwQguX72d7dQoMRVwv17UfZHO/gfxy7H+qTm1mQL7cG385yS/SywqjBNPcGMad0Au
         ex+cSrtSKEzSpSHI/BABqhNvi2VO/qwGn6c+BOo4r1Ixiv2iLXEgQrB0Dwh0LW4Cdhz1
         JjYJXGtTXuY0TMIUrdSNceDkXBYN8LyO6KYaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3AOo60tfBaJy0Iklwh+IzdN0WzcJlMEZNrEs/WOwvw=;
        b=Yd0Mhqtku0p3j1vnRqE/n069tToEiVYcgfWIvjK78g3k/T06f/EgR//riLZjHgN1T7
         ZUJU3UJfQQ/C+M+/5OqNhCY3EzBTZeVc1KCRHo4TZE/5F3vEF0+8JQ3+DsCqDVON9jFz
         YHK96vSn49vo34Onpt+hxe5NlUCPQTh33BcSfvYiqn7Omg5FUfjWhwF4NedSsdKiTJh3
         +EvHfoosLLfOvmcXASqHQfBu1gEHmwFo3aCSFwxwXvMgtx6T+pI/o8P0+N+vOi9GxhSF
         tZTpTXTlzvQAUUFHhTEGpd2ccjg7SHMmOOBwiPS8NSSewAGASiBHPrYGxWMitEfxO0QT
         bzeg==
X-Gm-Message-State: AOAM532VvDaJv+wKgu4bD74k+3IHjZFKntssMX2q2Qv+li3u6V10m/fa
        gNbBrTCunF9Hbw7+1bfaft+hpg==
X-Google-Smtp-Source: ABdhPJzy8r32H631rMEUqmMguE25zJsdVa5JigyKXSP1Nt1BwBWWh7OYkf9i+9yWOzq7PhycuDOl1Q==
X-Received: by 2002:a05:6e02:1a21:: with SMTP id g1mr280061ile.154.1644950743677;
        Tue, 15 Feb 2022 10:45:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id n12sm22596509ili.69.2022.02.15.10.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 10:45:43 -0800 (PST)
Subject: Re: [PATCH v3] selftests/seccomp: Fix seccomp failure by adding
 missing headers
To:     Sherry Yang <sherry.yang@oracle.com>, shuah@kernel.org,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        christian@brauner.io, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220215184215.40093-1-sherry.yang@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <022c8d4f-25aa-76e4-3e7c-eae1d1431a01@linuxfoundation.org>
Date:   Tue, 15 Feb 2022 11:45:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220215184215.40093-1-sherry.yang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/22 11:42 AM, Sherry Yang wrote:
> seccomp_bpf failed on tests 47 global.user_notification_filter_empty
> and 48 global.user_notification_filter_empty_threaded when it's
> tested on updated kernel but with old kernel headers. Because old
> kernel headers don't have definition of macro __NR_clone3 which is
> required for these two tests. Use KHDR_INCLUDES to correctly reach
> the installed headers.
> 
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
> Tested-by: Sherry Yang <sherry.yang@oracle.com>
> ---
>   tools/testing/selftests/seccomp/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index 0ebfe8b0e147..7eaed95ba4b3 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wl,-no-as-needed -Wall
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>   LDFLAGS += -lpthread
>   
>   TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
> 

Sherry,

Please see comments on v2. Your v2 is in next for rc5.

I pulled in your patch as a fix as is for 5.17-rc5.

Using KHDR_INCLUDES can be separate patch for next release.
This way the fix is going to be pulled for this release
without dependencies on other patches.

thanks,
-- Shuah
