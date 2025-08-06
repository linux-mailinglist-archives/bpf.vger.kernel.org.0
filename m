Return-Path: <bpf+bounces-65145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E991DB1CB16
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D286168AFA
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A229B204;
	Wed,  6 Aug 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M0EpK8Vv"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EB299952
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501878; cv=none; b=sy3YwhD5aWhBKjS4XmQ3DXAavHdBspU140c6kXUuSZ7lb0cDvDYFcs8qjlRcfTJI8khggRZGp1USnxnNC85qNP5WRcYC9NEAD5s2L8uuuRQmUnwaK4RTIkFgTD48QwNHUhMJwhza96yBjMUKotxna5yZUd0TYWBQjOdxfgiQTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501878; c=relaxed/simple;
	bh=BGlX4F9TBCHgFRucEjmJBusZHbT1xWjudfuQYsuta5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6uTGirfAcUlyRWckvnVVpgyc7IqXaLXQBi2B+y+o1hryTJnD9UoyX/TfvLWUiv6PcaFVZ8+CL+h745SLaTiO51mQOuILzwnhNZRlLSQKMF8Rm3QLYZfFiiy9sQhYSF+Wb6z+9zA7V5K60w7pcRV4IxVpIgkYfmX9dC3QdHJChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M0EpK8Vv; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b96d710-8e21-4d32-9229-30bc99dfb4f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754501874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpaIec0lLYYHJNdH90u7GIDmuDoXJeli/3yE7bAIPLA=;
	b=M0EpK8Vv2vUInyGaHvRGVAJawNEBO6XPrKkhtL0YCoO+EnafCR9kCJteb3TiMnf/XIhdtM
	HuffmvN2rB4C9gmHXiPms0RgY4kZIcZ/6B3ywv2fv7F3NBfLou6ofl7yIYhm6mvQvYXAH/
	RyWPqu9q93ZuPfGSotatdNg7b0WVvAU=
Date: Wed, 6 Aug 2025 10:37:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/1] bpf: Allow fall back to interpreter for
 programs with stack size <= 512
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mrpre@163.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
References: <20250805115513.4018532-1-kafai.wan@linux.dev>
 <401418b7-248c-42a3-ba74-9b2b2959e36c@linux.dev>
 <c8c870e25c07aee5c84c84aa62cebd655ff53f50.camel@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c8c870e25c07aee5c84c84aa62cebd655ff53f50.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 3:57 AM, KaFai Wan wrote:
