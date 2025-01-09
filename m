Return-Path: <bpf+bounces-48346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4C6A06BBD
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8375188715D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E4136327;
	Thu,  9 Jan 2025 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhcF2yMv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20BBE5E
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391535; cv=none; b=W474NM9pjOH+l/TibAlt1o1Z84oUiSOo2wlSaoriWxoOhGsOadIWXs5REjkTVh7HCp+q51UFqWV+6tWxXugp19BVp0uiKdAvLCauMjzTVyNicEerJDJkU3+mttR1zjxu8XR6Qayt3R+KIYSY/qmQTtj3I4CSHin3lmF2DFpNB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391535; c=relaxed/simple;
	bh=Vt+CRnk1ye8B5y25H6+xjvtK8YrAAiwIDq4Bs+Aiop8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nEWGN3squ0DYUoI2Dv8/AQaSy/e5YwzJujrOHTlOgDSGfGJh1tS+kfMcIEu+wFWey658tpzcsLxrEfw9Yk2mLjfvS84AyMTA47VHySZvtrMLSzKoDZjLkDNUxniRdTrtC0sU4QwXWRixNuheW4YaSpD12EZKvBWPM1MRVUukTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhcF2yMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736391533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UeEVifIWXTcYVcPd1SRPc2ptUfPXQ69SIyCID30m5c=;
	b=NhcF2yMvjStYNhKZ7/8saaZKC3LdThwNmt5OT+ly3Qobv2tVY4Q+2ff2ljs6HaOtnP5LHn
	iRF8MwGYeSvHd7Mejd4rw6Aeip2OJYgmYmKwcxhY1X7TNGZTzzbWl5F+4BBOIcAE+a70Ye
	Mprkyeq5mkFKZSdxndG3F1yQEe5NOGE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-GLO9AZVIMF2oKTmKbaDqGQ-1; Wed, 08 Jan 2025 21:58:52 -0500
X-MC-Unique: GLO9AZVIMF2oKTmKbaDqGQ-1
X-Mimecast-MFC-AGG-ID: GLO9AZVIMF2oKTmKbaDqGQ
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso8879386d6.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 18:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736391531; x=1736996331;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UeEVifIWXTcYVcPd1SRPc2ptUfPXQ69SIyCID30m5c=;
        b=eRWAk90ky5vVC/fq2Sn82GgN/Uo2LvnuHScy9rCGtztGs8DkXqnNOYx7LgmP46Orpp
         TIsxUFbNBglv+0P92gUoQpIm+3OioWwOa3wSrhrA418LGQru8Fv9O2pnR7EzTbHPAuCo
         FAPoMYRk4zY/1u2k50zJQJmhdGpUpRTHbXhrWByn1TsJY4ihJQ+zybgfnoLCpxRA5uDS
         HEH6YaP46+T2a8m1C3FuyAlSeggPEhXIE8Mmymd6dJ3eA8EVDl1mbtSp8HGluYLgc2SE
         RkZbukcxQ6KCGsL6AC2P1v6sbUSvdrskfrGq5m+s3tWstdqzCgXpPhCGjiFcozioJawM
         +/UA==
X-Forwarded-Encrypted: i=1; AJvYcCUtXE9KUvTP1cBCrEcrSETNAqauBpt7wMTrImtfklRz/1lg+LgvgoEoJwagbxmU1xD7/Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRNV1W58Hw/PTSvzZsH6nfWEPYhghyYgTWjgL6sWgkTwIqw7z
	YUXr5hd2rwLohf1Higi2g/SkIwKMhyTM3c2BIU5jxLm76qJIO14URX8Lr3hVYhz6vyBWaxbsvZg
	eXkqxWFvR3gZo8VQq3Md0bzV+wtH49rH5zSL67ZQeCtNZLj/lJw==
