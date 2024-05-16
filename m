Return-Path: <bpf+bounces-29854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8BE8C7839
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081F71F22358
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD151487F2;
	Thu, 16 May 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FegbiGWu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA5147C75
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868302; cv=none; b=VFcyQjgL9jtLL/aitr3ZU8U17JybC3SdIjjhAHXalzFvGaAxi4MGmAXC8ezqeBGDfdj4ayEbIx8YUofLc0ohZpHWbgP34YcbBS7E976ZXamisOHZi4y8t2TUFM61awQt1rfgEfb+uTAl0oAnxrkf+xrlHHard3MaR85ufFUiT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868302; c=relaxed/simple;
	bh=ucjtenbGd4P87rgZD1MVoSD9AG1jRL0FrENsyI3SexU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm3b9nKaV20hASsxjm/qi6PQ1ncfLC6zhx4Afl7To/FCL3il7Ix3ovx9qTAKnspyxHeQEeSAKEIzo+H0lQdpuMUPvF5TriGbg7NSEC1SB7B395y9eE91vjwkcLxshP6mZ4YjZBEkS52evI4KMrQz1DIUtC/4JXIw8VBNNE6bsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FegbiGWu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43df44ef2f9so53577961cf.1
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715868300; x=1716473100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t+dduDLD9wRCCW7w7MdGaZT+JBiZSs25Nx3zdolrNIE=;
        b=FegbiGWuI8Kl/AF6rE4+Zve5zLV5qkNt749GLOkpALufYf/aupBWNOOJ3dylsInNqG
         VtxdXPQ8HHWSwJ1A8yaKvCX/qi6rl+rgEWE0GsoyxgG2WsqZ/0qfa9g0SK1II8K3gtSj
         d3mPOzuqlVEl10P6zYOzoFCsx6TEilKD+lgSGy0ttZ9rcxDKS7Z8I60sk6c5F87irsgs
         4eRq1wRx6mrYPmXGTMx9Ux8vmE30LZur6WpOPSLNe9BSWoj9aqN7RG1Ta3PPu238j1Xa
         vCbM/P4jCBxBzoiQpJdqlytp3aDE34B7Xfp+hG2UFGKP3Luh+zmGXrcuqZrKid6GaxEH
         mlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868300; x=1716473100;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+dduDLD9wRCCW7w7MdGaZT+JBiZSs25Nx3zdolrNIE=;
        b=JHCBED4JyiaAF/F68kuU10lsXpyL8qd2nsTy1rn4xBwJzkbn1SHfzszry60yuOXAqZ
         aboFiio/wXZ5LtrW5kyJnpKBvgm54kQ0i+6qUUqiHKqRcJ9HJcIsR28Ise/tUY3W5b4a
         pau8o0e2O45GSvamjcIa8Q7X8eHGqZVv+fjEy9HhtIhu1tbTdrlJqcexumgXn1oN7kny
         UAmcD4beNZ8INUiCyjb7ehYAkBl+Lg0DMRspHQlVmIDtiYot35EgFk/oLoPQm37NWJ+c
         R7bkdZktHbnIhxI6tybg3HALtxAQCIfmFCev13MupDovfiT02OR7C/xB/UD3wiLxnVYd
         A4EQ==
X-Gm-Message-State: AOJu0YxWF311wUumUZN1K0S9CUxHKUOJgzrUSFXawldajktLAekTPNUj
	PUhWzapKtwszyXa3f84RPDsdVCGku+rVgMH/Tim77lYKaAhvOfpYuEWCUxAjhw==
X-Google-Smtp-Source: AGHT+IHAqlVqFjbtfq2Ya77nVuUrJuohiJngmcO+SvCMLU4Kc4CqF4lH/ER+meaVGZOiXXuyvsRVLA==
X-Received: by 2002:ac8:5889:0:b0:43c:7598:676 with SMTP id d75a77b69052e-43dfdb7ee36mr251282131cf.38.1715868299585;
        Thu, 16 May 2024 07:04:59 -0700 (PDT)
