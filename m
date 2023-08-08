Return-Path: <bpf+bounces-7205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9DD7735A4
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF51C20D91
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A63387;
	Tue,  8 Aug 2023 01:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFB191
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 01:01:59 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EAD171E
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 18:01:57 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bc9de53ee2so4065452a34.2
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691456517; x=1692061317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyBOm5DJrUPhc3DnOiz1H5TyvCVV6vbPsKopC+OqCxo=;
        b=npssVlTu1zx4Z5AzKvYnzOe3ASj8/7oBNhHa4m6Rvd5RIXunrn6RcA1MS0u0GGfMrL
         Z7GIhdkpSX1/fZ/PWnwL2bislbXPaeufdcsNl3ebrDtnELNw+pTq2eUdELfi/EdZRvlj
         8/JrLSACf2rHqGoKo1xE+7GlTe1eoVJCxZjhBsc646UDMfCQD8+Hnkmib6qLgE97Bnjk
         Ps+Ztt2tlYlXqO4GkbnvoHFKodf0I6Znie7O8PbIJsqIgcDuYfyESUlhZlTgtHR0Sfzx
         sRoAfCnG9bybCh4IbwuhRPjvyYcnAXE2yv1qsLaLRUbZdoOYuAE3s5jiTOVmfx9VOrsP
         RgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691456517; x=1692061317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyBOm5DJrUPhc3DnOiz1H5TyvCVV6vbPsKopC+OqCxo=;
        b=HZg2hgFNojgRNVIkO+jotqmMn/iwsHUJVFs7enblsuvBxaJ91GlT+2U5m47WLFSMGz
         QYv6oGIpA6tvEMmwiHxshvfXBWovKYGIXWenC+WIb736RTKrZVZMj65AwFd2BESiiTR7
         WkEw1Trui6T1jaZICUAZWL1rcqoQzqY+mQmXewSh7AZDGiEJsnriVtnRyCrxYIHP+Emg
         x2Rt26uNrsRq77Lxdo6TEaG2eCk7IOppcv4qR/F6OqQMQzRONYTRFpkr2hxYvShuY2cy
         sMlOO1ERRvZi3MyZHmLDyuH9feUeKbRYCHRdaMYb/km1AGV72tqYG3Ixt9Irn8yH1j2o
         tSvA==
X-Gm-Message-State: AOJu0YzHmfxOUnHm8NOvpiL361XE/AGZuyFdR+rA1Burwgxg8+ngmaXP
	yx4NXRp5KOyOY1VL4mfX0Co=
X-Google-Smtp-Source: AGHT+IGdGnQz7Wfnl0nUSVrbf+oGzMtC1Ka+cKo5Aw+ZkVkTXD2KC791sRRyNLe8z5j4XgulHayhpg==
X-Received: by 2002:a05:6830:1d53:b0:6b9:924e:b43b with SMTP id p19-20020a0568301d5300b006b9924eb43bmr10574252oth.6.1691456517026;
        Mon, 07 Aug 2023 18:01:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:435d:4410:5eba:3fbc? ([2600:1700:6cf8:1240:435d:4410:5eba:3fbc])
        by smtp.gmail.com with ESMTPSA id 78-20020a250251000000b00d0b6ca620besm2567464ybc.30.2023.08.07.18.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 18:01:56 -0700 (PDT)
Message-ID: <f44ba28c-df6f-d46b-045f-67fc3fdf1867@gmail.com>
Date: Mon, 7 Aug 2023 18:01:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] selftests/bpf: remove duplicated functions
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, bpf@vger.kernel.org
References: <20230807193840.567962-1-thinker.li@gmail.com>
 <b08d7924-9ca1-1ec1-8201-4bf58b403066@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b08d7924-9ca1-1ec1-8201-4bf58b403066@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/7/23 17:33, Martin KaFai Lau wrote:
> On 8/7/23 12:38 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The file cgroup_tcp_skb.c contains redundant implementations of the 
>> similar
>> functions (create_server_sock_v6() and connect_client_server_v6()) 
>> found in
>> network_helpers.c. Let's eliminate these duplicated functions.
> 
> How about the port function mentioned in 
> https://lore.kernel.org/bpf/c2776380-7550-3777-24a0-1f155785696c@linux.dev/ :
> 
>  >> There is get_socket_local_port() that supports both v4 and v6 in
>  >> network_helpers.c which is equivalent to the get_sock_port_v6() here.
> 
Ya, sure!

