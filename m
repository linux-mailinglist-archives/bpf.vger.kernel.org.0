Return-Path: <bpf+bounces-74952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4FAC69648
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DC95F2AC95
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8275235388A;
	Tue, 18 Nov 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9u+Zopz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQwhlZbs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03F33B97C
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469157; cv=none; b=GFf6WFFM2nQS4McQM3RJhCqEdAY6kkJCXyyV1jIqOsRZswzMQu5O3wuMoYd4dl085IoqZqtgpi/SFt7sdLylA2MzROPkvjOKTMil7QddYQc36sDC6dmymR6J1CT4ECOxu01r2b/TspOCnufci7o9clyT1XeZK/Svl6bGqbavxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469157; c=relaxed/simple;
	bh=DTaU0Q9eSCt9Q5BWyjMoRvlzd8ouWytjAvoYZ3iv3cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cHy+isG779MPEklf47kWH3148PjWgmj4cAsmXRe1CJOzwWV02NvDXZq3LqZd39ykgBLEYZdheqsU9fo3r5Y9Ide8qJsfXCVD0ZK7KzCnj8Z6AtkuyzCtiUlMb9YpU2pE8bq2J26kDUUpW19MXHqvBH/0CcleOIv4K8JZ15nfM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9u+Zopz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQwhlZbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763469154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
	b=U9u+ZopzuetLY3x7AyM+7zlxNP0uf5Ti3/G7CR278Bvysr5/886HWj4YA1R7O4K9GbulBw
	zIGq/GnTuGBb6zYUDb7POJYF8/KfzJZl0/RTJNrruQbf9Oj7gd1XUA3T1FvrAf10HrKq9v
	vjyZeREnASE2Osix317aT0zGlqENCtA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-c_Dy7zT-MVG3qDQVqlByTQ-1; Tue, 18 Nov 2025 07:32:32 -0500
X-MC-Unique: c_Dy7zT-MVG3qDQVqlByTQ-1
X-Mimecast-MFC-AGG-ID: c_Dy7zT-MVG3qDQVqlByTQ_1763469152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so2597977f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763469151; x=1764073951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
        b=cQwhlZbs4zt13LJuvvTf6u1L+WO1lo44p6vuzpc8B53pMNYeLuELmvr35iuQUjNRSC
         Siugvu0vQLmCD1dK76BGviJchMu17IFt6NZbG3MryiU2H39SsdCfya8GyFQUBXmnRf5q
         ZG6xGv+CDjfjo+xPQecaPF0L2kOuboCSHQVf/gIJG/acnIzVJduB3QET9Awej2br0KvU
         O8TmMQPBrkS6LN1GBUpuMRSnLj37BXbm9e18LlzfazVk40fqAvV9cDke7FWLChb1qHhR
         qb0jv0i7OwN5/1/54t29Ls9VdXDwE1C1ze2LvGSeRRezq/UgFcxNaUewQxToEbJNNMda
         BRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469151; x=1764073951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
        b=hLUYKRWRtTq5IGrEb4vcJeP8JU8D/zxu8Plq7aRvYsEMZwgw+ZeG3TqrW8yx3N0pbg
         rFeDgroK01tHZPUBDGc7uQLPWU1HLqxEhtsfKZy93F8/TIDqw52FG+Kcuk0T9+8kyjW5
         2DKPMKGOtxG+fLK/AMtV9H7YGE7Urf0wqFC5rdooxqdjx6NePnDeSEpQfptmHbV8ZFO0
         PiGYDLo5O31J0a3wO/QjtLoswfaEApXpuTLq0lSEA6qfL9CxtJTO+OvarRl8u64fxJZO
         GTSVQQ1Tf21NGWc4z4/vaIKYQQkV0x1sTTI3qGcd9s9xJu41JiY1BFaeYcvs5tujJCQ8
         BMkg==
X-Forwarded-Encrypted: i=1; AJvYcCUEUVisovFRLSGhYIbBWxEue0RrPEsAwdhfOJSMYEPkO34qyk4w2mRcpeMAnO5OlM72saY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0nBQ363iUZdnysBLJTJk0eIbu1/F7U4xVcKNECLVIXe+Fdhu
	6/ln02uYa0Z/Mo4+e6e/6J2UEr+rKqEoiBijtcLM4f28Z8r+ALKwgLvaFuyzJ3ASOkMQi3mLwDW
	qGacpoA8IbC2EMZmzTG2WztTI4F5zxqlb0Ev00NRWe+PH6DbFEw6wbQ==
X-Gm-Gg: ASbGncsk4usdG1oN4v8ssWJakq0PCUZt/WB6V+6Ov73tdOouhR98Xz+KOPVaAJXO+yn
	CCd4+HpYMcKA3NB800QOI/wTuBC6VQjkWK9eRBurQmxxVhdcSVh8YpVbLRlMAy/2I3AdPT8MCZ1
	HKIiLEx7VHTH9bK8sDaGuOIsgsiM17a+iryE70CBH291lqZIpZWwSSwSGwTY2Ioe8Ifcx5btAgr
	ObLor6oBjqmOfo2yZCNc2GQQlwm4Jn8RHKQg64vfnb8Y6q3KjRtpcPU80xurzGPRAPVQ+EIKNSY
	UX88qlo/qSSs++XQP6yETVKCPYrQUQl1JFfjK582Tt8IF3XGC2Kn+YIGkI2UDdikVQtwRICQrjG
	4C4grbJxeKpfT
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr157483565e9.3.1763469151645;
        Tue, 18 Nov 2025 04:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHFPZWLtIKBW62/sV/sykL4J1KL6tvHkeTFz5Ymr6cDp9e0U+MBYs0Z/GsHEyfY0VQ+h19FA==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr157482965e9.3.1763469151084;
        Tue, 18 Nov 2025 04:32:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a2892c8sm187622705e9.1.2025.11.18.04.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:32:30 -0800 (PST)
Message-ID: <6332df88-2d49-4dd6-8089-567129f1ef83@redhat.com>
Date: Tue, 18 Nov 2025 13:32:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 09/14] tcp: add TCP_SYNACK_RETRANS synack_type
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Before this patch, retransmitted SYN/ACK did not have a specific synack_type;
> however, the upcoming patch needs to distinguish between retransmitted and
> non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
> SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
> synack_type (TCP_SYNACK_RETRANS).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


