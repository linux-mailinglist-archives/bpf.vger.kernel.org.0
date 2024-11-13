Return-Path: <bpf+bounces-44718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC29C6814
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 05:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0471F24600
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 04:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4800B15688C;
	Wed, 13 Nov 2024 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CUlyyXNo"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB91388
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472359; cv=none; b=OUywYyE4zPCFJX0xRfc6NKIZX+B5pvqZW4eZSgDlNv+XrqATgsuX0uMCi7QN6cUDlxA6NOlhd0UCaBxdjunnAgotHIIvCl9HEiWFC0zOjwnXZLN7onv1Y4W5mucMhZKDe9n0RvbxfkWvaaMeAMpZm9jS+WTSyieb+KpWnvZL9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472359; c=relaxed/simple;
	bh=haRrDsJ2aUtJWtMOxmMasdOLu2DaInUijUDQk48Kc0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4tFBlg06PtOD1eiCa5KqxV4X1O0/mtS3tHUFT+vL4E3v+cXRL0drmNBAaSCfzbgUXd5je6J/Vg/SyCrlrwGDk4nb2kduIAKdii4fRQI2ctXszk19I1PPMa4v50z67BcJgi0CHdn8GCQSJvVgP4kShV/Q0NCOxAOjF+H7rs7Dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CUlyyXNo; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94e85972-ec2f-4231-bf0a-fcdda0ebde57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731472354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVjFpZOzvpDYD92WuPEcFMkP4peps0TrT1iwKMSrYAE=;
	b=CUlyyXNo10mgVLESGxHCN9cjIgiLQRrM49XKRdBQJxP75lmhpBNwXVgHH5rM2LlNT6wB5N
	Hp54VRvV8CrpTdAr4pT7UVM8Nv1PDSTLTPnV0C4mH8L0oHBgzjpM+I5+8ctJ8CwNDT3dNq
	SIc0L6e7zIq5MqJ4tFh4FHQ+wGZ5Vpc=
Date: Tue, 12 Nov 2024 20:32:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v12 4/7] bpf, x86: Support private stack in jit
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241112163902.2223011-1-yonghong.song@linux.dev>
 <20241112163922.2224385-1-yonghong.song@linux.dev>
 <CAADnVQJ0Hzfn8rUtOPCUy+qFjMMQiyPFpLRr6fN+8gRzh9wsPw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ0Hzfn8rUtOPCUy+qFjMMQiyPFpLRr6fN+8gRzh9wsPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/12/24 5:13 PM, Alexei Starovoitov wrote:
> On Tue, Nov 12, 2024 at 8:41 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +
>> +static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
>> +                                  struct bpf_prog *prog)
>> +{
>> +       int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
>> +       u64 *stack_ptr;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
>> +               if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
>> +                   stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL) {
>> +                       pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
>> +                              bpf_get_prog_name(prog));
>> +                       break;
>> +               }
>> +       }
>> +}
> I was tempted to change pr_err() to WARN() to make sure this kinda bug
> is very obvious, but left it as-is.
> I think kasan-ing JITed load/stores and adding poison to guards
> will be a bigger win.
> The bpf prog/verifier bug will be spotted right away instead of
> later during jit_free.

Agree. I will work on this as a follow-up.


