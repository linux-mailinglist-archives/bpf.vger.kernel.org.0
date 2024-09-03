Return-Path: <bpf+bounces-38750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6596935A
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B49F282599
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788BA1CEAA3;
	Tue,  3 Sep 2024 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN80zuCh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF151CDFDA
	for <bpf@vger.kernel.org>; Tue,  3 Sep 2024 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343030; cv=none; b=ZUG07TuT7rXpg9aLxCo4U4Ona94Q6r7PkS87WAn2YK2a5/vuSoPhKuMSYMESbI8P3s4ue8R7hvSM0xITx8EBCXu9yKPMmynPsBNPPiDB2v69hLxWWlBVtdnJELp+a48rnEf9JI17xeAyfjoAYSUohCWIV1vcaJMDTwfefHBCiXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343030; c=relaxed/simple;
	bh=7IJ4k0xiKfJliJv5H9Xsx1fF+waaY18Cn/t0CibK23c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sd2M5KpSi4RA1TQeLK4+xeUuIer2Vt4Oq/5gnjn0Byv48Z3t+4TFrHWdzf/5gr7fCfatajrGGzFUmOHDwO8tMCzgGIwFyX7TqFYwBSsYUoT6jpuB05ZZO0Isp3ZruBpQYwo2ngtTcEkXRa0I+PNlY1jOuT0ie25cTQ/AVJY6O2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN80zuCh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725343026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OulKu+Ua+XgCDkPp2NkymMKWxKC2v6+h4jQv0cayhhc=;
	b=AN80zuChCz5UH3TNGD6BEazctw6hMEeZ2QGWCpQ5rWrzO6QExTHpaS0cSqp+Q51KOJ+IJC
	lklV0V3VhnkaxfRq+XGBUd0V2G3Z+BUCKbs6/ATJWokRJQbr4gxhgtMv5bME+DY7i0L3tw
	HTBFZxr1L0ZXzDNv8918TCsWVZhYhPA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-_eeHxlOpMUiDnUN7xQdd_g-1; Tue, 03 Sep 2024 01:57:05 -0400
X-MC-Unique: _eeHxlOpMUiDnUN7xQdd_g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334824e68dso479386e87.3
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 22:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725343023; x=1725947823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OulKu+Ua+XgCDkPp2NkymMKWxKC2v6+h4jQv0cayhhc=;
        b=QIgGTSM8rG83kwkG6iZuA/LEt3JMLfV/f2yBI50IsqXgEZQ3FKxrIxBFRFMzDHP6MQ
         dVe1Mf0PvF+8iCCES4YTkEvOYT3zWfgQN+14HjKRGKYyCtt9uspPNTh4Yh+EL3Gwjdr1
         KctoeBcBCXS4Fp7aN3UqsqQ3zwWVM34oEY3LKl14SlLyskZppGpWOUe1N8hr2XUdV6+9
         ThAYgv7mvt0yF1j960I2pBEsU5imDXIWuItAqKuQ+pqFEq7MNX7+SX3y/+c8hyI00Dyk
         JbklvLNrvfxX50jMn6vkqvg1G8wj8KIr9S0UvIF/bcDGCBnx+IrxeIyG/Xv2OEtiBWSz
         /Luw==
X-Forwarded-Encrypted: i=1; AJvYcCVeoX4mAm9Wc4jK2HeDYklOu9ZB2GvhY4T+yFhqhD6L/s/7p5tgWpPWggUuTMWr6HyaCK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2XY5ykpXsQ4stSDmB1RRSH9kGvnl8iE11r7ZtfBpUpUMl0Iw
	qe+txfF/dfUH3pNBIv/T5d2auXac34mzd++mmUGIy6Tqh4x3+z81v9FCnEffm4/4OskuH2dM2ZI
	CfbXTOaA9h5aa3kySFugnb0h47OmC/T48BlXN4t9juO2LCxiOXXiqgV5+0Zc=
X-Received: by 2002:a05:6512:10d6:b0:52e:f4b4:6ec1 with SMTP id 2adb3069b0e04-53546b69264mr7059366e87.46.1725343023147;
        Mon, 02 Sep 2024 22:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFB4qtNd5sskXSYbEcz6OMC3E0dgwIWZc4zgCajoL8m2mO3xmDW3nfusbmcZp02ggPPRLEw==
