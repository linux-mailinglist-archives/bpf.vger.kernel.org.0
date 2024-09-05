Return-Path: <bpf+bounces-39083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A75596E61C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 01:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08C31F22E6E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 23:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6E1B2EF6;
	Thu,  5 Sep 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Gt965xdv"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148C1B3B3C
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578051; cv=none; b=sp0hNSNHy//nmKQZzGzQK0KpWZsPoHDWu7ZB3dQ/oX6qZWv3h1W5fVY17zpjUCCBYokAgNofVOqfNO75CGEeOLkY13ShCqdCwSSwIXuXi0OoIJ+pyEim+8EMvVqI97BS3kq/X/nY5mul65uwLmQ0KcNfF7fRTODmsIC7Bi3v3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578051; c=relaxed/simple;
	bh=b9oQJGJY1CKLMxyEcvkZyhGscM2FBiNdHkRK2Irs0b0=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HAbINWWEV5X8i2yNCMyfhVE0blIztxsv4h48of68b7O35y/PPttdzOJjYHPLHttKtbA2oAr/qdoUywuWGOpBVuPyN/dwc765PxEzmSpK8P8Rnv3QspvUHyhx5GNMlkYXJ0c8Zk2ELtnP88s47S2Hkt+eHfzliHHHXJzI/pGnA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Gt965xdv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yv97JjYO8sn72W249EnZZA2R8glHjNUOv+pE3hr/SQ4=; b=Gt965xdvejgyllL8lntUWkPSER
	/tcbptDRnul5uwVHUhxBUhBucuR1qY8Q9UeH1q77J1/zhsuNyQ40EEGOImbyCUfuyYQJArchdlqEe
	v47RBhdGQxXdTIZngZwqxd2jH8VVQ6QOEigNFmj3PHQZw/M4mOpOjPOBN2X4dvdLwr7g++axWfLtr
	ud4KDvwXJwwGXnCjx5srtKqHgidgcyuDvX5UsNQixNlsxHUId2vb91KSY2JLPbCgtTR+fBH/suY3g
	KgnDIYGPGJ7prqWGPCKuCFq1HfUTWO7DVXZdPL2BAiSlwJlzpV6XBO+QLo1TCrAe4CUAfGfUxujOI
	Rs1AEYzw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smLfy-0004yH-Ba; Fri, 06 Sep 2024 01:14:06 +0200
Received: from [178.197.248.15] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1smLfx-000LxK-0v;
	Fri, 06 Sep 2024 01:14:05 +0200
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Fix helper writes to read-only maps
From: Daniel Borkmann <daniel@iogearbox.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 kongln9170@gmail.com
References: <20240905134813.874-1-daniel@iogearbox.net>
 <CAADnVQJbqoXHMsC3_67xWXpvX8CjzOoRTTA7h_kZgZNOqNVW5w@mail.gmail.com>
 <14aa3075-2580-ab0d-e90d-bc29d435acd4@iogearbox.net>
 <ec71766c-d028-c88a-8a77-c9151c28670d@iogearbox.net>
Message-ID: <e3595f7e-7729-4c6b-ff79-3571b9538355@iogearbox.net>
Date: Fri, 6 Sep 2024 01:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec71766c-d028-c88a-8a77-c9151c28670d@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

On 9/6/24 12:56 AM, Daniel Borkmann wrote:
> On 9/5/24 10:27 PM, Daniel Borkmann wrote:
>> On 9/5/24 9:39 PM, Alexei Starovoitov wrote:
>>> On Thu, Sep 5, 2024 at 6:48 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index 3956be5d6440..d2c8945e8297 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -539,7 +539,9 @@ const struct bpf_func_proto bpf_strtol_proto = {
>>>>          .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>>>          .arg2_type      = ARG_CONST_SIZE,
>>>>          .arg3_type      = ARG_ANYTHING,
>>>> -       .arg4_type      = ARG_PTR_TO_LONG,
>>>> +       .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>>>> +                         MEM_UNINIT | MEM_ALIGNED,
>>>> +       .arg4_size      = sizeof(long),
>>>>   };
>>>>
>>>>   BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
>>>> @@ -567,7 +569,9 @@ const struct bpf_func_proto bpf_strtoul_proto = {
>>>>          .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>>>          .arg2_type      = ARG_CONST_SIZE,
>>>>          .arg3_type      = ARG_ANYTHING,
>>>> -       .arg4_type      = ARG_PTR_TO_LONG,
>>>> +       .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>>>> +                         MEM_UNINIT | MEM_ALIGNED,
>>>> +       .arg4_size      = sizeof(unsigned long),
>>>
>>> This is not correct.
>>> ARG_PTR_TO_LONG is bpf-side "long", not kernel side "long".
>>>
>>>> -static int int_ptr_type_to_size(enum bpf_arg_type type)
>>>> -{
>>>> -       if (type == ARG_PTR_TO_INT)
>>>> -               return sizeof(u32);
>>>> -       else if (type == ARG_PTR_TO_LONG)
>>>> -               return sizeof(u64);
>>>
>>> as seen here.
>>>
>>> BPF_CALL_4(bpf_strto[u]l, ... long *, res)
>>> are buggy.
>>
>> Right, the int_ptr_type_to_size() checks mem based on u64 vs writing
>> long in the helper which mismatches on 32bit archs.
>>
>>> but they call __bpf_strtoll which takes 'long long' correctly.
>>>
>>> The fix for BPF_CALL_4(bpf_strto[u]l and uapi/bpf.h is orthogonal,
>>> but this patch shouldn't make the verifier see it as sizeof(long).
>>
>> Ok, so I'll fix the BPF_CALL signatures for the affected helpers as
>> one more patch and also align arg*_size to {s,u}64 then so that there's
>> no mismatch.
> 
> Not fixing up BPF_CALL signatures but aligning .arg*_size to sizeof(u64)
> would fwiw keep things as today. This has the downside that on 32bit archs
> one could end up leaking out 4b of uninit mem (as verifier assumes fixed
> 64bit and in case of write there is no need to init the var as verifier
> thinks the helper will fill it all). Ugly bit is the func proto is enabled
> in bpf_base_func_proto() which is ofc available for unpriv (if someone
> actually has it turned on..).
> 
> Fixing up BPF_CALL signatures for bpf_strto{u,}l where res pointer becomes
> {s,u}64 and .arg*_size fixed 8b, would be nicer, but assuming this includes
> also the uapi helper description, then we'll also have to end up adapting
> selftests (given compiler warns on ptr type mismatch) :/
> 
> One option could be we fix up BPF_CALL sites, but not the uapi helper such
> that selftests stay as they are. For 64bit no change, but 32bit archs this
> will be subtle as we write beyond the passed/expected long inside the helper.

Nevermind, scratch the incorrect last part, only this option would do the
trick since from bpf pov its bpf-side "long" (as its unchanged in the uapi
header which gets pulled into the prog).

Thanks,
Daniel

