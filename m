Return-Path: <bpf+bounces-39188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636E196FFD1
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49343B22A31
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10493A1B5;
	Sat,  7 Sep 2024 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LmmIuOdT"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876E17BB4;
	Sat,  7 Sep 2024 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725679619; cv=none; b=cuPazRVmKeoOY8HeCxSMIx08ufTAuMe/e80JsHuNgjVzSu9WOUImzRLekWxkjwsCPFURD1iOKEKCXA4NkNkCpGtDHin4IMR0tWL4dDkpzr4rKxj+uhW+DczHJPtuBs4yWB3A8m1UpKUHU0PNuQy4N+qw3nY6I9Hpbidur1HaTao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725679619; c=relaxed/simple;
	bh=iLx+60992UKgTf7j5wreFIgwbCS5JWRm7aBPzVqJ0PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0K+evFiyyeNWRF7InX+QkRFWY4vltxj2JVjP3jdb1jqRuShHPPRQb09E/9Uu0WqOWLIiDc00nJR4P0qJoMLjLJUkYaJAgBhwZHQDJ2gqTpH7VYJqkDnmdP+HGWHHS+yc4vKUvPbqEOXZbR7Tz4Usf0uPZnJoXaiHy8z+r9Qo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LmmIuOdT; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725679613; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o6YIDB8+pEgPLL7mV5g7GEb+/wtfGn39UknKm3MtQNM=;
	b=LmmIuOdT3kCm9fZ/w0KeT0Ac5Or+lN071p+3tbnt95pHmumhIooo6D92isrqHtTdizg/mB8qm8QdoC3SKcdqGIwM872MGVK3ctcmEuXsjtD28290l6YUUiOchSe8LAopJ9VG5Y+xGyl31Wq4h/dK0Js6ym2rsDirvUpc/0Yz+z4=
Received: from 30.13.147.236(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WERGaMf_1725679610)
          by smtp.aliyun-inc.com;
          Sat, 07 Sep 2024 11:26:51 +0800
Message-ID: <48d5c3df-8735-4aa9-afe3-bfcd32f7cfe8@linux.alibaba.com>
Date: Sat, 7 Sep 2024 11:26:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Support __nullable argument suffix
 for tp_btf
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, edumazet@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 thinker.li@gmail.com, juntong.deng@outlook.com, jrife@google.com,
 alan.maguire@oracle.com, davemarchevsky@fb.com, dxu@dxuuu.xyz,
 vmalik@redhat.com, cupertino.miranda@oracle.com, mattbobrowski@google.com,
 xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
 <20240905075622.66819-2-lulie@linux.alibaba.com>
 <CAEf4BzYjGaJGzw+dXCOhUwJS-QhyZ-_sWL6Oo8yUXOoeWWA1=w@mail.gmail.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <CAEf4BzYjGaJGzw+dXCOhUwJS-QhyZ-_sWL6Oo8yUXOoeWWA1=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/7 05:25, Andrii Nakryiko wrote:
> On Thu, Sep 5, 2024 at 12:56 AM Philo Lu <lulie@linux.alibaba.com> wrote:
>>
>> Pointers passed to tp_btf were trusted to be valid, but some tracepoints
>> do take NULL pointer as input, such as trace_tcp_send_reset(). Then the
>> invalid memory access cannot be detected by verifier.
>>
>> This patch fix it by add a suffix "__nullable" to the unreliable
>> argument. The suffix is shown in btf, and PTR_MAYBE_NULL will be added
>> to nullable arguments. Then users must check the pointer before use it.
>>
>> A problem here is that we use "btf_trace_##call" to search func_proto.
>> As it is a typedef, argument names as well as the suffix are not
>> recorded. To solve this, I use bpf_raw_event_map to find
>> "__bpf_trace##template" from "btf_trace_##call", and then we can see the
>> suffix.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>>   kernel/bpf/btf.c      | 13 +++++++++++++
>>   kernel/bpf/verifier.c | 36 +++++++++++++++++++++++++++++++++---
>>   2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 1e29281653c62..157f5e1247c81 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -6385,6 +6385,16 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
>>          }
>>   }
>>
>> +static bool prog_arg_maybe_null(const struct bpf_prog *prog, const struct btf *btf,
>> +                               const struct btf_param *arg)
>> +{
>> +       if (prog->type != BPF_PROG_TYPE_TRACING ||
>> +           prog->expected_attach_type != BPF_TRACE_RAW_TP)
>> +               return false;
>> +
>> +       return btf_param_match_suffix(btf, arg, "__nullable");
> 
> why does this need to be BPF_TRACE_RAW_TP-specific logic? Are we
> afraid that there might be "some_arg__nullable" argument name?..
> 

Yes. I don't think the check is necessary but I'm not quite sure if it 
affects other prog/attach types. It's ok for me to remove the check. I 
added it just because this __nullable suffix only serves tp_btf now.

And thanks for your nice suggestions. I'll fix them in the next version.

Also, thanks for the information about retsnoop. Our solutions seem to 
be similar, and I'll look into it further. Honestly, it takes me some 
time to get argument names from tp_btf, and I cannot find a better 
solution but to use btp->bpf_func with kallsyms...

-- 
Philo


