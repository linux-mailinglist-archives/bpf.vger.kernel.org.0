Return-Path: <bpf+bounces-74333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10107C54AAD
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 22:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2033B343904
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B132E6CD0;
	Wed, 12 Nov 2025 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiByVJTn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184462E5B0D;
	Wed, 12 Nov 2025 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984709; cv=none; b=hQdSUyt8AAfuogggaOSIYAQGltWOcNQe6UyDiKcLT/BKmtY77tvs+sjYpu/bhTLsp4gSpdMA81Yh34H0RKDZoiohV1VfMqp5c04MCVlOqh4qJ9sEGlef2D6UvnGHNP77rJSe0CoPy4lP9L4PF1IT7I2pzG46trd4318mNnFyXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984709; c=relaxed/simple;
	bh=DCH5YBw66ErM1uxNNoYc8WJxzsfE8ZpJahysVMrqAkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxqshhjba5mE7PIgnYCLb+02JiBId14tiFS+4oWgkwCj5EW8QPNF4WAVVt5cwtVG0WozBJeDzAMRlAnRxMK9HrM4YGYEYaus/HmpbKVBDZS4y7nwK/fwY6nHQnv6myXO1wXE5LTaAjv+8F7GQjrHlvaqrHVKgUFyjVAr8/G5su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiByVJTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A965AC19423;
	Wed, 12 Nov 2025 21:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762984708;
	bh=DCH5YBw66ErM1uxNNoYc8WJxzsfE8ZpJahysVMrqAkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oiByVJTnWtO3RGPuzsmVE4E2uE/UfTblS478WXOkC0X6nxJ04o4iYt40TAukSmtzM
	 b9LjYsPnXMBkDmACHOOjmm+zPI6GlG8BVFMZ/BbVVkrwXCk0fM+OYtixdNnylkimVG
	 i+/E/UN8DriSWpPQR9nP/eEzoEHPcfm3AmmhuWMzlvK/fJAB6l4bg/wcqXi2tZxha6
	 ydiIQOZf886r2mu/1FfxaVQ4sdGVWWPcML1X3WB+XAgPk16zytV9u170+XMXXONFx/
	 s2lGF8aKLMP7rPymB7B6IYBACriIQPv1lknibV0I139ZO3Y2oxU044TziB1secfV/p
	 rlx8c+ZIzYF8w==
Message-ID: <69451eb5-a36e-4443-8e34-7a06627b087d@kernel.org>
Date: Wed, 12 Nov 2025 22:58:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 1/2] veth: enable dev_watchdog for detecting
 stalled TXQs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
 <176236369293.30034.1875162194564877560.stgit@firesoul>
 <20251106172919.24540443@kernel.org>
 <b9f01e64-f7cc-4f5a-9716-5767b37e2245@kernel.org>
 <20251107175445.58eba452@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251107175445.58eba452@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2025 02.54, Jakub Kicinski wrote:
> On Fri, 7 Nov 2025 14:42:58 +0100 Jesper Dangaard Brouer wrote:
>>> I think this belongs in net-next.. Fail safe is not really a bug fix.
>>> I'm slightly worried we're missing a corner case and will cause
>>> timeouts to get printed for someone's config.
>>
>> This is a recovery fix.  If the race condition fix isn't 100% then this
>> patch will allow veth to recover.  Thus, to me it makes sense to group
>> these two patches together.
>>
>> I'm more worried that we we're missing a corner case that we cannot
>> recover from. Than triggering timeouts to get printed, for a config
>> where NAPI consumer veth_poll() takes more that 5 seconds to run (budget
>> max 64 packets this needs to consume packets at a rate less than 12.8
>> pps). It might be good to get some warnings if the system is operating
>> this slow.
>>
>> Also remember this is not the default config that most people use.
>> The code is only activated if attaching a qdisc to veth, which isn't
>> default. Plus, NAPI mode need to be activated, where in normal NAPI mode
>> the producer and consumer usually runs on the same CPU, which makes it
>> impossible to overflow the ptr_ring.  The veth backpressure is primarily
>> needed when running with threaded-NAPI, where it is natural that
>> producer and consumer runs on different CPUs. In our production setup
>> the consumer is always slower than the producer (as the product inside
>> the namespace have installed too many nftables rules).
> 
> I understand all of this, but IMO the fix is in patch 2.
> This is a resiliency improvement, not a fix.

As maintainer you have the final say, so I send a [V4]. Notice that
doing it this way will cause a merge conflict once net and net-next gets
merged.

[V4] 
https://lore.kernel.org/all/176295319819.307447.6162285688886096284.stgit@firesoul/

--Jesper

