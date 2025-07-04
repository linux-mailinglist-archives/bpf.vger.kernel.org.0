Return-Path: <bpf+bounces-62438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C92AF9B66
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9F31C25B62
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D5220F36;
	Fri,  4 Jul 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UDpKAVcv"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643A20E01E
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751659167; cv=none; b=rm+I6oBsG9jeyDDtcF8STXJ1Pz4MVf3wF25HFvcmUjP15Y9dX1OnokhrtTdNsAWA5cIn+j5Pyd2VWxf30ODlClkf6xcBrcSP4cRNmj6Vt7X9YRe7stYv8v/XCKuuMxggVVkfNStpHlfAEI9YJLnKfNQ7l6oRbYfmBZ7Um/dTBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751659167; c=relaxed/simple;
	bh=KnF3JBJ7i5a419w3cLLAYKeU9QvbhWYJzC5PfYWa2s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDpA9AS5yQV6iMqCDPKO3DzXJIOquPP6R5jmvVd1uofyOIXPme1cY4Ot2pv3HSmwst38Xg7EALIp3rsRfqKADOofvKytcNRCrAVPF4rC+QKQ0hNIqL2cMDhJdHqMbxFbByxqubpZGEPngmnwWWSZqtMFld3wkr5C5GuzrRhlg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UDpKAVcv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9a3cc94-7ce2-4993-96ab-500f250e6e25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751659152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLH+Fn7TW6MVxsCjjSkKgY3F0lgXAmP3aZAfc3J5oGI=;
	b=UDpKAVcvV9lI70aP2kRW16dsxR42tY+jsZj2f2VR+z8wlP42Y6eh6sL3wyBpUMlSy+sArz
	MqoXFrsbaZqNPpO4/j/cofyMk6O44FFONvqKowQ82FCzbXLmILlX8NB32NKtPoc/M0eUln
	N0AE/pERVvb1lcDBMx46dCnaN7/x/6s=
Date: Fri, 4 Jul 2025 12:59:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] btf_encoder: skip functions consuming packed
 structs passed by value on stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
 <20250703-btf_skip_structs_on_stack-v2-1-4767e3ba10c9@bootlin.com>
 <8923cd39-a242-4f61-b99e-b5fe5678ee84@linux.dev>
 <DB35D2MDSOGN.1X8PB5AF5M3KN@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DB35D2MDSOGN.1X8PB5AF5M3KN@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/4/25 2:01 AM, Alexis Lothoré wrote:
> Hello Ihor,
> 
> thanks for the prompt feedback and testing !
> 
> On Thu Jul 3, 2025 at 8:17 PM CEST, Ihor Solodrai wrote:
>> On 7/3/25 2:02 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> 
> [...]
> 
>>>    		/* do not exclude functions with optimized-out parameters; they
>>>    		 * may still be _called_ with the right parameter values, they
>>>    		 * just do not _use_ them.  Only exclude functions with
>>> -		 * unexpected register use or multiple inconsistent prototypes.
>>> +		 * unexpected register use, multiple inconsistent prototypes or
>>> +		 * uncertain parameters location
>>>    		 */
>>> -		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto;
>>> +		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc;
>>
>>
>> Is it possible for a function to have uncertain_parm_loc in one CU,
>> but not in another?
>>
>> If yes, we still don't want the function in BTF, right?
> 
> TBH, my understanding about those discrepancies between CUs about the same
> functions and how pahole handle them is still a bit fragile. Have you got
> any example about how it could be the case ?

I would hope stuff like this doesn't happen often in the real
world, but in principle you could have the following situation:

#ifdef ENABLE_PACKING
struct some_data {
     char header;
     int payload;
     short footer;
} __attribute__((packed));
#else
struct some_data {
     char header;
     int payload;
     short footer;
};
#endif

void read_data(/* lots of args */, struct some_data data) { ... }

And then one user has #define ENABLE_PACKING and the other doesn't,
for example:

#define ENABLE_PACKING // or not
#include "some_data.h"

void user() {
      struct some_data = get_some_data();
      ...
      read_data(/* args */, some_data);
}

And then you compile a binary with both users:

$ gcc -g -O0 user1.c user2.c

DWARF will contain both packed and not packed instances of struct
some_data and two corresponding read_data() funcs.

> 
> If it _can_ happen, I guess you are suggesting to make sure that copies are
> compared in saved_functions_combine and their uncertain_loc_parm flag are
> aligned. Something like this:
> 
> uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
> [...]
> a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;

I asked out of curiosity, but you're right that this piece is needed.

> 
>>> @@ -2693,6 +2736,9 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>>    		if (!func)
>>>    			continue;
>>>    
>>> +		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
>>> +			fn->proto.uncertain_parm_loc = 1;
>>> +
>>>    		err = btf_encoder__save_func(encoder, fn, func);
>>
>> I think checking and setting uncertain_parm_loc flag should be done
>> inside btf_encoder__save_func(), because that's where we inspect DWARF
>> function prototype and add a new btf_encoder_func_state.
> 
> ACK, it can be moved there
> 
> Thanks,
> 
> Alexis
> 


