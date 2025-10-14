Return-Path: <bpf+bounces-70915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E6BDAC68
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67184355AE7
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E219307AD7;
	Tue, 14 Oct 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RP5bjAah"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F93016FD;
	Tue, 14 Oct 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462991; cv=none; b=XXEDJAp5nP7E1KVI1qVv5v2Jg/GqNh3s9vO1u+vNuwqWNfXNzrd0wvtimAMm8Pu7mmoPVnnkrfW6DOfvLtySTRIwglwNyQNP3QvDWuWHbAoG7FN8sqpyBW1D7NNUNoTXnCqSp9eXi27Q3vBoLZcR1HKNaI+0AbIkN3n0oEEeCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462991; c=relaxed/simple;
	bh=lDjuXCExYFk19/NGzi68q3S7dGAQ5tJ0UHZhqIDkIG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E45kOezuxs9iZziu3/7ScdYl2wfYtjNeYBIr19kX+jUnW5lKWdGw7euOUSMLHC/6eAe7qP3yLi3JkJ44Wz+kfra3Kt/RJXF/iOaVzPRRBcJ3u8VRvEOYNvJmDKSSLRXyrSU03+l/XSSMRugqtuzB3/dPmA1MJr4j3cFKyq5YRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RP5bjAah; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760462979;
	bh=lDjuXCExYFk19/NGzi68q3S7dGAQ5tJ0UHZhqIDkIG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RP5bjAahHILoBRIuJAG+KGPL08a/B+GkvunRQW09wtRGQV1Ry8J+ZVT3ipilnScKo
	 ESLYxDhWdsK4SPwX+nvtzpplA7pJ4DQ4clSM6jb11QCnmkxDPhjsZq9bzXsn/2gPdO
	 8DFSWyA0v9r6eV83k2D2j1wvgCZX6Xs622nnp48GxtOFCtmNgvj/OeliIL3idOTmE4
	 fKPRZYeqrVJZOOMXcZDsNzJd4pw3LNgWj0eWqR1bvKMLHl/MwduCb7/MNQY4CqGyw1
	 yCgdZQnpX4iqBLir5jr1k1AeEmS4JSMWDKwDXnU4Q+DiutsGtcQRXZRMcdh8Tk/qDg
	 Q95hNLp5JWvhA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7C23B6000C;
	Tue, 14 Oct 2025 17:29:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 9E6062005BE;
	Tue, 14 Oct 2025 17:29:30 +0000 (UTC)
Message-ID: <bbbdd1a0-2835-44c4-8b9f-942d2309e067@fiberby.net>
Date: Tue, 14 Oct 2025 17:29:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] tools: ynl-gen: use uapi mask definition in
 NLA_POLICY_MASK
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
 linux-kernel@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20251013165005.83659-1-ast@fiberby.net>
 <20251013165005.83659-4-ast@fiberby.net> <20251013175956.7a2fcf6d@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251013175956.7a2fcf6d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/25 12:59 AM, Jakub Kicinski wrote:
> On Mon, 13 Oct 2025 16:50:00 +0000 Asbjørn Sloth Tønnesen wrote:
>> Currently when generating policies using NLA_POLICY_MASK(), then
>> we emit a pre-computed decimal mask.
>>
>> When render-max is set, then we can re-use the mask definition,
>> that has been generated in the uapi header.
> 
> This will encourage people to render masks in uAPI which just pollutes
> the uAPI files.

It might, but is that a problem, given that most flag-sets are rather small?

Example from include/uapi/linux/wireguard.h:
 > enum wgpeer_flag {
 >     WGPEER_F_REMOVE_ME = 1U << 0,
 >     WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
 >     WGPEER_F_UPDATE_ONLY = 1U << 2,
 >     __WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
 >                      WGPEER_F_UPDATE_ONLY
 > };

I agree that a private "WGPEER_F_ALL" would be pollution, but "__WGPEER_F_ALL"
is less likely to accidentally be used by user-space.

I get why Jason likes having the __WGPEER_F_ALL in a place where it is easy
to review that it has contains all flags, and why he don't like a policy like
NLA_POLICY_MASK(.., 0x7).

We could do the mask definition in the kernel code, like many handwritten
netlink families does, but we still need to keep NETDEV_XDP_ACT_MASK in
netdev.h or remove it's YNL-GEN header for some time.

