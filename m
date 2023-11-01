Return-Path: <bpf+bounces-13768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F37DD96F
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 01:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086E0281824
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC39823BC;
	Wed,  1 Nov 2023 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FsiTTDLz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221B1FBB
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 00:03:12 +0000 (UTC)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B9ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:03:08 -0700 (PDT)
Message-ID: <5a8520dd-0dd6-4d51-9e4a-6eebcf7e792d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698796986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=II9GjCl6Uhu3g9660eosKEHzrX3QZwb8HpcFU6+4gqc=;
	b=FsiTTDLzx2kn3jXArqQG5UxoKQM3gn+K4JfkngpiGfPp/yDPGA+mijzvjDtVoROKKs0174
	rnx2Dsnx05vGP0/YA7HtjyW9J/N5KOzU1y82lFP99MfSYta0JW4TmSXmnhOV+iwh6PBSHP
	V21SKdYH9fviUb03AgmXfsR0nn581Bc=
Date: Tue, 31 Oct 2023 17:02:56 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <10f383a2-c83b-4a40-a1f9-bcf33c76c164@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/31/23 4:34 PM, Kui-Feng Lee wrote:
>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>> index a8813605f2f6..954536431e0b 100644
>>> --- a/include/linux/btf.h
>>> +++ b/include/linux/btf.h
>>> @@ -12,6 +12,8 @@
>>>   #include <uapi/linux/bpf.h>
>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);    \
>>
>> ((void)(struct type *)0); is new. Why is it needed?
> 
> This is a trick of BTF to force compiler generate type info for
> the given type. Without trick, compiler may skip these types if these
> type are not used at all in the module.  For example, modules usually
> don't use value types of struct_ops directly.
It is not the value type and value type emit is understood. It is the struct_ops 
type itself and it is new addition in this patchset afaict. The value type emit 
is in the next line which was cut out from the context here.


