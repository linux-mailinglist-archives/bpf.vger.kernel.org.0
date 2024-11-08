Return-Path: <bpf+bounces-44398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0D9C271F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982EC1C22006
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC2A1E883E;
	Fri,  8 Nov 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nnmVtmf6"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCE1DF977
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102109; cv=none; b=WBDbxrpFouSiIt81KJTl906AR0ZhO0YNOoN0aQAUJe/rKArDPYNUNvAZDrFiMpKqv7ep6U4C2cqobK3xSWSwAmHxH1FhTm2zN9kC+f/LSUIX2WmJNcy7c0+aD9iBOD7mYukCBlvYv9H6vUHIAfsOlkTFVHar3+aAy8kErP3oFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102109; c=relaxed/simple;
	bh=Ey99CT+rrUo7TJH7takPl89q+fek4dnH6OIoVlA+yi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNTJ8h3QmoOgektKAEAcLkmbL9e1cB8WwavhSgTxGs2xSSlv8K8oRmNBj/jEDdUmYrwunGEkSxZdiOSiksSW/dNbrpMUxB3nURKb8SqAcuMA3KT+bPymQTDJQT4PzJ0PH6ehSa5tsZoYQyfFSDvFlg9RnEvfy6LZxZT957sTc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nnmVtmf6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1241234-4c52-4b11-ba4b-0a064b9a6874@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731102105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LvKFX6Feoo7ZOgbEd3O5J9Qfh5ZY4gUVAgMwZFNEws=;
	b=nnmVtmf6dcv7rxwyhavCWuJ1a5+ZXCETCjpcUeuwoS5Nc4xx7r63sPS0RIRhwEAaK3rE6y
	jHJNypyf9cIe6wWv5/Q4gbVJH3QnJdY5ykxFRbMhTgTS9Py60F4r0J2qV8rjPydKp/BK0U
	OdYNwuYwSTE+pKs/niEWRNSvdMN1+8g=
Date: Fri, 8 Nov 2024 13:41:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 2/7] bpf: Enable private stack for eligible
 subprogs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241107024138.3355687-1-yonghong.song@linux.dev>
 <20241107024149.3356316-1-yonghong.song@linux.dev>
 <CAADnVQ+Y0Gj-S43oh5MXm71e=qDdRhK7FcigctLGg2TD3n5GkA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+Y0Gj-S43oh5MXm71e=qDdRhK7FcigctLGg2TD3n5GkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/8/24 11:11 AM, Alexei Starovoitov wrote:
> On Wed, Nov 6, 2024 at 6:42 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2284b909b499..09bb9dc939d6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6278,6 +6278,10 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
>>                                  return ret;
>>                  }
>>          }
>> +
> and patch 6 adds this line here:
> + env->prog->aux->priv_stack_requested = false;
>
>> +       if (si[0].priv_stack_mode == PRIV_STACK_ADAPTIVE)
>> +               env->prog->aux->priv_stack_requested = true;
>> +
> which makes the above hard to reason about.
>
> I think the root of the problem is the dual meaning of
> the priv_stack_requested flag.
> On one side it's a way for sched-ext to ask bpf core to enable priv stack,
> and on the other side it's a request from bpf core to bpf jit
> to allocate it.

You are right. I use the same priv_stack_requested to do two things.

>
> I think it's better to split these two conditions.
> Extra bool is cheap.
>
> How about 'bool priv_stack_requested' will be used by sched-ext only
> and patch 6 largely stays as-is.
>
> While patch 1 drops the introduction of priv_stack_requested flag.
> Instead 'bool jits_use_priv_stack' is introduced in the patch 2
> and used by JITs to allocate priv stack.
>
> I know we use 'jit_requested' to tell JITs to jit it,
> so we can bike shed on alternative ways to name these two flags.

Two bool's approach sound good to me. As you mentioned, two bool's
are not expensive and can make logic cleaner. Will do in the next
revision.

>
>>          return 0;
>>   }
>>
>> @@ -20211,6 +20215,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>
>>                  func[i]->aux->name[0] = 'F';
>>                  func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
>> +               if (env->subprog_info[i].priv_stack_mode == PRIV_STACK_ADAPTIVE)
>> +                       func[i]->aux->priv_stack_requested = true;
>> +
>>                  func[i]->jit_requested = 1;
>>                  func[i]->blinding_requested = prog->blinding_requested;
>>                  func[i]->aux->kfunc_tab = prog->aux->kfunc_tab;
>> --
>> 2.43.5
>>


