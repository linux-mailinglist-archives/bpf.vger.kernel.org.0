Return-Path: <bpf+bounces-48392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED466A07856
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E399B166B73
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440D219A76;
	Thu,  9 Jan 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UszsU1MY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AB215F4E
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431176; cv=none; b=WfevsuLELEm4qUvIjKe1U18fLQsdLQukE3IuMcAV12E7Hk2a52YIMOL+vFrBFApSIwRvJNdFwUpRZBEGxqHMPAZoyEpJIlQBf/WZOveH3G3pb16o8xsxZtJ73tuANZu2SpgEaOn0H28+RPqpkky3T5YA9qR7ug0cXXE1MBA/pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431176; c=relaxed/simple;
	bh=yqhB4jE7ih/qPV9eJ2r1XSJMHt7BqsvEpQ7Hxz6oO3k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LKxHBi+zQyG+PcoiZ/6lTzoh0A4ovDU18jxmJckofBAMNg5zEDnBX29CfmqWR+VIHXdInA/DxN1rW/J0YuM9Zwr10MOhX/ynzS6uB5w3b9qNi+lapfBQQl4YwU7Hqse53q7W37jd7tRglBR1WeSjdcp8Pez5IvF7+R/0jo195X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UszsU1MY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736431174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75CEj2ilYB4y1RMkVNNtYq9+NN/qHvo+cUZ8jr1W3Zo=;
	b=UszsU1MYeqWXyhqFQMch3VEi/PsQRYffJ6h3wyuhgmMqsmMGOJd7joEUsYV08byfRqMttR
	gtPWdoziQW9913t9h4xSLI2JaUfBMRkmthkcG3RfkvbW2H33PadhsnoMnbIHI4op9/5V9v
	dI50c6t5jJ+l+G2GPsn3jnTd2XHzYoY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Nnp7lpK0MBqk6mZSzr0awA-1; Thu, 09 Jan 2025 08:59:32 -0500
X-MC-Unique: Nnp7lpK0MBqk6mZSzr0awA-1
X-Mimecast-MFC-AGG-ID: Nnp7lpK0MBqk6mZSzr0awA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6dd43b16631so13096616d6.2
        for <bpf@vger.kernel.org>; Thu, 09 Jan 2025 05:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431172; x=1737035972;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75CEj2ilYB4y1RMkVNNtYq9+NN/qHvo+cUZ8jr1W3Zo=;
        b=QRwf9L1eiMpV6MS2IUSivX3YxhTuzksf42rvbs+yOpJPePTpH4h+F8NDDlrPkabrkA
         M0azwSEaAx5KLYcRd4hq1LlYnheSzCmH1VDlXn8pCFuv0oZT2cGpO4GIuJ5G/C26/rcQ
         5YpUidKa1XDe7qiUxrT3VN3I4i5mYHsGVGHgYQHmy1oy/h5w1kKtRI0Ki09NkyI2gHsk
         ShYvGrdS7McZtMmyy6v7EhiR0Gcghyuk7lMRVN7OfHClLlxFTteE/o8AdbGOIRM3tQfs
         WJuI/GUPhNUIRKtleXl023Bmy9+KK/MxXPz8Zmm8orygDadjr0kBYlfVhzfhNT64ym0n
         wOsg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCqGYNieQ47+1MaLKiKSgyJlyMYvaI+GuUUilfhGMtlf0QrhHaDvUlG+gVObkzJC8Sd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXBZPzTkThUKJMGWZaIHPRBpJSC+SIpZFuOqgvKXpfcw/EL6u
	DTSwssFfQies8TH9jyXU2TTm2wOgo5uftrrOxAvvweUbuEKcHOIFuMrjtprdCaQ9gftIsrWrHop
	xdTklNiNLcCRxBUfOnOVJNMYYkLgSz5MNHVBfqhBgBvTXztep3A==
X-Gm-Gg: ASbGnctCkTWk2e64bnGX1vu9xkMJCDwII+7gAyeYbvREtWdTsc63276cbU+MQuVexYQ
	XxZySA9CujKU7MPIvFuwP8PIItnM/quY2sv4nYVEpmQrPwULUg22I/X9YynJw36aSidIUeDQgEM
	eCp9Hdywtcva4MxsdtWy44gdjeRGzF4wxtJGgI9sJXdSZ2Y18ddBcnOioSyIOBgmSkAk/sY24B6
	RFTdvSGaRAI/T+hEcASJTkMWn2ozg//nQZXcApO+AupnwcSqnyCp/BRAUNveN5NdzQcmbeBKShp
	ynT9+C7iDrAoa3GphxJ0hrNX
X-Received: by 2002:a05:6214:20e3:b0:6d8:a32e:8426 with SMTP id 6a1803df08f44-6df9b1d237fmr95290316d6.3.1736431172419;
        Thu, 09 Jan 2025 05:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVw/bf+1TY6+NMjzPQ1gj26xKeKuh1Obm5BG5cSto/8IHVhIqXTqCX2Z3eambFa76Ru8Kk6A==
X-Received: by 2002:a05:6214:20e3:b0:6d8:a32e:8426 with SMTP id 6a1803df08f44-6df9b1d237fmr95289926d6.3.1736431171996;
        Thu, 09 Jan 2025 05:59:31 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18137218sm199427926d6.57.2025.01.09.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:59:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <974db75a-4ffd-4379-8085-484c45702fe5@redhat.com>
Date: Thu, 9 Jan 2025 08:59:29 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 00/22] Resilient Queued Spin Lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Waiman Long <llong@redhat.com>,
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
Content-Language: en-US
In-Reply-To: <CAP01T75XoSv91C6oT8WSFrSsqNxnGHn0ZE=RbPSYgwX79pRQVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 3:12 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Jan 2025 at 14:48, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Tue, Jan 07, 2025 at 03:54:36PM -0800, Linus Torvalds wrote:
>>> On Tue, 7 Jan 2025 at 06:00, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>>> This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
>>>> res_spin_lock() and res_spin_unlock() APIs).
>>> So when I see people doing new locking mechanisms, I invariably go "Oh no!".
>>>
>>> But this series seems reasonable to me. I see that PeterZ had a couple
>>> of minor comments (well, the arm64 one is more fundamental), which
>>> hopefully means that it seems reasonable to him too. Peter?
>> I've not had time to fully read the whole thing yet, I only did a quick
>> once over. I'll try and get around to doing a proper reading eventually,
>> but I'm chasing a regression atm, and then I need to go review a ton of
>> code Andrew merged over the xmas/newyears holiday :/
>>
>> One potential issue is that qspinlock isn't suitable for all
>> architectures -- and I've yet to figure out widely BPF is planning on
>> using this.
> For architectures where qspinlock is not available, I think we can
> have a fallback to a test and set lock with timeout and deadlock
> checks, like patch 12.
> We plan on using this in BPF core and BPF maps, so the usage will be
> pervasive, and we have atleast one architecture in CI (s390) which
> doesn't have ARCH_USER_QUEUED_SPINLOCK selected, so we should have
> coverage for both cases. For now the fallback is missing, but I will
> add one in v2.

Event though ARCH_USE_QUEUED_SPINLOCK isn't set for s390, it is actually 
using its own variant of qspinlock which encodes in the lock word 
additional information needed by the architecture. Similary for PPC.

Cheers,
Longman


