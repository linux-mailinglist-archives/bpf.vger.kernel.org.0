Return-Path: <bpf+bounces-48458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36112A08216
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D31887A39
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF0202F8E;
	Thu,  9 Jan 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIv/w93H"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB318785B
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457533; cv=none; b=UValQUxRh2eClQ+iXhrvsc8rCMff7i2RS3fpsexCbJtiijUpF79HEUJFp6OWuL5yxJKtU2lN8LdPBGLQ0/NcbuYztMu15AwxmPAZSf/PEA6WBsfi8XWI+tx6vVXsoFY+dVbfzM1rvBNvrnqdtNwYx1r9q4/4EkXBylztW9C9hSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457533; c=relaxed/simple;
	bh=Su+Jw+cgZc1WDPAuDKSv3zG2gVu3P1AkQRvgn8D2ICE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hCbN8ObgZYzYEE0NqzcrOwRvDG15n4zQMqkJYGL0j2wwo+7v9Yfe72+pHJW8Sd4/ugq7ABcfbnpDMUanPguylozieq9gmCAnNN+UF/PAYNP7kzZQGAD5v1LnbR8B/7KnTiLYFqR8tIfsma813fcIN1AFoNFTeweBQWMrbGQE5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIv/w93H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736457530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUxg8MKMgCXy+S8yjErvN9FPE1V4L+k8ZTNl9PoflDE=;
	b=UIv/w93HENbAMB5+Ze4g05gEAGe6wbP93WULtBtERHL+OYIrkzw8fGJWins9KXA6cWHZ07
	SJqYWYtXLp7rgTI3SvFdAeLKDDGH4MXBNkNRc6Eja6pm8qq7xQEnS89gc3beBFgOtceDzZ
	hwPwwuFA/HengKkgrWFdyViSoTtzM44=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-mcAYkNj9N2mkujsU8Zrryg-1; Thu, 09 Jan 2025 16:18:49 -0500
X-MC-Unique: mcAYkNj9N2mkujsU8Zrryg-1
X-Mimecast-MFC-AGG-ID: mcAYkNj9N2mkujsU8Zrryg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e178d4f8so226723585a.3
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 13:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736457529; x=1737062329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUxg8MKMgCXy+S8yjErvN9FPE1V4L+k8ZTNl9PoflDE=;
        b=Z892lYtwmt/La6JIAC+lZKkKpFF6M6rZaxNWS000eSLYsXTEdmtiQwCiBgMxCWshBr
         YgJW9PVpjI8aJWYK1g1HjW3ct2Ow7yFKnNtsSsQ+XGA/+k5PuMH7RQYaLuu3Hzann4qG
         tGYms/+puSn+rLatsDOFPNAEndsLsh9TDbyf2P2SJco201mZPi6vDXOV5mR4/Pw1VL9l
         XxZ8nSAQQgBwdX7JaBfO4Hrdam4MnQqH+WwsGUPPvu/tckv+UFQk75a70ROVhTvjhAWa
         foE663QM6+LJrKwhKbrgVMStQR/UfS6odWDaRNzNs1tt9VoqzyPQAuon4IgMijI6UpUS
         GXVw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ39lgvlhZNwFCa4djduqnra750FPWe1Afg7SKZ2zi4NYnsvZHrIiS28lfz/zxTn7IULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdMObFo0p9loMVxnY9Ilas6cznbP+Z1nlduyARmjkKJv1PGcR
	6vsObtoBjNVXK4V94h//gHT9LHgTHq3QPI8MmYBZQLUu2yI8NDin1DGhhdZfaV2Txyv7cGeHw5W
	Qk3H+tVfLS+p7FAWnRBbUnHhOSf3fciG/hou+axbzrvUYY/dQTg==
X-Gm-Gg: ASbGnct8bKVXl3PzgoMlyxMJH3dELYR8FoGGrRp+bYA0Y1VC/BCk9iOI3cnkROYuI4s
	Z3Q0BgYYoxnf372IQd9+MSHBAKwDnXLHIN9J99PzyMpAXJRRXmbDcTqbo8R0kNTW1GtZ22gIAGI
	w6q1TE4MZiYSi3yHSC/dJvCw9j0N59UPZOO2DaS2NRmEvOBnscI5TpLDbG5faLMt/XwlaljzIwz
	Rro3WHypUv3+dnbIqzVolGLHbUrQL0i4RWcbQrx8MXRAo51kCBFCoFPad7uHkMKyKKpeZ3YnfxL
	3sxMD5Wt7tkTByCXNj1diTny
