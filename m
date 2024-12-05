Return-Path: <bpf+bounces-46141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADBA9E51AE
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3BD188013B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041191D63CE;
	Thu,  5 Dec 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLuVkVE0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AA1D63C5
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392085; cv=none; b=CC+wb96rtpSCVompicTcQEvnipRduXvlAJsMkwcjH1eEGSXgg/7veZX9KZ/lKhv9wRT7GNSq8oaF3iTWEUIoV6StI5QJUoxhWSfza0l+AywflTO6+r9v3u+DgVbZywYDVlqN83q7Ke6ntTRiwE/VkI5Ys5RBgE7JhhA3EpNRI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392085; c=relaxed/simple;
	bh=uVGgeVDBxYjHDuussMzRiLAh79nE+0V1GomXq/8gLoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFZukyGZK2AgS1V/4AVjxB9LbBGor3uhFN8OnyflVlCzf1KvNIiBGBNvi1JW2Sz2FVnftkG0xe55uDm2VwEnH/N9iG0vzYncBcAhH1nst2VX7yFCYVjcUGRdUEqLC1KTENCw2DwCiOuF8LloIEH85I7JCGL1AQGbJWmdatd6UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=unknown smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLuVkVE0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733392083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVGgeVDBxYjHDuussMzRiLAh79nE+0V1GomXq/8gLoY=;
	b=PLuVkVE0OPMV+fBwuq0mhuow36tmcpnwojBYChx2m+vhyI8L/gpTIaocFlrYichQpa4TsL
	7heZeIR5456Ga2UA8EVYkv4lElqDlYeqzIoOZOoChvpjizr4fuJKjOfpZ7ecDGalLES9bI
	/9ewKkJcqJIk3UuY19WPkdMxWty+mD0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-8fTJ6xcANUGnwYVpmXoxdQ-1; Thu, 05 Dec 2024 04:48:01 -0500
X-MC-Unique: 8fTJ6xcANUGnwYVpmXoxdQ-1
X-Mimecast-MFC-AGG-ID: 8fTJ6xcANUGnwYVpmXoxdQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so6853455e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 01:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392080; x=1733996880;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVGgeVDBxYjHDuussMzRiLAh79nE+0V1GomXq/8gLoY=;
        b=Ue5jwA7vVidq1Qoc+20Wvg3M/s6lW5h/DRRsWMz90WnEZCSjcNgeo7wNTfC6ZuLNKg
         Fr0hJ0CULPy/m53enQxNm50oxDL/rOfNQo6ARF06+eK27hltKjNoY/Z79wRh4iLVOKU4
         3m0PjQjtG2IWaymqYEsqd5vbLt34mdwrQXtrVrVM3PdAeltv3HhMmvzq8R0tHdZkb/l8
         hnrJJgT6PuqlTdXXE0/kJKD/qMKY6N83Ll3wvpUHHLCtD6iHnW+lcEM3KVPR1rHP2kG0
         RFZO83Gb7IDbo9XZCGyGfiwDvabOVBYmXjBp7HVGZxy/6/IlEHzd+6TzPza2Y+DqHHcC
         EujQ==
X-Gm-Message-State: AOJu0YwUKhmEMfLuyuRyeO7oHqXND03OhYUGcVM7DrtuJGC63T4N8Z7R
	IdyzhjNE5wCfrBGEvJHfzNMW7zmr3r/KvcU/cLl2eE7xfRDc64nnrLWVZyCz2z7DivyRN+PWEG+
	c/V2KCoT0pV3f8bk9oXscyN8Tb8LOFoaz7gCsfmPmB+nJB8bb8w==
X-Gm-Gg: ASbGncv3vsuzSoOUUrDhvNMFTj25/O4ZTs5d16OUy9K8RH+Lbl2HaWZV0AE8yV6sn1w
	a7TgRnzlilOoecUhSXn/v1SqFHLSUeM23ssEYsNxqWIRSYb7Djtq9ugmTK6a02D73o+G1J9chFI
	rhkp9z8pi/cD/EDmO+RBEYycFoC0NBHUmf0n0bXTiL76C7XemkX/BQTsvA9PC+qXncIPbLpejb7
	G2S0cHu7VIhrT1HJO39hk0JsgY0XmTGfi2a8yGr9sUPjl4jXiqOIEirrZ4VwLlG5bmO/97it+o=
X-Received: by 2002:a5d:47cb:0:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-385fd3f29dfmr10719404f8f.26.1733392080704;
        Thu, 05 Dec 2024 01:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd3qm4HamJYbDTLT/dnyi2aARKNXmesx3QQ69Ih5iZbpuczWq2OT6s9UvoqGnOaN/pomD8Gg==
X-Received: by 2002:a5d:47cb:0:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-385fd3f29dfmr10719358f8f.26.1733392080283;
        Thu, 05 Dec 2024 01:48:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ae4f3sm67119066b.159.2024.12.05.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:47:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B7B6616BD2B6; Thu, 05 Dec 2024 10:47:58 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Hou Tao
 <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
In-Reply-To: <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
 <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com>
 <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Dec 2024 10:47:58 +0100
Message-ID: <878qsua2b5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> Hi,
>
> On 12/3/2024 9:42 AM, Alexei Starovoitov wrote:
>> On Fri, Nov 29, 2024 at 4:18=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> After switching from kmalloc() to the bpf memory allocator, there will=
 be
>>>> no blocking operation during the update of LPM trie. Therefore, change
>>>> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable in
>>>> atomic context, even on RT kernels.
>>>>
>>>> The max value of prefixlen is 2048. Therefore, update or deletion
>>>> operations will find the target after at most 2048 comparisons.
>>>> Constructing a test case which updates an element after 2048 compariso=
ns
>>>> under a 8 CPU VM, and the average time and the maximal time for such
>>>> update operation is about 210us and 900us.
>>> That is... quite a long time? I'm not sure we have any guidance on what
>>> the maximum acceptable time is (perhaps the RT folks can weigh in
>>> here?), but stalling for almost a millisecond seems long.
>>>
>>> Especially doing this unconditionally seems a bit risky; this means that
>>> even a networking program using the lpm map in the data path can stall
>>> the system for that long, even if it would have been perfectly happy to
>>> be preempted.
>> I don't share this concern.
>> 2048 comparisons is an extreme case.
>> I'm sure there are a million other ways to stall bpf prog for that long.
>
> 2048 is indeed an extreme case. I would do some test to check how much
> time is used for the normal cases with prefixlen=3D32 or prefixlen=3D128.

That would be awesome, thanks!

-Toke


