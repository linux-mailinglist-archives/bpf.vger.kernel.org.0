Return-Path: <bpf+bounces-76710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33BCC4011
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D241F3044858
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41635A95D;
	Tue, 16 Dec 2025 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qiMFQQS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32E358D19
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888767; cv=none; b=epK4WwcG4GZ4udxt6mx87DTyzc/jajow9xoAy7HAQyijAZSnA5g47oTCQKBLIiFgsmoyVxRfaZ9VUfFnduNV5ZodaIHl/HrYM6Wz7Avm9KRkY3xwUdu75kclMlRovKLI9jbkjLAHNPnSCFxnVyXROp+fpeSs1kAUeIMxY1yCP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888767; c=relaxed/simple;
	bh=ODOFXdKh7a/2yyeolj4dfSpZo/cGD6EWg9Uz8WCXsU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ud7FvoEkiz59OuYF5h4yylRuXbJRKQWe9JNjBbX9GqaWkxv1TT7CUsLa7mGmAbOsydC3fwFdVczUjyGQ8u6BlArTFgft5/1WO8+GxM+2bUr/SnNxgQjFW1oic9gHL9OV7qgKzPhfGDo7TVOtNYEsA3+nAMfGXo9ftn3ffBCbb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qiMFQQS; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64981e93806so5104239a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 04:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765888764; x=1766493564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl5vYkOfCeh8vzJ1i3gRdGX7RBaO+Y5siaEC/TfzJu8=;
        b=2qiMFQQSK1sYqI1EleMXBTcbFsv0cH87wr/PM6JBNiylktXHZiRhfivgox+dN9M1bJ
         ZDYpO9LZJVStLXOWQ3nz69Hc6SiZc5hh3eH0amEMEEgLHcyPgqY0YB65cTycydBWWLJZ
         Bf79/wLC2U8I3l4n8p9ZyzSfgfmLy6qKX9uyJCg6mRtObL5xni7RPL55+NsrElmu/jAP
         9trWIEMFqoIF4ZI2YJ3WKJpfmMuM3M+eI5+VULcjZaR5QTN2rpkxg4y+7SmlZB/OUmA1
         9m36dvwcIQoihRk0rOvhYiBoGvy14j7+mqjGaCwHcunl7K03g6AQkZnNbqPS6U4DrXFQ
         7NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888764; x=1766493564;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zl5vYkOfCeh8vzJ1i3gRdGX7RBaO+Y5siaEC/TfzJu8=;
        b=mOk8zICWt7zv5Zlh9HpaMAkwlIFF/lgz0lrTjeLZ6aXio7xzfOW5tgTS6yGCTkmeAU
         eKqu1Ficu9g4mfmjG1CJfMUlzSi2lHYDKF6xbqaDm12va50U6m/Tu0IpBH4vTQCQkGGd
         Cu5wTqFGAJ4g2nPEXWNc/wga0lyEd/htHL4S34drkXHg+7qv2d0vtBYMmFvgLjfGmxgL
         /3sYECdG0+xXH6a2f5w/S93LC9WERU2EJk8ajlW7Szu3V+3vWJC6Mevzz0FcLNMvzN96
         k7twzwkKLajCtR2TXlQTlupGeQvBx61PdDIWF5qBZL+W+UrvjtrMinrsCfxpyN1Y7Bgn
         0ETg==
X-Forwarded-Encrypted: i=1; AJvYcCVcxYDZ66ce+g+ZAwXNMWoko7ExvHRvrIDslLkwGer/STk4VHi8OjHD2LKjcK1MwwQ2dJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cQ9GJWcu1hDlloDFdQqubOnXllBtwmykJsiWlH4sroTVj1ot
	LSrGaLojx2+w4iaDA46KCVUJ269qOPYllto62srZQPKAL6oHcNhdaWPpBPY4+CI/CowsmyjJayx
	nk4u3mVu3PWr87A==
X-Google-Smtp-Source: AGHT+IHodb6E0igt70QWnGwF16M0BauoX0vq/LCQAwB66mdazNxScaNnSE8J8M2KteYx3re6oS8FbB6Lsn9MBw==
X-Received: from edsk11.prod.google.com ([2002:aa7:d8cb:0:b0:643:12a9:41be])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50c8:b0:64b:3a87:44ff with SMTP id 4fb4d7f45d1cf-64b3a874559mr607042a12.34.1765888763584;
 Tue, 16 Dec 2025 04:39:23 -0800 (PST)
