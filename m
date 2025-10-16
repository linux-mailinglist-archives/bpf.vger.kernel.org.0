Return-Path: <bpf+bounces-71067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F71BE117E
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 02:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5173A2AA6
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A69129E6E;
	Thu, 16 Oct 2025 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgXQaa+Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A711114
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574113; cv=none; b=JVPgn5sF+0i0vVC2Zd7CDg5hqM+qzdvO+3RgMM5huNADCFN4zRVH5SlF8tKnVuBgeLrsdWo5nRZ0nCrQ+Z5xbvO7KwT5K4v4yuFDez+TlW4Toc65OFPd1MpZmIHCLZwZxBUo7URaE124QqNDGz0VAe6Vurg4uf+LRUGF/dEyGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574113; c=relaxed/simple;
	bh=/N0dcrQj5SraVazDLw0BzRk4oHH4JebIn/XXG7nzvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1X06azvkPijEPhEmBnOi6ZecRGkyN8fcyfg1SffU9FuUYrCQJaX2oOC0/q5HJXrxgcn7BemgUT+RCBiovc+N0147KQ4kkID5opo8LYtrkmgdRllzpo3U8yGjGsWz3D/ERnwQBBeerrwIEug7GXc5UmubHjscPrYZ5oqFUsltrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgXQaa+Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso195526b3a.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760574111; x=1761178911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+uYbmyg7U3B88BGBaRnrEy2BORWFbRru8RT/OdSqk4=;
        b=JgXQaa+YZLECs9YCT9kbgPUMyZ23Sbmw1IEbxU/u7SQor+8QVMgN/4kiiM5SzVD7J8
         OTkzAmVvKUkoX7wN29DZXM9vmFc7ykJjVKMBKhldcuCRIT0lJy45Lw8Sta51Ya+i80kQ
         70R3Z7bN2TZ+vCdnIwhMmLaT9YlDQVVN3sX0x+6OrSQCpAIaz+gCznrNHA3b5Dt3wX2h
         KRdX2HkjV6fely7yMTQgxyJpm/+rgb3BYV3yrnkZOp34oxqQ6tyoARmiEYlzeCBoEM/r
         NLM8xl2LH6q1aBZBT4hNZkidzuyn5OTyHf0Iv9c1v4xUkIPCmjc/wZCtKMReX2YTaFBI
         oA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760574111; x=1761178911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+uYbmyg7U3B88BGBaRnrEy2BORWFbRru8RT/OdSqk4=;
        b=ipLE1z61GJ4OGQlNpABZOM1uYdtB1/BSzAWt8RsLB7cXM5OsWgU9+wYFkTs0E+YKjf
         hjodHP5ChQ+LnAP3zRStnwzz3A046OsKyCk/rsEPNbv799kf20rpSjLtmvnkrFhZ+jTS
         4muoboUc7vzZamg2d6kEg8/PigktDYJNhUKpRuxUJjN+HxeV20xwWdyXoWPBuP8SAGH+
         0g38TmS13RbjJNaOX6JbULh/gF73Blk5AvfBT9wIOkCAFqWV7oEq7M56GSIwNIvZjsdu
         Ngd9ML4vU2YjFGnsDWeEYsoqt/8SfN5fxsNNrhfsxb/uMffdL0IfTJnsMegVZyKuX2xD
         D18A==
X-Forwarded-Encrypted: i=1; AJvYcCVTx0KG2DFV1zN7WTfp1JDmAo1i0mkjs7pBRWooy7pCtHFkMqhEqx1JUN8irb5e/MMG0RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7M23u5zvIZmj+AfKJMCXU+9eCxLHF1SI/NmPPOulvy/jSuMY
	1vKhc3tpTAz6Wf7iSTC/P6Ui0tydTtCPj27AQu4fuJoWjckEKAZNei2y
X-Gm-Gg: ASbGncu4xl54EJD9AuAiUvHdoytQYJXHntsY6TefccmUJiNu7DcTsBC+AEdjsZhHPTa
	4u+I6Bc69EaXuhg1PYHIABYG18htgkT28F7/7fpWuvx1z4adihBduZdbOpElL+6v6RQAn1j/CL+
	BIGRhLDR1Y7YS4j7tLMKU8gy1Tms1RvjmY33zNgopc8h4KFKMiSq4AyWoRM3fZ+Fb5FGtl9tkjx
	6f4R+UcUDfqJnKcl+teEFnVBxPyNKsi8Zu+JgHo6dZSJYrolhkuxzB7wNLEGeNVbiPTCOCWZMnz
	ElPWpKqL4CxZ3Sg4ujZYYeVPgm490lxFM8t9lF88r0JR9J05QJ14xxfg85g1IDh0j5EqTpxUfX6
	ujV/Zi23Y1r4djGzVwEb1w1JjEduCq851rLVhrCSvzMIWXpDpxPoCqZozYS+ZNzTKpkPItpQj2i
	BNgih+Z4tTENdxNhBdR9lYEmq38r9WeWVl
X-Google-Smtp-Source: AGHT+IFJoepWNlU4+NBSNDZxjoH+m9KoM5DtxMqbC0OMbJN+YNUJKDrPJWuArAGQancBO2mZtAQxFg==
X-Received: by 2002:a05:6a00:4b01:b0:77f:1550:f3c9 with SMTP id d2e1a72fcca58-793859f34b3mr38869276b3a.12.1760574110523;
        Wed, 15 Oct 2025 17:21:50 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:b813:d910:1b7:5928? ([2620:10d:c090:500::4:c263])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm20056806b3a.40.2025.10.15.17.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 17:21:49 -0700 (PDT)
