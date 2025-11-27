Return-Path: <bpf+bounces-75647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6425C8F4C7
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE3E3A2A00
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581ED337B80;
	Thu, 27 Nov 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwndbZXb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6t5heAL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C72337B8B
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257568; cv=none; b=hNso17Qvnph6Ov7rnyocjsLULWTjZbpBvixz5EZeiyJ2ROwmjjP1xzj6ltmHFfuUCeCsbhc0Urru2WaRpZKnepaKdGGzLwvT//9BDLNOUd3/NOGJknW6HVa5yH1M+zdDkJ7KNrPfZQbTdcKMZuEdtBH/ti6bJjY2qp/JUysCSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257568; c=relaxed/simple;
	bh=xwWpsPu/p2TXGFyfS8pKhNxXZyonEZYzpGiCi7j/KIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8sLb4DycahBc1BZ+KihBgFlbNNtes3lFXVrNreOcpoHAp6Na4JgTZ2r8BhrxT8qOwo902aHiz1+Fw97szUrFuD4urI5qdv2n76T9Du6FdHmYXqzT1Q0HrKaHxDsm3lCyA3IvXt3PFMbSEJuphNdqIrYLCauzhSFlRU0AgHzkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwndbZXb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6t5heAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764257566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+GkUi07d4ou28wY1RAuasUKgt2dm0TVZWT+hGEKfC0=;
	b=AwndbZXbHDSd0E4xOCVT8VIB38cjR6ilC9pZ/QMMeGNVRn2y+5esq3ahKbApLufwCSKw9g
	yPqRG5jC0pJNf6/e3W5u1+5v6nX3A7mpMHOtt1ojZkQmO6EA8SJ58sBVPQBps1nAjM7Cyf
	zlzsE/+Z/Zq9ynJmyL35BrO0mBrgBx0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ToqiDyiEPQ2-K-rcCSUB9A-1; Thu, 27 Nov 2025 10:32:44 -0500
X-MC-Unique: ToqiDyiEPQ2-K-rcCSUB9A-1
X-Mimecast-MFC-AGG-ID: ToqiDyiEPQ2-K-rcCSUB9A_1764257564
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so7664415e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 07:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764257564; x=1764862364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+GkUi07d4ou28wY1RAuasUKgt2dm0TVZWT+hGEKfC0=;
        b=G6t5heALUxLuC5YQBg2RFNoiJZvW0AMdYHBcLdrDA+nzYdRANojH6yLu2mascCQ+VY
         5VnvMk6y/LTq45o1Fpo/fpjt3rahkCDRMdM3ig42ZXMl/0TbkUG+go9IHb1/b8OEspC9
         025f/pfp6SIK5Ctc0v4+FurCrkBCOOZmWc1OGPEglCwvik4eTZ7s5dTi64HBxjoK6pjU
         QMUzE1E7JA+6G0mIsQMIuxazJ7GUVcxBCK+h1YAPwPkmJilta/TNExSOmTfL5p+DSdOu
         uNxxC0XFW+cmEqj8JLqWGQ1AVYFfxBqosyO+QlBayEZpL7OKFjLHKH4Wi0JVNo7G+GPG
         tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257564; x=1764862364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+GkUi07d4ou28wY1RAuasUKgt2dm0TVZWT+hGEKfC0=;
        b=wUL0ybEas70KDmYCzI1yU4GeIjHxa5r0YQOWbO8D0Rx3WRBeABl6xWto1RZFkT4hR3
         MgJ/Cv7WKhrMsoNHZq9uKyx8HvuogIHabnljxLq1FVqa6zFDs1n9J6BfcorT3kuCaTNt
         9QRgYgWK8RTgaWqDpAazS6q0y6Cn+VjXkiOyPbEPbEIQXCU3qHKtpRPOz+f2gwi1XUp1
         XtHaccwWa/PZ4Wa9X1x8NUVNQe3TSDXHbGrFYD6W4XkdBhH1+GYPEs+6ndaQEEpY+gnQ
         4ZGWIp2jUfY9VelAx1jy5Wd7uC201p+AAlGd0lrDzzZ4aCf+J/9Pry9fJJVrNa12/GGP
         2NbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOT1kaNSBuJPJPH0JWW9Zo2txl6Kc4m00fXL0SOvAwW9CRs6kTN3DQmVhMMP3ice8glaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMf2f/uatifx2oUtc4w6MJs4+mGoxwQdeaarbjl6RSQsxIAiA
	xbVhNBhIa59KW+iuMiqd6sTNsC7s/D/PWu7ZcnAM/jto9I43XZTsbT/NANqdiU8UpTHbcZZN9FE
	F4oJvwHizx+xPlbEmiFJEX3VLsNtk/9U2H9Ysc1og8BFUw4EDRAoRUQ==