Date: Tue, 16 Dec 2025 12:39:22 +0000
In-Reply-To: <aUFKAdPY3zTlPmnr@e129823.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251212161832.2067134-3-yeoreum.yun@arm.com> <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com> <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
 <aT/drjN1BkvyAGoi@e129823.arm.com> <DEZK5U2YP6I0.27VJHSVK14646@google.com>
 <aUE8bwUVa6jSUft1@e129823.arm.com> <DEZLRT59S25H.2YWTZ2G0TN3HV@google.com> <aUFKAdPY3zTlPmnr@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEZNBMBRM5M2.1974FFAQ13G5E@google.com>
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

On Tue Dec 16, 2025 at 12:01 PM UTC, Yeoreum Yun wrote:
>> On Tue Dec 16, 2025 at 11:03 AM UTC, Yeoreum Yun wrote:
>> > Hi Brendan,
>> >
>> >> On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
>> >> [snip]
>> >> >> Overall I am feeling a bit uncomfortable about this use of _nolock=
, but
>> >> >> I am also feeling pretty ignorant about PREEMPT_RT and also about =
this
>> >> >> arm64 code, so I am hesitant to suggest alternatives, I hope someo=
ne
>> >> >> else can offer some input here...
>> >> >
>> >> > I understand. However, as I mentioned earlier,
>> >> > my main intention was to hear opinions specifically about memory co=
ntention.
>> >> >
>> >> > That said, if there is no memory contention,
>> >> > I don=E2=80=99t think using the _nolock API is necessarily a bad ap=
proach.
>> >>
>> >>
>> >> > In fact, I believe a bigger issue is that, under PREEMPT_RT,
>> >> > code that uses the regular memory allocation APIs may give users th=
e false impression
>> >> > that those APIs are =E2=80=9Csafe to use,=E2=80=9D even though they=
 are not.
>> >>
>> >> Yeah, I share this concern. I would bet I have written code that's
>> >> broken under PREEMPT_RT (luckily only in Google's kernel fork). The
>> >> comment for GFP_ATOMIC says:
>> >>
>> >>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed=
. A lower
>> >>  * watermark is applied to allow access to "atomic reserves".
>> >>  * The current implementation doesn't support NMI and few other stric=
t
>> >>  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to =
%GFP_NOWAIT.
>> >>
>> >> It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
>> >> normal preempt_disable() context. So do you know exactly why it's
>> >> invalid to use it in this stop_machine() context here? Maybe we need =
to
>> >> update this comment.
>> >
>> > In non-PREEMPT_RT configurations, this is fine to use.
>> > However, in PREEMPT_RT, it should not be used because
>> > spin_lock becomes a sleepable lock backed by an rt-mutex.
>> >
>> > From Documentation/locking/locktypes.rst:
>> >
>> >   The fact that PREEMPT_RT changes the lock category of spinlock_t and
>> >   rwlock_t from spinning to sleeping.
>> >
>> > As you know, all locks related to memory allocation
>> > (e.g., zone_lock, PCP locks, etc.) use spin_lock,
>> > which becomes sleepable under PREEMPT_RT.
>> >
>> > The callback of stop_machine() is executed in a preemption-disabled co=
ntext
>> > (see cpu_stopper_thread()). In this context, if it fails to acquire a =
spinlock
>> > during memory allocation,
>> > the task would be able to go to sleep while preemption is disabled,
>> > which is an obviously problematic situation.
>>
>> But this is what I mean, doesn't this sound like the GFP_ATOMIC comment
>> I quoted is wrong (or at least, it implies things which are wrong)? The
>> comment refers specifically to raw_spin_lock() and "strict
>> non-preemptive contexts". Which sounds like it is being written with
>> PREEMPT_RT in mind. But that doesn't really match what you've said.
>
> No. I think the comment of GFP_ATOMIC is right.
> It definitely said:
>   The current implementation *doesn't support* NMI and few other strict
>   *non-preemptive contexts (e.g. raw_spin_lock)*.

But this phrasing sounds like there are other non-preemptive contexts
that it _does_ support. I would definitely read this as implying that
plain old preempt_disable() is OK. I don't understand what those "few
other strict contexts" are, nor why the stop_machine() context is
included in them.