Message-ID: <e102f50a-efa5-49b9-927a-506b7353bac0@gmail.com>
Date: Wed, 15 Oct 2025 17:21:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, mkoutny@suse.com,
 yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 kernel-team@meta.com, mhocko@kernel.org, roman.gushchin@linux.dev,
 muchun.song@linux.dev
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 1:46 PM, Shakeel Butt wrote:
> Cc memcg maintainers.
> 
> On Wed, Oct 15, 2025 at 12:08:11PM -0700, JP Kobryn wrote:
>> When reading cgroup memory.stat files there is significant kernel overhead
>> in the formatting and encoding of numeric data into a string buffer. Beyond
>> that, the given user mode program must decode this data and possibly
>> perform filtering to obtain the desired stats. This process can be
>> expensive for programs that periodically sample this data over a large
>> enough fleet.
>>
>> As an alternative to reading memory.stat, introduce new kfuncs that allow
>> fetching specific memcg stats from within cgroup iterator based bpf
>> programs. This approach allows for numeric values to be transferred
>> directly from the kernel to user mode via the mapped memory of the bpf
>> program's elf data section. Reading stats this way effectively eliminates
>> the numeric conversion work needed to be performed in both kernel and user
>> mode. It also eliminates the need for filtering in a user mode program.
>> i.e. where reading memory.stat returns all stats, this new approach allows
>> returning only select stats.
>>
>> An experiment was setup to compare the performance of a program using these
>> new kfuncs vs a program that uses the traditional method of reading
>> memory.stat. On the experimental side, a libbpf based program was written
>> which sets up a link to the bpf program once in advance and then reuses
>> this link to create and read from a bpf iterator program for 1M iterations.
> 
> I am getting a bit confused on the terminology. You mentioned libbpf
> program, bpf program, link. Can you describe each of them? Think of
> explaining this to someone with no bpf background.
> 
> (BTW Yonghong already explained to me these details but I wanted the
> commit message to be self explanatory).

No problem. I'll try to expand on those terms in v3.

> 
>> Meanwhile on the control side, a program was written to open the root
>> memory.stat file
> 
> How much activity was on the system? I imagine none because I don't see
> flushing in the perf profile. This experiment focuses on the
> non-flushing part of the memcg stats which is fine.

Right, at the time there was no custom workload running alongside the
tests.

> 
>> and repeatedly read 1M times from the associated file
>> descriptor (while seeking back to zero before each subsequent read). Note
>> that the program does not bother to decode or filter any data in user mode.
>> The reason for this is because the experimental program completely removes
>> the need for this work.
> 
> Hmm in your experiment is the control program doing the decode and/or
> filter or no? The last sentence in above para is confusing. Yes, the
> experiment program does not need to do the parsing or decoding in
> userspace but the control program needs to do that. If your control
> program is not doing it then you are under-selling your work.

The control does not perform decoding. But it's a good point. Let me add
decoding to the control side in v3.

> 
>>
>> The results showed a significant perf benefit on the experimental side,
>> outperforming the control side by a margin of 80% elapsed time in kernel
>> mode. The kernel overhead of numeric conversion on the control side is
>> eliminated on the experimental side since the values are read directly
>> through mapped memory of the bpf program. The experiment data is shown
>> here:
>>
>> control: elapsed time
>> real    0m13.062s
>> user    0m0.147s
>> sys     0m12.876s
>>
>> experiment: elapsed time
>> real    0m2.717s
>> user    0m0.175s
>> sys     0m2.451s
> 
> These numbers are really awesome.

:)

> 
>>
>> control: perf data
>> 22.23% a.out [kernel.kallsyms] [k] vsnprintf
>> 18.83% a.out [kernel.kallsyms] [k] format_decode
>> 12.05% a.out [kernel.kallsyms] [k] string
>> 11.56% a.out [kernel.kallsyms] [k] number
>>   7.71% a.out [kernel.kallsyms] [k] strlen
>>   4.80% a.out [kernel.kallsyms] [k] memcpy_orig
>>   4.67% a.out [kernel.kallsyms] [k] memory_stat_format
>>   4.63% a.out [kernel.kallsyms] [k] seq_buf_printf
>>   2.22% a.out [kernel.kallsyms] [k] widen_string
>>   1.65% a.out [kernel.kallsyms] [k] put_dec_trunc8
>>   0.95% a.out [kernel.kallsyms] [k] put_dec_full8
>>   0.69% a.out [kernel.kallsyms] [k] put_dec
>>   0.69% a.out [kernel.kallsyms] [k] memcpy
>>
>> experiment: perf data
>> 10.04% memcgstat bpf_prog_.._query [k] bpf_prog_527781c811d5b45c_query
>>   7.85% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
>>   4.03% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
>>   3.47% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
>>   2.58% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
>>   2.58% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
>>   2.32% memcgstat [kernel.kallsyms] [k] kmem_cache_free
>>   2.19% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
>>   2.13% memcgstat [kernel.kallsyms] [k] mutex_lock
>>   2.12% memcgstat [kernel.kallsyms] [k] get_page_from_freelist
>>
>> Aside from the perf gain, the kfunc/bpf approach provides flexibility in
>> how memcg data can be delivered to a user mode program. As seen in the
>> second patch which contains the selftests, it is possible to use a struct
>> with select memory stat fields. But it is completely up to the programmer
>> on how to lay out the data.
> 
> I remember you plan to convert couple of open source program to use this
> new feature. I think below [1] and oomd [2]. Adding that information
> would further make your case strong. cAdvisor[3] is another open source
> tool which can take benefit from this work.

That is accurate, thanks. Will include in v3.

> 
> [1] https://github.com/facebookincubator/below
> [2] https://github.com/facebookincubator/oomd
> [3] https://github.com/google/cadvisor
> 


