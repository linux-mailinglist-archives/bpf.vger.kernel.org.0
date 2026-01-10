Return-Path: <bpf+bounces-78437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EC9D0CB3D
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74AB2300DB0A
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CE71A9FB0;
	Sat, 10 Jan 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m9nP37om"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510B139D0A
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008617; cv=none; b=Tb3a0XMVQo3uvETaRGz7RCa4CvU2J415Ou0pLSns68S3gww8bmKWzFkGdfIzztXSJZU/T146bRRdnlR8anslog9dDaJ1amEfLWDwo0pybRZoadIJJ/3TUHaw/x6sOXPuB0iy7ZCs+iZXk0IXOOV8XnRObRjkJ8ETtZDxAoSssjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008617; c=relaxed/simple;
	bh=DVYCzLxU139yfhMgB9M1/QojrzdtrbaUcBYe+FMVip0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwMFVpq04q5hD/2IpQ3do0F4IoMxLsVIKFSe+MU/GcKwPHwianEAx3s6kqiNqNUa+/5dzufu0nhyjO19ODhcyfRlL1o4fUrE8aM1W+ttCQ71o5HmGn7R+WD1nXvOQfIEyXhSUI5gtChvu9OB9KRbaSvIW6SJFevSwFu3Kya2DkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m9nP37om; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32fe65fa-ecfb-4cba-bd0c-61155bca637b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768008613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPJbgX2l1C9dajWiW9V8qfqPRBvAsaYcuEHxcxF4/RM=;
	b=m9nP37om5IlF8YoGdVxmq58fnJUhUDgIkfaSFUNUxhNC/AN/bg1ZzyuOxI7h6Jmvx4elkc
	AvXiT7k+s8rvLFrGzIiIOAdZhYsGqfhc6qY0KLoE/f/eWg+a1n/opMVPSw6zXtfOaA7gxn
	Co9LmhEOsGKe6sXjSnPcrBiVzsH+iQQ=
Date: Fri, 9 Jan 2026 17:29:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 05/10] selftests/bpf: Add tests for
 KF_IMPLICIT_ARGS
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-6-ihor.solodrai@linux.dev>
 <CAEf4BzZfuqpdwghCZ_TJJyt3Dm=xCBJLz3H0bbtabgToNV7V+A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzZfuqpdwghCZ_TJJyt3Dm=xCBJLz3H0bbtabgToNV7V+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 3:25 PM, Andrii Nakryiko wrote:
> On Fri, Jan 9, 2026 at 10:49 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> index 1c41d03bd5a1..503451875d33 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> @@ -1136,6 +1136,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
>>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
>>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux_prog);
>>
>> +__bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
>> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
>> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__prog);
>> +
>>  BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>>  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>>  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
>> @@ -1178,6 +1182,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_SLEEPABLE)
>>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
>>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
>>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
>> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
>> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
>> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
> 
> (irrelevant, now that I saw patch #8 discussion, but for the future
> the point will stand and we can decide how resolve_btfids handles this
> upfront)
> 
> I'm wondering, should we add KF_IMPLICIT_ARGS to legacy xxx_impl
> kfuncs as well to explicitly mark them to resolve_btfids as legacy
> implementations? And if we somehow find xxx_impl without it, then
> resolve_btfids complains louds and fails, this should never happen?

Eh... I don't like the idea of flagging both foo and foo_impl.

If we use the same flag for legacy funcs, the flag becomes
insufficient to determine whether a function is legacy or not: we also
have to check the name (or something). This could be a different flag,
but I don't like that either.

For legacy kfuncs that we want to support, I don't think we have to
enforce anything. We allow to use old API, and the new one if it's
implemented.

Are you suggesting to ban _impl suffix in names of new kfuncs?
Fail build on accidental name collision?

We could implement sanity checks like these as separate passes in
resolve_btfids, for example.

> 
> 
> 
>>  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>>
>>  static int bpf_testmod_ops_init(struct btf *btf)
>> @@ -1669,6 +1676,25 @@ int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux__prog
>>         return ret;
>>  }
>>
>> +int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
>> +{
>> +       if (aux && a > 0)
>> +               return a;
>> +       return -EINVAL;
>> +}
>> +
>> +int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux)
>> +{
>> +       if (aux)
>> +               return a + b;
>> +       return -EINVAL;
>> +}
>> +
>> +int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__prog)
>> +{
>> +       return bpf_kfunc_implicit_arg_legacy(a, b, aux__prog);
>> +}
>> +
>>  static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
>>  {
>>         struct bpf_testmod_multi_st_ops *st_ops =
>> --
>> 2.52.0
>>


