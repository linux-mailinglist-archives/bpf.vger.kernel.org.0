Return-Path: <bpf+bounces-63275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC2B04C8B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A83A88B8
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E595F273D95;
	Mon, 14 Jul 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="annGSL7V"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83791CEADB
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537007; cv=none; b=iTW9aYvoa50SybVY9uHAAHqNtXIvu8UAMMMWAabyUqcCTRz2rPsN1uI26PVqX+CMyp9MC/4g0ETqmxoq4xzDRSBaH+MAvJknO49SGpARYbJyNl+vZjv+EWrd1ykjJtzsB0/hXtMMmrVtWHEfQIM4Fkz+DEtK2627uWJ9qHkU/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537007; c=relaxed/simple;
	bh=m4DDZHtInT4ydf8cBaPoqBEoz5Qbe2x5/OvyenNtrdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9AJk6vWAIjA/e9f48KfG9haIs1FLQOjbe6xuTrFt/Vy8qE0h3RhYH4VRWSy2goeFboUKbskTiMbDdRAeUhazywcjgevKpHnOO9TSgIIGh0pGBZqrT99NRHNOJgXeZwg6tX3v8VaR7XWWQgRPhMJUDM2PvsAhvLNN/bS6Fo5K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=annGSL7V; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9771eaa3-413a-4ab0-b7e1-d6a6f326c43f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752537001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWDGZsiAj758/fPcimTBWNYKiuxjThlxx3os2rlu/mo=;
	b=annGSL7VDXcj8Aktq3dJ7rkV9+7BG+WU0vQaP/qI0M696vtiWmiF+pp0oZJFNt2GF/+j1N
	d26YyiSX638/UZEedCrOiQAveJwJoGHLOjevATUWBoX3ZvTTKmRm+DMLS27A12WoqfiKwD
	EY5+O9XTPJjVtEiWIDukTtYy5Al5lw4=
Date: Mon, 14 Jul 2025 16:49:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for
 tracing_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-18-dongml2@chinatelecom.cn>
 <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/8/25 1:07 PM, Alexei Starovoitov wrote:
> On Thu, Jul 3, 2025 at 5:18 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>
>> +               return true;
>> +
>> +       /* Following symbols have multi definition in kallsyms, take
>> +        * "t_next" for example:
>> +        *
>> +        *     ffffffff813c10d0 t t_next
>> +        *     ffffffff813d31b0 t t_next
>> +        *     ffffffff813e06b0 t t_next
>> +        *     ffffffff813eb360 t t_next
>> +        *     ffffffff81613360 t t_next
>> +        *
>> +        * but only one of them have corresponding mrecord:
>> +        *     ffffffff81613364 t_next
>> +        *
>> +        * The kernel search the target function address by the symbol
>> +        * name "t_next" with kallsyms_lookup_name() during attaching
>> +        * and the function "0xffffffff813c10d0" can be matched, which
>> +        * doesn't have a corresponding mrecord. And this will make
>> +        * the attach failing. Skip the functions like this.
>> +        *
>> +        * The list maybe not whole, so we still can fail......We need a
>> +        * way to make the whole things right. Yes, we need fix it :/
>> +        */
>> +       if (!strcmp(name, "kill_pid_usb_asyncio"))
>> +               return true;
>> +       if (!strcmp(name, "t_next"))
>> +               return true;
>> +       if (!strcmp(name, "t_stop"))
>> +               return true;
> 
> This looks like pahole bug. It shouldn't emit BTF for static
> functions with the same name in different files.
> I recall we discussed it in the past and I thought the fix had landed.

I checked this particular case (the t_next function), and what seems
to be happening is that all function prototypes match, according to
this check in pahole's BTF encoding:

* https://github.com/acmel/dwarves/blob/v1.30/btf_encoder.c#L1378
* https://github.com/acmel/dwarves/blob/v1.30/btf_encoder.c#L1112-L1152

That is: the name, number and types of parameters all match.

So at least according to the current pahole logic the prototypes are
*consistent*. As a result, a single BTF function t_next is emitted.

Maybe funcs__match() check should be even more strict? Say, disallow
static functions?

I am not sure that the draft that Jiri sent [1] is right as it just
filters out duplicates by name.

[1] https://lore.kernel.org/bpf/aHD0IdJBqd3XNybw@krava/


