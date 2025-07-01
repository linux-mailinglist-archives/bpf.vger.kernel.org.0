Return-Path: <bpf+bounces-62010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D5AF0527
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721464A5C81
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1D2FEE3B;
	Tue,  1 Jul 2025 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WozWKzXg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558728B3FD
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403273; cv=none; b=lwlSJnu3+Jt5CkLhR8reTaojKhofWsyZdMRMkWLIYVshYNI8TAIOanirPJcDPNK6GBCxDIbYYdaBsigECFp/2paUbTQKdTF6ihZiwr5accPp2JYk/LY1bhgslDarKrMUHqUXdbYlm3bzYLUqopH1ayej7+s0IIrC72dVplRQqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403273; c=relaxed/simple;
	bh=or9jl/Ohve/N9Ns+oFhbe97H5vFTlvIMCpvRCGZiT2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCQJI1JeSo7N2SJmrqPoasXnpGDKxqh4N4wdl0jkn2m5p2cHqxznY/q2yDaiv52XEBf6IM0BS+2SjiKXjWdtbSXczmACO1KDn+pREUSOyHmMsPCRrVOApr7eJUBIaUweJt7dTVkWO5dKFSBu7FRJCRU9Eim+UO23bDQ3ib+rkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WozWKzXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751403270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkzVSLl4NLtygyXSuRkDZK7ij9PxQA3e+T1LkAFLCR8=;
	b=WozWKzXgDdazpdGPKCVMng/cTzAkDH0mQvntT5X5srXVhz9YzNduZsCSHzlqE9v0H8t2ka
	DCAm6+gwspULepO3V6nd0oh1DB4Cpitf/57Z1FEWBvd7wRxPSRjqnifh+1nSkyRWK6bF/E
	hPYvMT8O6z+q25lo7zIL5sexDyXOXy0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-PyCoQxkLPZKU3iRx9ft4bQ-1; Tue, 01 Jul 2025 16:54:29 -0400
X-MC-Unique: PyCoQxkLPZKU3iRx9ft4bQ-1
X-Mimecast-MFC-AGG-ID: PyCoQxkLPZKU3iRx9ft4bQ_1751403268
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0b2bbd8bfso262264166b.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 13:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751403268; x=1752008068;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkzVSLl4NLtygyXSuRkDZK7ij9PxQA3e+T1LkAFLCR8=;
        b=epk5vIdCEaRSojAfzKpuFPd2tJqqY2VInkyERw6hz+n8L3oK2woQ+V0v1ZQrK/3Wel
         QOpiQyGce0wSlnGxpwJ4UBpuYpM1nEMTxBw/sVUJfIdQeTnp9W8jbSg1arstVeAdOG35
         CqktJdIgMivYCja3GEntn4cf2q8IZ8jwx0AN4XKUa8fJHO7DheLwEYcy3J4csgUfC5CF
         SOyVcQZY86qq7otrOea2hRQhjb0sz5AStzv0g4UGYBh+1+BBf8Y9g72aZ9IdGdrnuEbp
         E/MG1B+Ei2Vg7+vEPeMV4iQpzpAx5lz33/et/VVtFTXiSDcfqt6UfS8lMg2FqGnGVzxx
         tc2w==
X-Gm-Message-State: AOJu0YwWQ5NIcx9g89s7h6ycC7g/WZPCEfn22jcm2sjMnoVCN/OJSrVd
	309a1NQZFFlf++4XsAGxePSZQAmqm4r2twqiYq/oaLTSKT7w/5yCMdiPlidnMyKb49B/4YFbedr
	+0RHQlB20TVZP7skbyPG3Vb249YDqBPb3lx7CqHtk49T+z9/K38HS
X-Gm-Gg: ASbGncuUeVMnknCh/l0oMCMt46IcEfojl6xcZi2Z7SmyO4juBL6i9GAO9jaySTkqydK
	wDIqa1WHTac9v62xwnbWbG9/EoSAZ8m1t3S4C/lgPaK0AwX/3x+6nt3GBEI+3owEzDx2S96Fmaq
	2FwLb3udUzhfYsbcggquf8OcNtrBT2hBJuwqNTYA+0WGAJ5sROFQd+MMDgbX55frftkkpGpjqp9
	RjcaTgttaIjVWm9BiFpBFltsYHBDGiNHWKMwGLspshLUjZSIGXC1JX32lDEfJ7bBB96d+ROV9ki
	FMIB0ubwRntnoEkCwNpbjaEGEInJaPar06cTysMfA/CWh6bxRxRyREdZ
X-Received: by 2002:a17:906:d54d:b0:add:f0a2:d5d8 with SMTP id a640c23a62f3a-ae3c2a6c6d1mr27264666b.11.1751403268037;
        Tue, 01 Jul 2025 13:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9pHcvDapvJkHtHElALCVoC7Goh+kJdXnChSWYrw2+rmPmL55N4/Av4SzRkF5hqufXSaOUxw==
