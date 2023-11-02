Return-Path: <bpf+bounces-13863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC137DE93F
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB686B211AB
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA4EA1;
	Thu,  2 Nov 2023 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v0Ox2HDu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08F7E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:17:35 +0000 (UTC)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FAC110
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:17:29 -0700 (PDT)
Message-ID: <331802b3-07bd-7fec-32a7-b85a8dae1391@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698884247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlslLN7k8YpXoDWhURQaCChN5qxTCrjA15h4JQO7JZo=;
	b=v0Ox2HDuGM7eKm3I7RriTzNdADD3LDHD3vUrOKW1ulVrwz/gwuMaZ64zsWMmfLHmtukvj/
	18UT23zVgdku2ojXFDglf8UQlER5TTWW7R/x6NNCFJWCCWWhTweVu4gJMkLTbIzXbqLOh3
	5mXmt+x29fHfSHuwewPEI/mXcdRS4cE=
Date: Wed, 1 Nov 2023 17:17:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 07/10] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 thinker.li@gmail.com, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-8-thinker.li@gmail.com>
 <183fd964-8910-b7e6-436a-f5f82c2bafb0@linux.dev>
 <10f383a2-c83b-4a40-a1f9-bcf33c76c164@gmail.com>
 <5a8520dd-0dd6-4d51-9e4a-6eebcf7e792d@linux.dev>
 <51be2e5e-8def-45c5-8864-6b0dcc794300@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <51be2e5e-8def-45c5-8864-6b0dcc794300@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/31/23 5:19 PM, Kui-Feng Lee wrote:
> 
> 
> On 10/31/23 17:02, Martin KaFai Lau wrote:
>> On 10/31/23 4:34 PM, Kui-Feng Lee wrote:
>>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>>> index a8813605f2f6..954536431e0b 100644
>>>>> --- a/include/linux/btf.h
>>>>> +++ b/include/linux/btf.h
>>>>> @@ -12,6 +12,8 @@
>>>>>   #include <uapi/linux/bpf.h>
>>>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>>>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);    \
>>>>
>>>> ((void)(struct type *)0); is new. Why is it needed?
>>>
>>> This is a trick of BTF to force compiler generate type info for
>>> the given type. Without trick, compiler may skip these types if these
>>> type are not used at all in the module.  For example, modules usually
>>> don't use value types of struct_ops directly.
>> It is not the value type and value type emit is understood. It is the 
>> struct_ops type itself and it is new addition in this patchset afaict. The 
>> value type emit is in the next line which was cut out from the context here.
>>
> I mean both of them are required.
> In the case of a dummy implementation, struct_ops type itself properly never 
> being used, only being declared by the module. Without this line,

Other than bpf_dummy_ops, after reg(), the struct_ops->func() must be used 
somewhere in the kernel or module. Like tcp must be using the tcp_congestion_ops 
after reg(). bpf_dummy_ops is very special and probably should be moved out to 
bpf_testmod somehow but this is for later. Even bpf_dummy_ops does not have an 
issue now. Why it is needed after the kmod support change?

or it is a preemptive addition to be future proof only?

Addition is fine if it is required to work. I am trying to understand why this 
new addition is needed after the kmod support change. The reason why this is 
needed after the kmod support change is not obvious from looking at the code. 
The commit message didn't mention why and what broke after this kmod change. If 
someone wants to clean it up a few months later, we will need to figure out why 
it was added in the first place.


> the module developer will fail to load a struct_ops map of the dummy
> type. This line is added to avoid this awful situation.
> 


