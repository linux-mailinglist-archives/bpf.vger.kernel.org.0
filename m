Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A94F9DA0
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiDHT0D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiDHT0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 15:26:02 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C427348B0F
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 12:23:54 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so1639980ooh.8
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6PPIy36napfU/u2aY/HoK3sVhuBmHd01Cv34ZWmAUo=;
        b=M17zIr6OGlaLbdBLFFfL57NpApXft6SDt7tcMN9vfIY3Yl4YX+yPGlwdd0sWOXGUCL
         DbJDsNM+T3+TCWjAGPMRjWjOI+BWitOTmPWAdEM9H5Wf0fOD/l0/eZqEvJ00HHpmVf5x
         8KHOcIstIm3k+m1qGvVbUmEnXjlZSSENuvNjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6PPIy36napfU/u2aY/HoK3sVhuBmHd01Cv34ZWmAUo=;
        b=qRUrbGtrRyVCsN0P02xfWrkB3dcfm+PDcRwu0eFig/+WxGcFMxn4ILu3w0P5Grq5LE
         Dx38BBuLrDS76EjnLW99kFXQCyhgprqG+EbE7PM3n/ZIfZoTKZEhZWf/RbtYAdbXpaZr
         OehIxW7gwSAYk/85Y6lHpcd3i1tDodsq6ktFdRzn6J5RF5EsG+vS8jIZTsBs9Znorxe/
         ZhfGG5IpjAbYQzOHWXKqlO/3R7340jadG9nxgA1Jk5b3LmgML2/2Krd3ZKv+4EA7y6O7
         fZOqNVqLJS5IdPEbwVMA9Ss2Ly9zhSbL+jM2wXO0iMBdvs48BvPFzNiDBtu4tlhz7Gv+
         tDUA==
X-Gm-Message-State: AOAM5318PU44GMp4vCp4l/KNZsq4KkUhW5Ph3Nsn4zgaewFqySaDUC/i
        utKScyg9FAtm5lQHa9+dhoGDvFAcA/s5cw==
X-Google-Smtp-Source: ABdhPJwWcIPSf4bMVd1ad/gG9idPpq2ssdWRRIQ22dv8eLNNDKqX0ni/EbE82yE3fpqlJQJfX9wt7A==
X-Received: by 2002:a4a:2556:0:b0:324:bd36:f020 with SMTP id v22-20020a4a2556000000b00324bd36f020mr6730949ooe.13.1649445833546;
        Fri, 08 Apr 2022 12:23:53 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 15-20020aca110f000000b002da58c4ec52sm8888098oir.6.2022.04.08.12.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:23:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] selftests: mqueue: drop duplicate min definition
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
 <36201289cc9281ea7653127b0008ba01a1c14290.1649424565.git.geliang.tang@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2d535cf6-d5dc-21fa-4456-d9fe06e9588d@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 13:23:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <36201289cc9281ea7653127b0008ba01a1c14290.1649424565.git.geliang.tang@suse.com>
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
> Drop duplicate macro min() definition in mq_perf_tests.c, use MIN() in
> sys/param.h instead.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---

Thank you. I will apply this for next.

thanks,
-- Shuah
