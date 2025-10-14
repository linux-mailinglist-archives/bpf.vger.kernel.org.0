Return-Path: <bpf+bounces-70916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67198BDAC6D
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20893E4FD6
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409E307AEB;
	Tue, 14 Oct 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="BdCwsSQO"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B174305061;
	Tue, 14 Oct 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462991; cv=none; b=FdJlFw2V2skbnfc/J6i3ERUnqgfPZ+03N3gy/KeDcisE0+VQlHuU8eUUtRXEuZ2ifXbfDuhI7oN6gLJ0F/QdwoLYLVnxaiDRXy//Gk0khNh6x+chMTtA6xdSOVXjLyc0R42THoZNjDxBIp+Ct6/z3sQewXx5XT70AntRx0DH34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462991; c=relaxed/simple;
	bh=9KJBxjhG38hJDjR/lN8Fu+imHEXVbydQSLgDlbbY6ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbr5/WRlkiW1akrM2ELHiljrReCDfukXFZ8I+Nbg1N0ckNWzRDNEFi0rPswH2S5Jnn2dBMJ5v2xebmYpGNNgB1KP8CXHsp6omTTZY5BfrknVfu2LIow5vkf12IUM+BsaokHiBO3oLZG1G6cM2/e/+WA1ztto7jRUvLmkZ1XB/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=BdCwsSQO; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760462979;
	bh=9KJBxjhG38hJDjR/lN8Fu+imHEXVbydQSLgDlbbY6ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BdCwsSQOyprdkLeBASULbHg0508Otd/J9TWVwwhLKmwoh1NEZtoz/wacOqYR1iNFK
	 Gg9Q2f0qoL+GiiunRHyH3Smw8TmrG+6WBWnQ/giMazJZ6FLLu3vsoELWAYKjo7Z+LI
	 InoyAP85SwRtqcAbRU1lM5JPL4avVucrxaTbtXbhlDwTqddIMaZQKJK59cjXTaKknl
	 zE3niHLqtxYu/Nhzdpf0EztSuZJq5iRwk/PHypR0fmNxKuuqvW2eMrX8PVZRwx6YmM
	 gwVhaQ1x+URKOTzPGUdWXiWfxFJvhn+Y1pMT86ElGlnhuPl6KogYcxRyVn8yexe147
	 r5jPjK4avMgDw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8E786600C1;
	Tue, 14 Oct 2025 17:29:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 266C1201EBD;
	Tue, 14 Oct 2025 16:49:23 +0000 (UTC)
Message-ID: <d3f1427f-e8bc-4ab0-bf15-171b701325b9@fiberby.net>
Date: Tue, 14 Oct 2025 16:49:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] tools: ynl-gen: bitshift the flag values in
 the generated code
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Daniel Zahka
 <daniel.zahka@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Joe Damato <jdamato@fastly.com>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013165005.83659-1-ast@fiberby.net>
 <20251013165005.83659-2-ast@fiberby.net> <20251013175331.281ec43e@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251013175331.281ec43e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/25 12:53 AM, Jakub Kicinski wrote:
> On Mon, 13 Oct 2025 16:49:58 +0000 Asbjørn Sloth Tønnesen wrote:
>> Instead of pre-computing the flag values within the code generator,
>> then move the bitshift operation into the generated code.
>>
>> This IMHO makes the generated code read more like handwritten code.
> 
> I like it the way it is. The values are irrelevant.

Bit-shifting seams like the preferred way across the uAPI headers.

Would you be open to hexadecimal notation, if not bit-shifting?

Currently NLA_POLICY_MASK() is generated with a hexadecimal mask, and
with these patches, if render-max is not set. If using literal values
then we should properly consistently generate them as either decimal
or hexadecimal. I prefer hexadecimal over decimal.

> And returning a string from user_value() is quite ugly.
It only returns a string, when as_c is set, I am happy to duplicate
some code instead, and add a dedicated method always returning a string,
but can we please agree on the generated output, before implementation?

