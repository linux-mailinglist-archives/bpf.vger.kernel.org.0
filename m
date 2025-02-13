Return-Path: <bpf+bounces-51385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115CA33A35
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A878F3A926D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951A20C461;
	Thu, 13 Feb 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iQAtJYZF"
X-Original-To: bpf@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2B1EF08E;
	Thu, 13 Feb 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436118; cv=none; b=KD0OTn0gOY6FrTfbLR5SFfP/7TGOggCRMopxufC0zDSWJ7J2IMhccn78813PjUoMI7I2st3OaNkWG+vcxOzYPE6z2OzC7F/jC5CRc0F8Mux+uRQiY4wmPvaB/57D37N79TX/pKUOYkosDMu/Ye4sI8h9qsuhuYhLTpTlNY/dre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436118; c=relaxed/simple;
	bh=cy8MBkXlyj3eSMdMUvNtgdXMtyoeY+Pr19oxOv0dbIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9/PDF+DHg6keBm73oLKbwxIsvaW+mjGWZEv/gsEFTvtzoolu4ys7vIf5z0C1AraozCBO3cBbg43ErsXSGh1DJOP9CxJDZTbwMEetjqY5oZM33tXUh/rYILigAeHtugeRLEzzWWL+/AxF/WxGYgE1xylJHvW4mgpD01qe1IY3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iQAtJYZF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fSxeiuquXkp18O4JLaAPVYZlalJiP/8aBnDqJX0M4GA=; b=iQAtJYZFy4ufak0Z7HGdc+1pf7
	zS9jxycw42Sm7wSl0Fb/xfR2puVXxx5w/CRyac+GOYbIb6O8DCWpgi6FIBm64MJRv746pOFK2jJAl
	XdvM98CYYG5SCw73BdEUnLHIee+Ff4a7t9KfF7S/e1G6vW73nWop75mOzUr2McgIhYOCaDIlzTdf/
	rKVcaPQhcV6Z8kt+44wK1XVcggMwbUPYhFttz2valw7a4DZDM2ej8T5JhJtyNx2HUEyUQTfzkr+/v
	m/qn+zJ0WpxDMWiZ6tBEujFhO1mc8hBmtLym2lw2xU/AsZPaBhhypRQMrcNcILRPZyKXizo3geuyg
	4YmU2ASQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tiUmq-008suj-DZ; Thu, 13 Feb 2025 09:41:38 +0100
Message-ID: <1a158ad7-f988-42bf-9a1e-b673ff9122c2@igalia.com>
Date: Thu, 13 Feb 2025 17:41:29 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tj@kernel.org, arighi@nvidia.com,
 kernel-dev@igalia.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250212084851.150169-1-changwoo@igalia.com>
 <CAPhsuW44cRU6rfrpnkdd-+6MRm7fbQ2ucnhtueaD9wBKXYnn8Q@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAPhsuW44cRU6rfrpnkdd-+6MRm7fbQ2ucnhtueaD9wBKXYnn8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Song,

Thank you for the review!

On 25. 2. 13. 03:33, Song Liu wrote:
> On Wed, Feb 12, 2025 at 12:49 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> When there is no entry in the free list (c->free_llist), unit_alloc()
>> fails even when there is available memory in the system, causing allocation
>> failure in various BPF calls -- such as bpf_mem_alloc() and
>> bpf_cpumask_create().
>>
>> Such allocation failure can happen, especially when a BPF program tries many
>> allocations -- more than a delta between high and low watermarks -- in an
>> IRQ-disabled context.
> 
> Can we add a selftests for this scenario?

It would be a bit tricky to create an IRQ-disabled case in a BPF
program. However, I think it will be possible to reproduce the
allocation failure issue when allocating sufficiently enough
small allocations.

> 
>>
>> To address the problem, when there is no free entry, refill one entry on the
>> free list (alloc_bulk) and then retry the allocation procedure on the free
>> list. Note that since some callers of unit_alloc() do not allow to block
>> (e.g., bpf_cpumask_create), allocate the additional free entry in an atomic
>> manner (atomic = true in alloc_bulk).
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   kernel/bpf/memalloc.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
>> index 889374722d0a..22fe9cfb2b56 100644
>> --- a/kernel/bpf/memalloc.c
>> +++ b/kernel/bpf/memalloc.c
>> @@ -784,6 +784,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>>          struct llist_node *llnode = NULL;
>>          unsigned long flags;
>>          int cnt = 0;
>> +       bool retry = false;
> 
> "retry = false;" reads weird to me. Maybe rename it as "retried"?

"retried" reads betters. Will fix it.

> 
>>
>>          /* Disable irqs to prevent the following race for majority of prog types:
>>           * prog_A
>> @@ -795,6 +796,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>>           * Use per-cpu 'active' counter to order free_list access between
>>           * unit_alloc/unit_free/bpf_mem_refill.
>>           */
>> +retry_alloc:
>>          local_irq_save(flags);
>>          if (local_inc_return(&c->active) == 1) {
>>                  llnode = __llist_del_first(&c->free_llist);
>> @@ -815,6 +817,13 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
>>           */
>>          local_irq_restore(flags);
>>
>> +       if (unlikely(!llnode && !retry)) {
>> +               int cpu = smp_processor_id();
>> +               alloc_bulk(c, 1, cpu_to_node(cpu), true);
> cpu_to_node() is not necessary, we can just do
> 
> alloc_bulk(c, 1, NUMA_NO_NODE, true);

Sure, will change it as suggested.

> 
> Also, maybe we can let alloc_bulk return int (0 or -ENOMEM).
> For -ENOMEM, there is no need to goto retry_alloc.
> 
> Does this make sense?

Yup, I will change the alloc_bulk() as it returns 0 or -ENOMEM.

Regards,
Changwoo Min

