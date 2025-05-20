Return-Path: <bpf+bounces-58567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A55ABDDB8
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791177B68CE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6C2451C8;
	Tue, 20 May 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej/d64sN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6422C325
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752386; cv=none; b=LevKeqq223HBCc4VbFyIzKP610ieq/tnShFEQmZVRGIrUK5Y12tr6SY+mBC3vW1mHwDuMzrd9FpgODqexfx7y9eLdAr7r0u8PoEcK+HwSqf5xdq46+S0uSqg6B1hrwWMl9okR7T/I+OIWaskwJt1P45lJDW9PvZbZbfC7lPt4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752386; c=relaxed/simple;
	bh=vP+p+2XnakeENJ/Zm3ymmsAP/A8Rb6R9vT1DArXbvuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqrqVq2q5aOw1CSmQKR9cNvgvt6dPmFQcYQDuTa9FaFgGbI8lXOC7kY3Gu2NmZyI74ha9E6EAMAwmhscYypQ6l8BUFYpoRVA+bWfq5qm0/3fvbdYDKDInkQxoq4UWBs+aKEsKOpdu3AlYRCcaSEbN8e/UUUPYNKH3REIk5BVNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej/d64sN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad54e5389cdso474862666b.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747752382; x=1748357182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dWJrrqlojSOkRw/l4VR7WIaD+BGjU0xxd1XUG+aV9k=;
        b=ej/d64sNnH36qGxy8t5lCvIaOb5SYT+krojr5KCETh0YZuLMm7pVBROw3GYBtYe3AY
         4pxi1mjnz+YOufgkBC6oqY7usoYFhBY45C+k6wJwfSgR+Sc+/zWQk8vcYB36qAz6NHpP
         gyq0vbQwoXhNOSnCJkaCP/g8y9YxUHg0VppY+F7NUeSD0BgmrMvahorqFvN8yUlwEzIp
         aJrK3VG52eXSOBZ9GaCawqaH8/Vyl3GFX7+dfYeeoME1dbw7oaJE3onHQW8eOJs/uuV1
         zxSk7q95zTBoXdAlBfVF8PTHJja1dTu3raVzszlRXlYMjsi7dAsPXzpANYGU3xwAhzcZ
         lYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752382; x=1748357182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dWJrrqlojSOkRw/l4VR7WIaD+BGjU0xxd1XUG+aV9k=;
        b=TfdLoNu/v4eSvXMLeOgraqmmLCcdFkqqe5Fsmi5WAJWrkJkLcxlNOuEsXKnP7W+S21
         utIDtVsm7PlpTigDhFNXULLAmpbViuPYMM1w/uaboClLlJHpHqkwTTrPA9//2GmqpX7B
         p+YfxOhN98cux+r7GKb40k3iAWFR0KBOkS9ez77Hx1DuBUqDbJOAHW+pqUxpSTdHsbbt
         DY7cQGJ3bRgCIPNpjwBQSMx4O5F9HfMw7F6c2rXWO9G+i/fXaa+Xjik5EkghtKbNQEfg
         gTD5/rQsVrOu0wbT+w41I6qykOhG9T/3oqcyz8gIjyKIj5WuBNQ9vIdgt3ItXS7eNxk+
         U2MA==
X-Forwarded-Encrypted: i=1; AJvYcCU0NhKJf6C5B5dWLIJg9mFZnXRDWL4UHdUzdEiX1pq2q3Mp2nq5T39I4Ao7ud4HaYWqRRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73TWmAgpzkNyH+uHs2RwYHqy9m8c0MefDnvF+kvDABN2cimuy
	WudQK2dkFK6qDS0ZsupMr/r3xC7bSr+1eMbLvwyCE87c0hoLPKgb4K2x
X-Gm-Gg: ASbGnct5II08jE7huW/uYThF2mEpiiHmpSRQqSacPCdCdsbCiL8PxU/ZcAnriI6vaxp
	IbgbU4oO971077hsqhu7p/Pml6yeZ5a/eNWyn6bpm//GHGPz1OQzgk2b2kYUoq50o3geXHB0BHh
	y3A6ApDq8gEkVMPCyq+PvUphj/NAeNIVnWuAhMiPpZnL9AvpBadRqwSF08csIQM+zzpKQRQm2wo
	pt1MxhPk+AUAo88MDhCO4ff+DsI9dqNKH8L0gs4bo7+vgsjohSVbgCnIRl4qf5KHtsBw124NPat
	W+fixv9pZPJxZVQY6Ljla7+hQkSWnNU3vTPoIfnnMZtWRMjdHDkX5qve6k/7ELX+KLUG4o58gBW
	Wwy7DpbS2zLVVO/cbS0o+Ucyt
