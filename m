Return-Path: <bpf+bounces-34495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7D92DE34
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 04:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99BE284D4F
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57666748E;
	Thu, 11 Jul 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liH6iCbI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED5383
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663343; cv=none; b=DLZpkShe1f+5ISuVAUId0hvtIMmvUeAC9AOKZgIfhRWEbtu/zsFYSBlkGRNNSpFihmTNWaRYPn41uzOV6QA1js+hmJHw6VkOUaCTa2fIwM4ZkbOnD7frZhn6AVjzykLEtRNTtMOGdJmJhDDNm18z8BC04YnGc45nj4OuVk6Vbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663343; c=relaxed/simple;
	bh=UTGiIYkJDpIdS66rZLDBj9osXaKuonFwx5g2HA/yKm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD6vsG6ZypuDO2ZNJAaro1VoYy5OmVDVGlBbtUWZZWvkdmqse2r2fMP6MzuNzUhdwtu95Rpus+UXImmhMK5inFR1FNIvrxKKvRe7TVbr7AkfeGk1i7FlkZY3W2F7KwFlRVUd5I3GljoG6LlStzjhtTxJ4umxhj+WGM88i/wlRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liH6iCbI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb0d88fd25so3004045ad.0
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720663342; x=1721268142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cCS7ZmeSepMwvc8p+v2V33FabmcRxAG8JHcjc0V5jM=;
        b=liH6iCbIPKC5YTwI4oICLUusCne2S/e7DEPwjP8dv5SP/lBf/isfTH71xltwAjqb0i
         KAO7S+R40Xke/4rtzZ5Fria+YDkkhiHnD1OeraSoi7bf/wFh5Esy16SDgVZzTkKvExw6
         z9IZ+OjLgwUG70j5ri9N6VcOXC2mrJQ5NetcED8KzAOhjsBNyFt4/mcO4+mckHNy4nqs
         kugVLyZzLTiiOMphSRqyeVSwBxs3GSknMJZ+UjEoBYcsrtKnAi5GWdkmfgMZW486Yv+v
         2zhFXNlQrfBYEx7ZZQ0Icb3zxW7BqdHZ//1O1rYOZDToq88so7m13hAYbzVftGglbH6B
         N2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720663342; x=1721268142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cCS7ZmeSepMwvc8p+v2V33FabmcRxAG8JHcjc0V5jM=;
        b=w1oS7y3pRRqwlbxHhpK0Uqu8RizJDWfMmqBuCfJNLwBBUXUFxeWNIs7nQFhSlP+0F4
         ObSaRmvWG4f0M5SjKrkaQxcNNGt/3+1w9QCf3zZLQV4pkhX28F1A3nADPK/IqI/L0dvG
         0d5OV3Z25JkYKWnCk7NgjXLXpYyyCgAvhDnEslZqxWDZwPUjpIppjEB9HRw7M7o3Caf0
         S/6MCKhDi3qCbhpqbMxSwYJE5wcedMUrE8Q+Zfvh3Qi87oqy5/Fwm1bDYMSmONfg79G2
         1Tohg74jn183wYZ+ufqVPbIUFLZrT/1tEPaSL5LsWMQY7oNrAg6P7UOIouy+PGMoYSlG
         bfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAI50BqhMw8F4eof502KjD/x9KD6GzBwXVXgO+pU8kYPtnOssIuqf5brp4Hvrh9qaIMFBDttcebcvUUTcb/WbHEGNX
X-Gm-Message-State: AOJu0YwPCJHmf3aecoW0WPHd8aqnf5iIqBqcm/7hd4C0nWpzxtHzoQ9J
	6sfEtgtvXa/gnBj+zAxnU3wixdgu9OuNZwS9iezF7bpyLPiNGjYtWdGyPQ==
X-Google-Smtp-Source: AGHT+IEsrGdHBOpj6/KDboQClbkCbt1mStcioMjcFi7rZEDC5QcrV+KmXDJLwJe/Qgt7QaSLFHiFvg==
X-Received: by 2002:a17:903:1c3:b0:1f9:e927:8b83 with SMTP id d9443c01a7336-1fbdb9b53ffmr21681315ad.5.1720663341575;
        Wed, 10 Jul 2024 19:02:21 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d667ecd9fsm2937719a12.72.2024.07.10.19.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 19:02:21 -0700 (PDT)
Message-ID: <8914d81b-4a78-4657-909c-707759883216@gmail.com>
Date: Thu, 11 Jul 2024 10:02:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 maciej.fijalkowski@intel.com, puranjay@kernel.org, jakub@cloudflare.com,
 pulehui@huawei.com, kernel-patches-bot@fb.com
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
 <20240623161528.68946-2-hffilwlqm@gmail.com>
 <a00ad2e4df00bab1e5ea12cf22fe32d4933a7835.camel@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <a00ad2e4df00bab1e5ea12cf22fe32d4933a7835.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 08:15, Eduard Zingerman wrote:
