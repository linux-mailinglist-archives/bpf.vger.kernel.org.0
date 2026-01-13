Return-Path: <bpf+bounces-78698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78FD18A34
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BE593024B59
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935038E5EE;
	Tue, 13 Jan 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPZTjifV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYjL3mBh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9127330663
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306193; cv=none; b=Ts3u/zTt3jbP/IL9zrSiIIQjb1UQiNzJia2FRDJQrEsZytvC5R1Ynf1ZtJDptmdfa1GwkLmVKf8tYJyQ5r5OeeniiO6esjlcgIbRo9d3AwH+y0r8OrjIg2uVmBeardJsxqEAlw5jGyTXeDoQ/RC5RN8U5LAr4+cUNR9felU2Wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306193; c=relaxed/simple;
	bh=FOyIQHUl4fbCHcsoPOztRQ8Gbk8nvysXb5RItoObpWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOY9yFGjBfw31gFl+wS+1A5tbLxGOKYa+bXQ/GEQu45un+F0BonXdej2+UaRZt36jAgJzIp7ixqksu7jihtJigFS2PYwYv15MUxaNCsrlwQErGJDdbhhMhu6DDvSiWgKDJzi7BbUha3uSZuEkAjHNLdfOdcwbmmq46AKWWe9SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPZTjifV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYjL3mBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768306190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsGcz1WvRRNjaeiS8L2jAs44Dq1ERVZgiS9YT2RR8qE=;
	b=bPZTjifVP+d1diN3DS88PLkz+Fxj8RfgR1n4RR5ELvvGgzovKtYlEavdXoY4VL7v3ygfLe
	tKvrVI39Hx+DdSmE9eqEYby19fn3s0Qm4hegAvSE2jzKBZe/DGMkTU/Nxgn/87jKckxA2+
	/lC19Bt3N4xjY5MEXJ3aI9gKzG1PFm0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-vvj2ePPsMgeFmkLSdmiTKw-1; Tue, 13 Jan 2026 07:09:49 -0500
X-MC-Unique: vvj2ePPsMgeFmkLSdmiTKw-1
X-Mimecast-MFC-AGG-ID: vvj2ePPsMgeFmkLSdmiTKw_1768306188
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4776079ada3so74857805e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768306188; x=1768910988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsGcz1WvRRNjaeiS8L2jAs44Dq1ERVZgiS9YT2RR8qE=;
        b=ZYjL3mBh7xGNgKFDW04/ZK8hTDoTtzhKnE7XG9z1Cgv2t8jSF80/1GoG6BVslmWlWU
         LREtawf4HIukG1BSCb6bP8yPvLx3zZ0b8l+DLyiFY5nL6YI3acNkfahwpRQsxZVpEHtx
         0TxdUNM3nYupd042UBW3JvsotV1nNIP9Y9SJPwH1qhKzy+p0Xsi2zRePFe7f0bUw5LJB
         xLRK5FE3thYI1uA1ML8LFF8HcB19KLCRCL5e6vn+DJEB7ryxl7fuKQyAZ8qHSjtuZBog
         rRXqPPAfbqXJPQi3TuWxrCHvD78j0Ezauetg3DxC5gAPSfwXy3wY9V6EhrlkBEvZ8b4g
         gLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306188; x=1768910988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsGcz1WvRRNjaeiS8L2jAs44Dq1ERVZgiS9YT2RR8qE=;
        b=tpLHuHq4KHwqvr1qLEKK4WUwgoOT03gLov8PmegTPiN720EGs503uHh6DPWjzC4SXy
         uQLr1pn5HjSQjCG9W6SL/9mBhPR0yP2NFSHaAqkRFB/6wt8fkSocFej3kmm+G2B8Hht5
         mPuUOejYaYqeJ/phJJ7k0t7ZfbTeDubevt1fTn9wTvE+LHs+n6BnVq6mZFbORYxEQ0Jc
         IqaTfOFGpb1fem8YG21CZRpwqpcu+tHRgOUaZeHGbNjPEXitz9nKiKHLHxGjjNS9/HVb
         7X+h3QXBvVE4L4ICYCP95tfiHjKqMHrBxAPS1dxF8ZVszFl5qN6WQdMT4J6N1j6JVAzn
         Qmxw==
X-Forwarded-Encrypted: i=1; AJvYcCXcD26Ie8HDZelt8CQw4mlY+9IXUCKHKJg8LzZth/aZa+3oQmcf+3cfuoq2cAhgKTJYdhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFXdvacBKvy1yl2cHwqOQeLRoIWmoYxup7u/q7GXUBQfE1XfT
	zSzHaqp0aLFQDejLtta5eImd3krrqXwoXc9tmH7fMgkjAVbDB8cWazXhQkYOAwjfyOB1xbHDBAQ
	L3dtMPi/ahYQQ/qboVebSi4YhPvZZP6+tqrrrcVB+WzHnOXhJTcEb6w==
X-Gm-Gg: AY/fxX6Xpm0P1qr77rWEPzgftadfLexJiXa5RAxgkYNvALc3A7RqNj8OsdbE2OLK4LU
	8z8Jse2BmaNcs4a678bP/cRrWoSam6Ua5L2BMUaEGuR3eNBL5RV+YJZ45dtCZTN9aIlr1mg0U/r
	H7tk86m63WZSCPhCH/5GMSjlHaW3W6KrW/SuO3+dXExkvDmBV84gqzwofcJot8sYzV6yuOH95ld
	ve6BM1OqhavWUnVYQ9PfTcYLjdEDjquJg0RbW/o3Tps/fiGCKs1Yr2rOvhAgdJdG3yGfzXA9NN6
	0bqwZHXWoTD+WMoKZbvUkKjwWJChuWZE2yTqwIANR8PutCwzKE8MTVVJ2CiaxAOY8tb+bhNJ/69
	DM5PuuBaQvESJ
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47d84b3baa1mr178881825e9.20.1768306188269;
        Tue, 13 Jan 2026 04:09:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbuQTgjpKPcD3xlT3gcWAoP5ISZy4bXMwf1kvmiWmEM/sGrJ6JqtEl7Khb8z0QKPsiYSNlnw==
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47d84b3baa1mr178881355e9.20.1768306187854;
        Tue, 13 Jan 2026 04:09:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm43465294f8f.37.2026.01.13.04.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 04:09:47 -0800 (PST)
Message-ID: <36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
Date: Tue, 13 Jan 2026 13:09:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
To: Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112190856.3ff91f8d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 4:08 AM, Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 22:05:14 +0100 Jakub Sitnicki wrote:
>> This series is split out of [1] following discussion with Jakub.
>>
>> To copy XDP metadata into an skb extension when skb_metadata_set() is
>> called, we need to locate the metadata contents.
> 
> "When skb_metadata_set() is called"? I think that may cause perf
> regressions unless we merge major optimizations at the same time?
> Should we defer touching the drivers until we have a PoC and some
> idea whether allocating the extension right away is manageable or 
> we are better off doing it via a kfunc in TC (after GRO)?
> To be clear putting the metadata in an extension right away would
> indeed be much cleaner, just not sure how much of the perf hit we 
> can optimize away..

I agree it would be better deferring touching the driver before we have
proof there will not be significant regressions.

IIRC, at early MPTCP impl time, Eric suggested increasing struct sk_buff
size as an alternative to the mptcp skb extension, leaving the added
trailing part uninitialized when the sk_buff is allocated.

If skb extensions usage become so ubicuos they are basically allocated
for each packet, the total skb extension is kept under strict control
and remains reasonable (assuming it is :), perhaps we could consider
revisiting the above mentioned approach?

/P


