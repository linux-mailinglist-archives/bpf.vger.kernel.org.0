Return-Path: <bpf+bounces-38899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF396C352
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F366286EA4
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982C1E00AF;
	Wed,  4 Sep 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eG8D18s8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BE1E00A0
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465784; cv=none; b=A3+ZDYJKcyfHHYU+Ibu+w+AdotCNEBkWAawgZolyDhiaY0TuAVpvTe4CDaH7rwnsglcLFdZtuj1RWS4gASMJP7rGFFUU5qaeLKWoQ8d5aOso8WF/jQaZuDp3Q9MUHlXC8xrq7OjeqJ3vSclQUAgqAsssMxihQaC4zEz0stvMx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465784; c=relaxed/simple;
	bh=9WYCsjkd+S6bqAIXWVgiDRc7qOONsyXGqQ1d+E/N1Uw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cYi1HhEmzoJ/P36GVeKEcVdn2a+lAbo9zzp5oF/hajeJiWHxoluTVVDdYsJBgMZSAOV43R0BGln/+xbSW4vmwQS2ay/yK1sYrDpHPBjnOg5VQn33tZ21QdZ4nFgSDu7OB0pjPI38KUYSohc/Y4KfdjRKA3JpxqJ0cajcOq0K5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eG8D18s8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tPlOt+iHZTyU8ze70OH2R6WXbrCDFklcDqTAEhwjCko=; b=eG8D18s8oEIYaJWectPcv1Bx+W
	39mecfB8drdjGbqeLOjDD29pkGyFtybtfogC/Ig34sMCKVGf3ncMaQhBgeC5UIKxM0Ntps/VAYPlA
	gMV/9BYzjyibteF1oUqB5VkfOuJwP8FZ8Bjz6AFX77JJ0JBZQ+ejoWu4DYVVD4bKr8DhfglmJ2/Fo
	0BIPYNdz1llYXP8vm5oFh+WQGFKzDg09lD6CMFXx50mssHuL211Wr70KnDSrrWCVVgFHkaxhrxVYT
	RWTRPFphPAhDs5I/XvJE4o3Ke6N+sFVhLIwOF9E0wBvC0VW3GeUHPcRXiCw+eVD2VOqSSDnztRBpS
	YEIj3JNQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1slsTC-000MW8-Jg; Wed, 04 Sep 2024 18:02:58 +0200
Received: from [178.197.248.23] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1slsTB-000LMe-25;
	Wed, 04 Sep 2024 18:02:58 +0200
Subject: Re: [PATCH bpf 1/4] bpf: Fix helper writes to read-only maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
References: <20240823222033.31006-1-daniel@iogearbox.net>
 <CAEf4BzaLhBBPZWwPgTA8bRwxy-Zar07chWm4J9S55EusnH5Yzg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7181ad2d-b940-8046-3a8e-25a07960eeb5@iogearbox.net>
Date: Wed, 4 Sep 2024 18:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaLhBBPZWwPgTA8bRwxy-Zar07chWm4J9S55EusnH5Yzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27388/Wed Sep  4 10:40:46 2024)

On 8/28/24 12:37 AM, Andrii Nakryiko wrote:
> On Fri, Aug 23, 2024 at 3:21 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Lonial found an issue that despite user- and BPF-side frozen BPF map
>> (like in case of .rodata), it was still possible to write into it from
>> a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
>> as arguments.
>>
>> In check_func_arg() when the argument is as mentioned, the meta->raw_mode
>> is never set. Later, check_helper_mem_access(), under the case of
>> PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
>> subsequent call to check_map_access_type() and given the BPF map is
>> read-only it succeeds.
>>
>> The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
>> when results are written into them as opposed to read out of them. The
>> latter indicates that it's okay to pass a pointer to uninitialized memory
>> as the memory is written to anyway.
>>
>> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
>> Reported-by: Lonial Con <kongln9170@gmail.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   kernel/bpf/helpers.c     | 4 ++--
>>   kernel/bpf/syscall.c     | 2 +-
>>   kernel/bpf/verifier.c    | 3 ++-
>>   kernel/trace/bpf_trace.c | 4 ++--
>>   net/core/filter.c        | 4 ++--
>>   5 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b5f0adae8293..356a58aeb79b 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -538,7 +538,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
>>          .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>          .arg2_type      = ARG_CONST_SIZE,
>>          .arg3_type      = ARG_ANYTHING,
>> -       .arg4_type      = ARG_PTR_TO_LONG,
>> +       .arg4_type      = ARG_PTR_TO_LONG | MEM_UNINIT,
>>   };
>>
>>   BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
>> @@ -566,7 +566,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
>>          .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>>          .arg2_type      = ARG_CONST_SIZE,
>>          .arg3_type      = ARG_ANYTHING,
>> -       .arg4_type      = ARG_PTR_TO_LONG,
>> +       .arg4_type      = ARG_PTR_TO_LONG | MEM_UNINIT,
>>   };
>>
>>   BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index bf6c5f685ea2..6d5942a6f41f 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5952,7 +5952,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
>>          .arg1_type      = ARG_PTR_TO_MEM,
>>          .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
>>          .arg3_type      = ARG_ANYTHING,
>> -       .arg4_type      = ARG_PTR_TO_LONG,
>> +       .arg4_type      = ARG_PTR_TO_LONG | MEM_UNINIT,
>>   };
>>
>>   static const struct bpf_func_proto *
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d8520095ca03..70b0474e03a6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8877,8 +8877,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>>          case ARG_PTR_TO_INT:
>>          case ARG_PTR_TO_LONG:
>>          {
>> -               int size = int_ptr_type_to_size(arg_type);
>> +               int size = int_ptr_type_to_size(base_type(arg_type));
>>
>> +               meta->raw_mode = arg_type & MEM_UNINIT;
> 
> given all existing ARG_PTR_TO_{INT,LONG} use cases just write into
> that memory, why not just set meta->raw_mode unconditionally and not
> touch helper definitions?
> 
> also, isn't it suspicious that int_ptr_types have PTR_TO_MAP_KEY in
> it? key should always be immutable, so can't be written into, no?

That does not look right agree.. presumably copied over from mem_types for reading not
writing memory (just that none of the helpers using the arg type to actually read mem).

Also, I'm currently looking into whether it's possible to just remove the ARG_PTR_TO_{INT,LONG}
and make that a case of ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT where we just specify the
arg's size in the func proto. Two special arg cases less to look after in verifier then.

Thanks,
Daniel

