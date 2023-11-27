Return-Path: <bpf+bounces-16008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDA7FACFA
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 23:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F139A281B75
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242846558;
	Mon, 27 Nov 2023 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMfGZfxw"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F21AE
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 14:08:14 -0800 (PST)
Message-ID: <4880ee9f-780c-4b7c-a292-578212da8273@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701122892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7q+fGQrO2+SXT/nC1tqj+6roYzqM2+uNM9hBuItsv/o=;
	b=bMfGZfxwIdo8LBDlPf6SXf4t6kt5iZlxY53rvMCHrEum9SUK6e08XON0PXZXtKUFXjmAjN
	/60e+tOwb5Qr2CedSZQZRwbsxCDEkM36OcUsy80JvErFOqtrTHLDrQ0gUDhnmc9nNIMXmz
	E40HpM5iz7dIs2NzHoogGUG8/ohPlkc=
Date: Mon, 27 Nov 2023 14:08:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 07/13] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-8-thinker.li@gmail.com>
 <5cbae302-7fa6-5625-921a-c6f548bcc3a2@linux.dev>
 <180568df-308f-4bc5-8a54-a9f224123429@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <180568df-308f-4bc5-8a54-a9f224123429@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/22/23 2:33 PM, Kui-Feng Lee wrote:
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index 4ba6181ed1c4..2fb1b21f989a 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -635,6 +635,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>>>           bpf_jit_uncharge_modmem(PAGE_SIZE);
>>>       }
>>>       bpf_map_area_free(st_map->uvalue);
>>> +    btf_put(st_map->btf);
>>>       bpf_map_area_free(st_map);
>>>   }
>>> @@ -675,15 +676,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union 
>>> bpf_attr *attr)
>>>       struct bpf_struct_ops_map *st_map;
>>>       const struct btf_type *t, *vt;
>>>       struct bpf_map *map;
>>> +    struct btf *btf;
>>>       int ret;
>>> -    st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, 
>>> attr->btf_vmlinux_value_type_id);
>>> -    if (!st_ops_desc)
>>> -        return ERR_PTR(-ENOTSUPP);
>>> +    if (attr->value_type_btf_obj_fd) {
>>> +        /* The map holds btf for its whole life time. */
>>> +        btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
>>> +        if (IS_ERR(btf))
>>> +            return ERR_PTR(PTR_ERR(btf));
>>> +    } else {
>>> +        btf = btf_vmlinux;
>>> +        btf_get(btf);
>>> +    }
>>> +
>>> +    st_ops_desc = bpf_struct_ops_find_value(btf, 
>>> attr->btf_vmlinux_value_type_id);
>>> +    if (!st_ops_desc) {
>>> +        ret = -ENOTSUPP;
>>> +        goto errout;
>>> +    }
>>>       vt = st_ops_desc->value_type;
>>> -    if (attr->value_size != vt->size)
>>> -        return ERR_PTR(-EINVAL);
>>> +    if (attr->value_size != vt->size) {
>>> +        ret = -EINVAL;
>>> +        goto errout;
>>> +    }
>>>       t = st_ops_desc->type;
>>> @@ -694,17 +710,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union 
>>> bpf_attr *attr)
>>>           (vt->size - sizeof(struct bpf_struct_ops_value));
>>>       st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>>> -    if (!st_map)
>>> -        return ERR_PTR(-ENOMEM);
>>> +    if (!st_map) {
>>> +        ret = -ENOMEM;
>>> +        goto errout;
>>> +    }
>>> +    st_map->btf = btf;
>>
>> How about do the "st_map->btf = btf;" assignment the same as where the current 
>> code is doing (a few lines below). Would it avoid the new "btf = NULL;" dance 
>> during the error case?
>>
>> nit, if moving a line, I would move the following "st_map->st_ops_desc = 
>> st_ops_desc;" to the later and close to where "st_map->btf = btf;" is.
> 
> It would work. But, I also need to init st_map->btf as NULL. Or, it may
> fail at errout_free to free an invalid pointer if I read it correctly.

st_map->btf should have been initialized to NULL. Please check bpf_map_area_alloc().


