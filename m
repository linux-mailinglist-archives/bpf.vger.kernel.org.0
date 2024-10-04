Return-Path: <bpf+bounces-40915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684F98FCFF
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 07:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5992840E8
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FED680C0A;
	Fri,  4 Oct 2024 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KCCze5g4"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32409475
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019718; cv=none; b=IuZf6waA82wcQIp/GrmYHxRVRraaVYBokctkhRYOihacvrPulkTIiBl6zR9NZHzqT0ZoWS1uMZL96myveygh4wceZwJgE8gN+bye9tU8BME5tFODyuQpt+7cAeuFNTO0mvgb+EziU07HM7eRTKVdfoDTKpHj7/dfY15vwdTYh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019718; c=relaxed/simple;
	bh=PEuqH1peiri/YBuvzHWdhfa2Jrv3lxgFtvTHz1LrtzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7hcMiysOYRbbhUmf7ibPGNz/nQZMixxKdTX3mCrZM9GRmxDE4zp1rqYv4o8IRfMtgURkgnhFt6Q0JsUL/ROKkKuC66L0RdEDctTF9RC7p5YSkPrObI7VhuEHXOPlXfj6O8JFxUBfNWdQrr3bhsvSWv2iJBCKr3i+1TgPfZEtog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KCCze5g4; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cebd5c08-717f-4130-9f8c-1f5bd101d767@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728019715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+84r6u5hzBSXVMYDdK7c7QxyHOJyEwxN5wdWpftiNvs=;
	b=KCCze5g4miCILJ5IaM3oEC9j0zjM24FV2Y8ZkxqD2d8TknpXKptMvoUqvChfWzeNL5ltU/
	WWsBcJ4ElitVqJoseCd4NIX+ZGu8dsFArm933WgLwQezHdolhI6XVpOGFlFaNHoSgil+Zf
	S8kNYLuZ1fkDGEfWwYUXllwfayJbaKk=
Date: Thu, 3 Oct 2024 22:28:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod
 operations
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>,
 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>, bpf@ietf.org
Cc: 'bpf' <bpf@vger.kernel.org>, 'Alexei Starovoitov' <ast@kernel.org>,
 'Andrii Nakryiko' <andrii@kernel.org>,
 'Daniel Borkmann' <daniel@iogearbox.net>,
 'Martin KaFai Lau' <martin.lau@kernel.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/1/24 12:54 PM, Dave Thaler wrote:
> Yonghong Song <yonghong.song@linux.dev> wrote:
>> On 9/30/24 6:50 PM, Alexei Starovoitov wrote:
>>> On Thu, Sep 26, 2024 at 8:39 PM Yonghong Song <yonghong.song@linux.dev>
>> wrote:
>>>> Patch [1] fixed possible kernel crash due to specific sdiv/smod
>>>> operations in bpf program. The following are related operations and
>>>> the expected results of those operations:
>>>>     - LLONG_MIN/-1 = LLONG_MIN
>>>>     - INT_MIN/-1 = INT_MIN
>>>>     - LLONG_MIN%-1 = 0
>>>>     - INT_MIN%-1 = 0
>>>>
>>>> Those operations are replaced with codes which won't cause kernel
>>>> crash. This patch documents what operations may cause exception and
>>>> what replacement operations are.
>>>>
>>>>     [1]
>>>> https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@li
>>>> nux.dev/
>>>>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    .../bpf/standardization/instruction-set.rst   | 25 +++++++++++++++----
>>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/bpf/standardization/instruction-set.rst
>>>> b/Documentation/bpf/standardization/instruction-set.rst
>>>> index ab820d565052..d150c1d7ad3b 100644
>>>> --- a/Documentation/bpf/standardization/instruction-set.rst
>>>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>>>> @@ -347,11 +347,26 @@ register.
>>>>      =====  =====  =======
>>>> ==========================================================
>>>>
>>>>    Underflow and overflow are allowed during arithmetic operations,
>>>> meaning -the 64-bit or 32-bit value will wrap. If BPF program
>>>> execution would -result in division by zero, the destination register is instead set
>> to zero.
>>>> -If execution would result in modulo by zero, for ``ALU64`` the value of
>>>> -the destination register is unchanged whereas for ``ALU`` the upper
>>>> -32 bits of the destination register are zeroed.
>>>> +the 64-bit or 32-bit value will wrap. There are also a few
>>>> +arithmetic operations which may cause exception for certain
>>>> +architectures. Since crashing the kernel is not an option, those operations are
>> replaced with alternative operations.
>>>> +
>>>> +.. table:: Arithmetic operations with possible exceptions
>>>> +
>>>> +  =====  ==========  =============================
>> ==========================
>>>> +  name   class       original                       replacement
>>>> +  =====  ==========  =============================
>> ==========================
>>>> +  DIV    ALU64/ALU   dst /= 0                       dst = 0
>>>> +  SDIV   ALU64/ALU   dst s/= 0                      dst = 0
>>>> +  MOD    ALU64       dst %= 0                       dst = dst (no replacement)
>>>> +  MOD    ALU         dst %= 0                       dst = (u32)dst
>>>> +  SMOD   ALU64       dst s%= 0                      dst = dst (no replacement)
>>>> +  SMOD   ALU         dst s%= 0                      dst = (u32)dst
> All of the above are already covered in existing Table 5 and in my opinion
> don't need to be repeated.

This tries to separate cases between ALU and ALU64. But I agree that the table
5 should be good enough.

>
> That is, the "original" is not what Table 5 has, so just introduces confusion
> in the document in my opinion.
>
>>>> +  SDIV   ALU64       dst s/= -1 (dst = LLONG_MIN)   dst = LLONG_MIN
>>>> +  SDIV   ALU         dst s/= -1 (dst = INT_MIN)     dst = (u32)INT_MIN
>>>> +  SMOD   ALU64       dst s%= -1 (dst = LLONG_MIN)   dst = 0
>>>> +  SMOD   ALU         dst s%= -1 (dst = INT_MIN)     dst = 0
> The above four are the new ones and I'd prefer a solution that modifies
> existing table 5.  E.g. table 5 has now for SMOD:
>
> dst = (src != 0) ? (dst s% src) : dst
>
> and could have something like this:
>
> dst = (src == 0) ? dst : ((src == -1 && dst == INT_MIN) ? 0 : (dst s% src))

Thanks. This indeed simpler. I can do this.


