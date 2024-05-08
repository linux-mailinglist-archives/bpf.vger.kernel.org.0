Return-Path: <bpf+bounces-29143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636F8C07B5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF923282E2B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B7130E5A;
	Wed,  8 May 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuTtyr90"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F01BC40
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211352; cv=none; b=b7JQIkovLgEpHwwyfHNzmsLLC8r60olIM7z0igvVv+a+ZBQSKw7aYL+WvnK8BYat7Vk06YbLYVpPqxwkjb3akys6+wbElLQFuZ8yoTWRmh4G58zpMFSzylpgPxPJy1dG1nno/lYgiv8LHqSJrDTSI1vDPEvyWbQVl0kboyifbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211352; c=relaxed/simple;
	bh=G768bbfWad4Q8PPI4w6WWr1v+fB5yXJjiroYXmxDDEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHo7GwtCwGpElQQ+VkOCVlNqcm9F41ANWBCdxN31NcBjKYUhurf4ilmkxAF2GXf47m/jfQ0kR1eqn5jMci5ythl8hV63UWVoGdzdUgDdpHkhjU3+whT1vYJ7PHgs+OJufPWyUYuCviMDy2eE6Zuao6Z0YMX4eNYBOFlOs6Wtj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuTtyr90; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so3985711fa.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 16:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715211348; x=1715816148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0nMEmOUI9WFbSfAT5g2LVo0lPYzw7+6R3FXt6RXVio=;
        b=FuTtyr90mfTkAaoFOJ9zCntZltL/MqUf5vslMgQ210IPjDx1heszQeDnjQrmQMppSO
         l7eG9FWmxkhYtxWhn6Ws5rJMtK/59BPyN9gbga/uiqWHC9lfGWmcirOHqXICXly1RhGn
         Jx+Hyt5gs2mq5lzbf8APzdw0O08L94WDVfOSoWLIMzBs8qCo4zKGv7RbzCLJNJNV9CFp
         gTrKSca8PY4lkw/xjFSSBsZcnyL0jyJTxcgG6prfgkW73QylICLDCIO770zjcBiFTDOZ
         Rw94/DRp2uUEzZ2buaeHWf1jnNi2OXPszqC0IWrhdIJ7pkw16xHe0R1X8l4ZOg3CzskY
         6xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211348; x=1715816148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0nMEmOUI9WFbSfAT5g2LVo0lPYzw7+6R3FXt6RXVio=;
        b=nJOXQ81LMEPRHGubD9KbJlOf+lY56Yd5geDFV4XVlHVeRxSr8qvcNygnfs3jE58nhE
         f/0YFMIsGEZe1r8pVXFiM0zW5hbz4KW+l8dqqWfuJVhvyyUgHiosyoS1wM3Z8BzR8Eqp
         cyzGb0y1gv+uW/g8dFGHcISTl2azuVfEzfdxEYReg6Kk64OzoH95x2wX/ARQC/vLLqmd
         o6UXkWXN3RLoqTo1+4XP1HaqvK7RxPS/h7m9A4gIJSJPCYCuI4qOJcyutRu7Hc+7bD/8
         oKEYrTvnUoj14otVgrHxbBA/kK2mYmUyoYuibPip47b7nYGS/dDvbtaeGFDCiFUAdvWP
         7AGg==
X-Forwarded-Encrypted: i=1; AJvYcCXnwkzHKOJhB2lPY+yJcyGrwG664+zONMS+k5CIPaAgpSN3ZPQoUnUAJ5/hGFeiQJJhO0sfUu9680JepQKF4gL+0vsz
X-Gm-Message-State: AOJu0YxnPNrUU8L6aqdjh8T61RZfyK4e3KYiByEAPS4W6/1OOXCIx0AA
	ScMRE+PnOGj8hiQejhiw1yog9HT3zh1IyFrEmDNQz6ouAV4ZQoME
