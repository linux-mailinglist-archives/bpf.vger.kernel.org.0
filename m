Return-Path: <bpf+bounces-19013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A780823C6E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 08:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4F22883BA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E24F1DA27;
	Thu,  4 Jan 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iW4ovoMX"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E81DFE7
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1db29e2f-907f-40e9-8039-ba0c6cef92c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704351717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8EEZ2DFYDK7qmxbKLgirUvXvI+qRgIhNSOwV7Zq39Q=;
	b=iW4ovoMXEUYUYi7/ksLwvpDAMAIRoQ7dGpUzw0jbCLacMn1aektuatGLkezGbAeAaxvxD8
	os4E/2uSh0tmm3S4Fqb3zsTmEoQvV/0OXrnKCtN+GiW/Pf7YBKri0A9qSaLD1XlAXd6nQ+
	sC+KC4kGAbO3xxvFEf88Gwo9S2QIp6M=
Date: Wed, 3 Jan 2024 23:01:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/8] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231222031729.1287957-1-yonghong.song@linux.dev>
 <20231222031745.1289082-1-yonghong.song@linux.dev>
 <CAADnVQJTFo0tgZRhgv7k28zNAvgnqjWaLvNNhcy+oiqdfvTvpw@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJTFo0tgZRhgv7k28zNAvgnqjWaLvNNhcy+oiqdfvTvpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/3/24 9:21 PM, Alexei Starovoitov wrote:
> On Thu, Dec 21, 2023 at 7:18 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Later on, Commit 1fda5bb66ad8 ("bpf: Do not allocate percpu memory
>> at init stage") moved the non-fix-size percpu memory allocation
>> to bpf verificaiton stage.
> Only noticed after already applying and didn't want to force push
> to fix it up.
> But in the future please do not break commit one-liner into
> multiple lines. Commit should be lower case as well.

Sorry about the format issue. Will pay attention to this next time
and as you suggested, will run spellcheck as well.

>
> spellcheck is a good idea as well.
>
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               cc = per_cpu_ptr(pcc, cpu);
>> +               c = &cc->cache[i];
>> +               if (cpu == 0 && c->unit_size)
>> +                       break;
> I think this part ensures that repeated
> bpf_percpu_obj_new() in a bpf prog don't keep prefilling,
> right?
> I think it works, but cpu == 0 part is confusing.
> It will work with just: if (c->unit_size) break;
> right?

You are right. cpu == 0 is a leftover from one of
previous revisions and should be removed. Will send
a followup to remove it.

>
>> +
>> +               c->unit_size = unit_size;
>> +               c->objcg = objcg;
>> +               c->percpu_size = percpu_size;
>> +               c->tgt = c;
>> +
>> +               init_refill_work(c);
>> +               prefill_mem_cache(c, cpu);
>> +       }
>> +
>> +       return 0;
>> +}

