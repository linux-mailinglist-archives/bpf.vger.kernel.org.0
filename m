Return-Path: <bpf+bounces-44997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67459CFAD4
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 00:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E6FB30285
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E19190059;
	Fri, 15 Nov 2024 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3I++ZB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NevTVyC+"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553F187876;
	Fri, 15 Nov 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709770; cv=none; b=E15lMKGC2zslyqN4lvO/66LxMb27LUjvMKo7ImAiHA86kldcxxtLYqg5nTRnQ5sc8zLwH4Rp009bNUKsqwcLHUulfGaxydpBA5+HDZjMe7HewsArk5UkYjq4PFLAjV61kW//pooFj01vE9w8FIPG6akPgghcyne4+ZuJ25pHwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709770; c=relaxed/simple;
	bh=YgvT79iBaGBVWiBS65XCwTu/ttnEG6uZDj9Sw5C75WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eu/9JJ6GV/aYMpUEUHH5lHIEPRUGHPxSA5VwBtOKW0sE2BzaxLar9o5K+pylsqKIlUUHyy1DDrBySBT7PZ4OOAz6rojBtbbpiirPEvh6GasPx9l9JIOpWhRaUUBFFg+Zg+8iKda4CYQWssXsKVbVJHvhfEbDycixSzP50GYlnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3I++ZB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NevTVyC+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731709766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfxggv6ATdS6g6AFs0Huv/ja/7B7Fu4yoi78sTHWDUo=;
	b=U3I++ZB0s6lN0p4TkOIgmA1yjiODb5Y9A1GaqCxFsxFW4mqs2HYhzfWKU++XOQkT92j8XL
	vAxQIX80LscbhZvInxbQXzXb+EfeDTx5/9QQC8G1g6baWWxuSN1OL3s2UTzrGe3T+mWTdo
	NiY4VV03eMMl8TCD3JmW+c6fSwT1CEyHQK3jnDrYd8Qjq0TtdYEDwRqXo8M2SOIIITQBtv
	n13c4P511Bh+Wicdb/TZgBMZjdcvT1fcc16oIAdiKzg4Jn9/tmZ3cgwV/lMdlt5uqA7A4a
	aDuBU9ReSaF8cqBdOdOHQDKQKiQGI5vreZ6pTuJZCDTSOEO7U9VDNc1wditIOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731709766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfxggv6ATdS6g6AFs0Huv/ja/7B7Fu4yoi78sTHWDUo=;
	b=NevTVyC+yzwxBAKjaZgOegdnzziOjLg6+tEWAGDzSXnrWodcqre3bNcInnQ+nHhgzlUOlj
	AT5OXB5dOkQ5caDg==
To: Kunwu Chan <kunwu.chan@linux.dev>, Kunwu Chan <kunwu.chan@linux.dev>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
In-Reply-To: <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <87v7wsmqv4.ffs@tglx> <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
Date: Fri, 15 Nov 2024 23:29:31 +0100
Message-ID: <87sersyvuc.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 14 2024 at 10:43, Kunwu Chan wrote:
> On 2024/11/12 23:08, Thomas Gleixner wrote:
>>> @@ -330,7 +330,7 @@ static long trie_update_elem(struct bpf_map *map,
>>>   	if (key->prefixlen > trie->max_prefixlen)
>>>   		return -EINVAL;
>>>   
>>> -	spin_lock_irqsave(&trie->lock, irq_flags);
>>> +	raw_spin_lock_irqsave(&trie->lock, irq_flags);
>>>   
>>>   	/* Allocate and fill a new node */
>> Making this a raw spinlock moves the problem from the BPF trie code into
>> the memory allocator. On RT the memory allocator cannot be invoked under
>> a raw spinlock.
> I'am newbiee in this field. But actually when i change it to a raw 
> spinlock, the problem syzbot reported dispeared.

Yes, because the actual code path which is going to trigger this, is not
reached. But it will be reached at some point.

IIRC, BPF has it's own allocator which can be used everywhere.

Thanks,

        tglx

