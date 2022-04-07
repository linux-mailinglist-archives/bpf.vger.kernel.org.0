Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68624F8878
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiDGUdW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiDGUdN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:13 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E1843799C
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 13:18:18 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so7593280fac.11
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IE6b2b7PZA/765aj8kgizGiorDmRX0683kgvGjUxMeA=;
        b=Vo91PVuUiTxrM79of+dR3fG6FNsiGpAp2kiossNKX9RvZqQ0tNcysIyhC5hV26bIXs
         SX8tOzFdIbx4ZdJWJyCOnVN9LkH5KB+0wNKwBF271KrB43O9T6UmnE0IsgGwpboIV/vG
         WZxb5V1Lep77xEehScOKPw/yRSMSkeZfUR2RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IE6b2b7PZA/765aj8kgizGiorDmRX0683kgvGjUxMeA=;
        b=v6fjne/bcu6FOJmdrQjLZoYaqzWX+/Kfvv5EIshglsnCpALDrT61pyTFmzFPiUYSv1
         D0IJe7/6EOUTDGegbcvhCREAobeg1dBrx8ZrC047PDzH57e8JCblSUfaGUjmFH2erh9J
         6IQsjISCsna6Fzj0m1xeGE11yv1S5sKrtrquyXcHBDpSjKURT27xPh11uRaeXteWasAS
         NqHthmONYrB9VJVRFDp1JbExbNRwd5JfVZ3RkiE+xhNPAR/xOfqgbH4dDD6EM6STHLEu
         +r9yi4giRELMzeBjhWjSxlT6Ibb6kj0KM5BrqUjuzEBbcPkH/Xfect099PjO3KDMZTD4
         A1Ow==
X-Gm-Message-State: AOAM530snFnz+tcB7ZTS3Hwu6lWysEokBKWbcCDXRtJRSY8BW0CYpZ5d
        P3kXTdMKRVD3NlJ4fNz+HHAJLNzU8tDvow==
X-Google-Smtp-Source: ABdhPJwhwNK7rm2v7SKB4nv0/5WnpgJaJKVsEyInrw6UTpDl3iJdjYGBJdoJW9J/Uqlp9e3wNODP8g==
X-Received: by 2002:a05:6870:a411:b0:e1:e2b6:ba1d with SMTP id m17-20020a056870a41100b000e1e2b6ba1dmr7046596oal.217.1649360454832;
        Thu, 07 Apr 2022 12:40:54 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d62da000000b005b23f5488cdsm8162365otk.52.2022.04.07.12.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:40:54 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: use MIN for TCP CC tests
To:     Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <4da5ff038c442d4421b95580558fc981bb674e61.1649304888.git.geliang.tang@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8b37034a-183e-58d9-1065-6c207d26d68c@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 13:40:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4da5ff038c442d4421b95580558fc981bb674e61.1649304888.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/6/22 10:19 PM, Geliang Tang wrote:
> Use macro MIN() in sys/param.h for TCP CC tests, instead of defining a
> new one.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index 8f7a1cef7d87..ceed369361fc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -3,6 +3,7 @@
>   
>   #include <linux/err.h>
>   #include <netinet/tcp.h>
> +#include <sys/param.h>
>   #include <test_progs.h>
>   #include "network_helpers.h"
>   #include "bpf_dctcp.skel.h"
> @@ -10,8 +11,6 @@
>   #include "bpf_tcp_nogpl.skel.h"
>   #include "bpf_dctcp_release.skel.h"
>   
> -#define min(a, b) ((a) < (b) ? (a) : (b))
> -

Thank you for cleaning this up. Sanity compile test passed.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
