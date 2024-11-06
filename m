Return-Path: <bpf+bounces-44110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4A9BDF07
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 07:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD36CB234AC
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CA1925A4;
	Wed,  6 Nov 2024 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kV23DpzR"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED90190685
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876130; cv=none; b=uJZ6pwmmEfLNBCpPqPOrls1pr3Gvx31YM1Z7kMPWJSRRvqy5+dcHCM141RfMjo3kBOd1sFTPJb8rVyW3INXJFc5KkXgJCfVxnb+4/cpvN/0L+qwCqH641PKF4badsKaUsd62ZYvbSJ0UAPXRJxWtljuPtXuj936ZARiWz8uH91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876130; c=relaxed/simple;
	bh=i0TThHLV1u3ZJ0W4l+KAF7nW8w708vok3ErEiUReODo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5Wpz3fgDf77z3DAMFrjDVSjg3iamvsqcpeG068+5EsPlUb96SzU3eojgQFcRdTTzA5YLa7xSjfyT5gbPj1qgaxV5UeIv5dEtIrIVpC3Z8NtWiiwRUbucNCsrYsTV4zo0kpoxMGD6t8Sa1HyG/O+bDhX7BgTJwcCfMCSQhd6OLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kV23DpzR; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97aa51b0-5c12-4f5b-bd35-5abfcee9a715@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730876121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdfMFKKXfaqKPwu1de7BEtas78J6VxbHzfJM+ZqVWrw=;
	b=kV23DpzRFblx0jiD7plSHsxX5lkvyHrjLgXPnantu1njbCTuBJGcD1a7sbeXGRrWQew7L3
	f2ddBAluXZV9sCe8tBiHfat8JF0o3nteLpyDS8SOPhwa/SVsn+l8Ah6LFDRr9bDaH2DFz0
	S6uRvwPmpvzBD0xnWM72V7peX7JLjA4=
Date: Tue, 5 Nov 2024 22:55:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev>
 <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev>
 <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
 <c00685dc-c51b-4058-8373-93b01443143d@linux.dev>
 <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
 <a95f0953-1901-471f-8313-dac03efef9e2@linux.dev>
 <CAADnVQ+ohxtXEc8WufQoJQByRFMSD9427X_dsKWQFBv9dGzveA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+ohxtXEc8WufQoJQByRFMSD9427X_dsKWQFBv9dGzveA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/5/24 5:07 PM, Alexei Starovoitov wrote:
> On Tue, Nov 5, 2024 at 4:19 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>>
>> On 11/5/24 1:52 PM, Alexei Starovoitov wrote:
>>> On Tue, Nov 5, 2024 at 1:26 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>> I see. I think it works, but feels complicated.
>>>>> It feels it should be possible to do without extra flags. Like
>>>>> check_max_stack_depth_subprog() will know whether it was called
>>>>> to verify async_cb or not.
>>>>> So it's just a matter of adding single 'if' to it:
>>>>> if (subprog[idx].use_priv_stack && checking_async_cb)
>>>>>       /* reset to false due to potential recursion */
>>>>>       subprog[idx].use_priv_stack = false;
>>>>>
>>>>> check_max_stack_depth() starts with i==0,
>>>>> so reachable and eligible subprogs will be marked with use_priv_stack.
>>>>> Then check_max_stack_depth_subprog() will be called again
>>>>> to verify async. If it sees the mark it's a bad case.
>>>>> what am I missing?
>>>> First I think we still want to mark some subprogs in async tree
>>>> to use private stack, right? If this is the case, then let us see
>>>> the following examle:
>>>>
>>>> main_prog:
>>>>       sub1: use_priv_stack = true
>>>>       sub2" use_priv_stack = true
>>>>
>>>> async: /* calling sub1 twice */
>>>>       sub1
>>>>         <=== we do
>>>>                if (subprog[idx].use_priv_stack && checking_async_cb)
>>>>                    subprog[idx].use_priv_stack = false;
>>>>       sub1
>>>>         <=== here we have subprog[idx].use_priv_stack = false;
>>>>              we could mark use_priv_stack = true again here
>>>>              since logic didn't keep track of sub1 has been
>>>>              visited before.
>>> This case needs a sticky state to solve.
>>> Instead of bool use_priv_stack it can be tri-state:
>>> no_priv_stack
>>> priv_stack_unknown <- start state
>>> priv_stack_maybe
>>>
>>> main_prog pass will set it to priv_stack_maybe
>>> while async pass will clear it to no_priv_stack
>>> and it cannot be bumped up.
>> The tri-state may not work. For example,
>>
>> main_prog:
>>      call sub1
>>      call sub2
>>      call sub1
> sub1 cannot be called nested like this.
> I think we discussed it already.
>
>>      call sub3
>>
>> async:
>>      call sub4 ==> UNKNOWN -> MAYBE
>>      call sub3
>>      call sub4 ==> MAYBE -> NO_PRIV_STACK?
>>
>> For sub4 in async which is called twice, for the second sub4 call,
>> it is not clear whether UNKNOWN->MAYBE transition happens in
>> main_prog or async. So based on transition prototol,
>> second sub4 call will transition to NO_PRIV_STACK which is not
>> what we want.
> I see. Good point.
>
>> So I think we still need a separate bit in bpf_subprog_info to
>> accumulate information for main_prog tree or any async tree.
> This is getting quite convoluted. To support priv stack
> in multiple async cb-s we may need to remember async cb id or something.
> I say let's force all subprogs in async cb to use normal stack.

I did a quick prototype. Among others, tri-state (UNKNOWN, NO, ADAPTIVE) 
and reverse traversing subprogs like below diff --git 
a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index 
cb82254484ff..1084432dbe83 100644 --- a/kernel/bpf/verifier.c +++ 
b/kernel/bpf/verifier.c @@ -6192,7 +6192,7 @@ static int 
check_max_stack_depth(struct bpf_verifier_env *env) struct 
bpf_subprog_info *si = env->subprog_info; int ret; - for (int i = 0; i < 
env->subprog_cnt; i++) { + for (int i = env->subprog_cnt - 1; i >= 0; 
i--) { if (i && !si[i].is_async_cb) continue; works correctly. 
Basically, all async_cb touched subprogs are marked as 'NO'. Finally for 
main prog tree, UNKNOWN subprog will convert to ADAPTIVE if >= stack 
size threshold. Stack size checking can also be done properly for 
async_cb tree and main prog tree.