> On Mon, 2024-06-24 at 00:15 +0800, Leon Hwang wrote:
>> This patch fixes a tailcall issue caused by abusing the tailcall in
>> bpf2bpf feature.
>>
>> As we know, tail_call_cnt propagates by rax from caller to callee when
>> to call subprog in tailcall context. But, like the following example,
>> MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
>> back-propagation from callee to caller.
>>
>> \#include <linux/bpf.h>
>> \#include <bpf/bpf_helpers.h>
>> \#include "bpf_legacy.h"
>>
>> struct {
>> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>> 	__uint(max_entries, 1);
>> 	__uint(key_size, sizeof(__u32));
>> 	__uint(value_size, sizeof(__u32));
>> } jmp_table SEC(".maps");
>>
>> int count = 0;
>>
>> static __noinline
>> int subprog_tail1(struct __sk_buff *skb)
>> {
>> 	bpf_tail_call_static(skb, &jmp_table, 0);
>> 	return 0;
>> }
>>
>> static __noinline
>> int subprog_tail2(struct __sk_buff *skb)
>> {
>> 	bpf_tail_call_static(skb, &jmp_table, 0);
>> 	return 0;
>> }
>>
>> SEC("tc")
>> int entry(struct __sk_buff *skb)
>> {
>> 	volatile int ret = 1;
>>
>> 	count++;
>> 	subprog_tail1(skb);
>> 	subprog_tail2(skb);
>>
>> 	return ret;
>> }
>>
>> char __license[] SEC("license") = "GPL";
>>
>> At run time, the tail_call_cnt in entry() will be propagated to
>> subprog_tail1() and subprog_tail2(). But, when the tail_call_cnt in
>> subprog_tail1() updates when bpf_tail_call_static(), the tail_call_cnt
>> in entry() won't be updated at the same time. As a result, in entry(),
>> when tail_call_cnt in entry() is less than MAX_TAIL_CALL_CNT and
>> subprog_tail1() returns because of MAX_TAIL_CALL_CNT limit,
>> bpf_tail_call_static() in suprog_tail2() is able to run because the
>> tail_call_cnt in subprog_tail2() propagated from entry() is less than
>> MAX_TAIL_CALL_CNT.
>>
>> So, how many tailcalls are there for this case if no error happens?
>>
>> From top-down view, does it look like hierarchy layer and layer?
>>
>> With this view, there will be 2+4+8+...+2^33 = 2^34 - 2 = 17,179,869,182
>> tailcalls for this case.
>>
>> How about there are N subprog_tail() in entry()? There will be almost
>> N^34 tailcalls.
>>
>> Then, in this patch, it resolves this case on x86_64.
>>
>> In stead of propagating tail_call_cnt from caller to callee, it
>> propagates its pointer, tail_call_cnt_ptr, tcc_ptr for short.
>>
>> However, where does it store tail_call_cnt?
>>
>> It stores tail_call_cnt on the stack of main prog. When tail call
>> happens in subprog, it increments tail_call_cnt by tcc_ptr.
>>
>> Meanwhile, it stores tail_call_cnt_ptr on the stack of main prog, too.
>>
>> And, before jump to tail callee, it has to pop tail_call_cnt and
>> tail_call_cnt_ptr.
>>
>> Then, at the prologue of subprog, it must not make rax as
>> tail_call_cnt_ptr again. It has to reuse tail_call_cnt_ptr from caller.
>>
>> As a result, at run time, it has to recognize rax is tail_call_cnt or
>> tail_call_cnt_ptr at prologue by:
>>
>> 1. rax is tail_call_cnt if rax is <= MAX_TAIL_CALL_CNT.
>> 2. rax is tail_call_cnt_ptr if rax is > MAX_TAIL_CALL_CNT, because a
>>    pointer won't be <= MAX_TAIL_CALL_CNT.
>>
>> Furthermore, when trampoline is the caller of bpf prog, which is
>> tail_call_reachable, it is required to propagate rax through trampoline.
>>
>> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
>> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
> 
> Hi Leon,
> 
> Sorry for delayed response.
> I've looked through this patch and the changes make sense to me.
> One thing that helped to understand the gist of the changes,
> was dumping jited program using bpftool and annotating it with comments:
> https://gist.github.com/eddyz87/0d48da052e9d174b2bb84174295c4215
> Maybe consider adding something along these lines to the patch
> description?

Sure, I'll resend the patch with updated description along annotating
comments later.

Thanks,
Leon

>   
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

