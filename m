Return-Path: <bpf+bounces-14980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E597E9836
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 09:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C5E280C47
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05558182BD;
	Mon, 13 Nov 2023 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NX3JtGnM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AA1643A
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 08:55:39 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD58D1FEF
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:55:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso634298866b.1
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865736; x=1700470536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxdEd1wour3zDOqRujjcDyz9k3KjzIMb/Xvtn0yY41Y=;
        b=NX3JtGnM4flZR51xtZLemlVGFRn4QVZX00J8Dy4SkIujmAiRCWp9MIxeq1kjEnvc9+
         Xc/PPndnCg8CWXZsthSjiLSDHkrJkWDN8ac2il4Y9wEFH+rC8jAHHQrJhz9TEbXYiRay
         QzReSe8/qXVmUL0NiK1gh1w10+nn9H7Z6W5Xv6u2mkmhX/PqYWsnG6yXz+BFtqnWw5aY
         /LG+w1FH38vVrcbeZTedUIgycN9Zn1uISp9SKPrVD588+AmB3rkOI88u0C7ks78HmbNI
         j1eZ4DHOuso0xXzRCs8U37+GKDfskhiAlVQO+sIt1pPNq/lwGFRYnVs7qs4bfVxNK/kf
         IAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865736; x=1700470536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxdEd1wour3zDOqRujjcDyz9k3KjzIMb/Xvtn0yY41Y=;
        b=XbfTOO5cIyt+FKrwOllPymLgYncbQUkyTX11Zyh2TqF1CpBPzvooVP8O9NcH7KoDT2
         F7UiksqMp4Kc847LGp2KZFUUQNo5H5ABqCYmuOCdZ7SbBaD6e4mhhi0R5a+zir47I3Tt
         T8rEDyzZWWumAk5RJfhsJbQR8HaguSXyF1yKT5acMgLcXUAEl7rlzgFFngb5hdIYKwtC
         +58MagKJ0sKwy5rFAfONEdGwzsCRwC6TN5g46zbHggsw6Zqs8O5sCFXyvVeLgnS6+hdp
         XFcSoxVp0SbX6qSdquWexIZZY8+ch0d/t22xzdpXEwhJgK2bO40oIeJvqx4LCY3UPSoJ
         jI5g==
X-Gm-Message-State: AOJu0YzqrbZov7YCwx93XLDzKbILhO4BHouApcPCPmzqnmOZSd1SgDe7
	XahXBKRAMpBLnI00+xnz6DiG8A==
X-Google-Smtp-Source: AGHT+IFPxqLxFoRl9yAj7DA0ZD9F5WtLGeJf0FTh94K8nuK0/ID82TWQc8bNHB2npcZBGKlW/HeRiA==
X-Received: by 2002:a17:906:e0cb:b0:9a5:7759:19c0 with SMTP id gl11-20020a170906e0cb00b009a5775919c0mr4417240ejb.64.1699865736278;
        Mon, 13 Nov 2023 00:55:36 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a170906780c00b009c0c511bd62sm3667510ejm.197.2023.11.13.00.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:55:35 -0800 (PST)
Message-ID: <9e700566-8ea4-919b-320b-1d58ef96f116@blackwall.org>
Date: Mon, 13 Nov 2023 10:55:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 8/8] selftests/bpf: Add netkit to tc_redirect
 selftest
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-9-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-9-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> Extend the existing tc_redirect selftest to also cover netkit devices
> for exercising the bpf_redirect_peer() code paths, so that we have both
> veth as well as netkit covered, all tests still pass after this change.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> ---
>   .../selftests/bpf/prog_tests/tc_redirect.c    | 52 +++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



