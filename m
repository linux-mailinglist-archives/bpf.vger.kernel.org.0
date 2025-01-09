Return-Path: <bpf+bounces-48356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B544A06C96
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5DA3A50F0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319C157465;
	Thu,  9 Jan 2025 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDOnJAEi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93934142E86
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736395120; cv=none; b=qLhYkjjHcvazyxebyxglbhzeLCPAdqp3rZCA9rjkxjlCVboHZX8hy5GlXujVmNCnBNXtFsv6b/ZGhxGuiGvYfdQZY45N1d7ljjHG5z2FnKR6DHdxMf5ylGs/mlPjlCfVcZS6cJ8MYW6UXK9aREY3PUTCVCkGQZhnsZCvKnpuMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736395120; c=relaxed/simple;
	bh=NR7bujAqHByOJPgv11DJR1ebHw/wXTjmQOE+N8LB4Q0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DLftCmG0MT3baXXrzhmH3TxgP60j6x/hZbS0w5dzR4qOzFki2XDvc8gyb+JUYi4OTRVLI/wLSAi+97mWtoy8Z6Ey+IIHtDtNbLT8PxrC8Ju2lCaiW630stsXxoglS583tO6OjjhxRPtBAzgKIodP6mTA0+9Gom6akxwwvf/d3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDOnJAEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736395117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pK++yYVT6YtXhoG4NvKGkp/wRr7NgbDUOx7+AP4EMJE=;
	b=NDOnJAEi0T+4d9an0YmMM399QN1ny7s8GolmOCCpwS4n6Hp3jsiOCmjNfbCAE6HjojFTV6
	PatL3hmHN0Tc/PDuMYxt8abiFBy6rGVk6uzrcnxLcShSAw1XXH7ZGjYdvHAgmCkFR+DMpw
	4KmSQsEJKSDIsBEwqXKcaLQfCaHtV48=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-vVgswtTHPF2wrZeiZVgkcQ-1; Wed, 08 Jan 2025 22:58:36 -0500
X-MC-Unique: vVgswtTHPF2wrZeiZVgkcQ-1
X-Mimecast-MFC-AGG-ID: vVgswtTHPF2wrZeiZVgkcQ
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b9e433351dso101545985a.3
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 19:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736395116; x=1736999916;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK++yYVT6YtXhoG4NvKGkp/wRr7NgbDUOx7+AP4EMJE=;
        b=jtoRfDudzDC93O1UwNIKBi8n9ZhAi+03YW7JJpKsRrmYidp82Lm4sQWKgLHS1rYJ3q
         hfIcj8hqUQUbn8/ErjUqdrGWv6Ei5AwW+28w5CA3EP6Aha+bwyVspni3qjx7BrlNrkU+
         CvU/QZ8CJGT4Bpp0spW7HvjzSM85CpV0Zphj1Bgy40b+hyQtrHdAcLIsZe5YwG6/HowU
         CQLv0JLbXEG+Vp0HpwNR41oRUO13xEmWwlPMX65kmC5yMkgVvYEGAD8sgHF6QG4Fs2uA
         LyqhszgEJTnWkc/mTsbqaq2lPmwcWMKY/+aD+ldeoqz6rFnODaH7QCsG75gYOZvVNz4A
         sbRA==
X-Forwarded-Encrypted: i=1; AJvYcCV9tojKACrwILWNS0YLotFuxGsrptE+rUeod0nsgPRwBcgLXLV8ZiCIwlM5BJokdfvaXxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jRNJMq5GOWHWZeJf7H1zk36DpULiCQo4Rg/S75SRK/rmfwgc
	T6EXeyvEjdlCsH7nVND9YUbWz60E68wpUP0Os+o9vAnLWEytq2sGyL5REG/ut6wCtyIGQZNV3J9
	HjkA5pRQzspeSyXIaCzxwRcuU7IDaKt/0hicJsnUD8I8T0VIcfQ==
