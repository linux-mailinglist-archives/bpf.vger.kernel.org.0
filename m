Return-Path: <bpf+bounces-67069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC083B3D19F
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24F7189DB8A
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 09:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24224E4C4;
	Sun, 31 Aug 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRE0/Su9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB153D81;
	Sun, 31 Aug 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756632490; cv=none; b=b4VEM/EIJDxJXDj50l24pBgZRPdrs7GxBvQ0RCOms707rOUf1q1j3NnN8ZfXkIZXQ6lTzhI+83b5mIEgoqfXHud1tRUN2YXJBEAj7iwtc2usTcV0u3EY/afIQPssdL7CtHoLED22ojGgwRdpp5rHbiPFpeQ1khKTN073p+p2YtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756632490; c=relaxed/simple;
	bh=XPJ4hFRfRkyT/XA+k0K0wp/bwh5t0nxRoRj7nHtr5Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCHb79P+BeEzm88dFUt8lplf09AD24coOg6/jnTT38ZTk+c0bPQEVyxu3zlUIJluyWkkpmB+rJcwdJvyVq9PsNiC8uCq0cieYsvRkidsc6+SfOYMZwZTqfu1MbhZVIoRgL1GARJJ1ja1axpwGtXc1lBc/BzJxp5Fo/Si2xUIZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRE0/Su9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b82a21e6bso11229695e9.2;
        Sun, 31 Aug 2025 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756632487; x=1757237287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+xG21Oeo6HSyqyssQi7DDQRhEgxOVv7xjDl0q72uBU=;
        b=FRE0/Su9Pic/rkFi8aadwPCzXfEmGuxRBW4JhDDH4SY+DPoBDMspCUNfbIeYgoQNlC
         bdRFhHAf/s7cPl6xEe9SMs1ybmuidmXOEr5NnLXpuUy6NjFfBtOV7Wyhs/k4IsyN7ZrK
         pSnohr1+jdJd7/pHhD5xQ45HHdRveyW6NXQLUVVs7YwrKCg+YXc4gPFgs/NSUp3H9qY6
         OXRk+cCExylc8R6hZfEgCZBSByGNJJzATWF1SOgBmdiF+JenHKWG6AosqRU01/9wfAVK
         7NfA4z8L+37z+SB9wt5VqDAXx8nMAWJGd0IBxomR508L00dKCiaFn+Zfu8yMYssD2cqX
         hbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756632487; x=1757237287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+xG21Oeo6HSyqyssQi7DDQRhEgxOVv7xjDl0q72uBU=;
        b=dePz7cCy2dpJQHNSPSnlnwJk/2YYIpfXlucLEDVVf0kdDtgKc4kA0gYu3UXlpJSk3K
         x1we1KW6shBp9h8AbOuVp8cpzXQNZMm8xp3bEJ+eWWX0jMsLi0qPHVsFYCwLFNQJKEv0
         uxuuwJii3/yghyGH55QXBxoggIANkp5ALqP2rDBaz19lVo/fwzCXxVYOLNU2Bv8r01my
         5QjM0yne3gMUFYZOpEgB/BOKBfNr4Uh3f22A38STe3z6tUZroZ8th2S/X4GJGHxtwU2G
         QaJAJ/7AGAZ8me5ufCXcV9UQnNq2iNw50YeN83vD4OpTinquoztp3mu2TgIksgco94UL
         mJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRlvbQFwr2mjgK1ylBl0bVvvPxt0vVneXLoRWfOPyBK/Le+RkBciMYKBBpwFVZfknNw11pZFhcdrJFgA==@vger.kernel.org, AJvYcCW63jcl4C5F129uDmSPb3IPb0Nahz1BCgMaizcNhY1LbuOWIzD9UO+0IOdv07MqDjkuMHo=@vger.kernel.org, AJvYcCXcjbMVLEdtM3Fa2OtZZMn0EfgaFolWhkQ+JMM7DSxGPcH3qzqh83KAe/E9p6/+JcBsvfyM34Zq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4SJ/Dii13IZS7WkIBjTQ2WvKXzK+X8nvbKtU0Q5CXeExIZ44
	RzCRUOurqmoD5LGc5U1mdqwPQfV4Pz7+OyjO999YoMuRkwpZD9feXqK1
X-Gm-Gg: ASbGncua4Z7fnIgaFrxT/7qFEcGeoadYe9uug9wDu00ZKoTvSECrRuNPZ3E1Mdx3PSY
	100bbOniW62ryCCMGlJbulr8AE8qVn19rdkYvL4GxHxcgmDEfxMfCWJKDwt+sT/aLVun7aywC18
	lkupnidVDLVVKK9nbgdFre8hFZzVmwcqEZKK2P3/yIxTkHs2O686hwG9e9re2QBVTDwhCCbuTGh
	IplWJrY5/QWO0++h7dfm3T86mnXmxZf4p4kpKPDDlsh1ZoRFNjXtzMgRjMa1XAyvB/umlf+Vu1v
	Sd1jQlGnYs6U1DWJgOvcy9HjeF4x9MkN4H3YOuEeoR7U2LrU4n9n47zqh2lDyB1DQLHNTgwilsu
	zrWHJo3cMkjUfQobS7833+pRom0ugwUa97MtTXEuJHGEC2g==
X-Google-Smtp-Source: AGHT+IEryDBAwgH4ZBdTyXuCEd0bPl6kuLLfrmQASO3st64H4tDFzb2aAzLU74xzS75Na386oTvwmQ==
X-Received: by 2002:a05:600c:a4c:b0:45b:7bba:c7a6 with SMTP id 5b1f17b1804b1-45b85598aaemr28343535e9.32.1756632486727;
        Sun, 31 Aug 2025 02:28:06 -0700 (PDT)
Received: from [10.221.199.15] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d12c90a01bsm7872246f8f.31.2025.08.31.02.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 02:28:06 -0700 (PDT)
Message-ID: <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
Date: Sun, 31 Aug 2025 12:28:05 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Saeed Mahameed <saeed@kernel.org>, cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <aLIs_-lDKHCLTrTy@x130>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <aLIs_-lDKHCLTrTy@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/08/2025 1:43, Saeed Mahameed wrote:
> On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
>> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
>> copies parts of the payload to the linear part of the skb.
>>
>> This triggers suboptimal processing in GRO, causing slow throughput,...
>>
>> This patch series addresses this by using eth_get_headlen to compute the
>> size of the protocol headers and only copy those bits. This results in
>> a significant throughput improvement (detailled results in the specific
>> patch).
>>
>> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> 
> LGTM, I would love to take this to net-next-mlx5 and submit it back to
> netdev after regression testing if that's ok? Christoph? Anyway I will 
> wait for Jakub to mark this as "awaiting-upstream" or if he
> applies it directly then fine.
> 
> 
> 

Hi,

I recall trying out similar approach internally a few years ago.

eth_get_headlen() function didn't work properly for non-Eth frames 
(ipoib). I believe this is still the case.

Extra care is needed for the ipoib flow, which I assume gets broken here.

According to the perf gain, it is worth splitting to multiple code paths 
via branches/function pointers.

Regards,
Tariq

