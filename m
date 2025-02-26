Return-Path: <bpf+bounces-52662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FADA466AB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DC31893AC5
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FBC21CC42;
	Wed, 26 Feb 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xpNgXRUx"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CC21C9EE
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586387; cv=none; b=L5LkLAT8SF+Pq+IDQu1qioyQmJv1fr+0ZxdFuj5yF/YBdHNxkKOa9s9Vn92dKtgc8jQJN6wsOeQFUjkdFz4C2xJcAnwlJg5asNzoM2FbZDibCzmerXsLlZL4EzKxN4rw2QOv6ibNTOTbby+7xCkIkpNOzK0j7WfPwDsfueacTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586387; c=relaxed/simple;
	bh=RV4lGEBV81Z+92LHml9fS51Bf3ENT147Wq54pIkmsRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzxPD7X2nv6JI6+DWOz32FxP0aHvYJhuJKQ6QYHoKDnmRpQNO1QGpnri3WPezzSmL4y7yyNb5iR+fBcQzjYnzUemVWQv1EuF+zhPzVOjh3WpBmyDuxiGkcJpiQtS1FS8/YWJsG4dcTzQ7RP4s7cHMIN3CLwfy6MxNvPKr06hUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xpNgXRUx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6ca704d9-38e7-4fcf-ba98-b042a3478437@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740586383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YBsQG6NRLXGGEvQgjdny/pGJUEtuExOqlG81p+SrYc=;
	b=xpNgXRUxPXRK/KldnTUS35YXx9dy9XV3pZ7kjXFdKtBYTDJLjtgygM/jq5B4Rofmk6fYyM
	FOnm4zZBewEnJ1ioPfMUtF5EXdSKiAhMqhMdMxHvqV2tw8AhHD9fei+GDeuZ+EMEv9prAi
	PqoJvyH4CXvlHk+AvMzfVPqhon8wCIU=
Date: Thu, 27 Feb 2025 00:12:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-2-leon.hwang@linux.dev>
 <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
 <b49cbd71-6b2d-4c83-be5d-4fc56fdb3447@linux.dev>
 <CAADnVQLFtSGjHxdY4Q8Rjw0WVJJaXsvCuaQwPYZUX+N5w8AcHw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLFtSGjHxdY4Q8Rjw0WVJJaXsvCuaQwPYZUX+N5w8AcHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/26 23:31, Alexei Starovoitov wrote:
> On Wed, Feb 26, 2025 at 6:54 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 2025/2/26 10:19, Hou Tao wrote:
>>> Hi,
>>>
>>
>> [...]
>>
>>>> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
>>>>      .map_get_next_key = array_map_get_next_key,
>>>>      .map_lookup_elem = percpu_array_map_lookup_elem,
>>>>      .map_gen_lookup = percpu_array_map_gen_lookup,
>>>> +    .map_direct_value_addr = percpu_array_map_direct_value_addr,
>>>> +    .map_direct_value_meta = percpu_array_map_direct_value_meta,
>>>>      .map_update_elem = array_map_update_elem,
>>>>      .map_delete_elem = array_map_delete_elem,
>>>>      .map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 9971c03adfd5d..5682546b1193e 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>>>>      u64 addr;
>>>>      int err;
>>>>
>>>> +    if (map->map_type != BPF_MAP_TYPE_ARRAY)
>>>> +            return -EINVAL;
>>>
>>> Is the check still necessary ? Because its caller has already added the
>>> check of map_type.
>>
>> Yes. It should check here in order to make sure the code logic in
>> bpf_map_direct_read() is robust enough.
>>
>> But in check_mem_access(), if map is a read-only percpu array map, it
>> should not track its contents as SCALAR_VALUE, because the read-only
>> .percpu, named .ropercpu, hasn't been supported yet.
>>
>> Should we implement .ropercpu in this patch set, too?
> 
> Absolutely not and not tomorrow either. There is no use case
> for readonly percpu data. It's only a waste of memory.
> 

Yeah. I realize it absolutely wastes memory for read-only percpu data
after sending this message.

>>>>      err = map->ops->map_direct_value_addr(map, &addr, off);
>>>>      if (err)
>>>>              return err;
>>>> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>>>>                      /* if map is read-only, track its contents as scalars */
>>>>                      if (tnum_is_const(reg->var_off) &&
>>>>                          bpf_map_is_rdonly(map) &&
>>>> +                        map->map_type == BPF_MAP_TYPE_ARRAY &&
>>>>                          map->ops->map_direct_value_addr) {
>>>>                              int map_off = off + reg->var_off.value;
>>>>                              u64 val = 0;
>>>
>>> Do we also need to check in check_ld_imm() to ensure the dst_reg of
>>> bpf_ld_imm64 on a per-cpu array will not be treated as a map-value-ptr ?
>> No. The dst_reg of ld_imm64 for percpu array map must be treated as
>> map-value-ptr, just like the one for array map.
> 
> I suspect what Hou is hinting at that if percpu array rejected
> BPF_F_RDONLY_PROG in map_alloc_check() there would be no need
> to special case everything but "+ map->map_type == BPF_MAP_TYPE_ARRAY"
> here.

We could reject BPF_F_RDONLY_PROG in array_map_check_btf() instead, as
it can recognize when a percpu array is used for .percpu.

However, can we completely eliminate all map->map_type checks except for
this one? I have my doubts. Those checks are in place to prevent the
misuse of percpu data.

