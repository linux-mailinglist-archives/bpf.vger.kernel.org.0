Return-Path: <bpf+bounces-21239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5284A276
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 19:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E328A619
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE981481B1;
	Mon,  5 Feb 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XujVAKI7"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C14E1AD
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158075; cv=none; b=G68feMmm3H4qD5+bHI8NXRefqM5XyyqDLQp10ebIEnMJgxn0QCY/qbbK5UXxxKt/94SDePWrQWO82kOVThScJwkVquo5jKIhFu+8ltCL4hVWUBmg4hp3Bt7Uov2etmEZiUkOELwS+jidzfZB1MOaqfooyyKL4HveFgEeqN61DIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158075; c=relaxed/simple;
	bh=EJFQ6NyFZ44BEICeKRhVKm07VxQ1wRxrIiOwO1D2rwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBStby9hOfK0Ig0JqnP4NeeUFXDTBM9buR3jRjmgqwEXbdwocGlMh7+Djf48DWv/QI0yhKA6JSGG+7i5iBVkhNw3zFX+61lWOuEh4+VK3XudvqQxsgHeUuMWErm4puxQLVwz0OEeVvnFvQwi+EbVz76yKjLRd3Hr+7u0YdB0gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XujVAKI7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66f56100-0ef6-4d6a-8d98-26b87a7f10da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707158071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJFQ6NyFZ44BEICeKRhVKm07VxQ1wRxrIiOwO1D2rwY=;
	b=XujVAKI77ybe2aicx4rQ1N/KNyZm/U1ty/Z1SMBI4qg+PhdNsp2cgOs+CP1NuxChnxVK8i
	ed9z5Z8qGP/7RYUfR9o11yDfeFSzxpiBmWi53b4rOQfpA7hG5wmyAia9VIjweyPVgQiJif
	onbUnjNV2uyYzaYovWWD5UDm9ZmrZWg=
Date: Mon, 5 Feb 2024 10:34:24 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: Add generic kfunc bpf_ffs64()
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
References: <20240131155607.51157-1-hffilwlqm@gmail.com>
 <CAEf4BzYsYHi1s_7PZ5QknUg+Oe9drN0OSXbxT06WDB57o0Ju9w@mail.gmail.com>
 <a910fc94-47cd-419e-baf9-5c00140cbc60@linux.dev>
 <CAEf4BzaA+hhVdh=gGd2uz10ZLPeUKWN2H75MiF93L1AWPJ2O7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzaA+hhVdh=gGd2uz10ZLPeUKWN2H75MiF93L1AWPJ2O7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/5/24 10:18 AM, Andrii Nakryiko wrote:
> On Sun, Feb 4, 2024 at 11:20 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 2/2/24 2:18 PM, Andrii Nakryiko wrote:
>>> On Wed, Jan 31, 2024 at 7:56 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>> This patchset introduces a new generic kfunc bpf_ffs64(). This kfunc
>>>> allows bpf to reuse kernel's __ffs64() function to improve ffs
>>>> performance in bpf.
>>>>
>>> The downside of using kfunc for this is that the compiler will assume
>>> that R1-R5 have to be spilled/filled, because that's function call
>>> convention in BPF.
>>>
>>> If this was an instruction, though, it would be much more efficient
>>> and would avoid this problem. But I see how something like ffs64 is
>>> useful. I think it would be good to also have popcnt instruction and a
>>> few other fast bit manipulation operations as well.
>>>
>>> Perhaps we should think about another BPF ISA extension to add fast
>>> bit manipulation instructions?
>> Sounds a good idea to start the conversion. Besides popcnt, lzcnt
>> is also a candidate. From llvm perspective, it would be hard to
>> generate ffs64/popcnt/lzcnt etc. from source generic implementation.
> I'm curious why? I assumed that if a user used __builtin_popcount()
> Clang could just generate BPF's popcnt instruction (assuming the right
> BPF cpu version is enabled, of course).

Not aware of __builtin_popcount(). Yes, BPF backend should be able easily
converts __builtin_popcount() to a BPF insn.

>
>> So most likely, inline asm will be used. libbpf could define
>> some macros to make adoption easier. Verifier and JIT will do
>> proper thing, either using corresponding arch insns directly or
>> verifier will rewrite so JIT won't be aware of these insns.
[...]