> On Tue, 2025-08-05 at 10:45 -0700, Yonghong Song wrote:
>>
>> On 8/5/25 4:55 AM, KaFai Wan wrote:
>>> OpenWRT users reported regression on ARMv6 devices after updating
>>> to latest
>>> HEAD, where tcpdump filter:
>>>
>>> tcpdump -i mon1 \
>>> "not wlan addr3 3c37121a2b3c and not wlan addr2 184ecbca2a3a \
>>> and not wlan addr2 14130b4d3f47 and not wlan addr2 f0f61cf440b7 \
>>> and not wlan addr3 a84b4dedf471 and not wlan addr3 d022be17e1d7 \
>>> and not wlan addr3 5c497967208b and not wlan addr2 706655784d5b"
>>>
>>> fails with warning: "Kernel filter failed: No error information"
>>> when using config:
>>>    # CONFIG_BPF_JIT_ALWAYS_ON is not set
>>>    CONFIG_BPF_JIT_DEFAULT_ON=y
>>>
>>> The issue arises because commits:
>>> 1. "bpf: Fix array bounds error with may_goto" changed default
>>> runtime to
>>>      __bpf_prog_ret0_warn when jit_requested = 1
>>> 2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error
>>> when
>>>      jit_requested = 1 but jit fails
>>>
>>> This change restores interpreter fallback capability for BPF
>>> programs with
>>> stack size <= 512 bytes when jit fails.
>>>
>>> Reported-by: Felix Fietkau <nbd@nbd.name>
>>> Closes:
>>> https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name/
>>> Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
>>> Fixes: 86bc9c742426 ("bpf: Avoid __bpf_prog_ret0_warn when jit
>>> fails")
>>> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
>>> ---
>>>    kernel/bpf/core.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 5d1650af899d..2d86bd4b0b97 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -2366,8 +2366,8 @@ static unsigned int
>>> __bpf_prog_ret0_warn(const void *ctx,
>>>    					 const struct bpf_insn
>>> *insn)
>>>    {
>>>    	/* If this handler ever gets executed, then
>>> BPF_JIT_ALWAYS_ON
>>> -	 * is not working properly, or interpreter is being used
>>> when
>>> -	 * prog->jit_requested is not 0, so warn about it!
>>> +	 * or may_goto may cause stack size > 512 is not working
>>> properly,
>>> +	 * so warn about it!
>>>    	 */
>>>    	WARN_ON_ONCE(1);
>>>    	return 0;
>>> @@ -2478,10 +2478,10 @@ static void bpf_prog_select_func(struct
>>> bpf_prog *fp)
>>>    	 * But for non-JITed programs, we don't need bpf_func, so
>>> no bounds
>>>    	 * check needed.
>>>    	 */
>>> -	if (!fp->jit_requested &&
>>> -	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
>>> +	if (idx < ARRAY_SIZE(interpreters)) {
>>>    		fp->bpf_func = interpreters[idx];
>>>    	} else {
>>> +		WARN_ON_ONCE(!fp->jit_requested);
>>>    		fp->bpf_func = __bpf_prog_ret0_warn;
>>>    	}
>> Your logic here is to do interpreter even if fp->jit_requested is
>> true.
>> This is different from the current implementation.
>>
>> Also see below code:
>>
>> static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>>                                            const struct bpf_insn
>> *insn)
>> {
>>           /* If this handler ever gets executed, then
>> BPF_JIT_ALWAYS_ON
>>            * is not working properly, or interpreter is being used
>> when
>>            * prog->jit_requested is not 0, so warn about it!
>>            */
>>           WARN_ON_ONCE(1);
>>           return 0;
>> }
>>
>>
>> It mentions to warn if the interpreter is being used when
>> prog->jit_requested is not 0.
>>
>> So if prog->jit_requested is not 0, it is expected not to use
>> interpreter.
>>
> The commit 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
> [1] this patch fix change the code to that, before this commit it was:
>
> static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> 					 const struct bpf_insn *insn)
> {
> 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
> 	 * is not working properly, so warn about it!
> 	 */
> 	WARN_ON_ONCE(1);
> 	return 0;
> }
>
> And
>
> static void bpf_prog_select_func(struct bpf_prog *fp)
> {
> #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
>
> 	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) -
> 1];
> #else
> 	fp->bpf_func = __bpf_prog_ret0_warn;
> #endif
> }
>
> so it can fall back to the interpreter when jit fails. And this fit the
> intent of bpf_prog_select_runtime(), see comment:
>
> /**
>   *	bpf_prog_select_runtime - select exec runtime for BPF program
>   *	@fp: bpf_prog populated with BPF program
>   *	@err: pointer to error variable
>   *
>   * Try to JIT eBPF program, if JIT is not available, use interpreter.
>   * The BPF program will be executed via bpf_prog_run() function.
>   *
>   * Return: the &fp argument along with &err set to 0 for success or
>   * a negative errno code on failure
>   */
> struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>
>
> And this:
>
> 	bpf_prog_select_func(fp);
>
> 	/* eBPF JITs can rewrite the program in case constant
> 	 * blinding is active. However, in case of error during
> 	 * blinding, bpf_int_jit_compile() must always return a
> 	 * valid program, which in this case would simply not
> 	 * be JITed, but falls back to the interpreter.
> 	 */
> 	if (!bpf_prog_is_offloaded(fp->aux)) {
>
>
> The commit [1] mismatch the intent of bpf_prog_select_runtime(), so it
> should be fixed.
>
>
> [1] https://lore.kernel.org/all/20250214091823.46042-2-mrpre@163.com/

Okay, indeed the above [1] changed the behavior. Maybe Alexei can
comment whether we should restore to the behavior before [1].

>
>>>    #else
>>> @@ -2505,7 +2505,7 @@ struct bpf_prog
>>> *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>>    	/* In case of BPF to BPF calls, verifier did all the prep
>>>    	 * work with regards to JITing, etc.
>>>    	 */
>>> -	bool jit_needed = fp->jit_requested;
>>> +	bool jit_needed = false;
>>>    
>>>    	if (fp->bpf_func)
>>>    		goto finalize;
>>> @@ -2515,6 +2515,8 @@ struct bpf_prog
>>> *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>>>    		jit_needed = true;
>>>    
>>>    	bpf_prog_select_func(fp);
>>> +	if (fp->bpf_func == __bpf_prog_ret0_warn)
>>> +		jit_needed = true;
>>>    
>>>    	/* eBPF JITs can rewrite the program in case constant
>>>    	 * blinding is active. However, in case of error during


