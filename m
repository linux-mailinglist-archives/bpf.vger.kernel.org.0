Return-Path: <bpf+bounces-37719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A7959EED
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B474282C11
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F841ACE11;
	Wed, 21 Aug 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZQnb2QcV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712621A4AB7;
	Wed, 21 Aug 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247710; cv=none; b=MVhyw8eBXq9aQNR19I57nq8hhEVQvXTRbB0YRg5Xhvkgr0zm8LpSU409WvxOGx3UiWkCg6F8iuOJ7IjqPD23gdi+ipOyG4ckchTBL4/EGE1Z5uCcDpL5b3Nw/PMI5Ck5FZIn+gci6MWXv/WjvSgYsP1UQrUQAI32A3rnYjxyD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247710; c=relaxed/simple;
	bh=MkfPcGdJrcxhSmK6B/Ca4Kz1Ej9DyIDDHbI8AzWw4ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWa6G+OSHBQT7cQCFah3iFt6vG3M2YTIKmwDDNgA46c6C2jabtoJP+x/xCdSGSVBGm7iPPaEwrkUJo1cxqLta7g5WuDhNS5olWMDNi3Xj0ttH5mwrT3MmF9nRLg4Wii6cOAXpsL/4HoZaUpSlPXhdfgGVAFIkbQznYmRmifUirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZQnb2QcV; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id glakslxBOiKc3glaksEN2E; Wed, 21 Aug 2024 15:41:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724247699;
	bh=2BLgy7t94FX8U1WXUO0ibqyOoeto3YzwBOvxbxYnA9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZQnb2QcV7APkpv1qZ2L8cgmcvcpMQ0UaoNdIOKRrHdFTarRnGmFhJ9J9jEpRu19uU
	 heVDFT92sJdNn+Lr2n869ryVnbqpsY4lrBH+aYNd4V8Vg3oppQGlBhZo7Mtknd3bHR
	 OmXT4UZ+l12AYOFG/hjMh9rPGFgBKT1aFao6Wy5ChUMt2A/nzAmRC8A7Gl7rBJSs/o
	 +tAHqzrSXR+jMUoAkw1S6E0yMlZugLo3lPKHFXLs+gFM8Dmrb6EX2k71CtXJmYIitI
	 oJzfIXL18LdHKgTfBQienBJqUQo7UFsi+GcX8d3mwFRMvTYT66Lq3O8k2igsdcjYoU
	 kyf+6C6bJEPeA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 15:41:39 +0200
X-ME-IP: 90.11.132.44
Message-ID: <0bcbff49-1d0a-4e59-83ea-f5c568f736a9@wanadoo.fr>
Date: Wed, 21 Aug 2024 15:41:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libbpf: Initialize st_ops->tname with strdup()
To: Soma Nakata <soma.nakata01@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821112344.54299-3-soma.nakata01@gmail.com>
 <ecd1af32-8e6b-45d3-8434-0e981fd198ea@wanadoo.fr>
 <CAOpe7SdG_Y0M5dJJ-C3NJ6-bfjHAshz+Ok-MzcBiGuaiYyTeRw@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAOpe7SdG_Y0M5dJJ-C3NJ6-bfjHAshz+Ok-MzcBiGuaiYyTeRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 15:30, Soma Nakata a écrit :
> On Wed, Aug 21, 2024 at 9:16 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 21/08/2024 à 13:23, Soma Nakata a écrit :
>>> `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
>>> and these addresses point to strings in the btf. Since their locations
>>> may change while loading the bpf program, using `strdup()` ensures
>>> `tname` is safely stored.
>>>
>>> Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
>>> ---
>>>    tools/lib/bpf/libbpf.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index a3be6f8fac09..f4ad1b993ec5 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -496,7 +496,7 @@ struct bpf_program {
>>>    };
>>>
>>>    struct bpf_struct_ops {
>>> -     const char *tname;
>>> +     char *tname;
>>>        const struct btf_type *type;
>>>        struct bpf_program **progs;
>>>        __u32 *kern_func_off;
>>> @@ -1423,7 +1423,9 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
>>>                memcpy(st_ops->data,
>>>                       data->d_buf + vsi->offset,
>>>                       type->size);
>>> -             st_ops->tname = tname;
>>> +             st_ops->tname = strdup(tname);
>>> +             if (!st_ops->tname)
>>> +                     return -ENOMEM;
>>
>> Certainly a matter of taste, but I would personally move it just after
>> "st_ops->kern_func_off = malloc()" and add the NULL check with the
>> existing ones.
>>
>> BTW, there are some memory leaks if 1 or more allocations fail in this
>> function.
>> Not sure if it is an issue or not, and what should be done in this case.
> 
> You mean the line below?
> if (!st_ops->data || !st_ops->progs || !st_ops->kern_func_off)

Yes.

> seems it says the size of them are in descending order or something.
> But regardless, this looks like a memory leak.
> I will send another patch on this.
> 
> thanks,
> 
>>
>> CJ
>>
>>
>>>                st_ops->type = type;
>>>                st_ops->type_id = type_id;
>>>
>>> @@ -8984,6 +8986,7 @@ static void bpf_map__destroy(struct bpf_map *map)
>>>        map->mmaped = NULL;
>>>
>>>        if (map->st_ops) {
>>> +             zfree(&map->st_ops->tname);
>>>                zfree(&map->st_ops->data);
>>>                zfree(&map->st_ops->progs);
>>>                zfree(&map->st_ops->kern_func_off);
>>
> 
> 


