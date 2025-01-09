Return-Path: <bpf+bounces-48354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889E7A06C7D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798DD1646D0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A885139D0A;
	Thu,  9 Jan 2025 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUQG9oi8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC75423CE
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394372; cv=none; b=Pg432nCQ73EznaNSqtBUrSka2oLX3ePsUwWQBWn8DaK7X/n3HgDBAKysbZG2/4oeW+G7Mu0Qydz1V+nuPB0sIAtSX+fwn6vjOkZJgVDNp4VUIpompgz0qqFws85WqUcgtXLSCyNm3m3KI4bCqypv/ZDGq7NxxfNRLm9P/vhkjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394372; c=relaxed/simple;
	bh=WXVIr2digdx5p3er+7eiKKAk+PQhhNJhyV5n03pDSrQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eYQPVWKGHu15OoNXGAQyH0RyDkp+AB3syrSMOODvHVis7ZkFYmV38nIJIkuY4iovB2vUFdlhATACL0KoVKrZn3DUFirUYz3ZkdtwRRczTdRNInJTpqVrLHxabOeS6CThekrIUdsxLzj2M+y1c8l/BY/oRvgZmy2Mt5BtVM6cFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUQG9oi8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736394369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOoJqgw7H4gT9upPWqUMI30gXFp9tkLWAp3YieM9UKU=;
	b=PUQG9oi8XsFj+VTm3nene5wNc2jczggfD9J25DoVMeCVciAM3NNJPCAQbno8S/LQW7EYov
	nZ0wcpz4ruqP8v5/YHlNNhAdw6gmWpLuR1nmUmxA3CLxxkTZEvgOiNVBPk2wr93UNyFC9i
	60ToM0JZCBzETiKXmVn6tila4LOTn70=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-M31pYtglPYGz0ksZgWHTuw-1; Wed, 08 Jan 2025 22:46:08 -0500
X-MC-Unique: M31pYtglPYGz0ksZgWHTuw-1
X-Mimecast-MFC-AGG-ID: M31pYtglPYGz0ksZgWHTuw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6dfa69e6983so3455316d6.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 19:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736394368; x=1736999168;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOoJqgw7H4gT9upPWqUMI30gXFp9tkLWAp3YieM9UKU=;
        b=AgI21Z9WLjwxkStqjbHn3Os/rynSqJsLnoL4+pQ9LoremdC9VjqQvY043/MwmziJ0m
         75vC4RoiSl4DQJ067fOyHPFfx2TEsql1cQh4fE3saS25WzvvC9dmLCLFpbtnMzxBXYaF
         gEJeTKbFsyCWxHCncpWUQDWOlvc+XKmk+VH9osEp4FhgKPHw4HBfJt2odag8gsHo9xUP
         Ewz43tsG2jCYs3gekaEiUOX1fv0wW/R+GA+AuQRuOOteSSAjUP1vXwl+xyg4G9jjsnzz
         lD1c6qaun3lOTz6u2vlZXtNEAiSZ0DOOqxt9L/+GJxX+LoCWJO0fx7mOUOnp28py4+9/
         /ViQ==
X-Forwarded-Encrypted: i=1; AJvYcCU18eINAnXd4rH+p+p4sZQOCIEpZ7OF5jRb1XNRSV48QVZmKGKuTwKsXM/8gZRQxp52gA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUuAuZMcwxAPahyfvgN72brLFwzJthtz6Gq0on5POiJTbEIrC
	DgT0rtCIKCEOLnOpUC2IlLrzDanqfG+qS1JCfyBPdPN328hO5GLKvVN1bTB54e6PkVEKMXCVrn8
	OWgxJSnfSTxJ+3a8LmWijHDAbvk+zG0IphAvparaovcdqoLWKjg==
X-Gm-Gg: ASbGnctEs1h7QErR2MeErmZHDgM3XXtf2+pk0XEmzVkFOvaJPFI3vO3jJQ5MOiCrs0c
	HsF3t3JXwpVc+I53ehFhaqE7u/bQ26ZnIHvKhDsU457ZyR2EkxJX5she5j6Fn7hfJB006aZrxsw
	Uvc2/FM5UoeBiA33zMnPnA8/cdSaooa1chPu8IRt1a5NvNEzknGLXbCVvbdkwBX/oar9oez3ORb
	9rgukR0v5063x3A45wKUvtj369uH/Dl79LCbr7g2gUoQppK+TXZZufBsgVMEVvWJBXjvtxNwS9d
	SzyxmdE824shdBkTHMH8ZBPF