X-Google-Smtp-Source: AGHT+IHfcT/H2Ls7N5e4saz5n6Sgu1vTctwHMGTVC51izBjwwoQxCUhGPJUbn8zdYn3IN3sgzlCv8A==
X-Received: by 2002:a05:651c:2115:b0:2e3:3b4e:43ee with SMTP id 38308e7fff4ca-2e44738d29fmr31457451fa.19.1715211348087;
        Wed, 08 May 2024 16:35:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1131::1331? ([2620:10d:c092:400::5:54e4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea651asm90945a12.11.2024.05.08.16.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 16:35:47 -0700 (PDT)
Message-ID: <83829b9e-d561-4209-b4c7-9ef3e35708b0@gmail.com>
Date: Thu, 9 May 2024 00:35:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: introduce btf c dump sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20240506134458.727621-1-yatsenko@meta.com>
 <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
 <8ff3e0a3-faf7-4377-a4c3-8ee1aa82dd21@gmail.com>
 <CAEf4Bzar7k4P+JE2FVrcMzaXMHd6OZwvPjf7QUm5rJWoizYXZw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bzar7k4P+JE2FVrcMzaXMHd6OZwvPjf7QUm5rJWoizYXZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/9/24 00:21, Andrii Nakryiko wrote:
> On Wed, May 8, 2024 at 4:07 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 5/7/24 22:02, Andrii Nakryiko wrote:
>>> On Mon, May 6, 2024 at 6:45 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Provide a way to sort bpftool c dump output, to simplify vmlinux.h
>>>> diffing and forcing more natural definitions ordering.
>>>>
>>>> Use `normalized` argument in bpftool CLI after `format c` for example:
>>>> ```
>>>> bpftool btf dump file /sys/kernel/btf/fuse format c normalized
>>>> ```
>>>>
>>>> Definitions are sorted by their BTF kind ranks, lexicographically and
>>>> typedefs are forced to go right after their base type.
>>>>
>>>> Type ranks
>>>>
>>>> Assign ranks to btf kinds (defined in function btf_type_rank) to set
>>>> next order:
>>>> 1. Anonymous enums
>>>> 2. Anonymous enums64
>>>> 3. Named enums
>>>> 4. Named enums64
>>>> 5. Trivial types typedefs (ints, then floats)
>>>> 6. Structs
>>>> 7. Unions
>>>> 8. Function prototypes
>>>> 9. Forward declarations
>>>>
>>>> Lexicographical ordering
>>>>
>>>> Definitions within the same BTF kind are ordered by their names.
>>>> Anonymous enums are ordered by their first element.
>>>>
>>>> Forcing typedefs to go right after their base type
>>>>
>>>> To make sure that typedefs are emitted right after their base type,
>>>> we build a list of type's typedefs (struct typedef_ref) and after
>>>> emitting type, its typedefs are emitted as well (lexicographically)
>>>>
>>>> There is a small flaw in this implementation:
>>>> Type dependencies are resolved by bpf lib, so when type is dumped
>>>> because it is a dependency, its typedefs are not output right after it,
>>>> as bpflib does not have the list of typedefs for a given type.
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>    tools/bpf/bpftool/btf.c | 264 +++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 259 insertions(+), 5 deletions(-)
>>>>
> [...]
>
>>> can we avoid all this complexity with TYPEDEFs if we just rank them
>>> just like the type they are pointing to? I.e., TYPEDEF -> STRUCT is
>>> just a struct, TYPEDEF -> TYPEDEF -> INT is just an INT. Emitting the
>>> TYPEDEF type will force all the dependent types to be emitted, which
>>> is good.
>>>
>>> If we also use this "pointee type"'s name as TYPEDEF's sort name, it
>>> will also put it in the position where it should be, right? There
>>> might be some insignificant deviations, but I think it would keep the
>>> code much simpler (and either way we are striving for something that
>>> more-or-less works as expected in practice, not designing some API
>>> that's set in stone).
>>>
>>> WDYT?
>>>
>> I don't think this will guarantee for each type all typedefs follow
>> immediately.
>> For example:
>>
>> With this patch next output is generated:
>>       typedef s64 aaa; /* aaa is the smallest first level child of s64 */
>>       typedef aaa ccc; /* ccc immediately follows aaa as child */
>>       typedef s64 bbb; /* bbb is first level child of s64 following aaa */
>>       typedef s32 xxx; /* xxx follows bbb lexicographically */
>>
>> Option 2: I we apply flat sorting by rank and then name, we'll get next
>> order:
>>       typedef s64 aaa;
>>       typedef s64 bbb;
>>       typedef aaa ccc;
>>       typedef s32 xxx;
>>
>> Here order just follows aaa - bbb - ccc - xxx. Type ccc does not immediately
>> follow its parent aaa.
>>
>> Option3: If we use pointee name as sort name, next output is expected:
>>       typedef s64 aaa; /* dependency of the next line */
>>       typedef aaa ccc; /* sort name aaa */
>>       typedef s32 xxx; /* sort name s32 */
>>       typedef s64 bbb; /* sort name s64 */
>>
>> I think Option 2 will have the simplest implementation, but we are
>> getting BFS
>> ordering instead of DFS. I'm not entirely sure, but it looks to me, that we
>> can't achieve DFS ordering with sort-based simple implementation, let me
>> know if
>> I'm missing anything here.
>> If DFS ordering is not required, I'm happy to scrap it.
> I'd go with Option3, but I'd resolve ccc -> aaa -> s64 as sort name
> (so all the way to non-reference type), and use INT as rank for that
> typedef. We'd have ordering ambiguity between `ccc -> aaa -> s64`
> chain and `bbb -> s64`, to resolve that we'd need to be able to
> compare entire chains, but that would require more bookkeeping. So
> maybe let's remember both resolved name and "original" name (i.e., for
> ccc resolved would be "s64", original is "ccc"), and if the resolved
> name is the same, then compare original name. That will give the
> ordering more stability. And it's just an extra u32 to keep track per
> type in this extra sort_datum thingy. WDYT?
This will do.
> I think simple trumps whatever ideal ordering we come up with. In any
> case it's going to be pretty stable and easy to diff, so I'd go with
> that.
Agreed.
>>>> +static int *sort_btf_c(const struct btf *btf)
>>>> +{
>>>> +       int total_root_types;
>>>> +       struct sort_datum *datums;
>>>> +       int *sorted_indexes = NULL;
>>>> +       int *type_index_to_datum_index;
>>> nit: most of these names are unnecessarily verbose. It's one
>>> relatively straightforward function, just use shorter names "n",
>>> "idxs", "idx_to_datum", stuff like this. Cooler and shorter C names
>>> :))
>>>
>>>> +
>>>> +       if (!btf)
>>>> +               return sorted_indexes;
>>> this would be a horrible bug if this happens, don't guard against it here
>>>
>>>> +
>>>> +       total_root_types = btf__type_cnt(btf);
>>>> +       datums = malloc(sizeof(struct sort_datum) * total_root_types);
>>>> +
>>>> +       for (int i = 1; i < total_root_types; ++i) {
>>>> +               struct sort_datum *current_datum = datums + i;
>>>> +
>>>> +               current_datum->index = i;
>>>> +               current_datum->name = btf_type_sort_name(btf, i);
>>>> +               current_datum->type_rank = btf_type_rank(btf, i, false);
>>>> +               current_datum->emitted = false;
>>> btf_dump__dump_type() keeps track of which types are already emitted,
>>> you probably don't need to do this explicitly?
>> I use `emitted` to indicate whether type index has been copied into output
>> `sorted_indexes` array. This is needed because type (if it is a typedef)
>> can be put into output out of order by its parent base type, if base has
>> been processed earlier. It helps to avoid putting the same type twice in
>> the output array preventing buffer overrun.
> Would this still be needed if we do this sorting only approach?
Right, most of this code can be removed.
> [...]



