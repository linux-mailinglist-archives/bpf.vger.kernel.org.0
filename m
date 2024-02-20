Return-Path: <bpf+bounces-22290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7656285B58C
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07408B22D0E
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA45CDF7;
	Tue, 20 Feb 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bqOT/xcQ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F52E3E8;
	Tue, 20 Feb 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418403; cv=none; b=TPJATRVrxnUBycp78yDV1cyNYIE/CoSvUec3vHD/VHLMuAKX3vSK4tEEt1b5fnfpBT1ZzMJSjJKW/xCgRMHNBzdcCqBRwL9WLsVEr7RPBp1x+c/i+sy18wAE97Qq8VkO07Hs2mnS2xBYK//C74yeB0FYguD0anU3IPkEZ4C2pzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418403; c=relaxed/simple;
	bh=i2VLmiDs1HDaUbO7Q8ttxsa2e646Y7vLygvMNHBlik0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Cq6ukRTI64I+sEWyy5mPwVeuD/IxA5HCVGNCcXpX4NBCILkvqCYbTWDWAnJ+8WHgRqnr6guASb8KiTpaAzJEN8SNMsfsEIHXGgDY1hu7DR6TfI2LVTsEzGQiF6sJmWTmygES1T5s14W7Rd4UhRSjwjftDWKASMbRicIc2lKKNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bqOT/xcQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xGUrxgHVXxNC3GiUUaEHTNUllWnhZ7+xy6iEdGOWVl4=; b=bqOT/xcQY7jTWUTHDliC0AJ5Vf
	1KDsQGPw1ARCEpQXGHaM58TzSHRznwANmOgoiLZnQfCZeERbM9NJYBZcK8K8g5yFXyayreiX9a//N
	HAstKpFctUthI1Q7Pl1vCClwp2j81cyZpf7cNP0D3gSJAL3nuhJoTGd5evR2sF7XOBCuxV4NMr86X
	2jlOyUF+CNVD1udm8689/pqG7VpJCD76A5yTqGFpSo1I8zhrEzVM6VvY40Tefv02eKtulMS8gq5zK
	9/lgvH5/VK28y/2qvuRD0thHxvY/Xi9OxfWmW4FfWZCMkjd0wOa4H4OJyXvF+fUD13M0Ta7hLu+q3
	8e/vA6vA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcLfI-000IZ5-Fb; Tue, 20 Feb 2024 09:39:48 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcLfH-00043q-34;
	Tue, 20 Feb 2024 09:39:47 +0100
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page pool
 for live XDP frames
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240215132634.474055-1-toke@redhat.com> <87wmr0b82y.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
Date: Tue, 20 Feb 2024 09:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmr0b82y.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27190/Mon Feb 19 10:24:27 2024)

On 2/19/24 7:52 PM, Toke Høiland-Jørgensen wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> 
>> Now that we have a system-wide page pool, we can use that for the live
>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>> avoid the cost of creating a separate page pool instance for each
>> syscall invocation. See the individual patches for more details.
>>
>> Toke Høiland-Jørgensen (3):
>>    net: Register system page pool as an XDP memory model
>>    bpf: test_run: Use system page pool for XDP live frame mode
>>    bpf: test_run: Fix cacheline alignment of live XDP frame data
>>      structures
>>
>>   include/linux/netdevice.h |   1 +
>>   net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>>   net/core/dev.c            |  13 +++-
>>   3 files changed, 81 insertions(+), 71 deletions(-)
> 
> Hi maintainers
> 
> This series is targeting net-next, but it's listed as delegate:bpf in
> patchwork[0]; is that a mistake? Do I need to do anything more to nudge it
> along?

I moved it over to netdev, it would be good next time if there are dependencies
which are in net-next but not yet bpf-next to clearly state them given from this
series the majority touches the bpf test infra code.

> -Toke
> 
> [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=826384