X-Received: by 2002:a05:6512:10d6:b0:52e:f4b4:6ec1 with SMTP id 2adb3069b0e04-53546b69264mr7059348e87.46.1725343022089;
        Mon, 02 Sep 2024 22:57:02 -0700 (PDT)
Received: from [192.168.0.113] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891db42fsm634412866b.184.2024.09.02.22.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 22:57:01 -0700 (PDT)
Message-ID: <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com>
Date: Tue, 3 Sep 2024 07:57:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1725016029.git.vmalik@redhat.com>
 <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 19:01, Alan Maguire wrote:
> On 02/09/2024 07:58, Viktor Malik wrote:
>> TL;DR
>>
>> This adds libbpf support for creating multiple BPF programs having the
>> same instructions using symbol aliases.
>>
>> Context
>> =======
>>
>> bpftrace has so-called "wildcarded" probes which allow to attach the
>> same program to multple different attach points. For k(u)probes, this is
>> easy to do as we can leverage k(u)probe_multi, however, other program
>> types (fentry/fexit, tracepoints) don't have such features.
>>
>> Currently, what bpftrace does is that it creates a copy of the program
>> for each attach point. This naturally results in a lot of redundant code
>> in the produced BPF object.
>>
>> Proposal
>> ========
>>
>> One way to address this problem would be to use *symbol aliases*. In
>> short, they allow to have multiple symbol table entries for the same
>> address. In bpftrace, we would create them using llvm::GlobalAlias. In
>> C, it can be achieved using compiler __attribute__((alias(...))):
>>
>>     int BPF_PROG(prog)
>>     {
>>         [...]
>>     }
>>     int prog_alias() __attribute__((alias("prog")));
>>
>> When calling bpf_object__open, libbpf is currently able to discover all
>> the programs and internally does a separate copy of the instructions for
>> each aliased program. What libbpf cannot do, is perform relocations b/c
>> it assumes that each instruction belongs to a single program only. The
>> second patch of this series changes relocation collection such that it
>> records relocations for each aliased program. With that, bpftrace can
>> emit just one copy of the full program and an alias for each target
>> attach point.
>>
>> For example, considering the following bpftrace script collecting the
>> number of hits of each VFS function using fentry over a one second
>> period:
>>
>>     $ bpftrace -e 'kfunc:vfs_* { @[func] = count() } i:s:1 { exit() }'
>>     [...]
>>
>> this change will allow to reduce the size of the in-memory BPF object
>> that bpftrace generates from 60K to 9K.
>>
>> For reference, the bpftrace PoC is in [1].
>>
>> The advantage of this change is that for BPF objects without aliases, it
>> doesn't introduce any overhead.
>>
> 
> A few high-level questions - apologies in advance if I'm missing the
> point here.
> 
> Could bpftrace use program linking to solve this issue instead? So we'd
> have separate progs for the various attach points associated with vfs_*
> functions, but they would all call the same global function. That
> _should_ reduce the memory footprint of the object I think - or are
> there issues with doing that? 

That's a good suggestion, thanks! We added subprograms to bpftrace only
relatively recently so I didn't really think about this option. I'll
definitely give it a try as it could be even more efficient.

> I also wonder if aliasing helps memory
> footprint fully, especially if we end up with separate copies of the
> program for relocation purposes; won't we have separate copies in-kernel
> then too? So I _think_ the memory utilization you're concerned about is
> not what's running in the kernel, but the BPF object representation in
> bpftrace; is that right?

Yes, that is correct. libbpf will create a copy of the program for each
symbol in PROGBITS section that it discovers (including aliases) and the
copies will be loaded into kernel.

It's mainly the footprint of the BPF object produced by bpftrace that I
was concerned about. (The reason is that we work on ahead-of-time
compilation so it will directly affect the size of the pre-compiled
binaries). But the above solution using global subprograms should reduce
the in-kernel footprint, too, so I'll try to add it and see if it would
work for bpftrace.

Thanks!
Viktor

> 
> Thanks!
> 
> Alan
> 


