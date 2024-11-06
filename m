Return-Path: <bpf+bounces-44085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA87E9BDA4A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 01:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FEB284D5C
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3761DFFD;
	Wed,  6 Nov 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OP8ey3sN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7780B
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852877; cv=none; b=M+qdSRvW8Rip3DrSf72OJDJUMWcWHvLUat7Mp6sGtc4pR3bkrZWqTBvgU7NQKQxv0xXTt/hAp9pzN6zIoHD2vcgY9wdmuxSQqSffxqgxLCW15icoUyXSSy0ySzhp77hDBGjuSfrMIGd0VwCE7FD75mNAYYsqMQ3fXfvN1/kVeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852877; c=relaxed/simple;
	bh=b6uK7llb5e36CA4wEXAAc0AxUMUzILjII6G0DIJYf6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOtdPu8/wzODB9AbUITPAk9GjLsxCGC8WHTCny680cIWlfhG2i5iLouvSbUnZe/J06eRbFGrPii1t/ZVRupqEW74Tzmwcnqhsh5kTwxifMGhCdawvXPAmCVA3zUYBBJAMQkVUx1s9EV++xN3Uk81aDg01p7qbd1z6kGKOU1y1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OP8ey3sN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbce9e4598so37089306d6.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730852875; x=1731457675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPWQa+FTKYMBuDDcOKjxAgUcKitW+kesNp1QCv0e5R0=;
        b=OP8ey3sNOnsjyUzu0634OhEBwtsA1Mijx1spL7BwL0urvph0Rn4KZ/and2vDjFyWBU
         SMLBswJMXGEmpAPdeIElcKW9z50V4g3fmc+2I/u2mWbwtGl6uncw9TXig0p/BOyTSJpl
         5msLR3zjAb5c4WrfjnIBoXIyAtLHLsSdgStDTNwH7FS79UnjAOJeso4729LLF9PbTiiS
         MBkQY4i0GT+BHF102+DDgRqc3Y2RvlPi9L5cO2e6zMdXRU7Rib7dlJHlo2+ceNZu/E9Y
         iTpwDIePfuMgXvBwMPWdgnsWNYz4Im0pcUbkAdqMW/BNj3LN774RN1/GMXDzsuQipocf
         Xl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730852875; x=1731457675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPWQa+FTKYMBuDDcOKjxAgUcKitW+kesNp1QCv0e5R0=;
        b=f8uN1El0Xx3yK4WsDlle/5airLayCje3SlsXYUnRHN/YhO5m6D5IGEc9teWRXwaCjy
         ckURjuE+YD43QuvD4DvEbGwZpxPKAmXTUK6OeSsBOjz7S4nzejuI9aDYLNw9uO3TeFED
         /V10EfRlNqlNnSoxI6rWa8hbCQFHLuP2oyZemfQwvZIpnt0jZfAIeSq1QzGH7UhTcKrV
         2c8ZUdpor6cep7HxSJK0lw/sd86gv76XdQDtdjc5Uu38QjpAU08/W90fw8kXQeGxQt8X
         +Lx4drPFat+HVR65La+oiYcCaWSXC1YGgtZrYtb2miHn61ho/BFZUMCwPQrDC4ByMoav
         F8Ug==
X-Gm-Message-State: AOJu0Yyc3w5DjD8ZjeNAJI51GhHvYymCp9EtuR2U9DJd3pXGb/O+SAvm
	4ynPSI+hNHh9LJAkD3oDRKD6e1UYF6HqEFTEGIPKxPtyccARSqK7AyXuXfiKtKM=
X-Google-Smtp-Source: AGHT+IHkF61LIO7nneCgEwYCw4dCRD6xpNeXLJfFmTXxxf96FpcaIJmiMVnEV6PRFIp8IFBPbaPz/w==
X-Received: by 2002:a05:6214:3bc5:b0:6ce:26d0:c7b4 with SMTP id 6a1803df08f44-6d35c19bf44mr260048106d6.44.1730852875016;
        Tue, 05 Nov 2024 16:27:55 -0800 (PST)
Received: from ?IPV6:2601:647:4200:9750:314c:a1fc:f04f:2b34? ([2601:647:4200:9750:314c:a1fc:f04f:2b34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b2e3sm66002826d6.81.2024.11.05.16.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 16:27:54 -0800 (PST)
Message-ID: <de982cf0-45f5-46bc-91a7-e0f1d7745686@bytedance.com>
Date: Tue, 5 Nov 2024 16:27:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK
 check in tls_sw_has_ctx_tx/rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 stfomichev@gmail.com, netdev@vger.kernel.org
References: <20241030161855.149784-1-zijianzhang@bytedance.com>
 <20241103121546.4b9558aa@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20241103121546.4b9558aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/24 12:15 PM, Jakub Kicinski wrote:
> On Wed, 30 Oct 2024 16:18:55 +0000 zijianzhang@bytedance.com wrote:
>> As the introduction of the support for vsock and unix sockets in sockmap,
>> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
>> vsock and af_unix sockets have vsock_sock and unix_sock instead of
>> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
>> pointer and cause page fault in function tls_sw_ctx_rx.
> 
> Since it's touching TLS code:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> I wonder if we should move these helpers to skmsg or such, since only
> bpf uses them.
> 

Agree, skmsg.h seems a better place for these two helpers.

