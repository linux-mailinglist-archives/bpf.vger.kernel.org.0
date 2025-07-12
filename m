Return-Path: <bpf+bounces-63106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D9B0286C
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 02:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582941C42D69
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4CA30100;
	Sat, 12 Jul 2025 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KauNLz1l"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B716FC3
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281263; cv=none; b=XIJIDSb0hfG0TFH6iD6FKByTN3PQMuFgEx9UWGUYHZXFvBuvJMz5fEdwWNPqKTLsIkN7hn5HXwvvyOfhsqOeJ/qQWn/ZVN/siWEyIP5F5nOoW/iURAypZf4GoCLPbdu0bAwWM4uvtPi88oa/RjDKm5djYBFmPj6QtbOiJbQFpEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281263; c=relaxed/simple;
	bh=4z8qKSie1tm+l06Jf71oabOm48RQTnCJnJG0w6XFgQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc0+ZbefIpPXOWaa96AR5/IN3tCyGmz4kjp2D7wLhYNFFtvuR/ys41RrxeD9Bw+gUMCKN7Qc0cE+e6zjtW688mlVK/WCWhagP2Jsba+x2xZdO84AM65+D+LQqmsMFne+kGpIZGmtdNRHK1x+YWV7Us/Yoi5uN9xmQgMikU0wgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KauNLz1l; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <67b36ef6-fd2e-49a8-b5bd-ebcf69e12f22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752281257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqFdZCLEufsw1LPP9hfNAls1+06R7qgUjD6x+ag7IL0=;
	b=KauNLz1lWnJD/7gXcNK+WrR6vCHLHDcDbaAbNsJ5TlPIuCRdi60gk4QmYhJ0ozkx9KiyJL
	OeEj+W9dryFvs9WEzHEYD/8/z7/OMpAHg3JOBI4QuiprxlYGQP7yIitWu31tcBKrnyKjti
	gyC+3KJ29VrZr9xQfEqv6H0abWJzq2U=
Date: Fri, 11 Jul 2025 17:47:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Content-Language: en-GB
To: chenyuan <chenyuan_fl@163.com>
Cc: ast@kernel.org, qmo@qmon.net, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>
References: <20250626061158.29702-1-chenyuan_fl@163.com>
 <20250626074930.81813-1-chenyuan_fl@163.com>
 <21fbb0ba-25bc-4457-9f12-b5a8f6988e4c@linux.dev>
 <172453cd.68e1.197f84fac7c.Coremail.chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <172453cd.68e1.197f84fac7c.Coremail.chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/11/25 12:07 AM, chenyuan wrote:
> Thank you for your feedback! Does ARM64 require similar address adjustment detection? In my ARM64
>   environment with BTI enabled, bpftool correctly retrieves and prints function symbols. Could my verification
>   method be flawed?
> Here’s a detailed explanation:
>
> ARM64 BTI vs. x86 CET: Fundamental Differences
>
>      x86 CET (Control-flow Enforcement Technology):
>          Requires endbr32/endbr64 at function entries. Overwriting these instructions breaks CET protection .
>          Kernel logic (e.g., bpf_trace.c) adjusts symbol addresses by -4 to skip the endbr prefix .

This interpretation is not correct. The adjustment by -4 is not to skip the endbr prefix,
but to get the actual symbol address. For example,

ffffffff83809cb0 <bpf_fentry_test3>:
ffffffff83809cb0: f3 0f 1e fa           endbr64
ffffffff83809cb4: 0f 1f 44 00 00        nopl    (%rax,%rax)
ffffffff83809cb9: 8d 04 37              leal    (%rdi,%rsi), %eax
ffffffff83809cbc: 01 d0                 addl    %edx, %eax
ffffffff83809cbe: 2e e9 6c d3 c8 00     jmp     0xffffffff84497030 <__x86_return_thunk>
ffffffff83809cc4: 66 66 66 2e 0f 1f 84 00 00 00 00 00   nopw    %cs:(%rax,%rax)

The fentry_ip argument in func get_entry_ip() is 0xffffffff83809cb4. Adding -4
will get the value 0xffffffff83809cb0 which is the actual start of the function.