X-Received: by 2002:a05:620a:4444:b0:7b6:5e73:99e8 with SMTP id af79cd13be357-7bcd9710348mr1361818985a.25.1736457529089;
        Thu, 09 Jan 2025 13:18:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf93dP9YbrHDeL93rJW/h5zmnn34QfKme8Kf1AzijYw16Cd4WCE57ChHMJ8vmFubJM4przgg==
X-Received: by 2002:a05:620a:4444:b0:7b6:5e73:99e8 with SMTP id af79cd13be357-7bcd9710348mr1361814785a.25.1736457528769;
        Thu, 09 Jan 2025 13:18:48 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248304sm106303485a.31.2025.01.09.13.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 13:18:47 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dcb45d7c-2db4-4167-a420-312d3eb2611d@redhat.com>
Date: Thu, 9 Jan 2025 16:18:45 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <CAHk-=wh9bm+xSuJOoAdV_Wr0_jthnE0J5k7hsVgKO6v-3D6=Dg@mail.gmail.com>
 <20250108091827.GF23315@noisy.programming.kicks-ass.net>
 <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
 <974db75a-4ffd-4379-8085-484c45702fe5@redhat.com>
 <CAP01T76guECG9gn2cDENww4_W9rRvAZ_6YkF9T2mAy7jUS+V4g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP01T76guECG9gn2cDENww4_W9rRvAZ_6YkF9T2mAy7jUS+V4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/25 4:13 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu, 9 Jan 2025 at 19:29, Waiman Long <llong@redhat.com> wrote:
>> On 1/8/25 3:12 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, 8 Jan 2025 at 14:48, Peter Zijlstra <peterz@infradead.org> wrote:
>>>> On Tue, Jan 07, 2025 at 03:54:36PM -0800, Linus Torvalds wrote:
>>>>> On Tue, 7 Jan 2025 at 06:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>>>>> This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
>>>>>> res_spin_lock() and res_spin_unlock() APIs).
>>>>> So when I see people doing new locking mechanisms, I invariably go "Oh no!".
>>>>>
>>>>> But this series seems reasonable to me. I see that PeterZ had a couple
>>>>> of minor comments (well, the arm64 one is more fundamental), which
>>>>> hopefully means that it seems reasonable to him too. Peter?
>>>> I've not had time to fully read the whole thing yet, I only did a quick
>>>> once over. I'll try and get around to doing a proper reading eventually,
>>>> but I'm chasing a regression atm, and then I need to go review a ton of
>>>> code Andrew merged over the xmas/newyears holiday :/
>>>>
>>>> One potential issue is that qspinlock isn't suitable for all
>>>> architectures -- and I've yet to figure out widely BPF is planning on
>>>> using this.
>>> For architectures where qspinlock is not available, I think we can
>>> have a fallback to a test and set lock with timeout and deadlock
>>> checks, like patch 12.
>>> We plan on using this in BPF core and BPF maps, so the usage will be
>>> pervasive, and we have atleast one architecture in CI (s390) which
>>> doesn't have ARCH_USER_QUEUED_SPINLOCK selected, so we should have
>>> coverage for both cases. For now the fallback is missing, but I will
>>> add one in v2.
>> Event though ARCH_USE_QUEUED_SPINLOCK isn't set for s390, it is actually
>> using its own variant of qspinlock which encodes in the lock word
>> additional information needed by the architecture. Similary for PPC.
> Thanks, I see that now. It seems it is pretty similar to the paravirt
> scenario, where the algorithm would require changes to accommodate
> rqspinlock bits.
> For this series, I am planning to stick to a default TAS fallback, but
> we can tackle these cases together in a follow up.
> This series is already quite big and it would be better to focus on
> the base rqspinlock bits to keep things reviewable.
> Given we're only using this in BPF right now (in specific places where
> we're mindful we may fall back to TAS on some arches), we won't be
> regressing any other users.

I am not saying that you have to deal with that for the current patch 
series. However, it is something we need to tackle in the long run.

Cheers,
Longman


