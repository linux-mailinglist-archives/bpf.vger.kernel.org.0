Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FCA47D8B5
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhLVV1B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 16:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbhLVV1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 16:27:01 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588B8C061574
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 13:27:01 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id j6so2797377ila.4
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6eU1R3Cs//i1znwM0Ja1jB72ZugGYmuXx1hAhjyheQ=;
        b=S4nskv/MYSRm1Hwwo66tY4xGGFlFtdinWUgo9l0NfwzWUrKYnuXyQva/8/Iiz8foVK
         qd5jCAlzFlnMe0KklTPL99SRsm7F52rKQNb7m3rbPMVHdOK9BTLZ1L48AWhwCpkSlEuF
         5e8Y30NNsIozRUALg1WloOGazGXrUXIW50u+eWaivkfZrzl8r6NGFva7WkMSnKF2HUj3
         l/XeijaJS5KfAoehpduPam71iIBhOnfypg/UijijzSlytMfOvvCSS0A2ULs4p7bREicG
         f5nH6gl27G7o0mfLaTTtGYXcJbmc446dZGR5W1j+1MULj1bgIOH4BkpZY6EBWy7BkQcQ
         ey2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6eU1R3Cs//i1znwM0Ja1jB72ZugGYmuXx1hAhjyheQ=;
        b=oKZ6z6/iRKKcIAzlQX5urmjPk3dhzF6MyMN/Fc4GxRwif8FQCnjUHLd1NOzNnbzoog
         xDOiRaVJJ0EycBZKqsbjEpAX6lIWKMBSLEPN7/8Irm7Qqz9CnK65Pv1pHuPT8syKmsQo
         P9O2zqt2HrHB/MmcGLP0C8d5ARLokID4QpGsJeAZGDinAeE8T5sk4TxUm4ahsMNfmw2d
         gnTyCXChTqdP4UJNZwkggnNiRUj2FPFshJds76+wLAzzr94osPVMv3F/y5/jkmNHVnLg
         dA3R+23s773Vldq8IhF9inbqaQYGSVx6YQze3iSYX56dUljIOiDx1VQzEhA9JAbCKiCJ
         4vNQ==
X-Gm-Message-State: AOAM532XImRT5+TJAkxXmp2bUor2TQMv3LNkKP7k8pL087nPQus+5jzJ
        G1MrR3W521zGmF7ySJn7eiQ=
X-Google-Smtp-Source: ABdhPJxYvsDYZgicZzzE6cKm5RjW+ORql9UWuuq3hCLcCkFQIh85/cDHAA8ZEGYZ6NkWeojjabnQUQ==
X-Received: by 2002:a92:c083:: with SMTP id h3mr2436786ile.273.1640208420776;
        Wed, 22 Dec 2021 13:27:00 -0800 (PST)
Received: from [172.16.0.2] ([8.48.134.30])
        by smtp.googlemail.com with ESMTPSA id d11sm162329ilv.6.2021.12.22.13.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 13:27:00 -0800 (PST)
Message-ID: <a3b8a235-7a5b-5c7e-4cce-2acf6d342851@gmail.com>
Date:   Wed, 22 Dec 2021 14:26:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf] bpf: Fix fib lookup when ifindex is not set
Content-Language: en-US
To:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20211222151548.100494-1-m@lambda.lt>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <20211222151548.100494-1-m@lambda.lt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/22/21 8:15 AM, Martynas Pumputis wrote:
> Previously, bpf_ipv{4,6}_fib_lookup() with !BPF_FIB_LOOKUP_DIRECT
> required a netdev identified by bpf_fib_lookup->ifindex to exist even if
> the netdev's FIB table was not used for the lookup.

there is no 'netdev FIB table'; there is only a FIB table.

The ifindex is essential information for the lookup and for verifying
forwarding is allowed on the interface.

> 
> This commit makes the ifindex mandatory only if BPF_FIB_LOOKUP_DIRECT is
> set.
> 
> Fixes: 87f5fc7e48d ("bpf: Provide helper to do forwarding lookups in kernel FIB table")
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  net/core/filter.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 

