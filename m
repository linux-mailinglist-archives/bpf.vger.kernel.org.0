Return-Path: <bpf+bounces-63392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14119B06A97
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287C73A3EFF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C0136358;
	Wed, 16 Jul 2025 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5USGr9e"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60857405A
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626120; cv=none; b=pNK7Zv1LbETCXmB5sDpZndI7VFZKvrcJAQiP/anNWe77iRTz1M7rRBxJMql01v4gj+KGyG/k6wrfDilW4AA9/2tmCz9vlvTnDbkbGWn4bAwGCyBDXbP3ck0idCC2Q/JU3p72+SRvkxd8j2lSUz4nmSxogwx5IZVv1WiKZ9sdtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626120; c=relaxed/simple;
	bh=i5xnGWA6aCOVM8PL1UzdxhSqBxC8EVTH3Wk/P4IcK04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPk4wPlHb4mgE25WFQzpVVG4V02N+DIiIFRD6x775va4zFKNkcBhApbdajBJNVTrz2HTNY+AciNYytsdFs7/BNlZk4gZy1pFLZ/eh53EQDTecW5ZeszfHgMmCcE0DoZNeBiWswmkYBTPRvcbQocCNZtCiqIwrfEKm1BamRs23vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J5USGr9e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b40a13d8-0fc9-44bd-a0c7-e656d0a14819@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752626105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmliiU+uUkJ+3G40FReJrT5cdViv5DUGUpPp55i8RQI=;
	b=J5USGr9ea86oqdEBAjgMFTAaHxtIwu3z/wEMXyPBb4sVlLWjN+dlPRrWGZsKowFKBnF0bb
	q9PEENu5q10j7pE8kW/9sg0VRgmhdglow6lCXqJiNurmifDQQn4D3hxHZh/ma6hnSfTbBI
	h7UHO8sx4Q49/mwAnGkjVO1nQP+AA7U=
Date: Tue, 15 Jul 2025 17:34:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for
 tracing_multi
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves <dwarves@vger.kernel.org>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-18-dongml2@chinatelecom.cn>
 <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
 <9771eaa3-413a-4ab0-b7e1-d6a6f326c43f@linux.dev>
 <3dfbc97c-5721-4bd7-9443-ce57d7ba592c@linux.dev>
 <CAADnVQK-06d8E85aJ-=K+Af+a8_MSNJFiBqjpXYs4+adiTuwvw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQK-06d8E85aJ-=K+Af+a8_MSNJFiBqjpXYs4+adiTuwvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 5:31 PM, Alexei Starovoitov wrote:
> On Tue, Jul 15, 2025 at 5:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 7/14/25 4:49 PM, Ihor Solodrai wrote:
>>> On 7/8/25 1:07 PM, Alexei Starovoitov wrote:
>>>> On Thu, Jul 3, 2025 at 5:18 AM Menglong Dong
>>>> <menglong8.dong@gmail.com> wrote:
>>>>>
>>>>> +               return true;
>>>>> +
>>>>> +       /* Following symbols have multi definition in kallsyms, take
>>>>> +        * "t_next" for example:
>>>>> +        *
>>>>> +        *     ffffffff813c10d0 t t_next
>>>>> +        *     ffffffff813d31b0 t t_next
>>>>> +        *     ffffffff813e06b0 t t_next
>>>>> +        *     ffffffff813eb360 t t_next
>>>>> +        *     ffffffff81613360 t t_next
>>>>> +        *
>>>>> +        * but only one of them have corresponding mrecord:
>>>>> +        *     ffffffff81613364 t_next
>>>>> +        *
>>>>> +        * The kernel search the target function address by the symbol
>>>>> +        * name "t_next" with kallsyms_lookup_name() during attaching
>>>>> +        * and the function "0xffffffff813c10d0" can be matched, which
>>>>> +        * doesn't have a corresponding mrecord. And this will make
>>>>> +        * the attach failing. Skip the functions like this.
>>>>> +        *
>>>>> +        * The list maybe not whole, so we still can fail......We need a
>>>>> +        * way to make the whole things right. Yes, we need fix it :/
>>>>> +        */
>>>>> +       if (!strcmp(name, "kill_pid_usb_asyncio"))
>>>>> +               return true;
>>>>> +       if (!strcmp(name, "t_next"))
>>>>> +               return true;
>>>>> +       if (!strcmp(name, "t_stop"))
>>>>> +               return true;
>>
>> This little patch will filter out from BTF any static functions with
>> the same name that appear more than once.
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 0bc2334..6441269 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -96,7 +96,8 @@ struct elf_function {
>>           const char      *name;
>>           char            *alias;
>>           size_t          prefixlen;
>> -       bool            kfunc;
>> +       uint8_t         is_static:1;
>> +       uint8_t         kfunc:1;
>>           uint32_t        kfunc_flags;
>>    };
>>
>> @@ -1374,7 +1375,7 @@ static int saved_functions_combine(struct
>> btf_encoder_func_state *a, struct btf_
>>                   return ret;
>>           optimized = a->optimized_parms | b->optimized_parms;
>>           unexpected = a->unexpected_reg | b->unexpected_reg;
>> -       inconsistent = a->inconsistent_proto | b->inconsistent_proto;
>> +       inconsistent = a->inconsistent_proto | b->inconsistent_proto |
>> a->elf->is_static | b->elf->is_static;
>>           if (!unexpected && !inconsistent && !funcs__match(a, b))
>>                   inconsistent = 1;
>>           a->optimized_parms = b->optimized_parms = optimized;
>> @@ -1461,6 +1462,8 @@ static void elf_functions__collect_function(struct
>> elf_functions *functions, GEl
>>
>>           func = &functions->entries[functions->cnt];
>>           func->name = name;
>> +       func->is_static = elf_sym__bind(sym) == STB_LOCAL;
>> +
> 
> Hmm. We definitely don't want to filter out all static functions.
> That's too drastic.

Not all static functions. Only those that match by name.


