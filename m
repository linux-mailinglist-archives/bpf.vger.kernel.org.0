Return-Path: <bpf+bounces-39098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578C96E8F5
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 07:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE71C23704
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A4C53370;
	Fri,  6 Sep 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNlT0fVq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F81FDD
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599076; cv=none; b=RyMDglxaHx3bUg1f+0jH3v78lIAitYiXTrvHmVHAHjC+HKViVDf6H1spGDKIYVMX8DDmDHgd5YGNzBsPMygpVQ6fgbJPsV+XVoSTTHNqGWWz8oCTOps4P9jOd/TBxvr/ewT9W9Qmng2R5SHdxB3Pi7JCdF01VbnREgvCKJPdkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599076; c=relaxed/simple;
	bh=r3Nb8D9HjinJs8U35uyCQDqxVjHw3mTkcYJw1oi5jr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMWylvX6hTXNxs/jA2kEzqDTjjDrGE9afRLyAMgNIW2w11JcwLdKtR2M9O2zOET40Bhn4clxRKtNeY/Ha08F8wGweGydUWG7kgchKf9hy112yHLXCIrmDuAQj7fq6w5xgXZ2lK6QFHJiP45y0kyTbe5l+9Vo4k7eXez9jjY25Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNlT0fVq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725599073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdELk6mqPFKb3/4jPzyDqVmbC74OBnHNGVVKuPELWUw=;
	b=VNlT0fVqpXlfvkJfIRXlgwVo0PjjiwoG66bHhJNUR2JEcXOGmebdFvyIydzRw4FaJD3bOt
	qbW7UhTpvdXZ5y9+qcxNMvhe+b0B6FVYANi7jlmn3S/7/tyZYJHMHTlc/lWh5YFABTBZgf
	pvy2FIhxJAmYuGNmKrgptOhY0BOoNLc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-0UzggNCeMHanrFdPahN-dg-1; Fri, 06 Sep 2024 01:04:32 -0400
X-MC-Unique: 0UzggNCeMHanrFdPahN-dg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8711c48990so165711366b.2
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 22:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725599072; x=1726203872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdELk6mqPFKb3/4jPzyDqVmbC74OBnHNGVVKuPELWUw=;
        b=RplJFEj+4XG7juaAmZWLio8UtPKIcw323XaxaAykUns67R1N8LvTfW1YxntojOSzmn
         gcTqHuKZywNYPABx3ms4MzS3tPQPmvTrXRAL9I/HiVSOOsaK9mlAWsalbyBtZII4BuMm
         KBeEaDj0y2VW3pG/8QFA3SyesqhaSHNTrk93BSgjyD7qZRBQ3BTMC6lPxOO1erO9KbYp
         nK1nuyL8uoRceG7hJZ1iyFy769K1dj5rrZ/bkMaPfb3RS60xQwWzAcqeKpmmTPOcM7rw
         p90fJIhJ/w253gYZ3ekB7p0mhk9h2rFq40rbM4YE0pCXC41YsoNDWsQRjhsWg0Tkl0Ak
         xDPw==
X-Forwarded-Encrypted: i=1; AJvYcCUNtpsvih2wTxzuyQOirL8ckOVc+hrq1gpgbkg15+g2h4GVrjk+p3CIMKptraDFFHRcfeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVreunGgPzibuczhzPcDYZUbZ7796O4zdMPgCx+vDc1zKgEv2
	xX0jj2vssJEaxI2m/dGzQ90VJcBfOT/zRvk2zV0OCkSG+4gAzSolHE9mYivefEnhdWHK4/Igws0
	L5VaN2hfKK5u0JJteEM+ZecwvihqSo6J2rszKt9xYmD0vgoBs
X-Received: by 2002:a17:907:6d28:b0:a86:a9a4:69fa with SMTP id a640c23a62f3a-a897fa72317mr2152743466b.43.1725599071522;
        Thu, 05 Sep 2024 22:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWr/GuxOQpkqlr9UCFORZaJjsigKuAxPgmhCYtXU8anuvT2lZChnT2WEsudzqV1zN4Ozh5hg==
X-Received: by 2002:a17:907:6d28:b0:a86:a9a4:69fa with SMTP id a640c23a62f3a-a897fa72317mr2152738066b.43.1725599070446;
        Thu, 05 Sep 2024 22:04:30 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a764794c9sm152326466b.1.2024.09.05.22.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 22:04:29 -0700 (PDT)
Message-ID: <b157f640-98d0-4be1-ac30-35800032d094@redhat.com>
Date: Fri, 6 Sep 2024 07:04:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1725016029.git.vmalik@redhat.com>
 <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
 <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com>
 <CAADnVQLmo0sOCuF598nL_xoowMDwTEXzjHareG1xiWGPLM77qA@mail.gmail.com>
 <CAEf4Bza=i15HZoZHyvGJrPdqUPbNxEGG5QWTDJKFnbOcT-jPZw@mail.gmail.com>
