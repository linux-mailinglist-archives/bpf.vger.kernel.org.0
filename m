Return-Path: <bpf+bounces-37332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114B953D53
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7741F22620
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC447154C09;
	Thu, 15 Aug 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQKn2dZt"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172F1547DC
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760612; cv=none; b=uB5F8YM/TrY1fSbH9XGJxVNapWy3yDGtHK6kPPDmQFqNVgyvqMnF9Dlywf7a8DJ6zqqO/d1x2jTaQzIaoDaxreIvtMYH+a85VkWO1fmpzneMIM8ARLkEq1Ies74YeWKoyPviENPmA5DJy7Pt+qgdnyV5CqNwx7JbgYl06F1t0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760612; c=relaxed/simple;
	bh=wLYxl+jGSIBLqhmuitnciSXC9P2hwVl9Hlc2zgQULh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9CfnXTfJjIrRlwnXv+dyBHsbHGlsG6GzyvNHYqwZvw/UzrZ0XTYTLOuY5wFq2fHPLo74NJqxsccl0uch195FnrTM/rvjQy9re+o90ZL/g0WGRNQUsIlIQWJv6Fts2+77HKDtZPiLY4s4xWr7GVDkwT03LxvZeRhhBxN4fDR80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQKn2dZt; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1918269a-db95-4a8b-885f-7b223c029be1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723760608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSJvsPO8E+nG6F/pYcKBJvMa3FYBtO0VjsZitkQp5iM=;
	b=uQKn2dZtvdSZW1kACbLyUyQHfQJIs0qxHtyVqeAbspI1q52OFi6rRYVuV7gZeJqo5tY91L
	yzEc0yj4DAbNZmHKi63SscU47QuPVsBmRIPPwbHwmObZ7sxLVvtTn0MPMozc743I7Ky+QN
	MGofOr68U9ESVX4KW0YcTmtn9y4Vmec=
Date: Thu, 15 Aug 2024 15:23:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com
References: <20240812234356.2089263-1-eddyz87@gmail.com>
 <20240812234356.2089263-2-eddyz87@gmail.com>
 <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
 <065543369ba59473ae2479957ad318b5bb393c43.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <065543369ba59473ae2479957ad318b5bb393c43.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/15/24 3:07 PM, Eduard Zingerman wrote:
> On Thu, 2024-08-15 at 14:24 -0700, Andrii Nakryiko wrote:
>
> [...]
>
>>> @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
>>>          }
>>>   }
>>>
>>> +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment above */
>>> +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
>>> +{
>>> +       const struct btf_param *params;
>>> +       u32 vlen, i, mask;
>>> +
>>> +       params = btf_params(meta->func_proto);
>>> +       vlen = btf_type_vlen(meta->func_proto);
>>> +       mask = 0;
>>> +       if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
>>> +               mask |= BIT(BPF_REG_0);
>>> +       for (i = 0; i < vlen; ++i)
>>> +               mask |= BIT(BPF_REG_1 + i);
>> Somewhere deep in btf_dump implementation of libbpf, there is a
>> special handling of `<whatever> func(void)` (no args) function as
>> having vlen == 1 and type being VOID (i.e., zero). I don't know if
>> that still can happen, but I believe at some point we could get this
>> vlen==1 and type=VOID for no-args functions. So I wonder if we should
>> handle that here as well, or is it some compiler atavism we can forget
>> about?
>>
> I just checked BTF generated for 'int filelock_init(void)',
> for gcc compiled kernel using latest pahole and func proto looks as follows:
>
>    FUNC_PROTO '(anon)' ret_type_id=12 vlen=0
>
> So I assume this is an atavism.

Agree, for kernel vmlinux BTF, we should be fine.

>
> [...]
>
>

