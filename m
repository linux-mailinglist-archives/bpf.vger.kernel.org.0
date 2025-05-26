Return-Path: <bpf+bounces-58935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B375CAC3E0D
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 12:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA8E3B756B
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56921F4C9F;
	Mon, 26 May 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RO/aLwi3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9C1F4703
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256567; cv=none; b=m5b17124m76f6iuqA/t3OmS35qXyNj6Q7Irn4M1STdQ/OI4Yhg9AA+W+utKBcTAWhpNJSez2aBxMAj0rX/P1g+s57BaxOVeYTNs5OuJvswy1kgImT4uSCV8JlzFGv0O22nvhY+0eW9o22D4qLfEiMJhl+tM4SPf8pqdorVCWTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256567; c=relaxed/simple;
	bh=3ICHMVUnlzG7twbB6/4mIs7S9f1rQFv0oQgg2Fr9FAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7bOZmv29UC+uPTG6mxta65Mfq2SXy2pyrbY4YSU9jf6Fteo7O4Hbi3EjUBpsoh1AApu6gi3V2EDsuHRCQQ4dSy2yKW9oaDN9otLcsmtRQaY56x439Y2XfO5yAT8LXaiB1cBYoV1dWxmaUSx8pnwcwNdsB6zy+lCawq4Qq43h4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RO/aLwi3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748256564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7+0MuMSLXNRjDBhbv/pKDh8idUjTmBFxBgZqbNxP0Ew=;
	b=RO/aLwi3CCf40/081WKKrcnuClaerpcNzAxz0wT+EXQvbETDXt0LymG613w1fTJuXO36Oq
	LEklDC5/proRJGPmmStCA3G6vMGURAqjrFXtLKe0XZUACGWGtf5Dp+EhkqlRtDKOtnFFUV
	rNeMnPVq8AlggIBq7dETrTTJwPucWS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-M6YGcqeCOgacRfUh_artbQ-1; Mon, 26 May 2025 06:49:22 -0400
X-MC-Unique: M6YGcqeCOgacRfUh_artbQ-1
X-Mimecast-MFC-AGG-ID: M6YGcqeCOgacRfUh_artbQ_1748256562
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4d863ac97so355564f8f.2
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 03:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748256562; x=1748861362;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+0MuMSLXNRjDBhbv/pKDh8idUjTmBFxBgZqbNxP0Ew=;
        b=QWKCF0b3uzKBJ39jAZhulMdFas5rDhZ5TyI4oTB6r5n1Qn56a4Rge/kd6Dba9dEJSH
         Fi5q4wEohsfEunbk9yMssXNwvJPCYJlt5s+qManzkguRKGtMNLCrs4klGuThg4QNQzOG
         YcDsOE2BQgTyLROT4vs+mnRmTJVh0nuwt1UBkRLAjGoLlbyN3d+9dlqTITUPdixpoysx
         SgJswSB5+FzdRtVwI8rjHwsgqjcVHlzIqDbalPv82IM7+oyFqoEsYBDY97sIJgtX566J
         STlGeIywqer6LUeILSiEYJmexleqLc7lsShNt3ROetGXQ9Ny7oBso4VA3sE1tVLUkkn3
         uTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4jMZ1ffk7m9sei3LDJTlvszqPlUOF9NJhaZdJIyjngK0bfKvLdrc8C1YI19rU/pPPhuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20xOuT3oceEINZGMDG52ddOHl7l75fMGc8hgGj13ttuIZKM5m
	0htJd9kvvI11jkMWHHg4Rh8c6VwaZhL2Pn1M2LJ1mAVGSCfHrvX1xf1MKnStqXIPww8rGHrXZsw
	Sn8PHJ++joo99y/8+C/suQbp0vS6XEcaCsAfU2goP5Z7jWsyeGV/fzQ==
