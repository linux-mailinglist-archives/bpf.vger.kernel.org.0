Return-Path: <bpf+bounces-69686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97721B9E851
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FDF189CBCC
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FEB2E975A;
	Thu, 25 Sep 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvrQvBfR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C06286D73
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794106; cv=none; b=qvv6WRBiHP8h+LWdgb6I0JJA0qHM5R1fjyRVFUEeTQvlRlNePVQ+Ev0iCbCIlx0GgbuHyrrCquKVksszCHsyh6es2ctwnA/IKtximXPzwTT/Lqb2JFiPWoodUt6UF7OFsYkDbMPV1O5XjnOZ7nSGbmhk+pLvF4YrDgmbzMsEh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794106; c=relaxed/simple;
	bh=gYz7iV05DSw4pVhAWjhV3Q0zzhj5V+j80F263wxEhK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tth+8QOm4Q1g2dwS5puUq/fbHoo2qNzixMakRDBaJ3oI6TNfayLY9seSefIASxzCdKR8wyeYX4G+XXzaUJuV9TXqNJunxDQRIf+A98u8J3wPt8VDSm+GPDr9pd5+6AAr7Pv27wx1uQU+5vkHXLJ4WY4mHCh9xosGAeWcGK1uiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvrQvBfR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so91522a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758794103; x=1759398903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6dvovCLm5rvYDjRuqlZ0v6O+tZDtYwybR22eRO2w/w=;
        b=CvrQvBfR60pjYrt0JNov/JUzBIu7LqSKR/md3Vk/16C2BVFDFidGXudncHq/2Ns5d1
         iQioOLx9l0wtXcnHvsuBg8DIiHKBFus7lnQhgdGTZZo3ibU3LNyoOI60TEJoONJ2V+3/
         z9btmhvZnnbvl3TYlEKOP7BE9e2juxFDHABQe9IJ/KACOsO22CCr2zx4ho0Q0WNSqjqw
         QoC2/NUuoftjd9OiJbTJxykezYo2T+MQDH9EyMtt1tnNT9PAh64bqeA3QQ8c8zGu6tCm
         NcyC9Jli7v+vPVunCHe6KAOr3QHyjhfsGtQRcPoOm83Kc3LqmcGPcot4rzpInR237yYM
         BChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794103; x=1759398903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6dvovCLm5rvYDjRuqlZ0v6O+tZDtYwybR22eRO2w/w=;
        b=ibXeZq9X6+UocqA0oBoc1iAuRp9BCMreJiw1N1Ixy+3WQZitAFRp6FKxsU32or2Obx
         I1CC8N+wIhmjiKd727fxDHHZgRe6bEyYz28RucOhse/yaMgb4SQh42ac/K/VVqBTEDhu
         CblHTT7S35RJHgoeZefm3uETs0WTCW/rK2NZSln3ZAhTfzpzdT7AuY4962txH4uT1GBJ
         PsLORVs7HPtrydOuF5xudGe3ZmDVP3DcAXU0AKgGO/aZCDlJq4OpFEPO7sSdGAAGykTr
         HFCxTWpcu2aZsiAiiEB7lQLFePO4IXZbIzqGEBXaMxfYHdycMYO+Gr+N9RHoCPaHYWYa
         b89w==
X-Forwarded-Encrypted: i=1; AJvYcCVz9HEZh2w2vWqooLxuXIibVrd62GDzH+GXJN00HPzviDOjTJuzKREMJcrS0zxuxTYhe2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqeurOeOLyS/v8YmL52rvr6lu5bjj4Ix7eBbECSkhPZClVT/S
	iN4bJy9AQkhJdbj2CpJuSJQrbySFG6pJv2DhlHyawNPD2n5IDZXnaG2L
X-Gm-Gg: ASbGncu0YjGWcEadGrpNm8AMop+JdnZ+ccy/8wJ7Vfy+qUi5arcsWVhKeI1sVCteetn
	6AlHOvXJu4m3BPRa1fqD2VpOpqxzb/LpFDyFkM9g1aQiJKeA6hWxWkZvxcPRyoB45mmm5Eq7yfO
	gSX/IssdETSesESWPjTlKvO9bG1pSbVnIgyJcjN6B/y5VoECEUTJqsNqYnSUVgG1vIj+YE1kF55
	8Xbn6sTWnTFsI+BBU50Op5qQ7hkRENJ7PTlbAqsqR363UaQ+pIYyA1mVZIIjljns9fFr31XI9CU
	PURe+xxvENTDZM/TDB07zKwQOVG+W39xuBEjSGzh2o09Ep/eD0unajaWPPGKhjOtBWHd4addd0m
	RtaYLtNAsi64iK2X+4Q5CNreSNeMNq7yWLCOxQ6GMIm8=
X-Google-Smtp-Source: AGHT+IFTuGy+/aqTWUBxQswnc2Pa/G9YhWnP1H9BAmagYPQwBxO49Up+XtOmxAKd1meYws/OfWOHBA==
X-Received: by 2002:a05:6402:239a:b0:634:9e76:9997 with SMTP id 4fb4d7f45d1cf-6349faa4975mr860990a12.7.1758794103190;
        Thu, 25 Sep 2025 02:55:03 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae31cfsm919842a12.33.2025.09.25.02.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:55:02 -0700 (PDT)
Message-ID: <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
Date: Thu, 25 Sep 2025 11:54:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 jdamato@fastly.com, skhawaja@google.com, dw@davidwei.uk,
 mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <87h5wq50l0.fsf@cloudflare.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <87h5wq50l0.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>   This patch series is intended to make a base for setting
>>   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>   the right index. Although that part I still didn't figure
>>   out yet,I m searching for my guidance to do that as well
>>   as for the correctness of the patches in this series.
> 
> What is the use case/movtivation behind this work?

The goal of the work is to have xdp programs have the correct packet RX 
queue index after being redirected through cpumap because currently the 
queue_index gets unset or more accurately set to 0 as a default in 
xdp_rxq_info. This is my current understanding.I still have to know how 
I can propogate that HW hint from the NICs to the function where I need it.

Regards,
Mehdi