X-Received: by 2002:a17:906:d54d:b0:add:f0a2:d5d8 with SMTP id a640c23a62f3a-ae3c2a6c6d1mr27262366b.11.1751403267584;
        Tue, 01 Jul 2025 13:54:27 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca201asm942629366b.150.2025.07.01.13.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 13:54:27 -0700 (PDT)
Message-ID: <36400b83-1a6f-4da0-9561-073bd268c58e@redhat.com>
Date: Tue, 1 Jul 2025 22:54:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] selftests/bpf: Re-add kfunc declarations to qdisc
 tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgense?=
 =?UTF-8?Q?n?= <toke@redhat.com>, Feng Yang <yangfeng@kylinos.cn>
References: <20250630133524.364236-1-vmalik@redhat.com>
 <CAADnVQJF8-8zHV75Cf7v8XWGVrJwU5JaQjBm0B-Q3JUUMqNmcQ@mail.gmail.com>
 <49fcc6c3-8075-4134-bdbd-fbd8a40f4202@redhat.com>
 <CAADnVQKQTLDP1W1ao-mCPfLDbZWykW1TdcouJPSVapNWu=bCBw@mail.gmail.com>
 <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzaM9_RbUfi2Gk-=_2D3OC8GiDS-vT5-9CHOd07r=+wyeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 22:28, Andrii Nakryiko wrote:
> On Tue, Jul 1, 2025 at 12:50 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Jul 1, 2025 at 12:43 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> On 7/1/25 19:46, Alexei Starovoitov wrote:
>>>> On Mon, Jun 30, 2025 at 6:35 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>>
>>>>> BPF selftests compilation fails on systems with CONFIG_NET_SCH_BPF=n.
>>>>> The reason is that qdisc-related kfuncs are included via vmlinux.h but
>>>>> when qdisc is disabled, they are not defined and do not appear in
>>>>> vmlinux.h.
>>>>
>>>> Yes and that's expected behavior. It's not a bug.
>>>> That's why we have CONFIG_NET_SCH_BPF=y in
>>>> selftests/bpf/config
>>>> and CI picks it up automatically.
>>>>
>>>> If we add these kfuncs to bpf_qdisc_common.h where would we
>>>> draw the line when the kfuncs should be added or not ?
>>>
>>> I'd say that we should add kfuncs which are only included in vmlinux.h
>>> under certain configurations. Obviously stuff like CONFIG_BPF=y can be
>>> presumed but there're tons of configs options which may be disabled on a
>>> system and it still makes sense to compile and run at least a part of
>>> test_progs on them.
>>>
>>>> Currently we don't add any new kfuncs, since they all
>>>> should be in vmlinux.h
>>>
>>> This way, we're preventing people to build and therefore run *any*
>>> test_progs on systems which do not have all the configs required in
>>> selftests/bpf/config. Running selftests on such systems may reveal bugs
>>> not captured by the CI so I think that it may be eventually beneficial
>>> for everyone.
>>
>> Not quite. What's stopping people to build selftests
>> with 'make -k' ?
>> Some bpf progs will not compile, but test_progs binary will be built and
>> it will run the rest of the tests.

I don't think test_progs will be built if some of the objects from
progs/ do not build. I just tried to run `make -k` on a kernel with
CONFIG_NET_SCH_BPF=n. The compilation finished, some test binaries
exist, but not test_progs.

In addition, we generally don't want to ignore all the errors as some of
them may be important.

>>
>> We can take this patch, but let's define the rules for adding
>> kfuncs explicitly.
> 
> Note, we have a VMLINUX_H argument that can be passed into BPF
> selftests' makefile. We used to use this for libbpf CI to build latest
> selftests against (very) old kernels, and it worked well.
> 
> I don't think we need to make exceptions for a few kfuncs, all it
> takes is to have vmlinux.h generated from kernel image built from
> proper configuration.
> 
> Also note, that "proper configuration" only applies to *built* kernel,
> not the actually running host kernel. See how VMLINUX_BTF_PATHS is
> defined and handled: host kernel is the last thing we use for
> vmlinux.h generation, only if all other options are unavailable.

This is a good point but the problem here is the extra kernel build. If
you want to check that BPF in your kernel is working properly, you don't
want to do another kernel build with a different config just for the
sake of being able to build selftests.

>> What are you proposing exactly ?
>> Anything that is gated by some CONFIG_FOO _must_ be added explicitly ?
>> Assuming we won't be going back and retroactively adding them ?

Yes, exactly like that. Except for this qdisc one, we haven't run into
any issues for a long time, so I don't think that it's necessary to
retroactively add the kfuncs.

But if you prefer to have it unified, I can take some time to clean it
up - add config-gated kfuncs where they are missing and replace
universally-available kfuncs by vmlinux.h.


