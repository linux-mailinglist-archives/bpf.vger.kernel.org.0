Return-Path: <bpf+bounces-18063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245868155EA
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C271C23B04
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D361106;
	Sat, 16 Dec 2023 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VE9E7FSI"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0C10EE
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44dc6eb4-d524-4180-8970-4eef2a9b9f58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702689595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAEcl4cquQqM7eNM00aJdC3UaEH8nY11mNPK2QM2iFM=;
	b=VE9E7FSIRJLAzUZuHofLs9TT3Y9KQsbK+p1Kyu+NtEMtWIpExzeR2wZC016p7TChKO2nDP
	kpXiAiBugMAS5xS3dr76b9UZcFByIvBdrA7yM1fo7kS+TFokBwiJKfV8rLar211xJib3Yr
	AqAK+JmMvemZcTWB6gLhGgPFp8cq6Eo=
Date: Fri, 15 Dec 2023 17:19:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-5-thinker.li@gmail.com>
 <466399be-c571-48af-8f48-8365689d4d20@linux.dev>
 <fc15849b-2f71-420e-aab4-7a20014cba49@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fc15849b-2f71-420e-aab4-7a20014cba49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/15/23 1:42 PM, Kui-Feng Lee wrote:
> 
> 
> On 12/14/23 18:22, Martin KaFai Lau wrote:
>> On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
>>> +const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 
>>> *ret_cnt)
>>> +{
>>> +    if (!btf)
>>> +        return NULL;
>>> +    if (!btf->struct_ops_tab)
>>
>>          *ret_cnt = 0;
>>
>> unless the later patch checks the return value NULL before using *ret_cnt.
>> Anyway, better to set *ret_cnt to 0 if the btf has no struct_ops.
>>
>> The same should go for the "!btf" case above but I suspect the above !btf 
>> check is unnecessary also and the caller should have checked for !btf itself 
>> instead of expecting a list of struct_ops from a NULL btf. Lets continue the 
>> review on the later patches for now to confirm where the above !btf case might 
>> happen.
> 
> Checking callers, I didn't find anything that make btf here NULL so far.

> It is safe to remove !btf check. For the same reason as assigning
> *ret_cnt for safe, this check should be fine here as well, right?

If for safety, why ref_cnt is not checked for NULL also? The userspace passed-in 
btf should have been checked for NULL long time before reaching here. There is 
no need to be over protective here. It would really need a BUG_ON instead if btf 
was NULL here (don't add a BUG_ON though).

afaict, no function in btf.c is checking the btf argument for NULL also.

> 
> I don't have strong opinion here. What I though is to keep the values
> as it is without any side-effect if the function call fails and if
> possible. And, the callers should not expect the callee to set some
> specific values when a call fails.

For *ref_cnt stay uninit, there is a bug in patch 10 which exactly assumes 0 is 
set in *ret_cnt when there is no struct_ops. It is a good signal on how this 
function will be used.

I think it is arguable whether returning NULL here is failure. I would argue 
getting a 0 struct_ops_desc array is not a failure. It is why the !btf case 
confuses the return NULL case to mean a never would happen error instead of 
meaning there is no struct_ops. Taking out the !btf case, NULL means there is no 
struct_ops (instead of failure), so 0 cnt.

Anyhow, either assign 0 to *ret_cnt here, or fix patch 10 to init the local cnt 
0 and write a warning comment here in btf_get_struct_ops() saying ret_cnt won't 
be set when there is no struct_ops in the btf.

When looking at it again, how about moving the bpf_struct_ops_find_*() to btf.c. 
Then it will avoid the need of the new btf_get_struct_ops() function. 
bpf_struct_ops_find_*() can directly use the btf->struct_ops_tab.


> 
>>
>>> +        return NULL;
>>> +
>>> +    *ret_cnt = btf->struct_ops_tab->cnt;
>>> +    return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
>>> +}
>>


