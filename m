Return-Path: <bpf+bounces-76605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5315ECBD4AC
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1423018954
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0B32AAC2;
	Mon, 15 Dec 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1f5EmxaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B4329393
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792530; cv=none; b=WY16he9l8ZwlUZXj7yHeGyavd/kFOvS1gH1JvCJpBB6jWiErweE7ciQNfRKVDY/K9XDOrdeXxMTbFkB1eBxG7QmhjsEWvsm989n1nFCqDZWATcxaMlR8Kg8DUdyEdhPUORCvkUc9xl+OzxGKwEFFExxny36jXSC8NSpKan+EyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792530; c=relaxed/simple;
	bh=MErqbYG3hVSovTFjSQY3qFyCwp76vQn51NyQKwSvMfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NR7j5umq5MFOmGCGgResmFsCcZ5gF4YUxl5Tr41Lq8ZsXYQ/sdEp9FkC1pKuYZCgqYYqNplf/AhsFCdsHKhizSfa8YbrRxYr16YS2rHwZm2CGJl1KCOjw0XrwKKCM7bPPSEYs+F8Jmez2CSwogoIDMo5TfMEZjDC2ryXohsdh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1f5EmxaW; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430f825d4d2so751993f8f.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765792527; x=1766397327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXmkpglOgTRlWY6ZkKkXvIK9PamZymsXtf90xHcK+6o=;
        b=1f5EmxaWTdpPwCIPwvLlJSqXK3+c6NCzp+azUc4zNuYWtwlImsDbnWdmMGjnq27qDS
         SkvPrKt8N4BLYzNXR3jNbHHHrxjFejHODrmfN7GDHsI3Yco9dggG5AfeoETCTGexIP/t
         9ABoQpusllmimh2hrytTIS8aUleYV2RmWqD/UsF151DkVmmiozkQfO5FROvxf0rikc5w
         t2JcgEhhQwtX7hSm1y5B/7f+jaghMI3yhFvLV30sQnIK5wFBJtQccGqhRB0hydS0aomi
         5ExwM+2/3QIVmbmEsU7IclZEo3OxhSESfa4BJ71jr9e9h/A3AawSFRwzqkGG1jPnz6wS
         OAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765792527; x=1766397327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXmkpglOgTRlWY6ZkKkXvIK9PamZymsXtf90xHcK+6o=;
        b=pDDSt5ELIOnSv0cMz6In1WkJIYecJX+x7jnHfK1Dp0oTSeh3Rkt8zG75gQsHR+s3uh
         xUbiuKFWNNcFP5n80R8hAMSEIVx5ySqMDuuubR6EckGvaJcYHBT1OZf9inVJe5Ro+kxa
         oSGKDIEdVRKL7G/X+Q7/jCYPyBPIHEMH9HwqziDlJxJ7AFT7jYJmS8ndxX3Dqz/tU5rf
         5FA9+xa4ZVu4rrttG9u7RNcUbuMVfb/tttUPzg2zdmNgH1j+/ipeVE/93aFEVwJPdz2t
         vfvbF0dWs2rvHWPgl385hOAG0klUegkEGJFRcqZ47d1FiEHur3DiNFkHCpzljDmTRUtX
         ZQDA==
X-Forwarded-Encrypted: i=1; AJvYcCVI1Thz42cWhIkWnbfPCkRFi1jaf/vz3m+SWiTzDqndLv1OhFAyMp4jTO1DBWFKngbz4tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPhddGMCM5SgiZsDcabtaSV8MsV4FqIpZNdVqdnyB4i4pZhch
	jkmCfQ3SwdHlatxs/UXSdJUGOutcn12LNOInCLY9WcaqMuEKnod/f+9UyOUeUqU/2TrTitLzqT/
	eje/ENdsxdswE3Q==
X-Google-Smtp-Source: AGHT+IGJNUQ3yCE5dAMJ9tGmUAnyfo5RpFowfQkzScccNTMlw3Eak2tuYu3AGem3xCXRYZD9qM+KN+pYSar9uQ==
X-Received: from wrp13.prod.google.com ([2002:a05:6000:41ed:b0:430:fcc8:d29e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40df:b0:430:f68f:ee97 with SMTP id ffacd0b85a97d-430f68ff1b5mr5631418f8f.40.1765792526655;
 Mon, 15 Dec 2025 01:55:26 -0800 (PST)
Date: Mon, 15 Dec 2025 09:55:26 +0000
In-Reply-To: <aT/WOAr4osoJWaMS@e129823.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com> <aT/WOAr4osoJWaMS@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
From: Brendan Jackman <jackmanb@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Brendan Jackman <jackmanb@google.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<ryan.roberts@arm.com>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Dec 15, 2025 at 9:34 AM UTC, Yeoreum Yun wrote:
> Hi Brendan,
>> On Sun Dec 14, 2025 at 9:13 AM UTC, Yeoreum Yun wrote:
>> >> I don't have the context on what this code is doing so take this with
>> >> a grain of salt, but...
>> >>
>> >> The point of the _nolock alloc is to give the allocator an excuse to
>> >> fail. Panicking on that failure doesn't seem like a great idea to me?
>> >
>> > I thought first whether it changes to "static" memory area to handle
>> > this in PREEMPT_RT.
>> > But since this function is called while smp_cpus_done().
>> > So, I think it's fine since there wouldn't be a contention for
>> > memory allocation in this phase.
>>
>> Then shouldn't it use _nolock unconditionally?
>
> As you pointed out, I think it should be fine even in the !PREEMPT_RT case.
> However, in case I missed something or if my understanding is incorrect,
> I applied it only to the PREEMPT_RT case for now.

Hmm, I don't think "this code might be broken so let's cage it behind a
conditional" is a good strategy.

1. It bloats the codebase.

2. It's confusing to readers, now you have to try an understand why this
   conditional is here, which is a doomed effort. This could be
   mitigated with comments but, see point 1.

3. It expands the testing matrix. So now we have code that we aren't
   really sure is correct, AND it gets less test coverage.

Overall I am feeling a bit uncomfortable about this use of _nolock, but
I am also feeling pretty ignorant about PREEMPT_RT and also about this
arm64 code, so I am hesitant to suggest alternatives, I hope someone
else can offer some input here...

