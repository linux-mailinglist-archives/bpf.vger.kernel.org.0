Return-Path: <bpf+bounces-59230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0CAC759C
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 04:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3EBA40DE0
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3C241C89;
	Thu, 29 May 2025 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nv4Q5jzJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB852417D9
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484204; cv=none; b=RQMC/vx4meCOV2zHkSUgDDmFIleSMoQDcUHDmisuA1RXT23Q0qvXc0VyIkmmHqWKvim9TD1q3XHAej8GkH+AFANzRpO9Vnedtq+ZHJSiXy8irMyBXc9KjOA2VwlAnsjV+NAWOISrHBIEzhJ+Yp4OSdrFciwCyjUUMvAoNQb/1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484204; c=relaxed/simple;
	bh=SWW7m2YS63jr9KQ5MhnGgWwWRqvPYINWGmx0VDbiqGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T95CNMTOTyaBbNXQBSpJMZIc6A3jPOdVqnaFBEN18r+I8rNa0+IX8eobXrNc9l40QkBh0CoFw45QqpW74FoZJaE3j6s2mxuAfp5JgDkq6DvTd4nRm6SJdHzekjlqztUeL6ieD6rV95myB4pRu1IDwy38GNemzHbpmy0itnnfufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nv4Q5jzJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ecd34ed3-cbe6-4370-ae89-1e1e382b6c34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748484200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cP6cAp56RYNKdwcwWl/Smp5+QwlQcWMVbp3z3P0vJ+Q=;
	b=Nv4Q5jzJ6Leyr1kZwpr6hPEWspoQxji10M1FpaW04v9coYP/DIPG9gAnBVRlz1V+FDMpcE
	tvNs0xcYltuqsh6oQWAhhMyHJAxLMuWfMbJyX171e/u/bHYX01mQj0a8ckK77P7sn4DCBf
	iiYF3dNh3jC+eODoGV0Ns6VQFPgwaPM=
Date: Thu, 29 May 2025 10:03:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Introduce global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250526162146.24429-1-leon.hwang@linux.dev>
 <20250526162146.24429-2-leon.hwang@linux.dev>
 <CAEf4BzZw_OgDWRzRsni5crcOs=9V3VT+c_Fz_gf2zCvx1wLzuA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZw_OgDWRzRsni5crcOs=9V3VT+c_Fz_gf2zCvx1wLzuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 28/5/25 06:31, Andrii Nakryiko wrote:
> On Mon, May 26, 2025 at 9:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces global percpu data, inspired by commit
>> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
>> definition of global percpu variables in BPF, similar to the
>> DEFINE_PER_CPU() macro in the kernel[0].
>>

[...]

>> +
>>         err = check_map_access(env, regno, reg->off,
>>                                map->value_size - reg->off, false,
>>                                ACCESS_HELPER);
>> @@ -11101,6 +11109,11 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
>>                 return -EINVAL;
>>         num_args = data_len_reg->var_off.value / 8;
>>
>> +       if (fmt_map->map_type != BPF_MAP_TYPE_ARRAY) {
>> +               verbose(env, "only array map supports snprintf\n");
>> +               return -EINVAL;
>> +       }
>> +
>>         /* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
>>          * and map_direct_value_addr is set.
>>          */
>> @@ -21906,6 +21919,38 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                         goto next_insn;
>>                 }
>>
>> +#ifdef CONFIG_SMP
> 
> Instead of CONFIG_SMP, I think it's more appropriate to check for
> bpf_jit_supports_percpu_insn(). We check CONFIG_SMP for
> BPF_FUNC_get_smp_processor_id inlining because of `cpu_number` per-CPU
> variable, not because BPF_MOV64_PERCPU_REG() doesn't work on single
> CPU systems (IIUC).
> 
Agreed.

Then, 'EMIT_mov(dst_reg, src_reg);' can be avoided if dst_reg is same as
src_reg while handling BPF_MOV64_PERCPU_REG() on x86_64.

Thanks,
Leon


