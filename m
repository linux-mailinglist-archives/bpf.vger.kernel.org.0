Return-Path: <bpf+bounces-10098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FC47A10DA
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 00:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF75F1C215E7
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE969273E5;
	Thu, 14 Sep 2023 22:16:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B0273D8
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 22:16:27 +0000 (UTC)
Received: from out-212.mta1.migadu.com (out-212.mta1.migadu.com [IPv6:2001:41d0:203:375::d4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1D2D4E
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 15:16:26 -0700 (PDT)
Message-ID: <cf8257ad-6dbb-3529-4dc7-ff92d2b428a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694729784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlndV5xoe1+caV++nDpyLure5nzdczZq8WEUsVPta1Q=;
	b=gi9M0KHI+HQy6+2TbWDRS5KmpRJiYtLLyAVr8k7mwq8hUPllz+TykhlZ6eWschVaoffO2U
	sTdJ+Iwu3O5LESxXQsULIjQ9yT5SYrPyYFwHo1nFFIpJME1xtI69yljHpmZjMEHmGdRa8I
	RzCj/sDROLEvUZLEQLHeclq6GEFGnPY=
Date: Thu, 14 Sep 2023 15:16:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Charge modmem for struct_ops trampoline
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20230913222632.3312183-1-song@kernel.org>
 <208035ba-3016-c9ba-92e4-fe2cee797ca8@linux.dev>
 <CAPhsuW4LykHS9pnaaYuxgnoKMbVaxDpCKfL8OQxsjQGMnXqXPA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAPhsuW4LykHS9pnaaYuxgnoKMbVaxDpCKfL8OQxsjQGMnXqXPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/14/23 2:28 PM, Song Liu wrote:
> On Thu, Sep 14, 2023 at 2:14 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 9/13/23 3:26 PM, Song Liu wrote:
>>> Current code charges modmem for regular trampoline, but not for struct_ops
>>> trampoline. Add bpf_jit_[charge|uncharge]_modmem() to struct_ops so the
>>> trampoline is charged in both cases.
>>>
>>> Signed-off-by: Song Liu <song@kernel.org>
>>> ---
>>>    kernel/bpf/bpf_struct_ops.c | 13 +++++++++++--
>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index fdc3e8705a3c..ea6ca87a2ed9 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -615,7 +615,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>>>        if (st_map->links)
>>>                bpf_struct_ops_map_put_progs(st_map);
>>>        bpf_map_area_free(st_map->links);
>>> -     bpf_jit_free_exec(st_map->image);
>>> +     if (st_map->image) {
>>> +             bpf_jit_free_exec(st_map->image);
>>> +             bpf_jit_uncharge_modmem(PAGE_SIZE);
>>> +     }
>>>        bpf_map_area_free(st_map->uvalue);
>>>        bpf_map_area_free(st_map);
>>>    }
>>> @@ -657,6 +660,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>        struct bpf_struct_ops_map *st_map;
>>>        const struct btf_type *t, *vt;
>>>        struct bpf_map *map;
>>> +     int ret;
>>>
>>>        st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
>>>        if (!st_ops)
>>> @@ -681,6 +685,12 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>>        st_map->st_ops = st_ops;
>>>        map = &st_map->map;
>>>
>>> +     ret = bpf_jit_charge_modmem(PAGE_SIZE);
>>> +     if (ret) {
>>> +             __bpf_struct_ops_map_free(map);
>>> +             return ERR_PTR(ret);
>>> +     }
>>
>>
>> This just came to my mind when reading it again.
>>
>> It will miss a bpf_jit_uncharge_modmem() if the bpf_jit_alloc_exec() at a few
>> lines below did fail (meaning st_map->image is NULL). It is because the
>> __bpf_struct_ops_map_free() only uncharge if st_map->image is not NULL.
> 
> Indeed. This is a problem.
> 
>>
>> How above moving the bpf_jit_alloc_exec() to here (immediately after
>> bpf_jit_charge_modem succeeded). Like,
>>
>>          st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
>>          if (!st_map->image) {
>>                  bpf_jit_uncharge_modmem(PAGE_SIZE);
>>                  __bpf_struct_ops_map_free(map);
>>                  return ERR_PTR(-ENOMEM);
>>          }
>>
>> Then there is also no need to test 'if (st_map->image)' in
>> __bpf_struct_ops_map_free().
> 
> I think we still need this test for uncharge, no?

You are right, somehow I thought the above bpf_jit_charge_modmem's failure path 
could directly use the bpf_map_area_free() instead of 
__bpf_struct_ops_map_free(). Agree, lets keep it consistent, call 
__bpf_struct_ops_map_free() on all failure paths and keep the 'if 
(st_map->image)' check there. Thanks.