X-Gm-Gg: ASbGncvtIEbFSZNd4tR8dZPOQ8vRq7Xyy+XkLWvImHwv6AFFqZ1lrpztvaXM8rcKZJ1
	U5YbQ0r6EUR0hHOjfAKRkpgbXOsx6hajAXthBetjdLHo7FyCODCc8hUsMjhwLYEZULZ1MTvbOfB
	5rr1tgZ1+DLLFUsoJqTm5pfeFlFwUKL2ViZCM0prEE8/qOUZ6zxmTjFRkKN57nXcNXYCpZaj8su
	bPhPU1EjilXbAPJE36vd70Soa8GVwzSHJ8E3js2f3CLKSag5AeeEtVLRRFPqPvLY0CTH5+TpiGt
	muVY5d8IAOi4OKN9Xzi5G9dT24qgKESAjJQCG6e4wlKB931j/du7DayVrlIWUy4/f/fV6t96tb7
	6EELnpc02/rjhgQ==
X-Received: by 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-477c01c001bmr287759715e9.24.1764257563613;
        Thu, 27 Nov 2025 07:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgKL4NpJlfgAXWy2V91NL1cZHR73ojsGcmF1eX6oiBCPiBiIVYB93AIsjchnm+PuI1k/NaRQ==
X-Received: by 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-477c01c001bmr287759265e9.24.1764257563187;
        Thu, 27 Nov 2025 07:32:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47903c7360fsm75115715e9.0.2025.11.27.07.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:32:42 -0800 (PST)
Message-ID: <f4ca72ea-e975-431e-9b7a-e32c449248ca@redhat.com>
Date: Thu, 27 Nov 2025 16:32:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-3-kerneljasonxing@gmail.com>
 <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
 <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoCy9vkAmreAvtm2FhgL0bfjZ_kJm2p9JxyaCd1aTSiHew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/27/25 2:55 PM, Jason Xing wrote:
> On Thu, Nov 27, 2025 at 7:35 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/25/25 9:54 AM, Jason Xing wrote:
>>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>>> index 44cc01555c0b..3a023791b273 100644
>>> --- a/net/xdp/xsk_queue.h
>>> +++ b/net/xdp/xsk_queue.h
>>> @@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
>>>       q->cached_prod -= cnt;
>>>  }
>>>
>>> -static inline int xskq_prod_reserve(struct xsk_queue *q)
>>> +static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
>>>  {
>>> -     if (xskq_prod_is_full(q))
>>> +     u32 cached_prod = atomic_read(&q->cached_prod_atomic);
>>> +     u32 free_entries = q->nentries - (cached_prod - q->cached_cons);
>>> +
>>> +     if (free_entries)
>>> +             return true;
>>> +
>>> +     /* Refresh the local tail pointer */
>>> +     q->cached_cons = READ_ONCE(q->ring->consumer);
>>> +     free_entries = q->nentries - (cached_prod - q->cached_cons);
>>> +
>>> +     return free_entries ? true : false;
>>> +}
>> _If_ different CPUs can call xsk_cq_cached_prod_reserve() simultaneously
>> (as the spinlock existence suggests) the above change introduce a race:
>>
>> xsk_cq_cached_prod_nb_free() can return true when num_free == 1  on
>> CPU1, and xsk_cq_cached_prod_reserve increment cached_prod_atomic on
>> CPU2 before CPU1 completed xsk_cq_cached_prod_reserve().
> 
> I think you're right... I will give it more thought tomorrow morning.
> 
> I presume using try_cmpxchg() should work as it can detect if another
> process changes @cached_prod simultaneously. They both work similarly.
> But does it make any difference compared to spin lock? I don't have
> any handy benchmark to stably measure two xsk sharing the same umem,
> probably going to implement one.
> 
> Or like what you suggested in another thread, move that lock to struct
> xsk_queue?

I think moving the lock should be preferable: I think it makes sense
from a maintenance perspective to bundle the lock in the structure it
protects, and I hope it should make the whole patch simpler.

Cheers,

Paolo


