Return-Path: <bpf+bounces-41710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DACB999B8C
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 06:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00417B220AA
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CA1F4FD3;
	Fri, 11 Oct 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6nzphSq"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D151EF0A0
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619952; cv=none; b=IJ0ulty1vdB9Dj6pS/9+HNCGeRbJmROzBtesB8E4K3LvRBWBpjjYzvhMJ04D6SF+2KKvrybVjJrWc4dgzre4JSkA+vhOsOWgQ2ObT72MMe57285ELNtmGDkVA33kPsMkBJvXlCxFR/b6bp70Dg+Ypxu4Y4mBQLXXf35ndfypY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619952; c=relaxed/simple;
	bh=14CcennGgO/IJGADMy3F5gkS/ruXbVC5fBtQrsondt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsZn+vWUxdqmqe1r4L9O7eT6GW42HfDcINnZ3QMKbIoFkjbxPCQsI3EzpsGvLMJ8bqcRqFl5tc8vkRdf2/K7CufPoAlfFmtxICnGWMMOAq7kVLzk6lwh2jTas6QCzW+k4IXLhBJEsqRG3kje/FRBps/5y0KG/t8aKopNJBVivTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6nzphSq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96556ec2-f98c-444b-b0aa-ddf71e185c7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728619948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bln8v0F0Su98u5HTC8xUuNSD+4RlaXVVpAfeE/Lw4Bw=;
	b=j6nzphSqKDM3j2ct+m1Is45qxkJ+ISQVzdvzlrGMcUNuxG8f+vXj2DunT/hnG58yOhI90C
	BnMzt0KBdpCgy3byrQIOHZvJk8BypvStzjeFya6IbAUfrj46JiGH6T4EljiwUvUn5TZIqg
	A0ivTidCwRR0HLmY5WpZcfFaWQr/lvY=
Date: Thu, 10 Oct 2024 21:12:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 07/10] bpf: Support calling non-tailcall bpf
 prog
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175628.1898648-1-yonghong.song@linux.dev>
 <CAADnVQJMuR_riNLghmr0ohrEZSj-8ngcFQRn3VkdDyJAFakqKQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJMuR_riNLghmr0ohrEZSj-8ngcFQRn3VkdDyJAFakqKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/10/24 1:28 PM, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 10:56 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> A kfunc bpf_prog_call() is introduced such that it can call another bpf
>> prog within a bpf prog. It has the same parameters as bpf_tail_call()
>> but acts like a normal function call.
>>
>> But bpf_prog_call() could recurse to the caller prog itself. So if a bpf
>> prog calls bpf_prog_call(), that bpf prog will use private stacks with
>> maximum recursion level 4. The 4 level recursion should work for most
>> cases.
>>
>> bpf_prog_call() cannot be used if tail_call exists in the same prog
>> since tail_call does not use private stack. If both prog_call and
>> tail_call in the same prog, verification will fail.
> ..
>
>> +__bpf_kfunc int bpf_prog_call(void *ctx, struct bpf_map *p__map, u32 index)
>> +{
>> +       struct bpf_array *array;
>> +       struct bpf_prog *prog;
>> +
>> +       if (p__map->map_type != BPF_MAP_TYPE_PROG_ARRAY)
>> +               return -EINVAL;
>> +
>> +       array = container_of(p__map, struct bpf_array, map);
>> +       if (unlikely(index >= array->map.max_entries))
>> +               return -E2BIG;
>> +
>> +       prog = READ_ONCE(array->ptrs[index]);
>> +       if (!prog)
>> +               return -ENOENT;
>> +
>> +       return bpf_prog_run(prog, ctx);
>> +}
> bpf_tail_call() was a hack during the early days,
> since I didn't know any better :(
> I really don't want to use that as a pattern.
> prog life time rules, tail call cnt, prog_array_compatible, etc.
> caused plenty of pain. Don't want to see a repeat.
>
> Progs that need to call another prog can use freplace mechanism already.
> There is no need for bpf_prog_call.

In this case, it could call itself.

>
> Let's get priv_stack in shape first (the first ~6 patches).

I am okay to focus on the first 6 patches. But I would like to get
Tejun's comments about what is the best way to support hierarchical
bpf based scheduler.

>
> pw-bot: cr

