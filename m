Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36DE4F9D94
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 21:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiDHTRu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiDHTRo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 15:17:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55213E10
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 12:15:40 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z7so11818347iom.1
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Kf0ZTsLjDejTbR9KWoKZLLUzRAIqaERYWh64+TaiEU=;
        b=g1sj3t/3ZWwyETTsvtI5i3gJyFtW+Nd05vrRm9oD1goxzzwvtY8yWXr2de7mGtCT/W
         tZQ2KpIqVPPDbJ6yjrNpdAgflc6Cj8CbulHn2Zx1T9ap8WTlgSbw/UPTDOSl4Vf0Ywfb
         gsQ7ffF0oHPC0Ndk7S8TflMxNnINvnIeAchrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Kf0ZTsLjDejTbR9KWoKZLLUzRAIqaERYWh64+TaiEU=;
        b=lDQ9XiS58iM4gGssVm9HA+EQM8fwARsSaVWHMosM/oN+X666nhkm/tuatXEqBmpknD
         M+KjhsE7clP7nEbrTHFYlz83van6jvAUmsPkPrnXvXIXWGdwx4K3By2llleTn/ck17/r
         Vqj9JhcCmb33pC3/C1Ay/mNWB3452ueoRSAMXlOW2dr/hSXtd9pspmnnoq+/LPuR15pX
         vu3eGA68dVTIvQTRiugqylNUn3WsLSAAHAPktBFt8jkPgF+aDvhTcyOncheXOhDywcxw
         570/odgiUev9w3ajQAGe6e+PsT/2qzXasBZ5Qoehf6WT/qWxkstbznOGIQfWOiGqprov
         mWAg==
X-Gm-Message-State: AOAM533obWiSaOCq+0JzkJTTf6l68ki9i2v/MjjtjiW8jFBD5elhVxpX
        KRJQ73Ng+zXcp0/piGaTHFibxA==
X-Google-Smtp-Source: ABdhPJzWqNmG4+IS+JtgNg3GCHMv9HluLDJgUiMc+JnqV0/XSVAMoLEicla2iqHfEDsdkWDaTZUGIw==
X-Received: by 2002:a6b:1547:0:b0:64c:8bd4:acba with SMTP id 68-20020a6b1547000000b0064c8bd4acbamr9132129iov.204.1649445339396;
        Fri, 08 Apr 2022 12:15:39 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k11-20020a926f0b000000b002c2756f7e90sm13179595ilc.17.2022.04.08.12.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:15:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] selftests: bpf: drop duplicate max/min definitions
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
References: <cover.1649424565.git.geliang.tang@suse.com>
 <0efb81dab7a8de23044302c5c7fa9af308766236.1649424565.git.geliang.tang@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5aefc150-91f8-dd7d-d8bc-7f13efbc8747@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 13:15:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0efb81dab7a8de23044302c5c7fa9af308766236.1649424565.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/8/22 7:36 AM, Geliang Tang wrote:
> Drop duplicate macros min() and MAX() definitions in prog_tests, use MIN()
> or MAX() in sys/param.h instead.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c    | 5 ++---
>   tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  | 7 +++----
>   tools/testing/selftests/bpf/prog_tests/snprintf.c    | 5 ++---
>   tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 2 +-
>   4 files changed, 8 insertions(+), 11 deletions(-)
> 

Looks good to me. Thanks for cleaning these up.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
