Return-Path: <bpf+bounces-39104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7496EC71
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CB2B250CE
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4216190C;
	Fri,  6 Sep 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FUtwlt3K"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7715DBAE
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608596; cv=none; b=gQqyC1XkpAWCeDypjHvVasTNrGaMpP2VDVks5croxNArZU8AciUBFSpfWV0kumruuYPj4XwIqRf0BfzkDdd92cBoqCFnyR4D/m/MCO6/Wo9OW0VKfGS8ahMTk/JdezfA0ndkIGyDq1PZpT1HlBNFTfYBc/MriqktEWdhpIr8OQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608596; c=relaxed/simple;
	bh=rLxsDMkjU6EcMVlJA6k9xDzkncR4T/b/Jq+BTK3IARU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ih+1a+CYGL8oE8ltlfcmFwCAsRvv6vhSCta6oputaMOGySa3kBBBwyXFTa7SuF6m2bdJLGZL/8rDAMwOgwaqz+NfE00pyFbyDSb5NLc5UsXysWKuapihcGO/ZdrnSsj0Iu3JMiPYJ3FF1usqJC7seQkICj2xkDunFm9M7UOOcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FUtwlt3K; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pANJlbadqBd4aajpAbLIDeJhbsEsHMoFZUv5d4QmDtE=; b=FUtwlt3Kai1yrvO9ePtB4ZSAw5
	6f197Uh9iyuLFXMzawrMxK5m8QylWUFOXNTejwWN/I5VsIOerQ7771eTyJgiB8Hv4Tx1CgiZuLq5i
	OpYrNeXB1igN8Mx/md9V14A4YsjwoRwj/SwAwPXG6obHklPurRJ5FvSDr4HHfcTZYuLlltvaQNejr
	JkIa/8cQHdciuz4I7/hTdL7o3HJHeQ7UYdnAWKIxY2OxnyiQlfv2dg0IPUk/GG+EiMmptHUKNPDJj
	ZfY5kr3aJPMQHqPFoVi97LiaPsN08MTaCv0m41WmjQ2F2fGEvubJRRMJQ5cc+6l2qCy8Bcqvb+FcI
	F1CqDnsA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smTcc-000BF8-HT; Fri, 06 Sep 2024 09:43:10 +0200
Received: from [178.197.248.15] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1smTcb-0006ZH-1Z;
	Fri, 06 Sep 2024 09:43:09 +0200
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Fix helper writes to read-only maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 kongln9170@gmail.com
References: <20240905134813.874-1-daniel@iogearbox.net>
 <CAADnVQJbqoXHMsC3_67xWXpvX8CjzOoRTTA7h_kZgZNOqNVW5w@mail.gmail.com>
 <14aa3075-2580-ab0d-e90d-bc29d435acd4@iogearbox.net>
 <ec71766c-d028-c88a-8a77-c9151c28670d@iogearbox.net>
 <e3595f7e-7729-4c6b-ff79-3571b9538355@iogearbox.net>
 <CAADnVQJ8p7DE8c9VumKR-r5Qk866E_gHwx_XkLqptW17b3=T8Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <481fcec8-c12c-9abb-8ecb-76c71c009959@iogearbox.net>
Date: Fri, 6 Sep 2024 09:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ8p7DE8c9VumKR-r5Qk866E_gHwx_XkLqptW17b3=T8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