>      ARM64 BTI (Branch Target Identification):
>          Uses BTI instructions as "landing pads" for indirect jumps. Kprobes can safely overwrite BTI instructions without triggering faults because:
>              Executing BTI, SG, or PACBTI clears EPSR.B (the enforcement flag), allowing subsequent non-BTI instructions .
>              Non-landing-pad instructions (e.g., probes) only fault if executed before EPSR.B is cleared – which doesn’t occur when probes replace BTI .

I am not super familiar with arm64 bti. But from an arm64 kernel, with my config file (based on bpf CI),
I didn't find bti insns for tracable functions. So I double arm64 kernel will need address adjustment.
Otherwise, get_entry_ip() should do adjustment there.

It would be great if you can have an example to show arm64 also needs addr adjustment in bpftool
as in this patch.

>
> https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/armv8-1-m-pointer-authentication-and-branch-target-identification-extension
>
>
>
>
>
>
>
>
>
> At 2025-07-01 10:31:41, "Yonghong Song" <yonghong.song@linux.dev> wrote:
>>
>> On 6/26/25 12:49 AM, Yuan Chen wrote:
>>> From: Yuan Chen <chenyuan@kylinos.cn>
>>>
>>> Adjust symbol matching logic to account for Control-flow Enforcement
>>> Technology (CET) on x86_64 systems. CET prefixes functions with a 4-byte
>>> 'endbr' instruction, shifting the actual entry point to symbol + 4.
>>>
>>> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
>>> ---
>>>    tools/bpf/bpftool/link.c | 30 ++++++++++++++++++++++++++++--
>>>    1 file changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>>> index 03513ffffb79..dfd192b4c5ad 100644
>>> --- a/tools/bpf/bpftool/link.c
>>> +++ b/tools/bpf/bpftool/link.c
>>> @@ -307,8 +307,21 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>>>    		goto error;
>>>    
>>>    	for (i = 0; i < dd.sym_count; i++) {
>>> -		if (dd.sym_mapping[i].address != data[j].addr)
>>> +		if (dd.sym_mapping[i].address != data[j].addr) {
>>> +#if defined(__x86_64__) || defined(__amd64__)
>>> +			/*
>>> +			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
>>> +			 * function entry points have a 4-byte 'endbr' instruction prefix.
>>> +			 * This causes the actual function address = symbol address + 4.
>>> +			 * Here we check if this symbol matches the target address minus 4,
>>> +			 * indicating we've found a CET-enabled function entry point.
>>> +			 */
>>> +			if (dd.sym_mapping[i].address == data[j].addr - 4)
>>> +				goto found;
>>> +#endif
>> In kernel/trace/bpf_trace.c, I see
>>
>> static inline unsigned long get_entry_ip(unsigned long fentry_ip)
>> {
>> #ifdef CONFIG_X86_KERNEL_IBT
>>          if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
>>                  fentry_ip -= ENDBR_INSN_SIZE;
>> #endif
>>          return fentry_ip;
>> }
>>
>> Could you explain why arm64 also need to do checking
>>      if (dd.sym_mapping[i].address == data[j].addr - 4)
>> like x86_64?
>>
>>>    			continue;
>>> +		}
>>> +found:
>>>    		jsonw_start_object(json_wtr);
>>>    		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
>>>    		jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].name);
>>> @@ -744,8 +757,21 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>>>    
>>>    	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
>>>    	for (i = 0; i < dd.sym_count; i++) {
>>> -		if (dd.sym_mapping[i].address != data[j].addr)
>>> +		if (dd.sym_mapping[i].address != data[j].addr) {
>>> +#if defined(__x86_64__) || defined(__amd64__)
>>> +			/*
>>> +			 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
>>> +			 * function entry points have a 4-byte 'endbr' instruction prefix.
>>> +			 * This causes the actual function address = symbol address + 4.
>>> +			 * Here we check if this symbol matches the target address minus 4,
>>> +			 * indicating we've found a CET-enabled function entry point.
>>> +			 */
>>> +			if (dd.sym_mapping[i].address == data[j].addr - 4)
>>> +				goto found;
>>> +#endif
>>>    			continue;
>>> +		}
>>> +found:
>>>    		printf("\n\t%016lx %-16llx %s",
>>>    		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
>>>    		if (dd.sym_mapping[i].module[0] != '\0')


