Return-Path: <bpf+bounces-58564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5BABDD2A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6574C7A4305
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394B24290D;
	Tue, 20 May 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJMS/cAZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216519F464
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751541; cv=none; b=Oa1q7IxTA/pfkJ/zNDTE0iBhhigT7X/qoVTAsOm8xM8S92nG0iZiLAm0GWCSphjQMpN56mQRvdoGrArA7HUIae+VSf1EOagBbrFTgbjKmHA2cJsVv5qlhkqDEmLW4vRsoH54zs2L7AoYJSlBfZYK5jKT7mIvOVtaQ+XaRClOtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751541; c=relaxed/simple;
	bh=ru2j3L7G+1XxMoZ+feaegwSPaJoqHfxMmjOBLIahtGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=do8F+hn6FP4DNv4fUNuE/gzKyP8hbHhesNS15iLayQm5Ji9174Mp4lLWvZghlRhPUz9L7l5fdY1ataSv4fmAczaPRc/xQO+A1gIwHBFPYMD7gUrl2y/DiwOt51Q9uJ4UVannIyHrrEfGn34C1N0g/Uz+1yRk2RhDXus8I406WF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJMS/cAZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so6604995a12.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751538; x=1748356338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lh4Pm0sp8IajUI4dOEci5cZ7CVnfMTUBQkzonbEseWs=;
        b=eJMS/cAZIY04MM+aHsLKE7HnZ8Z1mVLy/gfdeqt2vAhd1iOg0eJ3yoJBgJQ1IXDIiX
         pf/8DJO+2/b+pYkgt66y9kivv7s9dpemAi36kkpqZc7d5KdZdvPuiWgAoZ88pgkKqZ+d
         dPEM1hhcRXrl084JE/BWZrfSHkFrvA4M7fVW3O9Os+wODfJjVuK8C+dXm0PWpzjy1Bmc
         FJm2s6JBIyNG9qgqd360vpc0NK2kFaezzPzWpfgI1TvMFuQZYs4Lsr5P8DAV9XJieaJE
         JU65oOHx5fnrDpXKKC1O/RuzWbSwbgmDs+KdJtHMx1FlDkdsGNc+RZ7Kyk0wEOsIE8FH
         rm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751538; x=1748356338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh4Pm0sp8IajUI4dOEci5cZ7CVnfMTUBQkzonbEseWs=;
        b=CQSNXmU3RE0YjPmzVJgGzg7s5KRsR8yBxcLMKFg1mPQ2JhGojT2LY/WhvgbkfvyZQN
         /R/7e7QQ8x1G/CMdngpaLEJn4lxNXdkS/zziy4vXcWcya84kggm5adddxh9KISL6ULD8
         nnmqb+tARy6GhOEdGgesldcSXEKbLi3lz3B2cbPo1ClbUa+smMAU9c1j7PzYuw2vHEfc
         RqioK/uKgTbj7CAvF1invLJIxKfUnV+fMk3pWgDbCJwhHxv1bmhWSG3VYRJURftPrJBc
         7w+U+eDcZvL1J8y5xPCa19GPG9S2xJoQZS0e6AiNRvuFKN6GzYw/rwzkPzpq8E39U6tm
         mYSg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ysY91gGkSh7smjnwTKckRw6kiaC09OtYZij+hHm7YPP1vd4ShMkLz56E5k7jUt9zJB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0L4gnbuKEYMODfTdjBEKDK4YZWSt6wtX6hH6dagLn5jzkyB3S
	Zpv6CiXjO7Gsc1jgCODVpqf9FI1AZh87r2VvqCa0LNeShmBgpTpVe+Sh