Content-Language: en-US
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CAEf4Bza=i15HZoZHyvGJrPdqUPbNxEGG5QWTDJKFnbOcT-jPZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/24 21:07, Andrii Nakryiko wrote:
> On Tue, Sep 3, 2024 at 1:19 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Sep 2, 2024 at 10:57 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> On 9/2/24 19:01, Alan Maguire wrote:
>>>> On 02/09/2024 07:58, Viktor Malik wrote:
>>>>> TL;DR
>>>>>
>>>>> This adds libbpf support for creating multiple BPF programs having the
>>>>> same instructions using symbol aliases.
>>>>>
>>>>> Context
>>>>> =======
>>>>>
>>>>> bpftrace has so-called "wildcarded" probes which allow to attach the
>>>>> same program to multple different attach points. For k(u)probes, this is
>>>>> easy to do as we can leverage k(u)probe_multi, however, other program
>>>>> types (fentry/fexit, tracepoints) don't have such features.
>>>>>
>>>>> Currently, what bpftrace does is that it creates a copy of the program
>>>>> for each attach point. This naturally results in a lot of redundant code
>>>>> in the produced BPF object.
>>>>>
>>>>> Proposal
>>>>> ========
>>>>>
>>>>> One way to address this problem would be to use *symbol aliases*. In
>>>>> short, they allow to have multiple symbol table entries for the same
>>>>> address. In bpftrace, we would create them using llvm::GlobalAlias. In
>>>>> C, it can be achieved using compiler __attribute__((alias(...))):
>>>>>
>>>>>     int BPF_PROG(prog)
>>>>>     {
>>>>>         [...]
>>>>>     }
>>>>>     int prog_alias() __attribute__((alias("prog")));
>>>>>
>>>>> When calling bpf_object__open, libbpf is currently able to discover all
>>>>> the programs and internally does a separate copy of the instructions for
>>>>> each aliased program. What libbpf cannot do, is perform relocations b/c
>>>>> it assumes that each instruction belongs to a single program only. The
>>>>> second patch of this series changes relocation collection such that it
>>>>> records relocations for each aliased program. With that, bpftrace can
>>>>> emit just one copy of the full program and an alias for each target
>>>>> attach point.
>>>>>
>>>>> For example, considering the following bpftrace script collecting the
>>>>> number of hits of each VFS function using fentry over a one second
>>>>> period:
>>>>>
>>>>>     $ bpftrace -e 'kfunc:vfs_* { @[func] = count() } i:s:1 { exit() }'
>>>>>     [...]
>>>>>
>>>>> this change will allow to reduce the size of the in-memory BPF object
>>>>> that bpftrace generates from 60K to 9K.
> 
> Tbh, I'm not too keen on adding this aliasing complication just for
> this. It seems a bit too intrusive for something so obscure.
> 
> retsnoop doesn't need this and bypasses the issue by cloning with
> bpf_prog_load(), can bpftrace follow the same model? If we need to add
> some getters to bpf_program() to make this easier, that sounds like a
> better long-term investment, API-wise.

Yes, as I already mentioned, it should be possible to use cloning via
bpf_prog_load(). The aliasing approach just seemed simpler from tool's
perspective - you just emit one alias for each clone and libbpf takes
care of the rest. But I admit that I anticipated the change to be much
simpler than it turned out to be.

Let me try add the cloning and I'll see if we could add something to
libbpf to make it simpler.

> 
>>>>>
>>>>> For reference, the bpftrace PoC is in [1].
>>>>>
>>>>> The advantage of this change is that for BPF objects without aliases, it
>>>>> doesn't introduce any overhead.
>>>>>
>>>>
>>>> A few high-level questions - apologies in advance if I'm missing the
>>>> point here.
>>>>
>>>> Could bpftrace use program linking to solve this issue instead? So we'd
>>>> have separate progs for the various attach points associated with vfs_*
>>>> functions, but they would all call the same global function. That
>>>> _should_ reduce the memory footprint of the object I think - or are
>>>> there issues with doing that?
>>>
>>> That's a good suggestion, thanks! We added subprograms to bpftrace only
>>> relatively recently so I didn't really think about this option. I'll
>>> definitely give it a try as it could be even more efficient.
>>>
>>>> I also wonder if aliasing helps memory
>>>> footprint fully, especially if we end up with separate copies of the
>>>> program for relocation purposes; won't we have separate copies in-kernel
>>>> then too? So I _think_ the memory utilization you're concerned about is
>>>> not what's running in the kernel, but the BPF object representation in
>>>> bpftrace; is that right?
>>>
>>> Yes, that is correct. libbpf will create a copy of the program for each
>>> symbol in PROGBITS section that it discovers (including aliases) and the
>>> copies will be loaded into kernel.
>>>
>>> It's mainly the footprint of the BPF object produced by bpftrace that I
>>> was concerned about. (The reason is that we work on ahead-of-time
>>> compilation so it will directly affect the size of the pre-compiled
>>> binaries). But the above solution using global subprograms should reduce
>>> the in-kernel footprint, too, so I'll try to add it and see if it would
>>> work for bpftrace.
>>
>> I think it's a half solution, since prog will be duplicated anyway and
>> loaded multiple times into the kernel.
>>
>> I think it's better to revive this patch sets:
>>
>> v1:
>> https://lore.kernel.org/bpf/20240220035105.34626-1-dongmenglong.8@bytedance.com/
>>
>> v2:
>> https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@bytedance.com/
>>
>> Unfortunately it went off rails, because we went deep into trying
>> to save bpf trampoline memory too.
>>
> 
> +1 to adding multi-attach fentry, even if it will have to duplicate trampolines

That would resolve fentry but the same problem still exists for (raw)
tracepoints. In bpftrace, you may want to do something like
`tracepoint:syscalls:sys_enter_* { ... }` and at the moment, we still
need to the cloning in such case.

But still, it does solve a part of the problem and could be useful for
bpftrace to reduce the memory footprint for wildcarded fentry probes.
I'll try to find some time to give this a shot (unless someone beats me
to it).

Viktor

> 
>> I think it can still land.
>> We can load fentry program once and attach it in multiple places
>> with many bpf links.
>> That is still worth doing.
> 
> This part I'm confused about, but we can postpone discussion until
> someone actually works on this.
> 
>>
>> I think it should solve retsnoop and bpftrace use cases.
>> Not perfect, since there will be many trampolines, but still an improvement.
>>
> 
> retsnoop is fine already through bpf_prog_load()-based cloning, but
> faster attachment for fentry/fexit would definitely help.
> 