X-Gm-Gg: ASbGncsTqPMW4Ele5iNwGBgmjdTwIPgwIi2i+77JX0rA79w9tax8ynpnqUx4qU8Fp68
	6VdHXqtc3UPCWv/Q11Zq7kvkD/3JKvs2OHCLfIpH84ZeAOWAscsohGK5fEfBb+UmtxDvTI3TxYm
	WIwL2csl/drhkk8p48yv88smWvITPDmf1Xu6TUr9qPe/QarVauxA9FdnW/norZsQBZbMUF+3bdc
	o5OBKrM2Nz47UyXYm/2A4V170qlgy5IEsF/d99fD29jO+ntw023RYufk8/UHqzlhkEFV24LqWDS
	0CVpJqvm74cCugRM07sjaUxh
X-Received: by 2002:ad4:5d67:0:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6df9b2ddc47mr93343516d6.38.1736391531524;
        Wed, 08 Jan 2025 18:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8F26SDt9kWzWyiiVXPGyfA8qhPJ7dVkXTBFp4iIK0r7U36zgqIGyTW56bJleAeprnKZqCIQ==
X-Received: by 2002:ad4:5d67:0:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6df9b2ddc47mr93342976d6.38.1736391530783;
        Wed, 08 Jan 2025 18:58:50 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5ac1sm196220196d6.120.2025.01.08.18.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 18:58:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7f1c3db7-a958-4bb5-b552-a20fb5b60a2e@redhat.com>
Date: Wed, 8 Jan 2025 21:58:46 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for
 CONFIG_PARAVIRT
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Waiman Long <llong@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, Kernel Team <kernel-team@meta.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-13-memxor@gmail.com>
 <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com>
 <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
 <dfbaf200-7c87-41b2-ab87-906cbdf3e0d7@redhat.com>
 <CAADnVQJdPNOOXzQvTTx_i4yYYAoOKe=u7yHJiRHSt8O13vp6VA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJdPNOOXzQvTTx_i4yYYAoOKe=u7yHJiRHSt8O13vp6VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/8/25 9:42 PM, Alexei Starovoitov wrote:
> On Wed, Jan 8, 2025 at 4:48 PM Waiman Long <llong@redhat.com> wrote:
>> Is the intention to only replace raw_spinlock_t by rqspinlock but never
>> spinlock_t?
> Correct. We brainstormed whether we can introduce resilient mutex
> for sleepable context, but it's way out of scope and PI
> considerations are too complex to think through.
> rqspinlock is a spinning lock, so it's a replacement for raw_spin_lock
> and really only for bpf use cases.
Thank for the confirmation. I think we should document the fact that 
rqspinlock is a replacement for raw_spin_lock only in the rqspinlock.c 
file to prevent possible abuse in the future.
>
> We considered placing rqspinlock.c in kernel/bpf/ directory
> to discourage any other use beyond bpf,
> but decided to keep in kernel/locking/ only because
> it's using mcs_spinlock.h and qspinlock_stat.h
> and doing #include "../locking/mcs_spinlock.h"
> is kinda ugly.
>
> Patch 16 does:
> +++ b/kernel/locking/Makefile
> @@ -24,6 +24,9 @@  obj-$(CONFIG_SMP) += spinlock.o
>   obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
>   obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
>   obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
> +ifeq ($(CONFIG_BPF_SYSCALL),y)
> +obj-$(CONFIG_QUEUED_SPINLOCKS) += rqspinlock.o
> +endif
>
> so that should give enough of a hint that it's for bpf usage.
>
>> As for the locking semantics allowed by the BPF verifier, is it possible
>> to enforce the strict locking rules for PREEMPT_RT kernel and use the
>> relaxed semantics for non-PREEMPT_RT kernel. We don't want the loading
>> of an arbitrary BPF program to break the latency guarantee of a
>> PREEMPT_RT kernel.
> Not really.
> root can load silly bpf progs that take significant
> amount time without abusing spinlocks.
> Like 100k integer divides or a sequence of thousands of calls to map_update.
> Long runtime of broken progs is a known issue.
> We're working on a runtime termination check/watchdog that
> will detect long running progs and will terminate them.
> Safe termination is tricky, as you can imagine.

Right.

In that case, we just have to warn users that they can load BPF prog at 
their own risk and PREEMPT_RT kernel may break its latency guarantee.

Thanks,
Longman