X-Gm-Gg: ASbGncvvEmX0MBZDgIEEh4xZ6eMMPaGF/EGUa2DOPNT+JrLgw1xlCVzWdI22f3wwhYF
	gk+EHwwuiioAIORzMfbsoaBJE/WjuW4mqdSpjfnhj+DirtNhYHF/W0LMR7rWZxheqjpf7l5HMV4
	7wwOG8p9wfJovHNw+6vRTEw44rQBcK92Py2S3TjfLh67H9HS5VlVNX1/f17zwkpLc5rluEecdQx
	WBs85ASzFW3j22OWx8sW1TK3TOM8hxNkP9xssbNoibIsXztKTc+Io/91V5CQwSwrk6oEwV1HwVE
	wEiCe1gwVpkSlW0wkhvE8FU8Edbf+21BNCe1NfAUpA7eaSbx4bXh4rjj7kbCQnnZY6e5mbCHDbQ
	Gm9rq/JJo1arinahZdfkxrbTT
X-Google-Smtp-Source: AGHT+IGfufzI3ipSzXSZFxZNhnZTBDsEoGZVdRNO8UaZUfj3D2VJARvPViUibgD0CIz8pQtzSjB0Tw==
X-Received: by 2002:a17:907:7d89:b0:ad5:2378:dd66 with SMTP id a640c23a62f3a-ad52d5757cfmr1610059966b.39.1747751537652;
        Tue, 20 May 2025 07:32:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1c0a:f3ac:4087:51c8? ([2620:10d:c092:500::7:66a9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60203c21233sm1497986a12.71.2025.05.20.07.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 07:32:17 -0700 (PDT)
Message-ID: <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
Date: Tue, 20 May 2025 15:32:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yafang Shao <laoar.shao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Nico Pache <npache@redhat.com>,
 akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/05/2025 15:22, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 10:08:03PM +0800, Yafang Shao wrote:
>> On Tue, May 20, 2025 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
>>>> The challenge we face is that our system administration team doesn't
>>>> permit enabling THP globally in production by setting it to "madvise"
>>>> or "always". As a result, we can only experiment with your feature on
>>>> our test servers at this stage.
>>>
>>> That's a you problem.
>>
>> perhaps.
>>
>>> You need to figure out how to influence your
>>> sysadmin team to change their mind; whether it's by talking to their
>>> superiors or persuading them directly.
>>
>> I believe that "practicing" matters more than "talking" or "persuading".
>> I’m surprised your suggestion relies on "talking" ;-)
>> If I understand correctly, we all agree that "talk is cheap", right?
>>
>>> It's not a justification for why
>>> upstream should take this patch.
>>
>> I believe Johannes has clearly explained the challenges the community
>> is currently facing [0].
>>
>> [0]. https://lore.kernel.org/linux-mm/20250430174521.GC2020@cmpxchg.org/
> 
> (Sorry to interject on your conversation, but :)
> 
> I don't think anybody denies we have issues in configuring this stuff
> sensibly. A global-only control isn't going to cut it in the real world it
> seems.
> 
> To me as you say yourself, definining the ABI/API here is what really matters,
> and we're right now inundated with several series all at once (you wait for one
> bus then 3 come at once... :).
> 
> So this I think, should be the question.
> 
> I like the idea of just exposing something like madvise(), which is something
> we're going to maintain indefinitely.
> 
> Though any such exposure would in my view would need to be opt-in i.e. have a
> list of MADV_... options that are accepted, as we'd need to very cautiously
> determine which are safe from this context.
> 
> Of course then this leads to the whole thing (and I really know very little
> about BPF internals - obviously happy to understand more) of whether we can just
> use the madvise() code direct or what locking we can do or how all that works.
> 
> At any rate, a custom thing that is specific as 'switch mode for mTHP pages of
> size X to Y' is just something I'd rather us not tie ourselves to.
> 
>>
>>
>> --
>> Regards
>>
>> Yafang
> 
> What do you think re: bpf vs. something like my proposed process_madvise()
> extensions or Usama's proposed prctl()?
> 
> Simpler, but really just using madvise functionality and having a means of
> defaulting across fork/exec (notwithstanding Jann's concerns in this area).

Unfortunately I think the issue is that neither prctl or process_madvise would work
for Yafangs usecase? Its usecase 3 mentioned in [1], i.e.
global system policy=never, process wants "madvise" policy for itself.
Will let Yafang confirm.

[1] https://lore.kernel.org/all/13b68fa0-8755-43d8-8504-d181c2d46134@gmail.com/

