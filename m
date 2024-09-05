Return-Path: <bpf+bounces-39072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2496E453
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455B21F2713B
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6DE1917E0;
	Thu,  5 Sep 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OXn3KIOc"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFB17839C
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569198; cv=none; b=SiJn8gPH1AmyrUPhy2YUOH9K/MPiUuNb/bHeg2iFBwZch1+MnDyV+qE/sdu06spOd6G9lGa+lPjedJFexP3deS7VQfgKgo5epu4bkdZLkXasixTSx+KCHNciSYmMBiwI2P39w/tmgNUDmsgsK7CkI8kjgIlMuK+VyqDYD90zkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569198; c=relaxed/simple;
	bh=9UgOlqAJ1NVnr3CBtNrLJlsQo+rN7FH/1d8QKyds9ZI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ClVz0rfbxPCHBgVGW02XYUE1NlTNpSh8h1Poj2YzQaMgU1u2PNeKpvlaFWI+HEBKV5h8rW6JMuDfUazrKa9n1Fh9Y+uZ+fdJ/YEvD3orNf4LbNlh+yrUpDYqf1JPo3VlsO9LNAhterQzbfxW+9h9Rxx2n8cBaLANVzTzDngmFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OXn3KIOc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H2FJj/RsNFf+Ta8hb3UaIua2T2O8Z1PwDWGEbn1dlDs=; b=OXn3KIOcMBW9Miyk4LRfV5Mt06
	QcFuaoD/pcgtJazlA4cuR+nYdXTRKc/fJGOI1RdC5zjDDVdODaDrLqWXRmY7skX+ACdUq2NDuNlJ6
	NRUQnrNMSetJ7J3UqasApL6MF/XTnHhbKGfh6AECcN73rXDVZ7feZo1wfg3VPdk8Z+6fdUqphNWjh
	jbbSo/JnNVUBzElPoSCL2llnvUEf7o8vJlx/o64p4o+AJedTcQagAFs/fd1zwvIMn5Qp86P7usaaL
	huvzBIyRfpln4tsUJMMWMulL5v+KuEctsHeza0iVE6EaEWLDD9ILU3wHYmu+esfMFqYmvYVRckAJ2
	mIpIiEKA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1smJ4N-000A24-Ib; Thu, 05 Sep 2024 22:27:07 +0200
Received: from [178.197.248.15] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1smJ4N-000Nhg-1w;
	Thu, 05 Sep 2024 22:27:06 +0200
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Fix helper writes to read-only maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 kongln9170@gmail.com
References: <20240905134813.874-1-daniel@iogearbox.net>
 <CAADnVQJbqoXHMsC3_67xWXpvX8CjzOoRTTA7h_kZgZNOqNVW5w@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <14aa3075-2580-ab0d-e90d-bc29d435acd4@iogearbox.net>
Date: Thu, 5 Sep 2024 22:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJbqoXHMsC3_67xWXpvX8CjzOoRTTA7h_kZgZNOqNVW5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27389/Thu Sep  5 10:33:25 2024)

On 9/5/24 9:39 PM, Alexei Starovoitov wrote:
> On Thu, Sep 5, 2024 at 6:48 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 3956be5d6440..d2c8945e8297 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -539,7 +539,9 @@ const struct bpf_func_proto bpf_strtol_proto = {
>>          .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>          .arg2_type      = ARG_CONST_SIZE,
>>          .arg3_type      = ARG_ANYTHING,
>> -       .arg4_type      = ARG_PTR_TO_LONG,
>> +       .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>> +                         MEM_UNINIT | MEM_ALIGNED,
>> +       .arg4_size      = sizeof(long),
>>   };
>>
>>   BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
>> @@ -567,7 +569,9 @@ const struct bpf_func_proto bpf_strtoul_proto = {
>>          .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>          .arg2_type      = ARG_CONST_SIZE,
>>          .arg3_type      = ARG_ANYTHING,
>> -       .arg4_type      = ARG_PTR_TO_LONG,
>> +       .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM |
>> +                         MEM_UNINIT | MEM_ALIGNED,
>> +       .arg4_size      = sizeof(unsigned long),
> 
> This is not correct.
> ARG_PTR_TO_LONG is bpf-side "long", not kernel side "long".
> 
>> -static int int_ptr_type_to_size(enum bpf_arg_type type)
>> -{
>> -       if (type == ARG_PTR_TO_INT)
>> -               return sizeof(u32);
>> -       else if (type == ARG_PTR_TO_LONG)
>> -               return sizeof(u64);
> 
> as seen here.
> 
> BPF_CALL_4(bpf_strto[u]l, ... long *, res)
> are buggy.

Right, the int_ptr_type_to_size() checks mem based on u64 vs writing
long in the helper which mismatches on 32bit archs.

> but they call __bpf_strtoll which takes 'long long' correctly.
> 
> The fix for BPF_CALL_4(bpf_strto[u]l and uapi/bpf.h is orthogonal,
> but this patch shouldn't make the verifier see it as sizeof(long).

Ok, so I'll fix the BPF_CALL signatures for the affected helpers as
one more patch and also align arg*_size to {s,u}64 then so that there's
no mismatch.

Thanks,
Daniel