X-Google-Smtp-Source: AGHT+IEqkOJNoilUVgingHglwr91JrYy8YeFcEi/+1/1hWhNcxirT8La5zrk2H4NYsAlOSPX631XIg==
X-Received: by 2002:a17:907:39c:b0:ad5:3ce3:6efb with SMTP id a640c23a62f3a-ad53ce3e815mr1208518066b.25.1747752382228;
        Tue, 20 May 2025 07:46:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1c0a:f3ac:4087:51c8? ([2620:10d:c092:500::7:66a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4967c9sm738675966b.129.2025.05.20.07.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 07:46:21 -0700 (PDT)
Message-ID: <7f3974b0-d201-453d-846e-563547cf3fdc@gmail.com>
Date: Tue, 20 May 2025 15:46:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Nico Pache <npache@redhat.com>, akpm@linux-foundation.org, david@redhat.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
 <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
 <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/05/2025 15:35, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 03:32:16PM +0100, Usama Arif wrote:
>>
>>
>> On 20/05/2025 15:22, Lorenzo Stoakes wrote:
>>> On Tue, May 20, 2025 at 10:08:03PM +0800, Yafang Shao wrote:
>>>> On Tue, May 20, 2025 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
>>>>>> The challenge we face is that our system administration team doesn't
>>>>>> permit enabling THP globally in production by setting it to "madvise"
>>>>>> or "always". As a result, we can only experiment with your feature on
>>>>>> our test servers at this stage.
>>>>>
>>>>> That's a you problem.
>>>>
>>>> perhaps.
>>>>
>>>>> You need to figure out how to influence your
>>>>> sysadmin team to change their mind; whether it's by talking to their
>>>>> superiors or persuading them directly.
>>>>
>>>> I believe that "practicing" matters more than "talking" or "persuading".
>>>> I’m surprised your suggestion relies on "talking" ;-)
>>>> If I understand correctly, we all agree that "talk is cheap", right?
>>>>
>>>>> It's not a justification for why
>>>>> upstream should take this patch.
>>>>
>>>> I believe Johannes has clearly explained the challenges the community
>>>> is currently facing [0].
>>>>
>>>> [0]. https://lore.kernel.org/linux-mm/20250430174521.GC2020@cmpxchg.org/
>>>
>>> (Sorry to interject on your conversation, but :)
>>>
>>> I don't think anybody denies we have issues in configuring this stuff
>>> sensibly. A global-only control isn't going to cut it in the real world it
>>> seems.
>>>
>>> To me as you say yourself, definining the ABI/API here is what really matters,
>>> and we're right now inundated with several series all at once (you wait for one
>>> bus then 3 come at once... :).
>>>
>>> So this I think, should be the question.
>>>
>>> I like the idea of just exposing something like madvise(), which is something
>>> we're going to maintain indefinitely.
>>>
>>> Though any such exposure would in my view would need to be opt-in i.e. have a
>>> list of MADV_... options that are accepted, as we'd need to very cautiously
>>> determine which are safe from this context.
>>>
>>> Of course then this leads to the whole thing (and I really know very little
>>> about BPF internals - obviously happy to understand more) of whether we can just
>>> use the madvise() code direct or what locking we can do or how all that works.
>>>
>>> At any rate, a custom thing that is specific as 'switch mode for mTHP pages of
>>> size X to Y' is just something I'd rather us not tie ourselves to.
>>>
>>>>
>>>>
>>>> --
>>>> Regards
>>>>
>>>> Yafang
>>>
>>> What do you think re: bpf vs. something like my proposed process_madvise()
>>> extensions or Usama's proposed prctl()?
>>>
>>> Simpler, but really just using madvise functionality and having a means of
>>> defaulting across fork/exec (notwithstanding Jann's concerns in this area).
>>
>> Unfortunately I think the issue is that neither prctl or process_madvise would work
>> for Yafangs usecase? Its usecase 3 mentioned in [1], i.e.
>> global system policy=never, process wants "madvise" policy for itself.
>> Will let Yafang confirm.
>>
>> [1] https://lore.kernel.org/all/13b68fa0-8755-43d8-8504-d181c2d46134@gmail.com/
>>
> 
> Yeah I really object to that case. I explicitly said on your series I
> object to it, I believe David did too.

Yes, I am not for it as well, which is why my series never tried to do it :)
As I mentioned in my series several times (unfortunately too many to count)
hugepage_global_enabled always evaluated to false when THP is never.

> 
> Never should mean never.
> 
> It's a NACK if that's what this is about unless I'm missing something here.
> 
> I agree global settings are not fine-grained enough, but 'sys admins refuse
> to do X so we want to ignore what they do' is... really not right at all.