X-Gm-Gg: ASbGnctYdy+8hXSONftrKepD0TEnn42ytxdieD77VgVeiCkfDf75gvFYn3ADF7fxK7j
	RYPyp6dvx77GfVZpx8HgXpeHtJ7g8fkBcc6X6S0c4xpBm81JnIwHhOzGLAvAnybWjHKaJs5lU41
	5bQeM4d3BMqNE3lZVXeCxGawM3PPYg3gt96cTMaCMNbNQsFY2eJcCluWjHQH/u+hgktPA8CqClG
	ZbL3gE85yjz9fSmOYYAiNJdzmVySqvs+h1xsZYHYKcGDrzYeXH8uITrETd4TM2GtvNFKP6oc1El
	4OkyAnuAkfWJUtvlRA8Z+tp+43XtDQaXUVTdjpc3nvTceWIbNHDC79h6E+4n/PbzPnR72B/mJga
	wtOsm120QppkOS8/PySLeB62yYSKA3XvMgGh3ZOk=
X-Received: by 2002:a05:6000:2082:b0:3a3:77d7:b3e2 with SMTP id ffacd0b85a97d-3a4cb49b0e6mr6460420f8f.41.1748256561788;
        Mon, 26 May 2025 03:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVCzHPZq1p0yojm5PhlRXuTjSHNBqW735pnpBnDUqSA1yaK/A1C8GImC/fbw1A2EkRBhRerg==
X-Received: by 2002:a05:6000:2082:b0:3a3:77d7:b3e2 with SMTP id ffacd0b85a97d-3a4cb49b0e6mr6460401f8f.41.1748256561363;
        Mon, 26 May 2025 03:49:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4? (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de. [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447eee9d8desm241148415e9.0.2025.05.26.03.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 03:49:20 -0700 (PDT)
Message-ID: <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
Date: Mon, 26 May 2025 12:49:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.05.25 11:37, Yafang Shao wrote:
> On Mon, May 26, 2025 at 4:14 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>> Hi all,
>>>
>>> Let’s summarize the current state of the discussion and identify how
>>> to move forward.
>>>
>>> - Global-Only Control is Not Viable
>>> We all seem to agree that a global-only control for THP is unwise. In
>>> practice, some workloads benefit from THP while others do not, so a
>>> one-size-fits-all approach doesn’t work.
>>>
>>> - Should We Use "Always" or "Madvise"?
>>> I suspect no one would choose 'always' in its current state. ;)
>>
>> IIRC, RHEL9 has the default set to "always" for a long time.
> 
> good to know.
> 
>>
>> I guess it really depends on how different the workloads are that you
>> are running on the same machine.
> 
> Correct. If we want to enable THP for specific workloads without
> modifying the kernel, we must isolate them on dedicated servers.
> However, this approach wastes resources and is not an acceptable
> solution.
> 
>>
>>   > Both Lorenzo and David propose relying on the madvise mode. However,>
>> since madvise is an unprivileged userspace mechanism, any user can
>>> freely adjust their THP policy. This makes fine-grained control
>>> impossible without breaking userspace compatibility—an undesirable
>>> tradeoff.
>>
>> If required, we could look into a "sealing" mechanism, that would
>> essentially lock modification attempts performed by the process (i.e.,
>> MADV_HUGEPAGE).
> 
> If we don’t introduce a new THP mode and instead rely solely on
> madvise, the "sealing" mechanism could either violate the intended
> semantics of madvise(), or simply break madvise() entirely, right?

We would have to be a bit careful, yes.

Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because 
these options also fail with -EINVAL on kernels without THP support.

Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.

What you likely really want to do is seal when you configured 
MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.

>>
>> The could be added on top of the current proposals that are flying
>> around, and could be done e.g., per-process.
> 
> How about introducing a dedicated "process" mode? This would allow
> each process to use different THP modes—some in "always," others in
> "madvise," and the rest in "never." Future THP modes could also be
> added to this framework.

We have to be really careful about not creating even more mess with more 
modes.

How would that design look like in detail (how would we set it per 
process etc?)?

-- 
Cheers,

David / dhildenb