X-Gm-Gg: ASbGncultNOxnUPSIcvuI/lpESpD6i2szk6VmW2Hu2q/NKGz5KhIwxcUSD7Rydl1maJ
	8i92YZmQ6F4fIgVrd9Ipgpilas/y6r2a2lvOpXSj6W2PPE7wojEdJbUyj+otCarQ3r8TD06AY4x
	opwPTmnW/i60Pid1bz1JKKs5rN3RJQa5Qh3YDnK264j4x/Kl4ZeAt+tidfHZtXa7yWF1TzJDW+z
	UBfRpMlj/uftfufWakTOzYGxaLpO0B7bsIki041Uidy3zFCUL1SlaI/9Qq80y05ZkzKH+vTCDtf
	/v0VV36gPDaS9U3Bb0SCrD+P
X-Received: by 2002:a05:6214:4111:b0:6d8:8416:9c54 with SMTP id 6a1803df08f44-6df9b1ed60bmr89974536d6.16.1736395115908;
        Wed, 08 Jan 2025 19:58:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeiTIkUAMhBgbC1EMxAjdJqJuyV96iwPVTqvaKJnAuAR/ttOD8+tajoUO11gY6Ulv+C63/YA==
X-Received: by 2002:a05:6214:4111:b0:6d8:8416:9c54 with SMTP id 6a1803df08f44-6df9b1ed60bmr89974456d6.16.1736395115667;
        Wed, 08 Jan 2025 19:58:35 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180ea82fsm196829446d6.26.2025.01.08.19.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 19:58:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <745d8edc-d621-41a0-a18f-827989d55738@redhat.com>
Date: Wed, 8 Jan 2025 22:58:32 -0500
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
 <7f1c3db7-a958-4bb5-b552-a20fb5b60a2e@redhat.com>
 <CAADnVQ+_eBZo5yTWpEd2pdv-dd3x=KEbqU=8awbyW3=9wm9nUA@mail.gmail.com>
 <0c239aaf-ad07-4be2-a608-0d484bc7fe95@redhat.com>
 <CAADnVQKDg3=cKmjqrQ7YraaW6STckj_w=1yU4oDZ7T+miMvgpA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKDg3=cKmjqrQ7YraaW6STckj_w=1yU4oDZ7T+miMvgpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/25 10:53 PM, Alexei Starovoitov wrote:
> On Wed, Jan 8, 2025 at 7:46 PM Waiman Long <llong@redhat.com> wrote:
>>>>>> As for the locking semantics allowed by the BPF verifier, is it possible
>>>>>> to enforce the strict locking rules for PREEMPT_RT kernel and use the
>>>>>> relaxed semantics for non-PREEMPT_RT kernel. We don't want the loading
>>>>>> of an arbitrary BPF program to break the latency guarantee of a
>>>>>> PREEMPT_RT kernel.
>>>>> Not really.
>>>>> root can load silly bpf progs that take significant
>>>>> amount time without abusing spinlocks.
>>>>> Like 100k integer divides or a sequence of thousands of calls to map_update.
>>>>> Long runtime of broken progs is a known issue.
>>>>> We're working on a runtime termination check/watchdog that
>>>>> will detect long running progs and will terminate them.
>>>>> Safe termination is tricky, as you can imagine.
>>>> Right.
>>>>
>>>> In that case, we just have to warn users that they can load BPF prog at
>>>> their own risk and PREEMPT_RT kernel may break its latency guarantee.
>>> Let's not open this can of worms.
>>> There will be a proper watchdog eventually.
>>> If we start to warn, when do we warn? On any bpf program loaded?
>>> How about classic BPF ? tcpdump and seccomp ? They are limited
>>> to 4k instructions, but folks can abuse that too.
>> My intention is to document this somewhere, not to print out a warning
>> in the kernel dmesg log.
> Document what exactly?
> "Loading arbitrary BPF program may break the latency guarantee of PREEMPT_RT"
> ?
> That's not helpful to anyone.
> Especially it undermines the giant effort we did together
> with RT folks to make bpf behave well on RT.
> For a long time bpf was the only user of migrate_disable().
> Some of XDP bits got friendly to RT only in the last release. Etc.

OK, it is just a suggestion. If you don't think that is necessary, I am 
not going to insist. Anyway, users should thoroughly test their BPF 
program before deplolying on production systems.

Cheers,
Longman


