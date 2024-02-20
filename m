Return-Path: <bpf+bounces-22318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073985BCD3
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 14:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366FB1F22423
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C8869E1F;
	Tue, 20 Feb 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="J+9j8m+L"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35156692E9;
	Tue, 20 Feb 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434279; cv=none; b=kRsBTNf+dm8xeCnKSaO+p05VBSLNQ7CIZMqymIA5F9pIYmeoHCafW8OOTPNWvGZHEoPSsqK9kMqv0t+YKr1oAP8ktk2ax+eQFV92KtTCJedxQ+16f/2J5wgzYuLDuzH3wdmEddXTd4FBg6ri52D4oMETNJ3oiiy1BmNRrIGyUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434279; c=relaxed/simple;
	bh=qw68cbvWVCDaSiCaFt0mqKtZsY5Hg/JPm2WM1pvSFcQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VOqne1tSn3QKqNUjtc8rvNBBZgXKhprtqdEngelHHYlVh71MMXcsKQjRTkkSAccESjK1/aNzwzI/YfP4IC/JR63cnu3Sn+qkKXMmTljWAhwtnsIw94XV8a3uALNFmUto8AFZsTON0pQPqxMmePbxHKnKYq5wlfmu8DqjB8UJv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=J+9j8m+L; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dXPxbG3jp1RJ38PIYIcqm3sOHazDTTUmnZEfZczc+no=; b=J+9j8m+LB244AtFelsGKWdhTNN
	9L8bbYJv5f63E2hZ7/ucVvO0sEY8v0If6gLAhbBhkGZkrOk+k6vB8HhSDsCSw4/HM35vUw6GsiW5M
	4vvb5Nfu1Bw0rl3r3S2JQ8ARdg+AvW4YVY7QDXIrchoo2sZUgAxoWRXLRGQ4WlqQL2PwVIcw/0Tgs
	Q0WWNNGdh1V1iqSZv/dFDAk+EE4Pdps4KPa9ixVY0tNMCB7nEf2B1E+IrThu1AGUHqszV5+AYck2J
	ERZbMFphlC5m6zbv84D80ZcdySqgo8hFtprKA4AjFZqDx7IKMvAbLxp4CDxns/mnPgtst2+ZP2xHe
	iITyA5xg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcPLa-000Lm0-3s; Tue, 20 Feb 2024 13:35:42 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcPLZ-000QAW-J4; Tue, 20 Feb 2024 13:35:41 +0100
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page pool
 for live XDP frames
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240215132634.474055-1-toke@redhat.com> <87wmr0b82y.fsf@toke.dk>
 <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net> <87o7cbbcqj.fsf@toke.dk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c888b60a-0be5-8e7c-0fa0-8039e691406a@iogearbox.net>
Date: Tue, 20 Feb 2024 13:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o7cbbcqj.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27191/Tue Feb 20 10:25:13 2024)

On 2/20/24 12:23 PM, Toke Høiland-Jørgensen wrote:
> Daniel Borkmann <daniel@iogearbox.net> writes:
>> On 2/19/24 7:52 PM, Toke Høiland-Jørgensen wrote:
>>> Toke Høiland-Jørgensen <toke@redhat.com> writes:
>>>
>>>> Now that we have a system-wide page pool, we can use that for the live
>>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>>> avoid the cost of creating a separate page pool instance for each
>>>> syscall invocation. See the individual patches for more details.
>>>>
>>>> Toke Høiland-Jørgensen (3):
>>>>     net: Register system page pool as an XDP memory model
>>>>     bpf: test_run: Use system page pool for XDP live frame mode
>>>>     bpf: test_run: Fix cacheline alignment of live XDP frame data
>>>>       structures
>>>>
>>>>    include/linux/netdevice.h |   1 +
>>>>    net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>>>>    net/core/dev.c            |  13 +++-
>>>>    3 files changed, 81 insertions(+), 71 deletions(-)
>>>
>>> Hi maintainers
>>>
>>> This series is targeting net-next, but it's listed as delegate:bpf in
>>> patchwork[0]; is that a mistake? Do I need to do anything more to nudge it
>>> along?
>>
>> I moved it over to netdev, it would be good next time if there are dependencies
>> which are in net-next but not yet bpf-next to clearly state them given from this
>> series the majority touches the bpf test infra code.
> 
> Right, I thought that was what I was doing by targeting them at net-next
> (in the subject). What's the proper way to do this, then, just noting it
> in the cover letter? :)

An explicit lore link to the series this depends on would be best.

Thanks,
Daniel