On 9/6/24 2:15 AM, Alexei Starovoitov wrote:
> On Thu, Sep 5, 2024 at 4:14 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 9/6/24 12:56 AM, Daniel Borkmann wrote:
>>> On 9/5/24 10:27 PM, Daniel Borkmann wrote:
>>>> On 9/5/24 9:39 PM, Alexei Starovoitov wrote:
>>>>> On Thu, Sep 5, 2024 at 6:48 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>>>> index 3956be5d6440..d2c8945e8297 100644
>>>>>> --- a/kernel/bpf/helpers.c
>>>>>> +++ b/kernel/bpf/helpers.c
>>>>>> @@ -539,7 +539,9 @@ const struct bpf_func_proto bpf_strtol_proto = {
>>>>>>           .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>>>>>           .arg2_type      = ARG_CONST_SIZE,
>>>>>>           .arg3_type      = ARG_ANYTHING,
>>>>>> -       .arg4_type      = ARG_PTR_TO_LONG,
>>>>>> +       .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>>>>>> +                         MEM_UNINIT | MEM_ALIGNED,
>>>>>> +       .arg4_size      = sizeof(long),
>>>>>>    };
>>>>>>
>>>>>>    BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
>>>>>> @@ -567,7 +569,9 @@ const struct bpf_func_proto bpf_strtoul_proto = {
>>>>>>           .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>>>>>           .arg2_type      = ARG_CONST_SIZE,
>>>>>>           .arg3_type      = ARG_ANYTHING,
>>>>>> -       .arg4_type      = ARG_PTR_TO_LONG,
>>>>>> +       .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>>>>>> +                         MEM_UNINIT | MEM_ALIGNED,
>>>>>> +       .arg4_size      = sizeof(unsigned long),
>>>>>
>>>>> This is not correct.
>>>>> ARG_PTR_TO_LONG is bpf-side "long", not kernel side "long".
>>>>>
>>>>>> -static int int_ptr_type_to_size(enum bpf_arg_type type)
>>>>>> -{
>>>>>> -       if (type == ARG_PTR_TO_INT)
>>>>>> -               return sizeof(u32);
>>>>>> -       else if (type == ARG_PTR_TO_LONG)
>>>>>> -               return sizeof(u64);
>>>>>
>>>>> as seen here.
>>>>>
>>>>> BPF_CALL_4(bpf_strto[u]l, ... long *, res)
>>>>> are buggy.
>>>>
>>>> Right, the int_ptr_type_to_size() checks mem based on u64 vs writing
>>>> long in the helper which mismatches on 32bit archs.
>>>>
>>>>> but they call __bpf_strtoll which takes 'long long' correctly.
>>>>>
>>>>> The fix for BPF_CALL_4(bpf_strto[u]l and uapi/bpf.h is orthogonal,
>>>>> but this patch shouldn't make the verifier see it as sizeof(long).
>>>>
>>>> Ok, so I'll fix the BPF_CALL signatures for the affected helpers as
>>>> one more patch and also align arg*_size to {s,u}64 then so that there's
>>>> no mismatch.
>>>
>>> Not fixing up BPF_CALL signatures but aligning .arg*_size to sizeof(u64)
>>> would fwiw keep things as today. This has the downside that on 32bit archs
>>> one could end up leaking out 4b of uninit mem (as verifier assumes fixed
>>> 64bit and in case of write there is no need to init the var as verifier
>>> thinks the helper will fill it all). Ugly bit is the func proto is enabled
>>> in bpf_base_func_proto() which is ofc available for unpriv (if someone
>>> actually has it turned on..).
>>>
>>> Fixing up BPF_CALL signatures for bpf_strto{u,}l where res pointer becomes
>>> {s,u}64 and .arg*_size fixed 8b, would be nicer, but assuming this includes
>>> also the uapi helper description, then we'll also have to end up adapting
>>> selftests (given compiler warns on ptr type mismatch) :/
>>>
>>> One option could be we fix up BPF_CALL sites, but not the uapi helper such
>>> that selftests stay as they are. For 64bit no change, but 32bit archs this
>>> will be subtle as we write beyond the passed/expected long inside the helper.
>>
>> Nevermind, scratch the incorrect last part, only this option would do the
>> trick since from bpf pov its bpf-side "long" (as its unchanged in the uapi
>> header which gets pulled into the prog).
> 
> Right. From bpf side 'long *' is ok-sh and it's ok to stay this way
> in uapi/bpf.h and from there in bpf_helper_defs.h,
> but BPF_CALL(bpf_strol..) needs to change.
> And if we fix that we should probably change uapi/bpf.h to stay consistent.
> Maybe we should use 'u64 *' everywhere then?

I'd love to also change uapi/bpf.h, just that this needs changes in existing
BPF selftests as otherwise the build errors out e.g. on regular x86-64 with
the following (without the -Werror this is 'just' a warning):

   [...]
   progs/verifier_const.c:28:36: error: incompatible pointer types passing 'long *' to parameter of type '__s64 *' (aka 'long long *') [-Werror,-Wincompatible-pointer-types]
      28 |         bpf_strtol(buff, sizeof(buff), 0, &bar);
         |                                           ^~~~
   [...]

One could argue that these two helpers are still fairly niche, but otoh,
they've been around since 2019. :/ So I guess it's probably better to stay
with the uapi/bpf.h inconsistency that they remain at {unsigned,} long
instead of __{u,s}64 such that user code does not need to be adapted to the
signature change.

> On 32-bit archs bpf_strtol helpers were broken,
> since they were converting string to 'long long', but assigning
> result into 32-bit 'long *',
> so upper bits will be seen as uninited from bpf prog pov.
> This series are fixing the error path of uninit, but looks like
> non-error path was broken on 32-bit archs too.
> 
> Thankfully bpf_strto[u]l are the only helpers that take 'long *'.
> Other helpers use 'u64 *' in similar situations.

Agree, thankfully just those which slipped through..