X-Received: by 2002:a05:6214:29e5:b0:6d4:257a:8e with SMTP id 6a1803df08f44-6df9b1f6e24mr84217196d6.4.1736394367944;
        Wed, 08 Jan 2025 19:46:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoDUb1PfWKp3bjM8S3e3J6XpvngMEjZw7EdKwSrsCt8MxnGCiP9QUPT03qVWxXQSb3A5gRHA==
X-Received: by 2002:a05:6214:29e5:b0:6d4:257a:8e with SMTP id 6a1803df08f44-6df9b1f6e24mr84217046d6.4.1736394367648;
        Wed, 08 Jan 2025 19:46:07 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd7d3bfa41sm120352076d6.99.2025.01.08.19.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 19:46:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0c239aaf-ad07-4be2-a608-0d484bc7fe95@redhat.com>
Date: Wed, 8 Jan 2025 22:46:04 -0500
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
Content-Language: en-US
In-Reply-To: <CAADnVQ+_eBZo5yTWpEd2pdv-dd3x=KEbqU=8awbyW3=9wm9nUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/25 10:37 PM, Alexei Starovoitov wrote:
> On Wed, Jan 8, 2025 at 6:58 PM Waiman Long <llong@redhat.com> wrote:
>>
>> On 1/8/25 9:42 PM, Alexei Starovoitov wrote:
>>> On Wed, Jan 8, 2025 at 4:48 PM Waiman Long <llong@redhat.com> wrote:
>>>> Is the intention to only replace raw_spinlock_t by rqspinlock but never
>>>> spinlock_t?
>>> Correct. We brainstormed whether we can introduce resilient mutex
>>> for sleepable context, but it's way out of scope and PI
>>> considerations are too complex to think through.
>>> rqspinlock is a spinning lock, so it's a replacement for raw_spin_lock
>>> and really only for bpf use cases.
>> Thank for the confirmation. I think we should document the fact that
>> rqspinlock is a replacement for raw_spin_lock only in the rqspinlock.c
>> file to prevent possible abuse in the future.
> Agreed.
>
>>> We considered placing rqspinlock.c in kernel/bpf/ directory
>>> to discourage any other use beyond bpf,
>>> but decided to keep in kernel/locking/ only because
>>> it's using mcs_spinlock.h and qspinlock_stat.h
>>> and doing #include "../locking/mcs_spinlock.h"
>>> is kinda ugly.
>>>
>>> Patch 16 does:
>>> +++ b/kernel/locking/Makefile
>>> @@ -24,6 +24,9 @@  obj-$(CONFIG_SMP) += spinlock.o
>>>    obj-$(CONFIG_LOCK_SPIN_ON_OWNER) += osq_lock.o
>>>    obj-$(CONFIG_PROVE_LOCKING) += spinlock.o
>>>    obj-$(CONFIG_QUEUED_SPINLOCKS) += qspinlock.o
>>> +ifeq ($(CONFIG_BPF_SYSCALL),y)
>>> +obj-$(CONFIG_QUEUED_SPINLOCKS) += rqspinlock.o
>>> +endif
>>>
>>> so that should give enough of a hint that it's for bpf usage.
>>>
>>>> As for the locking semantics allowed by the BPF verifier, is it possible
>>>> to enforce the strict locking rules for PREEMPT_RT kernel and use the
>>>> relaxed semantics for non-PREEMPT_RT kernel. We don't want the loading
>>>> of an arbitrary BPF program to break the latency guarantee of a
>>>> PREEMPT_RT kernel.
>>> Not really.
>>> root can load silly bpf progs that take significant
>>> amount time without abusing spinlocks.
>>> Like 100k integer divides or a sequence of thousands of calls to map_update.
>>> Long runtime of broken progs is a known issue.
>>> We're working on a runtime termination check/watchdog that
>>> will detect long running progs and will terminate them.
>>> Safe termination is tricky, as you can imagine.
>> Right.
>>
>> In that case, we just have to warn users that they can load BPF prog at
>> their own risk and PREEMPT_RT kernel may break its latency guarantee.
> Let's not open this can of worms.
> There will be a proper watchdog eventually.
> If we start to warn, when do we warn? On any bpf program loaded?
> How about classic BPF ? tcpdump and seccomp ? They are limited
> to 4k instructions, but folks can abuse that too.

My intention is to document this somewhere, not to print out a warning 
in the kernel dmesg log.

Cheers,
Longman


