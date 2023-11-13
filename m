Return-Path: <bpf+bounces-14976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921A7E9811
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9092F280C0F
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953A171DF;
	Mon, 13 Nov 2023 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MIUheSmK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F216436
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 08:52:38 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B310C9
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:52:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso628436966b.1
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865555; x=1700470355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=no0g8tCe9M/ACnWMS4hSD43FezMf7B1awhK8Bk++Q5s=;
        b=MIUheSmKlivygXomBU6ibeUvSMt4hOZqKoTzpfEYurYGfP6mMcwv1vcSyZiqXZphMD
         hwVlJUe6XXOiEk1S/14yyb2c+NQhVY5l9uiZAueb2VlRfubYNWXFrrjBrpSDc4lNxxne
         jTf1GCc8Mk1KHCmO2pU9YUESXmXVoY1g1tg2Sye/Xw2ZGBo85Td8E0L9ZtsHwdaJ54K5
         oPxRUUfmmqzMg8z/NQDohBedf5h93tN0ea/L1Ahwepg20AfhOxx7vNOvx2BR098tmi68
         K+zTFr9/mQ2wGWjk/ISlnWTcEyDT6TJezuMbD2Ijc0/u+C2e+4uywMH4bXjbkuQ0Hk6R
         DNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865555; x=1700470355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no0g8tCe9M/ACnWMS4hSD43FezMf7B1awhK8Bk++Q5s=;
        b=P1ku7ghdVe4XeRftibWjG3oS37cy9IdczBLxAfQS7l7xEEAtR2L9UcUzloFxmqvbC6
         Pok+P8bGhwBPLKVKR+YBvSHHjr1VReHj0kZzJ2HNoZcRg7OZC5VqXEQO1hafJwArLejs
         kG47nGc2HEIudL4s/JaUrRlw3R1Luqx6DiLkTJOd3eMUpaHqE5Lj035/y1Yqkx86E+aO
         bY2TtP8zfkGCThWMwAHWEv1CKydtZHS52J8yqpSCaRPfbAp+HyU4XFC+Ue5kmdePy1+V
         pbswWbs6MAhsDrDb3CuFv78l1Khi3kxSjVvCIBBzt5FHgxim0LRkfzeL7L8gvRmnrctw
         oMHA==
X-Gm-Message-State: AOJu0YxF5KGpzGE6vRHBNNDMU2fSHm7Zl+nLc4+9VTQVXd8WAI41KW+6
	S+xlv7LtyuiZp+31bL7Wm/2nqA==
X-Google-Smtp-Source: AGHT+IFsly8j4gBEEmGzx7jG20mZD6SJi1vnR92p+ITKjkDMTySIEFv6aW3V8EYHTehBCdLwDahuDg==
X-Received: by 2002:a17:906:855:b0:9ae:82b4:e309 with SMTP id f21-20020a170906085500b009ae82b4e309mr4374711ejd.0.1699865555335;
        Mon, 13 Nov 2023 00:52:35 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b0098ec690e6d7sm3677361ejb.73.2023.11.13.00.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:52:34 -0800 (PST)
Message-ID: <ec3ce84a-8203-b33d-008d-0a49eeb11bba@blackwall.org>
Date: Mon, 13 Nov 2023 10:52:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, David Ahern <dsahern@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> Move {l,t,d}stats allocation to the core and let netdevs pick the stats
> type they need. That way the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc) - all happening in the core.
> 
> Co-developed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>   drivers/net/veth.c        | 16 ++-----------
>   drivers/net/vrf.c         | 14 +++---------
>   include/linux/netdevice.h |  8 +++++++
>   net/core/dev.c            | 47 ++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 59 insertions(+), 26 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


