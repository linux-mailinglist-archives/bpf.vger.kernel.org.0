Return-Path: <bpf+bounces-69756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A045BA0EE7
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE54A129E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93792E6CD2;
	Thu, 25 Sep 2025 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n39f1Ke3"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9222B8AB
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822357; cv=none; b=UeFYCaYk7bi1Pe4Ee72GLXfzo+Zps53z9b2lFBK2kj9/l6ktMbuGMJNx/+t8nD7qzG5bSblvFKHFD2aXHIGvrKqjNNRzlSp4XxRjkEnMbMEBDppLW+xjWwZCmxpij410uhxWb6CWK7rnuNAIlmB2Owu/6/7rHAPMtdckyfpY9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822357; c=relaxed/simple;
	bh=cyKhDezdYWwGbQB43lnNusq2qtiII1uVfZrv+wRg5vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhBbxNYPUxIxA6pxJXPrfDhGKDLSvSKsqnIynhYPSbyBr6o6o3prUfKF47VL+FxYprk0WOs2vG/bqv/+R39QRe/Q4JMxmIFzY7rpeYc6p3JiNVIWPSqJpnxVRLd6wOWtjC3O9XFnweqXoD9H1Fm24J1aBFLdBtOhKUxayX8/pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n39f1Ke3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <310091f8-ee17-4dfc-bbb4-1bb262cbfd98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758822343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uuxu7hZwOaKDVqdhli7Mdbk2jg5kVbusifSuE5+jNMY=;
	b=n39f1Ke34lHYFK4IXMv9SUO4R1MZtlV1QKmZylX0YOcFHATqUpwfmu1sZQy826VRJz4CMz
	pqxliQbAond7RRsG0yx8bO8DJajAOyE6Uc2dV1XJymGX1vY9mDcA1S3INTQ3ojbmdqgYfE
	aUD10sBpS5DZBvEC224B037rqToz2t8=
Date: Fri, 26 Sep 2025 01:45:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add preempt_disable to protect
 get_perf_callchain
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250922075333.1452803-1-chen.dylane@linux.dev>
 <CAADnVQKtOCXdv-LJ-T6K_meAS26C_i4Yc0hOpYS46umsPmuQAQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQKtOCXdv-LJ-T6K_meAS26C_i4Yc0hOpYS46umsPmuQAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/23 10:53, Alexei Starovoitov 写道:
> On Mon, Sep 22, 2025 at 12:54 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> As Alexei suggested, the return value from get_perf_callchain() may be
>> reused if another task preempts and requests the stack after BPF program
>> switched to migrate disable.
>>
>> Reported-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 2e182a3ac4c..07892320906 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -314,8 +314,10 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>          if (max_depth > sysctl_perf_event_max_stack)
>>                  max_depth = sysctl_perf_event_max_stack;
>>
>> +       preempt_disable();
>>          trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
>>                                     false, false);
>> +       preempt_enable();
> 
> This is obviously wrong.
> As soon as preemption is enabled, trace can be overwritten.
> guard(preempt)();
> can fix it, but the length of the preempt disabled section
> will be quite big.
> The way get_perf_callchain() api is written I don't see
> another option though. Unless we refactor it similar
> to bpf_try_get_buffers().
> 
> pw-bot: cr

Hi Alexei,

I tried to understand what you meant and looked at the implementation of 
get_perf_callchain.

Only one perf_callchain_entry on every cpu right now.

callchain_cpus_entries(rcu global avariable)
     ↓
struct callchain_cpus_entries {
	struct perf_callchain_entry     *cpu_entries[];
			|
}                       ｜-> perf_callchain_entry0    cpu0
			     perf_callchain_entry1     cpu1
                              …
                              perf_callchain_entryn     cpun


If we want to realise it like bpf_try_get_buffers, we should
alloc a perf_callchain_entry array on every cpu right?

callchain_cpus_entries(rcu global avariable)
     ↓
struct callchain_cpus_entries {
	struct perf_callchain_entry     *cpu_entries[];
			|
}                       ｜-> perf_callchain_entry0[N]    cpu0
			     perf_callchain_entry1[N]     cpu1
                              …
                              perf_callchain_entryn[N]     cpun

-- 
Best Regards
Tao Chen