Received: from [192.168.1.8] (c-73-238-17-243.hsd1.ma.comcast.net. [73.238.17.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e3a6827fesm14767351cf.52.2024.05.16.07.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 07:04:59 -0700 (PDT)
Message-ID: <55b6e3cc-3809-448e-9603-951dc0693c0c@google.com>
Date: Thu, 16 May 2024 10:04:57 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and
 stack maps
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net,
 olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev,
 rjsu26@vt.edu, sairoop@vt.edu, miloc@vt.edu, memxor@gmail.com,
 syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <20240514124052.1240266-2-sidchintamaneni@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <20240514124052.1240266-2-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/24 08:40, Siddharth Chintamaneni wrote:
[...]
> +static inline int map_lock_inc(struct bpf_queue_stack *qs)
> +{
> +	unsigned long flags;
> +
> +	preempt_disable();
> +	local_irq_save(flags);
> +	if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> +		__this_cpu_dec(*(qs->map_locked));
> +		local_irq_restore(flags);
> +		preempt_enable();
> +		return -EBUSY;
> +	}
> +
> +	local_irq_restore(flags);
> +	preempt_enable();

it looks like you're taking the approach from kernel/bpf/hashtab.c to 
use a per-cpu lock before grabbing the real lock.  but in the success 
case here (where you incremented the percpu counter), you're enabling 
irqs and preemption.

what happens if you get preempted right after this?  you've left the 
per-cpu bit set, but then you run on another cpu.

possible alternative: instead of splitting the overall lock into "grab 
percpu lock, then grab real lock", have a single function for both, 
similar to htab_lock_bucket().  and keep irqs and preemption off from 
the moment you start attempting the overall lock until you completely 
unlock.

barret


> +
> +	return 0;
> +}
> +
> +static inline void map_unlock_dec(struct bpf_queue_stack *qs)
> +{
> +	unsigned long flags;
> +
> +	preempt_disable();
> +	local_irq_save(flags);
> +	__this_cpu_dec(*(qs->map_locked));
> +	local_irq_restore(flags);
> +	preempt_enable();
> +}
> +
>   static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>   {
>   	struct bpf_queue_stack *qs = bpf_queue_stack(map);
>   	unsigned long flags;
>   	int err = 0;
>   	void *ptr;
> +	int ret;
> +
> +	ret = map_lock_inc(qs);
> +	if (ret)
> +		return ret;
>   
>   	if (in_nmi()) {
> -		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
> +		if (!raw_spin_trylock_irqsave(&qs->lock, flags)) {
> +			map_unlock_dec(qs);
>   			return -EBUSY;
> +		}
>   	} else {
>   		raw_spin_lock_irqsave(&qs->lock, flags);
>   	}
> @@ -121,6 +170,8 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
>   
>   out:
>   	raw_spin_unlock_irqrestore(&qs->lock, flags);
> +	map_unlock_dec(qs);
> +
>   	return err;
>   }
>   
> @@ -132,10 +183,17 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
>   	int err = 0;
>   	void *ptr;
>   	u32 index;
> +	int ret;
> +
> +	ret = map_lock_inc(qs);
> +	if (ret)
> +		return ret;
>   
>   	if (in_nmi()) {
> -		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
> +		if (!raw_spin_trylock_irqsave(&qs->lock, flags)) {
> +			map_unlock_dec(qs);
>   			return -EBUSY;
> +		}
>   	} else {
>   		raw_spin_lock_irqsave(&qs->lock, flags);
>   	}
> @@ -158,6 +216,8 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
>   
>   out:
>   	raw_spin_unlock_irqrestore(&qs->lock, flags);
> +	map_unlock_dec(qs);
> +
>   	return err;
>   }
>   
> @@ -193,6 +253,7 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
>   	unsigned long irq_flags;
>   	int err = 0;
>   	void *dst;
> +	int ret;
>   
>   	/* BPF_EXIST is used to force making room for a new element in case the
>   	 * map is full
> @@ -203,9 +264,16 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
>   	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
>   		return -EINVAL;
>   
> +
> +	ret = map_lock_inc(qs);
> +	if (ret)
> +		return ret;
> +
>   	if (in_nmi()) {
> -		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
> +		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags)) {
> +			map_unlock_dec(qs);
>   			return -EBUSY;
> +		}
>   	} else {
>   		raw_spin_lock_irqsave(&qs->lock, irq_flags);
>   	}
> @@ -228,6 +296,8 @@ static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
>   
>   out:
>   	raw_spin_unlock_irqrestore(&qs->lock, irq_flags);
> +	map_unlock_dec(qs);
> +
>   	return err;
>   }
>   


