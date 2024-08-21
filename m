Return-Path: <bpf+bounces-37699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7A959AFE
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5F0B24804
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F31B3B33;
	Wed, 21 Aug 2024 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZmVm91D1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B72199FA5;
	Wed, 21 Aug 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240682; cv=none; b=tSUnGPRxh/NdcIEB0vSRn5GsIrTFjXZiwRPq81UKUo5Gd6g7I3vuIU9BmVCUIySY8NJHYypw4tOSgqsyhJTDgMGAiFsqUADAPIBfiVrW+PjRcWHX4DRwgkjGh4MeMkMUQiW8Qp3u5+u0rYkWzy8Quotbog6CbMbIA9tXBVDAIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240682; c=relaxed/simple;
	bh=ML42OdiINuuJ5vMS4VacMsbUkosKHy8A4IQhFyKN6zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiY1AuxRzNyFuFKuRHwSYzFU+aBKoZHJ6PQFEvQio/CXhwBRWv824iXLBbbDEfQW9PdxaQFAf33F8KN2qxqVZjyIQ8d1/9QSd0dk+4ESeJ1nWeD/EJu6Dw28Li2Y7pA9c+rqBqadxPscGSCTw07TiT5PapaOLAZXFI3T12iO1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZmVm91D1; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724240669; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+R5xOCFE8oBczmIJyK4y5RJEco64ATuR56HQDIbBO20=;
	b=ZmVm91D1yNPdPcKONlx7zv539vM02ysCVzxu3CaK2dSF+xXVHnblKm3JGGb+iiSv67HU+gJIJP0lyBQObYCTu4La9XdtKRzawkdFONCSScqdre393e0Bk473Gpwqqe9wfKPLIBkUoLp79qIiNJC2NJCmrqQrJ3nwioX9RkF/arY=
Received: from 30.221.128.127(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WDLhbjs_1724240667)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 19:44:28 +0800
Message-ID: <2fd14650-2294-4285-b3a5-88b443367a79@linux.alibaba.com>
Date: Wed, 21 Aug 2024 19:44:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: Move BPF_SK_LOOKUP ahead of connected UDP sk lookup?
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team <kernel-team@cloudflare.com>
References: <6e239bb7-b7f9-4a40-bd1d-a522d4b9529c@linux.alibaba.com>
 <87bk1mdybf.fsf@cloudflare.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <87bk1mdybf.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jakub,

On 2024/8/21 17:23, Jakub Sitnicki wrote:
> Hi Philo,
> 
> [CC Eric and Paolo who have more context than me here.]
> 
> On Tue, Aug 20, 2024 at 08:31 PM +08, Philo Lu wrote:
>> Hi all, I wonder if it is feasible to move BPF_SK_LOOKUP ahead of connected UDP
>> sk lookup?
>>
...
>>
>> So is there any other problem on it？Or I'll try to work on it and commit
>> patches later.
>>
>> [0]https://lore.kernel.org/bpf/20190618130050.8344-1-jakub@cloudflare.com/
>>
>> Thank you for your time.
> 
> It was done like that to maintain the connected UDP socket guarantees.
> Similarly to the established TCP sockets. The contract is that if you
> are bound to a 4-tuple, you will receive the packets destined to it.
> 

Thanks for your explaination. IIUC, bpf_sk_lookup was designed to skip 
connected socket lookup (established for TCP and connected for UDP), so 
it is not supposed to run before connected UDP lookup.
(though it seems so close to solve our problem...)

> It sounds like you are looking for an efficient way to lookup a
> connected UDP socket. We would be interested in that as well. We use> connected UDP/QUIC on egress where we don't expect the peer to roam and
> change its address. There's a memory cost on the kernel side to using
> them, but they make it easier to structure your application, because you
> can have roughly the same design for TCP and UDP transport.
> 
Yes, we have exactly the same problem.

> So what if instead of doing it in BPF, we make it better for everyone
> and introduce a hash table keyed by 4-tuple for connected sockets in the
> udp stack itself (counterpart of ehash in tcp)?

This solution is also ok to me. But I'm not sure are there previous 
attempts or technical problems on it?

In fact, I have done a simple test with 4-tuple UDP lookup, and it does 
make a difference:
(kernel-5.10, 1000 connected UDP socket on server, use sockperf to send 
msg to one of them, and take average for 5s)

Without 4-tuple lookup:

%Cpu0: 0.0 us, 0.0 sy, 0.0 ni,  0.0 id, 0.0 wa, 0.0 hi, 100.0 si, 0.0 st
%Cpu1: 0.2 us, 0.2 sy, 0.0 ni, 99.4 id, 0.0 wa, 0.2 hi,   0.0 si, 0.0 st
MiB Mem :7625.1 total,   6761.5 free,    210.2 used,    653.4 buff/cache
MiB Swap:   0.0 total,      0.0 free,      0.0 used.   7176.2 avail Mem

---
With 4-tuple lookup:

%Cpu0: 0.2 us, 0.4 sy, 0.0 ni, 48.1 id, 0.0 wa, 1.2 hi, 50.1 si,  0.0 st
%Cpu1: 0.6 us, 0.4 sy, 0.0 ni, 98.8 id, 0.0 wa, 0.2 hi,  0.0 si,  0.0 st
MiB Mem :7625.1 total,   6759.9 free,    211.9 used,    653.3 buff/cache
MiB Swap:   0.0 total,      0.0 free,      0.0 used.   7174.6 avail Mem

> 
> Thanks,
> (the other) Jakub

Thanks.
-- 
Philo


