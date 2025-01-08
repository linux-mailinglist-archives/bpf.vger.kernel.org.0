Return-Path: <bpf+bounces-48259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D4A061D5
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DA4188956A
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166731FECB3;
	Wed,  8 Jan 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcdDh+/Q"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7C2EAE5
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353642; cv=none; b=Zt0GDB/d9FMu/uvKbHqiHClzUod/+1HTByibm7xtug8BPwKpC35EhTmxTOp9juXuWy3etbAzID3FfYBPApVdqRd/33DJt+CqJrhS1TpFHYmS9E7vOSuItok1HCgzhgUCK93VF2cxrg+bBl+bbTVTdmy68LkkqqBlG0inHR06VTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353642; c=relaxed/simple;
	bh=UeZsfVI8/f4Y/+CVrzTXum3t7UqvjAFMBTCCCz9jcQ0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cky/ptBA0dMD/JLB8BBgUj87y5X6nItndx2jbqULKsf5QCR/G9YaxUFsbLy5rN0cOGhGdHXLPFaPJ6NWdBZ40UVOxtApNU3Qu6MdL+619bUn9+Fi/CD2BUDbXDioxokikOJjHyfEvUp+itKHeGwcsyxoJNbzOd+0rljiPMU0oZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcdDh+/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736353638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkpeSCEukM6iBxe9HuNrhpoVSaHBXeUot4e0FpvqthU=;
	b=dcdDh+/QOiJ+22UybXWYTaN+YA+kyvpeEamds4sEWbLaq3aURXMsagYNdL+6eV1SRY0++a
	5bL8lW75LybGcCe4BUQrlIk51whmGcB4s1QeOFKX4umF2MiC2VmAdD3/RFYoSeLJ+lN98C
	BWiJBKObzdB//xPMJUbpJ1nEIZybxcI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-mKVBbxLaOpq8AUB3xNRhPw-1; Wed, 08 Jan 2025 11:27:17 -0500
X-MC-Unique: mKVBbxLaOpq8AUB3xNRhPw-1
X-Mimecast-MFC-AGG-ID: mKVBbxLaOpq8AUB3xNRhPw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6eeef7c38so2760174985a.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 08:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353637; x=1736958437;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkpeSCEukM6iBxe9HuNrhpoVSaHBXeUot4e0FpvqthU=;
        b=YXSe8IIMSFIX100yatb67vfPBZTi5+uOYSkdnivrx/wCCmudB/5rm6EK23mGhkzYCH
         9+dVher9hHFo+uBNDiQvScWUYtP7ST/mOa78UJO64spAj6WLxaMTT84tNaISyfHOHw21
         pZWvFK+76XFi+RWpmfr86JBEattDs4tuEWtDHAJ2fMCThDhfefPBy9Zfmm3RK7wHI1+w
         Q24+pHqwCZ601+fd6VZae+fcGh24WLycqiclbJfmYMggAX0vJYYAfLUI5fyRlsW0bCiD
         ZkQsd1943Q1oSFuZpMFjZny42xqKJZmxxdvXapJETqSLCzruxFu5sqyJH4FQS2EofsXs
         PFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgjeGuWVPX6MKRUeJ8luPhakUvM3IKKh35fxDUlf+EuK3GOsKDeyPeZFkuSbJ0dmBchk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX82H+aE2qMyABbIB3/OLTcL86MAelmijmXLrBTC2Du40QOEay
	Hzx4hPZFarCsPG303doJCVnNbl1t3W/W7RYQsX1Fgpp3+Pf8eEj8H1Xl0myqYPuh70PSulBc47J
	TO4PAMRCw1kNxH20ixKr0Xm+u+pWrydAO39FsXDupMRJ6/615dg==
X-Gm-Gg: ASbGncv1lCyIFpwynK96SIAfHiIaKx6hH4j92T5HFok13lDNhNowW/x9OumvGc42e4R
	SCq5eIPdlpwwRi9Jgdm7G5ISdb81cxbV1HWj0iY1uIHk6A7NIwvZYZB4WIHEAzv3b7WfPKRwtJ7
	hZHMSXfCV1qYYfY9zI0G9w/Xl+XPeI/ySbgJctqqi2KFwsdSGlk5LyFlwvhNG9vQAwzVQNjjOCc
	9zZ7Vh60Sn2hcpkGAp1/j5PvJwXHid4CD67g2hsMeT80hJGUs25VumUIgdws7q7qYzTOVWjebc/
	1bodKNCrzLWgZgbzmrhWoHwZ
X-Received: by 2002:a05:620a:e94:b0:7bc:dc89:36f6 with SMTP id af79cd13be357-7bcdc893c87mr237290785a.60.1736353636990;
        Wed, 08 Jan 2025 08:27:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzvJ7DjCBIgpCPTr80qYxvGrfJg2NprZNP0WFoAZXTXH0Yn907zsYfu8LUYE21bnpl0WG3wg==
X-Received: by 2002:a05:620a:e94:b0:7bc:dc89:36f6 with SMTP id af79cd13be357-7bcdc893c87mr237278085a.60.1736353635245;
        Wed, 08 Jan 2025 08:27:15 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478df8sm1693634085a.81.2025.01.08.08.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:27:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com>
Date: Wed, 8 Jan 2025 11:27:12 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for
 CONFIG_PARAVIRT
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-13-memxor@gmail.com>
Content-Language: en-US
In-Reply-To: <20250107140004.2732830-13-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
> We ripped out PV and virtualization related bits from rqspinlock in an
> earlier commit, however, a fair lock performs poorly within a virtual
> machine when the lock holder is preempted. As such, retain the
> virt_spin_lock fallback to test and set lock, but with timeout and
> deadlock detection.
>
> We don't integrate support for CONFIG_PARAVIRT_SPINLOCKS yet, as that
> requires more involved algorithmic changes and introduces more
> complexity. It can be done when the need arises in the future.

virt_spin_lock() doesn't scale well. It is for hypervisors that don't 
support PV qspinlock yet. Now rqspinlock() will be in this category.

I wonder if we should provide an option to disable rqspinlock and fall 
back to the regular qspinlock with strict BPF locking semantics.

Another question that I have is about PREEMPT_RT kernel which cannot 
tolerate any locking stall. That will probably require disabling 
rqspinlock if CONFIG_PREEMPT_RT is enabled.

Cheers,
Longman


