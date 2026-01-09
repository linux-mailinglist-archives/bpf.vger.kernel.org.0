Return-Path: <bpf+bounces-78406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FED0C64F
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE2330486AB
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA933E37C;
	Fri,  9 Jan 2026 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0NhceFr"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61D31B131
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995630; cv=none; b=R2qmH6+siMY+SPWcU2Dt12x3G9OK66xNXKKDrQhOAgzEgrr5WN1p9DlWJvt9FUHQV+Cvu92Gl5GsgGawZdF44Lpb+VuHM5zqcO1jjO0g50G4uz7/l7M5Fw7g35sEgt3MLfpxmdFwLGnuap8cN0RwcVawLWbEYcSz6AMMDxdZOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995630; c=relaxed/simple;
	bh=gkxei1XV+7jup5mq3CbS6/u/Lk1Gm3xGtyjrSAmN83U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2UVCJkB/EC8vCCHtMgESxH0S6koAmkPH3HGh2jQR581DhnKKmLCsGpLY2SKXUvjX5n6WXRkC7yRfHKnc3uE15XsW+ywrAeG+My+6TdIUzSUrMXUVVhEfzuLJeZSHxGDDwoHC/vZg8Yn+a9erTKlvzg4+WhP64CCT2hwbI99YME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0NhceFr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3e041d4-c65a-4c16-99ff-37caceebb54a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767995615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=513Ls91pZJUmzplWGcunk0nQa90ZGydxvckD4eQkbpI=;
	b=K0NhceFr24pkhGGDbk9t7ZAZzu8znxijquW618kMieD3a6l6LM5bExNk1DbCU9wsoEIRX2
	TjFkLr/BQbdLI6ett5AHQRUEs/jw/Sy0m1Hv3J7I3oids0hDHMuZTfvE4x3vpl1YbScJas
	2M03mGMFHehLTqaqvjmgqPXaL8zlkRQ=
Date: Fri, 9 Jan 2026 13:53:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to
 failable
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, kpsingh@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-2-ameryhung@gmail.com>
 <74fa8337-b0cb-42fb-af8a-fdf6877e558d@linux.dev>
 <CAMB2axP5OvZKhHDnW9UD95S+2nTYaR4xLRHdg+oeXtpRJOfKrA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axP5OvZKhHDnW9UD95S+2nTYaR4xLRHdg+oeXtpRJOfKrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 10:39 AM, Amery Hung wrote:
>>> @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>>                goto unlock;
>>>        }
>>>
>>> +     b = select_bucket(smap, selem);
>>> +
>>> +     if (old_sdata) {
>>> +             old_b = select_bucket(smap, SELEM(old_sdata));
>>> +             old_b = old_b == b ? NULL : old_b;
>>> +     }
>>> +
>>> +     raw_spin_lock_irqsave(&b->lock, b_flags);
>>> +
>>> +     if (old_b)
>>> +             raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
>> This will deadlock because of the lock ordering of b and old_b.
>> Replacing it with res_spin_lock in the later patch can detect it and
>> break it more gracefully. imo, we should not introduce a known deadlock
>> logic in the kernel code in the syscall code path and ask the current
>> user to retry the map_update_elem syscall.
>>
>> What happened to the patch in the earlier revision that uses the
>> local_storage (or owner) for select_bucket?
> Thanks for reviewing!
> 
> I decided to revert it because this introduces the dependency of selem
> to local_storage when unlinking. bpf_selem_unlink_lockless() cannot
> assume map or local_storage associated with a selem to be alive. In
> the case where local_storage is already destroyed, we won't be able to
> figure out the bucket if select_bucket() uses local_storage for
> hashing.
> 
> A middle ground is to use local_storage for hashing, but save the
> bucket index in selem so that local_storage pointer won't be needed
> later. WDYT?

I would try not to add another "const"-like value to selem if it does 
not have to. imo, it is quite wasteful considering the number of 
selem(s) that can live in the system. Yes, there is one final 8-byte 
hole in selem, but it still should not be used lightly unless nothing 
else can be shared. The atomic/u16/bool added in this set can be 
discussed later once patch 10 is concluded.

For select_bucket in bpf_selem_unlink_lockless, map_free should know the 
bucket. destroy() should have the local_storage, no?


