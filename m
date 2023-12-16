Return-Path: <bpf+bounces-18095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62287815A77
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A3285B58
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4530351;
	Sat, 16 Dec 2023 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKR6ahRD"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAC3172E
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9dce9dca-f48b-4853-b1a5-a5ee0e22fc4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702744896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1FrPg50NR1gK5rFLBF37T83NFnenM/lZG1xZKz+pco=;
	b=cKR6ahRD1IRZUSbyNwePEqOmz6U4HTLCiXD/JrhZ4RS0btIDS4Ez6Ut9XIpBEuOEbQbc8O
	OzhfASYUP95lqUyBtvShjc3+5VEN0vnkU9NfqURpIqCTpyJ9TVq+639EFihOkxIRMqkzNB
	lupII+51OYY+UNDglUoKP0bUUztDzdk=
Date: Sat, 16 Dec 2023 08:41:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 07/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-8-thinker.li@gmail.com>
 <4e6bff53-a219-4c69-a662-75e097100c9c@linux.dev>
 <e2222287-6438-4de7-a747-9e04c5fd3f55@gmail.com>
 <3fd164b6-622e-499e-9fa4-6d56442b086f@linux.dev>
 <a3ab56ff-ca03-4f28-b2e7-4f0b50bfaaae@gmail.com>
 <390f3c92-2df6-4cea-aa78-ecc92a9fe8aa@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <390f3c92-2df6-4cea-aa78-ecc92a9fe8aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/15/23 10:07 PM, Kui-Feng Lee wrote:
> 
> 
> On 12/15/23 21:55, Kui-Feng Lee wrote:
>>
>>
>> On 12/15/23 16:19, Martin KaFai Lau wrote:
>>> On 12/15/23 2:10 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 12/14/23 18:44, Martin KaFai Lau wrote:
>>>>> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>>>>>> @@ -681,15 +682,30 @@ static struct bpf_map 
>>>>>> *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>>>>       struct bpf_struct_ops_map *st_map;
>>>>>>       const struct btf_type *t, *vt;
>>>>>>       struct bpf_map *map;
>>>>>> +    struct btf *btf;
>>>>>>       int ret;
>>>>>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>>>>>> attr->btf_vmlinux_value_type_id);
>>>>>> -    if (!st_ops_desc)
>>>>>> -        return ERR_PTR(-ENOTSUPP);
>>>>>> +    if (attr->value_type_btf_obj_fd) {
>>>>>> +        /* The map holds btf for its whole life time. */
>>>>>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>>>>>> +        if (IS_ERR(btf))
>>>>>> +            return ERR_PTR(PTR_ERR(btf));
>>>>>
>>>>>              return ERR_CAST(btf);
>>>>>
>>>>> It needs to check for btf_is_module:
>>>>>
>>>>>          if (!btf_is_module(btf)) {
>>>>>              btf_put(btf);
>>>>>              return ERR_PTR(-EINVAL);
>>>>>          }
>>>>
>>>> Even btf is btf_vmlinux the kernel's btf, it still works.
>>>
>>> btf could be a bpf program's btf. It needs to ensure it is a kernel module 
>>> btf here.
>>
>> Got it!
> 
> Isn't btf_is_kernel() better here?
> User space may pass a fd to btf_vmlinux.

Limit it to btf_is_module. What is the benefit of supporting btf_vmlinux as a fd 
while fd 0 already means btf_vmlinux?

kfunc does not support the btf_vmlinux as fd also, supporting in struct_ops 
alone is confusing. I don't think the major user (libbpf) does this either, so 
really not much usage other than a confusing API to have both fd == 0 and a 
btf_vmlinux's fd to mean btf_vmlinux.

> 
>>
>>>
>>>> Although libbpf pass 0 as the value of value_type_btf_obj_fd for
>>>> btf_vmlinux now, it should be OK for a user space loader to
>>>> pass a fd of btf_vmlinux.
>>>>
>>>> WDYT?
>>>


