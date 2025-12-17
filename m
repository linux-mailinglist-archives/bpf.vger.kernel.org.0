Return-Path: <bpf+bounces-76811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD19CC5F20
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 05:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F36630225B7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C12BE65C;
	Wed, 17 Dec 2025 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kjh6pBO7"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B63A1E8C
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 04:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765944795; cv=none; b=RNbIN+P0SoNvjNCJCvkhp/aelT9rxL/IhdyzcgYtvfFzgv/4KArwCOnRG+UNAEYFjy6Q9WimbfhOlFs0wOhhR3Boy8xpi22D895rXPSfrPz/v2W0b7xQlYFBxychtemMagXZtbWAjophr72B4fh7P1uavowMsAf/ZY3/YX7fygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765944795; c=relaxed/simple;
	bh=/3XOxNcGq7pJuEmAANasaV8qAUwY0h4d2Fr9Byfd5wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+W3TkjVl3w/P10ICUVOqs16vdZbPbg4DAGKJ004Jv2N+yoZaCsCoZm/uNVcXqtGBe4XrBCN05hEQnpEgtTONzxzGAX9PZ+ya7rIwNPDtdkdqUcOR+asxOVGbmt6T3+SvS061uYti/pu5H0hCkkqKzCkdVUiYE2V0XwB++XI0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kjh6pBO7; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e57cc87-9258-4d9e-a01c-c76f8938ae46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765944780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZv0I8sBeJ2LG4Vm5P6dpIWDpxSL+jbxMtqs26pPzTk=;
	b=Kjh6pBO7y9+v8fQ4lF0mtvG4Hzu1UtRMSjd+qVqAVSXeNFF0Wmic0oOEHtl3io4cHHbFEU
	9W85qk+lcoSw0dSZDHdG2mJUxhy1JTOxGyVQppairuAzI7uVB9+kG1mA1h/beG2ZJQ3mck
	L2T96zjhudvF98qgTiSJiXweM9UTY/w=
Date: Tue, 16 Dec 2025 20:12:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] dwarf_loader: Handle DW_AT_location attrs
 containing DW_OP_plus_uconst
Content-Language: en-GB
To: Yao Zi <me@ziyao.cc>, Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, q66 <me@q66.moe>
References: <20251130032113.4938-2-ziyao@disroot.org>
 <a3f82302-09d2-45e1-a30a-38a32ddbf947@linux.dev> <aT0hjyVstASDsl-E@pie>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aT0hjyVstASDsl-E@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/13/25 12:20 AM, Yao Zi wrote:
> Hi Yonghong,
>
> Sorry for the late reply,
>
> On Wed, Dec 03, 2025 at 04:46:20PM -0800, Yonghong Song wrote:
>>
>> On 11/29/25 7:21 PM, Yao Zi wrote:
> ...
>
>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>> index 79be3f516a26..635015676389 100644
>>> --- a/dwarf_loader.c
>>> +++ b/dwarf_loader.c
>>> @@ -708,6 +708,11 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
>>>    		case DW_OP_addrx:
>>>    			scope = VSCOPE_GLOBAL;
>>>    			*addr = expr[0].number;
>>> +
>>> +			if (location->exprlen == 2 &&
>>> +			    expr[1].atom == DW_OP_plus_uconst)
>>> +				addr += expr[1].number;
>> This does not work. 'addr' is the parameter and the above new 'addr' value won't
>> pass back to caller so the above is effectively a noop.
> Oops, this is a silly problem.
>
>> I think we need to add an additional parameter to pass the 'expr[1].number' back
>> to the caller, e.g.,
> However, I don't think it's necessary. See my explanation below,
>
>> static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, uint32_t *offset, struct location *location) { ... }
>>
>> and
>>
>>     in the above
>>         *offset = expr[1].number.
>>
>> Now the caller has the following information:
>>    . The deference of *addr stores the index to .debug_addr
> No, dwarf__location() invokes attr_location(), which calls
> dwarf_getlocation() and dwarf_formaddr(), the latter already performs a
> lookup in .debug_addr[1], so what is stored in *addr is right the symbol
> address.
>
> Thus I think it's enough to keep the signature, but add the offset to
> *addr.

Indeed, this does make sense. Thanks for explanation.

>
>>    . The offset to the address in .debug_addr
>> and the final address will be debug_addr[*addr] + offset.
>>
>>> +
>>>    			break;
>>>    		case DW_OP_reg1 ... DW_OP_reg31:
>>>    		case DW_OP_breg0 ... DW_OP_breg31:
> Thanks for your review, I'll soon send a patch with the missing pointer
> dereference to addr added.
>
> Best regards,
> Yao Zi
>
> [1]: https://github.com/sourceware-org/elfutils/blob/67199e1c974db37f2bd200dcca7d7103f42ed06e/libdw/dwarf_formaddr.c#L37-L77


