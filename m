Return-Path: <bpf+bounces-76708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B777CC2499
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FA930C9E7A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7E34320C;
	Tue, 16 Dec 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wchO70Tt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F0343200
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884393; cv=none; b=eGoAF/7N9azkBvVirjnWLR4TgFDcitqmdDwBFx8hXZEhPhxGffS6AWohYoRnI5edXZn7WZlaOFJa7EkQ+h/mZjTEZesnEr2Daz48B2SXHUPw3njzxsGnBd3H8EnFGgrhAcE3DaYfsL1TVPNidomQl2UEDLc/BceiwFupN5qDVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884393; c=relaxed/simple;
	bh=q9ZAtoPzV+0i8f8sOYySZ4a5kVA9GV/rbZS2hvoFQJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U4aEj9eNDN4qx4SF4B6FQ4m5qM7X/LjuxR7WZTzhlaaqion5NYUXq/6FZGvCRXzjdkhkWu2Y9N8Ii1xvd64ea8+9xPmPV2p9lGGjohdBaPkwa/5uTechMj3aQX5MiC+A3h6RJuMNczL+OwdlBdntxxUsq7+djodngDUnZAJxgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wchO70Tt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430ffa9fccaso1708963f8f.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765884390; x=1766489190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krMeQQo0RYkVVveyUInYgEYC1GtxSzSLPYvL0R6jcGk=;
        b=wchO70Ttgme5Trj3XKQm1fxMGM7CJkwKpVYn6N1UqhuvafA28l9I16tqoMfBUwnjq2
         wivTQmcY17Q379ton6v+f6hDCRL+us4F7OOdRKgvsRhrCpZ2tY3hC2NjlSkSYOf2X6jH
         UPF/lKgGq1TfgTuFGXNjDkB4/DuOv7oI4tSJuX/P7HuBlJMfppc3d7+bglDla6+m+Xtb
         ZqIr5mFgRssR8LgTUm/LTUl4hDFqOwm8qCBbZSTeVTc2lBOjFf+SYGdm2gfVToqai5NJ
         sUnCKFr0A1QZufnRb6I9w4i6CF/lGCs6VtMtKtGoSmK0cJ+PftcwnO8W64J4JCPC5Fr5
         Z17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884390; x=1766489190;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krMeQQo0RYkVVveyUInYgEYC1GtxSzSLPYvL0R6jcGk=;
        b=n68nVzLMgPZOwCXq6yNp1XSZLZGJM6GjuaJ4BjXlbjFUXTpnZWzFZ1dVvo3ePmwiBf
         go4K33NvbTHN699fkjrbmSwgcjqtYzgvoJTKdWUJLJs8Yi1xYIHGzOY+axE5HZRg6Eek
         yXR+Gg+pohJAtx7yPTsceTkqGyXEAhMwUq4nJzFCAlIjz6yJSvdBi/OE5+Ye7C9cvIqN
         vb4PDr1IvZ+IfzE7AcOTaeCvwIOP6eYqQBqSHclIFs44Np1QaZ7FGFDxBQgkU1l9Mkqw
         DalsD9NCx9gO5Q3HIe7LmjKZjdIJPVIZ7Yh1NHEIxEQNTm7yOGjUbjlkpbNMTV1ZomOh
         UCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1YUvH5qS93GzCny6Xcs8qI3PPY/YiRfa4+hTd4crbXj2m5HOAZXtclSjpGjh+5zeO94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9Ng3xynml7G6uDr2atw+6Z023GbXHub+DWimexfgQEwTlnm3
	NZDPYGdup2IzxiMMz+JItRZABivBUG2hlKzP6JMJtjoVC3eti8Wi4psXUq55hDvl8uORxF30Gxw
	N2bldEh3vRAHA0Q==
X-Google-Smtp-Source: AGHT+IHRBFMdNHijFHNhfpSjk2TQJ9kZwXaGz3RsF4bB/Qt7P2NzdaKmXMouO4czF1ta3V3ssZTXVLAPCUMyQQ==
X-Received: from wrrr18.prod.google.com ([2002:adf:a152:0:b0:427:87c:f46])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:310e:b0:430:fcda:4529 with SMTP id ffacd0b85a97d-430fcda47a1mr7553444f8f.61.1765884389671;
 Tue, 16 Dec 2025 03:26:29 -0800 (PST)
Date: Tue, 16 Dec 2025 11:26:29 +0000
In-Reply-To: <aUE8bwUVa6jSUft1@e129823.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com> <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
 <aT/drjN1BkvyAGoi@e129823.arm.com> <DEZK5U2YP6I0.27VJHSVK14646@google.com> <aUE8bwUVa6jSUft1@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEZLRT59S25H.2YWTZ2G0TN3HV@google.com>
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
Content-Transfer-Encoding: quoted-printable

On Tue Dec 16, 2025 at 11:03 AM UTC, Yeoreum Yun wrote:
> Hi Brendan,
>
>> On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
>> [snip]
>> >> Overall I am feeling a bit uncomfortable about this use of _nolock, b=
ut
>> >> I am also feeling pretty ignorant about PREEMPT_RT and also about thi=
s
>> >> arm64 code, so I am hesitant to suggest alternatives, I hope someone
>> >> else can offer some input here...
>> >
>> > I understand. However, as I mentioned earlier,
>> > my main intention was to hear opinions specifically about memory conte=
ntion.
>> >
>> > That said, if there is no memory contention,
>> > I don=E2=80=99t think using the _nolock API is necessarily a bad appro=
ach.
>>
>>
>> > In fact, I believe a bigger issue is that, under PREEMPT_RT,
>> > code that uses the regular memory allocation APIs may give users the f=
alse impression
>> > that those APIs are =E2=80=9Csafe to use,=E2=80=9D even though they ar=
e not.
>>
>> Yeah, I share this concern. I would bet I have written code that's
>> broken under PREEMPT_RT (luckily only in Google's kernel fork). The
>> comment for GFP_ATOMIC says:
>>
>>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A=
 lower
>>  * watermark is applied to allow access to "atomic reserves".
>>  * The current implementation doesn't support NMI and few other strict
>>  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GF=
P_NOWAIT.
>>
>> It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
>> normal preempt_disable() context. So do you know exactly why it's
>> invalid to use it in this stop_machine() context here? Maybe we need to
>> update this comment.
>
> In non-PREEMPT_RT configurations, this is fine to use.
> However, in PREEMPT_RT, it should not be used because
> spin_lock becomes a sleepable lock backed by an rt-mutex.
>
> From Documentation/locking/locktypes.rst:
>
>   The fact that PREEMPT_RT changes the lock category of spinlock_t and
>   rwlock_t from spinning to sleeping.
>
> As you know, all locks related to memory allocation
> (e.g., zone_lock, PCP locks, etc.) use spin_lock,
> which becomes sleepable under PREEMPT_RT.
>
> The callback of stop_machine() is executed in a preemption-disabled conte=
xt
> (see cpu_stopper_thread()). In this context, if it fails to acquire a spi=
nlock
> during memory allocation,
> the task would be able to go to sleep while preemption is disabled,
> which is an obviously problematic situation.

But this is what I mean, doesn't this sound like the GFP_ATOMIC comment
I quoted is wrong (or at least, it implies things which are wrong)? The
comment refers specifically to raw_spin_lock() and "strict
non-preemptive contexts". Which sounds like it is being written with
PREEMPT_RT in mind. But that doesn't really match what you've said.

