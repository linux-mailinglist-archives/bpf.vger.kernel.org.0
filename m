Return-Path: <bpf+bounces-57770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F59AAFE3E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42663A4B22
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690627A13D;
	Thu,  8 May 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S17PT/lX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4127A117;
	Thu,  8 May 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716672; cv=none; b=ZxDkQ3L/tlnvBrkKhYlvi+umGeVA5Taaqyf4M2ElRt6twWGSPF2QhojTfROKB4QPQ971FKU6Je14UV12ujpMaXwMKHYMDvSPwM/NCrW519tuXovuCKcNjFDaD70qG3lIydrcamy5pkMIvVpO8VFoC1Pes28ysZFWDZ3Ts90SPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716672; c=relaxed/simple;
	bh=f3pmFd270dNu8Or/W5yMS5uS6+F/sXTuIJWQ9O160r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQsdvetx/nd1EeCJrJ91VrKSmxN2lyenswWI3L0M6LTwhnWCJSzQKDylZevSKqL5b30eSjRNOkE+0jfZ6U04oEqpepuh3zR2HMjuOT9Oc+2vOkEv4XcqJgG7vQXU8peWM4DV3ufmkB0LI9QZSjueSfJ10WFRliLEu4lVmuCZB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S17PT/lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0AAC4CEE7;
	Thu,  8 May 2025 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716671;
	bh=f3pmFd270dNu8Or/W5yMS5uS6+F/sXTuIJWQ9O160r4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S17PT/lXZ5YOR9C4Vq2tbijKplcCmnht6DSb22qwndgoCUCxKAXe8Xl4e8I5ZMzjB
	 ps8GAurH0tTKCcMs51rW/AiQkuIgO4H7DYTX11tinnvapbSuiGdX6pN5DVrq8LjmD/
	 WxhosMNAIUa/sInQOcD97TghzLEqliob05H0nFJgww+seDGK5YLJJSpfy9F1em83f5
	 SGQ5CXdzledoXGVykgM5Lm8SGzTiSIBFUhb86BWo6iJTI3f20o/GlRuGhDl78jp+Q/
	 WM8iLKGrnj5nXHyv15Ayt5ZdpGC5W7Tnjf/KdaaFfjvV9CkGJvlw0QmtU7jinNZeSC
	 7DByatnPTED+A==
Message-ID: <2508ea8d-b7e3-49dc-b110-7eba1e4ece4d@kernel.org>
Date: Thu, 8 May 2025 17:04:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20250507161912.3271227-1-jon@nutanix.com>
 <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
 <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
 <681cb1d4cb20_2574d529466@willemb.c.googlers.com.notmuch>
 <962b227f-9673-4050-90b2-334850087487@kernel.org>
 <7C311781-F3BA-4AEB-BD17-892A88192016@nutanix.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <7C311781-F3BA-4AEB-BD17-892A88192016@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08/05/2025 16.24, Jon Kohler wrote:
> 
>> On May 8, 2025, at 10:16 AM, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
[...]
>>
>> AFAICR there is also some dual packet handling code path for XDP in
>> vhost_net/tun.  I'm also willing to take the paper-cut, for cleaning
>> that up.
>>
>> --Jesper
> 
> When you say dual packet handling, what are you referring to specifically?

The important part of the sentence was *code path*, as in multiple code 
path for packets.

You tricked me into looking up the code for you...

It was in drivers/net/virtio_net.c where function receive_buf() calls[1]
three different functions based on different checks.  Some cases support
XDP and others don't.  I though you talked about this in another thread?

--Jesper

[1] 
https://elixir.bootlin.com/linux/v6.15-rc5/source/drivers/net/virtio_net.c#L2570-L2573




